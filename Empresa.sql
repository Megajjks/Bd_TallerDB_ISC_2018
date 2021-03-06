CREATE DATABASE empresa;
USE empresa;
--creamos la base de datos  de empleado
CREATE TABLE EMPLEADO(Nombre VARCHAR(30), Apellido VARCHAR(30),Id VARCHAR(10) NOT NULL, FECNAC DATE, Dir VARCHAR(20), Sexo CHAR(1), Salario INT(4), SuperId VARCHAR(10), IdDepto INT(1))d ENGINE=INNODB; --INNODB nos sirve como un mecanismo de transacción segura
CREATE TABLE DEPTO (Nombre VARCHAR(20), Id INT(1) NOT NULL, IdJefe VARCHAR(10),Fec_Dir DATE) ENGINE=INNODB;
CREATE TABLE PROYECTO(Nombre VARCHAR(20), Id INT(1) NOT NULL, Local VARCHAR(20),IdDepto INT(1)) ENGINE=INNODB;
CREATE TABLE LOCAL(Id INT(1) NOT NULL, DEP_LOCA VARCHAR(20)) ENGINE=INNODB;
CREATE TABLE CARGO(IdEmp VARCHAR(10) NOT NULL, NomDepto VARCHAR(20), Sexo VARCHAR(1), FecNac DATE, Relacion VARCHAR(10))ENGINE=INNODB;
CREATE TABLE TRABAJAEN(Horas INT, Id VARCHAR(10), Nombre VARCHAR(20));

--Agregamos las claves primarias en las tablas
	--Agregamos las llaves primarias de las tablas
ALTER TABLE empleado ADD PRIMARY KEY (id);
ALTER TABLE depto ADD PRIMARY KEY (id);

	--Agregamos las llaves primaria y establecemos las relaciones
ALTER TABLE empleado ADD FOREIGN KEY (IdDepto) REFERENCES depto(Id) ON DELETE SET NULL ON UPDATE CASCADE, ADD FOREIGN KEY (SuperId) REFERENCES empleado(Id) ON DELETE SET NULL ON UPDATE CASCADE; --Relación, con actualización en cascada
ALTER TABLE depto ADD FOREIGN KEY (IdJefe) REFERENCES empleado(Id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE local ADD FOREIGN KEY (Id) REFERENCES depto(Id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE proyecto ADD FOREIGN KEY proyecto(IdDepto) REFERENCES depto (Id) ON DELETE SET NULL ON UPDATE CASCADE;

	-- Agrengando datos en la base de datos
INSERT INTO depto(Nombre,Id,Fec_Dir) VALUES ("Sistemas",1,"2001-10-10");
INSERT INTO depto(Nombre,Id,Fec_Dir) VALUES ("Venta",2,"2000-03-10");
INSERT INTO depto VALUES("Contabilidad",3,"3","1999-04-05");
INSERT INTO depto VALUES("Almacen",5,"3","2000-04-02");
INSERT INTO depto VALUES("Bodega",4,"1","2005-07-08");
INSERT INTO depto VALUES("Caja",6,"1","2010-06-08");	
INSERT INTO empleado VALUES("Rolando","Ramirez","1","1980-04-13","Nunkini","M",130,"1",1);
INSERT INTO empleado VALUES("Benedit","Mendez","2","2008-05-05","Calle 19","F",110,"1",2);
INSERT INTO empleado VALUES("Lili","Ruiz","3","2000-12-02","Calle 20","F",100,"1",1);
INSERT INTO empleado VALUES("Kayla","Diaz","4","2000-04-03","Calle 22","F",100,"1",1);
INSERT INTO empleado VALUES("Khaled","Diaz","5","2003-04-03","Calle 15","M",120,"1",1);
INSERT INTO empleado VALUES("Dora","Mendez","6","2008-05-05","Calle 19","F",110,"1",2);
INSERT INTO empleado VALUES("Juan","Perez","7","2008-05-05","Calle 32","M",110,"1",2);
INSERT INTO local VALUES(1,"Calkini");
INSERT INTO local VALUES(2,"Halacho");
INSERT INTO local VALUES(3,"Acapulco");
INSERT INTO local VALUES(4,"Merida");
INSERT INTO local VALUES(5,"Mexico");
INSERT INTO proyecto VALUES("Proyecto 1",1,"Acapulco",1);
INSERT INTO proyecto VALUES("Proyecto 2",2,"Merida",1);
INSERT INTO proyecto VALUES("Proyecto 3",3,"Mexico",2);
INSERT INTO proyecto VALUES("Proyecto 4",4,"Campeche",2);
INSERT INTO trabajaen VALUES("1",1,3.5);
INSERT INTO trabajaen VALUES("3",1,12);
INSERT INTO trabajaen VALUES("4",2,5);
INSERT INTO trabajaen VALUES("5",3,20);
INSERT INTO trabajaen VALUES("6",3,10.5);
INSERT INTO trabajaen VALUES("7",6,10.5);
INSERT INTO cargo VALUES("1","Miguel","M","1980-09-10","Conyugue");
INSERT INTO cargo VALUES("3","Juana","F","1978-10-23","Hija");

	--Actualizamos
UPDATE empleado SET DIR="Calle 10" WHERE Id=1;

	--Borrando datos
DELETE FROM empleado WHERE Id=6;

--Consultas
SELECT Nombre, Fec_dir FROM depto;
SELECT CONCAT(Nombre,' ',Apellido) AS Empleados FROM empleado;
SELECT * FROM empleado WHERE Id=2;
SELECT * FROM empleado WHERE SEXO='M';
SELECT * FROM empleado WHERE SEXO!='M';
--Consulta con dos tablas
SELECT empleado.Id, empleado.nombre, Apellido FROM empleado, depto WHERE empleado.Id=IDJEFE and depto.Nombre='Contabilidad';   
--Conculta eliminando filas duplicadas.
SELECT IDPROY FROM TRABAJAEN;
SELECT DISTINCT Idproy FROM trabajaen;
--Consultas con valores nulos
SELECT Id, Nombre,Apellido,SuperId FROM empleado WHERE Id IS NULL;
SELECT Id,Nombre,Apellido,SuperId FROM empleado WHERE IdDepto IS NOT NULL;
--Test de correspondencia con patrón
SELECT Nombre, Apellido FROM empleado WHERE Nombre LIKE'____'; --QUE TENGA 4 CARACTERES
SELECT Nombre,Apellido FROM empleado WHERE Apellido LIKE 'D%'; --Buscara las palabras que empiencen con D
SELECT Nombre,Apellido FROM empleado WHERE Nombre LIKE '____' AND Apellido LIKE 'D%';
--Consultas con rangos de fechas
SELECT Empleado.Nombre, Apellido,Fec_Dir FROM Empleado, Depto WHERE IdJefe=Empleado.Id AND YEAR(Fec_dir) BETWEEN 2000 AND 2005;
SELECT Empleado.Nombre, Apellido, Fecnac,(YEAR(CURRENT_DATE)-YEAR(Fecnac))-(RIGHT(CURRENT_DATE,5)<RIGHT(Fecnac,5))AS Edad FROM Empleado;
SELECT Depto.Id, Nombre FROM Depto, Local WHERE Depto.Id=Local.Id AND Dep_Loca='Acapulco';
SELECT E.ID, E.NOMBRE, E.APELLIDO, J.ID AS IDJEFE, J.NOMBRE AS JEFE, J.APELLIDO FROM EMPLEADO E, EMPLEADO J WHERE E.SUPERID=J.ID;
--Funciones de columna
SELECT COUNT(Id) FROM Empleado;
SELECT AVG(salario) FROM Empleado;
SELECT SUM(Horas) FROM Empleado, trabajaen WHERE IdEmp=Id AND Nombre='Juan' AND Apellido='Perez';
SELECT MAX(Salario), MIN(Salario) FROM EMPLEADO;
--Ordenamiento
SELECT Apellido,Nombre FROM Empleado ORDER BY Apellido DESC;
SELECT Apellido,Nombre FROM Empleado ORDER BY Apellido ASC;
--Consultas Agrupadas
SELECT IDEMP, NOMBRE,APELLIDO, SUM(HORAS) FROM TRABAJAEN, EMPLEADO WHERE ID=IDEMP GROUP BY IDEMP;
SELECT Nombre, Apellido, COUNT(Idproy) FROM Empleado, Trabajaen WHERE IdEmp=Id GROUP  BY Id HAVING COUNT(IdProy>3);
--Consultas con InnerJoin
SELECT Empleado.Id, Empleado.Nombre, Apellido FROM Empleado INNER JOIN Depto ON Empleado.Id=Depto.IdJefe; --Mezcla dos tablas y solo aparecen las que cumplan la condición
SELECT Empleado.Id, Empleado.Nombre, Apellido FROM Empleado LEFT JOIN Depto ON Empleado.Id=Depto.IdJefe; --lEFT JOIN trae todas las consultas más las que cumplen la condición en la segunda tabla 
SELECT Empleado.Id, Empleado.Nombre, Apellido FROM Empleado RIGHT JOIN Depto ON Empleado.Id=Depto.IdJefe; --Mezcla dos tablas y solo aparecen las que cumplan la condición

--Consultas propuestas
--1
SELECT Nombre as Departamentos FROM depto;
--2
Select Nombre AS Nombre_de_vendedores FROM Empleado WHERE Id=2;
--3
Select Nombre, Salario FROM Empleado WHERE Salario>200;
--4
SELECT Nombre FROM Empleado,Trabajaen WHERE IdProy=2 AND IdEmp=Id;
--5
SELECT Nombre,Salario FROM Empleado WHERE Salario BETWEEN 100 AND 150;
--6
SELECT Nombre,Id,Apellido,Horas FROM Empleado,Trabajaen;
--7
SELECT AVG(Horas) AS Promedio_de_Juan_Perez FROM Trabajaen WHERE IdEmp=7;
--8
SELECT * FROM Empleado WHERE MONTH(FECNAC)='05';
--9
SELECT Nombre, Local FROM Proyecto WHERE  Local='Acapulco';
--10
SELECT Nombre, Local FROM Proyecto WHERE  Local='Merida';
--11
SELECT Nombre, FECNAC FROM Empleado WHERE YEAR(FECNAC) BETWEEN 1990 AND 2000;
--12
SELECT Nombre,Salario FROM Empleado WHERE Salario IN(100,110,120);
--13
SELECT * FROM Empleado WHERE Nombre LIKE'A%';
--14
SELECT * FROM Empleado WHERE Salario>200;
--15
SELECT SUM(Salario) AS Suma_Salario, AVG(Salario) AS Promedio_Salario, MAX(Salario) AS Max_Salario, MIN(Salario) AS Min_Salario FROM Empleado;
--16
SELECT Depto.Nombre, Depto.Nombre FROM Depto, Empleado WHERE IdDepto=3;
--18
SELECT Depto.Nombre, MAX(Empleado.Salario) AS Salario_Max, MIN(Empleado.Salario) AS Salario_Min FROM Empleado,Depto WHERE Empleado.IdDepto = '1'AND Depto.Nombre='Sistemas';
--19
SELECT DISTINCT Salario, COUNT(*) AS Tipos_Salarios FROM Empleado GROUP BY Salario;
--20
--21
--22
--23
--24
SELECT * FROM Empleado WHERE Apellido LIKE'[A-R]*';
--25

--CREACIÓN DE USUARIOS
--Creado usuario root
CREATE USER 'Lety'@'localhost' IDENTIFIED BY 'ITESCAM2018';
GRANT ALL PRIVILEGES ON *.* TO 'Lety'@'localhost';
FLUSH PRIVILEGES;
--Creación de usurio Contador
CREATE USER 'Contador'@'localhost' IDENTIFIED BY 'CONTADOR1';
GRANT SELECT ON Empresa.Empleado TO 'Contador'@'localhost';
GRANT INSERT ON Empresa.Empleado TO 'Contador'@'localhost';
FLUSH PRIVILEGES;
--Creación de usuario JefeProy
CREATE USER 'JefeProy'@'localhost'IDENTIFIED BY 'PROYJEFX';
GRANT SELECT, INSERT, UPDATE ON Empresa.Proyecto TO 'JefeProy'@'localhost';
FLUSH PRIVILEGES;
--Creación de usuario RecHum
CREATE USER 'RecHum'@'localhost' IDENTIFIED BY 'RH1234';
GRANT SELECT ON Empresa.Empleado TO 'RecHum'@'localhost';
GRANT INSERT ON Empresa.Trabajaen TO 'RecHum'@'localhost';
GRANT UPDATE ON Empresa.Proyecto TO 'RecHum'@'localhost';
FLUSH PRIVILEGES;
--Creación de vistas
CREATE VIEW JefeDepto AS SELECT Empleado.Nombre Jefe, Apellido, Depto.Nombre, FEC_DIR FROM EMPLEADO, DEPTO WHERE IDJEFE=EMPLEADO.ID AND YEAR(FEC_DIR) BETWEEN 2000 AND 2005;
ALTER VIEW JEFEDEPTO AS SELECT Empleado.NOMBRE JEFE, Apellido, Depto.Nombre Departamento, FEC_DIR FROM Empleado, Depto WHERE IDjefe=Empleado.Id AND YEAR(FEC_DIR) BETWEEN 1980 AND 2000;
SHOW CREATE VIEW JefeDepto; --Mostrar el script de creación de vista
--1
CREATE VIEW Empleado_Horas AS SELECT Empleado.Id, Empleado.Nombre, Empleado.Apellido, COUNT(Trabajaen.Horas) AS Total_Horas FROM Empleado, Trabajaen GROUP BY Empleado.Id ORDER By Empleado.IdDepto;
 
--2
CREATE VIEW Empleado_Proyecto AS SELECT Empleado.Nombre,Empleado.Apellido,COUNT(*) AS Total_Proyecto FROM Empleado INNER JOIN Proyecto ON Empleado.IdDepto=Proyecto.IdDepto GROUP BY Empleado.Id;

--3

--4
CREATE VIEW Inf_Salarios AS SELECT SUM(Empleado.Salario) AS Total, AVG(Empleado.Salario) AS Promedio, MAX(Empleado.Salario) AS Maximo, MIN(Empleado.Salario) AS Min FROM Empleado;

--5
CREATE VIEW Empleados_2a5h AS SELECT IdEmp, Horas FROM Trabajaen WHERE Trabajaen.Horas BETWEEN 2 AND 5;

--6
CREATE VIEW Empleados_Edad_Ventas AS SELECT Id, Nombre, Apellido, (YEAR(CURRENT_DATE)-YEAR(Fecnac))-(RIGHT(CURRENT_DATE,5)<RIGHT(Fecnac,5))AS Edad FROM Empleado;

--7
CREATE VIEW Empleado_Sumdepto AS SELECT Depto.Nombre, COUNT(*) AS Total_Empleados FROM Depto, Empleado WHERE Empleado.IdDepto=2 AND Depto.Id=2;

--Transacciones
--PASO 1: Ejemplo de concurrencia
--Ventana 1 (root)
BEGIN;
INSERT INTO EMPLEADO VALUES ("TANOS","CROC", 8,"1980-02-08","CALLE 22A", 'M', 110,1,3);
select * from empleado;
--Ventana 2 (user Lety)
select * from empleado;
--Ventana 1 (root)
COMMIT;
--Ventana 2 (user Lety)
select * from empleado;

--PASO 2: Ejemplo de lecturas coherentes
--Ventana 1 (root)
BEGIN;
SELECT MAX(ID) FROM EMPLEADO;
select * from empleado;
--Ventana 2 (user Lety)
BEGIN;
SELECT MAX(ID) FROM EMPLEADO;
--Ventana 1 (root)
INSERT INTO EMPLEADO VALUES ("TONY","VALDEZ", 9,"1985-03-12","CALLE 11", 'M', 120,1,3);
COMMIT;
--Ventana 2 (user Lety)
INSERT INTO EMPLEADO VALUES ("ANTONIO","ROBLES", 9,"1982-11-12","CALLE 12", 'M', 120,1,3);
--Ventana 2 (user Lety)
COMMIT;

--PASO 3: Lectura de bloqueos para actualizaciones
--Ventana 1 (root)
BEGIN;
SELECT MAX(ID) FROM EMPLEADO FOR UPDATE;
INSERT INTO EMPLEADO VALUES ("CAMILA","SUAREZ", 9,"1999-01-12","CALLE 45", 'F', 100,2,3);
--Ventana 2 (user Lety)
BEGIN;
SELECT MAX(ID) FROM EMPLEADO FOR UPDATE;
--Ventana 1 (root)
COMMIT;
--Ventana 2 (user Lety)
INSERT INTO EMPLEADO VALUES ("RENATA","CASTRO", 10,"1979-03-06","CALLE 13",'F', 110,2,3);
COMMIT;

--PASO 4
--Ventana 1 (root)
BEGIN;
INSERT INTO EMPLEADO VALUES ("YUYI","SUAREZ", 11,"1978-01-12","CALLE 45", 'F',100,2,3);
UPDATE EMPLEADO SET NOMBRE = "YULI" WHERE ID =11;
--Ventana 2 (user Lety)
SELECT * FROM EMPLEADO;
SELECT * FROM EMPLEADO LOCK IN SHARE MODE;
--Ventana 1 (root)
COMMIT;

--PASO 5 
--Ventana 1 (root)
SELECT * FROM EMPLEADO;
--Ventana 2 (user Lety)
INSERT INTO EMPLEADO VALUES ("OBREGON","SUAREZ", 13,"1978-01-12","CALLE 45", 'F',100,2,3);
SELECT * FROM EMPLEADO;
--Ventana 1 (root)
SET AUTOCOMMIT=0;
--Ventana 2 (user Lety)
SELECT * FROM EMPLEADO;
--Ventana 1 (root)
INSERT INTO EMPLEADO VALUES ("JEAN","SUAREZ", 16,"1978-01-12","CALLE 45", 'F',100,2,3);
COMMIT;

--Ventana 1 (root)
SET AUTOCOMMIT=0;
--Ventana 2 (user Lety)
SET AUTOCOMMIT=0;
--Ventana 1 (root)
SELECT * FROM EMPLEADO;
--Ventana 2 (user Lety)
INSERT INTO EMPLEADO VALUES ("MANUEL","CAMACH0", 17,"1977-01-01","CALLE 11", 'M', 120,2,3);
COMMIT;
--Ventana 1 (root)
SELECT * FROM EMPLEADO;
--Ventana 1 (root)
COMMIT;
SELECT * FROM EMPLEADO;
--Ventana 1 (root)
SET AUTOCOMMIT=1;
--Ventana 2 (user Lety)
SET AUTOCOMMIT=1;

--Practica 6: Bloqueo de tabla
--Ventana 1 (root)
LOCK TABLE EMPLEADO READ;
--Ventana 2 (user Lety)
SELECT * FROM EMPLEADO;
INSERT INTO EMPLEADO VALUES ("ALONDRA","MINCE", 18,"1979-07-05","CALLE 11",'F', 110,2,3);
--Ventana 1 (root)
UNLOCK TABLES;

--Ventana 1 (root)
LOCK TABLE EMPLEADO READ, DEPTO WRITE;
--Ventana 2 (user Lety)
SELECT * FROM EMPLEADO;
--Ventana 1 (root)
INSERT INTO EMPLEADO VALUES ("ROSA","VERDE", 19,"1979-01-12","CALLE 45", 'F',130,1,3);

--Ventana 1 (root)
SELECT * FROM EMPLEADO;
--Ventana 2 (user Lety)
UNLOCK TABLES;
--Ventana 1 (root)
LOCK TABLE EMPLEADO WRITE;
--Ventana 2 (user Lety)
LOCK TABLE EMPLEADO READ;
--Ventana 3 (user Lety)
LOCK TABLE EMPLEADO READ;
--Ventana 1 (root)
UNLOCK TABLES;

--Ventana 3 (user Lety)
LOCK TABLE EMPLEADO WRITE;
--Ventana 2 (user Lety)
UNLOCK TABLES;

--PASO 7 Transacciones con START TRANSACTION
START TRANSACTION;
SELECT @S:=(salario) FROM EMPLEADO WHERE ID='1';
UPDATE EMPLEADO SET SALARIO=@S WHERE ID='2';
COMMIT;

START TRANSACTION;
SELECT @S:=(salario) FROM EMPLEADO WHERE ID='1';
UPDATE EMPLEADO SET SALARIO=@S+10 WHERE IDDEPTO='1';
COMMIT;

--uso de Funciones predefinidas en MYSQL
--DAYNAME(fecha): devulve dia
SELECT DAYNAME("2018-11-25");
--DAYOFMONTH (fecha): devuelve mes
SELECT DAYOFMONTH("2018-11-25");
--YEAR(fecha)
SELECT YEAR(FECNAC) FROM EMPLEADO WHERE ID= 1;
--MONTH (fecha)
SELECT MONTH (FECNAC) FROM EMPLEADO WHERE ID= 2;
--MONTHNAME (fecha)
SELECT MONTHNAME(FECNAC) FROM EMPLEADO WHERE ID= 5;
--LEFT (cadena, longitud)
SELECT LEFT(NOMBRE,3) FROM EMPLEADO WHERE ID= 5;
--LENGTH (cadena)
SELECT LENGTH(NOMBRE), NOMBRE FROM EMPLEADO WHERE ID= 2;
--LOCATE
SELECT LOCATE ('JU', NOMBRE) FROM EMPLEADO WHERE ID=1;
SELECT LOCATE ('RO', NOMBRE) FROM EMPLEADO WHERE ID=1;
--LOWER (cadena)
SELECT LOWER(NOMBRE) FROM EMPLEADO WHERE ID=1;
--POSITION (subcadena IN cadena)
SELECT POSITION('U' IN NOMBRE) FROM EMPLEADO WHERE ID=7;
--SUBSTRING(cadena, posicion [,longitud])
SELECT SUBSTRING(NOMBRE, 2) FROM EMPLEADO WHERE ID=1;
SELECT SUBSTRING(NOMBRE, 2,2) FROM EMPLEADO WHERE ID=1;
--UPPER
SELECT UPPER(NOMBRE) FROM EMPLEADO WHERE ID=10;
--ABS (numero)
SELECT ABS(-1);
--CEILING (numero)
SELECT CEILING(12.5);
--MOD (numero1, numero2)
SELECT MOD(2,15);
--POWER O POW
SELECT POW(3,4);
--SQRT (numero)
SELECT SQRT(32);
--TRUNCATE (numero, decimales)
SELECT TRUNCATE(23.5555,1);

--Creamos la tabla Bitacora
CREATE TABLE BITACORA(CLAVE INTEGER(11) PRIMARY KEY AUTO_INCREMENT, USUARIO VARCHAR(20), EVENTO VARCHAR(30), ID VARCHAR(10));

--Creación de Triggers
--PASO 1: Disparador que inserta un registro en la tabla “Bitacora” cuando se realiza un nuevo empleado.
CREATE TRIGGER TBit AFTER INSERT ON EMPLEADO FOR EACH ROW
INSERT INTO BITACORA(USUARIO, EVENTO, ID) VALUES (current_user, 'Registro empleado', NEW.ID);
--find del trigger
INSERT INTO EMPLEADO VALUES ("BOOS", "LIGHT", 20,"1980-12-13", "CALLE 44","M",130,1,1);

--PASO 2: Disparador que inserta un registro en la tabla “Bitacora” después de actualizar datos en la tabla empleado.
CREATE TRIGGER ActEmp AFTER UPDATE ON EMPLEADO FOR EACH ROW
INSERT INTO BITACORA (USUARIO, EVENTO, ID) VALUES (current_user, 'Actualiza empleado', new.id);

UPDATE EMPLEADO SET NOMBRE='CLAR', APELLIDO='BELLA', DIR='CALLE 1' WHERE ID=20;

--PASO 3: Disparador que inserta un registro en la tabla “Bitacora” después de dar de baja un empleado.
CREATE TRIGGER BajaEmp AFTER DELETE ON EMPLEADO FOR EACH ROW
INSERT INTO BITACORA (USUARIO, EVENTO, ID) VALUES (current_user, 'Baja empleado',OLD.ID);

DELETE FROM EMPLEADO WHERE ID=20;