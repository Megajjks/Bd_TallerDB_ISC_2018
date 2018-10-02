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

