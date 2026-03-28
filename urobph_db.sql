-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 28, 2026 at 07:41 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `urobph_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `api_assessment`
--

CREATE TABLE `api_assessment` (
  `id` int(11) NOT NULL,
  `total_score` int(11) DEFAULT NULL,
  `qol_score` int(11) DEFAULT NULL,
  `timestamp` datetime(6) NOT NULL,
  `patient_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `api_assessment`
--

INSERT INTO `api_assessment` (`id`, `total_score`, `qol_score`, `timestamp`, `patient_id`) VALUES
(1, 13, 2, '2026-03-03 09:06:53.843205', 2),
(2, 30, 4, '2026-03-03 09:12:40.822937', 2),
(3, 20, 2, '2026-03-03 09:13:31.127924', 2),
(4, 20, 2, '2026-03-03 09:13:31.144552', 2),
(5, 21, 2, '2026-03-04 08:17:07.214886', 2),
(6, 8, 3, '2026-03-10 04:06:08.403264', 1),
(7, 8, 2, '2026-03-10 04:21:25.479977', 1),
(8, 6, 2, '2026-03-10 04:24:53.908981', 1),
(9, 26, 5, '2026-03-10 05:19:15.063724', 1),
(10, 4, 0, '2026-03-16 03:09:18.335682', 1);

-- --------------------------------------------------------

--
-- Table structure for table `api_clinicalexam`
--

CREATE TABLE `api_clinicalexam` (
  `id` int(11) NOT NULL,
  `dre_size` varchar(100) DEFAULT NULL,
  `dre_consistency` varchar(100) DEFAULT NULL,
  `dre_tenderness` varchar(100) DEFAULT NULL,
  `blood_pressure` varchar(50) DEFAULT NULL,
  `bladder_distension` varchar(100) DEFAULT NULL,
  `timestamp` datetime(6) NOT NULL,
  `patient_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `api_clinicalexam`
--

INSERT INTO `api_clinicalexam` (`id`, `dre_size`, `dre_consistency`, `dre_tenderness`, `blood_pressure`, `bladder_distension`, `timestamp`, `patient_id`) VALUES
(1, 'Normal', 'Soft / Elastic', 'Significant', '', 'No', '2026-03-03 08:52:15.966244', 1),
(2, 'Enlarged (+)', 'Firm', 'None', '', 'No', '2026-03-03 08:56:40.121916', 1),
(3, 'Enlarged (+++)', 'Hard / Nodular', 'Significant', '', 'No', '2026-03-03 08:59:01.498661', 1),
(4, 'Enlarged (+++)', 'Hard / Nodular', 'Significant', '', 'No', '2026-03-03 08:59:01.516970', 2),
(5, 'Enlarged (++)', 'Hard / Nodular', 'Significant', '', 'No', '2026-03-03 09:01:22.685920', 2),
(6, 'Normal', 'Soft / Elastic', 'None', '', 'No', '2026-03-04 07:50:46.694904', 3),
(7, 'Normal', 'Firm', 'None', '120/80', 'No', '2026-03-04 08:15:50.156851', 2),
(8, 'Normal', 'Soft / Elastic', 'Significant', '', 'No', '2026-03-10 04:04:27.205507', 1);

-- --------------------------------------------------------

--
-- Table structure for table `api_doctorprofile`
--

CREATE TABLE `api_doctorprofile` (
  `id` int(11) NOT NULL,
  `license_number` varchar(100) DEFAULT NULL,
  `specialty` varchar(255) DEFAULT NULL,
  `role` varchar(50) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `api_doctorprofile`
--

INSERT INTO `api_doctorprofile` (`id`, `license_number`, `specialty`, `role`, `user_id`) VALUES
(1, NULL, NULL, 'UROLOGIST', 2),
(2, 'LIC-1733563', 'Urologist', 'UROLOGIST', 3),
(3, 'LIC-1263535', 'Technologist', 'TECHNOLOGIST', 4),
(4, 'TECH123', 'Technician', 'TECHNOLOGIST', 5),
(5, 'LIC-123556', 'Technologist', 'TECHNOLOGIST', 6),
(7, '', '', 'UROLOGIST', 8),
(8, 'LIC-12345', '', 'UROLOGIST', 9),
(9, 'LIC-12345', '', 'UROLOGIST', 10),
(10, 'LIC-001', '', 'UROLOGIST', 11);

-- --------------------------------------------------------

--
-- Table structure for table `api_imagingdata`
--

CREATE TABLE `api_imagingdata` (
  `id` int(11) NOT NULL,
  `prostate_volume` double DEFAULT NULL,
  `pvr` double DEFAULT NULL,
  `ipp` double DEFAULT NULL,
  `bladder_wall` double DEFAULT NULL,
  `timestamp` datetime(6) NOT NULL,
  `patient_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `api_imagingdata`
--

INSERT INTO `api_imagingdata` (`id`, `prostate_volume`, `pvr`, `ipp`, `bladder_wall`, `timestamp`, `patient_id`) VALUES
(1, 1, 1, 0, 0.2, '2026-03-04 07:52:47.172048', 3),
(2, 1, 1, 0, 0, '2026-03-10 04:06:08.398395', 1);

-- --------------------------------------------------------

--
-- Table structure for table `api_labdata`
--

CREATE TABLE `api_labdata` (
  `id` int(11) NOT NULL,
  `psa` double DEFAULT NULL,
  `creatinine` double DEFAULT NULL,
  `blood_urea` double DEFAULT NULL,
  `urinalysis` longtext DEFAULT NULL,
  `hematuria` varchar(100) DEFAULT NULL,
  `pyuria` varchar(100) DEFAULT NULL,
  `infection_markers` varchar(100) DEFAULT NULL,
  `culture` varchar(100) DEFAULT NULL,
  `timestamp` datetime(6) NOT NULL,
  `patient_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `api_labdata`
--

INSERT INTO `api_labdata` (`id`, `psa`, `creatinine`, `blood_urea`, `urinalysis`, `hematuria`, `pyuria`, `infection_markers`, `culture`, `timestamp`, `patient_id`) VALUES
(1, 1, 2, 0.2, 'Normal', 'Absent', 'Absent', 'Positive', 'Negative (No Growth)', '2026-03-04 07:52:47.165073', 3),
(2, 1.1, 0, 1, 'Normal', 'Absent', 'Absent', 'Negative', 'Negative (No Growth)', '2026-03-10 04:06:08.392865', 1);

-- --------------------------------------------------------

--
-- Table structure for table `api_medicalhistory`
--

CREATE TABLE `api_medicalhistory` (
  `id` int(11) NOT NULL,
  `comorbidities` longtext DEFAULT NULL,
  `medications` longtext DEFAULT NULL,
  `family_bph` longtext DEFAULT NULL,
  `family_cancer` longtext DEFAULT NULL,
  `timestamp` datetime(6) NOT NULL,
  `patient_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `api_medicalhistory`
--

INSERT INTO `api_medicalhistory` (`id`, `comorbidities`, `medications`, `family_bph`, `family_cancer`, `timestamp`, `patient_id`) VALUES
(1, 'Diabetes Mellitus, Hypertension', 'Antidiabetics', 'No', 'Yes', '2026-03-03 08:52:15.963213', 1),
(2, 'Diabetes Mellitus, Hypertension', 'Alpha Blockers (Tamsulosin, Silodosin)', 'No', 'Yes', '2026-03-03 08:56:40.097597', 1),
(3, 'Parkinson\'s Disease, Spinal Cord Injury', 'Antidepressants', 'No', 'Yes', '2026-03-03 08:59:01.482591', 1),
(4, 'Parkinson\'s Disease, Spinal Cord Injury', 'Antidepressants', 'No', 'Yes', '2026-03-03 08:59:01.514209', 2),
(5, 'Hypertension, Multiple Sclerosis', 'PDE5 Inhibitors (Tadalafil)', 'No', 'Yes', '2026-03-03 09:01:22.683658', 2),
(6, 'Hypertension, Sleep Apnea', 'Sedatives/Hypnotics', 'No', 'No', '2026-03-04 07:50:46.691716', 3),
(7, 'Hypertension, Coronary Artery Disease', 'Sedatives/Hypnotics', 'No', 'No', '2026-03-04 08:15:50.149162', 2),
(8, 'Diabetes Mellitus, Hypertension', 'PDE5 Inhibitors (Tadalafil)', 'No', 'No', '2026-03-10 04:04:27.199450', 1);

-- --------------------------------------------------------

--
-- Table structure for table `api_notification`
--

CREATE TABLE `api_notification` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `message` longtext NOT NULL,
  `type` varchar(50) NOT NULL,
  `is_read` tinyint(1) NOT NULL,
  `timestamp` datetime(6) NOT NULL,
  `patient_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `api_notification`
--

INSERT INTO `api_notification` (`id`, `title`, `message`, `type`, `is_read`, `timestamp`, `patient_id`) VALUES
(1, 'New Health Tip', 'Learn about how caffeine affects your symptoms.', 'INFO', 0, '2026-03-03 08:52:15.969977', 1),
(2, 'Obesity Warning', 'Patient BMI is 166.42 (Obese). Weight management recommended.', 'WARNING', 0, '2026-03-03 08:56:40.143191', 1),
(3, 'Elderly Patient Alert', 'Patient is 80 years old. Increased risk for BPH complications.', 'INFO', 0, '2026-03-03 08:56:40.147363', 1),
(4, 'New Health Tip', 'Learn about how caffeine affects your symptoms.', 'INFO', 0, '2026-03-03 08:56:40.150163', 1),
(5, 'Diabetes Management', 'Diabetes can worsen urinary symptoms. Careful glucose control and monitoring recommended.', 'INFO', 0, '2026-03-03 08:56:40.152979', 1),
(6, 'Hypertension Alert', 'Some BPH medications can interact with blood pressure treatments.', 'INFO', 0, '2026-03-03 08:56:40.155566', 1),
(7, 'Family History Alert', 'Positive family history for prostate cancer. PSA monitoring is advised.', 'WARNING', 0, '2026-03-03 08:56:40.158498', 1),
(8, 'Obesity Warning', 'Patient BMI is 171.90 (Obese). Weight management recommended.', 'WARNING', 0, '2026-03-03 08:59:01.500855', 1),
(9, 'Elderly Patient Alert', 'Patient is 80 years old. Increased risk for BPH complications.', 'INFO', 0, '2026-03-03 08:59:01.503176', 1),
(10, 'New Health Tip', 'Learn about how caffeine affects your symptoms.', 'INFO', 0, '2026-03-03 08:59:01.506443', 1),
(11, 'Neurological Risk', 'Neurological conditions may lead to neurogenic bladder symptoms.', 'WARNING', 0, '2026-03-03 08:59:01.508169', 1),
(12, 'Family History Alert', 'Positive family history for prostate cancer. PSA monitoring is advised.', 'WARNING', 0, '2026-03-03 08:59:01.510027', 1),
(13, 'Obesity Warning', 'Patient BMI is 171.90 (Obese). Weight management recommended.', 'WARNING', 0, '2026-03-03 08:59:01.518762', 2),
(14, 'Elderly Patient Alert', 'Patient is 80 years old. Increased risk for BPH complications.', 'INFO', 0, '2026-03-03 08:59:01.520770', 2),
(15, 'New Health Tip', 'Learn about how caffeine affects your symptoms.', 'INFO', 0, '2026-03-03 08:59:01.522998', 2),
(16, 'Neurological Risk', 'Neurological conditions may lead to neurogenic bladder symptoms.', 'WARNING', 0, '2026-03-03 08:59:01.524973', 2),
(17, 'Family History Alert', 'Positive family history for prostate cancer. PSA monitoring is advised.', 'WARNING', 0, '2026-03-03 08:59:01.527128', 2),
(18, 'Obesity Warning', 'Patient BMI is 184.91 (Obese). Weight management recommended.', 'WARNING', 0, '2026-03-03 09:01:22.687729', 2),
(19, 'New Health Tip', 'Learn about how caffeine affects your symptoms.', 'INFO', 0, '2026-03-03 09:01:22.689694', 2),
(20, 'Hypertension Alert', 'Some BPH medications can interact with blood pressure treatments.', 'INFO', 0, '2026-03-03 09:01:22.691683', 2),
(21, 'Neurological Risk', 'Neurological conditions may lead to neurogenic bladder symptoms.', 'WARNING', 0, '2026-03-03 09:01:22.693704', 2),
(22, 'Family History Alert', 'Positive family history for prostate cancer. PSA monitoring is advised.', 'WARNING', 0, '2026-03-03 09:01:22.696991', 2),
(23, 'Moderate Symptom Score', 'Your last score (13) indicates moderate symptoms.', 'INFO', 0, '2026-03-03 09:06:53.857759', 2),
(24, 'Moderate Symptoms Detected', 'Patient Lskdh has moderate symptoms (IPSS: 13). Monitor regularly.', 'INFO', 0, '2026-03-03 09:06:53.860063', 2),
(25, 'High Symptom Score', 'Your last score (30) indicated severe symptoms. Consider consulting a doctor.', 'URGENT', 0, '2026-03-03 09:12:40.839720', 2),
(26, 'Action Required: Severe Symptoms', 'IPSS score: 30. Patient requires clinical evaluation for severe symptoms.', 'URGENT', 0, '2026-03-03 09:12:40.843321', 2),
(27, 'High Symptom Score', 'Your last score (20) indicated severe symptoms. Consider consulting a doctor.', 'URGENT', 0, '2026-03-03 09:13:31.147914', 2),
(28, 'High Symptom Score', 'Your last score (20) indicated severe symptoms. Consider consulting a doctor.', 'URGENT', 0, '2026-03-03 09:13:31.149890', 2),
(29, 'Action Required: Severe Symptoms', 'IPSS score: 20. Patient requires clinical evaluation for severe symptoms.', 'URGENT', 0, '2026-03-03 09:13:31.151861', 2),
(30, 'Obesity Warning', 'Patient BMI is 280.00 (Obese). Weight management recommended.', 'WARNING', 0, '2026-03-04 07:50:46.697442', 3),
(31, 'New Health Tip', 'Learn about how caffeine affects your symptoms.', 'INFO', 0, '2026-03-04 07:50:46.699540', 3),
(32, 'Hypertension Alert', 'Some BPH medications can interact with blood pressure treatments.', 'INFO', 0, '2026-03-04 07:50:46.701264', 3),
(33, 'Severe Obstruction Detected', 'Qmax of 1.1 mL/s indicates severe obstruction.', 'URGENT', 0, '2026-03-04 07:52:47.175094', 3),
(34, 'Abnormal Creatinine', 'Creatinine level of 2.0 mg/dL is elevated.', 'URGENT', 0, '2026-03-04 07:52:47.177470', 3),
(35, 'Obesity Warning', 'Patient BMI is 251.48 (Obese). Weight management recommended.', 'WARNING', 0, '2026-03-04 08:15:50.159516', 2),
(36, 'New Health Tip', 'Learn about how caffeine affects your symptoms.', 'INFO', 0, '2026-03-04 08:15:50.165030', 2),
(37, 'Hypertension Alert', 'Some BPH medications can interact with blood pressure treatments.', 'INFO', 0, '2026-03-04 08:15:50.167130', 2),
(38, 'Severe Obstruction Detected', 'Qmax of 1.0 mL/s indicates severe obstruction.', 'URGENT', 0, '2026-03-04 08:17:07.218354', 2),
(39, 'High Symptom Score', 'Your last score (21) indicated severe symptoms. Consider consulting a doctor.', 'URGENT', 0, '2026-03-04 08:17:07.220515', 2),
(40, 'Action Required: Severe Symptoms', 'IPSS score: 21. Patient requires clinical evaluation for severe symptoms.', 'URGENT', 0, '2026-03-04 08:17:07.223822', 2),
(41, 'Obesity Warning', 'Patient BMI is 231.40 (Obese). Weight management recommended.', 'WARNING', 0, '2026-03-10 04:04:27.211180', 1),
(42, 'New Health Tip', 'Learn about how caffeine affects your symptoms.', 'INFO', 0, '2026-03-10 04:04:27.215621', 1),
(43, 'Diabetes Management', 'Diabetes can worsen urinary symptoms. Careful glucose control and monitoring recommended.', 'INFO', 0, '2026-03-10 04:04:27.219020', 1),
(44, 'Hypertension Alert', 'Some BPH medications can interact with blood pressure treatments.', 'INFO', 0, '2026-03-10 04:04:27.222882', 1),
(45, 'Severe Obstruction Detected', 'Qmax of 1.1 mL/s indicates severe obstruction.', 'URGENT', 0, '2026-03-10 04:06:08.408328', 1),
(46, 'Moderate Symptom Score', 'Your last score (8) indicates moderate symptoms.', 'INFO', 0, '2026-03-10 04:06:08.412385', 1),
(47, 'Moderate Symptoms Detected', 'Patient Lokesh  has moderate symptoms (IPSS: 8). Monitor regularly.', 'INFO', 0, '2026-03-10 04:06:08.417432', 1),
(48, 'Moderate Symptom Score', 'Your last score (8) indicates moderate symptoms.', 'INFO', 0, '2026-03-10 04:21:25.498138', 1),
(49, 'Moderate Symptoms Detected', 'Patient Lokesh  has moderate symptoms (IPSS: 8). Monitor regularly.', 'INFO', 0, '2026-03-10 04:21:25.501126', 1),
(50, 'Mild Symptom Score', 'Your last score (6) indicates mild symptoms.', 'SUCCESS', 0, '2026-03-10 04:24:53.925011', 1),
(51, 'High Symptom Score', 'Your last score (26) indicated severe symptoms. Consider consulting a doctor.', 'URGENT', 0, '2026-03-10 05:19:15.069025', 1),
(52, 'Action Required: Severe Symptoms', 'IPSS score: 26. Patient requires clinical evaluation for severe symptoms.', 'URGENT', 0, '2026-03-10 05:19:15.071317', 1),
(53, 'Mild Symptom Score', 'Your last score (4) indicates mild symptoms.', 'SUCCESS', 0, '2026-03-16 03:09:18.341561', 1);

-- --------------------------------------------------------

--
-- Table structure for table `api_passwordotp`
--

CREATE TABLE `api_passwordotp` (
  `id` int(11) NOT NULL,
  `otp` varchar(6) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `is_verified` tinyint(1) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `api_passwordotp`
--

INSERT INTO `api_passwordotp` (`id`, `otp`, `created_at`, `is_verified`, `user_id`) VALUES
(35, '5211', '2026-03-10 07:23:06.259827', 0, 6),
(37, '2332', '2026-03-10 07:28:41.886797', 1, 4),
(38, '9396', '2026-03-16 03:10:36.674102', 1, 3);

-- --------------------------------------------------------

--
-- Table structure for table `api_patient`
--

CREATE TABLE `api_patient` (
  `id` int(11) NOT NULL,
  `mrn` varchar(50) NOT NULL,
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
  `created_at` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `api_patient`
--

INSERT INTO `api_patient` (`id`, `mrn`, `name`, `age`, `gender`, `contact`, `height`, `weight`, `bmi`, `occupation`, `smoking`, `alcohol`, `activity`, `created_at`) VALUES
(1, 'UH-2026-001', 'Lokesh ', '22', 'Male', '', 55, 70, 231.40495867768593, 'Student', 'Never smoked', 'None / Rarely', 'Sedentary (little to no exercise)', '2026-03-03 08:52:15.958886'),
(2, 'UH-2026-002', 'Rakesh ', '22', 'Male', '', 52, 68, 251.47928994082838, 'Student', 'Never smoked', 'None / Rarely', 'Sedentary (little to no exercise)', '2026-03-03 08:59:01.511754'),
(3, 'UH-2026-003', 'Rakesh', '22', 'Male', '', 50, 70, 280, 'Student', 'Never smoked', 'None / Rarely', 'Sedentary (little to no exercise)', '2026-03-04 07:50:46.688685'),
(4, 'MRN-123', 'John Doe', '65', 'Male', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-16 04:47:10.928222');

-- --------------------------------------------------------

--
-- Table structure for table `api_uroflowmetry`
--

CREATE TABLE `api_uroflowmetry` (
  `id` int(11) NOT NULL,
  `qmax` double DEFAULT NULL,
  `avg_flow` double DEFAULT NULL,
  `voided_volume` int(11) DEFAULT NULL,
  `flow_pattern` varchar(100) DEFAULT NULL,
  `time_to_peak` double DEFAULT NULL,
  `notes` longtext DEFAULT NULL,
  `timestamp` datetime(6) NOT NULL,
  `patient_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `api_uroflowmetry`
--

INSERT INTO `api_uroflowmetry` (`id`, `qmax`, `avg_flow`, `voided_volume`, `flow_pattern`, `time_to_peak`, `notes`, `timestamp`, `patient_id`) VALUES
(1, 1.1, 0, 1, 'Normal (Bell-shaped)', 1, '', '2026-03-04 07:52:47.146759', 3),
(2, 1, 2, 1, 'Normal (Bell-shaped)', 1, 'gh', '2026-03-04 08:17:07.210503', 2),
(3, 1.1, 0.1, 1, 'Normal (Bell-shaped)', 1, '', '2026-03-10 04:06:08.371260', 1);

-- --------------------------------------------------------

--
-- Table structure for table `authtoken_token`
--

CREATE TABLE `authtoken_token` (
  `key` varchar(40) NOT NULL,
  `created` datetime(6) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `authtoken_token`
--

INSERT INTO `authtoken_token` (`key`, `created`, `user_id`) VALUES
('434a34fe5f80f61ee173f6003e1ebef1720272c2', '2026-03-03 07:57:55.404307', 3),
('5a112aa77916214d35aef1f2ad248d2f26178942', '2026-03-16 04:25:05.005114', 10),
('8c3e5a1e6a865d710a67fb512eabc85f35d11c3d', '2026-03-10 03:20:28.407169', 6),
('8c729131b94ea1e1c128ab9008243f77c352adfb', '2026-03-10 03:19:13.071280', 5),
('a84bfe7030d496897184a274f0db951c63b64865', '2026-03-16 04:08:30.661972', 9),
('a8919f37040d7e198019db36611c257c0957533d', '2026-03-10 03:14:34.794533', 4),
('b1ec32093dc535591e86d1a269f50da564cc0ded', '2026-03-10 07:44:14.745886', 8),
('d983bee1cea0bc3c127e934671539598e93d8945', '2026-03-16 04:58:05.266964', 11);

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add token', 7, 'add_token'),
(26, 'Can change token', 7, 'change_token'),
(27, 'Can delete token', 7, 'delete_token'),
(28, 'Can view token', 7, 'view_token'),
(29, 'Can add patient', 8, 'add_patient'),
(30, 'Can change patient', 8, 'change_patient'),
(31, 'Can delete patient', 8, 'delete_patient'),
(32, 'Can view patient', 8, 'view_patient'),
(33, 'Can add notification', 9, 'add_notification'),
(34, 'Can change notification', 9, 'change_notification'),
(35, 'Can delete notification', 9, 'delete_notification'),
(36, 'Can view notification', 9, 'view_notification'),
(37, 'Can add medical history', 10, 'add_medicalhistory'),
(38, 'Can change medical history', 10, 'change_medicalhistory'),
(39, 'Can delete medical history', 10, 'delete_medicalhistory'),
(40, 'Can view medical history', 10, 'view_medicalhistory'),
(41, 'Can add lab data', 11, 'add_labdata'),
(42, 'Can change lab data', 11, 'change_labdata'),
(43, 'Can delete lab data', 11, 'delete_labdata'),
(44, 'Can view lab data', 11, 'view_labdata'),
(45, 'Can add imaging data', 12, 'add_imagingdata'),
(46, 'Can change imaging data', 12, 'change_imagingdata'),
(47, 'Can delete imaging data', 12, 'delete_imagingdata'),
(48, 'Can view imaging data', 12, 'view_imagingdata'),
(49, 'Can add clinical exam', 13, 'add_clinicalexam'),
(50, 'Can change clinical exam', 13, 'change_clinicalexam'),
(51, 'Can delete clinical exam', 13, 'delete_clinicalexam'),
(52, 'Can view clinical exam', 13, 'view_clinicalexam'),
(53, 'Can add assessment', 14, 'add_assessment'),
(54, 'Can change assessment', 14, 'change_assessment'),
(55, 'Can delete assessment', 14, 'delete_assessment'),
(56, 'Can view assessment', 14, 'view_assessment'),
(57, 'Can add uroflowmetry', 15, 'add_uroflowmetry'),
(58, 'Can change uroflowmetry', 15, 'change_uroflowmetry'),
(59, 'Can delete uroflowmetry', 15, 'delete_uroflowmetry'),
(60, 'Can view uroflowmetry', 15, 'view_uroflowmetry'),
(61, 'Can add doctor profile', 16, 'add_doctorprofile'),
(62, 'Can change doctor profile', 16, 'change_doctorprofile'),
(63, 'Can delete doctor profile', 16, 'delete_doctorprofile'),
(64, 'Can view doctor profile', 16, 'view_doctorprofile'),
(65, 'Can add password otp', 17, 'add_passwordotp'),
(66, 'Can change password otp', 17, 'change_passwordotp'),
(67, 'Can delete password otp', 17, 'delete_passwordotp'),
(68, 'Can view password otp', 17, 'view_passwordotp'),
(69, 'Can add Token', 18, 'add_tokenproxy'),
(70, 'Can change Token', 18, 'change_tokenproxy'),
(71, 'Can delete Token', 18, 'delete_tokenproxy'),
(72, 'Can view Token', 18, 'view_tokenproxy'),
(73, 'Can add user', 19, 'add_user'),
(74, 'Can change user', 19, 'change_user'),
(75, 'Can delete user', 19, 'delete_user'),
(76, 'Can view user', 19, 'view_user');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `urologist` int(11) NOT NULL DEFAULT 0,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `technologist` int(11) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `urologist`, `username`, `first_name`, `last_name`, `email`, `technologist`, `is_active`, `date_joined`) VALUES
(1, 'pbkdf2_sha256$600000$sA1GCk7KefmB4ikNQtNhDS$Sr7wJji1B3SKJnB3eT4PxGP+awQ8Z+j0iCtj5s/OXk8=', NULL, 1, 'admin', 'Admin', '', 'admin@example.com', 1, 1, '2026-03-03 04:57:29.683303'),
(2, 'pbkdf2_sha256$600000$vZiMfKfE5mGZ4fA2kC6BfT$E/Hn34+Q6u4xr7Ut7sFtcQRIWNcUK47oZHKqEsK0Rzw=', NULL, 0, 'test@yopmail.com', 'Lokesh', '', 'test@yopmail.com', 0, 1, '2026-03-03 04:57:30.293196'),
(3, 'Lokesh@12', NULL, 1, 'lokeshekkurthi898@gmail.com', 'Lokesh', 'Ekkurthi', 'lokeshekkurthi898@gmail.com', 0, 1, '2026-03-03 07:57:55.098651'),
(4, '12345678', NULL, 0, 'lokeshekkurthi53766@gmail.com', 'Dr.Rakesh', '', 'lokeshekkurthi53766@gmail.com', 2, 1, '2026-03-10 03:14:34.150460'),
(5, 'pbkdf2_sha256$600000$TmFASSg2nNN9b2hm2XuICv$1STgjlCRqMj2rPSD/RDHGJGMUDp+4ImlyYWzUd7vkRs=', NULL, 0, 'test_tech@example.com', 'Test', 'Technologist', 'test_tech@example.com', 0, 1, '2026-03-10 03:19:12.494893'),
(6, '12345678', NULL, 0, 'lokeshekkurthi2004@gmail.com', 'Dr.Rakesh', '', 'lokeshekkurthi2004@gmail.com', 2, 1, '2026-03-10 03:20:27.821089'),
(8, 'MySecretPassword123', NULL, 1, 'test_role_user', 'Test', 'User', 'test_role@example.com', 0, 1, '2026-03-10 07:44:14.735998'),
(9, 'testpassword', NULL, 1, 'urologist_test', 'Uro', 'Logist', 'urologist_test@test.com', 0, 1, '2026-03-16 04:08:30.650748'),
(10, 'password123', NULL, 1, 'userabc', 'A', 'B', 'userabc@gmail.com', 0, 1, '2026-03-16 04:25:04.989189'),
(11, 'Password123!', NULL, 1, 'testuser', 'Test', 'User', 'test@example.com', 0, 1, '2026-03-16 04:58:05.246792');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(14, 'api', 'assessment'),
(13, 'api', 'clinicalexam'),
(16, 'api', 'doctorprofile'),
(12, 'api', 'imagingdata'),
(11, 'api', 'labdata'),
(10, 'api', 'medicalhistory'),
(9, 'api', 'notification'),
(17, 'api', 'passwordotp'),
(8, 'api', 'patient'),
(15, 'api', 'uroflowmetry'),
(19, 'api', 'user'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(7, 'authtoken', 'token'),
(18, 'authtoken', 'tokenproxy'),
(5, 'contenttypes', 'contenttype'),
(6, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'admin', '0001_initial', '2026-03-03 10:25:14.000000'),
(2, 'api', '0001_initial', '2026-03-03 10:25:14.000000'),
(3, 'api', '0002_doctorprofile', '2026-03-03 10:25:14.000000'),
(4, 'api', '0003_doctorprofile_phone_number', '2026-03-03 10:25:14.000000'),
(5, 'api', '0004_remove_doctorprofile_phone_number', '2026-03-03 10:25:14.000000'),
(6, 'auth', '0001_initial', '2026-03-03 10:25:14.000000'),
(7, 'authtoken', '0001_initial', '2026-03-03 10:25:14.000000'),
(8, 'contenttypes', '0001_initial', '2026-03-03 10:25:14.000000'),
(9, 'sessions', '0001_initial', '2026-03-03 10:25:14.000000'),
(10, 'api', '0005_alter_assessment_id_alter_clinicalexam_id_and_more', '2026-03-03 07:50:04.966866'),
(11, 'admin', '0002_logentry_remove_auto_add', '2026-03-14 08:43:04.025893'),
(12, 'admin', '0003_logentry_add_action_flag_choices', '2026-03-14 08:43:04.047784'),
(13, 'contenttypes', '0002_remove_content_type_name', '2026-03-14 08:43:04.106477'),
(14, 'auth', '0002_alter_permission_name_max_length', '2026-03-14 08:43:04.119806'),
(15, 'auth', '0003_alter_user_email_max_length', '2026-03-14 08:43:04.125899'),
(16, 'auth', '0004_alter_user_username_opts', '2026-03-14 08:43:04.132725'),
(17, 'auth', '0005_alter_user_last_login_null', '2026-03-14 08:43:04.138403'),
(18, 'auth', '0006_require_contenttypes_0002', '2026-03-14 08:43:04.140434'),
(19, 'auth', '0007_alter_validators_add_error_messages', '2026-03-14 08:43:04.146053'),
(20, 'auth', '0008_alter_user_username_max_length', '2026-03-14 08:43:04.152360'),
(21, 'auth', '0009_alter_user_last_name_max_length', '2026-03-14 08:43:04.160092'),
(22, 'auth', '0010_alter_group_name_max_length', '2026-03-14 08:43:04.172692'),
(23, 'auth', '0011_update_proxy_permissions', '2026-03-14 08:43:04.183257'),
(24, 'auth', '0012_alter_user_first_name_max_length', '2026-03-14 08:43:04.189525'),
(25, 'authtoken', '0002_auto_20160226_1747', '2026-03-14 08:43:04.209633'),
(26, 'authtoken', '0003_tokenproxy', '2026-03-14 08:43:04.212466'),
(27, 'authtoken', '0004_alter_tokenproxy_options', '2026-03-14 08:43:04.216696');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `api_assessment`
--
ALTER TABLE `api_assessment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `api_assessment_patient_id_d52ec5a0_fk` (`patient_id`);

--
-- Indexes for table `api_clinicalexam`
--
ALTER TABLE `api_clinicalexam`
  ADD PRIMARY KEY (`id`),
  ADD KEY `api_clinicalexam_patient_id_5ffd8c66_fk` (`patient_id`);

--
-- Indexes for table `api_doctorprofile`
--
ALTER TABLE `api_doctorprofile`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `api_imagingdata`
--
ALTER TABLE `api_imagingdata`
  ADD PRIMARY KEY (`id`),
  ADD KEY `api_imagingdata_patient_id_4a2d6f2f_fk` (`patient_id`);

--
-- Indexes for table `api_labdata`
--
ALTER TABLE `api_labdata`
  ADD PRIMARY KEY (`id`),
  ADD KEY `api_labdata_patient_id_18bc53a9_fk` (`patient_id`);

--
-- Indexes for table `api_medicalhistory`
--
ALTER TABLE `api_medicalhistory`
  ADD PRIMARY KEY (`id`),
  ADD KEY `api_medicalhistory_patient_id_2160595a_fk` (`patient_id`);

--
-- Indexes for table `api_notification`
--
ALTER TABLE `api_notification`
  ADD PRIMARY KEY (`id`),
  ADD KEY `api_notification_patient_id_3a185c9f_fk` (`patient_id`);

--
-- Indexes for table `api_passwordotp`
--
ALTER TABLE `api_passwordotp`
  ADD PRIMARY KEY (`id`),
  ADD KEY `api_passwordotp_user_id_dbccebe8_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `api_patient`
--
ALTER TABLE `api_patient`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mrn` (`mrn`);

--
-- Indexes for table `api_uroflowmetry`
--
ALTER TABLE `api_uroflowmetry`
  ADD PRIMARY KEY (`id`),
  ADD KEY `api_uroflowmetry_patient_id_573c4a1c_fk` (`patient_id`);

--
-- Indexes for table `authtoken_token`
--
ALTER TABLE `authtoken_token`
  ADD PRIMARY KEY (`key`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indexes for table `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Indexes for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_user_id_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `api_assessment`
--
ALTER TABLE `api_assessment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `api_clinicalexam`
--
ALTER TABLE `api_clinicalexam`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `api_doctorprofile`
--
ALTER TABLE `api_doctorprofile`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `api_imagingdata`
--
ALTER TABLE `api_imagingdata`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `api_labdata`
--
ALTER TABLE `api_labdata`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `api_medicalhistory`
--
ALTER TABLE `api_medicalhistory`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `api_notification`
--
ALTER TABLE `api_notification`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT for table `api_passwordotp`
--
ALTER TABLE `api_passwordotp`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `api_patient`
--
ALTER TABLE `api_patient`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `api_uroflowmetry`
--
ALTER TABLE `api_uroflowmetry`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=77;

--
-- AUTO_INCREMENT for table `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `api_assessment`
--
ALTER TABLE `api_assessment`
  ADD CONSTRAINT `api_assessment_patient_id_d52ec5a0_fk` FOREIGN KEY (`patient_id`) REFERENCES `api_patient` (`id`);

--
-- Constraints for table `api_clinicalexam`
--
ALTER TABLE `api_clinicalexam`
  ADD CONSTRAINT `api_clinicalexam_patient_id_5ffd8c66_fk` FOREIGN KEY (`patient_id`) REFERENCES `api_patient` (`id`);

--
-- Constraints for table `api_doctorprofile`
--
ALTER TABLE `api_doctorprofile`
  ADD CONSTRAINT `api_doctorprofile_user_id_9045adfa_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `api_imagingdata`
--
ALTER TABLE `api_imagingdata`
  ADD CONSTRAINT `api_imagingdata_patient_id_4a2d6f2f_fk` FOREIGN KEY (`patient_id`) REFERENCES `api_patient` (`id`);

--
-- Constraints for table `api_labdata`
--
ALTER TABLE `api_labdata`
  ADD CONSTRAINT `api_labdata_patient_id_18bc53a9_fk` FOREIGN KEY (`patient_id`) REFERENCES `api_patient` (`id`);

--
-- Constraints for table `api_medicalhistory`
--
ALTER TABLE `api_medicalhistory`
  ADD CONSTRAINT `api_medicalhistory_patient_id_2160595a_fk` FOREIGN KEY (`patient_id`) REFERENCES `api_patient` (`id`);

--
-- Constraints for table `api_notification`
--
ALTER TABLE `api_notification`
  ADD CONSTRAINT `api_notification_patient_id_3a185c9f_fk` FOREIGN KEY (`patient_id`) REFERENCES `api_patient` (`id`);

--
-- Constraints for table `api_passwordotp`
--
ALTER TABLE `api_passwordotp`
  ADD CONSTRAINT `api_passwordotp_user_id_dbccebe8_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `api_uroflowmetry`
--
ALTER TABLE `api_uroflowmetry`
  ADD CONSTRAINT `api_uroflowmetry_patient_id_573c4a1c_fk` FOREIGN KEY (`patient_id`) REFERENCES `api_patient` (`id`);

--
-- Constraints for table `authtoken_token`
--
ALTER TABLE `authtoken_token`
  ADD CONSTRAINT `authtoken_token_user_id_35299eff_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_user_id_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
