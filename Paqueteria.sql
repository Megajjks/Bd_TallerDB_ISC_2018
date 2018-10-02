CREATE DATABASE Paqueteria;
USE Paqueteria;
--creamos la base de datos  de empleado
CREATE TABLE Operador(id INT NOT NULL,nombre VARCHAR(30),apellido VARCHAR(30),telefono VARCHAR(10),direccion VARCHAR(50),salario INT);
CREATE TABLE Ciudad(codigo_ciudad VARCHAR(10) NOT NULL, nombre_ciudad VARCHAR(30));
CREATE TABLE Camion(matricula VARCHAR(20), modelo VARCHAR(30), año INT);
CREATE TABLE Paquete(codigo VARCHAR(10) NOT NULL,destinatario VARCHAR(50),direccion_dept VARCHAR(50),descripcion TEXT);
CREATE TABLE Conduce(Id_conduce INT NOT NULL, Id INT, Matricula VARCHAR(20));	
--Agrando cosas faltantes
ALTER TABLE Paquete ADD(Id INT(11));--campo faltante
ALTER TABLE Paquete ADD(codigo_ciudad VARCHAR(10)); --campo faltante

--Creación de llaves Primarias
ALTER TABLE camion ADD PRIMARY KEY(matricula);
ALTER TABLE ciudad ADD PRIMARY KEY(codigo_ciudad);
ALTER TABLE conduce ADD PRIMARY KEY(Id_conduce);
ALTER TABLE operador ADD PRIMARY KEY(id);
ALTER TABLE paquete ADD PRIMARY KEY(codigo);

--Creación de llaves Foraneas con sus relaciones
ALTER TABLE conduce ADD FOREIGN KEY(id) REFERENCES operador(id) ON DELETE SET NULL ON UPDATE CASCADE, ADD FOREIGN KEY(matricula) REFERENCES camion(matricula) ON DELETE SET NULL ON UPDATE CASCADE;  
ALTER TABLE paquete ADD FOREIGN KEY(id) REFERENCES operador(id) ON DELETE SET NULL ON UPDATE CASCADE, ADD FOREIGN KEY(codigo_ciudad) REFERENCES ciudad(codigo_ciudad) ON DELETE SET NULL ON UPDATE CASCADE;

	-- Agrengando datos en la base de datos
INSERT INTO operador VALUES(1,"Jayro","Salazar","9971398592","Calle 20",1200);
INSERT INTO operador VALUES(2,"Lia","Salazar","9971233456","Calle 10",1200);
INSERT INTO operador VALUES(3,"Natanael","Cauich","9975671243","Calle 23",1000);
INSERT INTO operador VALUES(4,"Naibi","Colli","9978741256","Calle 16",1000);
INSERT INTO operador VALUES(5,"Humberto","Mut","9979831230","Calle 31",1200);
INSERT INTO operador VALUES(6,"Aroel","May","9975132312","Calle 12",1200);
INSERT INTO operador VALUES(7,"Kemuel","Guitierrez","9971091242","Calle 2",1000);
INSERT INTO operador VALUES(8,"Danely","May","9972391222","Calle 29",1200);
INSERT INTO operador VALUES(9,"Marvin","Acosta","997111241","Calle 11",1000);
INSERT INTO operador VALUES(10,"Araciria","Salazar","997123567","Calle 24",1200);
INSERT INTO camion VALUES("1","FORD",2015);
INSERT INTO camion VALUES("2","FORD",2015);
INSERT INTO camion VALUES("3","FORD",2015);
INSERT INTO camion VALUES("4","FORD",2015);
INSERT INTO camion VALUES("5","FORD",2015);
INSERT INTO ciudad VALUES("1","Mérida");
INSERT INTO ciudad VALUES("2","Campeche");
INSERT INTO ciudad VALUES("3","Monterrey");
INSERT INTO ciudad VALUES("4","CDMX");
INSERT INTO ciudad VALUES("5","Tabasco");
INSERT INTO conduce VALUES(1,1,"1");
INSERT INTO conduce VALUES(3,2,"2");
INSERT INTO conduce VALUES(2,3,"3");
INSERT INTO conduce VALUES(4,4,"4");
INSERT INTO conduce VALUES(5,5,"5");
INSERT INTO paquete VALUES("1","des1","calle 20","Paquete urgente",1,"1");
INSERT INTO paquete VALUES("2","des2","calle 12","Paquete urgente",2,"2");
INSERT INTO paquete VALUES("3","des3","calle 23","Paquete urgente",3,"3");
INSERT INTO paquete VALUES("4","des4","calle 15","Paquete urgente",4,"4");
INSERT INTO paquete VALUES("5","des5","calle 23","Paquete urgente",5,"5");
INSERT INTO paquete VALUES("6","des6","calle 17","Paquete urgente",5,"5");

	--Actualizamos
UPDATE paquete SET descripcion="paquete no urgente" WHERE Id=5;

	--Borrando datos
DELETE FROM paquete WHERE codigo="6";

	