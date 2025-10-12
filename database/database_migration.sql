-- MySQL dump 10.13  Distrib 9.4.0, for Win64 (x86_64)
--
-- Host: localhost    Database: student_analysis
-- ------------------------------------------------------
-- Server version	9.4.0

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
-- Table structure for table `comprehensive_grades`
--

DROP TABLE IF EXISTS `comprehensive_grades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comprehensive_grades` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `academic_year` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `comprehensive_score` decimal(5,2) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `final_grade` decimal(5,2) DEFAULT NULL,
  `final_score` decimal(5,2) DEFAULT NULL,
  `grade_level` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `has_makeup` bit(1) NOT NULL,
  `is_passed` bit(1) NOT NULL,
  `makeup_score` decimal(5,2) DEFAULT NULL,
  `regular_score` decimal(5,2) DEFAULT NULL,
  `remarks` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `semester` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `course_id` bigint NOT NULL,
  `student_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKc0g4t58c51dt2mxdaucfy2494` (`course_id`),
  KEY `FKq61ajcs5dlqkesjgro91lk225` (`student_id`),
  CONSTRAINT `FKc0g4t58c51dt2mxdaucfy2494` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`),
  CONSTRAINT `FKq61ajcs5dlqkesjgro91lk225` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comprehensive_grades`
--

LOCK TABLES `comprehensive_grades` WRITE;
/*!40000 ALTER TABLE `comprehensive_grades` DISABLE KEYS */;
INSERT INTO `comprehensive_grades` VALUES (1,'2023-2024',69.50,'2025-10-10 14:11:55.000000',45.50,65.00,'F',_binary '\0',_binary '\0',NULL,80.00,NULL,'2024Spring','2025-10-11 15:35:12.254768',1,1),(2,'2023-2024',79.20,'2025-10-10 14:11:55.000000',54.60,78.00,'F',_binary '\0',_binary '\0',NULL,82.00,NULL,'2024Spring','2025-10-11 15:35:12.265766',1,2),(3,'2023-2024',85.90,'2025-10-10 14:11:55.000000',59.50,85.00,'F',_binary '\0',_binary '\0',NULL,88.00,NULL,'2024Spring','2025-10-11 15:35:12.270793',1,3),(4,'2023-2024',75.90,'2025-10-10 14:11:55.000000',50.40,72.00,'F',_binary '\0',_binary '\0',NULL,85.00,NULL,'2024Spring','2025-10-11 15:35:12.278766',1,4),(5,'2023-2024',61.60,'2025-10-10 14:11:55.000000',61.60,88.00,'D',_binary '\0',_binary '',NULL,0.00,NULL,'2024Spring','2025-10-11 15:35:12.283767',1,5),(6,'2023-2024',53.20,'2025-10-10 14:11:55.000000',53.20,76.00,'F',_binary '\0',_binary '\0',NULL,0.00,NULL,'2024Spring','2025-10-11 15:35:12.289767',1,6),(7,'2023-2024',57.40,'2025-10-10 14:11:55.000000',57.40,82.00,'F',_binary '\0',_binary '\0',NULL,0.00,NULL,'2024Spring','2025-10-11 15:35:12.296769',1,7),(8,'2023-2024',48.30,'2025-10-10 14:11:55.000000',48.30,69.00,'F',_binary '\0',_binary '\0',NULL,0.00,NULL,'2024Spring','2025-10-11 15:35:12.301766',1,8),(9,'2023-2024',63.70,'2025-10-10 14:11:55.000000',63.70,91.00,'D',_binary '\0',_binary '',NULL,0.00,NULL,'2024Spring','2025-10-11 15:35:12.310766',1,9),(10,'2023-2024',51.80,'2025-10-10 14:11:55.000000',51.80,74.00,'F',_binary '\0',_binary '\0',NULL,0.00,NULL,'2024Spring','2025-10-11 15:35:12.314766',1,10),(11,'2023-2024',84.10,'2025-10-10 14:11:55.000000',61.60,88.00,'D',_binary '\0',_binary '',NULL,75.00,NULL,'2024Spring','2025-10-11 16:49:00.430639',2,1),(12,'2023-2024',89.90,'2025-10-10 14:11:55.000000',64.40,92.00,'D',_binary '\0',_binary '',NULL,85.00,NULL,'2024Spring','2025-10-11 16:49:00.441440',2,2),(13,'2023-2024',86.50,'2025-10-10 14:11:55.000000',59.50,85.00,'F',_binary '\0',_binary '\0',NULL,90.00,NULL,'2024Spring','2025-10-11 16:49:00.448435',2,3),(14,'2023-2024',78.15,'2025-10-10 14:11:55.000000',54.60,78.00,'F',_binary '\0',_binary '\0',NULL,78.50,NULL,'2024Spring','2025-10-11 16:49:00.455773',2,4),(15,'2023-2024',66.50,'2025-10-10 14:11:55.000000',66.50,95.00,'D',_binary '\0',_binary '',NULL,0.00,NULL,'2024Spring','2025-10-11 16:49:00.463434',2,5),(16,'2023-2024',41.00,'2025-10-10 14:11:55.000000',41.00,82.00,'F',_binary '\0',_binary '\0',NULL,0.00,NULL,'2024Spring','2025-10-11 16:49:00.480326',3,6),(17,'2023-2024',38.00,'2025-10-10 14:11:55.000000',38.00,76.00,'F',_binary '\0',_binary '\0',NULL,0.00,NULL,'2024Spring','2025-10-11 16:49:00.492320',3,7),(18,'2023-2024',44.50,'2025-10-10 14:11:55.000000',44.50,89.00,'F',_binary '\0',_binary '\0',NULL,0.00,NULL,'2024Spring','2025-10-11 16:49:00.499668',3,8),(19,'2023-2024',42.00,'2025-10-10 14:11:55.000000',42.00,84.00,'F',_binary '\0',_binary '\0',NULL,0.00,NULL,'2024Spring','2025-10-11 16:49:00.515071',3,9),(20,'2023-2024',45.50,'2025-10-10 14:11:55.000000',45.50,91.00,'F',_binary '\0',_binary '\0',NULL,0.00,NULL,'2024Spring','2025-10-11 16:49:00.530068',3,10),(21,'2023-2024',85.60,'2025-10-10 14:11:55.000000',68.00,85.00,'D',_binary '\0',_binary '',NULL,88.00,NULL,'2024Spring','2025-10-11 16:49:00.546894',4,1),(22,'2023-2024',80.40,'2025-10-10 14:11:55.000000',62.40,78.00,'D',_binary '\0',_binary '',NULL,90.00,NULL,'2024Spring','2025-10-11 16:49:00.558883',4,2),(23,'2023-2024',92.60,'2025-10-10 14:11:55.000000',73.60,92.00,'C',_binary '\0',_binary '',NULL,95.00,NULL,'2024Spring','2025-10-11 16:49:00.567887',4,3),(24,'2023-2024',89.20,'2025-10-10 14:11:55.000000',70.40,88.00,'C',_binary '\0',_binary '',NULL,92.00,NULL,'2024Spring','2025-10-11 16:49:00.585598',4,4),(25,'2023-2024',68.80,'2025-10-10 14:11:55.000000',68.80,86.00,'D',_binary '\0',_binary '',NULL,0.00,NULL,'2024Spring','2025-10-11 16:49:00.599734',4,5),(26,NULL,0.00,'2025-10-11 19:27:00.683454',0.00,NULL,'F',_binary '\0',_binary '\0',NULL,0.00,NULL,NULL,'2025-10-11 19:27:00.683454',1,1),(27,NULL,0.00,'2025-10-11 19:27:00.718870',0.00,NULL,'F',_binary '\0',_binary '\0',NULL,0.00,NULL,NULL,'2025-10-11 19:27:00.718870',1,2),(28,NULL,0.00,'2025-10-11 19:27:00.738580',0.00,NULL,'F',_binary '\0',_binary '\0',NULL,0.00,NULL,NULL,'2025-10-11 19:27:00.738580',1,3),(29,NULL,0.00,'2025-10-11 19:27:00.756644',0.00,NULL,'F',_binary '\0',_binary '\0',NULL,0.00,NULL,NULL,'2025-10-12 10:41:05.470110',1,4),(30,NULL,0.00,'2025-10-11 19:27:00.774637',0.00,NULL,'F',_binary '\0',_binary '\0',NULL,0.00,NULL,NULL,'2025-10-11 19:27:00.774637',1,5),(31,NULL,0.00,'2025-10-11 19:27:00.791649',0.00,NULL,'F',_binary '\0',_binary '\0',NULL,0.00,NULL,NULL,'2025-10-11 19:27:00.791649',1,6),(32,NULL,0.00,'2025-10-11 19:27:00.808304',0.00,NULL,'F',_binary '\0',_binary '\0',NULL,0.00,NULL,NULL,'2025-10-11 19:27:00.808304',1,7),(33,NULL,0.00,'2025-10-11 19:27:00.823107',0.00,NULL,'F',_binary '\0',_binary '\0',NULL,0.00,NULL,NULL,'2025-10-11 19:27:00.823107',1,8),(34,NULL,0.00,'2025-10-11 19:27:00.837311',0.00,NULL,'F',_binary '\0',_binary '\0',NULL,0.00,NULL,NULL,'2025-10-11 19:27:00.837311',1,9),(35,NULL,0.00,'2025-10-11 19:27:00.855724',0.00,NULL,'F',_binary '\0',_binary '\0',NULL,0.00,NULL,NULL,'2025-10-11 19:27:00.855724',1,10),(36,NULL,0.00,'2025-10-12 08:05:34.486246',0.00,NULL,'F',_binary '\0',_binary '\0',NULL,0.00,NULL,NULL,'2025-10-12 08:05:34.486246',3,6),(37,NULL,0.00,'2025-10-12 08:05:34.513197',0.00,NULL,'F',_binary '\0',_binary '\0',NULL,0.00,NULL,NULL,'2025-10-12 08:05:34.513197',3,7),(38,NULL,0.00,'2025-10-12 08:05:34.525198',0.00,NULL,'F',_binary '\0',_binary '\0',NULL,0.00,NULL,NULL,'2025-10-12 08:05:34.525198',3,8),(39,NULL,0.00,'2025-10-12 08:05:34.537959',0.00,NULL,'F',_binary '\0',_binary '\0',NULL,0.00,NULL,NULL,'2025-10-12 08:05:34.537959',3,9),(40,NULL,0.00,'2025-10-12 08:05:34.550845',0.00,NULL,'F',_binary '\0',_binary '\0',NULL,0.00,NULL,NULL,'2025-10-12 08:05:34.550845',3,10),(41,NULL,0.00,'2025-10-12 08:05:48.504328',0.00,NULL,'F',_binary '\0',_binary '\0',NULL,0.00,NULL,NULL,'2025-10-12 08:05:48.504328',4,1),(42,NULL,0.00,'2025-10-12 08:05:48.514895',0.00,NULL,'F',_binary '\0',_binary '\0',NULL,0.00,NULL,NULL,'2025-10-12 08:05:48.514895',4,2),(43,NULL,0.00,'2025-10-12 08:05:48.524667',0.00,NULL,'F',_binary '\0',_binary '\0',NULL,0.00,NULL,NULL,'2025-10-12 08:05:48.524667',4,3),(44,NULL,0.00,'2025-10-12 08:05:48.534801',0.00,NULL,'F',_binary '\0',_binary '\0',NULL,0.00,NULL,NULL,'2025-10-12 08:05:48.534801',4,4),(45,NULL,0.00,'2025-10-12 08:05:48.545930',0.00,NULL,'F',_binary '\0',_binary '\0',NULL,0.00,NULL,NULL,'2025-10-12 08:05:48.545930',4,5);
/*!40000 ALTER TABLE `comprehensive_grades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_enrollments`
--

DROP TABLE IF EXISTS `course_enrollments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_enrollments` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '选课ID',
  `student_id` bigint NOT NULL COMMENT '学生ID',
  `course_id` bigint NOT NULL COMMENT '课程ID',
  `enrollment_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '选课日期',
  `status` enum('ENROLLED','DROPPED','COMPLETED') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_student_course` (`student_id`,`course_id`),
  KEY `idx_student` (`student_id`),
  KEY `idx_course` (`course_id`),
  KEY `idx_status` (`status`),
  CONSTRAINT `course_enrollments_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE,
  CONSTRAINT `course_enrollments_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='选课表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_enrollments`
--

LOCK TABLES `course_enrollments` WRITE;
/*!40000 ALTER TABLE `course_enrollments` DISABLE KEYS */;
INSERT INTO `course_enrollments` VALUES (1,1,1,'2025-10-10 06:11:55','ENROLLED','2025-10-10 06:11:55','2025-10-10 06:11:55'),(2,2,1,'2025-10-10 06:11:55','ENROLLED','2025-10-10 06:11:55','2025-10-10 06:11:55'),(3,3,1,'2025-10-10 06:11:55','ENROLLED','2025-10-10 06:11:55','2025-10-10 06:11:55'),(4,4,1,'2025-10-10 06:11:55','ENROLLED','2025-10-10 06:11:55','2025-10-10 06:11:55'),(5,5,1,'2025-10-10 06:11:55','ENROLLED','2025-10-10 06:11:55','2025-10-10 06:11:55'),(6,6,1,'2025-10-10 06:11:55','ENROLLED','2025-10-10 06:11:55','2025-10-10 06:11:55'),(7,7,1,'2025-10-10 06:11:55','ENROLLED','2025-10-10 06:11:55','2025-10-10 06:11:55'),(8,8,1,'2025-10-10 06:11:55','ENROLLED','2025-10-10 06:11:55','2025-10-10 06:11:55'),(9,9,1,'2025-10-10 06:11:55','ENROLLED','2025-10-10 06:11:55','2025-10-10 06:11:55'),(10,10,1,'2025-10-10 06:11:55','ENROLLED','2025-10-10 06:11:55','2025-10-10 06:11:55'),(11,1,2,'2025-10-10 06:11:55','ENROLLED','2025-10-10 06:11:55','2025-10-10 06:11:55'),(12,2,2,'2025-10-10 06:11:55','ENROLLED','2025-10-10 06:11:55','2025-10-10 06:11:55'),(13,3,2,'2025-10-10 06:11:55','ENROLLED','2025-10-10 06:11:55','2025-10-10 06:11:55'),(14,4,2,'2025-10-10 06:11:55','ENROLLED','2025-10-10 06:11:55','2025-10-10 06:11:55'),(15,5,2,'2025-10-10 06:11:55','ENROLLED','2025-10-10 06:11:55','2025-10-10 06:11:55'),(16,6,3,'2025-10-10 06:11:55','ENROLLED','2025-10-10 06:11:55','2025-10-10 06:11:55'),(17,7,3,'2025-10-10 06:11:55','ENROLLED','2025-10-10 06:11:55','2025-10-10 06:11:55'),(18,8,3,'2025-10-10 06:11:55','ENROLLED','2025-10-10 06:11:55','2025-10-10 06:11:55'),(19,9,3,'2025-10-10 06:11:55','ENROLLED','2025-10-10 06:11:55','2025-10-10 06:11:55'),(20,10,3,'2025-10-10 06:11:55','ENROLLED','2025-10-10 06:11:55','2025-10-10 06:11:55'),(21,1,4,'2025-10-10 06:11:55','ENROLLED','2025-10-10 06:11:55','2025-10-10 06:11:55'),(22,2,4,'2025-10-10 06:11:55','ENROLLED','2025-10-10 06:11:55','2025-10-10 06:11:55'),(23,3,4,'2025-10-10 06:11:55','ENROLLED','2025-10-10 06:11:55','2025-10-10 06:11:55'),(24,4,4,'2025-10-10 06:11:55','ENROLLED','2025-10-10 06:11:55','2025-10-10 06:11:55'),(25,5,4,'2025-10-10 06:11:55','ENROLLED','2025-10-10 06:11:55','2025-10-10 06:11:55');
/*!40000 ALTER TABLE `course_enrollments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_weight_configs`
--

DROP TABLE IF EXISTS `course_weight_configs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_weight_configs` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `final_weight` decimal(5,2) NOT NULL,
  `is_active` bit(1) NOT NULL,
  `makeup_weight` decimal(5,2) DEFAULT NULL,
  `regular_weight` decimal(5,2) NOT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `course_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_74ivy0xe20ljt4jrc7xsf4x0` (`course_id`),
  CONSTRAINT `FK23ivc9ojaqq2f2xq1skl24gav` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_weight_configs`
--

LOCK TABLES `course_weight_configs` WRITE;
/*!40000 ALTER TABLE `course_weight_configs` DISABLE KEYS */;
INSERT INTO `course_weight_configs` VALUES (1,'2025-10-10 14:11:55.000000','Compiler Principles Weight Config',70.00,_binary '',100.00,30.00,'2025-10-11 18:32:48.000000',1),(2,'2025-10-10 14:11:55.000000','Data Structure Weight Config',70.00,_binary '',100.00,30.00,'2025-10-11 06:08:09.313574',2),(3,'2025-10-10 14:11:55.000000','Computer Basics Weight Config',30.00,_binary '',70.00,70.00,'2025-10-12 10:40:56.000000',3),(4,'2025-10-10 14:11:55.000000','English Weight Config',80.00,_binary '',70.00,20.00,'2025-10-10 14:11:55.000000',4);
/*!40000 ALTER TABLE `course_weight_configs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses`
--

DROP TABLE IF EXISTS `courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `courses` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '课程ID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '课程名称',
  `code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '课程编号',
  `teacher_id` bigint NOT NULL COMMENT '授课教师ID',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '课程描述',
  `credits` int NOT NULL,
  `hours` int DEFAULT NULL COMMENT '课时数',
  `semester` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '学期',
  `academic_year` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '学年',
  `capacity` int DEFAULT NULL COMMENT '容量',
  `status` enum('DRAFT','ACTIVE','COMPLETED','CANCELLED') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `max_students` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`),
  KEY `idx_code` (`code`),
  KEY `idx_teacher` (`teacher_id`),
  KEY `idx_semester` (`semester`),
  KEY `idx_status` (`status`),
  KEY `idx_name` (`name`),
  CONSTRAINT `courses_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `teachers` (`id`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='课程表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses`
--

LOCK TABLES `courses` WRITE;
/*!40000 ALTER TABLE `courses` DISABLE KEYS */;
INSERT INTO `courses` VALUES (1,'Compiler Principles','CS301',2,'Compiler Principles Course',3,48,'2024Spring','2023-2024',50,'ACTIVE','2025-10-10 06:11:55','2025-10-10 06:11:55',NULL),(2,'Data Structure','CS201',3,'Data Structure and Algorithms',4,64,'2024Spring','2023-2024',50,'ACTIVE','2025-10-10 06:11:55','2025-10-10 06:11:55',NULL),(3,'Computer Basics','CS101',2,'Computer Fundamentals',2,32,'2024Spring','2023-2024',50,'ACTIVE','2025-10-10 06:11:55','2025-10-10 06:11:55',NULL),(4,'English','EN101',2,'College English',2,32,'2024Spring','2023-2024',50,'ACTIVE','2025-10-10 06:11:55','2025-10-10 06:11:55',NULL),(5,'Operating Systems','CS401',2,'Operating Systems Course',4,NULL,'2024Spring','2023-2024',NULL,'ACTIVE','2025-10-11 03:30:20','2025-10-11 03:30:20',NULL),(6,'Computer Networks','CS402',2,'Computer Networks Course',3,NULL,'2024Spring','2023-2024',NULL,'ACTIVE','2025-10-11 03:30:20','2025-10-11 03:30:20',NULL),(7,'Database Systems','CS403',2,'Database Systems Course',4,NULL,'2024Spring','2023-2024',NULL,'ACTIVE','2025-10-11 03:30:20','2025-10-11 03:30:20',NULL),(8,'Linear Algebra','MATH201',3,'Linear Algebra Course',3,NULL,'2024Spring','2023-2024',NULL,'ACTIVE','2025-10-11 03:30:20','2025-10-11 03:30:20',NULL),(9,'English Writing','ENG101',3,'English Writing Course',2,NULL,'2024Spring','2023-2024',NULL,'ACTIVE','2025-10-11 03:30:20','2025-10-11 03:30:20',NULL),(10,'Advanced Physics','PHYS201',3,'Advanced Physics Course',4,NULL,'2024Spring','2023-2024',NULL,'ACTIVE','2025-10-11 03:30:20','2025-10-11 03:30:20',NULL);
/*!40000 ALTER TABLE `courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grade_types`
--

DROP TABLE IF EXISTS `grade_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `grade_types` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `default_weight` decimal(5,2) DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `full_score` decimal(5,2) DEFAULT NULL,
  `is_active` bit(1) NOT NULL,
  `is_final` bit(1) NOT NULL,
  `is_makeup` bit(1) NOT NULL,
  `is_regular` bit(1) NOT NULL,
  `sort_order` int DEFAULT NULL,
  `type_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_atsopn4ox5p2tdvfgl6kra9hm` (`type_code`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grade_types`
--

LOCK TABLES `grade_types` WRITE;
/*!40000 ALTER TABLE `grade_types` DISABLE KEYS */;
INSERT INTO `grade_types` VALUES (1,'2025-10-10 14:11:55.000000',20.00,NULL,100.00,_binary '',_binary '\0',_binary '\0',_binary '',1,'ATTENDANCE','Attendance','2025-10-10 14:11:55.000000'),(2,'2025-10-10 14:11:55.000000',30.00,NULL,100.00,_binary '',_binary '\0',_binary '\0',_binary '',2,'HOMEWORK','Homework','2025-10-10 14:11:55.000000'),(3,'2025-10-10 14:11:55.000000',25.00,NULL,100.00,_binary '',_binary '\0',_binary '\0',_binary '',3,'LAB','Lab Report','2025-10-10 14:11:55.000000'),(4,'2025-10-10 14:11:55.000000',25.00,NULL,100.00,_binary '',_binary '\0',_binary '\0',_binary '',4,'QUIZ','Quiz','2025-10-10 14:11:55.000000'),(5,'2025-10-10 14:11:55.000000',100.00,NULL,100.00,_binary '',_binary '',_binary '\0',_binary '\0',5,'FINAL','Final Exam','2025-10-10 14:11:55.000000'),(6,'2025-10-10 14:11:55.000000',100.00,NULL,100.00,_binary '',_binary '\0',_binary '',_binary '\0',6,'MAKEUP','Makeup Exam','2025-10-10 14:11:55.000000'),(13,'2025-10-11 16:48:56.469221',10.00,'Assignment scores',100.00,_binary '',_binary '\0',_binary '\0',_binary '',1,'ASSIGNMENT_20251011164856','Assignment','2025-10-11 16:48:56.469889'),(14,'2025-10-11 16:48:56.484146',15.00,'Test scores',100.00,_binary '',_binary '\0',_binary '\0',_binary '',1,'TEST_20251011164856','Test','2025-10-11 16:48:56.484146'),(15,'2025-10-11 16:48:56.495631',5.00,'Class attendance',100.00,_binary '',_binary '\0',_binary '\0',_binary '',1,'ATTENDANCE_20251011164856','Attendance','2025-10-11 16:48:56.495631');
/*!40000 ALTER TABLE `grade_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grades`
--

DROP TABLE IF EXISTS `grades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `grades` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '成绩ID',
  `student_id` bigint NOT NULL COMMENT '学生ID',
  `course_id` bigint NOT NULL COMMENT '课程ID',
  `exam_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '考试类型: 期中, 期末, 作业, 测验',
  `score` decimal(5,2) NOT NULL COMMENT '分数',
  `max_score` decimal(5,2) DEFAULT '100.00' COMMENT '满分',
  `percentage` decimal(5,2) DEFAULT NULL COMMENT '百分比',
  `grade_level` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '等级: A, B, C, D, F',
  `exam_date` date DEFAULT NULL COMMENT '考试日期',
  `remarks` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '备注',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `total_score` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_student` (`student_id`),
  KEY `idx_course` (`course_id`),
  KEY `idx_exam_date` (`exam_date`),
  KEY `idx_student_course` (`student_id`,`course_id`),
  KEY `idx_exam_type` (`exam_type`),
  CONSTRAINT `grades_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE,
  CONSTRAINT `grades_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='成绩表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grades`
--

LOCK TABLES `grades` WRITE;
/*!40000 ALTER TABLE `grades` DISABLE KEYS */;
INSERT INTO `grades` VALUES (1,1,1,'FINAL',65.00,100.00,65.00,'D','2024-06-15',NULL,'2025-10-10 06:11:55','2025-10-10 06:11:55',NULL),(2,2,1,'FINAL',78.00,100.00,78.00,'C+','2024-06-15',NULL,'2025-10-10 06:11:55','2025-10-10 06:11:55',NULL),(3,3,1,'FINAL',85.00,100.00,85.00,'B+','2024-06-15',NULL,'2025-10-10 06:11:55','2025-10-10 06:11:55',NULL),(4,4,1,'FINAL',72.00,100.00,72.00,'C','2024-06-15',NULL,'2025-10-10 06:11:55','2025-10-10 06:11:55',NULL),(5,5,1,'FINAL',88.00,100.00,88.00,'B+','2024-06-15',NULL,'2025-10-10 06:11:55','2025-10-10 06:11:55',NULL),(6,6,1,'FINAL',76.00,100.00,76.00,'C+','2024-06-15',NULL,'2025-10-10 06:11:55','2025-10-10 06:11:55',NULL),(7,7,1,'FINAL',82.00,100.00,82.00,'B-','2024-06-15',NULL,'2025-10-10 06:11:55','2025-10-10 06:11:55',NULL),(8,8,1,'FINAL',69.00,100.00,69.00,'D+','2024-06-15',NULL,'2025-10-10 06:11:55','2025-10-10 06:11:55',NULL),(9,9,1,'FINAL',91.00,100.00,91.00,'A-','2024-06-15',NULL,'2025-10-10 06:11:55','2025-10-10 06:11:55',NULL),(10,10,1,'FINAL',74.00,100.00,74.00,'C','2024-06-15',NULL,'2025-10-10 06:11:55','2025-10-10 06:11:55',NULL),(11,1,2,'FINAL',88.00,100.00,88.00,'B+','2024-06-15',NULL,'2025-10-10 06:11:55','2025-10-10 06:11:55',NULL),(12,2,2,'FINAL',92.00,100.00,92.00,'A-','2024-06-15',NULL,'2025-10-10 06:11:55','2025-10-10 06:11:55',NULL),(13,3,2,'FINAL',85.00,100.00,85.00,'B+','2024-06-15',NULL,'2025-10-10 06:11:55','2025-10-10 06:11:55',NULL),(14,4,2,'FINAL',78.00,100.00,78.00,'C+','2024-06-15',NULL,'2025-10-10 06:11:55','2025-10-10 06:11:55',NULL),(15,5,2,'FINAL',95.00,100.00,95.00,'A','2024-06-15',NULL,'2025-10-10 06:11:55','2025-10-10 06:11:55',NULL),(16,6,3,'FINAL',82.00,100.00,82.00,'B-','2024-06-15',NULL,'2025-10-10 06:11:55','2025-10-10 06:11:55',NULL),(17,7,3,'FINAL',76.00,100.00,76.00,'C+','2024-06-15',NULL,'2025-10-10 06:11:55','2025-10-10 06:11:55',NULL),(18,8,3,'FINAL',89.00,100.00,89.00,'B+','2024-06-15',NULL,'2025-10-10 06:11:55','2025-10-10 06:11:55',NULL),(19,9,3,'FINAL',84.00,100.00,84.00,'B','2024-06-15',NULL,'2025-10-10 06:11:55','2025-10-10 06:11:55',NULL),(20,10,3,'FINAL',91.00,100.00,91.00,'A-','2024-06-15',NULL,'2025-10-10 06:11:55','2025-10-10 06:11:55',NULL),(21,1,4,'FINAL',85.00,100.00,85.00,'B+','2024-06-15',NULL,'2025-10-10 06:11:55','2025-10-10 06:11:55',NULL),(22,2,4,'FINAL',78.00,100.00,78.00,'C+','2024-06-15',NULL,'2025-10-10 06:11:55','2025-10-10 06:11:55',NULL),(23,3,4,'FINAL',92.00,100.00,92.00,'A-','2024-06-15',NULL,'2025-10-10 06:11:55','2025-10-10 06:11:55',NULL),(24,4,4,'FINAL',88.00,100.00,88.00,'B+','2024-06-15',NULL,'2025-10-10 06:11:55','2025-10-10 06:11:55',NULL),(25,5,4,'FINAL',86.00,100.00,86.00,'B','2024-06-15',NULL,'2025-10-10 06:11:55','2025-10-10 06:11:55',NULL),(26,16,1,'FINAL',98.00,100.00,98.00,'A','2024-06-15','Perfect student','2025-10-11 03:52:19','2025-10-11 03:52:19',100.00),(27,17,1,'FINAL',95.00,100.00,95.00,'A','2024-06-15','Excellent student','2025-10-11 03:52:19','2025-10-11 03:52:19',100.00),(28,18,1,'FINAL',92.00,100.00,92.00,'A','2024-06-15',NULL,'2025-10-11 03:52:19','2025-10-11 03:52:19',100.00),(29,19,1,'FINAL',89.00,100.00,89.00,'B','2024-06-15',NULL,'2025-10-11 03:52:19','2025-10-11 03:52:19',100.00),(30,20,1,'FINAL',86.00,100.00,86.00,'B','2024-06-15',NULL,'2025-10-11 03:52:19','2025-10-11 03:52:19',100.00),(31,21,1,'FINAL',78.00,100.00,78.00,'C','2024-06-15',NULL,'2025-10-11 03:52:27','2025-10-11 03:52:27',100.00),(32,22,1,'FINAL',72.00,100.00,72.00,'C','2024-06-15',NULL,'2025-10-11 03:52:27','2025-10-11 03:52:27',100.00),(33,23,1,'FINAL',68.00,100.00,68.00,'D','2024-06-15',NULL,'2025-10-11 03:52:27','2025-10-11 03:52:27',100.00),(34,24,1,'FINAL',45.00,100.00,45.00,'F','2024-06-15','Needs makeup exam','2025-10-11 03:52:27','2025-10-11 03:52:27',100.00),(35,25,1,'FINAL',35.00,100.00,35.00,'F','2024-06-15','Severely failing','2025-10-11 03:52:27','2025-10-11 03:52:27',100.00),(36,16,2,'FINAL',100.00,100.00,100.00,'A','2024-06-20','Perfect score','2025-10-11 03:52:38','2025-10-11 03:52:38',100.00),(37,17,2,'FINAL',96.00,100.00,96.00,'A','2024-06-20','Excellent student','2025-10-11 03:52:38','2025-10-11 03:52:38',100.00),(38,18,2,'FINAL',94.00,100.00,94.00,'A','2024-06-20',NULL,'2025-10-11 03:52:38','2025-10-11 03:52:38',100.00),(39,19,2,'FINAL',91.00,100.00,91.00,'A','2024-06-20',NULL,'2025-10-11 03:52:38','2025-10-11 03:52:38',100.00),(40,20,2,'FINAL',88.00,100.00,88.00,'B','2024-06-20',NULL,'2025-10-11 03:52:38','2025-10-11 03:52:38',100.00),(41,21,2,'FINAL',79.00,100.00,79.00,'C','2024-06-20',NULL,'2025-10-11 03:52:50','2025-10-11 03:52:50',100.00),(42,22,2,'FINAL',73.00,100.00,73.00,'C','2024-06-20',NULL,'2025-10-11 03:52:50','2025-10-11 03:52:50',100.00),(43,23,2,'FINAL',69.00,100.00,69.00,'D','2024-06-20',NULL,'2025-10-11 03:52:50','2025-10-11 03:52:50',100.00),(44,24,2,'FINAL',38.00,100.00,38.00,'F','2024-06-20','Severely failing','2025-10-11 03:52:50','2025-10-11 03:52:50',100.00),(45,25,2,'FINAL',28.00,100.00,28.00,'F','2024-06-20','Extremely poor','2025-10-11 03:52:50','2025-10-11 03:52:50',100.00),(46,16,4,'FINAL',94.00,100.00,94.00,'A','2024-06-30',NULL,'2025-10-11 03:52:59','2025-10-11 03:52:59',100.00),(47,17,4,'FINAL',91.00,100.00,91.00,'A','2024-06-30',NULL,'2025-10-11 03:52:59','2025-10-11 03:52:59',100.00),(48,18,4,'FINAL',88.00,100.00,88.00,'B','2024-06-30',NULL,'2025-10-11 03:52:59','2025-10-11 03:52:59',100.00),(49,19,4,'FINAL',85.00,100.00,85.00,'B','2024-06-30',NULL,'2025-10-11 03:52:59','2025-10-11 03:52:59',100.00),(50,20,4,'FINAL',82.00,100.00,82.00,'B','2024-06-30',NULL,'2025-10-11 03:52:59','2025-10-11 03:52:59',100.00),(51,21,4,'FINAL',90.00,100.00,90.00,'A','2024-06-30',NULL,'2025-10-11 03:53:07','2025-10-11 03:53:07',100.00),(52,22,4,'FINAL',87.00,100.00,87.00,'B','2024-06-30',NULL,'2025-10-11 03:53:07','2025-10-11 03:53:07',100.00),(53,23,4,'FINAL',84.00,100.00,84.00,'B','2024-06-30',NULL,'2025-10-11 03:53:07','2025-10-11 03:53:07',100.00),(54,24,4,'FINAL',15.00,100.00,15.00,'F','2024-06-30','Extremely poor English','2025-10-11 03:53:07','2025-10-11 03:53:07',100.00),(55,25,4,'FINAL',12.00,100.00,12.00,'F','2024-06-30','Cannot speak English','2025-10-11 03:53:07','2025-10-11 03:53:07',100.00),(56,26,1,'FINAL',87.00,100.00,87.00,'B','2024-06-10',NULL,'2025-10-11 03:57:19','2025-10-11 03:57:19',100.00),(57,27,1,'FINAL',83.00,100.00,83.00,'B','2024-06-10',NULL,'2025-10-11 03:57:19','2025-10-11 03:57:19',100.00),(58,28,1,'FINAL',89.00,100.00,89.00,'B','2024-06-10',NULL,'2025-10-11 03:57:19','2025-10-11 03:57:19',100.00),(59,29,1,'FINAL',85.00,100.00,85.00,'B','2024-06-10',NULL,'2025-10-11 03:57:19','2025-10-11 03:57:19',100.00),(60,30,1,'FINAL',81.00,100.00,81.00,'B','2024-06-10',NULL,'2025-10-11 03:57:19','2025-10-11 03:57:19',100.00),(61,31,2,'FINAL',91.00,100.00,91.00,'A','2024-06-12',NULL,'2025-10-11 03:57:28','2025-10-11 03:57:28',100.00),(62,32,2,'FINAL',88.00,100.00,88.00,'B','2024-06-12',NULL,'2025-10-11 03:57:28','2025-10-11 03:57:28',100.00),(63,33,2,'FINAL',85.00,100.00,85.00,'B','2024-06-12',NULL,'2025-10-11 03:57:28','2025-10-11 03:57:28',100.00),(64,34,2,'FINAL',82.00,100.00,82.00,'B','2024-06-12',NULL,'2025-10-11 03:57:28','2025-10-11 03:57:28',100.00),(65,35,2,'FINAL',79.00,100.00,79.00,'C','2024-06-12',NULL,'2025-10-11 03:57:28','2025-10-11 03:57:28',100.00),(66,36,3,'FINAL',93.00,100.00,93.00,'A','2024-06-18',NULL,'2025-10-11 03:57:37','2025-10-11 03:57:37',100.00),(67,37,3,'FINAL',90.00,100.00,90.00,'A','2024-06-18',NULL,'2025-10-11 03:57:37','2025-10-11 03:57:37',100.00),(68,38,3,'FINAL',87.00,100.00,87.00,'B','2024-06-18',NULL,'2025-10-11 03:57:37','2025-10-11 03:57:37',100.00),(69,39,3,'FINAL',84.00,100.00,84.00,'B','2024-06-18',NULL,'2025-10-11 03:57:37','2025-10-11 03:57:37',100.00),(70,40,3,'FINAL',81.00,100.00,81.00,'B','2024-06-18',NULL,'2025-10-11 03:57:37','2025-10-11 03:57:37',100.00),(71,41,4,'FINAL',76.00,100.00,76.00,'C','2024-06-22',NULL,'2025-10-11 03:57:47','2025-10-11 03:57:47',100.00),(72,42,4,'FINAL',72.00,100.00,72.00,'C','2024-06-22',NULL,'2025-10-11 03:57:47','2025-10-11 03:57:47',100.00),(73,43,4,'FINAL',69.00,100.00,69.00,'D','2024-06-22',NULL,'2025-10-11 03:57:47','2025-10-11 03:57:47',100.00),(74,44,4,'FINAL',66.00,100.00,66.00,'D','2024-06-22',NULL,'2025-10-11 03:57:47','2025-10-11 03:57:47',100.00),(75,45,4,'FINAL',25.00,100.00,25.00,'F','2024-06-22','Very poor English','2025-10-11 03:57:47','2025-10-11 03:57:47',100.00);
/*!40000 ALTER TABLE `grades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `learning_activities`
--

DROP TABLE IF EXISTS `learning_activities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `learning_activities` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '活动ID',
  `student_id` bigint NOT NULL COMMENT '学生ID',
  `course_id` bigint DEFAULT NULL COMMENT '课程ID',
  `activity_type` enum('LOGIN','LOGOUT','VIEW_MATERIAL','DOWNLOAD_MATERIAL','SUBMIT_ASSIGNMENT','VIEW_GRADE','TAKE_EXAM','TAKE_QUIZ','WATCH_VIDEO','POST_MESSAGE','VIEW_ANNOUNCEMENT') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `activity_data` json DEFAULT NULL COMMENT '活动数据',
  `duration` int DEFAULT NULL COMMENT '持续时间(秒)',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_student` (`student_id`),
  KEY `idx_course` (`course_id`),
  KEY `idx_type` (`activity_type`),
  KEY `idx_created` (`created_at`),
  CONSTRAINT `learning_activities_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE,
  CONSTRAINT `learning_activities_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='学习活动表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `learning_activities`
--

LOCK TABLES `learning_activities` WRITE;
/*!40000 ALTER TABLE `learning_activities` DISABLE KEYS */;
INSERT INTO `learning_activities` VALUES (1,1,1,'SUBMIT_ASSIGNMENT','{\"score\": 65.0, \"max_score\": 100.0, \"assignment_name\": \"Compiler System Introduction\"}',30,'2025-10-10 06:11:55'),(2,2,1,'SUBMIT_ASSIGNMENT','{\"score\": 78.0, \"max_score\": 100.0, \"assignment_name\": \"Lexical Analysis\"}',45,'2025-10-10 06:11:55'),(3,3,1,'SUBMIT_ASSIGNMENT','{\"score\": 85.0, \"max_score\": 100.0, \"assignment_name\": \"Syntax Analysis Lab\"}',60,'2025-10-10 06:11:55'),(4,4,1,'TAKE_QUIZ','{\"score\": 72.0, \"max_score\": 100.0, \"quiz_name\": \"Lexical Analysis Quiz\"}',20,'2025-10-10 06:11:55'),(5,5,1,'SUBMIT_ASSIGNMENT','{\"score\": 88.0, \"max_score\": 100.0, \"assignment_name\": \"Syntax-Directed Translation\"}',50,'2025-10-10 06:11:55');
/*!40000 ALTER TABLE `learning_activities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `messages` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '娑堟伅ID',
  `sender_id` bigint NOT NULL COMMENT '鍙戦?鑰匢D',
  `receiver_id` bigint NOT NULL COMMENT '鎺ユ敹鑰匢D',
  `content` text NOT NULL COMMENT '娑堟伅鍐呭?',
  `message_type` varchar(20) DEFAULT 'text' COMMENT '娑堟伅绫诲瀷: text, image, file',
  `is_read` tinyint(1) DEFAULT '0' COMMENT '鏄?惁宸茶?',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '鍒涘缓鏃堕棿',
  `read_at` timestamp NULL DEFAULT NULL COMMENT '璇诲彇鏃堕棿',
  PRIMARY KEY (`id`),
  KEY `idx_sender_id` (`sender_id`),
  KEY `idx_receiver_id` (`receiver_id`),
  KEY `idx_created_at` (`created_at`),
  KEY `idx_sender_receiver` (`sender_id`,`receiver_id`),
  KEY `idx_is_read` (`is_read`),
  CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`receiver_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='娑堟伅琛';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` VALUES (1,2,1,'Please complete the Compiler System Introduction assignment on time','COURSE',0,'2025-10-10 06:11:55',NULL),(2,2,8,'Your attendance rate is low, please pay attention to course learning','WARNING',0,'2025-10-10 06:11:55',NULL),(3,2,10,'Your comprehensive score is close to the pass line, please study harder','GRADE',0,'2025-10-10 06:11:55',NULL),(4,2,1,'1111','text',0,'2025-10-11 14:28:31',NULL),(5,2,6,'111','text',0,'2025-10-11 14:28:42',NULL),(6,4,2,'11111','text',1,'2025-10-11 17:11:11','2025-10-11 21:11:32');
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '通知ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '内容',
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '类型: SYSTEM, GRADE, COURSE, ANNOUNCEMENT',
  `is_read` tinyint(1) DEFAULT '0' COMMENT '是否已读',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_user` (`user_id`),
  KEY `idx_is_read` (`is_read`),
  KEY `idx_type` (`type`),
  KEY `idx_created` (`created_at`),
  CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='通知表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
INSERT INTO `notifications` VALUES (1,5,'新成绩发布','您的数据结构期末考试成绩已发布,请查看','GRADE',0,'2025-10-05 02:24:51'),(2,5,'选课通知','下学期选课系统将于下周一开放','COURSE',0,'2025-10-05 02:24:51'),(3,5,'系统维护通知','系统将于本周六进行维护,届时无法访问','SYSTEM',1,'2025-10-05 02:24:51'),(4,6,'作业提醒','数据结构作业2即将截止,请及时提交','COURSE',0,'2025-10-05 02:24:51'),(5,7,'成绩公布','高等数学期末成绩已公布','GRADE',0,'2025-10-05 02:24:51');
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resources`
--

DROP TABLE IF EXISTS `resources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `resources` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '璧勬簮鍚嶇О',
  `original_filename` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '鍘熷?鏂囦欢鍚',
  `file_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '鏂囦欢绫诲瀷(pdf, doc, ppt, video绛?',
  `file_path` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '鏂囦欢瀛樺偍璺?緞',
  `file_size` bigint DEFAULT NULL COMMENT '鏂囦欢澶у皬(瀛楄妭)',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '璧勬簮鎻忚堪',
  `uploader_id` bigint NOT NULL COMMENT '涓婁紶鑰匢D',
  `uploader_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '涓婁紶鑰呭?鍚',
  `course_id` bigint DEFAULT NULL COMMENT '鍏宠仈璇剧▼ID',
  `category` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '璧勬簮鍒嗙被(璇句欢銆佷綔涓氥?璇曞嵎銆佺礌鏉愮瓑)',
  `download_count` int DEFAULT '0' COMMENT '涓嬭浇娆℃暟',
  `upload_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '涓婁紶鏃堕棿',
  `update_time` datetime DEFAULT NULL COMMENT '鏇存柊鏃堕棿',
  `is_active` tinyint(1) DEFAULT '1' COMMENT '鏄?惁鏈夋晥',
  PRIMARY KEY (`id`),
  KEY `idx_file_type` (`file_type`),
  KEY `idx_uploader` (`uploader_id`),
  KEY `idx_course` (`course_id`),
  KEY `idx_category` (`category`),
  KEY `idx_upload_time` (`upload_time`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='鏁欏?璧勬簮琛';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resources`
--

LOCK TABLES `resources` WRITE;
/*!40000 ALTER TABLE `resources` DISABLE KEYS */;
INSERT INTO `resources` VALUES (1,'Compiler Principles Chapter 1','compiler_chapter1.pdf','PDF','/uploads/compiler_chapter1.pdf',2048000,'Compiler System Introduction Courseware',2,'Wang Na',1,'COURSEWARE',0,'2025-10-10 14:11:55',NULL,1),(2,'Lexical Analysis Lab Guide','lexical_analysis_lab.pdf','PDF','/uploads/lexical_analysis_lab.pdf',1536000,'Lexical Analysis Lab Guide Book',2,'Wang Na',1,'LAB_GUIDE',0,'2025-10-10 14:11:55',NULL,1),(3,'Data Structure Algorithm Implementation','data_structure_code.zip','ZIP','/uploads/data_structure_code.zip',5120000,'Data Structure Algorithm Implementation Code',2,'Wang Na',2,'CODE',0,'2025-10-10 14:11:55',NULL,1),(4,'76bd1d592337549b0f35f4b6a280e347.png','76bd1d592337549b0f35f4b6a280e347.png','image','uploads\\d8344b20-a121-4559-a729-d536b99153c0.png',20069,NULL,2,'teacher1',NULL,'课件',3,'2025-10-11 22:28:18','2025-10-12 10:41:57',1);
/*!40000 ALTER TABLE `resources` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_warnings`
--

DROP TABLE IF EXISTS `student_warnings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_warnings` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `academic_year` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` datetime(6) DEFAULT NULL,
  `current_regular_score` decimal(5,2) DEFAULT NULL,
  `handle_remarks` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `handled_at` datetime(6) DEFAULT NULL,
  `handled_by` bigint DEFAULT NULL,
  `is_handled` bit(1) NOT NULL,
  `semester` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `warning_level` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `warning_threshold` decimal(5,2) DEFAULT NULL,
  `warning_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `course_id` bigint NOT NULL,
  `student_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKrnk1f0pr0aal07ky6uyjcoh0k` (`course_id`),
  KEY `FKhyn2q1wh3ca3ncbd51y9um9qy` (`student_id`),
  CONSTRAINT `FKhyn2q1wh3ca3ncbd51y9um9qy` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`),
  CONSTRAINT `FKrnk1f0pr0aal07ky6uyjcoh0k` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_warnings`
--

LOCK TABLES `student_warnings` WRITE;
/*!40000 ALTER TABLE `student_warnings` DISABLE KEYS */;
INSERT INTO `student_warnings` VALUES (1,'2023-2024','Student Shen Gang has only 65% attendance rate in Compiler Principles course, needs attention','2025-10-10 14:11:55.000000',65.00,'ok','2025-10-11 21:43:29.217074',2,_binary '','2024Spring','Low Attendance Rate','2025-10-11 21:43:29.226073','HIGH',70.00,'ATTENDANCE',1,1),(2,'2023-2024','Student Wang Qiang has only 72% regular score in Compiler Principles course, needs reminder','2025-10-10 14:11:55.000000',72.00,'ok','2025-10-11 21:43:32.058129',2,_binary '','2024Spring','Low Regular Score','2025-10-11 21:43:32.063576','MEDIUM',75.00,'REGULAR_SCORE',1,8),(3,'2023-2024','Student Chen Jing has 75.2% comprehensive score in Compiler Principles course, close to pass line','2025-10-10 14:11:55.000000',75.20,'ok','2025-10-11 21:43:33.601978',2,_binary '','2024Spring','Low Comprehensive Score','2025-10-11 21:43:33.606693','LOW',80.00,'COMPREHENSIVE',1,10),(4,'2023-2024','学生Zhang Ming在课程Computer Basics中的平时分为0.00分，严重偏低，请立即关注！','2025-10-11 20:06:43.244168',0.00,'ok','2025-10-11 21:43:34.306454',2,_binary '','2024Spring','平时分严重偏低警告','2025-10-11 21:43:34.313169','HIGH',60.00,'LOW_REGULAR_SCORE',3,6),(5,'2023-2024','学生Li Hua在课程Computer Basics中的平时分为0.00分，严重偏低，请立即关注！','2025-10-11 20:06:43.254890',0.00,'ok','2025-10-11 21:43:35.310513',2,_binary '','2024Spring','平时分严重偏低警告','2025-10-11 21:43:35.315079','HIGH',60.00,'LOW_REGULAR_SCORE',3,7),(6,'2023-2024','学生Wang Qiang在课程Computer Basics中的平时分为0.00分，严重偏低，请立即关注！','2025-10-11 20:06:43.265321',0.00,'ok','2025-10-11 21:43:37.869477',2,_binary '','2024Spring','平时分严重偏低警告','2025-10-11 21:43:37.873477','HIGH',60.00,'LOW_REGULAR_SCORE',3,8),(7,'2023-2024','学生Liu Yang在课程Computer Basics中的平时分为0.00分，严重偏低，请立即关注！','2025-10-11 20:06:43.278066',0.00,'ok','2025-10-11 21:43:39.347868',2,_binary '','2024Spring','平时分严重偏低警告','2025-10-11 21:43:39.351866','HIGH',60.00,'LOW_REGULAR_SCORE',3,9),(8,'2023-2024','学生Chen Jing在课程Computer Basics中的平时分为0.00分，严重偏低，请立即关注！','2025-10-11 20:06:43.289066',0.00,'ok','2025-10-11 21:43:40.049904',2,_binary '','2024Spring','平时分严重偏低警告','2025-10-11 21:43:40.053903','HIGH',60.00,'LOW_REGULAR_SCORE',3,10),(9,'2023-2024','学生Shen Gang在课程English中的平时分为0.00分，严重偏低，请立即关注！','2025-10-11 20:06:44.760205',0.00,'ok','2025-10-11 21:43:40.914269',2,_binary '','2024Spring','平时分严重偏低警告','2025-10-11 21:43:40.919267','HIGH',60.00,'LOW_REGULAR_SCORE',4,1),(10,'2023-2024','学生Jia Yang在课程English中的平时分为0.00分，严重偏低，请立即关注！','2025-10-11 20:06:44.773262',0.00,'ok','2025-10-11 21:43:42.695028',2,_binary '','2024Spring','平时分严重偏低警告','2025-10-11 21:43:42.700953','HIGH',60.00,'LOW_REGULAR_SCORE',4,2),(11,'2023-2024','学生Wang Yicheng在课程English中的平时分为0.00分，严重偏低，请立即关注！','2025-10-11 20:06:44.785667',0.00,'ok','2025-10-11 21:43:46.407854',2,_binary '','2024Spring','平时分严重偏低警告','2025-10-11 21:43:46.411851','HIGH',60.00,'LOW_REGULAR_SCORE',4,3),(12,'2023-2024','学生Meng Jiahao在课程English中的平时分为0.00分，严重偏低，请立即关注！','2025-10-11 20:06:44.797664',0.00,'ok','2025-10-11 21:48:15.587848',2,_binary '','2024Spring','平时分严重偏低警告','2025-10-11 21:48:15.606115','HIGH',60.00,'LOW_REGULAR_SCORE',4,4),(13,'2023-2024','学生Huang Lishuan在课程English中的平时分为0.00分，严重偏低，请立即关注！','2025-10-11 20:06:44.809181',0.00,'ok','2025-10-11 21:53:54.241491',2,_binary '','2024Spring','平时分严重偏低警告','2025-10-11 21:53:54.249029','HIGH',60.00,'LOW_REGULAR_SCORE',4,5),(14,NULL,'学生Shen Gang在课程Compiler Principles中的平时分为0.00分，严重偏低，请立即关注！','2025-10-11 21:43:14.177901',0.00,'ok','2025-10-11 21:53:55.855258',2,_binary '',NULL,'平时分严重偏低警告','2025-10-11 21:53:55.860257','HIGH',60.00,'LOW_REGULAR_SCORE',1,1),(15,NULL,'学生Jia Yang在课程Compiler Principles中的平时分为0.00分，严重偏低，请立即关注！','2025-10-11 21:43:14.289054',0.00,'ok','2025-10-11 21:53:58.335197',2,_binary '',NULL,'平时分严重偏低警告','2025-10-11 21:53:58.342786','HIGH',60.00,'LOW_REGULAR_SCORE',1,2),(16,NULL,'学生Wang Yicheng在课程Compiler Principles中的平时分为0.00分，严重偏低，请立即关注！','2025-10-11 21:43:14.397091',0.00,'ok','2025-10-11 21:53:59.681649',2,_binary '',NULL,'平时分严重偏低警告','2025-10-11 21:53:59.686649','HIGH',60.00,'LOW_REGULAR_SCORE',1,3),(17,NULL,'学生Meng Jiahao在课程Compiler Principles中的平时分为0.00分，严重偏低，请立即关注！','2025-10-11 21:43:14.510978',0.00,'ok','2025-10-11 21:54:03.840695',2,_binary '',NULL,'平时分严重偏低警告','2025-10-11 21:54:03.847694','HIGH',60.00,'LOW_REGULAR_SCORE',1,4),(18,NULL,'学生Huang Lishuan在课程Compiler Principles中的平时分为0.00分，严重偏低，请立即关注！','2025-10-11 21:43:14.621616',0.00,'ok','2025-10-11 21:54:04.776208',2,_binary '',NULL,'平时分严重偏低警告','2025-10-11 21:54:04.780207','HIGH',60.00,'LOW_REGULAR_SCORE',1,5),(19,NULL,'学生Zhang Ming在课程Compiler Principles中的平时分为0.00分，严重偏低，请立即关注！','2025-10-11 21:43:14.730556',0.00,'ok','2025-10-11 21:54:05.664413',2,_binary '',NULL,'平时分严重偏低警告','2025-10-11 21:54:05.668413','HIGH',60.00,'LOW_REGULAR_SCORE',1,6),(20,NULL,'学生Li Hua在课程Compiler Principles中的平时分为0.00分，严重偏低，请立即关注！','2025-10-11 21:43:14.837999',0.00,'ok','2025-10-11 21:54:06.515419',2,_binary '',NULL,'平时分严重偏低警告','2025-10-11 21:54:06.519418','HIGH',60.00,'LOW_REGULAR_SCORE',1,7),(21,NULL,'学生Wang Qiang在课程Compiler Principles中的平时分为0.00分，严重偏低，请立即关注！','2025-10-11 21:43:14.938354',0.00,'ok','2025-10-11 21:54:07.320273',2,_binary '',NULL,'平时分严重偏低警告','2025-10-11 21:54:07.324274','HIGH',60.00,'LOW_REGULAR_SCORE',1,8),(22,NULL,'学生Liu Yang在课程Compiler Principles中的平时分为0.00分，严重偏低，请立即关注！','2025-10-11 21:43:15.052345',0.00,'ok','2025-10-11 21:54:08.019941',2,_binary '',NULL,'平时分严重偏低警告','2025-10-11 21:54:08.023940','HIGH',60.00,'LOW_REGULAR_SCORE',1,9),(24,'2023-2024','学生Zhang Ming在课程Computer Basics中的平时分为0.00分，严重偏低，请立即关注！','2025-10-11 21:53:46.699261',0.00,'ok','2025-10-11 22:00:35.553498',2,_binary '','2024Spring','平时分严重偏低警告','2025-10-11 22:00:35.558497','HIGH',60.00,'LOW_REGULAR_SCORE',3,6),(25,'2023-2024','学生Li Hua在课程Computer Basics中的平时分为0.00分，严重偏低，请立即关注！','2025-10-11 21:53:46.785649',0.00,'ok','2025-10-11 22:00:37.069976',2,_binary '','2024Spring','平时分严重偏低警告','2025-10-11 22:00:37.074977','HIGH',60.00,'LOW_REGULAR_SCORE',3,7),(26,'2023-2024','学生Wang Qiang在课程Computer Basics中的平时分为0.00分，严重偏低，请立即关注！','2025-10-11 21:53:46.864891',0.00,'ok','2025-10-11 22:00:38.836494',2,_binary '','2024Spring','平时分严重偏低警告','2025-10-11 22:00:38.841113','HIGH',60.00,'LOW_REGULAR_SCORE',3,8),(27,'2023-2024','学生Liu Yang在课程Computer Basics中的平时分为0.00分，严重偏低，请立即关注！','2025-10-11 21:53:46.944651',0.00,'ok','2025-10-11 22:00:41.907513',2,_binary '','2024Spring','平时分严重偏低警告','2025-10-11 22:00:41.912512','HIGH',60.00,'LOW_REGULAR_SCORE',3,9),(28,'2023-2024','学生Chen Jing在课程Computer Basics中的平时分为0.00分，严重偏低，请立即关注！','2025-10-11 21:53:47.028386',0.00,'ok','2025-10-11 22:00:42.863434',2,_binary '','2024Spring','平时分严重偏低警告','2025-10-11 22:00:42.868434','HIGH',60.00,'LOW_REGULAR_SCORE',3,10),(29,'2023-2024','学生Shen Gang在课程English中的平时分为0.00分，严重偏低，请立即关注！','2025-10-11 21:53:47.181483',0.00,'ok','2025-10-11 22:00:47.066144',2,_binary '','2024Spring','平时分严重偏低警告','2025-10-11 22:00:47.071145','HIGH',60.00,'LOW_REGULAR_SCORE',4,1),(30,'2023-2024','学生Jia Yang在课程English中的平时分为0.00分，严重偏低，请立即关注！','2025-10-11 21:53:47.253354',0.00,'ok','2025-10-11 22:00:47.900567',2,_binary '','2024Spring','平时分严重偏低警告','2025-10-11 22:00:47.905566','HIGH',60.00,'LOW_REGULAR_SCORE',4,2),(31,'2023-2024','学生Wang Yicheng在课程English中的平时分为0.00分，严重偏低，请立即关注！','2025-10-11 21:53:47.327507',0.00,'ok','2025-10-11 22:00:50.173277',2,_binary '','2024Spring','平时分严重偏低警告','2025-10-11 22:00:50.177277','HIGH',60.00,'LOW_REGULAR_SCORE',4,3),(32,'2023-2024','学生Meng Jiahao在课程English中的平时分为0.00分，严重偏低，请立即关注！','2025-10-11 21:53:47.420584',0.00,'ok','2025-10-11 22:00:53.694684',2,_binary '','2024Spring','平时分严重偏低警告','2025-10-11 22:00:53.698684','HIGH',60.00,'LOW_REGULAR_SCORE',4,4),(33,NULL,'学生Shen Gang在课程Compiler Principles中的平时分为0.00分，严重偏低，请立即关注！','2025-10-11 22:14:40.122401',0.00,'ok','2025-10-11 22:14:47.858378',2,_binary '',NULL,'平时分严重偏低警告','2025-10-11 22:14:47.862469','HIGH',60.00,'LOW_REGULAR_SCORE',1,1),(34,NULL,'学生Jia Yang在课程Compiler Principles中的平时分为0.00分，严重偏低，请立即关注！','2025-10-11 22:14:40.159680',0.00,'ok','2025-10-11 22:14:49.598584',2,_binary '',NULL,'平时分严重偏低警告','2025-10-11 22:14:49.599584','HIGH',60.00,'LOW_REGULAR_SCORE',1,2),(35,NULL,'学生Wang Yicheng在课程Compiler Principles中的平时分为0.00分，严重偏低，请立即关注！','2025-10-11 22:14:40.181173',0.00,'ok','2025-10-11 22:14:51.423721',2,_binary '',NULL,'平时分严重偏低警告','2025-10-11 22:14:51.424718','HIGH',60.00,'LOW_REGULAR_SCORE',1,3),(36,NULL,'学生Meng Jiahao在课程Compiler Principles中的平时分为0.00分，严重偏低，请立即关注！','2025-10-11 22:14:40.202172',0.00,'ok','2025-10-11 22:15:02.578748',2,_binary '',NULL,'平时分严重偏低警告','2025-10-11 22:15:02.579748','HIGH',60.00,'LOW_REGULAR_SCORE',1,4),(37,NULL,'学生Huang Lishuan在课程Compiler Principles中的平时分为0.00分，严重偏低，请立即关注！','2025-10-11 22:14:40.224636',0.00,'ok','2025-10-11 22:15:03.480773',2,_binary '',NULL,'平时分严重偏低警告','2025-10-11 22:15:03.481772','HIGH',60.00,'LOW_REGULAR_SCORE',1,5),(38,NULL,'学生Zhang Ming在课程Compiler Principles中的平时分为0.00分，严重偏低，请立即关注！','2025-10-11 22:14:40.247749',0.00,'ok','2025-10-11 22:15:04.249496',2,_binary '',NULL,'平时分严重偏低警告','2025-10-11 22:15:04.250495','HIGH',60.00,'LOW_REGULAR_SCORE',1,6),(39,NULL,'学生Li Hua在课程Compiler Principles中的平时分为0.00分，严重偏低，请立即关注！','2025-10-11 22:14:40.268749',0.00,'ok','2025-10-11 22:15:04.897500',2,_binary '',NULL,'平时分严重偏低警告','2025-10-11 22:15:04.899255','HIGH',60.00,'LOW_REGULAR_SCORE',1,7),(40,NULL,'学生Wang Qiang在课程Compiler Principles中的平时分为0.00分，严重偏低，请立即关注！','2025-10-11 22:14:40.292168',0.00,'ok','2025-10-11 22:15:08.255322',2,_binary '',NULL,'平时分严重偏低警告','2025-10-11 22:15:08.256324','HIGH',60.00,'LOW_REGULAR_SCORE',1,8),(41,NULL,'学生Liu Yang在课程Compiler Principles中的平时分为0.00分，严重偏低，请立即关注！','2025-10-11 22:14:40.312301',0.00,'ok','2025-10-11 22:15:09.709556',2,_binary '',NULL,'平时分严重偏低警告','2025-10-11 22:15:09.710554','HIGH',60.00,'LOW_REGULAR_SCORE',1,9),(42,NULL,'学生Chen Jing在课程Compiler Principles中的平时分为0.00分，严重偏低，请立即关注！','2025-10-11 22:14:40.329303',0.00,'ok','2025-10-11 22:15:10.440616',2,_binary '',NULL,'平时分严重偏低警告','2025-10-11 22:15:10.441615','HIGH',60.00,'LOW_REGULAR_SCORE',1,10),(43,'2023-2024','学生Zhang Ming在课程Computer Basics中的平时分为0.00分，严重偏低，请立即关注！','2025-10-11 22:14:40.420874',0.00,'ok','2025-10-11 22:15:11.095117',2,_binary '','2024Spring','平时分严重偏低警告','2025-10-11 22:15:11.097118','HIGH',60.00,'LOW_REGULAR_SCORE',3,6),(44,'2023-2024','学生Li Hua在课程Computer Basics中的平时分为0.00分，严重偏低，请立即关注！','2025-10-11 22:14:40.436389',0.00,'ok','2025-10-11 22:15:11.687615',2,_binary '','2024Spring','平时分严重偏低警告','2025-10-11 22:15:11.688614','HIGH',60.00,'LOW_REGULAR_SCORE',3,7),(45,'2023-2024','学生Wang Qiang在课程Computer Basics中的平时分为0.00分，严重偏低，请立即关注！','2025-10-11 22:14:40.447602',0.00,'ok','2025-10-11 22:15:13.705183',2,_binary '','2024Spring','平时分严重偏低警告','2025-10-11 22:15:13.706182','HIGH',60.00,'LOW_REGULAR_SCORE',3,8),(46,'2023-2024','学生Liu Yang在课程Computer Basics中的平时分为0.00分，严重偏低，请立即关注！','2025-10-11 22:14:40.459823',0.00,'ok','2025-10-11 22:15:16.094963',2,_binary '','2024Spring','平时分严重偏低警告','2025-10-11 22:15:16.094962','HIGH',60.00,'LOW_REGULAR_SCORE',3,9),(47,'2023-2024','学生Chen Jing在课程Computer Basics中的平时分为0.00分，严重偏低，请立即关注！','2025-10-11 22:14:40.472789',0.00,'ok','2025-10-11 22:15:18.448210',2,_binary '','2024Spring','平时分严重偏低警告','2025-10-11 22:15:18.449210','HIGH',60.00,'LOW_REGULAR_SCORE',3,10),(48,'2023-2024','学生Shen Gang在课程English中的平时分为0.00分，严重偏低，请立即关注！','2025-10-11 22:14:40.512606',0.00,'ok','2025-10-11 22:15:19.090570',2,_binary '','2024Spring','平时分严重偏低警告','2025-10-11 22:15:19.092569','HIGH',60.00,'LOW_REGULAR_SCORE',4,1),(49,'2023-2024','学生Jia Yang在课程English中的平时分为0.00分，严重偏低，请立即关注！','2025-10-11 22:14:40.522609',0.00,'ok','2025-10-11 22:15:20.127311',2,_binary '','2024Spring','平时分严重偏低警告','2025-10-11 22:15:20.127311','HIGH',60.00,'LOW_REGULAR_SCORE',4,2),(50,'2023-2024','学生Wang Yicheng在课程English中的平时分为0.00分，严重偏低，请立即关注！','2025-10-11 22:14:40.534429',0.00,'ok','2025-10-11 22:15:21.325084',2,_binary '','2024Spring','平时分严重偏低警告','2025-10-11 22:15:21.326083','HIGH',60.00,'LOW_REGULAR_SCORE',4,3),(51,'2023-2024','学生Meng Jiahao在课程English中的平时分为0.00分，严重偏低，请立即关注！','2025-10-11 22:14:40.546054',0.00,'ok','2025-10-11 22:15:25.283988',2,_binary '','2024Spring','平时分严重偏低警告','2025-10-11 22:15:25.285079','HIGH',60.00,'LOW_REGULAR_SCORE',4,4),(52,'2023-2024','学生Huang Lishuan在课程English中的平时分为0.00分，严重偏低，请立即关注！','2025-10-11 22:14:40.558901',0.00,'ok','2025-10-11 22:15:27.624124',2,_binary '','2024Spring','平时分严重偏低警告','2025-10-11 22:15:27.625124','HIGH',60.00,'LOW_REGULAR_SCORE',4,5),(53,NULL,'学生Shen Gang在课程Compiler Principles中的平时分为0.00分，严重偏低，请立即关注！','2025-10-11 22:28:06.335197',0.00,NULL,NULL,NULL,_binary '\0',NULL,'平时分严重偏低警告','2025-10-11 22:28:06.335197','HIGH',60.00,'LOW_REGULAR_SCORE',1,1),(54,NULL,'学生Jia Yang在课程Compiler Principles中的平时分为0.00分，严重偏低，请立即关注！','2025-10-11 22:28:06.468195',0.00,NULL,NULL,NULL,_binary '\0',NULL,'平时分严重偏低警告','2025-10-11 22:28:06.468195','HIGH',60.00,'LOW_REGULAR_SCORE',1,2),(55,NULL,'学生Wang Yicheng在课程Compiler Principles中的平时分为0.00分，严重偏低，请立即关注！','2025-10-11 22:28:06.580262',0.00,NULL,NULL,NULL,_binary '\0',NULL,'平时分严重偏低警告','2025-10-11 22:28:06.580262','HIGH',60.00,'LOW_REGULAR_SCORE',1,3),(56,NULL,'学生Meng Jiahao在课程Compiler Principles中的平时分为0.00分，严重偏低，请立即关注！','2025-10-11 22:28:06.690778',0.00,NULL,NULL,NULL,_binary '\0',NULL,'平时分严重偏低警告','2025-10-11 22:28:06.690778','HIGH',60.00,'LOW_REGULAR_SCORE',1,4),(57,NULL,'学生Huang Lishuan在课程Compiler Principles中的平时分为0.00分，严重偏低，请立即关注！','2025-10-11 22:28:06.815817',0.00,NULL,NULL,NULL,_binary '\0',NULL,'平时分严重偏低警告','2025-10-11 22:28:06.816817','HIGH',60.00,'LOW_REGULAR_SCORE',1,5),(58,NULL,'学生Zhang Ming在课程Compiler Principles中的平时分为0.00分，严重偏低，请立即关注！','2025-10-11 22:28:06.945852',0.00,NULL,NULL,NULL,_binary '\0',NULL,'平时分严重偏低警告','2025-10-11 22:28:06.945852','HIGH',60.00,'LOW_REGULAR_SCORE',1,6),(59,NULL,'学生Li Hua在课程Compiler Principles中的平时分为0.00分，严重偏低，请立即关注！','2025-10-11 22:28:07.079852',0.00,NULL,NULL,NULL,_binary '\0',NULL,'平时分严重偏低警告','2025-10-11 22:28:07.079852','HIGH',60.00,'LOW_REGULAR_SCORE',1,7),(60,NULL,'学生Wang Qiang在课程Compiler Principles中的平时分为0.00分，严重偏低，请立即关注！','2025-10-11 22:28:07.237852',0.00,NULL,NULL,NULL,_binary '\0',NULL,'平时分严重偏低警告','2025-10-11 22:28:07.237852','HIGH',60.00,'LOW_REGULAR_SCORE',1,8),(61,NULL,'学生Liu Yang在课程Compiler Principles中的平时分为0.00分，严重偏低，请立即关注！','2025-10-11 22:28:07.358852',0.00,NULL,NULL,NULL,_binary '\0',NULL,'平时分严重偏低警告','2025-10-11 22:28:07.359851','HIGH',60.00,'LOW_REGULAR_SCORE',1,9),(62,NULL,'学生Chen Jing在课程Compiler Principles中的平时分为0.00分，严重偏低，请立即关注！','2025-10-11 22:28:07.477497',0.00,NULL,NULL,NULL,_binary '\0',NULL,'平时分严重偏低警告','2025-10-11 22:28:07.477497','HIGH',60.00,'LOW_REGULAR_SCORE',1,10),(63,'2023-2024','学生Zhang Ming在课程Computer Basics中的平时分为0.00分，严重偏低，请立即关注！','2025-10-11 22:28:07.732991',0.00,NULL,NULL,NULL,_binary '\0','2024Spring','平时分严重偏低警告','2025-10-11 22:28:07.732991','HIGH',60.00,'LOW_REGULAR_SCORE',3,6),(64,'2023-2024','学生Li Hua在课程Computer Basics中的平时分为0.00分，严重偏低，请立即关注！','2025-10-11 22:28:07.821147',0.00,NULL,NULL,NULL,_binary '\0','2024Spring','平时分严重偏低警告','2025-10-11 22:28:07.821147','HIGH',60.00,'LOW_REGULAR_SCORE',3,7),(65,'2023-2024','学生Wang Qiang在课程Computer Basics中的平时分为0.00分，严重偏低，请立即关注！','2025-10-11 22:28:07.921028',0.00,NULL,NULL,NULL,_binary '\0','2024Spring','平时分严重偏低警告','2025-10-11 22:28:07.921028','HIGH',60.00,'LOW_REGULAR_SCORE',3,8),(66,'2023-2024','学生Liu Yang在课程Computer Basics中的平时分为0.00分，严重偏低，请立即关注！','2025-10-11 22:28:08.019412',0.00,NULL,NULL,NULL,_binary '\0','2024Spring','平时分严重偏低警告','2025-10-11 22:28:08.019412','HIGH',60.00,'LOW_REGULAR_SCORE',3,9),(67,'2023-2024','学生Chen Jing在课程Computer Basics中的平时分为0.00分，严重偏低，请立即关注！','2025-10-11 22:28:08.118728',0.00,NULL,NULL,NULL,_binary '\0','2024Spring','平时分严重偏低警告','2025-10-11 22:28:08.118728','HIGH',60.00,'LOW_REGULAR_SCORE',3,10),(68,'2023-2024','学生Shen Gang在课程English中的平时分为0.00分，严重偏低，请立即关注！','2025-10-11 22:28:08.292815',0.00,NULL,NULL,NULL,_binary '\0','2024Spring','平时分严重偏低警告','2025-10-11 22:28:08.292815','HIGH',60.00,'LOW_REGULAR_SCORE',4,1),(69,'2023-2024','学生Jia Yang在课程English中的平时分为0.00分，严重偏低，请立即关注！','2025-10-11 22:28:08.384821',0.00,NULL,NULL,NULL,_binary '\0','2024Spring','平时分严重偏低警告','2025-10-11 22:28:08.384821','HIGH',60.00,'LOW_REGULAR_SCORE',4,2),(70,'2023-2024','学生Wang Yicheng在课程English中的平时分为0.00分，严重偏低，请立即关注！','2025-10-11 22:28:08.481093',0.00,NULL,NULL,NULL,_binary '\0','2024Spring','平时分严重偏低警告','2025-10-11 22:28:08.481196','HIGH',60.00,'LOW_REGULAR_SCORE',4,3),(71,'2023-2024','学生Meng Jiahao在课程English中的平时分为0.00分，严重偏低，请立即关注！','2025-10-11 22:28:08.587711',0.00,NULL,NULL,NULL,_binary '\0','2024Spring','平时分严重偏低警告','2025-10-11 22:28:08.587711','HIGH',60.00,'LOW_REGULAR_SCORE',4,4),(72,'2023-2024','学生Huang Lishuan在课程English中的平时分为0.00分，严重偏低，请立即关注！','2025-10-11 22:28:08.685711',0.00,NULL,NULL,NULL,_binary '\0','2024Spring','平时分严重偏低警告','2025-10-11 22:28:08.685711','HIGH',60.00,'LOW_REGULAR_SCORE',4,5);
/*!40000 ALTER TABLE `student_warnings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `students`
--

DROP TABLE IF EXISTS `students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `students` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '学生ID',
  `user_id` bigint NOT NULL COMMENT '关联用户ID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '学生姓名',
  `student_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '学号',
  `class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '班级',
  `grade_level` int DEFAULT NULL COMMENT '年级',
  `major` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '专业',
  `enrollment_date` date DEFAULT NULL COMMENT '入学日期',
  `graduation_date` date DEFAULT NULL COMMENT '毕业日期',
  `avatar_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '头像URL',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remarks` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `has_custom_avatar` bit(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  UNIQUE KEY `student_number` (`student_number`),
  KEY `idx_student_number` (`student_number`),
  KEY `idx_class` (`class`),
  KEY `idx_grade_level` (`grade_level`),
  KEY `idx_name` (`name`),
  CONSTRAINT `students_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='学生表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `students`
--

LOCK TABLES `students` WRITE;
/*!40000 ALTER TABLE `students` DISABLE KEYS */;
INSERT INTO `students` VALUES (1,4,'Shen Gang','20181112737','18CS-A1',2018,'Software Engineering','2018-09-01',NULL,NULL,'2025-10-10 06:11:55','2025-10-10 06:11:55',NULL,_binary '\0'),(2,5,'Jia Yang','20191111504','19CS-A1',2019,'Software Engineering','2019-09-01',NULL,NULL,'2025-10-10 06:11:55','2025-10-10 06:11:55',NULL,_binary '\0'),(3,6,'Wang Yicheng','20191112403','19CS-A1',2019,'Software Engineering','2019-09-01',NULL,NULL,'2025-10-10 06:11:55','2025-10-10 06:11:55',NULL,_binary '\0'),(4,7,'Meng Jiahao','20191112404','19CS-A1',2019,'Software Engineering','2019-09-01',NULL,NULL,'2025-10-10 06:11:55','2025-10-10 06:11:55',NULL,_binary '\0'),(5,8,'Huang Lishuan','20191112405','19CS-A1',2019,'Software Engineering','2019-09-01',NULL,NULL,'2025-10-10 06:11:55','2025-10-10 06:11:55',NULL,_binary '\0'),(6,9,'Zhang Ming','20191112406','19CS-A1',2019,'Software Engineering','2019-09-01',NULL,NULL,'2025-10-10 06:11:55','2025-10-10 06:11:55',NULL,_binary '\0'),(7,10,'Li Hua','20191112407','19CS-A1',2019,'Software Engineering','2019-09-01',NULL,NULL,'2025-10-10 06:11:55','2025-10-10 06:11:55',NULL,_binary '\0'),(8,11,'Wang Qiang','20191112408','19CS-A1',2019,'Software Engineering','2019-09-01',NULL,NULL,'2025-10-10 06:11:55','2025-10-10 06:11:55',NULL,_binary '\0'),(9,12,'Liu Yang','20191112409','19CS-A1',2019,'Software Engineering','2019-09-01',NULL,NULL,'2025-10-10 06:11:55','2025-10-10 06:11:55',NULL,_binary '\0'),(10,13,'Chen Jing','20191112410','19CS-A1',2019,'Software Engineering','2019-09-01',NULL,NULL,'2025-10-10 06:11:55','2025-10-10 06:11:55',NULL,_binary '\0'),(11,16,'John Smith','20181001','18CS-A1',2018,'Computer Science','2018-09-01',NULL,NULL,'2025-10-11 03:36:03','2025-10-11 04:00:25',NULL,_binary '\0'),(12,17,'Jane Doe','20181002','18CS-A1',2018,'Computer Science','2018-09-01',NULL,NULL,'2025-10-11 03:36:03','2025-10-11 04:00:25',NULL,_binary '\0'),(13,18,'Mike Johnson','20181003','18CS-A1',2018,'Computer Science','2018-09-01',NULL,NULL,'2025-10-11 03:36:03','2025-10-11 04:00:25',NULL,_binary '\0'),(14,19,'Sarah Wilson','20181004','18CS-A1',2018,'Computer Science','2018-09-01',NULL,NULL,'2025-10-11 03:36:03','2025-10-11 04:00:25',NULL,_binary '\0'),(15,20,'David Brown','20181005','18CS-A1',2018,'Computer Science','2018-09-01',NULL,NULL,'2025-10-11 03:36:03','2025-10-11 04:00:25',NULL,_binary '\0'),(16,21,'Emily Davis','20181006','18CS-A2',2018,'Computer Science','2018-09-01',NULL,NULL,'2025-10-11 03:51:45','2025-10-11 04:00:25',NULL,_binary '\0'),(17,22,'Chris Miller','20181007','18CS-A2',2018,'Computer Science','2018-09-01',NULL,NULL,'2025-10-11 03:51:45','2025-10-11 04:00:25',NULL,_binary '\0'),(18,23,'Lisa Garcia','20181008','18CS-A2',2018,'Computer Science','2018-09-01',NULL,NULL,'2025-10-11 03:51:45','2025-10-11 04:00:25',NULL,_binary '\0'),(19,24,'Tom Rodriguez','20181009','18CS-A2',2018,'Computer Science','2018-09-01',NULL,NULL,'2025-10-11 03:51:45','2025-10-11 04:00:25',NULL,_binary '\0'),(20,25,'Anna Martinez','20181010','18CS-A2',2018,'Computer Science','2018-09-01',NULL,NULL,'2025-10-11 03:51:45','2025-10-11 04:00:25',NULL,_binary '\0'),(21,26,'Robert Lee','20181011','18CS-A3',2018,'Computer Science','2018-09-01',NULL,NULL,'2025-10-11 03:51:45','2025-10-11 04:00:25',NULL,_binary '\0'),(22,27,'Jennifer White','20181012','18CS-A3',2018,'Computer Science','2018-09-01',NULL,NULL,'2025-10-11 03:51:45','2025-10-11 04:00:25',NULL,_binary '\0'),(23,28,'Kevin Taylor','20181013','18CS-A3',2018,'Computer Science','2018-09-01',NULL,NULL,'2025-10-11 03:51:45','2025-10-11 04:00:25',NULL,_binary '\0'),(24,29,'Amanda Anderson','20181014','18CS-A3',2018,'Computer Science','2018-09-01',NULL,NULL,'2025-10-11 03:51:45','2025-10-11 04:00:25',NULL,_binary '\0'),(25,30,'Daniel Thomas','20181015','18CS-A3',2018,'Computer Science','2018-09-01',NULL,NULL,'2025-10-11 03:51:45','2025-10-11 04:00:25',NULL,_binary '\0'),(26,31,'Rachel Jackson','20191006','19CS-A2',2019,'Computer Science','2019-09-01',NULL,NULL,'2025-10-11 03:51:45','2025-10-11 04:00:25',NULL,_binary '\0'),(27,32,'Matthew Moore','20191007','19CS-A2',2019,'Computer Science','2019-09-01',NULL,NULL,'2025-10-11 03:51:45','2025-10-11 04:00:25',NULL,_binary '\0'),(28,33,'Jessica Martin','20191008','19CS-A2',2019,'Computer Science','2019-09-01',NULL,NULL,'2025-10-11 03:51:45','2025-10-11 04:00:25',NULL,_binary '\0'),(29,34,'Andrew Thompson','20191009','19CS-A2',2019,'Computer Science','2019-09-01',NULL,NULL,'2025-10-11 03:51:45','2025-10-11 04:00:25',NULL,_binary '\0'),(30,35,'Michelle Garcia','20191010','19CS-A2',2019,'Computer Science','2019-09-01',NULL,NULL,'2025-10-11 03:51:45','2025-10-11 04:00:25',NULL,_binary '\0'),(31,36,'Ryan Martinez','20201001','20CS-A1',2020,'Computer Science','2020-09-01',NULL,NULL,'2025-10-11 03:51:45','2025-10-11 04:00:25',NULL,_binary '\0'),(32,37,'Stephanie Robinson','20201002','20CS-A1',2020,'Computer Science','2020-09-01',NULL,NULL,'2025-10-11 03:51:45','2025-10-11 04:00:25',NULL,_binary '\0'),(33,38,'Brandon Clark','20201003','20CS-A1',2020,'Computer Science','2020-09-01',NULL,NULL,'2025-10-11 03:51:45','2025-10-11 04:00:25',NULL,_binary '\0'),(34,39,'Nicole Rodriguez','20201004','20CS-A1',2020,'Computer Science','2020-09-01',NULL,NULL,'2025-10-11 03:51:45','2025-10-11 04:00:25',NULL,_binary '\0'),(35,40,'Tyler Lewis','20201005','20CS-A1',2020,'Computer Science','2020-09-01',NULL,NULL,'2025-10-11 03:51:45','2025-10-11 04:00:25',NULL,_binary '\0'),(36,41,'Samantha Lee','20181016','18SE-A1',2018,'Software Engineering','2018-09-01',NULL,NULL,'2025-10-11 03:51:45','2025-10-11 04:00:25',NULL,_binary '\0'),(37,42,'Justin Walker','20181017','18SE-A1',2018,'Software Engineering','2018-09-01',NULL,NULL,'2025-10-11 03:51:45','2025-10-11 04:00:25',NULL,_binary '\0'),(38,43,'Megan Hall','20181018','18SE-A1',2018,'Software Engineering','2018-09-01',NULL,NULL,'2025-10-11 03:51:45','2025-10-11 04:00:25',NULL,_binary '\0'),(39,44,'Nathan Allen','20181019','18SE-A1',2018,'Software Engineering','2018-09-01',NULL,NULL,'2025-10-11 03:51:45','2025-10-11 04:00:25',NULL,_binary '\0'),(40,45,'Lauren Young','20181020','18SE-A1',2018,'Software Engineering','2018-09-01',NULL,NULL,'2025-10-11 03:51:45','2025-10-11 04:00:25',NULL,_binary '\0'),(41,46,'Jonathan King','20181021','18IS-A1',2018,'Information Security','2018-09-01',NULL,NULL,'2025-10-11 03:51:45','2025-10-11 04:00:25',NULL,_binary '\0'),(42,47,'Victoria Wright','20181022','18IS-A1',2018,'Information Security','2018-09-01',NULL,NULL,'2025-10-11 03:51:45','2025-10-11 04:00:25',NULL,_binary '\0'),(43,48,'Alexander Lopez','20181023','18IS-A1',2018,'Information Security','2018-09-01',NULL,NULL,'2025-10-11 03:51:45','2025-10-11 04:00:25',NULL,_binary '\0'),(44,49,'Olivia Hill','20181024','18IS-A1',2018,'Information Security','2018-09-01',NULL,NULL,'2025-10-11 03:51:45','2025-10-11 04:00:25',NULL,_binary '\0'),(45,50,'William Scott','20181025','18IS-A1',2018,'Information Security','2018-09-01',NULL,NULL,'2025-10-11 03:51:45','2025-10-11 04:00:25',NULL,_binary '\0');
/*!40000 ALTER TABLE `students` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teachers`
--

DROP TABLE IF EXISTS `teachers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teachers` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '教师ID',
  `user_id` bigint NOT NULL COMMENT '关联用户ID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '教师姓名',
  `employee_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '工号',
  `department` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '所属部门',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '职称',
  `education` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '学历',
  `specialization` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '专业方向',
  `hire_date` date DEFAULT NULL COMMENT '入职日期',
  `avatar_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '头像URL',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remarks` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `has_custom_avatar` bit(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  UNIQUE KEY `employee_number` (`employee_number`),
  KEY `idx_employee_number` (`employee_number`),
  KEY `idx_department` (`department`),
  KEY `idx_name` (`name`),
  CONSTRAINT `teachers_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='教师表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teachers`
--

LOCK TABLES `teachers` WRITE;
/*!40000 ALTER TABLE `teachers` DISABLE KEYS */;
INSERT INTO `teachers` VALUES (1,1,'Admin','ADMIN001','Computer Science','Professor','PhD','Computer Science','2020-01-01',NULL,'2025-10-10 06:11:55','2025-10-10 06:11:55',NULL,_binary '\0'),(2,2,'Wang Na','T001','Computer Science','Associate Professor','Master','Compiler','2020-01-01',NULL,'2025-10-10 06:11:55','2025-10-10 06:11:55',NULL,_binary '\0'),(3,3,'Li Professor','T002','Computer Science','Professor','PhD','Data Structure','2020-01-01',NULL,'2025-10-10 06:11:55','2025-10-10 06:11:55',NULL,_binary '\0');
/*!40000 ALTER TABLE `teachers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '加密密码',
  `role` enum('STUDENT','TEACHER','ADMIN') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '电子邮箱',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '手机号码',
  `status` enum('ACTIVE','INACTIVE','LOCKED') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_login` timestamp NULL DEFAULT NULL COMMENT '最后登录时间',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `phone` (`phone`),
  KEY `idx_username` (`username`),
  KEY `idx_email` (`email`),
  KEY `idx_phone` (`phone`),
  KEY `idx_role` (`role`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','$2a$10$jmPzOs5rn.tD3.pARAng3.smdvynSosTC5JHnSdHhv.XfYRL8dgAG','ADMIN','admin@example.com','13800000000','ACTIVE',NULL,'2025-10-10 06:11:55','2025-10-11 16:55:50'),(2,'teacher1','$2a$10$jmPzOs5rn.tD3.pARAng3.smdvynSosTC5JHnSdHhv.XfYRL8dgAG','TEACHER','wangna@example.com','13800000001','ACTIVE','2025-10-12 02:39:51','2025-10-10 06:11:55','2025-10-12 02:39:51'),(3,'teacher2','$2a$10$jmPzOs5rn.tD3.pARAng3.smdvynSosTC5JHnSdHhv.XfYRL8dgAG','TEACHER','li@example.com','13800000002','ACTIVE',NULL,'2025-10-10 06:11:55','2025-10-11 16:55:50'),(4,'student1','$2a$10$jmPzOs5rn.tD3.pARAng3.smdvynSosTC5JHnSdHhv.XfYRL8dgAG','STUDENT','shengang@example.com','13800138001','ACTIVE','2025-10-12 02:42:35','2025-10-10 06:11:55','2025-10-12 02:42:35'),(5,'student2','$2a$10$jmPzOs5rn.tD3.pARAng3.smdvynSosTC5JHnSdHhv.XfYRL8dgAG','STUDENT','jiayang@example.com','13800138002','ACTIVE',NULL,'2025-10-10 06:11:55','2025-10-11 16:55:50'),(6,'student3','$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi','STUDENT','wangyicheng@example.com','13800138003','ACTIVE',NULL,'2025-10-10 06:11:55','2025-10-10 06:11:55'),(7,'student4','$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi','STUDENT','mengjiahao@example.com','13800138004','ACTIVE',NULL,'2025-10-10 06:11:55','2025-10-10 06:11:55'),(8,'student5','$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi','STUDENT','huanglishuan@example.com','13800138005','ACTIVE',NULL,'2025-10-10 06:11:55','2025-10-10 06:11:55'),(9,'student6','$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi','STUDENT','zhangming@example.com','13800138006','ACTIVE',NULL,'2025-10-10 06:11:55','2025-10-10 06:11:55'),(10,'student7','$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi','STUDENT','lihua@example.com','13800138007','ACTIVE',NULL,'2025-10-10 06:11:55','2025-10-10 06:11:55'),(11,'student8','$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi','STUDENT','wangqiang@example.com','13800138008','ACTIVE',NULL,'2025-10-10 06:11:55','2025-10-10 06:11:55'),(12,'student9','$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi','STUDENT','liuyang@example.com','13800138009','ACTIVE',NULL,'2025-10-10 06:11:55','2025-10-10 06:11:55'),(13,'student10','$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi','STUDENT','chenjing@example.com','13800138010','ACTIVE',NULL,'2025-10-10 06:11:55','2025-10-10 06:11:55'),(14,'testuser2','$2a$10$UvkeDX2o9.sTY.1lTDgaw.x85Ydq7RQfMqeJjz7pJO3db9GQmjE2i','STUDENT','testuser2@example.com','13800009999','ACTIVE','2025-10-10 07:44:03','2025-10-10 07:44:02','2025-10-10 07:44:03'),(15,'testteacher','$2a$10$3HMq.6R/fW3E96iCITs.2.y42.bC6Z5Y9ZRcERrGfUmRXQ8FhJwyC','TEACHER','testteacher@example.com','13800008888','ACTIVE','2025-10-10 07:53:41','2025-10-10 07:53:41','2025-10-10 07:53:41'),(16,'student11','\\.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi','STUDENT','student11@example.com',NULL,'ACTIVE',NULL,'2025-10-11 03:35:51','2025-10-11 03:35:51'),(17,'student12','\\.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi','STUDENT','student12@example.com',NULL,'ACTIVE',NULL,'2025-10-11 03:35:51','2025-10-11 03:35:51'),(18,'student13','\\.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi','STUDENT','student13@example.com',NULL,'ACTIVE',NULL,'2025-10-11 03:35:51','2025-10-11 03:35:51'),(19,'student14','\\.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi','STUDENT','student14@example.com',NULL,'ACTIVE',NULL,'2025-10-11 03:35:51','2025-10-11 03:35:51'),(20,'student15','\\.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi','STUDENT','student15@example.com',NULL,'ACTIVE',NULL,'2025-10-11 03:35:51','2025-10-11 03:35:51'),(21,'student21','$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi','STUDENT','student21@example.com',NULL,'ACTIVE',NULL,'2025-10-11 03:51:45','2025-10-11 03:51:45'),(22,'student22','$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi','STUDENT','student22@example.com',NULL,'ACTIVE',NULL,'2025-10-11 03:51:45','2025-10-11 03:51:45'),(23,'student23','$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi','STUDENT','student23@example.com',NULL,'ACTIVE',NULL,'2025-10-11 03:51:45','2025-10-11 03:51:45'),(24,'student24','$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi','STUDENT','student24@example.com',NULL,'ACTIVE',NULL,'2025-10-11 03:51:45','2025-10-11 03:51:45'),(25,'student25','$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi','STUDENT','student25@example.com',NULL,'ACTIVE',NULL,'2025-10-11 03:51:45','2025-10-11 03:51:45'),(26,'student26','$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi','STUDENT','student26@example.com',NULL,'ACTIVE',NULL,'2025-10-11 03:51:45','2025-10-11 03:51:45'),(27,'student27','$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi','STUDENT','student27@example.com',NULL,'ACTIVE',NULL,'2025-10-11 03:51:45','2025-10-11 03:51:45'),(28,'student28','$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi','STUDENT','student28@example.com',NULL,'ACTIVE',NULL,'2025-10-11 03:51:45','2025-10-11 03:51:45'),(29,'student29','$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi','STUDENT','student29@example.com',NULL,'ACTIVE',NULL,'2025-10-11 03:51:45','2025-10-11 03:51:45'),(30,'student30','$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi','STUDENT','student30@example.com',NULL,'ACTIVE',NULL,'2025-10-11 03:51:45','2025-10-11 03:51:45'),(31,'student31','$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi','STUDENT','student31@example.com',NULL,'ACTIVE',NULL,'2025-10-11 03:51:45','2025-10-11 03:51:45'),(32,'student32','$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi','STUDENT','student32@example.com',NULL,'ACTIVE',NULL,'2025-10-11 03:51:45','2025-10-11 03:51:45'),(33,'student33','$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi','STUDENT','student33@example.com',NULL,'ACTIVE',NULL,'2025-10-11 03:51:45','2025-10-11 03:51:45'),(34,'student34','$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi','STUDENT','student34@example.com',NULL,'ACTIVE',NULL,'2025-10-11 03:51:45','2025-10-11 03:51:45'),(35,'student35','$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi','STUDENT','student35@example.com',NULL,'ACTIVE',NULL,'2025-10-11 03:51:45','2025-10-11 03:51:45'),(36,'student36','$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi','STUDENT','student36@example.com',NULL,'ACTIVE',NULL,'2025-10-11 03:51:45','2025-10-11 03:51:45'),(37,'student37','$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi','STUDENT','student37@example.com',NULL,'ACTIVE',NULL,'2025-10-11 03:51:45','2025-10-11 03:51:45'),(38,'student38','$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi','STUDENT','student38@example.com',NULL,'ACTIVE',NULL,'2025-10-11 03:51:45','2025-10-11 03:51:45'),(39,'student39','$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi','STUDENT','student39@example.com',NULL,'ACTIVE',NULL,'2025-10-11 03:51:45','2025-10-11 03:51:45'),(40,'student40','$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi','STUDENT','student40@example.com',NULL,'ACTIVE',NULL,'2025-10-11 03:51:45','2025-10-11 03:51:45'),(41,'student41','$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi','STUDENT','student41@example.com',NULL,'ACTIVE',NULL,'2025-10-11 03:51:45','2025-10-11 03:51:45'),(42,'student42','$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi','STUDENT','student42@example.com',NULL,'ACTIVE',NULL,'2025-10-11 03:51:45','2025-10-11 03:51:45'),(43,'student43','$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi','STUDENT','student43@example.com',NULL,'ACTIVE',NULL,'2025-10-11 03:51:45','2025-10-11 03:51:45'),(44,'student44','$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi','STUDENT','student44@example.com',NULL,'ACTIVE',NULL,'2025-10-11 03:51:45','2025-10-11 03:51:45'),(45,'student45','$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi','STUDENT','student45@example.com',NULL,'ACTIVE',NULL,'2025-10-11 03:51:45','2025-10-11 03:51:45'),(46,'student46','$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi','STUDENT','student46@example.com',NULL,'ACTIVE',NULL,'2025-10-11 03:51:45','2025-10-11 03:51:45'),(47,'student47','$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi','STUDENT','student47@example.com',NULL,'ACTIVE',NULL,'2025-10-11 03:51:45','2025-10-11 03:51:45'),(48,'student48','$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi','STUDENT','student48@example.com',NULL,'ACTIVE',NULL,'2025-10-11 03:51:45','2025-10-11 03:51:45'),(49,'student49','$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi','STUDENT','student49@example.com',NULL,'ACTIVE',NULL,'2025-10-11 03:51:45','2025-10-11 03:51:45'),(50,'student50','$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi','STUDENT','student50@example.com',NULL,'ACTIVE',NULL,'2025-10-11 03:51:45','2025-10-11 03:51:45');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'student_analysis'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-10-12 12:04:01
