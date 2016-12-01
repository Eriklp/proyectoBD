
--Universidad del Valle
--Escuela de Ingenieria de Sistemas
--Bases de Datos
--Camilo José Cruz Rivera--1428907
--Erik Lopez Pachco--1430406
--Robert leandro quiceno --1422913
--Juan Carlos Viteri --1427543
------------------------------------------------------------------------------------------------------------------------------------------
DROP TABLE if exists RUTA CASCADE;
CREATE TABLE  RUTA 
   (	nombre VARCHAR(30) NOT NULL PRIMARY KEY,
	descripcion VARCHAR(100)
   );

------------------------------------------------------------------------------------------------------------------------------------------

DROP TABLE if exists BUS CASCADE;
CREATE TABLE  BUS 
   (	placa INTEGER NOT NULL,
	tipo INTEGER,
	nombre_ruta VARCHAR(30),
	CONSTRAINT BUS_PK PRIMARY KEY (placa),
	CONSTRAINT bus_ruta_fk FOREIGN KEY (nombre_ruta) REFERENCES RUTA (nombre)
   );

------------------------------------------------------------------------------------------------------------------------------------------
DROP TABLE if exists TARJETA CASCADE;
CREATE TABLE  TARJETA 
   (	tarjeta_id INTEGER NOT NULL,
	saldo INTEGER,
	estado BOOLEAN,
	CONSTRAINT TARJETA_PK PRIMARY KEY (tarjeta_id)
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

DROP TABLE if exists EMPLEADO CASCADE;
CREATE TABLE  EMPLEADO 
   (	empleado_id INTEGER NOT NULL,
	cedula INTEGER NOT NULL,
	nombre VARCHAR(15),
	apellido VARCHAR(15),
	telefono INTEGER,
	CONSTRAINT EMPLEADO_PK PRIMARY KEY (empleado_id)
   );

------------------------------------------------------------------------------------------------------------------------------------------
DROP TABLE if exists DIRECTOR_ESTACION CASCADE;
CREATE TABLE  DIRECTOR_ESTACION 
   (	id-empleado-dir INTEGER NOT NULL,
	CONSTRAINT DIRECTOR_ESTACION_PK PRIMARY KEY (id-empleado-dir),
        CONSTRAINT id-empleado-dir_fk FOREIGN KEY (id-empleado-dir) REFERENCES EMPLEADO (empleado_id)
   );
-----------------------------------------------------------------------------------------------------------------------------

DROP TABLE if exists AUX_SERVICIO CASCADE;
CREATE TABLE  AUX_SERVICIO 
   (	id-empleado-aux INTEGER NOT NULL,
	CONSTRAINT DIRECTOR_ESTACION_PK PRIMARY KEY (id-empleado-aux),
        CONSTRAINT id-empleado-aux_fk FOREIGN KEY (id-empleado-aux) REFERENCES EMPLEADO (empleado_id)
   );
-----------------------------------------------------------------------------------------------------------------------------
DROP TABLE if exists CONDUCTOR CASCADE;
CREATE TABLE  CONDUCTOR 
   (	id-empleado-conductor INTEGER NOT NULL,
	CONSTRAINT DIRECTOR_ESTACION_PK PRIMARY KEY (id-empleado-conductor),
        CONSTRAINT id-empleado-conductor_fk FOREIGN KEY (id-empleado-conductor) REFERENCES EMPLEADO (empleado_id)
   );
-----------------------------------------------------------------------------------------------------------------------------
DROP TABLE if exists ESTACION CASCADE;
CREATE TABLE  ESTACION 
   (	nombre_estacion VARCHAR(30) NOT NULL,
	director_id INTEGER,
	CONSTRAINT ESTACION_PK PRIMARY KEY (nombre_estacion),
	CONSTRAINT director_id_fk FOREIGN KEY (director_id) REFERENCES DIRECTOR_ESTACION (id-empleado-dir)          
   );

------------------------------------------------------------------------------------------------------------------------------------------

DROP TABLE if exists RUTA_ESTACION CASCADE;
CREATE TABLE  RUTA_ESTACION 
   (	id_ruta VARCHAR(30) NOT NULL,
    	id_estacion VARCHAR(30) NOT NULL,
	CONSTRAINT RUTA_ESTACION_PK PRIMARY KEY (id-ruta,id-estacion),
        CONSTRAINT id_ruta_fk FOREIGN KEY (id-ruta) REFERENCES RUTA (nombre),
        CONSTRAINT id_estacion_fk FOREIGN KEY (id_estacion_fk) REFERENCES ESTACION (nombre_estacion)  
   );

------------------------------------------------------------------------------------------------------------------------------------------

DROP TABLE if exists MANEJO_BUSES CASCADE;
CREATE TABLE  MANEJO_BUSES
   (	conductor_id INTEGER NOT NULL,
	placa_bus INTEGER NOT NULL,
	turno TIME NOT NULL,
	CONSTRAINT MANEJO_BUS_PK PRIMARY KEY (conductor_id, placa_bus),
        CONSTRAINT conductor_id_fk FOREIGN KEY (conductor_id) REFERENCES CONDUCTOR (id-empleado-conductor),
        CONSTRAINT placa_bus_fk FOREIGN KEY (placa_bus) REFERENCES BUS (placa)  
   );

------------------------------------------------------------------------------------------------------------------------------------------

DROP TABLE if exists VENTA_TARJETAS CASCADE;
CREATE TABLE  VENTA_TARJETAS 
   (	auxiliar_id INTEGER NOT NULL,
	nombre_estacion VARCHAR(30) NOT NULL,
	tarjeta_id INTEGER NOT NULL,
	CONSTRAINT VENTA_TARJETA_PK PRIMARY KEY (auxiliar_id, nombre_estacion),
        CONSTRAINT auxiliar_id_fk FOREIGN KEY (auxiliar_id) REFERENCES AUX_SERVICIO (id-empleado-aux),
	CONSTRAINT nombre_est_fk FOREIGN KEY (nombre_estacion) REFERENCES ESTACION (nombre_estacion),
        CONSTRAINT tarjeta_id_fk FOREIGN KEY (tarjeta_id) REFERENCES TARJETA (tarjeta_id)  
   );

------------------------------------------------------------------------------------------------------------------------------------------

DROP TABLE if exists T_PERSONALIZADA CASCADE;
CREATE TABLE  T_PERSONALIZADA 
   (	tarjeta_id INTEGER NOT NULL,
	avances_disponibles INTEGER,
	CONSTRAINT T_PERSONALIZADA_PK PRIMARY KEY (tarjeta_id),
   );

------------------------------------------------------------------------------------------------------------------------------------------

DROP TABLE if exists CLIENTE CASCADE;
CREATE TABLE  CLIENTE 
   (	cedula INTEGER NOT NULL,
	nombres VARCHAR (20),
	telefono INTEGER,
	tarjeta_id INTEGER, 
	CONSTRAINT CLIENTE_PK PRIMARY KEY (cedula),
        CONSTRAINT tarjeta_id_fk FOREIGN KEY (tarjeta_id) REFERENCES T_PERSONALIZADA (tarjeta_id)  
   );

------------------------------------------------------------------------------------------------------------------------------------------


DROP TABLE if exists T_GENERICA CASCADE;
CREATE TABLE  T_GENERICA 
   (	id_tarjeta INTEGER NOT NULL,
	CONSTRAINT T_GENERICA_PK PRIMARY KEY (id_tarjeta)    
   );

------------------------------------------------------------------------------------------------------------------------------------------

DROP TABLE if exists RECLAMOS CASCADE;
CREATE TABLE  RECLAMOS 
   (	num_tiquete INTEGER NOT NULL,
	fecha DATE,
	motivo VARCHAR,
	descripcion VARCHAR,
	CONSTRAINT RECLAMO_PK PRIMARY KEY (num_tiquete)
   );

------------------------------------------------------------------------------------------------------------------------------------------

DROP TABLE if exists MEDIDAS CASCADE;
CREATE TABLE  MEDIDAS 
   (	num_tiquete INTEGER NOT NULL,
	medida VARCHAR,
	CONSTRAINT MEDIDAS_PK PRIMARY KEY (num_tiquete),
        CONSTRAINT num_tiquete_fk FOREIGN KEY (num_tiquete) REFERENCES RECLAMOS (num_tiquete)  
   );

------------------------------------------------------------------------------------------------------------------------------------------

DROP TABLE if exists RECLAMOS_REALIZADOS CASCADE;
CREATE TABLE  RECLAMOS_REALIZADOS 
   (	num_tiquete INTEGER NOT NULL,
	auxiliar_id INTEGER NOT NULL,
	tarjeta_id INTEGER NOT NULL,
	CONSTRAINT RECLAMOS_REALIZADOS_PK PRIMARY KEY (num_tiquete, auxiliar_id, tarjeta_id),
	CONSTRAINT num_tiquete_fk FOREIGN KEY (num_tiquete) REFERENCES RECLAMO (num_tiquete),
        CONSTRAINT auxiliar_id_fk FOREIGN KEY (auxiliar_id) REFERENCES AUX_SERVICIO (id-empleado-aux),
	CONSTRAINT tarjeta_id_fk FOREIGN KEY (tarjeta_id) REFERENCES TARJETA (tarjeta_id)
   );


