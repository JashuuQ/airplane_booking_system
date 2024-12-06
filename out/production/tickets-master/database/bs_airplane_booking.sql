SET FOREIGN_KEY_CHECKS = 0;

-- Drop existing database if it exists
DROP DATABASE IF EXISTS `bs_airplane_booking`;
CREATE DATABASE `bs_airplane_booking`;
USE `bs_airplane_booking`;

-- ----------------------------
-- Table structure for city
-- ----------------------------
DROP TABLE IF EXISTS `city`;
CREATE TABLE `city` (
  `city_id` INT AUTO_INCREMENT,
  `city_name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`city_id`),
  UNIQUE KEY `uk_city_name` (`city_name`)
) ENGINE=InnoDB;

-- Insert city data
INSERT INTO `city` (`city_name`)
VALUES 
  ('New York'), 
  ('Los Angeles'), 
  ('Chicago'), 
  ('Miami'), 
  ('Houston'), 
  ('Dallas'), 
  ('Seattle'), 
  ('San Francisco')
ON DUPLICATE KEY UPDATE `city_name` = VALUES(`city_name`);

-- ----------------------------
-- Table structure for airport
-- ----------------------------
DROP TABLE IF EXISTS `airport`;
CREATE TABLE `airport` (
  `airport_id` INT AUTO_INCREMENT,
  `airport_name` VARCHAR(255) NOT NULL,
  `city_id` INT NOT NULL,
  PRIMARY KEY (`airport_id`),
  UNIQUE KEY `uk_airport_name` (`airport_name`),
  CONSTRAINT `fk_airport_city` FOREIGN KEY (`city_id`) 
    REFERENCES `city`(`city_id`) 
    ON UPDATE CASCADE 
    ON DELETE RESTRICT
) ENGINE=InnoDB;

-- Insert airport data
INSERT INTO `airport` (`airport_name`, `city_id`)
SELECT 'JFK Airport', `city_id` FROM `city` WHERE `city_name` = 'New York' UNION ALL
SELECT 'LAX Airport', `city_id` FROM `city` WHERE `city_name` = 'Los Angeles' UNION ALL
SELECT 'ORD Airport', `city_id` FROM `city` WHERE `city_name` = 'Chicago' UNION ALL
SELECT 'MIA Airport', `city_id` FROM `city` WHERE `city_name` = 'Miami' UNION ALL
SELECT 'HOU Airport', `city_id` FROM `city` WHERE `city_name` = 'Houston' UNION ALL
SELECT 'DFW Airport', `city_id` FROM `city` WHERE `city_name` = 'Dallas' UNION ALL
SELECT 'SEA Airport', `city_id` FROM `city` WHERE `city_name` = 'Seattle' UNION ALL
SELECT 'SFO Airport', `city_id` FROM `city` WHERE `city_name` = 'San Francisco'
ON DUPLICATE KEY UPDATE `airport_name` = VALUES(`airport_name`);

-- ----------------------------
-- Table structure for airline
-- ----------------------------
DROP TABLE IF EXISTS `airline`;
CREATE TABLE `airline` (
  `airline_id` INT AUTO_INCREMENT,
  `airline_name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`airline_id`),
  UNIQUE KEY `uk_airline_name` (`airline_name`)
) ENGINE=InnoDB;

-- Insert airline data
INSERT INTO `airline` (`airline_name`)
VALUES 
  ('American Airlines'), 
  ('United Airlines'), 
  ('JetBlue Airways'), 
  ('Spirit Airlines'), 
  ('Delta Airlines'), 
  ('Southwest Airlines'),
  ('Alaska Airlines')
ON DUPLICATE KEY UPDATE `airline_name` = VALUES(`airline_name`);

-- ----------------------------
-- Table structure for flight_info
-- ----------------------------
DROP TABLE IF EXISTS `flight_info`;
CREATE TABLE `flight_info` (
  `flight_num` VARCHAR(255) NOT NULL,
  `airline_id` INT NOT NULL,
  PRIMARY KEY (`flight_num`),
  CONSTRAINT `fk_flight_info_airline` FOREIGN KEY (`airline_id`) 
    REFERENCES `airline`(`airline_id`) 
    ON UPDATE CASCADE 
    ON DELETE RESTRICT
) ENGINE=InnoDB;

-- Insert flight_info data
INSERT INTO `flight_info` (`flight_num`, `airline_id`)
VALUES 
  ('AA123', (SELECT `airline_id` FROM `airline` WHERE `airline_name` = 'American Airlines')),
  ('UA456', (SELECT `airline_id` FROM `airline` WHERE `airline_name` = 'United Airlines')),
  ('JB123', (SELECT `airline_id` FROM `airline` WHERE `airline_name` = 'JetBlue Airways')),
  ('SP789', (SELECT `airline_id` FROM `airline` WHERE `airline_name` = 'Spirit Airlines')),
  ('DL789', (SELECT `airline_id` FROM `airline` WHERE `airline_name` = 'Delta Airlines')),
  ('AA567', (SELECT `airline_id` FROM `airline` WHERE `airline_name` = 'American Airlines')),
  ('DL123', (SELECT `airline_id` FROM `airline` WHERE `airline_name` = 'Delta Airlines')),
  ('SW123', (SELECT `airline_id` FROM `airline` WHERE `airline_name` = 'Southwest Airlines')),
  ('SW890', (SELECT `airline_id` FROM `airline` WHERE `airline_name` = 'Southwest Airlines')),
  ('AS345', (SELECT `airline_id` FROM `airline` WHERE `airline_name` = 'Alaska Airlines')),
  ('AS789', (SELECT `airline_id` FROM `airline` WHERE `airline_name` = 'Alaska Airlines')),
  ('UA678', (SELECT `airline_id` FROM `airline` WHERE `airline_name` = 'United Airlines')),
  ('AS123', (SELECT `airline_id` FROM `airline` WHERE `airline_name` = 'Alaska Airlines'))
ON DUPLICATE KEY UPDATE `flight_num` = VALUES(`flight_num`);

-- ----------------------------
-- Table structure for flight
-- ----------------------------
DROP TABLE IF EXISTS `flight`;
CREATE TABLE `flight` (
  `date` DATE NULL DEFAULT NULL,
  `flight_num` VARCHAR(255) NOT NULL COMMENT 'Flight Number',
  `start_city_id` INT NOT NULL,
  `start_airport_id` INT NOT NULL,
  `start_time` TIME NOT NULL,
  `reach_city_id` INT NOT NULL,
  `reach_airport_id` INT NOT NULL,
  `reach_time` TIME NOT NULL,
  `seat_count` INT NOT NULL,
  `used_time` INT NOT NULL DEFAULT 0,
  `price` DOUBLE(10, 2) NOT NULL,
  `id` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_flight_num_date` (`flight_num`, `date`),
  KEY `idx_flight_num` (`flight_num`),
  CONSTRAINT `fk_flight_flightinfo` FOREIGN KEY (`flight_num`) 
    REFERENCES `flight_info`(`flight_num`) 
    ON UPDATE CASCADE 
    ON DELETE RESTRICT,
  CONSTRAINT `fk_flight_start_city` FOREIGN KEY (`start_city_id`) 
    REFERENCES `city`(`city_id`) 
    ON UPDATE CASCADE 
    ON DELETE RESTRICT,
  CONSTRAINT `fk_flight_reach_city` FOREIGN KEY (`reach_city_id`) 
    REFERENCES `city`(`city_id`) 
    ON UPDATE CASCADE 
    ON DELETE RESTRICT,
  CONSTRAINT `fk_flight_start_airport` FOREIGN KEY (`start_airport_id`) 
    REFERENCES `airport`(`airport_id`) 
    ON UPDATE CASCADE 
    ON DELETE RESTRICT,
  CONSTRAINT `fk_flight_reach_airport` FOREIGN KEY (`reach_airport_id`) 
    REFERENCES `airport`(`airport_id`) 
    ON UPDATE CASCADE 
    ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=1011 ROW_FORMAT=DYNAMIC;

-- Insert flight records
INSERT INTO `flight` (`date`, `flight_num`, `start_city_id`, `start_airport_id`, `start_time`, `reach_city_id`, `reach_airport_id`, `reach_time`, `seat_count`, `used_time`, `price`, `id`)
VALUES 
  ('2024-12-05', 'AA123', (SELECT `city_id` FROM `city` WHERE `city_name` = 'New York'), (SELECT `airport_id` FROM `airport` WHERE `airport_name` = 'JFK Airport'), '17:00:00', (SELECT `city_id` FROM `city` WHERE `city_name` = 'Los Angeles'), (SELECT `airport_id` FROM `airport` WHERE `airport_name` = 'LAX Airport'), '20:00:00', 46, 180, 300.00, 2),
  ('2024-12-05', 'UA456', (SELECT `city_id` FROM `city` WHERE `city_name` = 'Los Angeles'), (SELECT `airport_id` FROM `airport` WHERE `airport_name` = 'LAX Airport'), '21:00:00', (SELECT `city_id` FROM `city` WHERE `city_name` = 'New York'), (SELECT `airport_id` FROM `airport` WHERE `airport_name` = 'JFK Airport'), '05:00:00', 48, 360, 320.00, 3),
  ('2024-12-06', 'JB123', (SELECT `city_id` FROM `city` WHERE `city_name` = 'New York'), (SELECT `airport_id` FROM `airport` WHERE `airport_name` = 'JFK Airport'), '08:00:00', (SELECT `city_id` FROM `city` WHERE `city_name` = 'Los Angeles'), (SELECT `airport_id` FROM `airport` WHERE `airport_name` = 'LAX Airport'), '11:30:00', 50, 210, 350.00, 7),
  ('2024-12-06', 'SP789', (SELECT `city_id` FROM `city` WHERE `city_name` = 'Los Angeles'), (SELECT `airport_id` FROM `airport` WHERE `airport_name` = 'LAX Airport'), '12:00:00', (SELECT `city_id` FROM `city` WHERE `city_name` = 'New York'), (SELECT `airport_id` FROM `airport` WHERE `airport_name` = 'JFK Airport'), '20:00:00', 45, 360, 330.00, 8),
  ('2024-12-06', 'DL789', (SELECT `city_id` FROM `city` WHERE `city_name` = 'Chicago'), (SELECT `airport_id` FROM `airport` WHERE `airport_name` = 'ORD Airport'), '15:00:00', (SELECT `city_id` FROM `city` WHERE `city_name` = 'Miami'), (SELECT `airport_id` FROM `airport` WHERE `airport_name` = 'MIA Airport'), '19:00:00', 49, 240, 280.00, 4),
  ('2024-12-07', 'AA567', (SELECT `city_id` FROM `city` WHERE `city_name` = 'Chicago'), (SELECT `airport_id` FROM `airport` WHERE `airport_name` = 'ORD Airport'), '10:00:00', (SELECT `city_id` FROM `city` WHERE `city_name` = 'Miami'), (SELECT `airport_id` FROM `airport` WHERE `airport_name` = 'MIA Airport'), '14:00:00', 40, 240, 250.00, 9),
  ('2024-12-07', 'DL123', (SELECT `city_id` FROM `city` WHERE `city_name` = 'Miami'), (SELECT `airport_id` FROM `airport` WHERE `airport_name` = 'MIA Airport'), '16:00:00', (SELECT `city_id` FROM `city` WHERE `city_name` = 'Chicago'), (SELECT `airport_id` FROM `airport` WHERE `airport_name` = 'ORD Airport'), '20:00:00', 48, 240, 270.00, 10),
  ('2024-12-06', 'SW123', (SELECT `city_id` FROM `city` WHERE `city_name` = 'Houston'), (SELECT `airport_id` FROM `airport` WHERE `airport_name` = 'HOU Airport'), '12:00:00', (SELECT `city_id` FROM `city` WHERE `city_name` = 'Dallas'), (SELECT `airport_id` FROM `airport` WHERE `airport_name` = 'DFW Airport'), '13:30:00', 44, 90, 150.00, 5),
  ('2024-12-07', 'SW890', (SELECT `city_id` FROM `city` WHERE `city_name` = 'Houston'), (SELECT `airport_id` FROM `airport` WHERE `airport_name` = 'HOU Airport'), '09:00:00', (SELECT `city_id` FROM `city` WHERE `city_name` = 'Dallas'), (SELECT `airport_id` FROM `airport` WHERE `airport_name` = 'DFW Airport'), '10:30:00', 44, 90, 120.00, 11),
  ('2024-12-07', 'AS345', (SELECT `city_id` FROM `city` WHERE `city_name` = 'Dallas'), (SELECT `airport_id` FROM `airport` WHERE `airport_name` = 'DFW Airport'), '14:00:00', (SELECT `city_id` FROM `city` WHERE `city_name` = 'Houston'), (SELECT `airport_id` FROM `airport` WHERE `airport_name` = 'HOU Airport'), '15:30:00', 44, 90, 130.00, 12),
  ('2024-12-06', 'AS789', (SELECT `city_id` FROM `city` WHERE `city_name` = 'Seattle'), (SELECT `airport_id` FROM `airport` WHERE `airport_name` = 'SEA Airport'), '10:00:00', (SELECT `city_id` FROM `city` WHERE `city_name` = 'San Francisco'), (SELECT `airport_id` FROM `airport` WHERE `airport_name` = 'SFO Airport'), '12:00:00', 46, 120, 200.00, 6),
  ('2024-12-08', 'UA678', (SELECT `city_id` FROM `city` WHERE `city_name` = 'Seattle'), (SELECT `airport_id` FROM `airport` WHERE `airport_name` = 'SEA Airport'), '07:00:00', (SELECT `city_id` FROM `city` WHERE `city_name` = 'San Francisco'), (SELECT `airport_id` FROM `airport` WHERE `airport_name` = 'SFO Airport'), '09:00:00', 46, 120, 190.00, 13),
  ('2024-12-08', 'AS123', (SELECT `city_id` FROM `city` WHERE `city_name` = 'San Francisco'), (SELECT `airport_id` FROM `airport` WHERE `airport_name` = 'SFO Airport'), '11:00:00', (SELECT `city_id` FROM `city` WHERE `city_name` = 'Seattle'), (SELECT `airport_id` FROM `airport` WHERE `airport_name` = 'SEA Airport'), '13:00:00', 46, 120, 210.00, 14)
ON DUPLICATE KEY UPDATE `flight_num` = VALUES(`flight_num`);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `username` VARCHAR(10) NOT NULL,
  `password` VARCHAR(16) NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `id` VARCHAR(18) NOT NULL,
  `phone` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB;

-- Insert user records
INSERT INTO `user` (`username`, `password`, `name`, `id`, `phone`)
VALUES 
  ('admin', 'test123', 'Admin User', '1', '857-998-8312'),
  ('user', 'test123', 'Regular User', '2', '834-932-3213')
ON DUPLICATE KEY UPDATE `username` = VALUES(`username`);

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `order_num` VARCHAR(255) NOT NULL,
  `date` DATE NOT NULL,
  `flight_num` VARCHAR(255) NOT NULL,
  `username` VARCHAR(10) NOT NULL,
  `name` VARCHAR(255) DEFAULT NULL COMMENT 'Passenger Name',
  `id` VARCHAR(255) NOT NULL COMMENT 'Passenger ID',
  `phone` VARCHAR(255) DEFAULT NULL COMMENT 'Passenger Phone',
  PRIMARY KEY (`date`, `flight_num`, `id`, `order_num`),
  CONSTRAINT `fk_orders_flight` FOREIGN KEY (`flight_num`, `date`) 
    REFERENCES `flight`(`flight_num`, `date`) 
    ON UPDATE CASCADE 
    ON DELETE RESTRICT,
  CONSTRAINT `fk_orders_user` FOREIGN KEY (`username`) 
    REFERENCES `user`(`username`) 
    ON UPDATE CASCADE 
    ON DELETE RESTRICT
) ENGINE=InnoDB ROW_FORMAT=DYNAMIC;

-- Insert orders records
INSERT INTO `orders` (`order_num`, `date`, `flight_num`, `username`, `name`, `id`, `phone`)
VALUES
  ('20240113093549', '2024-12-05', 'AA123', 'admin', 'Admin User', '1', '857-998-8312'),
  ('20240113093552', '2024-12-06', 'DL789', 'admin', 'Admin User', '1', '857-998-8312')
ON DUPLICATE KEY UPDATE `order_num` = VALUES(`order_num`);

SET FOREIGN_KEY_CHECKS = 1;


-- ================================
-- Functions, Stored Procedures, Triggers, and Events
-- ================================

-- 1. Create function: Calculate flight duration (used_time) in minutes
DROP FUNCTION IF EXISTS `calc_used_time`;
DELIMITER $$
CREATE FUNCTION `calc_used_time`(start_t TIME, end_t TIME)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE duration INT;
    SET duration = TIME_TO_SEC(TIMEDIFF(end_t, start_t)) / 60;
    IF duration < 0 THEN
        SET duration = duration + 1440; -- Handle overnight flights
    END IF;
    RETURN duration;
END$$
DELIMITER ;

-- 2. Create stored procedure: Place an order (sp_place_order)
DROP PROCEDURE IF EXISTS `sp_place_order`;
DELIMITER $$
CREATE PROCEDURE `sp_place_order`(
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
END$$
DELIMITER ;

-- 3. Create trigger: After inserting an order, automatically reduce seat count and update used_time
DROP TRIGGER IF EXISTS `trg_after_order_insert`;
DELIMITER $$
CREATE TRIGGER `trg_after_order_insert`
AFTER INSERT ON `orders`
FOR EACH ROW
BEGIN
    UPDATE `flight` 
    SET 
      `seat_count` = `seat_count` - 1,
      `used_time` = `used_time` + `calc_used_time`(`start_time`, `reach_time`)
    WHERE `flight_num` = NEW.`flight_num` AND `date` = NEW.`date`;
END$$
DELIMITER ;

-- 4. Create event: Daily cleanup of expired flights
DROP EVENT IF EXISTS `evt_clean_old_flights`;
DELIMITER $$
CREATE EVENT `evt_clean_old_flights`
ON SCHEDULE EVERY 1 DAY STARTS '2025-01-01 00:00:00'
DO
BEGIN
    DELETE FROM `flight` WHERE `date` < CURDATE();
END$$
DELIMITER ;
