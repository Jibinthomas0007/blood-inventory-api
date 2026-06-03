-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 03, 2026 at 02:18 PM
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
-- Database: `blood_inventory`
--

-- --------------------------------------------------------

--
-- Table structure for table `alert_histories`
--

CREATE TABLE `alert_histories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `refrigerator_id` bigint(20) UNSIGNED NOT NULL,
  `message` varchar(255) NOT NULL,
  `recorded_temperature` decimal(5,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `alert_histories`
--

INSERT INTO `alert_histories` (`id`, `refrigerator_id`, `message`, `recorded_temperature`, `created_at`, `updated_at`) VALUES
(1, 1, 'Temperature exceeded 8°C for 10 consecutive minutes.', 8.10, '2026-06-03 06:37:13', '2026-06-03 06:37:13');

-- --------------------------------------------------------

--
-- Table structure for table `blood_bags`
--

CREATE TABLE `blood_bags` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `refrigerator_id` bigint(20) UNSIGNED NOT NULL,
  `bag_number` varchar(50) NOT NULL,
  `blood_group` varchar(10) NOT NULL,
  `donor_name` varchar(100) NOT NULL,
  `collection_date` date NOT NULL,
  `expiry_date` date NOT NULL,
  `quantity_ml` int(11) NOT NULL,
  `status` enum('Available','Reserved','Dispatched','Expired') NOT NULL DEFAULT 'Available',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `blood_bags`
--

INSERT INTO `blood_bags` (`id`, `refrigerator_id`, `bag_number`, `blood_group`, `donor_name`, `collection_date`, `expiry_date`, `quantity_ml`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 'BAG-1001', 'O+', 'John Doe', '2026-05-29', '2026-07-10', 450, 'Available', '2026-06-03 04:41:43', '2026-06-03 04:41:43'),
(2, 1, 'BAG-1002', 'A-', 'Jane Smith', '2026-04-14', '2026-05-29', 450, 'Expired', '2026-06-03 04:41:43', '2026-06-03 04:41:43'),
(3, 2, 'BAG-1003', 'B+', 'Mike Johnson', '2026-06-01', '2026-07-13', 450, 'Reserved', '2026-06-03 04:41:43', '2026-06-03 04:41:43');

-- --------------------------------------------------------

--
-- Table structure for table `blood_banks`
--

CREATE TABLE `blood_banks` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `location` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `blood_banks`
--

INSERT INTO `blood_banks` (`id`, `name`, `location`, `created_at`, `updated_at`) VALUES
(1, 'City General Blood Bank', 'Downtown Medical Wing', '2026-06-03 04:41:43', '2026-06-03 04:41:43');

-- --------------------------------------------------------

--
-- Table structure for table `blood_bank_user`
--

CREATE TABLE `blood_bank_user` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `blood_bank_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `blood_bank_user`
--

INSERT INTO `blood_bank_user` (`id`, `user_id`, `blood_bank_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, NULL, NULL),
(2, 2, 1, NULL, NULL),
(3, 3, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2026_06_03_092005_create_personal_access_tokens_table', 1),
(5, '2026_06_03_092211_create_blood_banks_table', 1),
(6, '2026_06_03_092211_create_refrigerators_table', 1),
(7, '2026_06_03_092212_create_blood_bags_table', 1),
(8, '2026_06_03_092212_create_temperature_logs_table', 1),
(9, '2026_06_03_094012_create_blood_bank_user_table', 1),
(10, '2026_06_03_113627_create_alert_histories_table', 2),
(11, '2026_06_03_115020_create_notifications_table', 3);

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` char(36) NOT NULL,
  `type` varchar(255) NOT NULL,
  `notifiable_type` varchar(255) NOT NULL,
  `notifiable_id` bigint(20) UNSIGNED NOT NULL,
  `data` text NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `type`, `notifiable_type`, `notifiable_id`, `data`, `read_at`, `created_at`, `updated_at`) VALUES
('30590bb8-2a6f-4771-bb60-8b2293455398', 'App\\Notifications\\CriticalAlertNotification', 'App\\Models\\User', 1, '{\"refrigerator_id\":1,\"message\":\"CRITICAL: Refrigerator Fridge-Alpha has been above 8\\u00b0C for 10 minutes!\"}', NULL, '2026-06-03 06:37:15', '2026-06-03 06:37:15');

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` text NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 1, 'auth_token', '19674a8bb8a5f726dd8e7c44f4f73e7070e205bddc70d06339d481790d3761ea', '[\"admin\"]', NULL, NULL, '2026-06-03 05:03:34', '2026-06-03 05:03:34'),
(2, 'App\\Models\\User', 1, 'auth_token', 'b60fbc5486b59b3f00aeb8625c1c67028d3683b70924349be139a6c233c62ef0', '[\"admin\"]', '2026-06-03 06:01:15', NULL, '2026-06-03 05:23:29', '2026-06-03 06:01:15');

-- --------------------------------------------------------

--
-- Table structure for table `refrigerators`
--

CREATE TABLE `refrigerators` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `blood_bank_id` bigint(20) UNSIGNED NOT NULL,
  `identifier` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `refrigerators`
--

INSERT INTO `refrigerators` (`id`, `blood_bank_id`, `identifier`, `created_at`, `updated_at`) VALUES
(1, 1, 'Fridge-Alpha', '2026-06-03 04:41:43', '2026-06-03 04:41:43'),
(2, 1, 'Fridge-Beta', '2026-06-03 04:41:43', '2026-06-03 04:41:43');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `temperature_logs`
--

CREATE TABLE `temperature_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `refrigerator_id` bigint(20) UNSIGNED NOT NULL,
  `temperature` decimal(5,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `temperature_logs`
--

INSERT INTO `temperature_logs` (`id`, `refrigerator_id`, `temperature`, `created_at`, `updated_at`) VALUES
(1, 1, 8.20, '2026-06-03 04:26:43', '2026-06-03 04:41:43'),
(2, 1, 6.30, '2026-06-03 04:27:43', '2026-06-03 04:41:43'),
(3, 1, 6.40, '2026-06-03 04:28:43', '2026-06-03 04:41:43'),
(4, 1, 8.30, '2026-06-03 04:29:43', '2026-06-03 04:41:43'),
(5, 1, 8.40, '2026-06-03 04:30:43', '2026-06-03 04:41:43'),
(6, 1, 7.00, '2026-06-03 04:31:43', '2026-06-03 04:41:43'),
(7, 1, 7.00, '2026-06-03 04:32:43', '2026-06-03 04:41:43'),
(8, 1, 4.40, '2026-06-03 04:33:43', '2026-06-03 04:41:43'),
(9, 1, 5.10, '2026-06-03 04:34:43', '2026-06-03 04:41:43'),
(10, 1, 7.30, '2026-06-03 04:35:43', '2026-06-03 04:41:43'),
(11, 1, 8.50, '2026-06-03 04:36:43', '2026-06-03 04:41:43'),
(12, 1, 5.20, '2026-06-03 04:37:43', '2026-06-03 04:41:43'),
(13, 1, 7.80, '2026-06-03 04:38:43', '2026-06-03 04:41:43'),
(14, 1, 8.30, '2026-06-03 04:39:43', '2026-06-03 04:41:43'),
(15, 1, 6.50, '2026-06-03 04:40:43', '2026-06-03 04:41:43'),
(16, 1, 8.50, '2026-06-03 06:37:13', '2026-06-03 06:37:13'),
(17, 1, 8.50, '2026-06-03 06:37:13', '2026-06-03 06:37:13'),
(18, 1, 8.50, '2026-06-03 06:37:13', '2026-06-03 06:37:13'),
(19, 1, 8.50, '2026-06-03 06:37:13', '2026-06-03 06:37:13'),
(20, 1, 8.50, '2026-06-03 06:37:13', '2026-06-03 06:37:13'),
(21, 1, 8.50, '2026-06-03 06:37:13', '2026-06-03 06:37:13'),
(22, 1, 8.50, '2026-06-03 06:37:13', '2026-06-03 06:37:13'),
(23, 1, 8.50, '2026-06-03 06:37:13', '2026-06-03 06:37:13'),
(24, 1, 8.50, '2026-06-03 06:37:13', '2026-06-03 06:37:13'),
(25, 1, 8.50, '2026-06-03 06:37:13', '2026-06-03 06:37:13');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `role` enum('admin','staff','monitor') NOT NULL DEFAULT 'staff',
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `role`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'Admin Manager', 'admin@example.com', NULL, '$2y$12$C.uW18RR6oVkcIy2QAQ.u.Wsak1lme4eVb/81PWF9Bz1iC8Y06H7S', NULL, '2026-06-03 04:41:43', '2026-06-03 04:41:43'),
(2, 'staff', 'Staff Member', 'staff@example.com', NULL, '$2y$12$zYzs60047V.tEomJVcyC4.HsHJM/sb5lyhF0EliKUrODZ2aV/sDK2', NULL, '2026-06-03 04:41:43', '2026-06-03 04:41:43'),
(3, 'monitor', 'System Monitor', 'monitor@example.com', NULL, '$2y$12$SkTp/.lz87hAxwPoR5rnlei2nRsc9HqVW7MBtBDlFpQmSi4lWBze6', NULL, '2026-06-03 04:41:43', '2026-06-03 04:41:43');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `alert_histories`
--
ALTER TABLE `alert_histories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `alert_histories_refrigerator_id_foreign` (`refrigerator_id`);

--
-- Indexes for table `blood_bags`
--
ALTER TABLE `blood_bags`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `blood_bags_bag_number_unique` (`bag_number`),
  ADD KEY `blood_bags_refrigerator_id_foreign` (`refrigerator_id`);

--
-- Indexes for table `blood_banks`
--
ALTER TABLE `blood_banks`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `blood_bank_user`
--
ALTER TABLE `blood_bank_user`
  ADD PRIMARY KEY (`id`),
  ADD KEY `blood_bank_user_user_id_foreign` (`user_id`),
  ADD KEY `blood_bank_user_blood_bank_id_foreign` (`blood_bank_id`);

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  ADD KEY `personal_access_tokens_expires_at_index` (`expires_at`);

--
-- Indexes for table `refrigerators`
--
ALTER TABLE `refrigerators`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `refrigerators_identifier_unique` (`identifier`),
  ADD KEY `refrigerators_blood_bank_id_foreign` (`blood_bank_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `temperature_logs`
--
ALTER TABLE `temperature_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `temperature_logs_refrigerator_id_foreign` (`refrigerator_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `alert_histories`
--
ALTER TABLE `alert_histories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `blood_bags`
--
ALTER TABLE `blood_bags`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `blood_banks`
--
ALTER TABLE `blood_banks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `blood_bank_user`
--
ALTER TABLE `blood_bank_user`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `refrigerators`
--
ALTER TABLE `refrigerators`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `temperature_logs`
--
ALTER TABLE `temperature_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `alert_histories`
--
ALTER TABLE `alert_histories`
  ADD CONSTRAINT `alert_histories_refrigerator_id_foreign` FOREIGN KEY (`refrigerator_id`) REFERENCES `refrigerators` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `blood_bags`
--
ALTER TABLE `blood_bags`
  ADD CONSTRAINT `blood_bags_refrigerator_id_foreign` FOREIGN KEY (`refrigerator_id`) REFERENCES `refrigerators` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `blood_bank_user`
--
ALTER TABLE `blood_bank_user`
  ADD CONSTRAINT `blood_bank_user_blood_bank_id_foreign` FOREIGN KEY (`blood_bank_id`) REFERENCES `blood_banks` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `blood_bank_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `refrigerators`
--
ALTER TABLE `refrigerators`
  ADD CONSTRAINT `refrigerators_blood_bank_id_foreign` FOREIGN KEY (`blood_bank_id`) REFERENCES `blood_banks` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `temperature_logs`
--
ALTER TABLE `temperature_logs`
  ADD CONSTRAINT `temperature_logs_refrigerator_id_foreign` FOREIGN KEY (`refrigerator_id`) REFERENCES `refrigerators` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
