from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import (
    PatientViewSet, sync_data, health_check, RegisterView, 
    CustomAuthToken, reset_password, verify_otp, confirm_password_reset, 
    clear_notifications, manage_profile, NotificationViewSet
)

router = DefaultRouter()
router.register(r'patients', PatientViewSet, basename='patient')
router.register(r'notifications', NotificationViewSet, basename='notification')

urlpatterns = [
    path('', include(router.urls)),
    path('sync/', sync_data),
    path('status/', health_check),
    path('register/', RegisterView.as_view(), name='register'),
    path('login/', CustomAuthToken.as_view(), name='login'),
    path('reset-password/', reset_password, name='password_reset'),
    path('verify-otp/', verify_otp, name='verify_otp'),
    path('password-reset-confirm/', confirm_password_reset, name='password_reset_confirm'),
    path('clear-notifications/', clear_notifications, name='clear_notifications'),
    path('profile/', manage_profile, name='manage_profile'),
]
