-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jun 07, 2018 at 03:25 PM
-- Server version: 5.7.22-0ubuntu0.16.04.1
-- PHP Version: 7.0.30-0ubuntu0.16.04.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `prod_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `dqtranslations`
--

CREATE TABLE `dqtranslations` (
  `name` varchar(255) NOT NULL,
  `language` varchar(20) NOT NULL DEFAULT '',
  `value` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `dqtranslations`
--

INSERT INTO `dqtranslations` (`name`, `language`, `value`) VALUES
('API_ButtonNo', 'cy', 'Naddo'),
('API_ButtonNo', 'en', 'No'),
('API_ButtonYes', 'cy', 'Doooo'),
('API_ButtonYes', 'en', 'Yesss'),
('API_DontShowAgain', 'en', 'don\'t show this again');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `dqtranslations`
--
ALTER TABLE `dqtranslations`
  ADD PRIMARY KEY (`name`,`language`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
