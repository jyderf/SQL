CREATE DATABASE  IF NOT EXISTS `tienda` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `tienda`;
-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: tienda
-- ------------------------------------------------------
-- Server version	8.3.0

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
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `idcliente` int NOT NULL AUTO_INCREMENT,
  `idtipo_documento` int DEFAULT NULL,
  `documento` varchar(30) DEFAULT NULL,
  `nombre` varchar(30) DEFAULT NULL,
  `apellido` varchar(30) DEFAULT NULL,
  `idmunicipio` int DEFAULT NULL,
  PRIMARY KEY (`idcliente`),
  KEY `idtipo_documento` (`idtipo_documento`),
  KEY `idmunicipio` (`idmunicipio`),
  CONSTRAINT `cliente_ibfk_1` FOREIGN KEY (`idtipo_documento`) REFERENCES `tipo_documento` (`idtipo_documento`),
  CONSTRAINT `cliente_ibfk_2` FOREIGN KEY (`idmunicipio`) REFERENCES `municipio` (`idmunicipio`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES (1,1,'111111111','BRIGITE','FUEL',1),(2,1,'222222222','SANDRA','GUALGUAN',1),(3,2,'333333333','YEIMI','ARGOTI',1),(4,2,'444444444','ANDRES','BARRERA',1),(5,2,'555555555','HECTOR','MADROÑERO',2),(6,2,'666666666','RICHARD','BASTIDAS',2),(7,2,'777777777','GINA','VEGA',2),(8,2,'888888888','GINELA','ORTIZ',2),(9,2,'999999999','JAIRO','LUNA',3),(10,2,'101010101','WILSON','GOMEZ',3),(11,2,'121212121','LUIS','AGUIRRE',3),(12,2,'131313131','LUIS','ORDOÑEZ',3),(13,2,'141414141','YENNI','CHAVES',4),(14,2,'151515151','JAVIER','HERNANDEZ',4),(15,2,'161616161','MONICA','HERNANDEZ',4),(16,2,'171717171','ALEXANDRA','JURADO',4),(17,2,'181818181','LUBIER','VEGA',5),(18,2,'191919191','FABIO','DIAZ',5),(19,2,'202020202','ALBERTO','ANDAMIO',5),(20,2,'212121212','POLONIO','COLON',5),(21,2,'232323232','ALICIA','TABARES',6),(22,2,'242424242','JUAN','ALARCON',6),(23,2,'252525252','PATRICIA','CORONEL',6),(24,2,'262626262','JUAN','TABARES',6),(25,3,'272727272','MARCELO','ZAPATA',7),(26,4,'282828282','MICHAEL','SMITH',8),(27,3,'272727272','RAMON','BENCENO',7),(28,4,'282828282','JESICA','SIMPSON',8);
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departamento`
--

DROP TABLE IF EXISTS `departamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `departamento` (
  `iddepartamento` int NOT NULL AUTO_INCREMENT,
  `departamento` varchar(30) DEFAULT NULL,
  `idpais` int DEFAULT NULL,
  PRIMARY KEY (`iddepartamento`),
  KEY `idpais` (`idpais`),
  CONSTRAINT `departamento_ibfk_1` FOREIGN KEY (`idpais`) REFERENCES `pais` (`idpais`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departamento`
--

LOCK TABLES `departamento` WRITE;
/*!40000 ALTER TABLE `departamento` DISABLE KEYS */;
INSERT INTO `departamento` VALUES (1,'NARIÑO',1),(2,'PUTUMAYO',1),(3,'HUILA',1),(4,'CATALUÑA',2),(5,'FLORIDA',3);
/*!40000 ALTER TABLE `departamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `factura`
--

DROP TABLE IF EXISTS `factura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `factura` (
  `idfactura` int NOT NULL AUTO_INCREMENT,
  `fecha` date DEFAULT NULL,
  `idvendedor` int DEFAULT NULL,
  `idcliente` int DEFAULT NULL,
  PRIMARY KEY (`idfactura`),
  KEY `idvendedor` (`idvendedor`),
  KEY `idcliente` (`idcliente`),
  CONSTRAINT `factura_ibfk_1` FOREIGN KEY (`idvendedor`) REFERENCES `vendedor` (`idvendedor`),
  CONSTRAINT `factura_ibfk_2` FOREIGN KEY (`idcliente`) REFERENCES `cliente` (`idcliente`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `factura`
--

LOCK TABLES `factura` WRITE;
/*!40000 ALTER TABLE `factura` DISABLE KEYS */;
INSERT INTO `factura` VALUES (1,'2020-01-15',1,1),(2,'2020-01-16',1,2),(3,'2020-01-17',1,3),(4,'2020-01-18',1,4),(5,'2020-02-15',1,5),(6,'2020-02-16',1,6),(7,'2020-02-17',1,7),(8,'2020-02-18',1,8),(9,'2021-03-15',1,9),(10,'2021-03-16',1,10),(11,'2021-03-17',1,11),(12,'2021-03-18',1,12),(13,'2021-04-15',1,13),(14,'2021-04-16',1,14),(15,'2021-04-17',1,15),(16,'2021-04-18',1,16),(17,'2022-01-15',2,15),(18,'2022-01-16',2,16),(19,'2022-01-17',2,17),(20,'2022-01-18',2,18),(21,'2022-02-15',2,19),(22,'2022-02-16',2,20),(23,'2022-02-17',2,21),(24,'2022-02-18',2,22),(25,'2023-01-15',3,23),(26,'2023-01-16',3,24),(27,'2023-01-17',3,25),(28,'2023-01-18',3,26);
/*!40000 ALTER TABLE `factura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `factura_producto`
--

DROP TABLE IF EXISTS `factura_producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `factura_producto` (
  `idfactura_producto` int NOT NULL AUTO_INCREMENT,
  `cantidad` int DEFAULT NULL,
  `idproducto` int DEFAULT NULL,
  `idfactura` int DEFAULT NULL,
  PRIMARY KEY (`idfactura_producto`),
  KEY `idproducto` (`idproducto`),
  KEY `idfactura` (`idfactura`),
  CONSTRAINT `factura_producto_ibfk_1` FOREIGN KEY (`idproducto`) REFERENCES `producto` (`idproducto`),
  CONSTRAINT `factura_producto_ibfk_2` FOREIGN KEY (`idfactura`) REFERENCES `factura` (`idfactura`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `factura_producto`
--

LOCK TABLES `factura_producto` WRITE;
/*!40000 ALTER TABLE `factura_producto` DISABLE KEYS */;
INSERT INTO `factura_producto` VALUES (1,1,1,1),(2,2,2,2),(3,2,3,2),(4,3,4,3),(5,3,5,3),(6,3,6,3),(7,4,8,4),(8,4,9,4),(9,4,10,4),(10,4,11,4),(11,5,12,5),(12,5,13,5),(13,5,15,5),(14,5,16,5),(15,5,1,5),(16,6,2,6),(17,7,3,7),(18,8,4,8),(19,9,5,9),(20,10,6,10),(21,11,8,11),(22,12,9,12),(23,13,10,13),(24,14,11,14),(25,15,12,15),(26,16,13,16),(27,17,15,17),(28,18,16,18),(29,19,1,19),(30,20,2,20),(31,1,1,21),(32,1,2,22),(33,1,3,23),(34,1,4,24),(35,1,1,25),(36,1,2,26),(37,1,3,27),(38,1,4,28);
/*!40000 ALTER TABLE `factura_producto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `municipio`
--

DROP TABLE IF EXISTS `municipio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `municipio` (
  `idmunicipio` int NOT NULL AUTO_INCREMENT,
  `municipio` varchar(30) DEFAULT NULL,
  `iddepartamento` int DEFAULT NULL,
  PRIMARY KEY (`idmunicipio`),
  KEY `iddepartamento` (`iddepartamento`),
  CONSTRAINT `municipio_ibfk_1` FOREIGN KEY (`iddepartamento`) REFERENCES `departamento` (`iddepartamento`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `municipio`
--

LOCK TABLES `municipio` WRITE;
/*!40000 ALTER TABLE `municipio` DISABLE KEYS */;
INSERT INTO `municipio` VALUES (1,'PASTO',1),(2,'SAMANIEGO',1),(3,'MOCOA',2),(4,'VILLAGARZON',2),(5,'PITALITO',3),(6,'NEIVA',3),(7,'BARCELONA',4),(8,'MIAMI',5);
/*!40000 ALTER TABLE `municipio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pais`
--

DROP TABLE IF EXISTS `pais`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pais` (
  `idpais` int NOT NULL AUTO_INCREMENT,
  `pais` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`idpais`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pais`
--

LOCK TABLES `pais` WRITE;
/*!40000 ALTER TABLE `pais` DISABLE KEYS */;
INSERT INTO `pais` VALUES (1,'Colombia'),(2,'España'),(3,'Estados Unidos'),(4,'Panamá'),(5,'Francia'),(6,'México'),(7,'Brasil');
/*!40000 ALTER TABLE `pais` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `producto`
--

DROP TABLE IF EXISTS `producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `producto` (
  `idproducto` int NOT NULL AUTO_INCREMENT,
  `producto` varchar(30) DEFAULT NULL,
  `costo` int DEFAULT NULL,
  `idtipo_producto` int DEFAULT NULL,
  PRIMARY KEY (`idproducto`),
  KEY `idtipo_producto` (`idtipo_producto`),
  CONSTRAINT `producto_ibfk_1` FOREIGN KEY (`idtipo_producto`) REFERENCES `tipo_producto` (`idtipo_producto`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `producto`
--

LOCK TABLES `producto` WRITE;
/*!40000 ALTER TABLE `producto` DISABLE KEYS */;
INSERT INTO `producto` VALUES (1,'CARNE KILO',15000,1),(2,'TARRO SALCHICAS PEQUEÑO',5000,1),(3,'KILO PESCADO',10000,1),(4,'CARNE MOLIDA KILO',18000,1),(5,'FRIJOL KILO',4500,2),(6,'MAIZ KILO',2500,2),(7,'LENTEJA KILO',3000,2),(8,'ALBERJA KILO',3000,2),(9,'YOGURT EN BOLSA',1500,3),(10,'YOGURT EN VASO',2500,3),(11,'QUESO CAMPESINO',4500,3),(12,'QUESO PRENSADO',8000,3),(13,'DETODITO PEQUEÑO',3500,4),(14,'CHOCOLATINA YUMBO PEQUEÑA',4500,4),(15,'CHOCOLATINA YET PEQUEÑA',1500,4),(16,'CHICLES TRIDENT UNIDAD',200,4),(17,'DETERGENTE FAB BOLSA MEDIANA',4000,5),(18,'DETERGENTE ARIEL BOLSA MEDIANA',4100,5),(19,'DESODORANTE REXONA TARRO',14000,6);
/*!40000 ALTER TABLE `producto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_documento`
--

DROP TABLE IF EXISTS `tipo_documento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_documento` (
  `idtipo_documento` int NOT NULL AUTO_INCREMENT,
  `tipo_documento` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`idtipo_documento`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_documento`
--

LOCK TABLES `tipo_documento` WRITE;
/*!40000 ALTER TABLE `tipo_documento` DISABLE KEYS */;
INSERT INTO `tipo_documento` VALUES (1,'TI'),(2,'CC'),(3,'CE'),(4,'PASAPORTE');
/*!40000 ALTER TABLE `tipo_documento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_producto`
--

DROP TABLE IF EXISTS `tipo_producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_producto` (
  `idtipo_producto` int NOT NULL AUTO_INCREMENT,
  `tipo_producto` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`idtipo_producto`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_producto`
--

LOCK TABLES `tipo_producto` WRITE;
/*!40000 ALTER TABLE `tipo_producto` DISABLE KEYS */;
INSERT INTO `tipo_producto` VALUES (1,'carnico'),(2,'grano'),(3,'lacteo'),(4,'mecato'),(5,'aseo general'),(6,'aseo personal'),(7,'cosmetico');
/*!40000 ALTER TABLE `tipo_producto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vendedor`
--

DROP TABLE IF EXISTS `vendedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vendedor` (
  `idvendedor` int NOT NULL AUTO_INCREMENT,
  `idtipo_documento` int DEFAULT NULL,
  `documento` varchar(30) DEFAULT NULL,
  `nombre` varchar(30) DEFAULT NULL,
  `apellido` varchar(30) DEFAULT NULL,
  `idmunicipio` int DEFAULT NULL,
  `nacimiento` date DEFAULT NULL,
  PRIMARY KEY (`idvendedor`),
  KEY `idtipo_documento` (`idtipo_documento`),
  KEY `idmunicipio` (`idmunicipio`),
  CONSTRAINT `vendedor_ibfk_1` FOREIGN KEY (`idtipo_documento`) REFERENCES `tipo_documento` (`idtipo_documento`),
  CONSTRAINT `vendedor_ibfk_2` FOREIGN KEY (`idmunicipio`) REFERENCES `municipio` (`idmunicipio`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vendedor`
--

LOCK TABLES `vendedor` WRITE;
/*!40000 ALTER TABLE `vendedor` DISABLE KEYS */;
INSERT INTO `vendedor` VALUES (1,1,'111222333','Carlos','Rodriguez',3,'1990-12-15'),(2,2,'222333444','Katerine','Galindo',3,'2000-12-15'),(3,2,'333444555','Angela','Samboni',1,'2000-12-15');
/*!40000 ALTER TABLE `vendedor` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-04-12  4:35:45
