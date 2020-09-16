-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 13, 2020 at 05:03 PM
-- Server version: 10.4.13-MariaDB
-- PHP Version: 7.4.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `lara_test`
--

-- --------------------------------------------------------

--
-- Table structure for table `apps`
--

CREATE TABLE `apps` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `app_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `app_abbr` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `apps`
--

INSERT INTO `apps` (`id`, `app_name`, `app_abbr`, `created_by`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Kelton Simonis', '', 1, '2020-09-08 10:41:55', '2020-09-08 10:41:55', NULL),
(2, 'Myrtice Kirlin', '', 1, '2020-09-08 10:41:55', '2020-09-08 10:41:55', NULL),
(3, 'Dr. Abbie Hickle', '', 1, '2020-09-08 10:41:55', '2020-09-08 10:41:55', NULL),
(4, 'Santina Thiel', '', 1, '2020-09-08 10:41:55', '2020-09-08 10:41:55', NULL),
(5, 'Edwin Huel', '', 1, '2020-09-08 10:41:55', '2020-09-08 10:41:55', NULL),
(6, 'Seamus Reilly Jr.', '', 1, '2020-09-08 10:41:55', '2020-09-08 10:41:55', NULL),
(7, 'Lazaro Kiehn V', '', 1, '2020-09-08 10:41:55', '2020-09-08 10:41:55', NULL),
(8, 'Delbert Roberts', '', 1, '2020-09-08 10:41:55', '2020-09-08 10:41:55', NULL),
(9, 'Dr. Ansley Koch', '', 1, '2020-09-08 10:41:55', '2020-09-08 10:41:55', NULL),
(10, 'Tirhal', 'Tr', 1, '2020-09-08 10:41:55', '2020-09-12 16:02:18', NULL),
(11, 'category_title', '', 1, '2020-09-08 10:49:57', '2020-09-08 10:51:00', '2020-09-08 10:51:00'),
(12, 'Mashi', 'mash', 1, '2020-09-12 16:02:53', '2020-09-12 16:02:53', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `audits`
--

CREATE TABLE `audits` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `event` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `auditable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `auditable_id` bigint(20) UNSIGNED NOT NULL,
  `old_values` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `new_values` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` varchar(1023) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tags` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `audits`
--

INSERT INTO `audits` (`id`, `user_type`, `user_id`, `event`, `auditable_type`, `auditable_id`, `old_values`, `new_values`, `url`, `ip_address`, `user_agent`, `tags`, `created_at`, `updated_at`) VALUES
(1, 'App\\User', 1, 'created', 'App\\Category', 11, '[]', '{\"category_title\":\"category_title\"}', 'http://127.0.0.1:8000/api/auth/category', '127.0.0.1', 'PostmanRuntime/7.26.3', NULL, '2020-09-08 10:49:57', '2020-09-08 10:49:57'),
(2, 'App\\User', 1, 'updated', 'App\\App', 10, '{\"app_name\":\"Kennedy Morar III\"}', '{\"app_name\":\"Application Name\"}', 'http://127.0.0.1/backend/api/auth/app/update', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.83 Safari/537.36', NULL, '2020-09-09 08:18:58', '2020-09-09 08:18:58'),
(3, 'App\\User', 1, 'created', 'App\\Category', 12, '[]', '{\"category_title\":\"A\",\"category_type\":\"Driver\",\"category_priority\":\"Low\"}', 'http://127.0.0.1/backend/api/auth/category', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.83 Safari/537.36', NULL, '2020-09-09 09:02:50', '2020-09-09 09:02:50'),
(4, 'App\\User', 1, 'updated', 'App\\Category', 12, '{\"category_priority\":\"Low\"}', '{\"category_priority\":\"Medium\"}', 'http://127.0.0.1/backend/api/auth/category/update', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.83 Safari/537.36', NULL, '2020-09-09 09:05:25', '2020-09-09 09:05:25'),
(5, 'App\\User', 1, 'updated', 'App\\Category', 12, '{\"category_type\":\"Driver\"}', '{\"category_type\":\"Passenger\"}', 'http://127.0.0.1/backend/api/auth/category/update', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.83 Safari/537.36', NULL, '2020-09-09 09:05:39', '2020-09-09 09:05:39'),
(6, 'App\\User', 1, 'updated', 'App\\Category', 12, '{\"category_type\":\"Driver\"}', '{\"category_type\":\"Passenger\"}', 'http://127.0.0.1/backend/api/auth/category/update', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.83 Safari/537.36', NULL, '2020-09-09 09:35:29', '2020-09-09 09:35:29'),
(7, 'App\\User', 1, 'updated', 'App\\Category', 12, '{\"category_priority\":\"Medium\"}', '{\"category_priority\":\"High\"}', 'http://127.0.0.1/backend/api/auth/category/update', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.83 Safari/537.36', NULL, '2020-09-09 09:35:35', '2020-09-09 09:35:35'),
(8, 'App\\User', 1, 'updated', 'App\\Category', 1, '{\"category_priority\":\"High\"}', '{\"category_priority\":\"Medium\"}', 'http://127.0.0.1/backend/api/auth/category/update', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.83 Safari/537.36', NULL, '2020-09-09 09:35:46', '2020-09-09 09:35:46'),
(9, 'App\\User', 1, 'updated', 'App\\Users', 22, '{\"email\":\"hoyt30@example.com\",\"role\":null,\"group_name\":null,\"active\":null}', '{\"email\":\"hoyt30@tirhal.net\",\"role\":\"Team Leader\",\"group_name\":\"callcenter\",\"active\":true}', 'http://127.0.0.1/backend/api/auth/user/update', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.83 Safari/537.36', NULL, '2020-09-09 09:53:38', '2020-09-09 09:53:38'),
(10, 'App\\User', 1, 'updated', 'App\\Users', 21, '{\"email\":\"elvis23@example.org\",\"role\":null,\"group_name\":null}', '{\"email\":\"elvis23@example.org@tirhal.net\",\"role\":\"Agent\",\"group_name\":\"callcenter\"}', 'http://127.0.0.1/backend/api/auth/user/update', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.83 Safari/537.36', NULL, '2020-09-09 09:53:49', '2020-09-09 09:53:49'),
(11, 'App\\User', 1, 'updated', 'App\\Users', 21, '{\"email\":\"elvis23@example.org@tirhal.net\"}', '{\"email\":\"elvis23@example.org@tirhal.net@tirhal.net\"}', 'http://127.0.0.1/backend/api/auth/user/update', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.83 Safari/537.36', NULL, '2020-09-09 09:54:01', '2020-09-09 09:54:01'),
(12, 'App\\User', 1, 'created', 'App\\Filter', 13, '[]', '{\"filter_title\":\"Title Filters\",\"purpose\":\"Complaint\",\"filter_type\":\"Passenger\",\"cateory_list\":\"8,9,10,7\",\"created_by\":1}', 'http://127.0.0.1/backend/api/auth/filter', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.83 Safari/537.36', NULL, '2020-09-09 11:06:47', '2020-09-09 11:06:47'),
(13, 'App\\User', 1, 'created', 'App\\Filter', 14, '[]', '{\"filter_title\":\"kh\",\"purpose\":\"Complaint\",\"filter_type\":\"Passenger\",\"cateory_list\":\"7,8,3,1\",\"created_by\":1}', 'http://127.0.0.1/backend/api/auth/filter', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.83 Safari/537.36', NULL, '2020-09-09 11:53:09', '2020-09-09 11:53:09'),
(14, 'App\\User', 1, 'created', 'App\\Filter', 15, '[]', '{\"filter_title\":\"eeeeeeeeeeee\",\"purpose\":\"Complaint\",\"filter_type\":\"Passenger\",\"cateory_list\":\"[7,9]\",\"created_by\":1}', 'http://127.0.0.1/backend/api/auth/filter', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.83 Safari/537.36', NULL, '2020-09-09 11:59:43', '2020-09-09 11:59:43'),
(15, 'App\\User', 1, 'created', 'App\\Filter', 16, '[]', '{\"filter_title\":\"DDD\",\"purpose\":\"Complaint\",\"filter_type\":\"Passenger\",\"cateory_list\":\"8,1,2\",\"created_by\":1}', 'http://127.0.0.1/backend/api/auth/filter', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.83 Safari/537.36', NULL, '2020-09-09 12:06:47', '2020-09-09 12:06:47'),
(16, 'App\\User', 1, 'updated', 'App\\Filter', 16, '{\"cateory_list\":\"8,1,2\"}', '{\"cateory_list\":\"1,2\"}', 'http://127.0.0.1/backend/api/auth/filter/update', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.83 Safari/537.36', NULL, '2020-09-09 12:23:13', '2020-09-09 12:23:13'),
(17, 'App\\User', 1, 'updated', 'App\\Filter', 14, '{\"cateory_list\":\"7,8,3,1\"}', '{\"cateory_list\":\"8,3,1\"}', 'http://127.0.0.1/backend/api/auth/filter/update', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.83 Safari/537.36', NULL, '2020-09-09 12:23:38', '2020-09-09 12:23:38'),
(18, 'App\\User', 1, 'updated', 'App\\Filter', 14, '{\"cateory_list\":\"8,3,1\"}', '{\"cateory_list\":\"8,1\"}', 'http://127.0.0.1/backend/api/auth/filter/update', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.83 Safari/537.36', NULL, '2020-09-09 12:23:49', '2020-09-09 12:23:49'),
(19, 'App\\User', 1, 'updated', 'App\\App', 10, '{\"app_name\":\"Application Name\",\"app_abbr\":\"\"}', '{\"app_name\":\"Tirhal\",\"app_abbr\":\"tr\"}', 'http://127.0.0.1/backend/api/auth/app/update', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.102 Safari/537.36', NULL, '2020-09-12 16:00:47', '2020-09-12 16:00:47'),
(20, 'App\\User', 1, 'updated', 'App\\App', 10, '{\"app_abbr\":\"tr\"}', '{\"app_abbr\":\"Tr\"}', 'http://127.0.0.1/backend/api/auth/app/update', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.102 Safari/537.36', NULL, '2020-09-12 16:02:18', '2020-09-12 16:02:18'),
(21, 'App\\User', 1, 'created', 'App\\App', 12, '[]', '{\"app_name\":\"Mashi\",\"app_abbr\":\"mash\"}', 'http://127.0.0.1/backend/api/auth/app', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.102 Safari/537.36', NULL, '2020-09-12 16:02:53', '2020-09-12 16:02:53'),
(22, 'App\\User', 1, 'created', 'App\\Users', 24, '[]', '{\"name\":\"abbas\",\"email\":\"samer@gmail.com\",\"created_by\":1,\"password\":\"$2y$10$PqAxHaN.IZlP8HISpHi5T.HhiNvogc7XB1EIkYC22SS3fcT9rnCx.\",\"role\":\"role\",\"active\":\"0\"}', 'http://127.0.0.1/backend/api/auth/user', '127.0.0.1', 'PostmanRuntime/7.26.3', NULL, '2020-09-12 17:02:38', '2020-09-12 17:02:38');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `category_title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_type` varchar(300) COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_priority` varchar(300) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_by` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `category_title`, `category_type`, `category_priority`, `created_by`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Kelton Simonis', 'Passenger', 'Medium', 1, '2020-09-08 10:41:55', '2020-09-09 09:35:46', NULL),
(2, 'Myrtice Kirlin', '', '', 1, '2020-09-08 10:41:55', '2020-09-08 10:41:55', NULL),
(3, 'Dr. Abbie Hickle', '', '', 1, '2020-09-08 10:41:55', '2020-09-08 10:41:55', NULL),
(4, 'Santina Thiel', '', '', 1, '2020-09-08 10:41:55', '2020-09-08 10:41:55', NULL),
(5, 'Edwin Huel', '', '', 1, '2020-09-08 10:41:55', '2020-09-08 10:41:55', NULL),
(6, 'Seamus Reilly Jr.', '', '', 1, '2020-09-08 10:41:55', '2020-09-08 10:41:55', NULL),
(7, 'Lazaro Kiehn V', '', '', 1, '2020-09-08 10:41:55', '2020-09-08 10:41:55', NULL),
(8, 'Delbert Roberts', '', '', 1, '2020-09-08 10:41:55', '2020-09-08 10:41:55', NULL),
(9, 'Dr. Ansley Koch', '', '', 1, '2020-09-08 10:41:55', '2020-09-08 10:41:55', NULL),
(10, 'Kennedy Morar III', '', '', 1, '2020-09-08 10:41:55', '2020-09-08 10:41:55', NULL),
(11, 'category_title', '', '', 1, '2020-09-08 10:49:57', '2020-09-08 10:51:00', '2020-09-08 10:51:00'),
(12, 'A', 'Passenger', 'High', 1, '2020-09-09 09:02:50', '2020-09-09 09:35:35', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `filters`
--

CREATE TABLE `filters` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `filter_title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `purpose` varchar(300) COLLATE utf8mb4_unicode_ci NOT NULL,
  `filter_type` varchar(300) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cateory_list` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_by` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `filters`
--

INSERT INTO `filters` (`id`, `filter_title`, `purpose`, `filter_type`, `cateory_list`, `created_by`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Kelton Simonis', 'Passenger', 'Medium', '', 1, '2020-09-08 10:41:55', '2020-09-09 09:35:46', NULL),
(2, 'Myrtice Kirlin', '', '', '', 1, '2020-09-08 10:41:55', '2020-09-08 10:41:55', NULL),
(3, 'Dr. Abbie Hickle', '', '', '', 1, '2020-09-08 10:41:55', '2020-09-08 10:41:55', NULL),
(4, 'Santina Thiel', '', '', '', 1, '2020-09-08 10:41:55', '2020-09-08 10:41:55', NULL),
(5, 'Edwin Huel', '', '', '', 1, '2020-09-08 10:41:55', '2020-09-08 10:41:55', NULL),
(6, 'Seamus Reilly Jr.', '', '', '', 1, '2020-09-08 10:41:55', '2020-09-08 10:41:55', NULL),
(7, 'Lazaro Kiehn V', '', '', '', 1, '2020-09-08 10:41:55', '2020-09-08 10:41:55', NULL),
(8, 'Delbert Roberts', '', '', '', 1, '2020-09-08 10:41:55', '2020-09-08 10:41:55', NULL),
(9, 'Dr. Ansley Koch', '', '', '', 1, '2020-09-08 10:41:55', '2020-09-08 10:41:55', NULL),
(10, 'Kennedy Morar III', '', '', '', 1, '2020-09-08 10:41:55', '2020-09-08 10:41:55', NULL),
(11, 'category_title', '', '', '', 1, '2020-09-08 10:49:57', '2020-09-08 10:51:00', '2020-09-08 10:51:00'),
(12, 'A', 'Passenger', 'High', '', 1, '2020-09-09 09:02:50', '2020-09-09 11:10:47', '2020-09-09 11:10:47'),
(13, 'Title Filters', 'Complaint', 'Passenger', '8,9,10,7', 1, '2020-09-09 11:06:47', '2020-09-09 11:06:47', NULL),
(14, 'kh', 'Complaint', 'Passenger', '8,1', 1, '2020-09-09 11:53:09', '2020-09-09 12:23:49', NULL),
(15, 'eeeeeeeeeeee', 'Complaint', 'Passenger', '[7,9]', 1, '2020-09-09 11:59:43', '2020-09-09 12:23:56', '2020-09-09 12:23:56'),
(16, 'DDD', 'Complaint', 'Passenger', '1,2', 1, '2020-09-09 12:06:47', '2020-09-09 12:23:13', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2020_09_08_111500_create_audits_table', 2),
(5, '2020_09_08_113613_add_soft_delete_to_users_table', 3),
(6, '2020_09_08_114224_add_soft_delete_to_users_table', 4),
(7, '2020_09_08_120254_add_categories_table', 5);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `purposes`
--

CREATE TABLE `purposes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `purpose_title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_by` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `purposes`
--

INSERT INTO `purposes` (`id`, `purpose_title`, `created_by`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Kelton Simonis', 1, '2020-09-08 10:41:55', '2020-09-08 10:41:55', NULL),
(2, 'Myrtice Kirlin', 1, '2020-09-08 10:41:55', '2020-09-08 10:41:55', NULL),
(3, 'Dr. Abbie Hickle', 1, '2020-09-08 10:41:55', '2020-09-08 10:41:55', NULL),
(4, 'Santina Thiel', 1, '2020-09-08 10:41:55', '2020-09-08 10:41:55', NULL),
(5, 'Edwin Huel', 1, '2020-09-08 10:41:55', '2020-09-08 10:41:55', NULL),
(6, 'Seamus Reilly Jr.', 1, '2020-09-08 10:41:55', '2020-09-08 10:41:55', NULL),
(7, 'Lazaro Kiehn V', 1, '2020-09-08 10:41:55', '2020-09-08 10:41:55', NULL),
(8, 'Delbert Roberts', 1, '2020-09-08 10:41:55', '2020-09-08 10:41:55', NULL),
(9, 'Dr. Ansley Koch', 1, '2020-09-08 10:41:55', '2020-09-08 10:41:55', NULL),
(10, 'Kennedy Morar III', 1, '2020-09-08 10:41:55', '2020-09-08 10:41:55', NULL),
(11, 'category_title', 1, '2020-09-08 10:49:57', '2020-09-08 10:51:00', '2020-09-08 10:51:00');

-- --------------------------------------------------------

--
-- Table structure for table `tickets`
--

CREATE TABLE `tickets` (
  `id` int(11) NOT NULL,
  `ticket_no` text DEFAULT NULL,
  `status` varchar(50) NOT NULL,
  `caller_phone` text NOT NULL,
  `caller_name` text NOT NULL,
  `caller_amount` float DEFAULT NULL,
  `caller_email` text DEFAULT NULL,
  `purpose` varchar(100) DEFAULT NULL,
  `type` varchar(100) DEFAULT NULL,
  `category` int(11) DEFAULT NULL,
  `plate_no` varchar(100) DEFAULT NULL,
  `orderid` text DEFAULT NULL,
  `triprequestnumber` text DEFAULT NULL,
  `otherphone` text DEFAULT NULL,
  `content` text DEFAULT NULL,
  `created_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tickets`
--

INSERT INTO `tickets` (`id`, `ticket_no`, `status`, `caller_phone`, `caller_name`, `caller_amount`, `caller_email`, `purpose`, `type`, `category`, `plate_no`, `orderid`, `triprequestnumber`, `otherphone`, `content`, `created_time`, `created_by`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'tr123455', '', '249916582707', 'hassan ahmed', 350, 'email@gmail.com', 'complaint', 'driver', NULL, '2132', 'order123', NULL, NULL, 'content', '2020-09-13 11:26:38', NULL, '2020-09-13 05:43:53', '2020-09-13 05:43:53', NULL),
(2, 'tr123456', '', '249916582707', 'Abbas Ibrahim', 350, 'email@hotmail.com', 'complaint', 'driver', NULL, '2132', 'order456', NULL, NULL, 'content', '2020-09-13 11:26:43', NULL, '2020-09-13 05:45:18', '2020-09-13 05:45:18', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role` varchar(300) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `group_name` varchar(300) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active` int(11) DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `role`, `group_name`, `active`, `created_by`, `created_at`, `updated_at`, `deleted_at`) VALUES
(2, 'John Doe', 'demo@example.org', NULL, '$2y$10$cSLYk7O4FX36MXq/PBwDpunYhYqJBGh2xWQkTjW8ZocpRktKuW9p2', NULL, '', '', 0, 0, '2020-09-08 09:26:51', '2020-09-08 09:53:39', '2020-09-08 09:53:39'),
(3, 'Mr. Dedrick Kiehn', 'mchamplin@example.com', '2020-09-08 09:39:27', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '3IIeQSbYkW', '', '', 0, 0, '2020-09-08 09:39:27', '2020-09-08 09:39:27', NULL),
(4, 'Bernita Collins', 'rraynor@example.net', '2020-09-08 09:39:27', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'bDtIUwq3z5', '', '', 0, 0, '2020-09-08 09:39:27', '2020-09-08 09:39:27', NULL),
(5, 'Jordane Donnelly Sr.', 'germaine39@example.com', '2020-09-08 09:39:27', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'DSEj1HU0Bs', '', '', 0, 0, '2020-09-08 09:39:27', '2020-09-08 09:39:27', NULL),
(6, 'Aric Kuphal', 'santa.legros@example.org', '2020-09-08 09:39:27', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'VU2fVLfEZW', '', '', 0, 0, '2020-09-08 09:39:27', '2020-09-08 09:39:27', NULL),
(7, 'Nola Pagac', 'octavia68@example.net', '2020-09-08 09:39:27', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'sl1jU9834o', '', '', 0, 0, '2020-09-08 09:39:27', '2020-09-08 09:39:27', NULL),
(8, 'Dr. Stephen Maggio', 'uwolff@example.com', '2020-09-08 09:39:27', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'ICHMCM77oY', '', '', 0, 0, '2020-09-08 09:39:27', '2020-09-08 09:39:27', NULL),
(9, 'German Dickens', 'odare@example.net', '2020-09-08 09:39:27', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'CjTrz1ILST', '', '', 0, 0, '2020-09-08 09:39:27', '2020-09-08 09:39:27', NULL),
(10, 'Aida Bahringer', 'brielle65@example.com', '2020-09-08 09:39:27', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'eZyV1RbZTp', '', '', 0, 0, '2020-09-08 09:39:27', '2020-09-08 09:39:27', NULL),
(11, 'Mr. Chauncey West II', 'losinski@example.com', '2020-09-08 09:39:27', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'XTsAy33xUI', '', '', 0, 0, '2020-09-08 09:39:27', '2020-09-08 09:39:27', NULL),
(12, 'Marley Ziemann', 'bartell.cleora@example.com', '2020-09-08 09:39:27', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '17csbiJDDh', '', '', 0, 0, '2020-09-08 09:39:27', '2020-09-08 09:39:27', NULL),
(13, 'Cassandra Brakus', 'miller.barry@example.net', '2020-09-08 10:17:59', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'ALuwxVQVHT', NULL, NULL, NULL, 0, '2020-09-08 10:17:59', '2020-09-08 10:17:59', NULL),
(14, 'Idell Baumbach PhD', 'elissa37@example.org', '2020-09-08 10:17:59', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'q3bymF8b37', NULL, NULL, NULL, 0, '2020-09-08 10:17:59', '2020-09-08 10:17:59', NULL),
(15, 'Dr. Camron Ledner', 'demetris.dibbert@example.net', '2020-09-08 10:17:59', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'g9eXWzgeC9', NULL, NULL, NULL, 0, '2020-09-08 10:17:59', '2020-09-08 10:17:59', NULL),
(16, 'Keshawn Rice', 'armstrong.berta@example.com', '2020-09-08 10:17:59', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'tMPCqacYxU', NULL, NULL, NULL, 0, '2020-09-08 10:18:00', '2020-09-08 10:18:00', NULL),
(17, 'Ms. Mariane Predovic', 'cortiz@example.com', '2020-09-08 10:17:59', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'd1mK3lonY5', NULL, NULL, NULL, 0, '2020-09-08 10:18:00', '2020-09-08 10:18:00', NULL),
(18, 'Dr. Oral Borer', 'kgulgowski@example.net', '2020-09-08 10:17:59', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'E1aaXPeXDJ', NULL, NULL, NULL, 0, '2020-09-08 10:18:00', '2020-09-08 10:18:00', NULL),
(19, 'Deon Dickinson', 'cernser@example.net', '2020-09-08 10:17:59', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 's5TDEsRg3c', NULL, NULL, NULL, 0, '2020-09-08 10:18:00', '2020-09-08 10:18:00', NULL),
(20, 'Grayce Huels', 'lempi91@example.com', '2020-09-08 10:17:59', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'SWrGfZ1SlZ', NULL, NULL, NULL, 0, '2020-09-08 10:18:00', '2020-09-08 10:18:00', NULL),
(21, 'Prof. Lavon White V', 'elvis23@example.org@tirhal.net@tirhal.net', '2020-09-08 10:17:59', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'fxeVK2YNEI', 'Agent', 'callcenter', NULL, 0, '2020-09-08 10:18:00', '2020-09-09 09:54:01', NULL),
(22, 'Teagan Paucek', 'hoyt30@tirhal.net', '2020-09-08 10:17:59', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'gKacp1LbaG', 'Team Leader', 'callcenter', 1, 0, '2020-09-08 10:18:00', '2020-09-13 11:05:48', '2020-09-13 11:05:48'),
(24, 'abbas', 'samer@gmail.com', NULL, '$2y$10$PqAxHaN.IZlP8HISpHi5T.HhiNvogc7XB1EIkYC22SS3fcT9rnCx.', NULL, 'role', NULL, 0, 1, '2020-09-12 17:02:38', '2020-09-12 17:02:38', NULL),
(100, 'ali', 'ali@gmail.com', NULL, '$2y$10$fZqxb45kmu0GUk5iA0MBm.eFfTDFD7aZg.FFom0Z.lbbM8UED6LLG', NULL, 'agent', 'agent', 0, 0, '2020-09-08 09:06:21', '2020-09-12 20:56:19', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `apps`
--
ALTER TABLE `apps`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `audits`
--
ALTER TABLE `audits`
  ADD PRIMARY KEY (`id`),
  ADD KEY `audits_auditable_type_auditable_id_index` (`auditable_type`,`auditable_id`),
  ADD KEY `audits_user_id_user_type_index` (`user_id`,`user_type`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `filters`
--
ALTER TABLE `filters`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `purposes`
--
ALTER TABLE `purposes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tickets`
--
ALTER TABLE `tickets`
  ADD PRIMARY KEY (`id`);

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
-- AUTO_INCREMENT for table `apps`
--
ALTER TABLE `apps`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `audits`
--
ALTER TABLE `audits`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `filters`
--
ALTER TABLE `filters`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `purposes`
--
ALTER TABLE `purposes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `tickets`
--
ALTER TABLE `tickets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
