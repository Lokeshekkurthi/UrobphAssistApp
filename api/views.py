import os
from django.conf import settings
from rest_framework import viewsets, status, generics, permissions
from rest_framework.decorators import api_view, permission_classes
from rest_framework.response import Response
from rest_framework.authtoken.models import Token
from rest_framework.authtoken.views import ObtainAuthToken
from django.contrib.auth import get_user_model
from django.core.mail import send_mail
from django.utils.crypto import get_random_string
from .models import Patient, MedicalHistory, Uroflowmetry, LabData, ImagingData, Assessment, ClinicalExam, Notification, DoctorProfile
from .serializers import PatientSerializer, MedicalHistorySerializer, UroflowmetrySerializer, LabDataSerializer, ImagingDataSerializer, AssessmentSerializer, ClinicalExamSerializer, NotificationSerializer, UserSerializer, RegisterSerializer

User = get_user_model()

class RegisterView(generics.CreateAPIView):
    queryset = User.objects.all()
    serializer_class = RegisterSerializer

    def create(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        if not serializer.is_valid():
            print("Registration Validation Errors:", serializer.errors)
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        
        user = serializer.save()
        token, created = Token.objects.get_or_create(user=user)
        return Response({
            'token': token.key,
            'user': UserSerializer(user).data
        }, status=status.HTTP_201_CREATED)

class CustomAuthToken(ObtainAuthToken):
    def post(self, request, *args, **kwargs):
        serializer = self.serializer_class(data=request.data,
                                           context={'request': request})
        if not serializer.is_valid():
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        
        user = serializer.validated_data['user']
        
        # Role Enforcement
        # 1 in urologist is only log in for urologist
        # 2 in technologist is only log in for technologist
        requested_role = request.data.get('role', '').upper()
        
        if requested_role == 'UROLOGIST' and user.urologist != 1:
            return Response({"error": "This account is not authorized as a Urologist."}, status=status.HTTP_403_FORBIDDEN)
        elif requested_role == 'TECHNOLOGIST' and user.technologist != 2:
            return Response({"error": "This account is not authorized as a Technologist."}, status=status.HTTP_403_FORBIDDEN)
        elif not requested_role and user.urologist != 1 and user.technologist != 2:
            # If no role provided, still ensure they have some valid role
            return Response({"error": "Unauthorized account role."}, status=status.HTTP_403_FORBIDDEN)

        token, created = Token.objects.get_or_create(user=user)
        return Response({
            'token': token.key,
            'user': UserSerializer(user).data
        })

import threading

def send_email_bg(subject, message, recipient_list):
    try:
        send_mail(subject, message, None, recipient_list, fail_silently=False)
        print(f"Background thread successfully sent OTP to {recipient_list}")
    except Exception as e:
        print(f"Background thread SMTP Error: {str(e)}")

@api_view(['POST'])
def reset_password(request):
    email = request.data.get('email')
    if not email:
        return Response({"error": "Email is required"}, status=status.HTTP_400_BAD_REQUEST)
    
    try:
        user = User.objects.get(email=email)
        # Generate a 6-digit OTP
        otp_code = get_random_string(length=6, allowed_chars='0123456789')
        
        # Save OTP to database
        from .models import PasswordOTP
        PasswordOTP.objects.filter(user=user).delete() # Clear old ones
        PasswordOTP.objects.create(user=user, otp=otp_code)
        
        # Send Reset Code via email (asynchronously)
        subject = 'Your UroBPHAssist Password Reset Code'
        message = f'Hello {user.first_name or user.username},\n\nYour reset code for password reset is: {otp_code}\n\nPlease enter this in the app to proceed.'
        
        # Log to console for debugging
        print(f"--- [DEBUG] OTP for {email} is: {otp_code} ---")
        
        # Start background thread to send email
        threading.Thread(target=send_email_bg, args=(subject, message, [email])).start()
        
        return Response({"message": "OTP sent to email"}, status=status.HTTP_200_OK)
    
    except User.DoesNotExist:
        # For security, we still claim OTP was sent even if email doesn't exist
        return Response({"message": "If this email is registered, an OTP has been sent."}, status=status.HTTP_200_OK)
    except Exception as e:
        print(f"Internal Reset Error: {str(e)}")
        return Response({"error": "An internal error occurred"}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

@api_view(['POST'])
def verify_otp(request):
    email = request.data.get('email')
    otp_code = request.data.get('otp')
    
    if not email or not otp_code:
        return Response({"error": "Email and OTP are required"}, status=status.HTTP_400_BAD_REQUEST)
    
    try:
        user = User.objects.get(email=email)
        from .models import PasswordOTP
        otp_obj = PasswordOTP.objects.get(user=user, otp=otp_code)
        
        # In a real app, check expiration here (e.g., 10 mins)
        
        otp_obj.is_verified = True
        otp_obj.save()
        
        return Response({"message": "OTP verified successfully"}, status=status.HTTP_200_OK)
    except (User.DoesNotExist, PasswordOTP.DoesNotExist):
        return Response({"error": "Invalid OTP or Email"}, status=status.HTTP_400_BAD_REQUEST)

@api_view(['POST'])
def confirm_password_reset(request):
    email = request.data.get('email')
    new_password = request.data.get('new_password')
    
    if not email or not new_password:
        return Response({"error": "Email and New Password are required"}, status=status.HTTP_400_BAD_REQUEST)
    
    try:
        user = User.objects.get(email=email)
        from .models import PasswordOTP
        otp_obj = PasswordOTP.objects.get(user=user, is_verified=True)
        
        user.set_password(new_password)
        user.save()
        
        # Delete the OTP after successful reset
        otp_obj.delete()
        
        return Response({"message": "Password reset successfully"}, status=status.HTTP_200_OK)
    except (User.DoesNotExist, PasswordOTP.DoesNotExist):
        return Response({"error": "OTP not verified or Session expired"}, status=status.HTTP_400_BAD_REQUEST)

class PatientViewSet(viewsets.ModelViewSet):
    serializer_class = PatientSerializer
    lookup_field = 'mrn'
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        if self.request.user.is_authenticated:
            return Patient.objects.filter(is_deleted=False, user=self.request.user)
        return Patient.objects.none()

    def destroy(self, request, *args, **kwargs):
        instance = self.get_object()
        instance.is_deleted = True
        instance.save()
        return Response(status=status.HTTP_204_NO_CONTENT)

class NotificationViewSet(viewsets.ModelViewSet):
    serializer_class = NotificationSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        # Only return notifications linked to patients belonging to this user
        return Notification.objects.filter(patient__user=self.request.user).order_by('-timestamp')

@api_view(['POST'])
@permission_classes([permissions.IsAuthenticated])
def sync_data(request):
    """
    Bulk sync endpoint for receiving patient data and related clinical records.
    Expects a list of patient objects, each containing its clinical data.
    """
    data = request.data
    if not isinstance(data, list):
        return Response({"error": "Expected a list of patients"}, status=status.HTTP_400_BAD_REQUEST)

    results = []
    for patient_data in data:
        mrn = patient_data.get('mrn')
        if not mrn:
            continue
        
        # Update or create patient
        patient_fields = {
            'name': patient_data.get('name'),
            'age': patient_data.get('age'),
            'gender': patient_data.get('gender'),
            'contact': patient_data.get('contact'),
            'height': patient_data.get('height'),
            'weight': patient_data.get('weight'),
            'bmi': patient_data.get('bmi'),
            'occupation': patient_data.get('occupation'),
            'smoking': patient_data.get('smoking'),
            'alcohol': patient_data.get('alcohol'),
            'activity': patient_data.get('activity'),
        }
        # Only include fields that are actually provided to avoid overwriting with None
        defaults = {k: v for k, v in patient_fields.items() if v is not None}
        
        # Update or create patient (but check for soft delete)
        try:
            patient = Patient.objects.get(mrn=mrn, user=request.user)
            if patient.is_deleted:
                # If it's already deleted on server, ignore the push for this patient
                continue
            for key, value in defaults.items():
                setattr(patient, key, value)
            patient.save()
            created = False
        except Patient.DoesNotExist:
            patient = Patient.objects.create(mrn=mrn, user=request.user, **defaults)
            created = True

        # Sync related records (simplified logic: create new if not existing, or just create)
        # In a real app, we might want to check for duplicates by timestamp
        
        def sync_related(model, data_key, serializer_class):
            records = patient_data.get(data_key, [])
            for record_data in records:
                record_data['patient'] = patient.id
                serializer = serializer_class(data=record_data)
                if serializer.is_valid():
                    serializer.save()
                else:
                    print(f"Error syncing {data_key}: {serializer.errors}")

        sync_related(MedicalHistory, 'medical_history', MedicalHistorySerializer)
        sync_related(Uroflowmetry, 'uroflowmetry', UroflowmetrySerializer)
        sync_related(LabData, 'lab_data', LabDataSerializer)
        sync_related(ImagingData, 'imaging_data', ImagingDataSerializer)
        
        # Sync Assessments and trigger auto-notifications
        assessments = patient_data.get('assessments', [])
        for a_data in assessments:
            a_data['patient'] = patient.id
            serializer = AssessmentSerializer(data=a_data)
            if serializer.is_valid():
                assessment = serializer.save()
                # Auto-generate notification if score is significant
                score = assessment.total_score
                if score >= 8:
                    type = 'URGENT' if score >= 20 else 'INFO'
                    title = f"{'High' if score >= 20 else 'Moderate'} Symptom Score: {patient.name}"
                    message = f"Patient {patient.name} (MRN: {patient.mrn}) recorded an IPSS score of {score}."
                    Notification.objects.get_or_create(
                        patient=patient,
                        title=title,
                        message=message,
                        type=type,
                        defaults={'is_read': False}
                    )
            else:
                print(f"Error syncing assessments: {serializer.errors}")

        sync_related(ClinicalExam, 'clinical_exams', ClinicalExamSerializer)
        sync_related(Notification, 'notifications', NotificationSerializer)

        results.append({"mrn": mrn, "status": "synced"})

    return Response(results, status=status.HTTP_200_OK)


@api_view(['POST'])
@permission_classes([permissions.IsAuthenticated])
def clear_notifications(request):
    """
    Clears only notifications for patients belonging to the authenticated user.
    """
    Notification.objects.filter(patient__user=request.user).delete()
    return Response({"status": "Notifications cleared"}, status=status.HTTP_200_OK)

@api_view(['GET', 'PATCH', 'DELETE'])
@permission_classes([permissions.IsAuthenticated])
def manage_profile(request):
    """
    View to retrieve, update, or delete the authenticated user's profile.
    """
    user = request.user
    if request.method == 'GET':
        serializer = UserSerializer(user)
        return Response(serializer.data)
    
    elif request.method == 'PATCH':
        serializer = UserSerializer(user, data=request.data, partial=True)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    elif request.method == 'DELETE':
        user.delete()
        return Response({"message": "Account deleted successfully"}, status=status.HTTP_204_NO_CONTENT)

@api_view(['GET'])
def health_check(request):
    return Response({"status": "ok", "message": "UroBPH Backend is running"}, status=status.HTTP_200_OK)
