-- MySQL dump 10.10
--
-- Host: localhost    Database: sssm
-- ------------------------------------------------------
-- Server version	5.0.24-community-nt

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
-- Table structure for table `project`
--

DROP TABLE IF EXISTS `project`;
CREATE TABLE `project` (
  `project_name` varchar(50) default NULL,
  `project_no` int(11) NOT NULL auto_increment,
  `active_status` int(1) default '1',
  `students` varchar(500) default NULL,
  `sem` int(1) default NULL,
  PRIMARY KEY  (`project_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `project`
--


/*!40000 ALTER TABLE `project` DISABLE KEYS */;
LOCK TABLES `project` WRITE;
INSERT INTO `project` VALUES ('adad',1,1,'0545cs171014 0545cs171023 0545cs171024',5),('SSSSM',2,1,'0545cs171014 0545cs171023 0545cs171023',5),('Challan generation',3,1,NULL,NULL),('face recognition ',4,1,NULL,NULL);
UNLOCK TABLES;
/*!40000 ALTER TABLE `project` ENABLE KEYS */;

--
-- Table structure for table `skills`
--

DROP TABLE IF EXISTS `skills`;
CREATE TABLE `skills` (
  `skill_name` varchar(30) NOT NULL default '',
  PRIMARY KEY  (`skill_name`),
  UNIQUE KEY `skill_name` (`skill_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `skills`
--


/*!40000 ALTER TABLE `skills` DISABLE KEYS */;
LOCK TABLES `skills` WRITE;
INSERT INTO `skills` VALUES ('bootstrap'),('c'),('CPP'),('css'),('html'),('java');
UNLOCK TABLES;
/*!40000 ALTER TABLE `skills` ENABLE KEYS */;

--
-- Table structure for table `slogin`
--

DROP TABLE IF EXISTS `slogin`;
CREATE TABLE `slogin` (
  `roll` varchar(15) default NULL,
  `passwd` varchar(15) default NULL,
  KEY `roll` (`roll`),
  CONSTRAINT `slogin_ibfk_1` FOREIGN KEY (`roll`) REFERENCES `student` (`roll`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `slogin`
--


/*!40000 ALTER TABLE `slogin` DISABLE KEYS */;
LOCK TABLES `slogin` WRITE;
INSERT INTO `slogin` VALUES ('0545cs171007','root'),('0545cs171009','root'),('0545cs171012','root'),('0545cs171013','root'),('0545cs171014','root'),('0545cs171023','root'),('0545cs171024','root'),('0545CS171006','12345678yY'),('0545CS171038','NS0XkjW4'),('0545CS171098','Gek16E0V'),('0545CS171001','123456Yy');
UNLOCK TABLES;
/*!40000 ALTER TABLE `slogin` ENABLE KEYS */;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
CREATE TABLE `student` (
  `roll` varchar(15) NOT NULL,
  `first_name` varchar(25) default NULL,
  `last_name` varchar(25) default NULL,
  `dob` date default NULL,
  `sex` varchar(1) default NULL,
  `sem` int(11) default NULL,
  `email` varchar(50) default NULL,
  `mobile` varchar(10) default NULL,
  PRIMARY KEY  (`roll`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `student`
--


/*!40000 ALTER TABLE `student` DISABLE KEYS */;
LOCK TABLES `student` WRITE;
INSERT INTO `student` VALUES ('0545CS171001','Vipul','Jain','1999-12-12','m',5,'vipuljain14@gmail.com','8770630229'),('0545CS171006','Yash','Barneg','1996-12-12','m',1,'yashbarange149@gmail.com','8770632224'),('0545cs171007','nikk','surya','2000-12-14','m',3,'7@gmail.com','8770630224'),('0545cs171009','namn','jain','2000-12-14','m',3,'9@gmail.com','8770630225'),('0545cs171012','lokesh','sevatkar','1998-12-12','m',4,'12@gmail.com','147258369'),('0545cs171013','amit ','nagle','1988-02-05','m',6,'13@gmail.com','8770630220'),('0545cs171014','nihal','barode','1988-02-05','m',5,'14@gmail.com','8770630112'),('0545cs171023','nikhil','kale','1999-12-25','m',5,'23@gmail.com','8779621335'),('0545cs171024','rahul','sahu','1998-04-05','m',5,'24@gmail.com','7089811617'),('0545CS171038','Yash','Brange','1999-12-12','m',3,'yashbarange14@gmail.com','8774578545'),('0545CS171098','Nikhil','Surya','1999-12-12','m',3,'nikhilsurya29@gmail.com','8770520114');
UNLOCK TABLES;
/*!40000 ALTER TABLE `student` ENABLE KEYS */;

--
-- Table structure for table `student_skill`
--

DROP TABLE IF EXISTS `student_skill`;
CREATE TABLE `student_skill` (
  `roll` varchar(15) default NULL,
  `skill_name` varchar(500) default NULL,
  KEY `roll` (`roll`),
  CONSTRAINT `student_skill_ibfk_1` FOREIGN KEY (`roll`) REFERENCES `student` (`roll`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `student_skill`
--


/*!40000 ALTER TABLE `student_skill` DISABLE KEYS */;
LOCK TABLES `student_skill` WRITE;
INSERT INTO `student_skill` VALUES ('0545cs171007','CPP css html'),('0545cs171001','bootstrap c CPP css');
UNLOCK TABLES;
/*!40000 ALTER TABLE `student_skill` ENABLE KEYS */;

--
-- Table structure for table `teacher`
--

DROP TABLE IF EXISTS `teacher`;
CREATE TABLE `teacher` (
  `email` varchar(50) NOT NULL,
  `first_name` varchar(25) default NULL,
  `last_name` varchar(25) default NULL,
  `sex` varchar(1) default NULL,
  `mobile` varchar(10) default NULL,
  PRIMARY KEY  (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `teacher`
--


/*!40000 ALTER TABLE `teacher` DISABLE KEYS */;
LOCK TABLES `teacher` WRITE;
INSERT INTO `teacher` VALUES ('akashbarange14@gmail.com','akash','barange','m','8770630225'),('nikhilsurya29@gmail.com','Nikhil','Suryawanshi','m','8827252634'),('yashbarange14@gmail.com','yash','barange','m','8770630229');
UNLOCK TABLES;
/*!40000 ALTER TABLE `teacher` ENABLE KEYS */;

--
-- Table structure for table `tlogin`
--

DROP TABLE IF EXISTS `tlogin`;
CREATE TABLE `tlogin` (
  `email` varchar(50) default NULL,
  `passwd` varchar(15) default NULL,
  KEY `email` (`email`),
  CONSTRAINT `tlogin_ibfk_1` FOREIGN KEY (`email`) REFERENCES `teacher` (`email`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tlogin`
--


/*!40000 ALTER TABLE `tlogin` DISABLE KEYS */;
LOCK TABLES `tlogin` WRITE;
INSERT INTO `tlogin` VALUES ('nikhilsurya29@gmail.com','root'),('akashbarange14@gmail.com','root'),('yashbarange14@gmail.com','123456yY');
UNLOCK TABLES;
/*!40000 ALTER TABLE `tlogin` ENABLE KEYS */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

