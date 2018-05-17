CREATE DATABASE  IF NOT EXISTS `lose_weight_pr2_db` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `lose_weight_pr2_db`;
-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: lose_weight_pr2_db
-- ------------------------------------------------------
-- Server version	5.7.21-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `bmi`
--

DROP TABLE IF EXISTS `bmi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bmi` (
  `bmiID` int(11) NOT NULL AUTO_INCREMENT,
  `weight` double NOT NULL,
  `height` double NOT NULL,
  `age` tinyint(2) NOT NULL,
  `gender` varchar(1) CHARACTER SET latin1 NOT NULL,
  `bmi` double NOT NULL,
  `classification` varchar(25) CHARACTER SET latin1 NOT NULL,
  `bmr` double NOT NULL,
  `emr` double NOT NULL,
  `dateTimePosted` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `metaID` int(11) NOT NULL,
  PRIMARY KEY (`bmiID`),
  KEY `FK_bmi_meta_idx` (`metaID`),
  CONSTRAINT `FK_bmi_meta` FOREIGN KEY (`metaID`) REFERENCES `metabolic_rate` (`metaID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bmi`
--

LOCK TABLES `bmi` WRITE;
/*!40000 ALTER TABLE `bmi` DISABLE KEYS */;
INSERT INTO `bmi` VALUES (1,75,1.75,33,'M',24.49,'Optimal',1744.1,0,'2018-05-12 17:34:16',1),(2,77,1.64,29,'F',28.63,'Overweight',1553.1,0,'2018-05-12 17:34:16',1),(3,85,1.75,30,'F',27.76,'Overweight',1645,0,'2018-05-12 17:34:16',1),(4,75,1.75,33,'M',24.49,'Optimal',1744.1,0,'2018-05-12 17:34:16',1),(5,64,1.64,29,'F',23.8,'Optimal',1565.6,0,'2018-05-12 17:34:16',1),(6,70,1.75,33,'M',22.86,'Optimal',1675.6,0,'2018-05-12 17:34:16',1);
/*!40000 ALTER TABLE `bmi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `metabolic_rate`
--

DROP TABLE IF EXISTS `metabolic_rate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `metabolic_rate` (
  `metaID` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(100) NOT NULL,
  `modifier` float NOT NULL,
  PRIMARY KEY (`metaID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metabolic_rate`
--

LOCK TABLES `metabolic_rate` WRITE;
/*!40000 ALTER TABLE `metabolic_rate` DISABLE KEYS */;
INSERT INTO `metabolic_rate` VALUES (1,'Sedentary',1.2),(2,'Lightly active',1.375),(3,'Moderately active',1.55),(4,'Very active',1.725),(5,'Extremely active',1.9);
/*!40000 ALTER TABLE `metabolic_rate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `private_message`
--

DROP TABLE IF EXISTS `private_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `private_message` (
  `private_messageID` int(11) NOT NULL AUTO_INCREMENT,
  `dateSubmission` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `messageData` varchar(250) NOT NULL,
  `isRead` tinyint(1) NOT NULL DEFAULT '0',
  `senderID` int(11) NOT NULL,
  `receiverID` int(11) NOT NULL,
  PRIMARY KEY (`private_messageID`),
  KEY `senderID` (`senderID`),
  KEY `receiverID` (`receiverID`),
  CONSTRAINT `private_message_ibfk_1` FOREIGN KEY (`senderID`) REFERENCES `user` (`userID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `private_message_ibfk_2` FOREIGN KEY (`receiverID`) REFERENCES `user` (`userID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `private_message`
--

LOCK TABLES `private_message` WRITE;
/*!40000 ALTER TABLE `private_message` DISABLE KEYS */;
INSERT INTO `private_message` VALUES (1,'2018-05-14 11:24:14','τεστ',0,1,1),(2,'2018-05-14 11:33:56','Τεστ τεστ',0,7,1),(3,'2018-05-14 12:32:13','Τεστ τεστ τεστ',1,7,1),(4,'2018-05-14 12:32:13','Τεστ\r\nτεστ',1,7,1),(5,'2018-05-14 12:26:53','Είσαι καραγκιόζης\r\n\r\nκαι βλάκας',0,1,7);
/*!40000 ALTER TABLE `private_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role` (
  `roleID` int(11) NOT NULL AUTO_INCREMENT,
  `roleName` varchar(15) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`roleID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'GOD'),(2,'ADMIN'),(3,'STANDARD_USER');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `topic`
--

DROP TABLE IF EXISTS `topic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `topic` (
  `topicID` int(11) NOT NULL,
  `subject` varchar(200) NOT NULL,
  `dateSubmission` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `postedBy` int(11) NOT NULL,
  PRIMARY KEY (`topicID`),
  KEY `FK_topic_user_idx` (`postedBy`),
  CONSTRAINT `FK_topic_user` FOREIGN KEY (`postedBy`) REFERENCES `user` (`userID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `topic`
--

LOCK TABLES `topic` WRITE;
/*!40000 ALTER TABLE `topic` DISABLE KEYS */;
/*!40000 ALTER TABLE `topic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `topic_message`
--

DROP TABLE IF EXISTS `topic_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `topic_message` (
  `topic_messageID` int(11) NOT NULL,
  `messageData` varchar(2000) NOT NULL,
  `dateSubmission` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `postedBy` int(11) NOT NULL,
  `topicID` int(11) NOT NULL,
  PRIMARY KEY (`topic_messageID`),
  KEY `FK_topicmessage_user_idx` (`postedBy`),
  KEY `FK_topicmessage_topic_idx` (`topicID`),
  CONSTRAINT `FK_topicmessage_topic` FOREIGN KEY (`topicID`) REFERENCES `topic` (`topicID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_topicmessage_user` FOREIGN KEY (`postedBy`) REFERENCES `user` (`userID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `topic_message`
--

LOCK TABLES `topic_message` WRITE;
/*!40000 ALTER TABLE `topic_message` DISABLE KEYS */;
/*!40000 ALTER TABLE `topic_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `userID` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(25) CHARACTER SET latin1 NOT NULL,
  `password` varchar(25) CHARACTER SET latin1 NOT NULL,
  `isBanned` tinyint(1) NOT NULL DEFAULT '0',
  `roleID` int(11) NOT NULL,
  PRIMARY KEY (`userID`),
  KEY `roleID` (`roleID`),
  CONSTRAINT `user_ibfk_2` FOREIGN KEY (`roleID`) REFERENCES `role` (`roleID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'admin','aDmI3$',0,1),(7,'user1','123',0,3);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_bmis`
--

DROP TABLE IF EXISTS `users_bmis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_bmis` (
  `id` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `bmiID` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_usersbmis_user_idx` (`userID`),
  KEY `FK_usersbmis_bmi_idx` (`bmiID`),
  CONSTRAINT `FK_usersbmis_bmi` FOREIGN KEY (`bmiID`) REFERENCES `bmi` (`bmiID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_usersbmis_user` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_bmis`
--

LOCK TABLES `users_bmis` WRITE;
/*!40000 ALTER TABLE `users_bmis` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_bmis` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-05-14 16:20:13
