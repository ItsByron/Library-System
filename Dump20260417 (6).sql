-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: librarysystemfinal
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
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin` (
  `Admin_ID` int NOT NULL AUTO_INCREMENT,
  `Admin_Username` varchar(100) NOT NULL,
  `Password` varchar(255) NOT NULL,
  PRIMARY KEY (`Admin_ID`),
  UNIQUE KEY `Admin_Username` (`Admin_Username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES (1,'admin','123');
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `author`
--

DROP TABLE IF EXISTS `author`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `author` (
  `Author_ID` int NOT NULL AUTO_INCREMENT,
  `Author_Name` varchar(255) NOT NULL,
  PRIMARY KEY (`Author_ID`),
  UNIQUE KEY `Author_Name` (`Author_Name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `author`
--

LOCK TABLES `author` WRITE;
/*!40000 ALTER TABLE `author` DISABLE KEYS */;
INSERT INTO `author` VALUES (9,'Dan Brown'),(6,'F. Scott Fitzgerald'),(7,'George Orwell'),(1,'Harper Lee'),(3,'J.K. Rowling'),(4,'J.R.R. Tolkien'),(2,'Paulo Coelho'),(8,'test'),(5,'Test Author'),(10,'Yuval Noah Harari');
/*!40000 ALTER TABLE `author` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book_status`
--

DROP TABLE IF EXISTS `book_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book_status` (
  `Book_Status_ID` int NOT NULL AUTO_INCREMENT,
  `Book_Status_Name` varchar(30) NOT NULL,
  PRIMARY KEY (`Book_Status_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book_status`
--

LOCK TABLES `book_status` WRITE;
/*!40000 ALTER TABLE `book_status` DISABLE KEYS */;
INSERT INTO `book_status` VALUES (1,'Available'),(2,'Borrowed');
/*!40000 ALTER TABLE `book_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bookcopy`
--

DROP TABLE IF EXISTS `bookcopy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookcopy` (
  `BookCopy_ID` int NOT NULL AUTO_INCREMENT,
  `Book_ID` int DEFAULT NULL,
  `Book_Status_ID` int DEFAULT '1',
  PRIMARY KEY (`BookCopy_ID`),
  KEY `Book_ID` (`Book_ID`),
  KEY `Book_Status_ID` (`Book_Status_ID`),
  CONSTRAINT `bookcopy_ibfk_1` FOREIGN KEY (`Book_ID`) REFERENCES `books` (`Book_ID`),
  CONSTRAINT `bookcopy_ibfk_2` FOREIGN KEY (`Book_Status_ID`) REFERENCES `book_status` (`Book_Status_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookcopy`
--

LOCK TABLES `bookcopy` WRITE;
/*!40000 ALTER TABLE `bookcopy` DISABLE KEYS */;
INSERT INTO `bookcopy` VALUES (1,1,2),(2,1,2),(3,1,1),(4,2,1),(5,2,1),(6,3,1),(7,4,1),(9,6,1),(10,6,1),(11,7,1),(12,7,1),(13,7,1);
/*!40000 ALTER TABLE `bookcopy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `books`
--

DROP TABLE IF EXISTS `books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `books` (
  `Book_ID` int NOT NULL AUTO_INCREMENT,
  `Book_Title` varchar(255) NOT NULL,
  `Publication_Year` int DEFAULT NULL,
  `Isbn` varchar(20) DEFAULT NULL,
  `Author_ID` int DEFAULT NULL,
  `Category_ID` int DEFAULT NULL,
  PRIMARY KEY (`Book_ID`),
  UNIQUE KEY `Isbn` (`Isbn`),
  KEY `Author_ID` (`Author_ID`),
  KEY `Category_ID` (`Category_ID`),
  CONSTRAINT `books_ibfk_1` FOREIGN KEY (`Author_ID`) REFERENCES `author` (`Author_ID`),
  CONSTRAINT `books_ibfk_2` FOREIGN KEY (`Category_ID`) REFERENCES `category` (`Category_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books`
--

LOCK TABLES `books` WRITE;
/*!40000 ALTER TABLE `books` DISABLE KEYS */;
INSERT INTO `books` VALUES (1,'The Great Gatsby',1925,'9780743273565',6,1),(2,'1984',1949,'9780451524935',7,1),(3,'To Kill a Mockingbird',1950,'9780061120084',1,1),(4,'The Hobbit',1937,'9780547928227',4,6),(6,'The Da Vinci Code',2003,'9780307474278',9,7),(7,'Sapiens: A Brief History of Humankind',2003,'9780062316097',10,4);
/*!40000 ALTER TABLE `books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `borrow_status`
--

DROP TABLE IF EXISTS `borrow_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `borrow_status` (
  `Borrow_Status_ID` int NOT NULL AUTO_INCREMENT,
  `Borrow_Status_Name` varchar(30) NOT NULL,
  PRIMARY KEY (`Borrow_Status_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `borrow_status`
--

LOCK TABLES `borrow_status` WRITE;
/*!40000 ALTER TABLE `borrow_status` DISABLE KEYS */;
INSERT INTO `borrow_status` VALUES (1,'Borrowed'),(2,'Returned'),(3,'Overdue');
/*!40000 ALTER TABLE `borrow_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `borrowdetails`
--

DROP TABLE IF EXISTS `borrowdetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `borrowdetails` (
  `BorrowDetails_ID` int NOT NULL AUTO_INCREMENT,
  `Borrow_ID` int DEFAULT NULL,
  `BookCopy_ID` int DEFAULT NULL,
  `Return_Date` date DEFAULT NULL,
  `Borrow_Status_ID` int DEFAULT '1',
  PRIMARY KEY (`BorrowDetails_ID`),
  KEY `Borrow_ID` (`Borrow_ID`),
  KEY `BookCopy_ID` (`BookCopy_ID`),
  KEY `Borrow_Status_ID` (`Borrow_Status_ID`),
  CONSTRAINT `borrowdetails_ibfk_1` FOREIGN KEY (`Borrow_ID`) REFERENCES `borrowrecord` (`Borrow_ID`),
  CONSTRAINT `borrowdetails_ibfk_2` FOREIGN KEY (`BookCopy_ID`) REFERENCES `bookcopy` (`BookCopy_ID`),
  CONSTRAINT `borrowdetails_ibfk_3` FOREIGN KEY (`Borrow_Status_ID`) REFERENCES `borrow_status` (`Borrow_Status_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `borrowdetails`
--

LOCK TABLES `borrowdetails` WRITE;
/*!40000 ALTER TABLE `borrowdetails` DISABLE KEYS */;
INSERT INTO `borrowdetails` VALUES (5,5,3,'2026-04-17',2),(7,7,2,NULL,1);
/*!40000 ALTER TABLE `borrowdetails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `borrowrecord`
--

DROP TABLE IF EXISTS `borrowrecord`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `borrowrecord` (
  `Borrow_ID` int NOT NULL AUTO_INCREMENT,
  `Member_ID` int DEFAULT NULL,
  `Borrow_Date` date DEFAULT NULL,
  `Due_Date` date DEFAULT NULL,
  PRIMARY KEY (`Borrow_ID`),
  KEY `Member_ID` (`Member_ID`),
  CONSTRAINT `borrowrecord_ibfk_1` FOREIGN KEY (`Member_ID`) REFERENCES `members` (`Member_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `borrowrecord`
--

LOCK TABLES `borrowrecord` WRITE;
/*!40000 ALTER TABLE `borrowrecord` DISABLE KEYS */;
INSERT INTO `borrowrecord` VALUES (5,5,'2026-04-17','2026-05-01'),(7,6,'2026-04-17','2026-05-01');
/*!40000 ALTER TABLE `borrowrecord` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `Category_ID` int NOT NULL AUTO_INCREMENT,
  `Category_Name` varchar(50) NOT NULL,
  PRIMARY KEY (`Category_ID`),
  UNIQUE KEY `Category_Name` (`Category_Name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (6,'Fantasy'),(1,'Fiction'),(4,'History'),(7,'Mystery'),(2,'Non-Fiction'),(5,'Philosophy'),(3,'Science');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fines`
--

DROP TABLE IF EXISTS `fines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fines` (
  `Fines_ID` int NOT NULL AUTO_INCREMENT,
  `Borrow_ID` int DEFAULT NULL,
  `Fine_Amount` decimal(10,2) DEFAULT '0.00',
  `Fine_Status_ID` int DEFAULT '1',
  `Issued_Date` date DEFAULT NULL,
  `Paid_Date` date DEFAULT NULL,
  PRIMARY KEY (`Fines_ID`),
  KEY `Borrow_ID` (`Borrow_ID`),
  KEY `Fine_Status_ID` (`Fine_Status_ID`),
  CONSTRAINT `fines_ibfk_1` FOREIGN KEY (`Borrow_ID`) REFERENCES `borrowdetails` (`BorrowDetails_ID`),
  CONSTRAINT `fines_ibfk_2` FOREIGN KEY (`Fine_Status_ID`) REFERENCES `fines_status` (`Fine_Status_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fines`
--

LOCK TABLES `fines` WRITE;
/*!40000 ALTER TABLE `fines` DISABLE KEYS */;
/*!40000 ALTER TABLE `fines` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fines_status`
--

DROP TABLE IF EXISTS `fines_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fines_status` (
  `Fine_Status_ID` int NOT NULL AUTO_INCREMENT,
  `Fine_Status_Name` varchar(30) NOT NULL,
  PRIMARY KEY (`Fine_Status_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fines_status`
--

LOCK TABLES `fines_status` WRITE;
/*!40000 ALTER TABLE `fines_status` DISABLE KEYS */;
INSERT INTO `fines_status` VALUES (1,'Unpaid'),(2,'Paid'),(3,'Waived');
/*!40000 ALTER TABLE `fines_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member_status`
--

DROP TABLE IF EXISTS `member_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member_status` (
  `Member_Status_ID` int NOT NULL AUTO_INCREMENT,
  `Member_Status_Name` varchar(30) NOT NULL,
  PRIMARY KEY (`Member_Status_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member_status`
--

LOCK TABLES `member_status` WRITE;
/*!40000 ALTER TABLE `member_status` DISABLE KEYS */;
INSERT INTO `member_status` VALUES (1,'Active'),(2,'Restricted');
/*!40000 ALTER TABLE `member_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `members`
--

DROP TABLE IF EXISTS `members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `members` (
  `Member_ID` int NOT NULL AUTO_INCREMENT,
  `Member_Name` varchar(255) NOT NULL,
  `Email` varchar(255) DEFAULT NULL,
  `Contact_Number` varchar(20) DEFAULT NULL,
  `Date_Joined` date DEFAULT NULL,
  `Member_Status_ID` int DEFAULT '1',
  PRIMARY KEY (`Member_ID`),
  UNIQUE KEY `Email` (`Email`),
  UNIQUE KEY `Contact_Number` (`Contact_Number`),
  KEY `Member_Status_ID` (`Member_Status_ID`),
  CONSTRAINT `members_ibfk_1` FOREIGN KEY (`Member_Status_ID`) REFERENCES `member_status` (`Member_Status_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `members`
--

LOCK TABLES `members` WRITE;
/*!40000 ALTER TABLE `members` DISABLE KEYS */;
INSERT INTO `members` VALUES (5,'Ashleigh Mahaguay','asheligh@gmail.com','09213716362','2026-04-17',1),(6,'Jhon Carlo','jcsaguid@gmail.com','09198848114','2026-04-17',1);
/*!40000 ALTER TABLE `members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vw_bookswithdetails`
--

DROP TABLE IF EXISTS `vw_bookswithdetails`;
/*!50001 DROP VIEW IF EXISTS `vw_bookswithdetails`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_bookswithdetails` AS SELECT 
 1 AS `Book_ID`,
 1 AS `Book_Title`,
 1 AS `Publication_Year`,
 1 AS `Isbn`,
 1 AS `Author_ID`,
 1 AS `Author_Name`,
 1 AS `Category_ID`,
 1 AS `Category_Name`,
 1 AS `BookCopy_ID`,
 1 AS `Book_Status_Name`,
 1 AS `Book_Status_ID`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_memberborrowedbooks`
--

DROP TABLE IF EXISTS `vw_memberborrowedbooks`;
/*!50001 DROP VIEW IF EXISTS `vw_memberborrowedbooks`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_memberborrowedbooks` AS SELECT 
 1 AS `Transaction_ID`,
 1 AS `Member_ID`,
 1 AS `Member_Name`,
 1 AS `Book_ID`,
 1 AS `BookCopy_ID`,
 1 AS `Book_Title`,
 1 AS `Book_Author`,
 1 AS `Book_Genre`,
 1 AS `Borrow_Date`,
 1 AS `Due_Date`,
 1 AS `Return_Date`,
 1 AS `Status`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'librarysystemfinal'
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_AddBook` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_AddBook`(
    IN p_Title      VARCHAR(255),
    IN p_AuthorName VARCHAR(255),
    IN p_Isbn       VARCHAR(20),
    IN p_Category   VARCHAR(50),
    IN p_Year       INT,
    IN p_CopyCount  INT
)
BEGIN
    DECLARE v_AuthorID   INT;
    DECLARE v_CategoryID INT;
    DECLARE v_BookID     INT;
    DECLARE i            INT DEFAULT 0;

    SELECT Author_ID INTO v_AuthorID FROM Author WHERE Author_Name = p_AuthorName LIMIT 1;
    IF v_AuthorID IS NULL THEN
        INSERT INTO Author(Author_Name) VALUES(p_AuthorName);
        SET v_AuthorID = LAST_INSERT_ID();
    END IF;

    SELECT Category_ID INTO v_CategoryID FROM Category WHERE Category_Name = p_Category LIMIT 1;
    IF v_CategoryID IS NULL THEN
        INSERT INTO Category(Category_Name) VALUES(p_Category);
        SET v_CategoryID = LAST_INSERT_ID();
    END IF;

    INSERT INTO Books(Book_Title, Publication_Year, Isbn, Author_ID, Category_ID)
    VALUES(p_Title, p_Year, NULLIF(p_Isbn,''), v_AuthorID, v_CategoryID);

    SET v_BookID = LAST_INSERT_ID();

    WHILE i < p_CopyCount DO
        INSERT INTO BookCopy(Book_ID, Book_Status_ID) VALUES(v_BookID, 1);
        SET i = i + 1;
    END WHILE;

    SELECT 'success' AS status, 'Book added successfully!' AS message;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_AddMember` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_AddMember`(
    IN p_Name           VARCHAR(255),
    IN p_Email          VARCHAR(255),
    IN p_Contact_Number VARCHAR(20),
    IN p_Date_Joined    DATE
)
BEGIN
    INSERT INTO Members(Member_Name, Email, Contact_Number, Date_Joined, Member_Status_ID)
    VALUES(p_Name, NULLIF(p_Email,''), NULLIF(p_Contact_Number,''), p_Date_Joined, 1);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_AdminLogin` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_AdminLogin`(
    IN p_Username VARCHAR(50),
    IN p_Password VARCHAR(100)
)
BEGIN
    SELECT *
    FROM Admin
    WHERE Admin_Username = p_Username
      AND Password = p_Password
    LIMIT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_BorrowBook` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_BorrowBook`(
    IN p_BookCopy_ID INT,
    IN p_Member_ID   INT,
    IN p_Borrow_Date DATE,
    IN p_Due_Date    DATE
)
BEGIN
    DECLARE v_CopyStatus   INT;
    DECLARE v_BorrowCount  INT;
    DECLARE v_SameBook     INT;
    DECLARE v_BookID       INT;
    DECLARE v_MemberStatus INT;
    DECLARE v_BorrowID     INT;

    SELECT Member_Status_ID INTO v_MemberStatus
    FROM Members
    WHERE Member_ID = p_Member_ID;

    SELECT Book_Status_ID INTO v_CopyStatus
    FROM BookCopy
    WHERE BookCopy_ID = p_BookCopy_ID;

    SELECT Book_ID INTO v_BookID
    FROM BookCopy
    WHERE BookCopy_ID = p_BookCopy_ID;

    -- Count how many books this member currently has borrowed and not returned
    SELECT COUNT(*) INTO v_BorrowCount
    FROM BorrowDetails bd
    INNER JOIN BorrowRecord br ON bd.Borrow_ID = br.Borrow_ID
    WHERE br.Member_ID = p_Member_ID
      AND bd.Return_Date IS NULL;

    -- Check if member already has a copy of this same book
    SELECT COUNT(*) INTO v_SameBook
    FROM BorrowDetails bd
    INNER JOIN BorrowRecord  br ON bd.Borrow_ID  = br.Borrow_ID
    INNER JOIN BookCopy      bc ON bd.BookCopy_ID = bc.BookCopy_ID
    WHERE br.Member_ID   = p_Member_ID
      AND bc.Book_ID     = v_BookID
      AND bd.Return_Date IS NULL;

    IF v_MemberStatus <> 1 THEN
        SELECT 'error' AS status, 'Member is not active!' AS message;

    ELSEIF v_CopyStatus <> 1 THEN
        SELECT 'error' AS status, 'Book copy is not available!' AS message;

    ELSEIF v_BorrowCount >= 3 THEN
        SELECT 'error' AS status, 'Member already has 3 books borrowed (maximum)!' AS message;

    ELSEIF v_SameBook > 0 THEN
        SELECT 'error' AS status, 'Member already has a copy of this book!' AS message;

    ELSE
        -- Create the borrow record header
        INSERT INTO BorrowRecord(Member_ID, Borrow_Date, Due_Date)
        VALUES(p_Member_ID, p_Borrow_Date, p_Due_Date);

        SET v_BorrowID = LAST_INSERT_ID();

        -- Create the borrow detail line
        INSERT INTO BorrowDetails(Borrow_ID, BookCopy_ID, Borrow_Status_ID)
        VALUES(v_BorrowID, p_BookCopy_ID, 1);

        -- Mark this copy as Borrowed
        UPDATE BookCopy
        SET Book_Status_ID = 2
        WHERE BookCopy_ID = p_BookCopy_ID;

        SELECT 'success' AS status, 'Book borrowed successfully!' AS message;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_CheckBorrowedBooksPerMemberID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_CheckBorrowedBooksPerMemberID`(
	 IN p_Member_ID INT
)
BEGIN
SELECT  
    br.Borrow_ID,
    bd.BorrowDetails_ID,
    bd.Borrow_Status_ID,
    m.Member_Name,
    bs.Borrow_Status_Name
FROM members m
LEFT JOIN borrowrecord br
    ON m.Member_ID = br.Member_ID
LEFT JOIN borrowdetails bd
    ON br.Borrow_ID = bd.Borrow_ID
LEFT JOIN borrow_status bs
    ON bd.Borrow_Status_ID = bs.Borrow_Status_ID
WHERE m.Member_ID = p_Member_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_DeleteBook` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_DeleteBook`(IN p_Book_ID INT)
BEGIN
    DECLARE v_BorrowCount INT;

    -- Check if any copy is currently borrowed
    SELECT COUNT(*) INTO v_BorrowCount
    FROM BorrowDetails bd
    INNER JOIN BookCopy bc ON bd.BookCopy_ID = bc.BookCopy_ID
    WHERE bc.Book_ID = p_Book_ID
      AND bd.Return_Date IS NULL;

    IF v_BorrowCount > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot delete a book that has copies currently borrowed!';
    ELSE

        DELETE FROM BookCopy WHERE Book_ID = p_Book_ID;


        DELETE FROM Books WHERE Book_ID = p_Book_ID;

        SELECT 'success' AS status, 'Book deleted successfully!' AS message;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_DeleteMember` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_DeleteMember`(IN p_Member_ID INT)
BEGIN
   DECLARE hasOtherStatus INT;

    -- Check if ANY record is NOT returned
    SELECT EXISTS (
        SELECT 1
        FROM BorrowDetails bd
        INNER JOIN BorrowRecord br 
            ON bd.Borrow_ID = br.Borrow_ID
        WHERE br.Member_ID = p_Member_ID
          AND bd.Borrow_Status_ID <> 2
    ) INTO hasOtherStatus;

    IF hasOtherStatus = 0 THEN

        -- ✅ All records are status = 2 → delete

        DELETE FROM BorrowDetails
        WHERE Borrow_ID IN (
            SELECT Borrow_ID 
            FROM BorrowRecord 
            WHERE Member_ID = p_Member_ID
        );

        DELETE FROM BorrowRecord
        WHERE Member_ID = p_Member_ID;

        DELETE FROM Members
        WHERE Member_ID = p_Member_ID;

        SELECT 0 AS unreturned_count, 
               'Member deleted successfully!' AS message;

    ELSE

        -- ❌ Found at least one not equal to 2
        SELECT COUNT(*) AS unreturned_count,
               'Cannot delete — some records are not returned' AS message
        FROM BorrowDetails bd
        INNER JOIN BorrowRecord br 
            ON bd.Borrow_ID = br.Borrow_ID
        WHERE br.Member_ID = p_Member_ID
          AND bd.Borrow_Status_ID <> 2;

    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_GetAllBooks` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetAllBooks`()
BEGIN
    SELECT
        b.Book_ID,
        b.Book_Title,
        b.Publication_Year,
        b.Isbn,
        a.Author_ID,
        a.Author_Name,
        c.Category_ID,
        c.Category_Name,
        bc.BookCopy_ID,
        bs.Book_Status_ID,
        bs.Book_Status_Name
    FROM Books b
    INNER JOIN Author      a  ON b.Author_ID      = a.Author_ID
    INNER JOIN Category    c  ON b.Category_ID    = c.Category_ID
    INNER JOIN BookCopy    bc ON bc.Book_ID        = b.Book_ID
    INNER JOIN Book_Status bs ON bc.Book_Status_ID = bs.Book_Status_ID
    ORDER BY b.Book_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_GetAllFines` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetAllFines`()
BEGIN
    SELECT
        f.Fines_ID,
        f.Borrow_ID         AS Transaction_ID,
        f.Fine_Amount,
        f.Issued_Date,
        f.Paid_Date,
        fs.Fine_Status_Name AS Fine_Status,
        m.Member_ID,
        m.Member_Name,
        b.Book_Title
    FROM Fines f
    INNER JOIN Fines_Status  fs ON f.Fine_Status_ID  = fs.Fine_Status_ID
    INNER JOIN BorrowDetails bd ON f.Borrow_ID       = bd.BorrowDetails_ID
    INNER JOIN BorrowRecord  br ON bd.Borrow_ID      = br.Borrow_ID
    INNER JOIN BookCopy      bc ON bd.BookCopy_ID    = bc.BookCopy_ID
    INNER JOIN Books          b ON bc.Book_ID        = b.Book_ID
    INNER JOIN Members        m ON br.Member_ID      = m.Member_ID
    ORDER BY f.Fines_ID DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_GetAllMembers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetAllMembers`()
BEGIN
    SELECT
        m.Member_ID,
        m.Member_Name,
        m.Email,
        m.Contact_Number,
        m.Date_Joined,
        ms.Member_Status_ID,
        ms.Member_Status_Name
    FROM Members m
    INNER JOIN Member_Status ms ON m.Member_Status_ID = ms.Member_Status_ID
    ORDER BY m.Member_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_GetAllTransactions` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetAllTransactions`()
BEGIN
    SELECT
        bd.BorrowDetails_ID AS Transaction_ID,
        b.Book_ID,
        bc.BookCopy_ID,
        b.Book_Title        AS Title,
        m.Member_ID,
        m.Member_Name       AS Name,
        br.Borrow_Date,
        br.Due_Date,
        bd.Return_Date,
        IF(bd.Return_Date IS NOT NULL, 'Returned',
            IF(CURDATE() > br.Due_Date, 'Overdue', 'Borrowed')
        ) AS Status
    FROM BorrowDetails bd
    INNER JOIN BorrowRecord br ON bd.Borrow_ID   = br.Borrow_ID
    INNER JOIN BookCopy     bc ON bd.BookCopy_ID  = bc.BookCopy_ID
    INNER JOIN Books         b ON bc.Book_ID      = b.Book_ID
    INNER JOIN Members       m ON br.Member_ID    = m.Member_ID
    ORDER BY bd.BorrowDetails_ID DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_GetBorrowedBooks` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetBorrowedBooks`()
BEGIN
    SELECT
        bd.BorrowDetails_ID AS Transaction_ID,
        bc.BookCopy_ID,
        b.Book_ID,
        b.Book_Title        AS Title,
        a.Author_Name       AS Author,
        c.Category_Name     AS Genre,
        m.Member_ID,
        m.Member_Name       AS Name,
        br.Borrow_Date,
        br.Due_Date
    FROM BorrowDetails bd
    INNER JOIN BorrowRecord br ON bd.Borrow_ID   = br.Borrow_ID
    INNER JOIN BookCopy     bc ON bd.BookCopy_ID  = bc.BookCopy_ID
    INNER JOIN Books         b ON bc.Book_ID      = b.Book_ID
    INNER JOIN Author        a ON b.Author_ID     = a.Author_ID
    INNER JOIN Category      c ON b.Category_ID   = c.Category_ID
    INNER JOIN Members       m ON br.Member_ID    = m.Member_ID
    WHERE bd.Return_Date IS NULL
    ORDER BY br.Due_Date ASC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_GetMemberBorrowedBooks` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetMemberBorrowedBooks`(IN p_Member_ID INT)
BEGIN
    SELECT
        Transaction_ID,
        Book_ID,
        BookCopy_ID,
        Book_Title,
        Book_Author,
        Book_Genre,
        Borrow_Date,
        Due_Date,
        Return_Date,
        Status
    FROM vw_MemberBorrowedBooks
    WHERE Member_ID = p_Member_ID
    ORDER BY Borrow_Date DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_GetMemberFines` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetMemberFines`(IN p_Member_ID INT)
BEGIN
    SELECT
        f.Fines_ID,
        f.Borrow_ID         AS Transaction_ID,
        f.Fine_Amount,
        f.Issued_Date,
        f.Paid_Date,
        fs.Fine_Status_Name AS Fine_Status,
        b.Book_Title
    FROM Fines f
    INNER JOIN Fines_Status  fs ON f.Fine_Status_ID  = fs.Fine_Status_ID
    INNER JOIN BorrowDetails bd ON f.Borrow_ID       = bd.BorrowDetails_ID
    INNER JOIN BorrowRecord  br ON bd.Borrow_ID      = br.Borrow_ID
    INNER JOIN BookCopy      bc ON bd.BookCopy_ID    = bc.BookCopy_ID
    INNER JOIN Books          b ON bc.Book_ID        = b.Book_ID
    WHERE br.Member_ID = p_Member_ID
    ORDER BY f.Fines_ID DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_PayFine` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_PayFine`(IN p_Fine_ID INT)
BEGIN
    DECLARE v_Status INT;

    SELECT Fine_Status_ID INTO v_Status
    FROM Fines
    WHERE Fines_ID = p_Fine_ID;

    IF v_Status = 1 THEN
        UPDATE Fines
        SET Fine_Status_ID = 2,
            Paid_Date      = CURDATE()
        WHERE Fines_ID = p_Fine_ID;

        SELECT 'success' AS status, 'Fine marked as paid!' AS message;
    ELSE
        SELECT 'error' AS status, 'Fine is already paid or waived!' AS message;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_RegisterAdmin` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_RegisterAdmin`(
    IN p_Username VARCHAR(50),
    IN p_Password VARCHAR(100)
)
BEGIN

    IF EXISTS (SELECT 1 FROM Admin WHERE Admin_Username = p_Username) THEN
        SELECT 'error' AS status, 'Username already exists!' AS message;
    ELSE
        INSERT INTO Admin (Admin_Username, Password)
        VALUES (p_Username, p_Password);

        SELECT 'success' AS status, 'Admin registered successfully!' AS message;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ReturnBook` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ReturnBook`(
    IN p_BorrowDetails_ID INT,
    IN p_Return_Date      DATE
)
BEGIN
    DECLARE v_CopyID     INT;
    DECLARE v_DueDate    DATE;
    DECLARE v_DaysLate   INT;
    DECLARE v_FineAmount DECIMAL(10,2) DEFAULT 0.00;

    SELECT bd.BookCopy_ID, br.Due_Date
    INTO   v_CopyID, v_DueDate
    FROM   BorrowDetails bd
    INNER JOIN BorrowRecord br ON bd.Borrow_ID = br.Borrow_ID
    WHERE  bd.BorrowDetails_ID = p_BorrowDetails_ID;

    -- Calculate fine at 5 per day late
    IF p_Return_Date > v_DueDate THEN
        SET v_DaysLate   = DATEDIFF(p_Return_Date, v_DueDate);
        SET v_FineAmount = v_DaysLate * 5.00;
    END IF;

    -- Update borrow detail: set return date and status to Returned
    UPDATE BorrowDetails
    SET Return_Date      = p_Return_Date,
        Borrow_Status_ID = 2
    WHERE BorrowDetails_ID = p_BorrowDetails_ID;

    -- Set the copy back to Available
    UPDATE BookCopy
    SET Book_Status_ID = 1
    WHERE BookCopy_ID = v_CopyID;

    -- If the book was late, create a fine record
    IF v_FineAmount > 0 THEN
        INSERT INTO Fines(Borrow_ID, Fine_Amount, Fine_Status_ID, Issued_Date)
        VALUES(p_BorrowDetails_ID, v_FineAmount, 1, p_Return_Date);
    END IF;

    SELECT 'success' AS status,
           IF(v_FineAmount > 0,
              CONCAT('Book returned. Fine issued: ', FORMAT(v_FineAmount, 2)),
              'Book returned successfully!'
           ) AS message,
           v_FineAmount AS fine_amount;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_SearchBooks` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_SearchBooks`(IN p_Query VARCHAR(255))
BEGIN
    SELECT
        b.Book_ID,
        b.Book_Title,
        b.Publication_Year,
        b.Isbn,
        a.Author_Name,
        c.Category_Name,
        bc.BookCopy_ID,
        bs.Book_Status_Name
    FROM Books b
    INNER JOIN Author      a  ON b.Author_ID      = a.Author_ID
    INNER JOIN Category    c  ON b.Category_ID    = c.Category_ID
    INNER JOIN BookCopy    bc ON bc.Book_ID        = b.Book_ID
    INNER JOIN Book_Status bs ON bc.Book_Status_ID = bs.Book_Status_ID
    WHERE  b.Book_Title    LIKE CONCAT('%', p_Query, '%')
        OR a.Author_Name   LIKE CONCAT('%', p_Query, '%')
        OR b.Isbn          LIKE CONCAT('%', p_Query, '%')
        OR c.Category_Name LIKE CONCAT('%', p_Query, '%')
    ORDER BY b.Book_Title;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_SearchMembers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_SearchMembers`(IN p_Query VARCHAR(255))
BEGIN
    SELECT
        m.Member_ID,
        m.Member_Name,
        m.Email,
        m.Contact_Number,
        m.Date_Joined,
        ms.Member_Status_ID,
        ms.Member_Status_Name
    FROM Members m
    INNER JOIN Member_Status ms ON m.Member_Status_ID = ms.Member_Status_ID
    WHERE  m.Member_Name    LIKE CONCAT('%', p_Query, '%')
        OR m.Email          LIKE CONCAT('%', p_Query, '%')
        OR m.Contact_Number LIKE CONCAT('%', p_Query, '%')
    ORDER BY m.Member_Name;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_SearchTransactions` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_SearchTransactions`(IN p_Query VARCHAR(255))
BEGIN
    SELECT
        bd.BorrowDetails_ID AS Transaction_ID,
        b.Book_ID,
        bc.BookCopy_ID,
        b.Book_Title        AS Title,
        m.Member_ID,
        m.Member_Name       AS Name,
        br.Borrow_Date,
        br.Due_Date,
        bd.Return_Date,
        IF(bd.Return_Date IS NOT NULL, 'Returned',
            IF(CURDATE() > br.Due_Date, 'Overdue', 'Borrowed')
        ) AS Status
    FROM BorrowDetails bd
    INNER JOIN BorrowRecord br ON bd.Borrow_ID   = br.Borrow_ID
    INNER JOIN BookCopy     bc ON bd.BookCopy_ID  = bc.BookCopy_ID
    INNER JOIN Books         b ON bc.Book_ID      = b.Book_ID
    INNER JOIN Members       m ON br.Member_ID    = m.Member_ID
    WHERE  b.Book_Title   LIKE CONCAT('%', p_Query, '%')
        OR m.Member_Name  LIKE CONCAT('%', p_Query, '%')
        OR br.Borrow_Date LIKE CONCAT('%', p_Query, '%')
        OR bd.Return_Date LIKE CONCAT('%', p_Query, '%')
    ORDER BY bd.BorrowDetails_ID DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_UpdateBook` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_UpdateBook`(
    IN p_Book_ID    INT,
    IN p_Title      VARCHAR(255),
    IN p_AuthorName VARCHAR(255),
    IN p_Isbn       VARCHAR(20),
    IN p_Category   VARCHAR(50),
    IN p_Year       INT
)
BEGIN
    DECLARE v_AuthorID   INT;
    DECLARE v_CategoryID INT;

    SELECT Author_ID INTO v_AuthorID FROM Author WHERE Author_Name = p_AuthorName LIMIT 1;
    IF v_AuthorID IS NULL THEN
        INSERT INTO Author(Author_Name) VALUES(p_AuthorName);
        SET v_AuthorID = LAST_INSERT_ID();
    END IF;

    SELECT Category_ID INTO v_CategoryID FROM Category WHERE Category_Name = p_Category LIMIT 1;
    IF v_CategoryID IS NULL THEN
        INSERT INTO Category(Category_Name) VALUES(p_Category);
        SET v_CategoryID = LAST_INSERT_ID();
    END IF;

    UPDATE Books
    SET Book_Title       = p_Title,
        Publication_Year = p_Year,
        Isbn             = NULLIF(p_Isbn,''),
        Author_ID        = v_AuthorID,
        Category_ID      = v_CategoryID
    WHERE Book_ID = p_Book_ID;

    SELECT 'success' AS status, 'Book updated successfully!' AS message;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_UpdateMember` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_UpdateMember`(
    IN p_Member_ID      INT,
    IN p_Name           VARCHAR(255),
    IN p_Email          VARCHAR(255),
    IN p_Contact_Number VARCHAR(20)
)
BEGIN
    UPDATE Members
    SET Member_Name    = p_Name,
        Email          = NULLIF(p_Email,''),
        Contact_Number = NULLIF(p_Contact_Number,'')
    WHERE Member_ID = p_Member_ID;

    SELECT 'success' AS status, 'Member updated successfully!' AS message;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_UpdateMemberStatus` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_UpdateMemberStatus`(
    IN p_Member_ID INT,
    IN p_Status    VARCHAR(30)
)
BEGIN
    DECLARE v_StatusID INT;

    SELECT Member_Status_ID INTO v_StatusID
    FROM Member_Status
    WHERE Member_Status_Name = p_Status
    LIMIT 1;

    IF v_StatusID IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid status name!';
    END IF;

    UPDATE Members SET Member_Status_ID = v_StatusID WHERE Member_ID = p_Member_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_WaiveFine` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_WaiveFine`(IN p_Fine_ID INT)
BEGIN
    UPDATE Fines
    SET Fine_Status_ID = 3
    WHERE Fines_ID = p_Fine_ID
      AND Fine_Status_ID = 1;

    SELECT 'success' AS status, 'Fine waived!' AS message;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `vw_bookswithdetails`
--

/*!50001 DROP VIEW IF EXISTS `vw_bookswithdetails`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_bookswithdetails` AS select `b`.`Book_ID` AS `Book_ID`,`b`.`Book_Title` AS `Book_Title`,`b`.`Publication_Year` AS `Publication_Year`,`b`.`Isbn` AS `Isbn`,`a`.`Author_ID` AS `Author_ID`,`a`.`Author_Name` AS `Author_Name`,`c`.`Category_ID` AS `Category_ID`,`c`.`Category_Name` AS `Category_Name`,`bc`.`BookCopy_ID` AS `BookCopy_ID`,`bs`.`Book_Status_Name` AS `Book_Status_Name`,`bs`.`Book_Status_ID` AS `Book_Status_ID` from ((((`books` `b` join `author` `a` on((`b`.`Author_ID` = `a`.`Author_ID`))) join `category` `c` on((`b`.`Category_ID` = `c`.`Category_ID`))) join `bookcopy` `bc` on((`bc`.`Book_ID` = `b`.`Book_ID`))) join `book_status` `bs` on((`bc`.`Book_Status_ID` = `bs`.`Book_Status_ID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_memberborrowedbooks`
--

/*!50001 DROP VIEW IF EXISTS `vw_memberborrowedbooks`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_memberborrowedbooks` AS select `bd`.`BorrowDetails_ID` AS `Transaction_ID`,`m`.`Member_ID` AS `Member_ID`,`m`.`Member_Name` AS `Member_Name`,`b`.`Book_ID` AS `Book_ID`,`bc`.`BookCopy_ID` AS `BookCopy_ID`,`b`.`Book_Title` AS `Book_Title`,`a`.`Author_Name` AS `Book_Author`,`c`.`Category_Name` AS `Book_Genre`,`br`.`Borrow_Date` AS `Borrow_Date`,`br`.`Due_Date` AS `Due_Date`,`bd`.`Return_Date` AS `Return_Date`,if((`bd`.`Return_Date` is not null),'Returned',if((curdate() > `br`.`Due_Date`),'Overdue','Borrowed')) AS `Status` from ((((((`borrowdetails` `bd` join `borrowrecord` `br` on((`bd`.`Borrow_ID` = `br`.`Borrow_ID`))) join `bookcopy` `bc` on((`bd`.`BookCopy_ID` = `bc`.`BookCopy_ID`))) join `books` `b` on((`bc`.`Book_ID` = `b`.`Book_ID`))) join `author` `a` on((`b`.`Author_ID` = `a`.`Author_ID`))) join `category` `c` on((`b`.`Category_ID` = `c`.`Category_ID`))) join `members` `m` on((`br`.`Member_ID` = `m`.`Member_ID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-17 15:47:29
