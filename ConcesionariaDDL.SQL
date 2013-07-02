CREATE OR REPLACE TYPE ListaDeCompras AS VARRAY(1000) OF INTEGER;
CREATE OR REPLACE TYPE ListaDeVehiculos AS VARRAY(100) OF VARCHAR2(30);
CREATE OR REPLACE TYPE ListaDePedidos AS VARRAY(20) OF INTEGER;
CREATE OR REPLACE TYPE ListaDeAdicionales AS VARRAY(100) OF INTEGER;

CREATE TABLE IF NOT EXISTS sector(
idSector SMALLINT NOT NULL UNIQUE AUTO_INCREMENT,
descripcion VARCHAR2(20) NOT NULL UNIQUE,
PRIMARY KEY idSector);

CREATE TABLE IF NOT EXISTS sucursal(
 idSucursal SMALLINT NOT NULL UNIQUE AUTO_INCREMENT,
 gerente VARCHAR2(20) CHECK gerente IN (SELECT apellido FROM empleado WHERE cargo like '%Gerente%'),
 cantidadDeEmpleados NUMBER(4), -- como le asigno un select count(id) from empleados WHERE sucursal = this ???
 montoDeVentas NUMBER(10,2), -- como le asigno un select sum(monto) FROM ventas WHERE idSucursal = this ???
 sector VARCHAR2(15) CHECK sector IN (SELECT descripcion FROM sector),
 direccion VARCHAR2(50),
 telefono VARCHAR2(20),
 INDEX(idSucursal),
 INDEX(gerente),
 PRIMARY KEY idSucursal);
 
 /*
 CREATE TABLE IF NOT EXISTS persona(
 dni VARCHAR2(15) NOT NULL UNIQUE,
 nombre VARCHAR2(25),
 apellido VARCHAR2(30),
 direccion VARCHAR2(60),
 telefono VARCHAR2(30),
 INDEX(dni(15)),
 INDEX(apellido(15)),
 PRIMARY KEY dni);
 */
 
 CREATE TABLE IF NOT EXISTS vehiculo(
 vin VARCHAR2(30) NOT NULL UNIQUE,
 marca VARCHAR2(25),
 modelo VARCHAR2(50),
 anio SMALLINT,
 precio NUMBER(10,2),
 color VARCHAR2(15),
 equipamiento VARCHAR2(750),
 INDEX(vin(30)),
 INDEX(marca(10)),
 INDEX(modelo(15)),
 PRIMARY KEY vin);
 
 CREATE TABLE IF NOT EXISTS empleado(
 idEmpleado INTEGER NOT NULL UNIQUE AUTO_INCREMENT,
 dni VARCHAR2(15) NOT NULL UNIQUE,
 nombre VARCHAR2(25) NOT NULL,
 apellido VARCHAR2(30) NOT NULL,
 direccion VARCHAR2(60) NOT NULL,
 sueldo NUMBER(10,2) NOT NULL,
 numero_sucursal SMALLINT CHECK numero_sucursal IN (SELECT idSucursal FROM sucursal),
 nombre_sector VARCHAR2(15) CHECK sector IN (SELECT descripcion FROM sector),
 cargo VARCHAR2(60) NOT NULL,
 mail VARCHAR2(40) NOT NULL UNIQUE,
 INDEX(mail(30)),
 INDEX(idEmpleado),
 INDEX(dni(15)),
 PRIMARY KEY(idEmpleado,mail),
 FOREIGN KEY numero_sucursal REFERENCES sucursal(idSucursal),
 FOREIGN KEY nombre_sector REFERENCES sector(descripcion));
 
 CREATE TABLE IF NOT EXISTS cliente(
 idCliente INTEGER NOT NULL UNIQUE AUTO_INCREMENT,
 dni VARCHAR2(15) NOT NULL UNIQUE,
 nombre VARCHAR2(25) NOT NULL,
 apellido VARCHAR2(30) NOT NULL,
 nivel CHAR(2) CHECK nivel IN ('A1','B1','C1','A2','B2','C2','A3','B3','C3'),
 mail VARCHAR2(60) NOT NULL UNIQUE,
 idSucursal SMALLINT CHECK idSucursal IN (SELECT idSucursal FROM sucursal),
 compras ListaDeCompras,
 direccion VARCHAR2(50) NOT NULL,
 telefono VARCHAR2(20) NOT NULL,
 INDEX(idCliente),
 INDEX(dni(15)),
 INDEX(apellido(30)),
 FOREIGN KEY sucursal_pertenencia REFERENCES sucursal(idSucursal),
 PRIMARY KEY(idCliente));
 
 CREATE TABLE IF NOT EXISTS venta(
 idVenta INTEGER NOT NULL UNIQUE AUTO_INCREMENT,
 idVendedor INTEGER NOT NULL,
 idVehiculos ListaDeVehiculos,
 seña NUMBER(10,2) NOT NULL,
 idCliente INTEGER NOT NULL,
 dniCliente VARCHAR(15) NOT NULL
 metodoDePago VARCHAR2(20) NOT NULL,
 cantidad INT NOT NULL,
 idSucursal SMALLINT CHECK idSucursal IN (SELECT idSucursal FROM sucursal),
 fechaVenta DATE NOT NULL,
 fechaDeEntrega DATE NOT NULL,
 comisionVendedor DOUBLE NOT NULL,
 pedidos ListaDePedidos NOT NULL,
 adicionales ListaDeAdicionales,
 INDEX(idVenta),
 INDEX(idVendedor),
 INDEX(idCliente),
 INDEX(idSucursal),
 PRIMARY KEY(idVenta),
 FOREIGN KEY idVendedor REFERENCES vendedor(idVendedor),
 FOREIGN KEY idVehiculos REFERENCES vehiculos(idVehiculo),
 FOREIGN KEY idCliente REFERENCES cliente(idCliente));
 
 CREATE TABLE IF NOT EXISTS pedido(
 idPedido INTEGER NOT NULL UNIQUE,
 idVenta INTEGER NOT NULL,
 cantidadDeUnidades INT NOT NULL,
 marca VARCHAR2(25) NOT NULL,
 modelo VARCHAR2(50) NOT NULL,
 fechaPedido DATE NOT NULL,
 fechaEntrega DATE NOT NULL,
 adicionales ListaDeAdicionales,
 INDEX(idPedido),
 INDEX(idVenta),
 FOREIGN KEY idVenta REFERENCES venta(idVenta),
 PRIMARY KEY(idPedido));
 
 
 
