-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 07, 2026 at 05:46 PM
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
-- Database: `image_rater`
--

-- --------------------------------------------------------

--
-- Table structure for table `images`
--

CREATE TABLE `images` (
  `id` int(10) UNSIGNED NOT NULL,
  `image_name` varchar(150) NOT NULL,
  `image_path` varchar(255) NOT NULL,
  `uploaded_by` int(10) UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `images`
--

INSERT INTO `images` (`id`, `image_name`, `image_path`, `uploaded_by`, `created_at`) VALUES
(10, 'Tauquir Ahmed (1)', '20260406225341_1000023292.jpg', 16, '2026-04-06 22:53:41'),
(11, 'Tauquir Ahmed (2)', '20260406225733_1000023312.jpg', 16, '2026-04-06 22:57:33'),
(12, 'Tauquir Ahmed (3)', '20260406225744_1000023313.jpg', 16, '2026-04-06 22:57:44'),
(13, 'Tauquir Ahmed (4)', '20260406225801_1000023314.jpg', 16, '2026-04-06 22:58:01'),
(14, 'Tauquir Ahmed (5)', '20260406225816_1000023315.jpg', 16, '2026-04-06 22:58:16'),
(15, 'Mostofa Sarwar Farooki (1)', '20260406230019_1000023320.jpg', 16, '2026-04-06 23:00:19'),
(16, 'Mostofa Sarwar Farooki (2)', '20260406230031_1000023316.jpg', 16, '2026-04-06 23:00:31'),
(17, 'Mostofa Sarwar Farooki (3)', '20260406230042_1000023317.jpg', 16, '2026-04-06 23:00:42'),
(18, 'Mostofa Sarwar Farooki (4)', '20260406230116_1000023318.jpg', 16, '2026-04-06 23:01:16'),
(19, 'Mostofa Sarwar Farooki (5)', '20260406230139_1000023319.jpg', 16, '2026-04-06 23:01:39'),
(20, 'Abdur rajjak', '20260407191644_images.webp', 15, '2026-04-07 19:16:44'),
(21, 'Abdur Rajjak', '20260407191726_MV5BNzliZGYyZTctYzM1NC00ODJmLWI5NTMtMWE3Yzc5MDQ3ZjdmXkEyXkFqcGc._V1_FMjpg_UX1000_.jpg', 15, '2026-04-07 19:17:26'),
(22, 'Abdur Rajjak', '20260407191943_RazzakAbdur.jpg', 15, '2026-04-07 19:19:43'),
(23, 'Abdur Rajjak', '20260407191956_1608158915_5fda8ec38b7c7_abdur-rajjak.jpg', 15, '2026-04-07 19:19:56'),
(24, 'Abdur Rajjak', '20260407192025_1503381133.jpg', 15, '2026-04-07 19:20:25'),
(25, 'Mohiuddin Ahmad Alamgir', '20260407192142_Mohammad_Ali_Arafat_Presents_Swapnadhara_BFDA_Awards_2022-23_Dhaka_2024-05-11_PID-0008615_cropped.jpg', 15, '2026-04-07 19:21:42'),
(26, 'Mohiuddin Ahmad Alamgir', '20260407192208_DS-2---21-04-2021.jpg', 15, '2026-04-07 19:22:08'),
(27, 'Mohiuddin Ahmad Alamgir', '20260407192220_2006-10-04__cul03.jpg', 15, '2026-04-07 19:22:20'),
(28, 'Mohiuddin Ahmad Alamgir', '20260407192301_alamgir.jpg', 15, '2026-04-07 19:23:01'),
(29, 'Mohiuddin Ahmad Alamgir', '20260407192339_alamgir-1.jpg', 15, '2026-04-07 19:23:39'),
(30, 'Ilias Kanchan', '20260407192705_MV5BOWFlNmFmZDUtN2EyMS00OWYyLWE5ZTctOGUxZjI0ZmZkZmM1XkEyXkFqcGc._V1_.jpg', 15, '2026-04-07 19:27:05'),
(31, 'Ilias Kanchan', '20260407192716_mg_7622_0.jpg', 15, '2026-04-07 19:27:16'),
(32, 'Ilias Kanchan', '20260407192738_Ilias_Kanchan.png', 15, '2026-04-07 19:27:38'),
(33, 'Ilias Kanchan', '20260407192754_kanchan-champa.jpg', 15, '2026-04-07 19:27:54'),
(34, 'Ilias Kanchan', '20260407192816_MV5BMzMwMDY2YTEtOTI0Yy00Y2QzLThkY2QtZDU2MDRhM2ZmYTVhXkEyXkFqcGc._V1_.jpg', 15, '2026-04-07 19:28:16'),
(35, 'Salman Shah', '20260407193025_salman-shah-1757157035-1757159026.jpg', 15, '2026-04-07 19:30:25'),
(36, 'Salman Shah', '20260407193044_a705a46d1f2cf3428de17d3cd8567935189a73ccd23b3c35.jpg', 15, '2026-04-07 19:30:44'),
(38, 'Salman Shah', '20260407193723_379288705_640787361526663_9094119912800332675_n.jpg', 15, '2026-04-07 19:37:23'),
(39, 'Salman Shah', '20260407193910_1601318714_8.jpg', 15, '2026-04-07 19:39:10'),
(40, 'Salman Shah', '20260407194001_nhytrk-2511021307.jpg', 15, '2026-04-07 19:40:01'),
(41, 'Manna', '20260407194057_SM_Aslam_Talukder_Manna.jpg', 15, '2026-04-07 19:40:57'),
(42, 'Manna', '20260407194142_manna-1-750x416-2202170635.jpg', 15, '2026-04-07 19:41:42'),
(43, 'Manna', '20260407194220_manna.jpg', 15, '2026-04-07 19:42:20'),
(44, 'Manna', '20260407194251_manna-actor-a1097a09-33a1-4905-987a-2187faaccde-resize-750.jpg', 15, '2026-04-07 19:42:51'),
(45, 'Manna', '20260407194737_manna-obak-meme-template.webp', 15, '2026-04-07 19:47:37'),
(46, 'Shakib Khan', '20260407194805_shakib-khan-fb-050625-01-1749114777.jpg', 15, '2026-04-07 19:48:05'),
(47, 'Shakib Khan', '20260407194826_shakib_khan_case.webp', 15, '2026-04-07 19:48:26'),
(48, 'Shakib Khan', '20260407194919_pmJvt5SBS1AwJqMSx6Ix8VtdKqQ.webp', 15, '2026-04-07 19:49:19'),
(49, 'Shakib Khan', '20260407194937_inbound6192139892920636513.png', 15, '2026-04-07 19:49:37'),
(50, 'Shakib Khan', '20260407194953_channels4_profile.jpg', 15, '2026-04-07 19:49:53'),
(51, 'Ferdous Ahmed', '20260407195107_MV5BZTNmMWVkMTEtYTEwNy00ZjY4LWFjNDctMTE5NDIyZWE0ZmQ5XkEyXkFqcGc._V1_.jpg', 15, '2026-04-07 19:51:07'),
(52, 'Ferdous Ahmed', '20260407195114_ferdous-ahmed.gif', 15, '2026-04-07 19:51:14'),
(53, 'Ferdous Ahmed', '20260407195122_4244ytl7IddA1dva36I9RopC0u4.webp', 15, '2026-04-07 19:51:22'),
(54, 'Ferdous Ahmed', '20260407195137_27d144710f6747a5cff12e24bec0a7c9.jpg', 15, '2026-04-07 19:51:37'),
(55, 'Ferdous Ahmed', '20260407195154_1704712686_main-4.jpg', 15, '2026-04-07 19:51:54'),
(56, 'Riaz Uddin Ahamed Siddique', '20260407195248_Riaz-ds.jpg', 15, '2026-04-07 19:52:48'),
(57, 'Riaz Uddin Ahamed Siddique', '20260407195256_Riaz-horoscope.jpg', 15, '2026-04-07 19:52:56'),
(58, 'Riaz Uddin Ahamed Siddique', '20260407195305_riaz-actor-72e33cf7-562d-4cd4-9713-087ceb6ddbb-resize-750.jpg', 15, '2026-04-07 19:53:05'),
(59, 'Riaz Uddin Ahamed Siddique', '20260407195315_riaz-ahmed.jpg', 15, '2026-04-07 19:53:15'),
(60, 'Riaz Uddin Ahamed Siddique', '20260407195340_riaz-actor-dd5f7271-ed70-4937-bfec-7f2d7197d00-resize-750.jpg', 15, '2026-04-07 19:53:40'),
(61, 'Amin Khan', '20260407195408_AK_Khan.jpg', 15, '2026-04-07 19:54:08'),
(62, 'Amin Khan', '20260407195419_amin_khan_2.jpg', 15, '2026-04-07 19:54:19'),
(63, 'Amin Khan', '20260407195444_amin-khan-bangladeshi-actor.jpg', 15, '2026-04-07 19:54:44'),
(64, 'Amin Khan', '20260407195459_2012-06-30__art01.jpg', 15, '2026-04-07 19:54:59'),
(65, 'Amin Khan', '20260407195518_FB_IMG_1593139769070.jpg', 15, '2026-04-07 19:55:18'),
(66, 'Dipjol', '20260407195634_artworks-000339345216-2glv1f-t1080x1080.jpg', 15, '2026-04-07 19:56:34'),
(67, 'Dipjol', '20260407195641_artworks-000213573435-w4c2p4-t500x500.jpg', 15, '2026-04-07 19:56:41'),
(68, 'Dipjol', '20260407195709_dipjol-664b20d7446cd.jpg', 15, '2026-04-07 19:57:09'),
(69, 'Dipjol', '20260407195721_images.jpg', 15, '2026-04-07 19:57:21'),
(70, 'Dipjol', '20260407195739_dipjol_1.jpg', 15, '2026-04-07 19:57:39'),
(71, 'A.T.M. Shamsuzzaman', '20260407205019_screenshot-2021-02-20-104413-1613796473522.webp', 15, '2026-04-07 20:50:19'),
(72, 'A.T.M. Shamsuzzaman', '20260407205029_ATM20190506134144.jpg', 15, '2026-04-07 20:50:29'),
(73, 'A.T.M. Shamsuzzaman', '20260407205035_atm-samsujjaman.jpg', 15, '2026-04-07 20:50:35'),
(74, 'A.T.M. Shamsuzzaman', '20260407205132_atm_1_0.jpg', 15, '2026-04-07 20:51:32'),
(75, 'A.T.M. Shamsuzzaman', '20260407205148_atm_dara.jpg', 15, '2026-04-07 20:51:48'),
(76, 'Abul Hayat', '20260407205447_Dailysun-12--14-10-2021.jpg', 15, '2026-04-07 20:54:47'),
(77, 'Abul Hayat', '20260407205456_daymukti.png', 15, '2026-04-07 20:54:56'),
(78, 'Abul Hayat', '20260407205506_DS-07-09-2018-14.jpg', 15, '2026-04-07 20:55:06'),
(79, 'Abul Hayat', '20260407205648_bd-actor-abul-hayat1-20210401200304-e89e152e03a635e7c7a6bd8624969ea1.webp', 15, '2026-04-07 20:56:48'),
(80, 'Abul Hayat', '20260407205658_abul-01.jpg', 15, '2026-04-07 20:56:58');

-- --------------------------------------------------------

--
-- Table structure for table `ratings`
--

CREATE TABLE `ratings` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `image_id` int(10) UNSIGNED NOT NULL,
  `rating` tinyint(3) UNSIGNED NOT NULL CHECK (`rating` between 1 and 10),
  `rated_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(120) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` enum('admin','user') NOT NULL DEFAULT 'user',
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password_hash`, `role`, `created_at`) VALUES
(13, 'SNEHA', 'farzanasneha161@gmail.com', '$2b$12$R9CsBGdVKRB72aVhKyyKyO1XbnUmdSjynGVc4oCVf.JTa7c/Zga3a', 'admin', '2026-04-05 20:34:34'),
(15, 'raiyan10', 'raiyan772ab0@gmail.com', '$2b$12$ocJiShE4nblRQty3CXvtDuTaThgRYmz0005v4aqQ5VapK3AqyHUuK', 'admin', '2026-04-05 20:37:39'),
(16, 'AK', 'ak@gmail.com', '$2b$12$LgiQrqABS1zBWcV3Y8IFhO7blXVyEU59zCuUlhplMnNXsV0vH1ktG', 'admin', '2026-04-05 20:38:09');

-- --------------------------------------------------------

--
-- Table structure for table `user_rating_session`
--

CREATE TABLE `user_rating_session` (
  `user_id` int(10) UNSIGNED NOT NULL,
  `ratings_count` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `last_rating_time` datetime DEFAULT NULL,
  `cooldown_until` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_rating_session`
--

INSERT INTO `user_rating_session` (`user_id`, `ratings_count`, `last_rating_time`, `cooldown_until`) VALUES
(13, 0, NULL, NULL),
(15, 0, NULL, NULL),
(16, 0, NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `images`
--
ALTER TABLE `images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_images_uploader` (`uploaded_by`);

--
-- Indexes for table `ratings`
--
ALTER TABLE `ratings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_user_image` (`user_id`,`image_id`),
  ADD KEY `idx_ratings_user` (`user_id`),
  ADD KEY `idx_ratings_image` (`image_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `user_rating_session`
--
ALTER TABLE `user_rating_session`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `images`
--
ALTER TABLE `images`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;

--
-- AUTO_INCREMENT for table `ratings`
--
ALTER TABLE `ratings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `images`
--
ALTER TABLE `images`
  ADD CONSTRAINT `fk_img_user` FOREIGN KEY (`uploaded_by`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `ratings`
--
ALTER TABLE `ratings`
  ADD CONSTRAINT `fk_rat_image` FOREIGN KEY (`image_id`) REFERENCES `images` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_rat_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_rating_session`
--
ALTER TABLE `user_rating_session`
  ADD CONSTRAINT `fk_sess_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
