/* CREACION DE TABLAS */

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
 nombre VARCHAR2(20),
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
 nombre VARCHAR2(20) NOT NULL,
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
 
  