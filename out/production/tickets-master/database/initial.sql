SET FOREIGN_KEY_CHECKS = 0;

-- Drop existing database if exists
DROP DATABASE IF EXISTS bs_airplane_booking;
CREATE DATABASE bs_airplane_booking;
USE bs_airplane_booking;

-- ----------------------------
-- Table structure for flight
-- ----------------------------
DROP TABLE IF EXISTS flight;
CREATE TABLE flight  (
  date varchar(255) NULL DEFAULT NULL,
  flight_num varchar(255) NOT NULL COMMENT 'Flight Number',
  start_city varchar(255) NOT NULL,
  start_airport varchar(255) NOT NULL,
  start_time varchar(255) NOT NULL,
  reach_city varchar(255) NOT NULL,
  reach_airport varchar(255) NOT NULL,
  reach_time varchar(255) NOT NULL,
  seat_count int(11) NOT NULL,
  used_time varchar(255) NOT NULL DEFAULT '',
  price double(10, 2) NOT NULL,
  id int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (id) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1011 ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of flight
-- ----------------------------
INSERT INTO flight VALUES 
    ('2024-12-05', 'American Airlines AA123', 'New York', 'JFK Airport', '17:00', 'Los Angeles', 'LAX Airport', '20:00', 46, '180', 300.00, 2),
    ('2024-12-05', 'United Airlines UA456', 'Los Angeles', 'LAX Airport', '21:00', 'New York', 'JFK Airport', '05:00', 48, '360', 320.00, 3),
    ('2024-12-06', 'JetBlue Airways JB123', 'New York', 'JFK Airport', '08:00', 'Los Angeles', 'LAX Airport', '11:30', 50, '210', 350.00, 7),
    ('2024-12-06', 'Spirit Airlines SP789', 'Los Angeles', 'LAX Airport', '12:00', 'New York', 'JFK Airport', '20:00', 45, '360', 330.00, 8),
    
    ('2024-12-06', 'Delta Airlines DL789', 'Chicago', 'ORD Airport', '15:00', 'Miami', 'MIA Airport', '19:00', 49, '240', 280.00, 4),
    ('2024-12-07', 'American Airlines AA567', 'Chicago', 'ORD Airport', '10:00', 'Miami', 'MIA Airport', '14:00', 40, '240', 250.00, 9),
    ('2024-12-07', 'Delta Airlines DL123', 'Miami', 'MIA Airport', '16:00', 'Chicago', 'ORD Airport', '20:00', 48, '240', 270.00, 10),
    
    ('2024-12-06', 'Southwest Airlines SW123', 'Houston', 'HOU Airport', '12:00', 'Dallas', 'DFW Airport', '13:30', 44, '90', 150.00, 5),
    ('2024-12-07', 'Southwest Airlines SW890', 'Houston', 'HOU Airport', '09:00', 'Dallas', 'DFW Airport', '10:30', 44, '90', 120.00, 11),
    ('2024-12-07', 'Alaska Airlines AS345', 'Dallas', 'DFW Airport', '14:00', 'Houston', 'HOU Airport', '15:30', 44, '90', 130.00, 12),
    
    ('2024-12-06', 'Alaska Airlines AS789', 'Seattle', 'SEA Airport', '10:00', 'San Francisco', 'SFO Airport', '12:00', 46, '120', 200.00, 6),
    ('2024-12-08', 'United Airlines UA678', 'Seattle', 'SEA Airport', '07:00', 'San Francisco', 'SFO Airport', '09:00', 46, '120', 190.00, 13),
    ('2024-12-08', 'Alaska Airlines AS123', 'San Francisco', 'SFO Airport', '11:00', 'Seattle', 'SEA Airport', '13:00', 46, '120', 210.00, 14);
	
-- ----------------------------

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS orders;
CREATE TABLE orders  (
  order_num varchar(255) NOT NULL,
  date varchar(255) NOT NULL,
  flight_num varchar(255) NOT NULL,
  start_city varchar(255) NOT NULL,
  start_airport varchar(255) NOT NULL,
  reach_city varchar(255) NOT NULL,
  reach_airport varchar(255) NOT NULL,
  username varchar(255) NOT NULL,
  name varchar(255) NULL DEFAULT NULL COMMENT 'Passenger Name',
  id varchar(255) NOT NULL COMMENT 'Passenger ID',
  phone varchar(255) NULL DEFAULT NULL COMMENT 'Passenger Phone',
  PRIMARY KEY (date, flight_num, id, order_num) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO orders VALUES
    ('20240113093549', '2024-12-05', 
		'American Airlines AA123', 'New York', 
        'JFK Airport', 'Los Angeles', 'LAX Airport', 
        'admin', 'Admin User', '1', '857-998-8312'),
    ('20240113093552', '2024-12-06', 
		'Delta Airlines DL789', 'Chicago', 
        'ORD Airport', 'Miami', 'MIA Airport', 
        'admin', 'Admin User', '1', '857-998-8312');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS user;
CREATE TABLE user  (
  username varchar(10) NOT NULL,
  password varchar(16) NOT NULL,
  name varchar(255) NOT NULL,
  id varchar(18) NOT NULL,
  phone varchar(255) NOT NULL,
  PRIMARY KEY (username) USING BTREE
) ENGINE = InnoDB ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO user (username, password, name, id, phone)
VALUES 
    ('admin', 'test123', 'Admin User', '1', '857-998-8312'),
    ('user', 'test123', 'Regular User', '2', '834-932-3213');