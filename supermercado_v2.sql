DROP SCHEMA IF EXISTS supermercado;
CREATE SCHEMA supermercado;
USE supermercado;

CREATE TABLE pais(
idpais INT PRIMARY KEY AUTO_INCREMENT,
pais VARCHAR(50)
);

CREATE TABLE departamento(
iddepartamento INT PRIMARY KEY AUTO_INCREMENT,
departamento VARCHAR(30),
idpais INT NOT NULL,
FOREIGN KEY(idpais) REFERENCES pais(idpais)
);

CREATE TABLE municipio(
idmunicipio INT PRIMARY KEY auto_increment,
municipio VARCHAR(50),
iddepartamento  INT NOT NULL,
FOREIGN KEY(iddepartamento) REFERENCES departamento(iddepartamento)
);

CREATE TABLE tipo_doc(
idtipo_doc INT PRIMARY KEY auto_increment,
tipo_doc VARCHAR(10)
);

CREATE TABLE tipo_persona(
idtipo_persona INT PRIMARY KEY AUTO_INCREMENT,
tipo_persona VARCHAR(10)
);

CREATE TABLE persona(
idpersona VARCHAR(20) PRIMARY KEY UNIQUE,
idtipo_doc INT NOT NULL,
idtipo_persona INT NOT NULL, #NATURAL O JURÍDICA
nombre VARCHAR(50) NOT NULL,   
 apellido VARCHAR(50) NOT NULL,
 telefono VARCHAR(13),
 email VARCHAR(100) NOT NULL,
 fecha_nacimiento DATE,
 direccion 	VARCHAR(100),
 idmunicipio INT NOT NULL,
 FOREIGN KEY(idtipo_persona) REFERENCES tipo_persona(idtipo_persona),
 FOREIGN KEY(idtipo_doc) REFERENCES tipo_doc(idtipo_doc),
 FOREIGN KEY(idmunicipio) REFERENCES municipio(idmunicipio)
);

CREATE TABLE empleado (    
 idempleado INT PRIMARY KEY AUTO_INCREMENT,
 idpersona VARCHAR(20),
 email_institucional VARCHAR(100) NOT NULL, 
 contrasena VARCHAR(100) NOT NULL,   
 fecha_registro DATE,
 FOREIGN KEY(idpersona) REFERENCES persona(idpersona)
 );
  
 ##########   INICIO PRODUCTO ###########
CREATE TABLE categoria (   #
 idcategoria INT PRIMARY KEY AUTO_INCREMENT,
 categoria VARCHAR(30) NOT NULL
 ); 
 
  CREATE TABLE producto(
 idproducto INT PRIMARY KEY AUTO_INCREMENT,   
 nombre VARCHAR(100) NOT NULL,  
 descripcion TEXT,
 costo DECIMAL(10,2),
 precio DECIMAL(10,2),
 fecha_registro DATE 
 );
 
 CREATE TABLE producto_categoria(
 idproducto_categoria INT PRIMARY KEY AUTO_INCREMENT,
 idcategoria INT NOT NULL,
 idproducto INT NOT NULL,
 FOREIGN KEY (idcategoria) REFERENCES categoria(idcategoria),
 FOREIGN KEY (idproducto) REFERENCES producto(idproducto)
 );
 
   CREATE TABLE stock (    
 idstock INT PRIMARY KEY AUTO_INCREMENT, 
 idproducto INT,  
 cantidad INT,   
 FOREIGN KEY (idproducto) REFERENCES producto(idproducto)
 );
 ########### FIN PRODUCTO ###########################
 
 
 ############ INICIO COMPLEMENTOS ###################  
   CREATE TABLE metodo_pago_pedido ( # en efectivo, tarjeta, psi, datáfono, etc
 idmetodo_pago_pedido INT PRIMARY KEY AUTO_INCREMENT,
 metodo_pago_pedido VARCHAR(50) NOT NULL 
 );
 
   CREATE TABLE metodo_pago_venta ( # en efectivo, tarjeta, psi, datáfono, etc
 idmetodo_pago_venta INT PRIMARY KEY AUTO_INCREMENT,
 metodo_pago_venta VARCHAR(50) NOT NULL 
 ); 
 
 CREATE TABLE EstadoP( #pendiente o entregado
  idEstadoP INT PRIMARY KEY AUTO_INCREMENT,
  EstadoP VARCHAR(50) NOT NULL 
  );  
  
   CREATE TABLE EstadoV( #pendiente o entregado
  idEstadoV INT PRIMARY KEY AUTO_INCREMENT,
  EstadoV VARCHAR(50) NOT NULL 
  );
############### FIN COMPLEMENTOS #####################
  
  
###############  INICIO VENTA  ####################### 
  CREATE TABLE venta (   
	idventa INT PRIMARY KEY AUTO_INCREMENT,  
	idempleado INT ,
    idcliente VARCHAR(20), 
	fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
	fecha_envio DATE,  
	fecha_entrega DATE, 	
	total DECIMAL(10,2) ,    
  
	FOREIGN KEY (idempleado) REFERENCES empleado(idempleado),
	FOREIGN KEY (idcliente) REFERENCES persona(idpersona)
);
 
 CREATE TABLE abono_venta(
 idabono_venta INT PRIMARY KEY AUTO_INCREMENT,
 abono_venta DECIMAL(10,2) NOT NULL,
 idmetodo_pago_venta INT NOT NULL,
 fecha DATE,
 idventa INT NOT NULL,
 FOREIGN KEY(idmetodo_pago_venta) REFERENCES metodo_pago_venta(idmetodo_pago_venta),
 FOREIGN KEY(idventa)REFERENCES venta(idventa)
  );
 
    CREATE TABLE estado_venta( #pendiente o entregado
  idestado_venta INT PRIMARY KEY AUTO_INCREMENT,
  idventa INT NOT NULL,
  idEstadoV INT NOT NULL,
  FOREIGN KEY(idventa) REFERENCES venta(idventa),
  FOREIGN KEY(idEstadoV) REFERENCES EstadoV(idEstadoV)
  );
  
   CREATE TABLE saldo_venta(
  idsaldo_venta INT PRIMARY KEY AUTO_INCREMENT,
  saldo_venta INT NOT NULL, #saldado o deuda pendiente
  idventa INT NOT NULL,
  FOREIGN KEY(idventa) REFERENCES venta(idventa)
  );
  
   CREATE TABLE venta_producto (   
 idventa_producto INT PRIMARY KEY AUTO_INCREMENT,
 idventa INT NOT NULL, 
 idproducto INT NOT NULL,    
 cantidad INT NOT NULL,
 FOREIGN KEY (idventa) REFERENCES venta(idventa),  
 FOREIGN KEY (idproducto) REFERENCES producto(idproducto)
 );  
  ###    FIN VENTA   ###################################################
 
  ###    INICIO PEDIDOS   ##############################################  
  CREATE TABLE pedido (   
	idpedido INT PRIMARY KEY AUTO_INCREMENT,  
	idempleado INT,
    idproveedor VARCHAR(20), 
	fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
	fecha_envio DATE,  
	fecha_entrega DATE, 	
	total DECIMAL(10,2) ,  
	FOREIGN KEY (idempleado) REFERENCES empleado(idempleado),
	FOREIGN KEY (idproveedor) REFERENCES persona(idpersona)    
    );
 
   CREATE TABLE saldo_pedido(
  idsaldo_pedido INT PRIMARY KEY AUTO_INCREMENT,
  saldo_pedido DECIMAL(10,2) NOT NULL, #saldado o deuda pendiente
  idpedido INT NOT NULL,
  FOREIGN KEY(idpedido)REFERENCES pedido(idpedido)
  );
 
  CREATE TABLE abono_pedido(
 idabono_pedido INT PRIMARY KEY AUTO_INCREMENT,
 abono_pedido INT NOT NULL,
 idmetodo_pago_pedido INT NOT NULL,
 fecha DATE,
 idpedido INT NOT NULL,
 FOREIGN KEY(idmetodo_pago_pedido) REFERENCES metodo_pago_pedido(idmetodo_pago_pedido),
 FOREIGN KEY(idpedido) REFERENCES pedido(idpedido)
  );
 
   CREATE TABLE estado_pedido( #pendiente o entregado
  idestado_pedido INT PRIMARY KEY AUTO_INCREMENT,
  idpedido INT NOT NULL,
  idEstadoP INT NOT NULL,
  FOREIGN KEY(idpedido) REFERENCES pedido(idpedido),
  FOREIGN KEY(idEstadoP) REFERENCES EstadoP(idEstadoP)
  );
 
 CREATE TABLE pedido_producto (   
 idpedido_producto INT PRIMARY KEY AUTO_INCREMENT,
 idpedido INT NOT NULL, 
 idproducto INT NOT NULL,    
 cantidad INT NOT NULL,
 FOREIGN KEY (idpedido) REFERENCES pedido(idpedido),  
 FOREIGN KEY (idproducto) REFERENCES producto(idproducto)
 ); 
 ##################################################### FIN PEDIDO ####################################################
 
 CREATE TABLE movimiento_caja(
  idmovimiento_caja INT PRIMARY KEY AUTO_INCREMENT,
  fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  ingreso DECIMAL(10, 2),
  egreso DECIMAL(10, 2),
  saldo DECIMAL(10, 2)
 );
 
 ##################################	INICIO INGRESO DE DATOS		############################################################ 
 INSERT INTO `supermercado`.`pais` (`pais`) VALUES ('Colombia');
INSERT INTO `supermercado`.`pais` (`pais`) VALUES ('España');
INSERT INTO `supermercado`.`pais` (`pais`) VALUES ('Estados Unidos');
INSERT INTO `supermercado`.`pais` (`pais`) VALUES ('Alemania');
INSERT INTO `supermercado`.`pais` (`pais`) VALUES ('Francia');
INSERT INTO `supermercado`.`pais` (`pais`) VALUES ('Rusia');
INSERT INTO `supermercado`.`pais` (`pais`) VALUES ('Ecuador');
INSERT INTO `supermercado`.`pais` (`pais`) VALUES ('Venezuela');

INSERT INTO `supermercado`.`categoria` (`categoria`) VALUES ('Carnico');
INSERT INTO `supermercado`.`categoria` (`categoria`) VALUES ('Grano');
INSERT INTO `supermercado`.`categoria` (`categoria`) VALUES ('Lacteo');
INSERT INTO `supermercado`.`categoria` (`categoria`) VALUES ('Mecato');
INSERT INTO `supermercado`.`categoria` (`categoria`) VALUES ('Aseo');
INSERT INTO `supermercado`.`categoria` (`categoria`) VALUES ('Cosmeticos');
INSERT INTO `supermercado`.`categoria` (`categoria`) VALUES ('Enlatado');
INSERT INTO `supermercado`.`categoria` (`categoria`) VALUES ('Embutido');
INSERT INTO `supermercado`.`categoria` (`categoria`) VALUES ('Cereal');

INSERT INTO `supermercado`.`estadop` (`estadop`) VALUES ('En camino');
INSERT INTO `supermercado`.`estadop` (`estadop`) VALUES ('Entregado');
INSERT INTO `supermercado`.`estadop` (`estadop`) VALUES ('NA');


INSERT INTO `supermercado`.`estadov` (`estadov`) VALUES ('En camino');
INSERT INTO `supermercado`.`estadov` (`estadov`) VALUES ('Entregado');
INSERT INTO `supermercado`.`estadov` (`estadov`) VALUES ('NA');

INSERT INTO `supermercado`.`metodo_pago_pedido` (`metodo_pago_pedido`) VALUES ('Efectivo');
INSERT INTO `supermercado`.`metodo_pago_pedido` (`metodo_pago_pedido`) VALUES ('Tarjeta');
INSERT INTO `supermercado`.`metodo_pago_pedido` (`metodo_pago_pedido`) VALUES ('Pse');
INSERT INTO `supermercado`.`metodo_pago_pedido` (`metodo_pago_pedido`) VALUES ('Datáfono');

INSERT INTO `supermercado`.`metodo_pago_venta` (`metodo_pago_venta`) VALUES ('Efectivo');
INSERT INTO `supermercado`.`metodo_pago_venta` (`metodo_pago_venta`) VALUES ('Tarjeta');
INSERT INTO `supermercado`.`metodo_pago_venta` (`metodo_pago_venta`) VALUES ('Pse');
INSERT INTO `supermercado`.`metodo_pago_venta` (`metodo_pago_venta`) VALUES ('Datáfono');

INSERT INTO `supermercado`.`producto` (`nombre`, `descripcion`, `fecha_registro`,`costo`,`precio`) VALUES ('Carne de res', 'kilo', '2020-01-10','10000','20000 ');
INSERT INTO `supermercado`.`producto` (`nombre`, `descripcion`, `fecha_registro`,`costo`,`precio`) VALUES ('Carne de cerdo', 'kilo', '2020-01-11','15000','30000');
INSERT INTO `supermercado`.`producto` (`nombre`, `descripcion`, `fecha_registro`,`costo`,`precio`) VALUES ('Pollo ', 'kilo', '2020-01-12','12000','24000');
INSERT INTO `supermercado`.`producto` (`nombre`, `descripcion`, `fecha_registro`,`costo`,`precio`) VALUES ('Pavo ', 'kilo', '2020-01-13','13000','26000');
INSERT INTO `supermercado`.`producto` (`nombre`, `descripcion`, `fecha_registro`,`costo`,`precio`) VALUES ('Carne de cordero', 'kilo', '2020-01-14','15000','30000');
INSERT INTO `supermercado`.`producto` (`nombre`, `descripcion`, `fecha_registro`,`costo`,`precio`) VALUES ('Salchichas Zenú', 'Tarro', '2020-01-15','8000','16000');
INSERT INTO `supermercado`.`producto` (`nombre`, `descripcion`, `fecha_registro`,`costo`,`precio`) VALUES ('Salchichas rancheras', 'Paquete', '2020-01-16','12000','24000');
INSERT INTO `supermercado`.`producto` (`nombre`, `descripcion`, `fecha_registro`,`costo`,`precio`) VALUES ('Chorizo', 'Paquete', '2020-01-17','15000','30000');
INSERT INTO `supermercado`.`producto` (`nombre`, `descripcion`, `fecha_registro`,`costo`,`precio`) VALUES ('Mortadela', 'Paquete', '2020-01-18','12000','24000');
INSERT INTO `supermercado`.`producto` (`nombre`, `descripcion`, `fecha_registro`,`costo`,`precio`) VALUES ('Jamón', 'Paquete', '2020-01-19','10000','20000');
INSERT INTO `supermercado`.`producto` (`nombre`, `descripcion`, `fecha_registro`,`costo`,`precio`) VALUES ('Atun', 'Tarro', '2020-01-20','8000','16000');
INSERT INTO `supermercado`.`producto` (`nombre`, `descripcion`, `fecha_registro`,`costo`,`precio`) VALUES ('Sardina', 'Tarro', '2020-01-21','8000','16000');
INSERT INTO `supermercado`.`producto` (`nombre`, `descripcion`, `fecha_registro`,`costo`,`precio`) VALUES ('Carne molida', 'Paquete', '2020-01-22','18000','36000');
INSERT INTO `supermercado`.`producto` (`nombre`, `descripcion`, `fecha_registro`,`costo`,`precio`) VALUES ('Salmon', 'Pescado Fresco', '2020-01-23','14000','28000');
INSERT INTO `supermercado`.`producto` (`nombre`, `descripcion`, `fecha_registro`,`costo`,`precio`) VALUES ('Tilapia', 'Pescado Fresco', '2020-01-23','12000','24000');

INSERT INTO `supermercado`.`producto` (`nombre`, `descripcion`, `fecha_registro`,`costo`,`precio`) VALUES ('Arroz Diana', 'kilo', '2020-02-10','9000','18000');
INSERT INTO `supermercado`.`producto` (`nombre`, `descripcion`, `fecha_registro`,`costo`,`precio`) VALUES ('Arroz Roa', 'kilo', '2020-02-11','11000','22000');
INSERT INTO `supermercado`.`producto` (`nombre`, `descripcion`, `fecha_registro`,`costo`,`precio`) VALUES ('Frijol', 'kilo', '2020-02-12','12000','24000');
INSERT INTO `supermercado`.`producto` (`nombre`, `descripcion`, `fecha_registro`,`costo`,`precio`) VALUES ('Lenteja', 'kilo', '2020-02-13','9000','18000');
INSERT INTO `supermercado`.`producto` (`nombre`, `descripcion`, `fecha_registro`,`costo`,`precio`) VALUES ('Palomitas de maiz', 'kilo', '2020-02-14','7000','14000');

INSERT INTO `supermercado`.`producto` (`nombre`, `descripcion`, `fecha_registro`,`costo`,`precio`) VALUES ('Leche', 'Litro', '2020-03-10','5000','10000');
INSERT INTO `supermercado`.`producto` (`nombre`, `descripcion`, `fecha_registro`,`costo`,`precio`) VALUES ('Yogur ', 'Tarro', '2020-03-11','1500','3000');
INSERT INTO `supermercado`.`producto` (`nombre`, `descripcion`, `fecha_registro`,`costo`,`precio`) VALUES ('Queso campesino', 'Kilo', '2020-03-12','6000','12000');
INSERT INTO `supermercado`.`producto` (`nombre`, `descripcion`, `fecha_registro`,`costo`,`precio`) VALUES ('Mantequilla', 'Tarro', '2020-03-13','6000','12000');
INSERT INTO `supermercado`.`producto` (`nombre`, `descripcion`, `fecha_registro`,`costo`,`precio`) VALUES ('Leche condensada', 'Tarro', '2020-03-14','4000','8000');
INSERT INTO `supermercado`.`producto` (`nombre`, `descripcion`, `fecha_registro`,`costo`,`precio`) VALUES ('Queso crema', 'Tarro', '2020-03-15','8000','16000');

INSERT INTO `supermercado`.`producto` (`nombre`, `descripcion`, `fecha_registro`,`costo`,`precio`) VALUES ('Papas fritas', 'Paquete', '2020-04-10','3000','6000');
INSERT INTO `supermercado`.`producto` (`nombre`, `descripcion`, `fecha_registro`,`costo`,`precio`) VALUES ('Galletas saladas', 'Paquete', '2020-04-11','6500','13000');
INSERT INTO `supermercado`.`producto` (`nombre`, `descripcion`, `fecha_registro`,`costo`,`precio`) VALUES ('Chocolatina Jet pequeña', 'Unidad', '2020-04-12','700','1400');
INSERT INTO `supermercado`.`producto` (`nombre`, `descripcion`, `fecha_registro`,`costo`,`precio`) VALUES ('Chocolatina Jumbo Grande', 'Unidad', '2020-04-13','2000','4000');
INSERT INTO `supermercado`.`producto` (`nombre`, `descripcion`, `fecha_registro`,`costo`,`precio`) VALUES ('Chicle trident', 'Unidad', '2020-04-14','200','400');
INSERT INTO `supermercado`.`producto` (`nombre`, `descripcion`, `fecha_registro`,`costo`,`precio`) VALUES ('Chicle Charms', 'Unidad', '2020-04-15','100','200');
INSERT INTO `supermercado`.`producto` (`nombre`, `descripcion`, `fecha_registro`,`costo`,`precio`) VALUES ('Platanitos', 'Paquete', '2020-04-16','1500','3000');

INSERT INTO `supermercado`.`producto` (`nombre`, `descripcion`, `fecha_registro`,`costo`,`precio`) VALUES ('Jabon de manos', 'Tarro', '2020-05-10','5000','10000');
INSERT INTO `supermercado`.`producto` (`nombre`, `descripcion`, `fecha_registro`,`costo`,`precio`) VALUES ('Champú ego', 'Tarro', '2020-05-11','5000','10000');
INSERT INTO `supermercado`.`producto` (`nombre`, `descripcion`, `fecha_registro`,`costo`,`precio`) VALUES ('Gel ego', 'Tarro', '2020-05-12','2000','4000');
INSERT INTO `supermercado`.`producto` (`nombre`, `descripcion`, `fecha_registro`,`costo`,`precio`) VALUES ('Gel moco de gorila', 'Tarro', '2020-05-13','9000','18000');
INSERT INTO `supermercado`.`producto` (`nombre`, `descripcion`, `fecha_registro`,`costo`,`precio`) VALUES ('Pasta dental colgate', 'Unidad', '2020-05-14','7000','14000');
INSERT INTO `supermercado`.`producto` (`nombre`, `descripcion`, `fecha_registro`,`costo`,`precio`) VALUES ('Pasta dental genérica', 'Unidad', '2020-05-15','6000','12000');
INSERT INTO `supermercado`.`producto` (`nombre`, `descripcion`, `fecha_registro`,`costo`,`precio`) VALUES ('Detergente fab', 'Bolsa grande', '2020-05-16','8000','16000');
INSERT INTO `supermercado`.`producto` (`nombre`, `descripcion`, `fecha_registro`,`costo`,`precio`) VALUES ('Desodorante rexona barra', 'unidad', '2020-05-17','9000','18000');
INSERT INTO `supermercado`.`producto` (`nombre`, `descripcion`, `fecha_registro`,`costo`,`precio`) VALUES ('Servilletas', 'Paquete', '2020-05-18','3000','6000');
INSERT INTO `supermercado`.`producto` (`nombre`, `descripcion`, `fecha_registro`,`costo`,`precio`) VALUES ('Bolsas de basura', 'Unidad', '2020-05-19','500','1000 ');
INSERT INTO `supermercado`.`producto` (`nombre`, `descripcion`, `fecha_registro`,`costo`,`precio`) VALUES ('Tampones', 'Paquete', '2020-05-20','4000','8000');
INSERT INTO `supermercado`.`producto` (`nombre`, `descripcion`, `fecha_registro`,`costo`,`precio`) VALUES ('Toallas', 'Paquete', '2020-05-21','8000','16000');
INSERT INTO `supermercado`.`producto` (`nombre`, `descripcion`, `fecha_registro`,`costo`,`precio`) VALUES ('Pañales', 'Paquete', '2020-05-22','9000','18000');

INSERT INTO `supermercado`.`producto` (`nombre`, `descripcion`, `fecha_registro`,`costo`,`precio`) VALUES ('Purina cat chow', 'Kilo', '2020-06-10','4000','8000');
INSERT INTO `supermercado`.`producto` (`nombre`, `descripcion`, `fecha_registro`,`costo`,`precio`) VALUES ('Purina dog chow', 'Bulto', '2020-06-11','40000','80000');

INSERT INTO `supermercado`.`producto_categoria` (`idcategoria`, `idproducto`) VALUES ('1', '1');
INSERT INTO `supermercado`.`producto_categoria` (`idcategoria`, `idproducto`) VALUES ('1', '2');
INSERT INTO `supermercado`.`producto_categoria` (`idcategoria`, `idproducto`) VALUES ('1', '3');
INSERT INTO `supermercado`.`producto_categoria` (`idcategoria`, `idproducto`) VALUES ('1', '4');
INSERT INTO `supermercado`.`producto_categoria` (`idcategoria`, `idproducto`) VALUES ('1', '5');
INSERT INTO `supermercado`.`producto_categoria` (`idcategoria`, `idproducto`) VALUES ('1', '6');
INSERT INTO `supermercado`.`producto_categoria` (`idcategoria`, `idproducto`) VALUES ('1', '7');
INSERT INTO `supermercado`.`producto_categoria` (`idcategoria`, `idproducto`) VALUES ('1', '8');
INSERT INTO `supermercado`.`producto_categoria` (`idcategoria`, `idproducto`) VALUES ('1', '9');
INSERT INTO `supermercado`.`producto_categoria` (`idcategoria`, `idproducto`) VALUES ('1', '10');
INSERT INTO `supermercado`.`producto_categoria` (`idcategoria`, `idproducto`) VALUES ('1', '11');
INSERT INTO `supermercado`.`producto_categoria` (`idcategoria`, `idproducto`) VALUES ('1', '12');
INSERT INTO `supermercado`.`producto_categoria` (`idcategoria`, `idproducto`) VALUES ('1', '13');
INSERT INTO `supermercado`.`producto_categoria` (`idcategoria`, `idproducto`) VALUES ('1', '14');
INSERT INTO `supermercado`.`producto_categoria` (`idcategoria`, `idproducto`) VALUES ('1', '15');
INSERT INTO `supermercado`.`producto_categoria` (`idcategoria`, `idproducto`) VALUES ('2', '16');
INSERT INTO `supermercado`.`producto_categoria` (`idcategoria`, `idproducto`) VALUES ('2', '17');
INSERT INTO `supermercado`.`producto_categoria` (`idcategoria`, `idproducto`) VALUES ('2', '18');
INSERT INTO `supermercado`.`producto_categoria` (`idcategoria`, `idproducto`) VALUES ('2', '19');
INSERT INTO `supermercado`.`producto_categoria` (`idcategoria`, `idproducto`) VALUES ('2', '20');
INSERT INTO `supermercado`.`producto_categoria` (`idcategoria`, `idproducto`) VALUES ('3', '21');
INSERT INTO `supermercado`.`producto_categoria` (`idcategoria`, `idproducto`) VALUES ('3', '22');
INSERT INTO `supermercado`.`producto_categoria` (`idcategoria`, `idproducto`) VALUES ('3', '23');
INSERT INTO `supermercado`.`producto_categoria` (`idcategoria`, `idproducto`) VALUES ('3', '24');
INSERT INTO `supermercado`.`producto_categoria` (`idcategoria`, `idproducto`) VALUES ('3', '25');
INSERT INTO `supermercado`.`producto_categoria` (`idcategoria`, `idproducto`) VALUES ('3', '26');
INSERT INTO `supermercado`.`producto_categoria` (`idcategoria`, `idproducto`) VALUES ('4', '27');
INSERT INTO `supermercado`.`producto_categoria` (`idcategoria`, `idproducto`) VALUES ('4', '28');
INSERT INTO `supermercado`.`producto_categoria` (`idcategoria`, `idproducto`) VALUES ('4', '29');
INSERT INTO `supermercado`.`producto_categoria` (`idcategoria`, `idproducto`) VALUES ('4', '30');
INSERT INTO `supermercado`.`producto_categoria` (`idcategoria`, `idproducto`) VALUES ('4', '31');
INSERT INTO `supermercado`.`producto_categoria` (`idcategoria`, `idproducto`) VALUES ('4', '32');
INSERT INTO `supermercado`.`producto_categoria` (`idcategoria`, `idproducto`) VALUES ('4', '33');
INSERT INTO `supermercado`.`producto_categoria` (`idcategoria`, `idproducto`) VALUES ('5', '34');
INSERT INTO `supermercado`.`producto_categoria` (`idcategoria`, `idproducto`) VALUES ('5', '35');
INSERT INTO `supermercado`.`producto_categoria` (`idcategoria`, `idproducto`) VALUES ('5', '36');
INSERT INTO `supermercado`.`producto_categoria` (`idcategoria`, `idproducto`) VALUES ('5', '37');
INSERT INTO `supermercado`.`producto_categoria` (`idcategoria`, `idproducto`) VALUES ('5', '38');
INSERT INTO `supermercado`.`producto_categoria` (`idcategoria`, `idproducto`) VALUES ('5', '39');
INSERT INTO `supermercado`.`producto_categoria` (`idcategoria`, `idproducto`) VALUES ('5', '40');
INSERT INTO `supermercado`.`producto_categoria` (`idcategoria`, `idproducto`) VALUES ('5', '41');
INSERT INTO `supermercado`.`producto_categoria` (`idcategoria`, `idproducto`) VALUES ('5', '42');
INSERT INTO `supermercado`.`producto_categoria` (`idcategoria`, `idproducto`) VALUES ('5', '43');
INSERT INTO `supermercado`.`producto_categoria` (`idcategoria`, `idproducto`) VALUES ('5', '44');
INSERT INTO `supermercado`.`producto_categoria` (`idcategoria`, `idproducto`) VALUES ('5', '45');
INSERT INTO `supermercado`.`producto_categoria` (`idcategoria`, `idproducto`) VALUES ('5', '46');

INSERT INTO `supermercado`.`producto_categoria` (`idcategoria`, `idproducto`) VALUES ('7', '6');
INSERT INTO `supermercado`.`producto_categoria` (`idcategoria`, `idproducto`) VALUES ('7', '11');
INSERT INTO `supermercado`.`producto_categoria` (`idcategoria`, `idproducto`) VALUES ('7', '12');
INSERT INTO `supermercado`.`producto_categoria` (`idcategoria`, `idproducto`) VALUES ('8', '7');
INSERT INTO `supermercado`.`producto_categoria` (`idcategoria`, `idproducto`) VALUES ('8', '8');

INSERT INTO `supermercado`.`departamento` (`departamento`, `idpais`) VALUES ('NARIÑO', '1');
INSERT INTO `supermercado`.`departamento` (`departamento`, `idpais`) VALUES ('PUTUMAYO', '1');
INSERT INTO `supermercado`.`departamento` (`departamento`, `idpais`) VALUES ('HUILA', '1');
INSERT INTO `supermercado`.`departamento` (`departamento`, `idpais`) VALUES ('ANTIOQUIA', '1');
INSERT INTO `supermercado`.`departamento` (`departamento`, `idpais`) VALUES ('CUNDINAMARCA', '1');
INSERT INTO `supermercado`.`departamento` (`departamento`, `idpais`) VALUES ('CATALUÑA', '2');
INSERT INTO `supermercado`.`departamento` (`departamento`, `idpais`) VALUES ('FLORIDA', '3');

INSERT INTO `supermercado`.`municipio` (`municipio`, `iddepartamento`) VALUES ('Pasto', '1');
INSERT INTO `supermercado`.`municipio` (`municipio`, `iddepartamento`) VALUES ('Samaniego', '1');
INSERT INTO `supermercado`.`municipio` (`municipio`, `iddepartamento`) VALUES ('Mocoa', '2');
INSERT INTO `supermercado`.`municipio` (`municipio`, `iddepartamento`) VALUES ('Villagarzón', '2');
INSERT INTO `supermercado`.`municipio` (`municipio`, `iddepartamento`) VALUES ('Neiva', '3');
INSERT INTO `supermercado`.`municipio` (`municipio`, `iddepartamento`) VALUES ('Pitalito', '3');
INSERT INTO `supermercado`.`municipio` (`municipio`, `iddepartamento`) VALUES ('Bogotá', '5');
INSERT INTO `supermercado`.`municipio` (`municipio`, `iddepartamento`) VALUES ('Pitalito', '3');
INSERT INTO `supermercado`.`municipio` (`municipio`, `iddepartamento`) VALUES ('Medellín', '4');
INSERT INTO `supermercado`.`municipio` (`municipio`, `iddepartamento`) VALUES ('Bogotá', '5');
INSERT INTO `supermercado`.`municipio` (`municipio`, `iddepartamento`) VALUES ('Barcelona', '6');
INSERT INTO `supermercado`.`municipio` (`municipio`, `iddepartamento`) VALUES ('Miami', '7');

INSERT INTO `supermercado`.`tipo_doc` (`tipo_doc`) VALUES ('TI');
INSERT INTO `supermercado`.`tipo_doc` (`tipo_doc`) VALUES ('CC');
INSERT INTO `supermercado`.`tipo_doc` (`tipo_doc`) VALUES ('CE');
INSERT INTO `supermercado`.`tipo_doc` (`tipo_doc`) VALUES ('Pasaporte');
INSERT INTO `supermercado`.`tipo_doc` (`tipo_doc`) VALUES ('NIT');

INSERT INTO `supermercado`.`tipo_persona` (`tipo_persona`) VALUES ('Natural');
INSERT INTO `supermercado`.`tipo_persona` (`tipo_persona`) VALUES ('Jurídica');

INSERT INTO `supermercado`.`persona` (`idpersona`, `idtipo_doc`, `idtipo_persona`, `nombre`, `apellido`, `telefono`, `email`, `fecha_nacimiento`, `direccion`, `idmunicipio`) VALUES ('100000001', '1', '1', 'BRIGITE', 'FUEL', '3204414571', 'brigite@gmail.com', '2008-12-01', 'B/Centro', '1');
INSERT INTO `supermercado`.`persona` (`idpersona`, `idtipo_doc`, `idtipo_persona`, `nombre`, `apellido`, `telefono`, `email`, `fecha_nacimiento`, `direccion`, `idmunicipio`) VALUES ('100000002', '1', '1', 'SANDRA', 'GUALGUAN', '3204414572', 'sandra@gmail.com', '2008-02-02', 'B/Carolina', '1');
INSERT INTO `supermercado`.`persona` (`idpersona`, `idtipo_doc`, `idtipo_persona`, `nombre`, `apellido`, `telefono`, `email`, `fecha_nacimiento`, `direccion`, `idmunicipio`) VALUES ('100000003', '2', '1', 'YEIMI', 'ARGOTI', '3204414573', 'yeimi@gmail.com', '1975-02-12', 'B/Pandiaco', '1');
INSERT INTO `supermercado`.`persona` (`idpersona`, `idtipo_doc`, `idtipo_persona`, `nombre`, `apellido`, `telefono`, `email`, `fecha_nacimiento`, `direccion`, `idmunicipio`) VALUES ('100000004', '2', '1', 'ANDRES', 'BARRERA', '3204414574', 'andres@gmail.com', '1980-12-12', 'B/Centro', '1');
INSERT INTO `supermercado`.`persona` (`idpersona`, `idtipo_doc`, `idtipo_persona`, `nombre`, `apellido`, `telefono`, `email`, `fecha_nacimiento`, `direccion`, `idmunicipio`) VALUES ('100000005', '2', '1', 'HECTOR', 'MADROÑERO', '3204414575', 'hector@gmail.com', '1976-11-10', 'V/ Via al puente', '2');
INSERT INTO `supermercado`.`persona` (`idpersona`, `idtipo_doc`, `idtipo_persona`, `nombre`, `apellido`, `telefono`, `email`, `fecha_nacimiento`, `direccion`, `idmunicipio`) VALUES ('100000006', '2', '1', 'RICHARD', 'BASTIDAS', '3204414576', 'richard@gmail.com', '1960-09-21', 'B/ Centro', '2');
INSERT INTO `supermercado`.`persona` (`idpersona`, `idtipo_doc`, `idtipo_persona`, `nombre`, `apellido`, `telefono`, `email`, `fecha_nacimiento`, `direccion`, `idmunicipio`) VALUES ('100000007', '2', '1', 'GINA', 'VEGA', '3204414577', 'gina@gmail.com', '1986-08-01', 'B/ JH', '2');
INSERT INTO `supermercado`.`persona` (`idpersona`, `idtipo_doc`, `idtipo_persona`, `nombre`, `apellido`, `telefono`, `email`, `fecha_nacimiento`, `direccion`, `idmunicipio`) VALUES ('100000008', '2', '1', 'GINELA', 'ORTIZ', '3204414578', 'ginela@gmail.com', '1987-05-01', 'B/Union', '2');
INSERT INTO `supermercado`.`persona` (`idpersona`, `idtipo_doc`, `idtipo_persona`, `nombre`, `apellido`, `telefono`, `email`, `fecha_nacimiento`, `direccion`, `idmunicipio`) VALUES ('100000009', '2', '1', 'JAIRO', 'LUNA', '3204414579', 'jairo@gmail.com', '1970-12-11', 'B/Villa Natalia', '3');
INSERT INTO `supermercado`.`persona` (`idpersona`, `idtipo_doc`, `idtipo_persona`, `nombre`, `apellido`, `telefono`, `email`, `fecha_nacimiento`, `direccion`, `idmunicipio`) VALUES ('1000000010', '2', '1', 'WILSON', 'GOMEZ', '3204414510', 'wilson@gmail.com', '1987-11-11', 'B/ Independencia', '3');
INSERT INTO `supermercado`.`persona` (`idpersona`, `idtipo_doc`, `idtipo_persona`, `nombre`, `apellido`, `telefono`, `email`, `fecha_nacimiento`, `direccion`, `idmunicipio`) VALUES ('1000000011', '2', '1', 'LUIS', 'AGUIRRE', '3204414511', 'luis1@gmail.com', '1976-01-01', 'B/ Modelo', '3');
INSERT INTO `supermercado`.`persona` (`idpersona`, `idtipo_doc`, `idtipo_persona`, `nombre`, `apellido`, `telefono`, `email`, `fecha_nacimiento`, `direccion`, `idmunicipio`) VALUES ('1000000013', '2', '1', 'YENNI', 'CHAVES', '3204414513', 'yenni@gmail.com', '1999-04-13', 'V/ La Alemania', '4');
INSERT INTO `supermercado`.`persona` (`idpersona`, `idtipo_doc`, `idtipo_persona`, `nombre`, `apellido`, `telefono`, `email`, `fecha_nacimiento`, `direccion`, `idmunicipio`) VALUES ('1000000014', '2', '1', 'JAVIER', 'HERNANDEZ', '3204414514', 'javier@gmail.com', '1976-03-11', 'B/ Los Diamantes', '4');
INSERT INTO `supermercado`.`persona` (`idpersona`, `idtipo_doc`, `idtipo_persona`, `nombre`, `apellido`, `telefono`, `email`, `fecha_nacimiento`, `direccion`, `idmunicipio`) VALUES ('1000000015', '2', '1', 'MONICA', 'HERNANDEZ', '3204414515', 'monica@gmail.com', '1986-04-11', 'B/ Los diamantes', '4');
INSERT INTO `supermercado`.`persona` (`idpersona`, `idtipo_doc`, `idtipo_persona`, `nombre`, `apellido`, `telefono`, `email`, `fecha_nacimiento`, `direccion`, `idmunicipio`) VALUES ('1000000016', '2', '1', 'ALEXANDRA', 'JURADO', '3204414516', 'alexandra@gmail.com', '1997-07-12', 'B/ Villacolombia', '4');
INSERT INTO `supermercado`.`persona` (`idpersona`, `idtipo_doc`, `idtipo_persona`, `nombre`, `apellido`, `telefono`, `email`, `fecha_nacimiento`, `direccion`, `idmunicipio`) VALUES ('1000000017', '2', '1', 'LUBIER', 'VEGA', '3204414517', 'lubier@gmail.com', '1999-02-02', 'V/ El Nogal', '5');
INSERT INTO `supermercado`.`persona` (`idpersona`, `idtipo_doc`, `idtipo_persona`, `nombre`, `apellido`, `telefono`, `email`, `fecha_nacimiento`, `direccion`, `idmunicipio`) VALUES ('1000000018', '2', '1', 'FABIO', 'DIAZ', '3204414518', 'fabio@gmail.com', '1990-03-04', 'B/ San Isidro', '5');
INSERT INTO `supermercado`.`persona` (`idpersona`, `idtipo_doc`, `idtipo_persona`, `nombre`, `apellido`, `telefono`, `email`, `fecha_nacimiento`, `direccion`, `idmunicipio`) VALUES ('1000000019', '2', '1', 'ALBERTO', 'ANDAMIO', '3204414519', 'alberto@gmail.com', '1979-01-18', 'B/ Centro', '5');
INSERT INTO `supermercado`.`persona` (`idpersona`, `idtipo_doc`, `idtipo_persona`, `nombre`, `apellido`, `telefono`, `email`, `fecha_nacimiento`, `direccion`, `idmunicipio`) VALUES ('1000000020', '2', '1', 'POLONIO', 'COLON', '3204414520', 'polonio@gmail.com', '1954-04-03', 'B/ Villasoñada', '5');
INSERT INTO `supermercado`.`persona` (`idpersona`, `idtipo_doc`, `idtipo_persona`, `nombre`, `apellido`, `telefono`, `email`, `fecha_nacimiento`, `direccion`, `idmunicipio`) VALUES ('1000000021', '2', '1', 'ALICIA', 'TABARES', '3204414521', 'alicia@hotmail.com', '1990-09-07', 'B/ Normandía', '6');
INSERT INTO `supermercado`.`persona` (`idpersona`, `idtipo_doc`, `idtipo_persona`, `nombre`, `apellido`, `telefono`, `email`, `fecha_nacimiento`, `direccion`, `idmunicipio`) VALUES ('1000000022', '2', '1', 'JUAN', 'ALARCON', '3204414522', 'juan@hotmail.com', '1967-05-09', 'B/ Villahermosa', '6');
INSERT INTO `supermercado`.`persona` (`idpersona`, `idtipo_doc`, `idtipo_persona`, `nombre`, `apellido`, `telefono`, `email`, `fecha_nacimiento`, `direccion`, `idmunicipio`) VALUES ('1000000023', '2', '1', 'PATRICIA', 'CORONEL', '3204414523', 'patricia@hotmail.com', '1988-12-07', 'B/ Olímpica', '6');
INSERT INTO `supermercado`.`persona` (`idpersona`, `idtipo_doc`, `idtipo_persona`, `nombre`, `apellido`, `telefono`, `email`, `fecha_nacimiento`, `direccion`, `idmunicipio`) VALUES ('1000000024', '2', '1', 'JUAN', 'TABARES', '3204414524', 'juan@hotmail.com', '2000-06-07', 'B/ La Pradera', '6');
INSERT INTO `supermercado`.`persona` (`idpersona`, `idtipo_doc`, `idtipo_persona`, `nombre`, `apellido`, `telefono`, `email`, `fecha_nacimiento`, `direccion`, `idmunicipio`) VALUES ('1000000025', '3', '1', 'MARCELO', 'ZAPATA', '3204414525', 'marcelo@hotmail.com', '2002-03-12', 'Av/ La Española', '7');
INSERT INTO `supermercado`.`persona` (`idpersona`, `idtipo_doc`, `idtipo_persona`, `nombre`, `apellido`, `telefono`, `email`, `fecha_nacimiento`, `direccion`, `idmunicipio`) VALUES ('1000000026', '4', '1', 'MICHAEL', 'SMITH', '3204414526', 'michael@hotmail.com', '1999-04-06', 'Wall Street', '8');
INSERT INTO `supermercado`.`persona` (`idpersona`, `idtipo_doc`, `idtipo_persona`, `nombre`, `apellido`, `telefono`, `email`, `fecha_nacimiento`, `direccion`, `idmunicipio`) VALUES ('1000000027', '3', '1', 'RAMON', 'BENCENO', '3204414527', 'ramon@hotmail.com', '1998-06-01', 'Av/ Los Chavales', '7');
INSERT INTO `supermercado`.`persona` (`idpersona`, `idtipo_doc`, `idtipo_persona`, `nombre`, `apellido`, `telefono`, `email`, `fecha_nacimiento`, `direccion`, `idmunicipio`) VALUES ('1000000028', '4', '1', 'JESICA', 'SIMPSON', '3204414528', 'jesica@hotmail.com', '2000-07-07', 'Beach', '8');
INSERT INTO `supermercado`.`persona` (`idpersona`, `idtipo_doc`, `idtipo_persona`, `nombre`, `apellido`, `telefono`, `email`, `fecha_nacimiento`, `direccion`, `idmunicipio`) VALUES ('1000000029', '5', '2', 'GARCIA', 'HERMANOS', '3204444444', 'hermanosg@compa.com', '1977-12-12', 'B/centro', '5');
INSERT INTO `supermercado`.`persona` (`idpersona`, `idtipo_doc`, `idtipo_persona`, `nombre`, `apellido`, `telefono`, `email`, `fecha_nacimiento`, `direccion`, `idmunicipio`) VALUES ('1000000030', '5', '2', 'GOMEZ', 'ASOCIADOS', '3162222222', 'gomezsa@mail.com', '1950-11-07', 'B/Centro', '5');
INSERT INTO `supermercado`.`persona` (`idpersona`, `idtipo_doc`, `idtipo_persona`, `nombre`, `apellido`, `telefono`, `email`, `fecha_nacimiento`, `direccion`, `idmunicipio`) VALUES ('1777777731', '2', '1', 'ANGELA', 'ESPINOSA', '3157777771', 'angietabares@hotmail.com', '1987-11-13', 'B/Villahermosa', '9');
INSERT INTO `supermercado`.`persona` (`idpersona`, `idtipo_doc`, `idtipo_persona`, `nombre`, `apellido`, `telefono`, `email`, `fecha_nacimiento`, `direccion`, `idmunicipio`) VALUES ('1985555532', '2', '1', 'PATRICIA', 'PEDRAZA', '3189898782', 'pato@hotmail.com', '1999-12-12', 'B/Centro', '10');


INSERT INTO `supermercado`.`empleado` (`idpersona`, `email_institucional`, `contrasena`, `fecha_registro`) VALUES ('1777777731', 'espinosa@mercado.com', '123', '2020-07-01');
INSERT INTO `supermercado`.`empleado` (`idpersona`, `email_institucional`, `contrasena`, `fecha_registro`) VALUES ('1985555532', 'pedraza@mercado.com', '234', '2020-07-02');
INSERT INTO `supermercado`.`empleado` (`idpersona`, `email_institucional`, `contrasena`, `fecha_registro`) VALUES ('1000000024', 'tabares@mercado.com', '345', '2020-07-03');








