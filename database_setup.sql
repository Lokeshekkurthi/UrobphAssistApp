-- UroBPH Database Setup Script for MariaDB 10.4 / XAMPP
-- Created to bypass Django 6.0 compatibility issues

SET FOREIGN_KEY_CHECKS = 0;

-- 1. Content Types
CREATE TABLE IF NOT EXISTS `django_content_type` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `app_label` varchar(100) NOT NULL,
    `model` varchar(100) NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 2. Permissions
CREATE TABLE IF NOT EXISTS `auth_permission` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `name` varchar(255) NOT NULL,
    `content_type_id` int(11) NOT NULL,
    `codename` varchar(100) NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
    CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 3. Groups
CREATE TABLE IF NOT EXISTS `auth_group` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `name` varchar(150) NOT NULL UNIQUE,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `auth_group_permissions` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT,
    `group_id` int(11) NOT NULL,
    `permission_id` int(11) NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
    CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
    CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 4. Users
CREATE TABLE IF NOT EXISTS `auth_user` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `password` varchar(128) NOT NULL,
    `last_login` datetime(6) DEFAULT NULL,
    `urologist` int(11) NOT NULL DEFAULT 0,
    `username` varchar(150) NOT NULL UNIQUE,
    `first_name` varchar(150) NOT NULL,
    `last_name` varchar(150) NOT NULL,
    `email` varchar(254) NOT NULL,
    `technologist` int(11) NOT NULL DEFAULT 0,
    `is_active` tinyint(1) NOT NULL,
    `date_joined` datetime(6) NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `auth_user_groups` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT,
    `user_id` int(11) NOT NULL,
    `group_id` int(11) NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
    CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
    CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `auth_user_user_permissions` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT,
    `user_id` int(11) NOT NULL,
    `permission_id` int(11) NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
    CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
    CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 5. Tokens
CREATE TABLE IF NOT EXISTS `authtoken_token` (
    `key` varchar(40) NOT NULL,
    `created` datetime(6) NOT NULL,
    `user_id` int(11) NOT NULL UNIQUE,
    PRIMARY KEY (`key`),
    CONSTRAINT `authtoken_token_user_id_35299eff_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 6. Patients
CREATE TABLE IF NOT EXISTS `api_patient` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT,
    `mrn` varchar(50) NOT NULL UNIQUE,
    `name` varchar(255) NOT NULL,
    `age` varchar(10) DEFAULT NULL,
    `gender` varchar(20) DEFAULT NULL,
    `contact` varchar(20) DEFAULT NULL,
    `height` double DEFAULT NULL,
    `weight` double DEFAULT NULL,
    `bmi` double DEFAULT NULL,
    `occupation` varchar(255) DEFAULT NULL,
    `smoking` varchar(100) DEFAULT NULL,
    `alcohol` varchar(100) DEFAULT NULL,
    `activity` varchar(100) DEFAULT NULL,
    `created_at` datetime(6) NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 7. Doctor Profile
CREATE TABLE IF NOT EXISTS `api_doctorprofile` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT,
    `license_number` varchar(100) DEFAULT NULL,
    `specialty` varchar(255) DEFAULT NULL,
    `role` varchar(50) NOT NULL,
    `user_id` int(11) NOT NULL UNIQUE,
    PRIMARY KEY (`id`),
    CONSTRAINT `api_doctorprofile_user_id_9045adfa_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 8. Clinical Data Tables
CREATE TABLE IF NOT EXISTS `api_medicalhistory` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT,
    `comorbidities` longtext DEFAULT NULL,
    `medications` longtext DEFAULT NULL,
    `family_bph` longtext DEFAULT NULL,
    `family_cancer` longtext DEFAULT NULL,
    `timestamp` datetime(6) NOT NULL,
    `patient_id` bigint(20) NOT NULL,
    PRIMARY KEY (`id`),
    CONSTRAINT `api_medicalhistory_patient_id_2160595a_fk_api_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `api_patient` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `api_uroflowmetry` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT,
    `qmax` double DEFAULT NULL,
    `avg_flow` double DEFAULT NULL,
    `voided_volume` int(11) DEFAULT NULL,
    `flow_pattern` varchar(100) DEFAULT NULL,
    `time_to_peak` double DEFAULT NULL,
    `notes` longtext DEFAULT NULL,
    `timestamp` datetime(6) NOT NULL,
    `patient_id` bigint(20) NOT NULL,
    PRIMARY KEY (`id`),
    CONSTRAINT `api_uroflowmetry_patient_id_573c4a1c_fk_api_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `api_patient` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `api_labdata` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT,
    `psa` double DEFAULT NULL,
    `creatinine` double DEFAULT NULL,
    `blood_urea` double DEFAULT NULL,
    `urinalysis` longtext DEFAULT NULL,
    `hematuria` varchar(100) DEFAULT NULL,
    `pyuria` varchar(100) DEFAULT NULL,
    `infection_markers` varchar(100) DEFAULT NULL,
    `culture` varchar(100) DEFAULT NULL,
    `timestamp` datetime(6) NOT NULL,
    `patient_id` bigint(20) NOT NULL,
    PRIMARY KEY (`id`),
    CONSTRAINT `api_labdata_patient_id_18bc53a9_fk_api_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `api_patient` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `api_imagingdata` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT,
    `prostate_volume` double DEFAULT NULL,
    `pvr` double DEFAULT NULL,
    `ipp` double DEFAULT NULL,
    `bladder_wall` double DEFAULT NULL,
    `timestamp` datetime(6) NOT NULL,
    `patient_id` bigint(20) NOT NULL,
    PRIMARY KEY (`id`),
    CONSTRAINT `api_imagingdata_patient_id_4a2d6f2f_fk_api_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `api_patient` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `api_assessment` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT,
    `total_score` int(11) DEFAULT NULL,
    `qol_score` int(11) DEFAULT NULL,
    `timestamp` datetime(6) NOT NULL,
    `patient_id` bigint(20) NOT NULL,
    PRIMARY KEY (`id`),
    CONSTRAINT `api_assessment_patient_id_d52ec5a0_fk_api_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `api_patient` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `api_clinicalexam` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT,
    `dre_size` varchar(100) DEFAULT NULL,
    `dre_consistency` varchar(100) DEFAULT NULL,
    `dre_tenderness` varchar(100) DEFAULT NULL,
    `blood_pressure` varchar(50) DEFAULT NULL,
    `bladder_distension` varchar(100) DEFAULT NULL,
    `timestamp` datetime(6) NOT NULL,
    `patient_id` bigint(20) NOT NULL,
    PRIMARY KEY (`id`),
    CONSTRAINT `api_clinicalexam_patient_id_5ffd8c66_fk_api_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `api_patient` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `api_notification` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT,
    `title` varchar(255) NOT NULL,
    `message` longtext NOT NULL,
    `type` varchar(50) NOT NULL,
    `is_read` tinyint(1) NOT NULL,
    `timestamp` datetime(6) NOT NULL,
    `patient_id` bigint(20) DEFAULT NULL,
    PRIMARY KEY (`id`),
    CONSTRAINT `api_notification_patient_id_3a185c9f_fk_api_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `api_patient` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `api_passwordotp` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT,
    `otp` varchar(6) NOT NULL,
    `created_at` datetime(6) NOT NULL,
    `is_verified` tinyint(1) NOT NULL,
    `user_id` int(11) NOT NULL,
    PRIMARY KEY (`id`),
    CONSTRAINT `api_passwordotp_user_id_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `django_admin_log` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `action_time` datetime(6) NOT NULL,
    `object_id` longtext DEFAULT NULL,
    `object_repr` varchar(200) NOT NULL,
    `action_flag` smallint(5) UNSIGNED NOT NULL,
    `change_message` longtext NOT NULL,
    `content_type_id` int(11) DEFAULT NULL,
    `user_id` int(11) NOT NULL,
    PRIMARY KEY (`id`),
    CONSTRAINT `django_admin_log_user_id_c561eba4_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 9. Sessions
CREATE TABLE IF NOT EXISTS `django_session` (
    `session_key` varchar(40) NOT NULL,
    `session_data` longtext NOT NULL,
    `expire_date` datetime(6) NOT NULL,
    PRIMARY KEY (`session_key`),
    KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 10. Django Migrations (To keep Django happy)
CREATE TABLE IF NOT EXISTS `django_migrations` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT,
    `app` varchar(255) NOT NULL,
    `name` varchar(255) NOT NULL,
    `applied` datetime(6) NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

SET FOREIGN_KEY_CHECKS = 1;

-- Insert initial content types and fake migrations to satisfy Django
INSERT INTO `django_migrations` (`app`, `name`, `applied`) VALUES
('admin', '0001_initial', NOW()),
('api', '0001_initial', NOW()),
('api', '0002_doctorprofile', NOW()),
('api', '0003_doctorprofile_phone_number', NOW()),
('api', '0004_remove_doctorprofile_phone_number', NOW()),
('auth', '0001_initial', NOW()),
('authtoken', '0001_initial', NOW()),
('contenttypes', '0001_initial', NOW()),
('sessions', '0001_initial', NOW());
