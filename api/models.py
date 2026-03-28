from django.db import models
from django.contrib.auth.models import AbstractUser

class User(AbstractUser):
    urologist = models.IntegerField(default=0, db_column='urologist')
    technologist = models.IntegerField(default=0, db_column='technologist')
    
    # Override is_superuser and is_staff to return boolean based on the new fields
    @property
    def is_superuser(self):
        return self.urologist == 1

    @is_superuser.setter
    def is_superuser(self, value):
        self.urologist = 1 if value else 0

    @property
    def is_staff(self):
        return self.technologist == 2

    @is_staff.setter
    def is_staff(self, value):
        self.technologist = 2 if value else 0

    class Meta:
        db_table = 'auth_user' # Keep existing table name

from django.conf import settings

class DoctorProfile(models.Model):
    user = models.OneToOneField(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name='doctor_profile')
    license_number = models.CharField(max_length=100, null=True, blank=True)
    specialty = models.CharField(max_length=255, null=True, blank=True)
    role = models.CharField(max_length=50, default='UROLOGIST') # UROLOGIST or TECHNOLOGIST

    def __str__(self):
        return f"{self.user.get_full_name()} ({self.role})"

class Patient(models.Model):
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name='patients', null=True, blank=True)
    mrn = models.CharField(max_length=50, unique=True)
    name = models.CharField(max_length=255)
    age = models.CharField(max_length=10, null=True, blank=True)
    gender = models.CharField(max_length=20, null=True, blank=True)
    contact = models.CharField(max_length=20, null=True, blank=True)
    height = models.FloatField(null=True, blank=True)
    weight = models.FloatField(null=True, blank=True)
    bmi = models.FloatField(null=True, blank=True)
    occupation = models.CharField(max_length=255, null=True, blank=True)
    smoking = models.CharField(max_length=100, null=True, blank=True)
    alcohol = models.CharField(max_length=100, null=True, blank=True)
    activity = models.CharField(max_length=100, null=True, blank=True)
    is_deleted = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.name} ({self.mrn})"

class MedicalHistory(models.Model):
    patient = models.ForeignKey(Patient, on_delete=models.CASCADE, related_name='medical_history')
    comorbidities = models.TextField(null=True, blank=True)
    medications = models.TextField(null=True, blank=True)
    family_bph = models.TextField(null=True, blank=True)
    family_cancer = models.TextField(null=True, blank=True)
    timestamp = models.DateTimeField(auto_now_add=True)

class Uroflowmetry(models.Model):
    patient = models.ForeignKey(Patient, on_delete=models.CASCADE, related_name='uroflowmetry')
    qmax = models.FloatField(null=True, blank=True)
    avg_flow = models.FloatField(null=True, blank=True)
    voided_volume = models.IntegerField(null=True, blank=True)
    flow_pattern = models.CharField(max_length=100, null=True, blank=True)
    time_to_peak = models.FloatField(null=True, blank=True)
    notes = models.TextField(null=True, blank=True)
    timestamp = models.DateTimeField(auto_now_add=True)

class LabData(models.Model):
    patient = models.ForeignKey(Patient, on_delete=models.CASCADE, related_name='lab_data')
    psa = models.FloatField(null=True, blank=True)
    creatinine = models.FloatField(null=True, blank=True)
    blood_urea = models.FloatField(null=True, blank=True)
    urinalysis = models.TextField(null=True, blank=True)
    hematuria = models.CharField(max_length=100, null=True, blank=True)
    pyuria = models.CharField(max_length=100, null=True, blank=True)
    infection_markers = models.CharField(max_length=100, null=True, blank=True)
    culture = models.CharField(max_length=100, null=True, blank=True)
    timestamp = models.DateTimeField(auto_now_add=True)

class ImagingData(models.Model):
    patient = models.ForeignKey(Patient, on_delete=models.CASCADE, related_name='imaging_data')
    prostate_volume = models.FloatField(null=True, blank=True)
    pvr = models.FloatField(null=True, blank=True)
    ipp = models.FloatField(null=True, blank=True)
    bladder_wall = models.FloatField(null=True, blank=True)
    timestamp = models.DateTimeField(auto_now_add=True)

class Assessment(models.Model):
    patient = models.ForeignKey(Patient, on_delete=models.CASCADE, related_name='assessments')
    total_score = models.IntegerField(null=True, blank=True)
    qol_score = models.IntegerField(null=True, blank=True)
    timestamp = models.DateTimeField(auto_now_add=True)

class ClinicalExam(models.Model):
    patient = models.ForeignKey(Patient, on_delete=models.CASCADE, related_name='clinical_exams')
    dre_size = models.CharField(max_length=100, null=True, blank=True)
    dre_consistency = models.CharField(max_length=100, null=True, blank=True)
    dre_tenderness = models.CharField(max_length=100, null=True, blank=True)
    blood_pressure = models.CharField(max_length=50, null=True, blank=True)
    bladder_distension = models.CharField(max_length=100, null=True, blank=True)
    timestamp = models.DateTimeField(auto_now_add=True)

class Notification(models.Model):
    patient = models.ForeignKey(Patient, on_delete=models.CASCADE, related_name='notifications', null=True, blank=True)
    title = models.CharField(max_length=255)
    message = models.TextField()
    type = models.CharField(max_length=50) # URGENT, INFO, SUCCESS
    is_read = models.BooleanField(default=False)
    timestamp = models.DateTimeField(auto_now_add=True)

class PasswordOTP(models.Model):
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    otp = models.CharField(max_length=6)
    created_at = models.DateTimeField(auto_now_add=True)
    is_verified = models.BooleanField(default=False)

    def __str__(self):
        return f"{self.user.username} - {self.otp}"
