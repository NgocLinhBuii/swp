-- MySQL dump 10.13  Distrib 8.4.3, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: pls
-- ------------------------------------------------------
-- Server version	8.4.3

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `role` varchar(30) DEFAULT NULL,
  `full_name` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `sex` int DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `image_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_uk_email` (`email`),
  KEY `account_image_id_fk` (`image_id`),
  CONSTRAINT `account_image_id_fk` FOREIGN KEY (`image_id`) REFERENCES `image` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

INSERT INTO `account` VALUES (1,'parent1@example.com','$2a$10$gHFIrl9e47BBiSDoIiypauhRWkXHi2dPD5BCcWGbVVty8al1JwIN6','active','parent','Nguyen Van A',1,'1980-05-12',1),(2,'teacher1@example.com','$2a$10$gHFIrl9e47BBiSDoIiypauhRWkXHi2dPD5BCcWGbVVty8al1JwIN6','active','teacher','Tran Thi B',0,'1990-07-20',2),(3,'parent2@example.com','$2a$10$gHFIrl9e47BBiSDoIiypauhRWkXHi2dPD5BCcWGbVVty8al1JwIN6','active','parent2','Nguyen Van B',1,'1980-05-12',1),(4,'parent3@example.com','$2a$10$gHFIrl9e47BBiSDoIiypauhRWkXHi2dPD5BCcWGbVVty8al1JwIN6','active','parent3','Nguyen Van C',1,'1980-05-12',1);

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(300) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `num_questions` int DEFAULT NULL,
  `duration` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

INSERT INTO `category` VALUES (1,'Toán',20,30),(2,'Tiếng Việt',25,35);

--
-- Table structure for table `chapter`
--

DROP TABLE IF EXISTS `chapter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chapter` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(300) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `description` text,
  `subject_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `chapter_subject_id_fk` (`subject_id`),
  CONSTRAINT `chapter_subject_id_fk` FOREIGN KEY (`subject_id`) REFERENCES `subject` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chapter`
--

INSERT INTO `chapter` VALUES (1,'Chương 1: Cộng trừ','Giới thiệu cộng trừ trong phạm vi 10',1),(2,'Chương 2: Làm quen chữ cái','Học chữ cái cơ bản',2);

--
-- Table structure for table `grade`
--

DROP TABLE IF EXISTS `grade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `grade` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(300) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `description` text,
  `teacher_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `grade_account_id_fk` (`teacher_id`),
  CONSTRAINT `grade_account_id_fk` FOREIGN KEY (`teacher_id`) REFERENCES `account` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grade`
--

INSERT INTO `grade` VALUES (1,'Grade 1','Lớp 1 - Cơ bản',2),(2,'Grade 2','Lớp 2 - Nâng cao',2);

--
-- Table structure for table `image`
--

DROP TABLE IF EXISTS `image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `image` (
  `id` int NOT NULL AUTO_INCREMENT,
  `image_data` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `image`
--

INSERT INTO `image` VALUES (1,'base64_string_or_image_url_1'),(2,'base64_string_or_image_url_2'),(3,'base64_string_or_image_url_3'),(4,'base64_string_or_image_url_4'),(5,'assets/img/avatar/avatar_1749464303221.mp4');

--
-- Table structure for table `invoice`
--

DROP TABLE IF EXISTS `invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoice` (
  `id` int NOT NULL AUTO_INCREMENT,
  `total_amount` mediumtext,
  `parent_id` int DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `update_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `invoice_account_id_fk` (`parent_id`),
  CONSTRAINT `invoice_account_id_fk` FOREIGN KEY (`parent_id`) REFERENCES `account` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice`
--

INSERT INTO `invoice` VALUES (1,'500000',1,'2025-06-04 22:42:06','PAID','2025-06-04 22:42:06');

--
-- Table structure for table `invoice_line`
--

DROP TABLE IF EXISTS `invoice_line`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoice_line` (
  `invoice_id` int NOT NULL,
  `package_id` int NOT NULL,
  PRIMARY KEY (`invoice_id`,`package_id`),
  KEY `invoice_line_study_package_id_fk` (`package_id`),
  CONSTRAINT `invoice_line_invoice_id_fk` FOREIGN KEY (`invoice_id`) REFERENCES `invoice` (`id`),
  CONSTRAINT `invoice_line_study_package_id_fk` FOREIGN KEY (`package_id`) REFERENCES `study_package` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice_line`
--

INSERT INTO `invoice_line` VALUES (1,1);

--
-- Table structure for table `lesson`
--

DROP TABLE IF EXISTS `lesson`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lesson` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(300) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `content` longtext,
  `chapter_id` int DEFAULT NULL,
  `video_link` text,
  PRIMARY KEY (`id`),
  KEY `lesson_chapter_id_fk` (`chapter_id`),
  CONSTRAINT `lesson_chapter_id_fk` FOREIGN KEY (`chapter_id`) REFERENCES `chapter` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lesson`
--

INSERT INTO `lesson` VALUES (1,'Bài 1: Cộng trong phạm vi 10','Nội dung bài học...',1,NULL),(2,'Bài 2: Âm a, ă, â','Nội dung bài học...',2,NULL);

--
-- Table structure for table `package_subject`
--

DROP TABLE IF EXISTS `package_subject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `package_subject` (
  `package_id` int NOT NULL,
  `subject_id` int NOT NULL,
  PRIMARY KEY (`package_id`,`subject_id`),
  KEY `package_subject_subject_id_fk` (`subject_id`),
  CONSTRAINT `package_subject_study_package_id_fk` FOREIGN KEY (`package_id`) REFERENCES `study_package` (`id`),
  CONSTRAINT `package_subject_subject_id_fk` FOREIGN KEY (`subject_id`) REFERENCES `subject` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `package_subject`
--

INSERT INTO `package_subject` VALUES (1,1),(2,2);

--
-- Table structure for table `question`
--

DROP TABLE IF EXISTS `question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `question` (
  `id` int NOT NULL AUTO_INCREMENT,
  `question` text NOT NULL,
  `image_id` int DEFAULT NULL,
  `lesson_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `question_lesson_id_fk` (`lesson_id`),
  KEY `question_image_id_fk` (`image_id`),
  CONSTRAINT `question_image_id_fk` FOREIGN KEY (`image_id`) REFERENCES `image` (`id`),
  CONSTRAINT `question_lesson_id_fk` FOREIGN KEY (`lesson_id`) REFERENCES `lesson` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `question`
--

INSERT INTO `question` VALUES (1,'5 + (-3) = ?',NULL,1),(2,'Vận tốc là gì?',NULL,2);

--
-- Table structure for table `question_option`
--

DROP TABLE IF EXISTS `question_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `question_option` (
  `id` int NOT NULL AUTO_INCREMENT,
  `question_id` int DEFAULT NULL,
  `content` text,
  `is_correct` tinyint DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `question_option_question_id_fk` (`question_id`),
  CONSTRAINT `question_option_question_id_fk` FOREIGN KEY (`question_id`) REFERENCES `question` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `question_option`
--

INSERT INTO `question_option` VALUES (1,1,'2',1),(2,1,'-8',0),(3,2,'Độ lớn của quãng đường chia cho thời gian',1),(4,2,'Khối lượng vật',0);

--
-- Table structure for table `question_record`
--

DROP TABLE IF EXISTS `question_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `question_record` (
  `id` int NOT NULL AUTO_INCREMENT,
  `test_record_id` int DEFAULT NULL,
  `question_id` int DEFAULT NULL,
  `option_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `question_record_question_id_fk` (`question_id`),
  KEY `question_record_question_option_id_fk` (`option_id`),
  KEY `question_record_test_record_id_fk` (`test_record_id`),
  CONSTRAINT `question_record_question_id_fk` FOREIGN KEY (`question_id`) REFERENCES `question` (`id`),
  CONSTRAINT `question_record_question_option_id_fk` FOREIGN KEY (`option_id`) REFERENCES `question_option` (`id`),
  CONSTRAINT `question_record_test_record_id_fk` FOREIGN KEY (`test_record_id`) REFERENCES `test_record` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `question_record`
--


--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student` (
  `id` int NOT NULL,
  `grade_id` int NOT NULL,
  `parent_id` int NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `full_name` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `sex` bit(1) DEFAULT NULL,
  `image_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `student_pk_username` (`username`),
  KEY `student_account_id_fk_2` (`parent_id`),
  KEY `student_grade_id_fk` (`grade_id`),
  KEY `student_image_id_fk` (`image_id`),
  CONSTRAINT `student_account_id_fk` FOREIGN KEY (`parent_id`) REFERENCES `account` (`id`),
  CONSTRAINT `student_grade_id_fk` FOREIGN KEY (`grade_id`) REFERENCES `grade` (`id`),
  CONSTRAINT `student_image_id_fk` FOREIGN KEY (`image_id`) REFERENCES `image` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

INSERT INTO `student` VALUES (1,1,2,'student01','pass123','Le Van C','2010-09-01',_binary '',3),(2,2,3,'student02','pass456','Pham Thi D','2011-03-15',_binary '\0',4);

--
-- Table structure for table `study_package`
--

DROP TABLE IF EXISTS `study_package`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `study_package` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(300) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `price` mediumtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `study_package`
--

INSERT INTO `study_package` VALUES (1,'Gói học Toán 6','500000'),(2,'Gói học Vật lý 7','600000');

--
-- Table structure for table `subject`
--

DROP TABLE IF EXISTS `subject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subject` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(300) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `description` text,
  `grade_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `subject_grade_id_fk` (`grade_id`),
  CONSTRAINT `subject_grade_id_fk` FOREIGN KEY (`grade_id`) REFERENCES `grade` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subject`
--

INSERT INTO `subject` VALUES (1,'Toán nâng cao','Môn Toán nâng cao cho lớp 1',1),(2,'Tiếng Việt nâng cao','Môn Tiếng Việt nâng cao cho lớp 2',2);

--
-- Table structure for table `test`
--

DROP TABLE IF EXISTS `test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `test` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(300) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `description` text,
  `is_practice` bit(1) DEFAULT NULL,
  `category_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `test_category_id_fk` (`category_id`),
  CONSTRAINT `test_category_id_fk` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test`
--

INSERT INTO `test` VALUES (1,'Test Toán Học Cơ Bản','Bài kiểm tra về kiến thức toán học cơ bản',_binary '',1),(2,'Test Vật Lý Nâng Cao','Bài kiểm tra nâng cao về vật lý',_binary '\0',2);

--
-- Table structure for table `test_question`
--

DROP TABLE IF EXISTS `test_question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `test_question` (
  `test_id` int NOT NULL,
  `question_id` int NOT NULL,
  PRIMARY KEY (`question_id`,`test_id`),
  KEY `test_question_test_id_fk` (`test_id`),
  CONSTRAINT `test_question_question_id_fk` FOREIGN KEY (`question_id`) REFERENCES `question` (`id`),
  CONSTRAINT `test_question_test_id_fk` FOREIGN KEY (`test_id`) REFERENCES `test` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test_question`
--

INSERT INTO `test_question` VALUES (1,1),(2,2);

--
-- Table structure for table `test_record`
--

DROP TABLE IF EXISTS `test_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `test_record` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_id` int DEFAULT NULL,
  `test_id` int DEFAULT NULL,
  `started_at` datetime DEFAULT NULL,
  `finish_at` datetime DEFAULT NULL,
  `score` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `test_record_account_id_fk` (`student_id`),
  KEY `test_record_test_id_fk` (`test_id`),
  CONSTRAINT `test_record_student_id_fk` FOREIGN KEY (`student_id`) REFERENCES `student` (`id`),
  CONSTRAINT `test_record_test_id_fk` FOREIGN KEY (`test_id`) REFERENCES `test` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test_record`
--

INSERT INTO `test_record` VALUES (1,1,1,'2025-05-19 08:00:00','2025-05-19 08:30:00',8.5),(2,2,2,'2025-05-20 09:00:00','2025-05-20 09:45:00',7);
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-11 23:37:04

ALTER TABLE question
ADD COLUMN question_type VARCHAR(20) NOT NULL DEFAULT 'SINGLE';
