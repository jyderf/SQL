DROP DATABASE IF EXISTS `tienda`;
CREATE DATABASE IF NOT EXISTS `tienda`;
USE `tienda`;

-- TABLAS SIN DEPENDENCIAS
DROP TABLE IF EXISTS `tipo_documento`;
CREATE TABLE `tipo_documento` (
  `idtipo_documento` INT NOT NULL AUTO_INCREMENT,
  `tipo_documento` VARCHAR(30) DEFAULT NULL,
  PRIMARY KEY (`idtipo_documento`)
);

INSERT INTO `tipo_documento` VALUES
(1,'TI'),(2,'CC'),(3,'CE'),(4,'PASAPORTE');

DROP TABLE IF EXISTS `tipo_producto`;
CREATE TABLE `tipo_producto` (
  `idtipo_producto` INT NOT NULL AUTO_INCREMENT,
  `tipo_producto` VARCHAR(30) DEFAULT NULL,
  PRIMARY KEY (`idtipo_producto`)
);

INSERT INTO `tipo_producto` VALUES
(1,'carnico'),(2,'grano'),(3,'lacteo'),(4,'mecato'),
(5,'aseo general'),(6,'aseo personal'),(7,'cosmetico');

DROP TABLE IF EXISTS `pais`;
CREATE TABLE `pais` (
  `idpais` INT NOT NULL AUTO_INCREMENT,
  `pais` VARCHAR(30) DEFAULT NULL,
  PRIMARY KEY (`idpais`)
);

INSERT INTO `pais` VALUES
(1,'Colombia'),(2,'España'),(3,'Estados Unidos'),
(4,'Panamá'),(5,'Francia'),(6,'México'),(7,'Brasil');

-- DEPENDE DE pais
DROP TABLE IF EXISTS `departamento`;
CREATE TABLE `departamento` (
  `iddepartamento` INT NOT NULL AUTO_INCREMENT,
  `departamento` VARCHAR(30) DEFAULT NULL,
  `idpais` INT DEFAULT NULL,
  PRIMARY KEY (`iddepartamento`),
  KEY (`idpais`),
  CONSTRAINT `departamento_ibfk_1` FOREIGN KEY (`idpais`) REFERENCES `pais` (`idpais`)
);

INSERT INTO `departamento` VALUES
(1,'NARIÑO',1),(2,'PUTUMAYO',1),(3,'HUILA',1),
(4,'CATALUÑA',2),(5,'FLORIDA',3);

-- DEPENDE DE departamento
DROP TABLE IF EXISTS `municipio`;
CREATE TABLE `municipio` (
  `idmunicipio` INT NOT NULL AUTO_INCREMENT,
  `municipio` VARCHAR(30) DEFAULT NULL,
  `iddepartamento` INT DEFAULT NULL,
  PRIMARY KEY (`idmunicipio`),
  KEY (`iddepartamento`),
  CONSTRAINT `municipio_ibfk_1` FOREIGN KEY (`iddepartamento`) REFERENCES `departamento` (`iddepartamento`)
);

INSERT INTO `municipio` VALUES
(1,'PASTO',1),(2,'SAMANIEGO',1),(3,'MOCOA',2),
(4,'VILLAGARZON',2),(5,'PITALITO',3),(6,'NEIVA',3),
(7,'BARCELONA',4),(8,'MIAMI',5);

-- DEPENDE DE tipo_documento, municipio
DROP TABLE IF EXISTS `cliente`;
CREATE TABLE `cliente` (
  `idcliente` INT NOT NULL AUTO_INCREMENT,
  `idtipo_documento` INT DEFAULT NULL,
  `documento` VARCHAR(30) DEFAULT NULL,
  `nombre` VARCHAR(30) DEFAULT NULL,
  `apellido` VARCHAR(30) DEFAULT NULL,
  `idmunicipio` INT DEFAULT NULL,
  PRIMARY KEY (`idcliente`),
  KEY (`idtipo_documento`),
  KEY (`idmunicipio`),
  CONSTRAINT `cliente_ibfk_1` FOREIGN KEY (`idtipo_documento`) REFERENCES `tipo_documento` (`idtipo_documento`),
  CONSTRAINT `cliente_ibfk_2` FOREIGN KEY (`idmunicipio`) REFERENCES `municipio` (`idmunicipio`)
);

INSERT INTO `cliente` VALUES
(1,1,'111111111','BRIGITE','FUEL',1),
(2,1,'222222222','SANDRA','GUALGUAN',1),
(3,2,'333333333','YEIMI','ARGOTI',1),
(4,2,'444444444','ANDRES','BARRERA',1),
(5,2,'555555555','HECTOR','MADROÑERO',2),
(6,2,'666666666','RICHARD','BASTIDAS',2),
(7,2,'777777777','GINA','VEGA',2),
(8,2,'888888888','GINELA','ORTIZ',2),
(9,2,'999999999','JAIRO','LUNA',3),
(10,2,'101010101','WILSON','GOMEZ',3),
(11,2,'121212121','LUIS','AGUIRRE',3),
(12,2,'131313131','LUIS','ORDOÑEZ',3),
(13,2,'141414141','YENNI','CHAVES',4),
(14,2,'151515151','JAVIER','HERNANDEZ',4),
(15,2,'161616161','MONICA','HERNANDEZ',4),
(16,2,'171717171','ALEXANDRA','JURADO',4),
(17,2,'181818181','LUBIER','VEGA',5),
(18,2,'191919191','FABIO','DIAZ',5),
(19,2,'202020202','ALBERTO','ANDAMIO',5),
(20,2,'212121212','POLONIO','COLON',5),
(21,2,'232323232','ALICIA','TABARES',6),
(22,2,'242424242','JUAN','ALARCON',6),
(23,2,'252525252','PATRICIA','CORONEL',6),
(24,2,'262626262','JUAN','TABARES',6),
(25,3,'272727272','MARCELO','ZAPATA',7),
(26,4,'282828282','MICHAEL','SMITH',8),
(27,3,'272727272','RAMON','BENCENO',7),
(28,4,'282828282','JESICA','SIMPSON',8);

-- DEPENDE DE tipo_documento, municipio
DROP TABLE IF EXISTS `vendedor`;
CREATE TABLE `vendedor` (
  `idvendedor` INT NOT NULL AUTO_INCREMENT,
  `idtipo_documento` INT DEFAULT NULL,
  `documento` VARCHAR(30) DEFAULT NULL,
  `nombre` VARCHAR(30) DEFAULT NULL,
  `apellido` VARCHAR(30) DEFAULT NULL,
  `idmunicipio` INT DEFAULT NULL,
  `nacimiento` DATE DEFAULT NULL,
  PRIMARY KEY (`idvendedor`),
  KEY (`idtipo_documento`),
  KEY (`idmunicipio`),
  CONSTRAINT `vendedor_ibfk_1` FOREIGN KEY (`idtipo_documento`) REFERENCES `tipo_documento` (`idtipo_documento`),
  CONSTRAINT `vendedor_ibfk_2` FOREIGN KEY (`idmunicipio`) REFERENCES `municipio` (`idmunicipio`)
);

INSERT INTO `vendedor` VALUES
(1,1,'111222333','Carlos','Rodriguez',3,'1990-12-15'),
(2,2,'222333444','Katerine','Galindo',3,'2000-12-15'),
(3,2,'333444555','Angela','Samboni',1,'2000-12-15');

-- DEPENDE DE cliente, vendedor
DROP TABLE IF EXISTS `factura`;
CREATE TABLE `factura` (
  `idfactura` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATE DEFAULT NULL,
  `idvendedor` INT DEFAULT NULL,
  `idcliente` INT DEFAULT NULL,
  PRIMARY KEY (`idfactura`),
  KEY (`idvendedor`),
  KEY (`idcliente`),
  CONSTRAINT `factura_ibfk_1` FOREIGN KEY (`idvendedor`) REFERENCES `vendedor` (`idvendedor`),
  CONSTRAINT `factura_ibfk_2` FOREIGN KEY (`idcliente`) REFERENCES `cliente` (`idcliente`)
);

INSERT INTO `factura` VALUES
(1,'2020-01-15',1,1),(2,'2020-01-16',1,2),(3,'2020-01-17',1,3),
(4,'2020-01-18',1,4),(5,'2020-02-15',1,5),(6,'2020-02-16',1,6),
(7,'2020-02-17',1,7),(8,'2020-02-18',1,8),(9,'2021-03-15',1,9),
(10,'2021-03-16',1,10),(11,'2021-03-17',1,11),(12,'2021-03-18',1,12),
(13,'2021-04-15',1,13),(14,'2021-04-16',1,14),(15,'2021-04-17',1,15),
(16,'2021-04-18',1,16),(17,'2022-01-15',2,15),(18,'2022-01-16',2,16),
(19,'2022-01-17',2,17),(20,'2022-01-18',2,18),(21,'2022-02-15',2,19),
(22,'2022-02-16',2,20),(23,'2022-02-17',2,21),(24,'2022-02-18',2,22),
(25,'2023-01-15',3,23),(26,'2023-01-16',3,24),(27,'2023-01-17',3,25),
(28,'2023-01-18',3,26);

-- DEPENDE DE tipo_producto
DROP TABLE IF EXISTS `producto`;
CREATE TABLE `producto` (
  `idproducto` INT NOT NULL AUTO_INCREMENT,
  `producto` VARCHAR(30) DEFAULT NULL,
  `costo` INT DEFAULT NULL,
  `idtipo_producto` INT DEFAULT NULL,
  PRIMARY KEY (`idproducto`),
  KEY (`idtipo_producto`),
  CONSTRAINT `producto_ibfk_1` FOREIGN KEY (`idtipo_producto`) REFERENCES `tipo_producto` (`idtipo_producto`)
);

INSERT INTO `producto` VALUES
(1,'CARNE KILO',15000,1),(2,'TARRO SALCHICAS PEQUEÑO',5000,1),
(3,'KILO PESCADO',10000,1),(4,'CARNE MOLIDA KILO',18000,1),
(5,'FRIJOL KILO',4500,2),(6,'MAIZ KILO',2500,2),(7,'LENTEJA KILO',3000,2),
(8,'ALBERJA KILO',3000,2),(9,'YOGURT EN BOLSA',1500,3),
(10,'YOGURT EN VASO',2500,3),(11,'QUESO CAMPESINO',4500,3),
(12,'QUESO PRENSADO',8000,3),(13,'DETODITO PEQUEÑO',3500,4),
(14,'CHOCOLATINA YUMBO PEQUEÑA',4500,4),(15,'CHOCOLATINA YET PEQUEÑA',1500,4),
(16,'CHICLES TRIDENT UNIDAD',200,4),(17,'DETERGENTE FAB BOLSA MEDIANA',4000,5),
(18,'DETERGENTE ARIEL BOLSA MEDIANA',4100,5),
(19,'DESODORANTE REXONA TARRO',14000,6);

-- DEPENDE DE producto y factura
DROP TABLE IF EXISTS `factura_producto`;
CREATE TABLE `factura_producto` (
  `idfactura_producto` INT NOT NULL AUTO_INCREMENT,
  `cantidad` INT DEFAULT NULL,
  `idproducto` INT DEFAULT NULL,
  `idfactura` INT DEFAULT NULL,
  PRIMARY KEY (`idfactura_producto`),
  KEY (`idproducto`),
  KEY (`idfactura`),
  CONSTRAINT `factura_producto_ibfk_1` FOREIGN KEY (`idproducto`) REFERENCES `producto` (`idproducto`),
  CONSTRAINT `factura_producto_ibfk_2` FOREIGN KEY (`idfactura`) REFERENCES `factura` (`idfactura`)
);

INSERT INTO `factura_producto` VALUES
(1,1,1,1),(2,2,2,2),(3,2,3,2),(4,3,4,3),(5,3,5,3),
(6,3,6,3),(7,4,8,4),(8,4,9,4),(9,4,10,4),(10,4,11,4),
(11,5,12,5),(12,5,13,5),(13,5,15,5),(14,5,16,5),(15,5,1,5),
(16,6,2,6),(17,7,3,7),(18,8,4,8),(19,9,5,9),(20,10,6,10),
(21,11,8,11),(22,12,9,12),(23,13,10,13),(24,14,11,14),
(25,15,12,15),(26,16,13,16),(27,17,15,17),(28,18,16,18),
(29,19,1,19),(30,20,2,20),(31,1,1,21),(32,1,2,22),
(33,1,3,23),(34,1,4,24),(35,1,1,25),(36,1,2,26),
(37,1,3,27),(38,1,4,28);
