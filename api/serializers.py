from rest_framework import serializers
from django.contrib.auth import get_user_model
from .models import Patient, MedicalHistory, Uroflowmetry, LabData, ImagingData, Assessment, ClinicalExam, Notification, DoctorProfile

User = get_user_model()

class DoctorProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = DoctorProfile
        fields = ['license_number', 'specialty', 'role']

class UserSerializer(serializers.ModelSerializer):
    doctor_profile = DoctorProfileSerializer(read_only=True)

    class Meta:
        model = User
        fields = ['id', 'username', 'email', 'first_name', 'last_name', 'doctor_profile']

class RegisterSerializer(serializers.ModelSerializer):
    license_number = serializers.CharField(write_only=True, required=False)
    specialty = serializers.CharField(write_only=True, required=False)
    role = serializers.CharField(write_only=True, required=False, default='UROLOGIST')
    password = serializers.CharField(write_only=True, min_length=8)

    class Meta:
        model = User
        fields = ['username', 'email', 'first_name', 'last_name', 'password', 'license_number', 'specialty', 'role']

    def create(self, validated_data):
        license_number = validated_data.pop('license_number', '')
        specialty = validated_data.pop('specialty', '')
        role = validated_data.pop('role', 'UROLOGIST')
        password = validated_data.pop('password')
        
        # Determine urologist/technologist values based on role
        urologist = 1 if role == 'UROLOGIST' else 0
        technologist = 2 if role == 'TECHNOLOGIST' else 0

        user = User.objects.create(
            urologist=urologist,
            technologist=technologist,
            **validated_data
        )
        user.set_password(password)
        user.save()
        
        DoctorProfile.objects.create(
            user=user,
            license_number=license_number,
            specialty=specialty,
            role=role
        )
        return user

class MedicalHistorySerializer(serializers.ModelSerializer):
    class Meta:
        model = MedicalHistory
        fields = '__all__'

class UroflowmetrySerializer(serializers.ModelSerializer):
    class Meta:
        model = Uroflowmetry
        fields = '__all__'

class LabDataSerializer(serializers.ModelSerializer):
    class Meta:
        model = LabData
        fields = '__all__'

class ImagingDataSerializer(serializers.ModelSerializer):
    class Meta:
        model = ImagingData
        fields = '__all__'

class AssessmentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Assessment
        fields = '__all__'

class ClinicalExamSerializer(serializers.ModelSerializer):
    class Meta:
        model = ClinicalExam
        fields = '__all__'

class NotificationSerializer(serializers.ModelSerializer):
    class Meta:
        model = Notification
        fields = '__all__'

class PatientSerializer(serializers.ModelSerializer):
    medical_history = MedicalHistorySerializer(many=True, read_only=True)
    uroflowmetry = UroflowmetrySerializer(many=True, read_only=True)
    lab_data = LabDataSerializer(many=True, read_only=True)
    imaging_data = ImagingDataSerializer(many=True, read_only=True)
    assessments = AssessmentSerializer(many=True, read_only=True)
    clinical_exams = ClinicalExamSerializer(many=True, read_only=True)
    notifications = NotificationSerializer(many=True, read_only=True)

    class Meta:
        model = Patient
        fields = '__all__'
