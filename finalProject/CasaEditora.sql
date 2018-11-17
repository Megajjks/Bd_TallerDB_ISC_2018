CREATE DATABASE CasaEditorial;
USE CasaEditorial;
--Creamos las tablas de la base de datos
CREATE TABLE editor(id_edit INTEGER(10) NOT NULL, publicaciones VARCHAR(100), perscont INTEGER(10), razonsoc TEXT, direccion VARCHAR(50)) ENGINE=INNODB;
CREATE TABLE publicacion(id_pub INTEGER(10) NOT NULL, precio DOUBLE, nombre VARCHAR(50), suplemento VARCHAR(50),dia_suplem DATE, peridiocidad VARCHAR(50), id_edit INTEGER(10)) ENGINE=INNODB;
CREATE TABLE recibe(id_rec INTEGER(10), id_pub INTEGER(10), dni INTEGER(10), diarecibe DATE, tipopublicacion VARCHAR(50), periodo VARCHAR(50)) ENGINE=INNODB;
CREATE TABLE suscribtor(dni INTEGER(10) NOT NULL, nombre VARCHAR(50), domicilio VARCHAR(50), telefono VARCHAR(14), preferente BOOLEAN, bonificacion DOUBLE) ENGINE=INNODB;
CREATE TABLE entrega(id_entrega INTEGER(10) NOT NULL, id_pub INTEGER(10), dni_repartidor INTEGER(10), id_ruta INTEGER(10)) ENGINE=INNODB;
CREATE TABLE repartidor(dni_repartidor INTEGER(10) NOT NULL, nombre VARCHAR(50), domicilio VARCHAR(50), telefono VARCHAR(50), situacion VARCHAR(50)) ENGINE=INNODB;
CREATE TABLE ruta(id_ruta INTEGER(10) NOT NULL, calleprincipal VARCHAR(20), callesecundario VARCHAR(20), localidad VARCHAR(20), entidad VARCHAR(20), numero VARCHAR(5), dni_repartidor INTEGER(10)) ENGINE=INNODB;
CREATE TABLE incidencia(id_incidencia INTEGER(10) NOT NULL, ambito VARCHAR(50), descripcion TEXT, fecha_producida DATE, solucion TEXT, id_ruta INTEGER(10)) ENGINE=INNODB;
--Asignamos las llaves primarias de las tablas
ALTER TABLE editor ADD PRIMARY KEY (id_edit);
ALTER TABLE publicacion ADD PRIMARY KEY (id_pub);
ALTER TABLE recibe ADD PRIMARY KEY (id_rec);
ALTER TABLE suscribtor ADD PRIMARY KEY (dni);
ALTER TABLE entrega ADD PRIMARY KEY (id_entrega);
ALTER TABLE repartidor ADD PRIMARY KEY (dni_repartidor);
ALTER TABLE ruta ADD PRIMARY KEY (id_ruta);
ALTER TABLE incidencia ADD PRIMARY KEY (id_incidencia);
--Asignacion de las cardinalidades en la BD
ALTER TABLE publicacion ADD FOREIGN KEY (id_edit) REFERENCES editor(id_edit) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE recibe ADD FOREIGN KEY (id_pub) REFERENCES publicacion(id_pub) ON DELETE CASCADE ON UPDATE CASCADE, ADD FOREIGN KEY (dni) REFERENCES suscribtor(dni) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE entrega ADD FOREIGN KEY (id_pub) REFERENCES publicacion(id_pub) ON DELETE CASCADE ON UPDATE CASCADE, ADD FOREIGN KEY (dni_repartidor) REFERENCES repartidor(dni_repartidor) ON DELETE CASCADE ON UPDATE CASCADE, ADD FOREIGN KEY (id_ruta) REFERENCES ruta(id_ruta) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE ruta ADD FOREIGN KEY (dni_repartidor) REFERENCES repartidor(dni_repartidor) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE incidencia ADD FOREIGN KEY (id_ruta) REFERENCES ruta(id_ruta) ON DELETE CASCADE ON UPDATE CASCADE;