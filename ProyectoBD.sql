
--Universidad del Valle
--Escuela de Ingenieria de Sistemas
--Bases de Datos
--Camilo José Cruz Rivera--1428907
--Erik Lopez Pachco--1430406
--Robert leandro quiceno --¿?
--Juan Carlos Viteri --¿?
------------------------------------------------------------------------------------------------------------------------------------------
DROP TABLE if exists RUTA CASCADE;
CREATE TABLE  RUTA 
   (	nombre VARCHAR(30) NOT NULL PRIMARY KEY,
	descripcion VARCHAR(100)
   );

------------------------------------------------------------------------------------------------------------------------------------------

DROP TABLE if exists TIPO_BUS CASCADE;
CREATE TABLE  TIPO_BUS 
   (	tipo_id INTEGER NOT NULL,
	nombre_tipo VARCHAR(50),
	CONSTRAINT TIPO_BUS_PK PRIMARY KEY (tipo_id)
   );


------------------------------------------------------------------------------------------------------------------------------------------

DROP TABLE if exists BUS CASCADE;
CREATE TABLE  BUS 
   (	placa INTEGER NOT NULL,
	tipo INTEGER,
	nombre_ruta VARCHAR(30),
	CONSTRAINT BUS_PK PRIMARY KEY (placa),
	CONSTRAINT bus_ruta_fk FOREIGN KEY (nombre_ruta) REFERENCES RUTA (nombre),
	CONSTRAINT bus_tipo_fk FOREIGN KEY (tipo) REFERENCES TIPO_BUS (tipo_id) 
   );

------------------------------------------------------------------------------------------------------------------------------------------

DROP TABLE if exists TIPO_TARJETA CASCADE;
CREATE TABLE  TIPO_TARJETA 
   (	tipo_id INTEGER NOT NULL,
	nombre_tipo VARCHAR(50),
	CONSTRAINT TIPO_TARJETA_PK PRIMARY KEY (tipo_id)
   );

------------------------------------------------------------------------------------------------------------------------------------------

DROP TABLE if exists TARJETA CASCADE;
CREATE TABLE  TARJETA 
   (	tarjeta_id INTEGER NOT NULL,
	saldo INTEGER,
	estado BOOLEAN,
	tipo INTEGER, 
	CONSTRAINT TARJETA_PK PRIMARY KEY (tarjeta_id),
        CONSTRAINT tipo_tar_fk FOREIGN KEY (tipo) REFERENCES TIPO_TARJETA (tipo_id)  
   );

------------------------------------------------------------------------------------------------------------------------------------------

DROP TABLE if exists VIAJE CASCADE;
CREATE TABLE  VIAJE 
   (	fecha DATE NOT NULL,
	hora TIME NOT NULL,
	tarjeta_id INTEGER NOT NULL,
	placa_bus INTEGER NOT NULL,
	CONSTRAINT VIAJE_PK PRIMARY KEY (fecha, hora, tarjeta_id, placa_bus),
        CONSTRAINT placa_bus_fk FOREIGN KEY (placa_bus) REFERENCES BUS (placa),
        CONSTRAINT tarjeta_id_fk FOREIGN KEY (tarjeta_id) REFERENCES TARJETA (tarjeta_id)  
   );

------------------------------------------------------------------------------------------------------------------------------------------

DROP TABLE if exists CARGO CASCADE;
CREATE TABLE  CARGO 
   (	cargo_id INTEGER NOT NULL,
	nombre_cargo VARCHAR(15),
	CONSTRAINT CARGO_PK PRIMARY KEY (cargo_id)        
   );

------------------------------------------------------------------------------------------------------------------------------------------

DROP TABLE if exists DATOS_EMPLEADOS CASCADE;
CREATE TABLE  DATOS_EMPLEADOS 
   (	cedula INTEGER NOT NULL,
	nombre VARCHAR(15),
	apellido VARCHAR(15),
	telefono INTEGER,
	CONSTRAINT DATOS_EMPLEADOS_PK PRIMARY KEY (cedula)        
   );

------------------------------------------------------------------------------------------------------------------------------------------

DROP TABLE if exists EMPLEADO CASCADE;
CREATE TABLE  EMPLEADO 
   (	empleado_id INTEGER NOT NULL,
	datos_personales INTEGER,
	cargo INTEGER,
	CONSTRAINT EMPLEADO_PK PRIMARY KEY (empleado_id),
        CONSTRAINT datos_personales_fk FOREIGN KEY (datos_personales) REFERENCES DATOS_EMPLEADOS (cedula),
        CONSTRAINT cargo_fk FOREIGN KEY (cargo) REFERENCES CARGO (cargo_id)  
   );

------------------------------------------------------------------------------------------------------------------------------------------

DROP TABLE if exists ESTACION CASCADE;
CREATE TABLE  ESTACION 
   (	nombre_estacion VARCHAR(30) NOT NULL,
	director_id INTEGER,
	CONSTRAINT ESTACION_PK PRIMARY KEY (nombre_estacion),
	CONSTRAINT director_id_fk FOREIGN KEY (director_id) REFERENCES EMPLEADO (empleado_id)          
   );

------------------------------------------------------------------------------------------------------------------------------------------

DROP TABLE if exists MANEJO_BUS CASCADE;
CREATE TABLE  MANEJO_BUS 
   (	conductor_id INTEGER NOT NULL,
	placa_bus INTEGER NOT NULL,
	turno TIME NOT NULL,
	CONSTRAINT MANEJO_BUS_PK PRIMARY KEY (conductor_id, placa_bus, turno),
        CONSTRAINT conductor_id_fk FOREIGN KEY (conductor_id) REFERENCES EMPLEADO (empleado_id),
        CONSTRAINT placa_bus_fk FOREIGN KEY (placa_bus) REFERENCES BUS (placa)  
   );

------------------------------------------------------------------------------------------------------------------------------------------

DROP TABLE if exists VENTA_TARJETA CASCADE;
CREATE TABLE  VENTA_TARJETA 
   (	auxiliar_id INTEGER NOT NULL,
	nombre_estacion VARCHAR(30) NOT NULL,
	tarjeta_id INTEGER NOT NULL,
	CONSTRAINT VENTA_TARJETA_PK PRIMARY KEY (auxiliar_id, nombre_estacion, tarjeta_id),
        CONSTRAINT auxiliar_id_fk FOREIGN KEY (auxiliar_id) REFERENCES EMPLEADO (empleado_id),
	CONSTRAINT nombre_est_fk FOREIGN KEY (nombre_estacion) REFERENCES ESTACION (nombre_estacion),
        CONSTRAINT tarjeta_id_fk FOREIGN KEY (tarjeta_id) REFERENCES TARJETA (tarjeta_id)  
   );

------------------------------------------------------------------------------------------------------------------------------------------

DROP TABLE if exists AVANCES CASCADE;
CREATE TABLE  AVANCES 
   (	tarjeta_id INTEGER NOT NULL,
	num_avances INTEGER,
	estado BOOLEAN,
	CONSTRAINT AVANCES_PK PRIMARY KEY (tarjeta_id, num_avances, estado),
        CONSTRAINT tarjeta_id_fk FOREIGN KEY (tarjeta_id) REFERENCES TARJETA (tarjeta_id)  
   );

------------------------------------------------------------------------------------------------------------------------------------------

DROP TABLE if exists CLIENTE CASCADE;
CREATE TABLE  CLIENTE 
   (	cedula INTEGER NOT NULL,
	nombres VARCHAR (20),
	apellidos VARCHAR (20),
	telefono INTEGER,
	tarjeta_id INTEGER, 
	CONSTRAINT CLIENTE_PK PRIMARY KEY (cedula),
        CONSTRAINT tarjeta_id_fk FOREIGN KEY (tarjeta_id) REFERENCES TARJETA (tarjeta_id)  
   );

------------------------------------------------------------------------------------------------------------------------------------------

DROP TABLE if exists RECLAMO CASCADE;
CREATE TABLE  RECLAMO 
   (	num_tiquete INTEGER NOT NULL,
	fecha DATE,
	motivo VARCHAR,
	descripcion VARCHAR,
	director_id INTEGER,
	cedula_cliente INTEGER,
	CONSTRAINT RECLAMO_PK PRIMARY KEY (num_tiquete),
        CONSTRAINT director_id_fk FOREIGN KEY (director_id) REFERENCES EMPLEADO (empleado_id),
	CONSTRAINT cedula_cliente_fk FOREIGN KEY (cedula_cliente) REFERENCES CLIENTE (cedula)  
   );

------------------------------------------------------------------------------------------------------------------------------------------

DROP TABLE if exists MEDIDAS CASCADE;
CREATE TABLE  MEDIDAS 
   (	num_tiquete INTEGER NOT NULL,
	medida VARCHAR,
	CONSTRAINT MEDIDAS_PK PRIMARY KEY (num_tiquete, medida),
        CONSTRAINT num_tiquete_fk FOREIGN KEY (num_tiquete) REFERENCES RECLAMO (num_tiquete)  
   );

------------------------------------------------------------------------------------------------------------------------------------------

DROP TABLE if exists RECLAMOS_REALIZADOS CASCADE;
CREATE TABLE  RECLAMOS_REALIZADOS 
   (	num_tiquete INTEGER NOT NULL,
	auxiliar_id INTEGER NOT NULL,
	tarjeta_id INTEGER NOT NULL,
	CONSTRAINT RECLAMOS_REALIZADOS_PK PRIMARY KEY (num_tiquete, auxiliar_id, tarjeta_id),
	CONSTRAINT num_tiquete_fk FOREIGN KEY (num_tiquete) REFERENCES RECLAMO (num_tiquete),
        CONSTRAINT auxiliar_id_fk FOREIGN KEY (auxiliar_id) REFERENCES EMPLEADO (empleado_id),
	CONSTRAINT tarjeta_id_fk FOREIGN KEY (tarjeta_id) REFERENCES TARJETA (tarjeta_id)
   );

----------------------------------------------------------------------------------------------------------------------------------------------
DROP TABLE IF exists ESTACION_RUTA CASCADE;
CREATE TABLE ESTACION_RUTA
(
	id_ruta INTEGER NOT NULL,
	id_estacion INTEGER NOT NULL,
	CONSTRAINT id_ruta_fk FOREIGN KEY (id_ruta) REFERENCES RUTA(nombre),
	CONSTRAINT id_estacion_fk FOREIGN KEY (id_estacion) REFERENCES ESTACION(nombre)
);
