CREATE DATABASE  IF NOT EXISTS `bs_airplane_booking` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `bs_airplane_booking`;
-- MySQL dump 10.13  Distrib 8.0.38, for macos14 (arm64)
--
-- Host: localhost    Database: bs_airplane_booking
-- ------------------------------------------------------
-- Server version	9.0.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `airline`
--

DROP TABLE IF EXISTS `airline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `airline` (
  `airline_id` int NOT NULL AUTO_INCREMENT,
  `airline_name` varchar(255) NOT NULL,
  PRIMARY KEY (`airline_id`),
  UNIQUE KEY `uk_airline_name` (`airline_name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `airline`
--

LOCK TABLES `airline` WRITE;
/*!40000 ALTER TABLE `airline` DISABLE KEYS */;
INSERT INTO `airline` VALUES (7,'Alaska Airlines'),(1,'American Airlines'),(5,'Delta Airlines'),(3,'JetBlue Airways'),(6,'Southwest Airlines'),(4,'Spirit Airlines'),(2,'United Airlines');
/*!40000 ALTER TABLE `airline` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `airport`
--

DROP TABLE IF EXISTS `airport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `airport` (
  `airport_id` int NOT NULL AUTO_INCREMENT,
  `airport_name` varchar(255) NOT NULL,
  `city_id` int NOT NULL,
  PRIMARY KEY (`airport_id`),
  UNIQUE KEY `uk_airport_name` (`airport_name`),
  KEY `fk_airport_city` (`city_id`),
  CONSTRAINT `fk_airport_city` FOREIGN KEY (`city_id`) REFERENCES `city` (`city_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `airport`
--

LOCK TABLES `airport` WRITE;
/*!40000 ALTER TABLE `airport` DISABLE KEYS */;
INSERT INTO `airport` VALUES (1,'JFK Airport',1),(2,'LAX Airport',2),(3,'ORD Airport',3),(4,'MIA Airport',4),(5,'HOU Airport',5),(6,'DFW Airport',6),(7,'SEA Airport',7),(8,'SFO Airport',8);
/*!40000 ALTER TABLE `airport` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `city`
--

DROP TABLE IF EXISTS `city`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `city` (
  `city_id` int NOT NULL AUTO_INCREMENT,
  `city_name` varchar(255) NOT NULL,
  PRIMARY KEY (`city_id`),
  UNIQUE KEY `uk_city_name` (`city_name`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `city`
--

LOCK TABLES `city` WRITE;
/*!40000 ALTER TABLE `city` DISABLE KEYS */;
INSERT INTO `city` VALUES (3,'Chicago'),(6,'Dallas'),(5,'Houston'),(2,'Los Angeles'),(4,'Miami'),(1,'New York'),(8,'San Francisco'),(7,'Seattle');
/*!40000 ALTER TABLE `city` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flight`
--

DROP TABLE IF EXISTS `flight`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flight` (
  `date` date DEFAULT NULL,
  `flight_num` varchar(255) NOT NULL COMMENT 'Flight Number',
  `start_city_id` int NOT NULL,
  `start_airport_id` int NOT NULL,
  `start_time` time NOT NULL,
  `reach_city_id` int NOT NULL,
  `reach_airport_id` int NOT NULL,
  `reach_time` time NOT NULL,
  `seat_count` int NOT NULL,
  `used_time` int NOT NULL DEFAULT '0',
  `price` double(10,2) NOT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_flight_num_date` (`flight_num`,`date`),
  KEY `idx_flight_num` (`flight_num`),
  KEY `fk_flight_start_city` (`start_city_id`),
  KEY `fk_flight_reach_city` (`reach_city_id`),
  KEY `fk_flight_start_airport` (`start_airport_id`),
  KEY `fk_flight_reach_airport` (`reach_airport_id`),
  CONSTRAINT `fk_flight_flightinfo` FOREIGN KEY (`flight_num`) REFERENCES `flight_info` (`flight_num`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_flight_reach_airport` FOREIGN KEY (`reach_airport_id`) REFERENCES `airport` (`airport_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_flight_reach_city` FOREIGN KEY (`reach_city_id`) REFERENCES `city` (`city_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_flight_start_airport` FOREIGN KEY (`start_airport_id`) REFERENCES `airport` (`airport_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_flight_start_city` FOREIGN KEY (`start_city_id`) REFERENCES `city` (`city_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1011 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flight`
--

LOCK TABLES `flight` WRITE;
/*!40000 ALTER TABLE `flight` DISABLE KEYS */;
INSERT INTO `flight` VALUES ('2024-12-05','AA123',1,1,'17:00:00',2,2,'20:00:00',46,180,300.00,2),('2024-12-05','UA456',2,2,'21:00:00',1,1,'05:00:00',48,360,320.00,3),('2024-12-06','DL789',3,3,'15:00:00',4,4,'19:00:00',49,240,280.00,4),('2024-12-06','SW123',5,5,'12:00:00',6,6,'13:30:00',44,90,150.00,5),('2024-12-06','AS789',7,7,'10:00:00',8,8,'12:00:00',46,120,200.00,6),('2024-12-06','JB123',1,1,'08:00:00',2,2,'11:30:00',50,210,350.00,7),('2024-12-06','SP789',2,2,'12:00:00',1,1,'20:00:00',45,360,330.00,8),('2024-12-07','AA567',3,3,'10:00:00',4,4,'14:00:00',40,240,250.00,9),('2024-12-07','DL123',4,4,'16:00:00',3,3,'20:00:00',48,240,270.00,10),('2024-12-07','SW890',5,5,'09:00:00',6,6,'10:30:00',44,90,120.00,11),('2024-12-07','AS345',6,6,'14:00:00',5,5,'15:30:00',44,90,130.00,12),('2024-12-08','UA678',7,7,'07:00:00',8,8,'09:00:00',46,120,190.00,13),('2024-12-08','AS123',8,8,'11:00:00',7,7,'13:00:00',46,120,210.00,14);
/*!40000 ALTER TABLE `flight` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flight_info`
--

DROP TABLE IF EXISTS `flight_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flight_info` (
  `flight_num` varchar(255) NOT NULL,
  `airline_id` int NOT NULL,
  PRIMARY KEY (`flight_num`),
  KEY `fk_flight_info_airline` (`airline_id`),
  CONSTRAINT `fk_flight_info_airline` FOREIGN KEY (`airline_id`) REFERENCES `airline` (`airline_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flight_info`
--

LOCK TABLES `flight_info` WRITE;
/*!40000 ALTER TABLE `flight_info` DISABLE KEYS */;
INSERT INTO `flight_info` VALUES ('AA123',1),('AA567',1),('UA456',2),('UA678',2),('JB123',3),('SP789',4),('DL123',5),('DL789',5),('SW123',6),('SW890',6),('AS123',7),('AS345',7),('AS789',7);
/*!40000 ALTER TABLE `flight_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `order_num` varchar(255) NOT NULL,
  `date` date NOT NULL,
  `flight_num` varchar(255) NOT NULL,
  `username` varchar(10) NOT NULL,
  `name` varchar(255) DEFAULT NULL COMMENT 'Passenger Name',
  `id` varchar(255) NOT NULL COMMENT 'Passenger ID',
  `phone` varchar(255) DEFAULT NULL COMMENT 'Passenger Phone',
  PRIMARY KEY (`date`,`flight_num`,`id`,`order_num`),
  KEY `fk_orders_flight` (`flight_num`,`date`),
  KEY `fk_orders_user` (`username`),
  CONSTRAINT `fk_orders_flight` FOREIGN KEY (`flight_num`, `date`) REFERENCES `flight` (`flight_num`, `date`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_orders_user` FOREIGN KEY (`username`) REFERENCES `user` (`username`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES ('20240113093549','2024-12-05','AA123','admin','Admin User','1','857-998-8312'),('20240113093552','2024-12-06','DL789','admin','Admin User','1','857-998-8312');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_after_order_insert` AFTER INSERT ON `orders` FOR EACH ROW BEGIN
    UPDATE `flight` 
    SET 
      `seat_count` = `seat_count` - 1,
      `used_time` = `used_time` + `calc_used_time`(`start_time`, `reach_time`)
    WHERE `flight_num` = NEW.`flight_num` AND `date` = NEW.`date`;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `username` varchar(10) NOT NULL,
  `password` varchar(16) NOT NULL,
  `name` varchar(255) NOT NULL,
  `id` varchar(18) NOT NULL,
  `phone` varchar(255) NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('admin','test123','Admin User','1','857-998-8312'),('user','test123','Regular User','2','834-932-3213');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'bs_airplane_booking'
--
/*!50106 SET @save_time_zone= @@TIME_ZONE */ ;
/*!50106 DROP EVENT IF EXISTS `evt_clean_old_flights` */;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `evt_clean_old_flights` ON SCHEDULE EVERY 1 DAY STARTS '2025-01-01 00:00:00' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
    DELETE FROM `flight` WHERE `date` < CURDATE();
END */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
DELIMITER ;
/*!50106 SET TIME_ZONE= @save_time_zone */ ;

--
-- Dumping routines for database 'bs_airplane_booking'
--
/*!50003 DROP FUNCTION IF EXISTS `calc_used_time` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `calc_used_time`(start_t TIME, end_t TIME) RETURNS int
    DETERMINISTIC
BEGIN
    DECLARE duration INT;
    SET duration = TIME_TO_SEC(TIMEDIFF(end_t, start_t)) / 60;
    IF duration < 0 THEN
        SET duration = duration + 1440; -- Handle overnight flights
    END IF;
    RETURN duration;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_place_order` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_place_order`(
    IN p_order_num VARCHAR(255),
    IN p_date DATE,
    IN p_flight_num VARCHAR(255),
    IN p_username VARCHAR(10),
    IN p_passenger_name VARCHAR(255),
    IN p_passenger_id VARCHAR(255),
    IN p_passenger_phone VARCHAR(255)
)
BEGIN
    DECLARE v_seat_count INT;
    
    -- Retrieve seat count for the specified flight
    SELECT `seat_count` INTO v_seat_count 
    FROM `flight`
    WHERE `flight_num` = p_flight_num AND `date` = p_date FOR UPDATE;
    
    IF v_seat_count IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Flight not found';
    END IF;
    
    IF v_seat_count <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No seats available';
    END IF;
    
    -- Insert the order into orders table
    INSERT INTO `orders` (`order_num`, `date`, `flight_num`, `username`, `name`, `id`, `phone`)
    VALUES (p_order_num, p_date, p_flight_num, p_username, p_passenger_name, p_passenger_id, p_passenger_phone);
    
    -- Update seat count and used time in flight table
    UPDATE `flight` 
    SET 
      `seat_count` = `seat_count` - 1,
      `used_time` = `used_time` + `calc_used_time`(`start_time`, `reach_time`)
    WHERE `flight_num` = p_flight_num AND `date` = p_date;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-05 23:02:20
