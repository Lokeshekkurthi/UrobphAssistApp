from django.contrib import admin
from .models import Patient, MedicalHistory, Uroflowmetry, LabData, ImagingData, Assessment, ClinicalExam, Notification

@admin.register(Patient)
class PatientAdmin(admin.ModelAdmin):
    list_display = ('mrn', 'name', 'age', 'gender', 'contact', 'created_at')
    search_fields = ('mrn', 'name')

@admin.register(MedicalHistory)
class MedicalHistoryAdmin(admin.ModelAdmin):
    list_display = ('patient', 'timestamp')

@admin.register(Uroflowmetry)
class UroflowmetryAdmin(admin.ModelAdmin):
    list_display = ('patient', 'qmax', 'avg_flow', 'voided_volume', 'timestamp')

@admin.register(LabData)
class LabDataAdmin(admin.ModelAdmin):
    list_display = ('patient', 'psa', 'creatinine', 'blood_urea', 'timestamp')

@admin.register(ImagingData)
class ImagingDataAdmin(admin.ModelAdmin):
    list_display = ('patient', 'prostate_volume', 'pvr', 'timestamp')

@admin.register(Assessment)
class AssessmentAdmin(admin.ModelAdmin):
    list_display = ('patient', 'total_score', 'qol_score', 'timestamp')

@admin.register(ClinicalExam)
class ClinicalExamAdmin(admin.ModelAdmin):
    list_display = ('patient', 'dre_size', 'blood_pressure', 'timestamp')

@admin.register(Notification)
class NotificationAdmin(admin.ModelAdmin):
    list_display = ('patient', 'title', 'type', 'is_read', 'timestamp')
