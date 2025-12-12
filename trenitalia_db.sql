CREATE DATABASE  IF NOT EXISTS `trenitalia_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `trenitalia_db`;
-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: trenitalia_db
-- ------------------------------------------------------
-- Server version	8.0.44

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
-- Table structure for table `carriage`
--

DROP TABLE IF EXISTS `carriage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `carriage` (
  `ID_CARRIAGE` int NOT NULL AUTO_INCREMENT,
  `Number` int NOT NULL,
  `ID_VEHICLE_FK` int NOT NULL,
  `ID_CLASS_FK` int NOT NULL,
  PRIMARY KEY (`ID_CARRIAGE`),
  UNIQUE KEY `ID_VEHICLE_FK` (`ID_VEHICLE_FK`,`Number`),
  KEY `ID_CLASS_FK` (`ID_CLASS_FK`),
  CONSTRAINT `carriage_ibfk_1` FOREIGN KEY (`ID_VEHICLE_FK`) REFERENCES `vehicle` (`ID_VEHICLE`) ON DELETE CASCADE,
  CONSTRAINT `carriage_ibfk_2` FOREIGN KEY (`ID_CLASS_FK`) REFERENCES `class` (`ID_CLASS`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carriage`
--

LOCK TABLES `carriage` WRITE;
/*!40000 ALTER TABLE `carriage` DISABLE KEYS */;
INSERT INTO `carriage` VALUES (1,1,1,2),(2,2,1,1),(3,1,2,1),(4,1,3,1);
/*!40000 ALTER TABLE `carriage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `class`
--

DROP TABLE IF EXISTS `class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `class` (
  `ID_CLASS` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) NOT NULL,
  PRIMARY KEY (`ID_CLASS`),
  UNIQUE KEY `Name` (`Name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `class`
--

LOCK TABLES `class` WRITE;
/*!40000 ALTER TABLE `class` DISABLE KEYS */;
INSERT INTO `class` VALUES (3,'1^ Classe'),(2,'Business'),(1,'Standard');
/*!40000 ALTER TABLE `class` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `discount_coupon`
--

DROP TABLE IF EXISTS `discount_coupon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `discount_coupon` (
  `ID_DISCOUNT_COUPON` int NOT NULL AUTO_INCREMENT,
  `Code` varchar(50) NOT NULL,
  `Value` decimal(10,2) NOT NULL,
  `Valid_From` date NOT NULL,
  `Valid_To` date NOT NULL,
  PRIMARY KEY (`ID_DISCOUNT_COUPON`),
  UNIQUE KEY `Code` (`Code`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discount_coupon`
--

LOCK TABLES `discount_coupon` WRITE;
/*!40000 ALTER TABLE `discount_coupon` DISABLE KEYS */;
INSERT INTO `discount_coupon` VALUES (1,'SCONTO2025',10.00,'2025-01-01','2025-12-31');
/*!40000 ALTER TABLE `discount_coupon` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `discount_vehicle_type_association`
--

DROP TABLE IF EXISTS `discount_vehicle_type_association`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `discount_vehicle_type_association` (
  `ID_DISCOUNT_COUPON_FK` int NOT NULL,
  `ID_VEHICLE_TYPE_FK` int NOT NULL,
  PRIMARY KEY (`ID_DISCOUNT_COUPON_FK`,`ID_VEHICLE_TYPE_FK`),
  KEY `ID_VEHICLE_TYPE_FK` (`ID_VEHICLE_TYPE_FK`),
  CONSTRAINT `discount_vehicle_type_association_ibfk_1` FOREIGN KEY (`ID_DISCOUNT_COUPON_FK`) REFERENCES `discount_coupon` (`ID_DISCOUNT_COUPON`) ON DELETE CASCADE,
  CONSTRAINT `discount_vehicle_type_association_ibfk_2` FOREIGN KEY (`ID_VEHICLE_TYPE_FK`) REFERENCES `vehicle_type` (`ID_VEHICLE_TYPE`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discount_vehicle_type_association`
--

LOCK TABLES `discount_vehicle_type_association` WRITE;
/*!40000 ALTER TABLE `discount_vehicle_type_association` DISABLE KEYS */;
INSERT INTO `discount_vehicle_type_association` VALUES (1,1);
/*!40000 ALTER TABLE `discount_vehicle_type_association` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fidelity_card`
--

DROP TABLE IF EXISTS `fidelity_card`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fidelity_card` (
  `ID_FIDELITY_CARD` int NOT NULL AUTO_INCREMENT,
  `ID_USER_FK` int NOT NULL,
  `Code` int NOT NULL,
  `CF_Status` varchar(50) NOT NULL DEFAULT 'Bronzo',
  `CF_StatusPoints` float DEFAULT '0',
  `CF_PrizePoints` float DEFAULT '0',
  `CF_StatusPoints_ExpireDate` date NOT NULL,
  `CF_PrizePoints_ExpireDate` date NOT NULL,
  `XGO_Points` float DEFAULT '0',
  `XGO_Points_ExpireDate` date NOT NULL,
  PRIMARY KEY (`ID_FIDELITY_CARD`),
  UNIQUE KEY `ID_USER_FK` (`ID_USER_FK`),
  UNIQUE KEY `Code` (`Code`),
  CONSTRAINT `fidelity_card_ibfk_1` FOREIGN KEY (`ID_USER_FK`) REFERENCES `user` (`ID_USER`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fidelity_card`
--

LOCK TABLES `fidelity_card` WRITE;
/*!40000 ALTER TABLE `fidelity_card` DISABLE KEYS */;
INSERT INTO `fidelity_card` VALUES (1,1,175800424,'Argento',1260.2,512.5,'2025-12-31','2026-05-31',38.9,'2026-12-31');
/*!40000 ALTER TABLE `fidelity_card` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gift_coupon`
--

DROP TABLE IF EXISTS `gift_coupon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gift_coupon` (
  `ID_GIFT_COUPON` int NOT NULL AUTO_INCREMENT,
  `Antifraud_Code` varchar(50) NOT NULL,
  `Value` decimal(10,2) NOT NULL,
  PRIMARY KEY (`ID_GIFT_COUPON`),
  UNIQUE KEY `Antifraud_Code` (`Antifraud_Code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gift_coupon`
--

LOCK TABLES `gift_coupon` WRITE;
/*!40000 ALTER TABLE `gift_coupon` DISABLE KEYS */;
/*!40000 ALTER TABLE `gift_coupon` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `offer`
--

DROP TABLE IF EXISTS `offer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `offer` (
  `ID_OFFER` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL,
  `Refund_Flexibility` varchar(50) NOT NULL,
  `Change_Flexibility` varchar(50) NOT NULL,
  `Price_Multiplier` decimal(4,2) DEFAULT '1.00',
  PRIMARY KEY (`ID_OFFER`),
  UNIQUE KEY `Name` (`Name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offer`
--

LOCK TABLES `offer` WRITE;
/*!40000 ALTER TABLE `offer` DISABLE KEYS */;
INSERT INTO `offer` VALUES (1,'Base','Alta','Media',1.00),(2,'Economy','Bassa','Bassa',0.85),(3,'Super Economy','Nessuna','Nessuna',0.60);
/*!40000 ALTER TABLE `offer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `passenger`
--

DROP TABLE IF EXISTS `passenger`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `passenger` (
  `ID_PASSENGER` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL,
  `Surname` varchar(100) NOT NULL,
  `Cell` varchar(16) DEFAULT NULL,
  `Email` varchar(150) NOT NULL,
  `ID_FIDELITY_CARD_FK` int DEFAULT NULL,
  PRIMARY KEY (`ID_PASSENGER`),
  UNIQUE KEY `ID_FIDELITY_CARD_FK` (`ID_FIDELITY_CARD_FK`),
  CONSTRAINT `passenger_ibfk_1` FOREIGN KEY (`ID_FIDELITY_CARD_FK`) REFERENCES `fidelity_card` (`ID_FIDELITY_CARD`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `passenger`
--

LOCK TABLES `passenger` WRITE;
/*!40000 ALTER TABLE `passenger` DISABLE KEYS */;
INSERT INTO `passenger` VALUES (1,'Mario','Rossi','3315873468','mario.rossi@mail.it',1),(2,'Luisa','Bianchi','3298453128','luisa.bianchi@mail.it',NULL),(3,'Giulia','Verdi','3358476364','giulia.verdi@mail.it',NULL);
/*!40000 ALTER TABLE `passenger` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `price`
--

DROP TABLE IF EXISTS `price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `price` (
  `ID_ROUTE_FK` int NOT NULL,
  `ID_CLASS_FK` int NOT NULL,
  `ID_OFFER_FK` int NOT NULL,
  `Base_Price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`ID_ROUTE_FK`,`ID_CLASS_FK`,`ID_OFFER_FK`),
  KEY `ID_CLASS_FK` (`ID_CLASS_FK`),
  KEY `ID_OFFER_FK` (`ID_OFFER_FK`),
  CONSTRAINT `price_ibfk_1` FOREIGN KEY (`ID_ROUTE_FK`) REFERENCES `route` (`ID_ROUTE`) ON DELETE CASCADE,
  CONSTRAINT `price_ibfk_2` FOREIGN KEY (`ID_CLASS_FK`) REFERENCES `class` (`ID_CLASS`) ON DELETE RESTRICT,
  CONSTRAINT `price_ibfk_3` FOREIGN KEY (`ID_OFFER_FK`) REFERENCES `offer` (`ID_OFFER`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `price`
--

LOCK TABLES `price` WRITE;
/*!40000 ALTER TABLE `price` DISABLE KEYS */;
INSERT INTO `price` VALUES (1,1,1,45.00),(1,2,1,65.00),(1,2,2,55.25),(2,1,1,8.00),(3,1,1,12.50),(3,1,3,7.50);
/*!40000 ALTER TABLE `price` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservation`
--

DROP TABLE IF EXISTS `reservation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservation` (
  `ID_RESERVATION` int NOT NULL AUTO_INCREMENT,
  `PNR_Code` varchar(10) NOT NULL,
  `Purchase_Date_Time` datetime NOT NULL,
  `Status` varchar(20) NOT NULL,
  `Total_Price` decimal(10,2) NOT NULL,
  `ID_USER_FK` int NOT NULL,
  `ID_DISCOUNT_COUPON_FK` int DEFAULT NULL,
  `ID_GIFT_COUPON_FK` int DEFAULT NULL,
  PRIMARY KEY (`ID_RESERVATION`),
  UNIQUE KEY `PNR_Code` (`PNR_Code`),
  UNIQUE KEY `ID_DISCOUNT_COUPON_FK` (`ID_DISCOUNT_COUPON_FK`),
  UNIQUE KEY `ID_GIFT_COUPON_FK` (`ID_GIFT_COUPON_FK`),
  KEY `ID_USER_FK` (`ID_USER_FK`),
  CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`ID_USER_FK`) REFERENCES `user` (`ID_USER`) ON DELETE RESTRICT,
  CONSTRAINT `reservation_ibfk_2` FOREIGN KEY (`ID_DISCOUNT_COUPON_FK`) REFERENCES `discount_coupon` (`ID_DISCOUNT_COUPON`) ON DELETE RESTRICT,
  CONSTRAINT `reservation_ibfk_3` FOREIGN KEY (`ID_GIFT_COUPON_FK`) REFERENCES `gift_coupon` (`ID_GIFT_COUPON`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservation`
--

LOCK TABLES `reservation` WRITE;
/*!40000 ALTER TABLE `reservation` DISABLE KEYS */;
INSERT INTO `reservation` VALUES (1,'AZW3FG','2025-11-20 10:00:00','Pagata',106.25,1,1,NULL),(2,'FGT6YU','2025-11-05 18:00:00','Pagata',7.50,2,NULL,NULL);
/*!40000 ALTER TABLE `reservation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `route`
--

DROP TABLE IF EXISTS `route`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `route` (
  `ID_ROUTE` int NOT NULL AUTO_INCREMENT,
  `Departure_Date_Time` datetime NOT NULL,
  `Arrival_Date_Time` datetime NOT NULL,
  `ID_VEHICLE_FK` int NOT NULL,
  `ID_DEPARTURE_STATION_FK` int NOT NULL,
  `ID_ARRIVAL_STATION_FK` int NOT NULL,
  PRIMARY KEY (`ID_ROUTE`),
  KEY `ID_VEHICLE_FK` (`ID_VEHICLE_FK`),
  KEY `ID_ARRIVAL_STATION_FK` (`ID_ARRIVAL_STATION_FK`),
  KEY `idx_route_departure_time` (`Departure_Date_Time`),
  KEY `idx_route_dep_arr` (`ID_DEPARTURE_STATION_FK`,`ID_ARRIVAL_STATION_FK`),
  CONSTRAINT `route_ibfk_1` FOREIGN KEY (`ID_VEHICLE_FK`) REFERENCES `vehicle` (`ID_VEHICLE`) ON DELETE RESTRICT,
  CONSTRAINT `route_ibfk_2` FOREIGN KEY (`ID_DEPARTURE_STATION_FK`) REFERENCES `station` (`ID_STATION`) ON DELETE RESTRICT,
  CONSTRAINT `route_ibfk_3` FOREIGN KEY (`ID_ARRIVAL_STATION_FK`) REFERENCES `station` (`ID_STATION`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `route`
--

LOCK TABLES `route` WRITE;
/*!40000 ALTER TABLE `route` DISABLE KEYS */;
INSERT INTO `route` VALUES (1,'2025-12-20 08:00:00','2025-12-20 09:10:00',1,1,2),(2,'2025-12-20 09:30:00','2025-12-20 10:20:00',3,2,4),(3,'2025-12-25 15:00:00','2025-12-25 16:30:00',2,3,2);
/*!40000 ALTER TABLE `route` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seat`
--

DROP TABLE IF EXISTS `seat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seat` (
  `ID_SEAT` int NOT NULL AUTO_INCREMENT,
  `Code` varchar(10) NOT NULL,
  `Orientation` varchar(20) DEFAULT NULL,
  `Position` varchar(20) DEFAULT NULL,
  `ID_CARRIAGE_FK` int NOT NULL,
  PRIMARY KEY (`ID_SEAT`),
  UNIQUE KEY `ID_CARRIAGE_FK` (`ID_CARRIAGE_FK`,`Code`),
  CONSTRAINT `seat_ibfk_1` FOREIGN KEY (`ID_CARRIAGE_FK`) REFERENCES `carriage` (`ID_CARRIAGE`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seat`
--

LOCK TABLES `seat` WRITE;
/*!40000 ALTER TABLE `seat` DISABLE KEYS */;
INSERT INTO `seat` VALUES (1,'01A',NULL,NULL,1),(2,'01B',NULL,NULL,1),(3,'02A',NULL,NULL,1),(4,'02B',NULL,NULL,1),(5,'03A',NULL,NULL,1),(6,'03B',NULL,NULL,1),(7,'04A',NULL,NULL,1),(8,'04B',NULL,NULL,1),(9,'05A',NULL,NULL,1),(10,'05B',NULL,NULL,1),(11,'101',NULL,NULL,3),(12,'102',NULL,NULL,3),(13,'103',NULL,NULL,3),(14,'104',NULL,NULL,3),(15,'105',NULL,NULL,3),(16,'05C',NULL,NULL,4),(17,'05D',NULL,NULL,4);
/*!40000 ALTER TABLE `seat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `station`
--

DROP TABLE IF EXISTS `station`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `station` (
  `ID_STATION` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL,
  `City` varchar(100) NOT NULL,
  `Code` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`ID_STATION`),
  UNIQUE KEY `Code` (`Code`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `station`
--

LOCK TABLES `station` WRITE;
/*!40000 ALTER TABLE `station` DISABLE KEYS */;
INSERT INTO `station` VALUES (1,'Milano Centrale','Milano','MI-CEN'),(2,'Bologna Centrale','Bologna','BO-CEN'),(3,'Firenze S.M.N','Firenze','FI-SMN'),(4,'Modena Autostazione','Modena','MO-AUT');
/*!40000 ALTER TABLE `station` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket`
--

DROP TABLE IF EXISTS `ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ticket` (
  `ID_TICKET` int NOT NULL AUTO_INCREMENT,
  `ID_RESERVATION_FK` int NOT NULL,
  `ID_PASSENGER_FK` int NOT NULL,
  PRIMARY KEY (`ID_TICKET`),
  KEY `ID_RESERVATION_FK` (`ID_RESERVATION_FK`),
  KEY `ID_PASSENGER_FK` (`ID_PASSENGER_FK`),
  CONSTRAINT `ticket_ibfk_1` FOREIGN KEY (`ID_RESERVATION_FK`) REFERENCES `reservation` (`ID_RESERVATION`) ON DELETE CASCADE,
  CONSTRAINT `ticket_ibfk_2` FOREIGN KEY (`ID_PASSENGER_FK`) REFERENCES `passenger` (`ID_PASSENGER`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket`
--

LOCK TABLES `ticket` WRITE;
/*!40000 ALTER TABLE `ticket` DISABLE KEYS */;
INSERT INTO `ticket` VALUES (1,1,1),(2,1,2),(3,2,3);
/*!40000 ALTER TABLE `ticket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket_segment`
--

DROP TABLE IF EXISTS `ticket_segment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ticket_segment` (
  `ID_TICKET_SEGMENT` int NOT NULL AUTO_INCREMENT,
  `ID_TICKET_FK` int NOT NULL,
  `ID_ROUTE_FK` int NOT NULL,
  `ID_SEAT_FK` int DEFAULT NULL,
  PRIMARY KEY (`ID_TICKET_SEGMENT`),
  UNIQUE KEY `ID_ROUTE_FK` (`ID_ROUTE_FK`,`ID_SEAT_FK`),
  KEY `ID_TICKET_FK` (`ID_TICKET_FK`),
  KEY `ID_SEAT_FK` (`ID_SEAT_FK`),
  CONSTRAINT `ticket_segment_ibfk_1` FOREIGN KEY (`ID_TICKET_FK`) REFERENCES `ticket` (`ID_TICKET`) ON DELETE CASCADE,
  CONSTRAINT `ticket_segment_ibfk_2` FOREIGN KEY (`ID_ROUTE_FK`) REFERENCES `route` (`ID_ROUTE`) ON DELETE RESTRICT,
  CONSTRAINT `ticket_segment_ibfk_3` FOREIGN KEY (`ID_SEAT_FK`) REFERENCES `seat` (`ID_SEAT`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket_segment`
--

LOCK TABLES `ticket_segment` WRITE;
/*!40000 ALTER TABLE `ticket_segment` DISABLE KEYS */;
INSERT INTO `ticket_segment` VALUES (1,1,1,1),(2,1,2,3),(3,2,1,2),(4,2,2,4),(5,3,3,11);
/*!40000 ALTER TABLE `ticket_segment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `ID_USER` int NOT NULL AUTO_INCREMENT,
  `Username` varchar(15) NOT NULL,
  `Name` varchar(100) NOT NULL,
  `Surname` varchar(100) NOT NULL,
  `CF` varchar(16) DEFAULT NULL,
  `Email` varchar(150) NOT NULL,
  `Cell` varchar(20) DEFAULT NULL,
  `Address` varchar(50) DEFAULT NULL,
  `Password_Salt` varchar(50) NOT NULL,
  `Password_Hash` varchar(255) NOT NULL,
  PRIMARY KEY (`ID_USER`),
  UNIQUE KEY `Username` (`Username`),
  UNIQUE KEY `Email` (`Email`),
  UNIQUE KEY `CF` (`CF`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'mrossi80','Mario','Rossi','RSSMRI80A01H501K','mario.rossi@mail.it',NULL,NULL,'salt_mario','hash_mario'),(2,'gverdi95','Giulia','Verdi','VRDGLI95E01G100R','giulia.verdi@mail.it',NULL,NULL,'salt_giulia','hash_giulia');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicle`
--

DROP TABLE IF EXISTS `vehicle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vehicle` (
  `ID_VEHICLE` int NOT NULL AUTO_INCREMENT,
  `Number` varchar(20) NOT NULL,
  `Company` varchar(100) NOT NULL,
  `Capacity` int DEFAULT NULL,
  `Has_Bike_Space` tinyint(1) DEFAULT '0',
  `Has_Seat_Choice` tinyint(1) DEFAULT '0',
  `ID_VEHICLE_TYPE_FK` int NOT NULL,
  PRIMARY KEY (`ID_VEHICLE`),
  UNIQUE KEY `Number` (`Number`),
  KEY `ID_VEHICLE_TYPE_FK` (`ID_VEHICLE_TYPE_FK`),
  CONSTRAINT `vehicle_ibfk_1` FOREIGN KEY (`ID_VEHICLE_TYPE_FK`) REFERENCES `vehicle_type` (`ID_VEHICLE_TYPE`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicle`
--

LOCK TABLES `vehicle` WRITE;
/*!40000 ALTER TABLE `vehicle` DISABLE KEYS */;
INSERT INTO `vehicle` VALUES (1,'FR9510','Trenitalia',450,0,1,1),(2,'RV2123','Trenitalia',300,0,0,2),(3,'BUS-A1','TPER',50,0,0,3);
/*!40000 ALTER TABLE `vehicle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicle_type`
--

DROP TABLE IF EXISTS `vehicle_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vehicle_type` (
  `ID_VEHICLE_TYPE` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL,
  PRIMARY KEY (`ID_VEHICLE_TYPE`),
  UNIQUE KEY `Name` (`Name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicle_type`
--

LOCK TABLES `vehicle_type` WRITE;
/*!40000 ALTER TABLE `vehicle_type` DISABLE KEYS */;
INSERT INTO `vehicle_type` VALUES (3,'Bus Extraurbano'),(1,'Frecciarossa ETR 500'),(2,'Regionale Veloce');
/*!40000 ALTER TABLE `vehicle_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicle_type_class_association`
--

DROP TABLE IF EXISTS `vehicle_type_class_association`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vehicle_type_class_association` (
  `ID_VEHICLE_TYPE_FK` int NOT NULL,
  `ID_CLASS_FK` int NOT NULL,
  PRIMARY KEY (`ID_VEHICLE_TYPE_FK`,`ID_CLASS_FK`),
  KEY `ID_CLASS_FK` (`ID_CLASS_FK`),
  CONSTRAINT `vehicle_type_class_association_ibfk_1` FOREIGN KEY (`ID_VEHICLE_TYPE_FK`) REFERENCES `vehicle_type` (`ID_VEHICLE_TYPE`) ON DELETE CASCADE,
  CONSTRAINT `vehicle_type_class_association_ibfk_2` FOREIGN KEY (`ID_CLASS_FK`) REFERENCES `class` (`ID_CLASS`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicle_type_class_association`
--

LOCK TABLES `vehicle_type_class_association` WRITE;
/*!40000 ALTER TABLE `vehicle_type_class_association` DISABLE KEYS */;
INSERT INTO `vehicle_type_class_association` VALUES (1,1),(2,1),(3,1),(1,2);
/*!40000 ALTER TABLE `vehicle_type_class_association` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-12 19:02:46
