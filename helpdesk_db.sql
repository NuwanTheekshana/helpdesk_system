-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 22, 2024 at 06:40 AM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 7.4.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `helpdesk_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `employee_id` int(11) NOT NULL,
  `office_id` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `contact_phone` varchar(15) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `job_title` varchar(50) DEFAULT NULL,
  `department` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`employee_id`, `office_id`, `name`, `contact_phone`, `email`, `start_date`, `end_date`, `job_title`, `department`) VALUES
(3, 1, 'Employee 2', '0773256652', 'employee2@gmail.com', '2024-10-03', '0000-00-00', 'Broker', 'Broker');

-- --------------------------------------------------------

--
-- Table structure for table `equipment`
--

CREATE TABLE `equipment` (
  `equipment_id` int(11) NOT NULL,
  `office_id` int(11) DEFAULT NULL,
  `serial_number` varchar(50) DEFAULT NULL,
  `equipment_type` varchar(50) DEFAULT NULL,
  `make` varchar(50) DEFAULT NULL,
  `model` varchar(50) DEFAULT NULL,
  `manufacturer` varchar(50) DEFAULT NULL,
  `warranty_expiry_date` date DEFAULT NULL,
  `software_licence_number` varchar(50) DEFAULT NULL,
  `software_type` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `equipment`
--

INSERT INTO `equipment` (`equipment_id`, `office_id`, `serial_number`, `equipment_type`, `make`, `model`, `manufacturer`, `warranty_expiry_date`, `software_licence_number`, `software_type`) VALUES
(1, 1, 'FJHJWI64FDF', 'Hardware', 'HP', 'Probook', 'HP', '2027-10-21', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `helpdesk_calls`
--

CREATE TABLE `helpdesk_calls` (
  `call_id` int(11) NOT NULL,
  `caller_id` int(11) DEFAULT NULL,
  `operator_id` int(11) DEFAULT NULL,
  `call_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `problem_description` text DEFAULT NULL,
  `equipment_id` int(11) DEFAULT NULL,
  `operating_system` varchar(50) DEFAULT NULL,
  `software_used` varchar(50) DEFAULT NULL,
  `status` enum('Open','Closed') DEFAULT 'Open'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `helpdesk_calls`
--

INSERT INTO `helpdesk_calls` (`call_id`, `caller_id`, `operator_id`, `call_time`, `problem_description`, `equipment_id`, `operating_system`, `software_used`, `status`) VALUES
(1, 3, 2, '2024-10-21 16:30:56', 'test problem', 1, 'Windows', 'Ms Office', 'Closed');

-- --------------------------------------------------------

--
-- Table structure for table `offices`
--

CREATE TABLE `offices` (
  `office_id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `contact_phone` varchar(15) DEFAULT NULL,
  `specialisation` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `offices`
--

INSERT INTO `offices` (`office_id`, `name`, `address`, `contact_phone`, `specialisation`) VALUES
(1, 'Office 1', 'Gampaha', '0117236587', 'Land Development');

-- --------------------------------------------------------

--
-- Table structure for table `problems`
--

CREATE TABLE `problems` (
  `problem_id` int(11) NOT NULL,
  `call_id` int(11) DEFAULT NULL,
  `technician_id` int(11) DEFAULT NULL,
  `problem_type` varchar(100) DEFAULT NULL,
  `assigned_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `resolution_time` timestamp NULL DEFAULT NULL,
  `resolution_description` text DEFAULT NULL,
  `time_taken` float DEFAULT NULL,
  `status` enum('Open','Resolved') DEFAULT 'Open'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `problems`
--

INSERT INTO `problems` (`problem_id`, `call_id`, `technician_id`, `problem_type`, `assigned_time`, `resolution_time`, `resolution_description`, `time_taken`, `status`) VALUES
(1, 1, 3, 'test', '2024-10-21 16:42:31', NULL, 'done', 2, 'Resolved');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('operator','technician','admin','office') NOT NULL,
  `full_name` varchar(100) DEFAULT NULL,
  `contact_phone` varchar(15) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `password`, `role`, `full_name`, `contact_phone`, `email`) VALUES
(1, 'adminuser', '$2y$10$bR7GS6wbsWDXJN0hN1h5WOJF2dfChDvwB2V8qCXZCiqOEVtWnLUzS', 'admin', 'Admin User', '0773256692', 'admin@gmail.com'),
(2, 'helpdesk_user', '$2y$10$uSj0WnO./HC7uiONOTcqLeNI8c5p23Bn7fQSa0Fl72QrrWWwR6D/u', 'operator', 'Help Desk User 1', '0771234567', 'helpdesk_1@gmail.com'),
(3, 'techuser_1', '$2y$10$1nX0D.yXdHbYOjXwhZXasOMZElPXlB3ad4xfGXe2rmm961OyeHsIK', 'technician', 'Technical User 1', '0772365879', 'techuser_1@gmail.com'),
(4, 'techuser_2', '$2y$10$tIDRSURS4oFIu9EOYmlGqOp3bn1gCxhpWbyQrTYv7Lk3q2XCACdYa', 'technician', 'Technical User 2', '0773256687', 'techuser_2@gmail.com'),
(7, 'officemanager_1', '$2y$10$9sI5hglv.j6bGhqhSm/tBODbAJkNcvAr/uH6.zRwecysEgS7EM45K', 'office', 'Office Manager 1', '0117236588', 'officemanager_1@gmail.com');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`employee_id`),
  ADD KEY `office_id` (`office_id`);

--
-- Indexes for table `equipment`
--
ALTER TABLE `equipment`
  ADD PRIMARY KEY (`equipment_id`),
  ADD KEY `office_id` (`office_id`);

--
-- Indexes for table `helpdesk_calls`
--
ALTER TABLE `helpdesk_calls`
  ADD PRIMARY KEY (`call_id`),
  ADD KEY `caller_id` (`caller_id`),
  ADD KEY `operator_id` (`operator_id`),
  ADD KEY `equipment_id` (`equipment_id`);

--
-- Indexes for table `offices`
--
ALTER TABLE `offices`
  ADD PRIMARY KEY (`office_id`);

--
-- Indexes for table `problems`
--
ALTER TABLE `problems`
  ADD PRIMARY KEY (`problem_id`),
  ADD KEY `call_id` (`call_id`),
  ADD KEY `technician_id` (`technician_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `employee_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `equipment`
--
ALTER TABLE `equipment`
  MODIFY `equipment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `helpdesk_calls`
--
ALTER TABLE `helpdesk_calls`
  MODIFY `call_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `offices`
--
ALTER TABLE `offices`
  MODIFY `office_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `problems`
--
ALTER TABLE `problems`
  MODIFY `problem_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `employees`
--
ALTER TABLE `employees`
  ADD CONSTRAINT `employees_ibfk_1` FOREIGN KEY (`office_id`) REFERENCES `offices` (`office_id`);

--
-- Constraints for table `equipment`
--
ALTER TABLE `equipment`
  ADD CONSTRAINT `equipment_ibfk_1` FOREIGN KEY (`office_id`) REFERENCES `offices` (`office_id`);

--
-- Constraints for table `helpdesk_calls`
--
ALTER TABLE `helpdesk_calls`
  ADD CONSTRAINT `helpdesk_calls_ibfk_1` FOREIGN KEY (`caller_id`) REFERENCES `employees` (`employee_id`),
  ADD CONSTRAINT `helpdesk_calls_ibfk_2` FOREIGN KEY (`operator_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `helpdesk_calls_ibfk_3` FOREIGN KEY (`equipment_id`) REFERENCES `equipment` (`equipment_id`);

--
-- Constraints for table `problems`
--
ALTER TABLE `problems`
  ADD CONSTRAINT `problems_ibfk_1` FOREIGN KEY (`call_id`) REFERENCES `helpdesk_calls` (`call_id`),
  ADD CONSTRAINT `problems_ibfk_2` FOREIGN KEY (`technician_id`) REFERENCES `users` (`user_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
