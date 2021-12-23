-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 23, 2021 at 01:58 AM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 8.0.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sulomas`
--

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

CREATE TABLE `accounts` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone_no` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `accounts`
--

INSERT INTO `accounts` (`id`, `username`, `password`, `email`, `phone_no`) VALUES
(1, 'eee', '555', 'test@test.com', '0199987763'),
(2, 'Madiha', '15de21c670ae7c3f6f3f1f37029303c9', 'madiha@test.com', '0199987723'),
(3, 'mable', '15de21c670ae7c3f6f3f1f37029303c9', 'mable@outlook.com', '0199987763'),
(4, 'kevinchang', '698d51a19d8a121ce581499d7b701668', 'kevin@istvari.com', '0199987763'),
(5, 'Test', '555', 'ggg@outlook.com', '0199987763'),
(6, 'guest', '555', 'gyuest@gg.com', '0199987763'),
(7, 'Diha', '555', 'sales@sulomas.com.my', '0199987763'),
(8, 'sulomas operator', '555', 'operator@gmail.com', '0199987763'),
(9, '222', '555', '222@gmail.com', '0199987763'),
(10, '333', '555', '333@gmail.com', '0199987763'),
(11, 'Rahim', 'dbc4d84bfcfe2284ba11beffb853a8c4', 'rahim@gmail.com', '0199987763'),
(12, 'dog', '698d51a19d8a121ce581499d7b701668', 'dog@gmail.com', '0199987763'),
(13, 'hihi', 'bf8c144140b15befb8ce662632a7b76e', 'hihi@gmail.com', '01112223788');

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `ID` int(11) NOT NULL,
  `Username` varchar(50) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `Email` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`ID`, `Username`, `Password`, `Email`) VALUES
(1, 'Madiha', '202cb962ac59075b964b07152d234b70', 'madiha@email.com'),
(2, 'eee', 'c854a6b52a6d1455169cdf56f02d02e3', '231@gmail.com'),
(3, 'admin1234', '81dc9bdb52d04dc20036dbd8313ed055', 'admin@sulomas.com'),
(4, '222', 'bcbe3365e6ac95ea2c0343a2395834dd', '222@gmail.com'),
(5, 'mable', '15de21c670ae7c3f6f3f1f37029303c9', 'mable@outlook.com');

-- --------------------------------------------------------

--
-- Table structure for table `bincollection`
--

CREATE TABLE `bincollection` (
  `ID` int(11) NOT NULL,
  `ACC_ID` int(11) NOT NULL,
  `BIN_CODE` longtext NOT NULL,
  `Address` varchar(255) NOT NULL,
  `Latitude` float(10,6) NOT NULL,
  `Longtitude` float(10,6) NOT NULL,
  `Description` varchar(255) NOT NULL,
  `DATETIME` text NOT NULL,
  `Status` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `bincollection`
--

INSERT INTO `bincollection` (`ID`, `ACC_ID`, `BIN_CODE`, `Address`, `Latitude`, `Longtitude`, `Description`, `DATETIME`, `Status`) VALUES
(1, 4, 'ISTVARI00001', 'Sulomas Sdn Bhd, Jalan Permata 1, Kawasan Perindustrian Nilai, Nilai, Negeri Sembilan, Malaysia', 2.861258, 101.815887, 'Bin is Yellow', '2021-12-23 08:53:42', 'Collected'),
(2, 4, 'ISTVARI00002', 'Pharmafood Engineering Sdn Bhd, Jalan Permata 1/6, Arab Malaysian Industrial Park, Nilai, Negeri Sembilan, Malaysia', 2.863431, 101.802856, '', '2021-12-23 08:52:00', 'Collected'),
(3, 3, 'ISTVARI00003', 'Restoran Satay Poh G, Jalan Permata, Arab Malaysian Industrial Park, Nilai, Negeri Sembilan, Malaysia', 2.866362, 101.799461, '', '2021-12-23 08:55:31', 'Collected'),
(4, 3, 'ISTVARI00004', 'Meditech Gloves Sdn. Bhd., Jalan Permata 1/3, Arab Malaysian Industrial Park, Nilai, Negeri Sembilan, Malaysia', 2.863665, 101.810265, '', '0000-00-00 00:00:00', 'Not Collected'),
(5, 4, 'ISTVARI00005', 'IGC Industrial Galv Corporation. Sdn. Bhd., Lorong Am 11, Arab Malaysian Industrial Park, Nilai, Negeri Sembilan, Malaysia', 2.864756, 101.807312, '', '0000-00-00 00:00:00', 'Not Collected'),
(6, 4, 'ISTVARI00006', 'Kian Joo Canpack Sdn. Bhd., Arab Malaysian Industrial Park, Nilai, Negeri Sembilan, Malaysia', 2.860462, 101.806145, '', '0000-00-00 00:00:00', 'Not Collected'),
(7, 0, 'ISTVARI00007', 'MK Curtain (HQ), Jalan Nilai 3/10, Kawasan Perindustrian Nilai 3, Nilai, Negeri Sembilan, Malaysia', 2.857125, 101.807022, 'Red Bin', '0000-00-00 00:00:00', 'Not Collected');

-- --------------------------------------------------------

--
-- Table structure for table `dailytask`
--

CREATE TABLE `dailytask` (
  `ID` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `BIN_CODE` longtext NOT NULL,
  `Datetime` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `dailytask`
--

INSERT INTO `dailytask` (`ID`, `username`, `BIN_CODE`, `Datetime`) VALUES
(1, 'kevinchang', 'ISTVARI00001', '2021-12-31'),
(2, 'kevinchang', 'ISTVARI00002', '2021-12-23'),
(3, 'mable', 'ISTVARI00003', '2022-01-01'),
(4, 'mable', 'ISTVARI00004', '2022-01-01'),
(5, 'kevinchang', 'ISTVARI00005', '2021-12-31'),
(6, 'kevinchang', 'ISTVARI00006', '2021-12-23');

-- --------------------------------------------------------

--
-- Table structure for table `qr_scanner`
--

CREATE TABLE `qr_scanner` (
  `ACC_ID` int(11) NOT NULL,
  `ID` int(11) NOT NULL,
  `content` longtext NOT NULL,
  `DateTime` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `qr_scanner`
--

INSERT INTO `qr_scanner` (`ACC_ID`, `ID`, `content`, `DateTime`) VALUES
(6, 1, 'Sulomas Sdn Bhd', '2021-11-19 10:44:30'),
(6, 2, 'Sulomas Sdn Bhd', '2021-11-19 10:44:40'),
(4, 3, 'http://en.m.wikipedia.org', '2021-11-19 15:19:01'),
(4, 4, 'Hello :)', '2021-11-19 15:19:15'),
(4, 5, 'https://qrco.de/bcH2zo', '2021-11-19 15:20:33'),
(4, 6, '00007', '2021-11-19 15:21:14'),
(6, 7, 'BIN0001', '2021-11-19 15:22:54'),
(6, 8, 'BIN0001', '2021-11-19 15:23:04'),
(6, 9, 'BIN0001', '2021-11-19 15:24:33'),
(4, 10, 'http://quintale.ethicalbean.com/q.php?EB101096', '2021-11-23 11:06:31'),
(6, 11, 'BIN 001', '2021-11-26 09:11:21'),
(6, 12, 'BIN 001', '2021-11-26 09:11:39'),
(6, 13, 'BIN 008', '2021-11-26 09:12:05'),
(6, 14, 'https://qrco.de/bcaNNp', '2021-11-26 09:16:05'),
(6, 15, 'https://qrco.de/bcaNNp', '2021-11-26 09:16:17'),
(6, 16, 'https://qrco.de/bcaNNp', '2021-11-26 09:16:22'),
(6, 17, 'BIN 007', '2021-11-26 09:19:46'),
(6, 18, 'BIN 007', '2021-11-26 09:20:18'),
(6, 19, '00007', '2021-11-26 15:39:29'),
(7, 20, '00007', '2021-11-26 15:43:08'),
(4, 21, 'ISTVARI00001', '2021-11-26 15:46:26'),
(4, 22, 'BIN 007', '2021-11-26 16:01:22'),
(4, 23, 'ISTVARI00001', '2021-11-26 16:02:13'),
(7, 24, 'ISTVARI00001', '2021-11-26 16:30:43'),
(6, 25, 'ISTVARI00001', '2021-11-29 14:37:29'),
(4, 26, 'Sulomas Sdn Bhd', '2021-11-29 14:46:49'),
(4, 27, 'Sulomas Sdn Bhd', '2021-11-29 14:53:30'),
(4, 28, 'Sulomas Sdn Bhd', '2021-11-29 14:53:35'),
(4, 29, 'Sulomas Sdn Bhd', '2021-11-29 14:54:36'),
(6, 30, 'ISTVARI00001', '2021-11-29 15:00:02'),
(6, 31, 'ISTVARI00001', '2021-11-29 15:04:16'),
(4, 32, 'ISTVARI00001', '2021-12-03 16:33:17'),
(4, 33, 'ISTVARI00001', '2021-12-03 16:36:07'),
(4, 34, 'ISTVARI00001', '2021-12-03 16:37:11'),
(4, 35, 'ISTVARI00001', '2021-12-03 16:39:53'),
(4, 36, 'ISTVARI00001', '2021-12-03 16:44:28'),
(4, 37, 'Hello :)', '2021-12-03 16:51:21'),
(4, 38, 'http://www.unitaglive.com', '2021-12-03 16:51:30'),
(4, 39, 'http://www.twitter.com/craig_lloyd', '2021-12-03 16:51:38'),
(4, 40, '1@i/QC6x5UAV99cYwNHoEUb1Mktmpv8Gf/v6gFlfiIcLuRyZ/n2VZxZ+44DUVDA+0HFr/azh4Mrxbp/Q==,NVzdofixtOumQOxsJ+eCJA4ZMJlQ46HMWGiwnL62DzQ=,V9uAdt4mlLNmyZUsF8tGEw==', '2021-12-03 16:52:19'),
(4, 41, 'https://www.tokai-tv.com/newsone/', '2021-12-03 16:53:38'),
(4, 42, 'http://appleinsider.com', '2021-12-03 16:56:26'),
(4, 43, 'ISTVARI00001', '2021-12-03 17:17:49'),
(4, 44, 'http://en.m.wikipedia.org', '2021-12-03 17:19:18'),
(4, 45, 'ISTVARI00001', '2021-12-06 13:50:04'),
(4, 46, 'ISTVARI00001', '2021-12-06 13:51:27'),
(4, 47, 'ISTVARI00001', '2021-12-06 13:53:06'),
(4, 48, 'ISTVARI00001', '2021-12-06 13:57:53'),
(4, 49, 'ISTVARI00001', '2021-12-06 14:05:42'),
(4, 50, 'ISTVARI00001', '2021-12-06 14:06:57'),
(4, 51, 'ISTVARI00001', '2021-12-06 14:08:30'),
(4, 52, 'ISTVARI00001', '2021-12-06 14:33:14'),
(4, 53, 'ISTVARI00001', '2021-12-06 14:34:39'),
(4, 54, 'ISTVARI00001', '2021-12-06 14:35:52'),
(4, 55, 'https://myqr.pro/5f69885602f760', '2021-12-06 14:37:44'),
(4, 56, 'ISTVARI00001', '2021-12-06 14:54:09'),
(4, 57, 'ISTVARI00001', '2021-12-06 14:55:30'),
(4, 58, 'ISTVARI00001', '2021-12-06 14:59:25'),
(4, 59, 'ISTVARI00001', '2021-12-06 15:00:29'),
(4, 60, 'ISTVARI00001', '2021-12-06 15:08:35'),
(4, 61, 'ISTVARI00001', '2021-12-06 15:10:46'),
(4, 62, 'ISTVARI00001', '2021-12-06 15:12:11'),
(4, 63, 'ISTVARI00001', '2021-12-06 15:14:03'),
(4, 64, 'ISTVARI00001', '2021-12-06 15:30:35'),
(4, 65, 'ISTVARI00001', '2021-12-06 15:33:41'),
(4, 66, 'ISTVARI00001', '2021-12-06 15:39:06'),
(4, 67, 'ISTVARI00001', '2021-12-06 15:44:25'),
(4, 68, 'ISTVARI00001', '2021-12-06 15:46:21'),
(4, 69, 'ISTVARI00001', '2021-12-06 15:47:11'),
(4, 70, 'ISTVARI00001', '2021-12-06 15:48:38'),
(4, 71, 'ISTVARI00001', '2021-12-06 15:50:05'),
(4, 72, 'ISTVARI00001', '2021-12-06 15:50:48'),
(4, 73, 'ISTVARI00001', '2021-12-06 15:50:55'),
(4, 74, 'ISTVARI00001', '2021-12-06 15:51:27'),
(4, 75, 'ISTVARI00001', '2021-12-06 15:53:56'),
(4, 76, 'ISTVARI00001', '2021-12-06 15:54:33'),
(4, 77, 'ISTVARI00001', '2021-12-06 16:03:51'),
(4, 78, 'ISTVARI00001', '2021-12-06 16:04:25'),
(4, 79, 'ISTVARI00001', '2021-12-06 16:05:19'),
(4, 80, 'ISTVARI00001', '2021-12-06 16:14:03'),
(4, 81, 'ISTVARI00001', '2021-12-06 16:15:40'),
(4, 82, 'ISTVARI00001', '2021-12-06 16:16:28'),
(4, 83, 'ISTVARI00001', '2021-12-06 16:26:10'),
(4, 84, 'ISTVARI00001', '2021-12-06 16:26:30'),
(4, 85, 'ISTVARI00001', '2021-12-06 16:28:23'),
(4, 86, 'ISTVARI00001', '2021-12-06 16:30:27'),
(4, 87, 'ISTVARI00001', '2021-12-06 16:32:21'),
(4, 88, 'ISTVARI00001', '2021-12-06 16:35:11'),
(4, 91, 'ISTVARI00001', '2021-12-06 16:55:16'),
(4, 92, 'ISTVARI00001', '2021-12-06 16:56:53'),
(4, 93, 'ISTVARI00001', '2021-12-06 16:57:51'),
(4, 94, 'ISTVARI00001', '2021-12-06 16:58:41'),
(4, 95, 'ISTVARI00001', '2021-12-06 16:59:24'),
(4, 96, 'ISTVARI00001', '2021-12-06 17:00:28'),
(4, 97, 'ISTVARI00001', '2021-12-06 17:02:05'),
(4, 98, 'ISTVARI00001', '2021-12-06 17:03:00'),
(4, 99, 'ISTVARI00001', '2021-12-06 17:03:56'),
(4, 100, 'ISTVARI00001', '2021-12-06 17:05:56'),
(4, 101, 'ISTVARI00001', '2021-12-06 17:06:30'),
(4, 102, 'ISTVARI00001', '2021-12-06 17:17:18'),
(4, 103, 'ISTVARI00001', '2021-12-06 17:18:57'),
(4, 104, 'ISTVARI00001', '2021-12-06 17:27:15'),
(4, 105, 'ISTVARI00001', '2021-12-06 17:27:46'),
(4, 106, 'ISTVARI00001', '2021-12-06 17:28:30'),
(4, 107, 'ISTVARI00001', '2021-12-06 17:28:51'),
(4, 108, 'ISTVARI00001', '2021-12-07 08:40:35'),
(4, 109, 'ISTVARI00001', '2021-12-07 08:42:00'),
(4, 110, 'ISTVARI00001', '2021-12-07 08:42:55'),
(4, 111, 'ISTVARI00001', '2021-12-07 08:43:49'),
(4, 112, 'ISTVARI00001', '2021-12-07 08:48:14'),
(4, 113, 'ISTVARI00001', '2021-12-07 08:49:08'),
(4, 114, 'ISTVARI00001', '2021-12-07 09:02:48'),
(4, 115, 'ISTVARI00001', '2021-12-07 09:06:27'),
(4, 116, 'ISTVARI00001', '2021-12-07 09:26:55'),
(4, 117, 'ISTVARI00001', '2021-12-07 09:27:40'),
(4, 118, 'https://www.kwch.com/', '2021-12-07 09:28:11'),
(4, 119, 'ISTVARI00001', '2021-12-07 09:31:20'),
(4, 120, 'ISTVARI00001', '2021-12-07 09:35:24'),
(4, 121, 'ISTVARI00001', '2021-12-07 09:36:29'),
(4, 122, 'ISTVARI00001', '2021-12-07 09:37:50'),
(4, 123, 'ISTVARI00001', '2021-12-07 09:38:21'),
(4, 124, 'http://en.m.wikipedia.org', '2021-12-07 09:38:45'),
(4, 125, 'ISTVARI00001', '2021-12-07 09:39:11'),
(4, 126, 'ISTVARI0002', '2021-12-07 09:39:44'),
(4, 127, 'ISTVARI00001', '2021-12-07 09:41:00'),
(4, 128, 'ISTVARI00001', '2021-12-07 09:42:36'),
(4, 129, 'ISTVARI0002', '2021-12-07 09:43:01'),
(4, 130, 'ISTVARI00002', '2021-12-07 09:43:20'),
(4, 131, 'https://myqr.pro/5f69885602f760', '2021-12-07 09:43:40'),
(4, 132, 'ISTVARI00001', '2021-12-07 09:43:53'),
(4, 133, 'ISTVARI00001', '2021-12-07 09:44:49'),
(4, 134, 'ISTVARI00001', '2021-12-07 09:53:50'),
(4, 135, 'ISTVARI00001', '2021-12-07 09:57:04'),
(4, 136, 'https://myqr.pro/5f69885602f760', '2021-12-07 09:58:55'),
(4, 137, 'ISTVARI00002', '2021-12-07 09:59:20'),
(4, 138, 'ISTVARI00001', '2021-12-07 09:59:43'),
(4, 139, 'ISTVARI00002', '2021-12-07 10:00:06'),
(4, 140, 'ISTVARI00001', '2021-12-07 10:00:23'),
(4, 141, 'ISTVARI00001', '2021-12-07 10:09:41'),
(4, 142, 'ISTVARI00002', '2021-12-07 10:10:04'),
(4, 143, 'https://www.kaspersky.com', '2021-12-07 10:10:25'),
(4, 144, 'ISTVARI00001', '2021-12-07 10:10:36'),
(4, 145, 'ISTVARI00001', '2021-12-07 10:12:34'),
(6, 146, 'ISTVARI00001', '2021-12-07 10:32:50'),
(4, 147, 'ISTVARI00001', '2021-12-07 11:51:02'),
(6, 148, 'ISTVARI00001', '2021-12-07 17:02:05'),
(4, 149, 'ISTVARI00001', '2021-12-07 17:06:26'),
(4, 150, 'http://www.unitaglive.com', '2021-12-08 09:33:48'),
(6, 151, 'ISTVARI00001', '2021-12-08 09:34:53'),
(4, 152, 'ISTVARI00001', '2021-12-08 09:35:35'),
(6, 153, 'ISTVARI00001', '2021-12-08 09:45:44'),
(6, 154, 'ISTVARI00001', '2021-12-08 09:45:55'),
(4, 155, 'ISTVARI00001', '2021-12-08 09:47:34'),
(4, 156, 'https://myqr.pro/5f69885602f760', '2021-12-08 09:56:33'),
(4, 157, 'http://howtogeek.com', '2021-12-09 16:01:19'),
(4, 158, 'ISTVARI00002', '2021-12-09 16:01:57'),
(4, 159, 'Hello :)', '2021-12-13 15:50:41'),
(4, 160, 'ISTVARI00005', '2021-12-13 15:52:36'),
(4, 161, 'BIN002', '2021-12-13 15:53:57'),
(6, 162, 'ISTVARI00003', '2021-12-13 15:54:45'),
(4, 163, 'BIN 007', '2021-12-13 17:04:02'),
(4, 164, 'ISTVARI00001', '2021-12-13 17:04:35'),
(4, 165, 'ISTVARI00001', '2021-12-13 17:06:23'),
(4, 166, 'ISTVARI00001', '2021-12-13 17:07:50'),
(4, 167, 'ISTVARI00001', '2021-12-13 17:12:06'),
(4, 168, 'ISTVARI00001', '2021-12-13 17:18:23'),
(4, 169, 'ISTVARI00004', '2021-12-14 08:41:07'),
(6, 170, 'ISTVARI00004', '2021-12-14 08:41:55'),
(6, 171, 'ISTVARI00002', '2021-12-14 08:42:51'),
(6, 172, 'ISTVARI00003', '2021-12-14 11:34:38'),
(4, 173, 'ISTVARI00003', '2021-12-14 11:35:41'),
(4, 174, 'ISTVARI00001', '2021-12-14 11:36:32'),
(4, 175, 'ISTVARI00002', '2021-12-14 11:36:45'),
(4, 176, 'ISTVARI00004', '2021-12-14 11:37:22'),
(4, 177, 'ISTVARI00005', '2021-12-14 11:37:30'),
(4, 178, 'BIN006', '2021-12-14 11:37:40'),
(6, 179, 'BIN006', '2021-12-14 16:43:22'),
(4, 180, 'BIN006', '2021-12-14 16:43:55'),
(4, 181, 'BIN006', '2021-12-14 16:47:40'),
(4, 182, 'ISTVARI00001', '2021-12-14 16:48:34'),
(4, 183, 'ISTVARI00002', '2021-12-14 16:49:22'),
(4, 184, 'ISTVARI00003', '2021-12-14 16:49:29'),
(4, 185, 'ISTVARI00004', '2021-12-14 16:49:34'),
(4, 186, 'ISTVARI00004', '2021-12-14 16:55:53'),
(4, 187, 'ISTVARI00001', '2021-12-14 16:56:01'),
(4, 188, 'ISTVARI00002', '2021-12-14 16:56:06'),
(4, 189, 'ISTVARI00003', '2021-12-14 16:56:12'),
(4, 190, 'ISTVARI00005', '2021-12-14 16:56:48'),
(4, 191, 'BIN006', '2021-12-14 16:56:58'),
(4, 192, 'ISTVARI00001', '2021-12-15 09:07:32'),
(4, 193, 'ISTVARI00002', '2021-12-15 09:07:37'),
(4, 194, 'ISTVARI00003', '2021-12-15 09:07:44'),
(4, 195, 'ISTVARI00004', '2021-12-15 09:07:51'),
(4, 196, 'ISTVARI00005', '2021-12-15 09:07:58'),
(4, 197, 'BIN006', '2021-12-15 09:08:08'),
(10, 198, 'ISTVARI00001', '2021-12-17 15:18:26'),
(6, 199, 'ISTVARI00001', '2021-12-17 15:19:02'),
(4, 200, 'ISTVARI00001', '2021-12-17 15:19:43'),
(4, 201, 'ISTVARI00007', '2021-12-17 16:47:15'),
(2, 202, 'ISTVARI00007', '2021-12-17 16:51:45'),
(3, 203, 'ISTVARI00007', '2021-12-17 16:52:19'),
(12, 204, 'ISTVARI00001', '2021-12-21 17:12:20'),
(4, 205, 'ISTVARI00001', '2021-12-21 17:13:48'),
(4, 206, 'ISTVARI00001', '2021-12-21 17:14:32'),
(4, 207, 'ISTVARI00002', '2021-12-21 17:15:18'),
(4, 208, 'ISTVARI00005', '2021-12-23 08:51:34'),
(4, 209, 'ISTVARI00002', '2021-12-23 08:52:00'),
(4, 210, 'ISTVARI00001', '2021-12-23 08:53:42'),
(4, 211, 'ISTVARI00003', '2021-12-23 08:54:15'),
(3, 212, 'ISTVARI00003', '2021-12-23 08:55:31');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `bincollection`
--
ALTER TABLE `bincollection`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `BIN_CODE` (`BIN_CODE`) USING HASH;

--
-- Indexes for table `dailytask`
--
ALTER TABLE `dailytask`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `qr_scanner`
--
ALTER TABLE `qr_scanner`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts`
--
ALTER TABLE `accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `bincollection`
--
ALTER TABLE `bincollection`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `dailytask`
--
ALTER TABLE `dailytask`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `qr_scanner`
--
ALTER TABLE `qr_scanner`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=213;

DELIMITER $$
--
-- Events
--
CREATE DEFINER=`root`@`localhost` EVENT `update_status` ON SCHEDULE EVERY 1 DAY STARTS '2021-12-17 00:00:00' ON COMPLETION PRESERVE ENABLE DO UPDATE bincollection SET Status = ('Not Collected')$$

DELIMITER ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
