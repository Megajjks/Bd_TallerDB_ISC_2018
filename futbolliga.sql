CREATE DATABASE futbolliga;
USE futbolliga;
--Creando las tablas
CREATE TABLE Jugador(Id_jug INT(10) NOT NULL, Nombre VARCHAR(30), Apellido VARCHAR(30), Posicion VARCHAR(30), Fecnac DATE, Id_equi INT(10) NOT NULL) ENGINE=INNODB;
CREATE TABLE Equipo(Id_equi INT(10) NOT NULL, Nombre VARCHAR(30), Fundacion DATE,Colonia VARCHAR(30))ENGINE=INNODB;
CREATE TABLE Partido(Id_part INT(10) NOT NULL, Fec DATE, Goles_casa INT(2),Goles_fuera INT(2),Id_equi INT(10) NOT NULL) ENGINE=INNODB;
CREATE TABLE presidente(Id_pres INT(10) NOT NULL,Nombre VARCHAR(30),Apellido VARCHAR(30),Fecnac DATE, Equipo VARCHAR(30),Anopres DATE,Id_equi INT(10) NOT NULL) ENGINE=INNODB;
--Creación de las llaves primarias 
ALTER TABLE Equipo ADD PRIMARY KEY(Id_equi);
ALTER TABLE Jugador ADD PRIMARY KEY(Id_jug);
ALTER TABLE Partido ADD PRIMARY KEY(Id_part);
ALTER TABLE presidente ADD PRIMARY KEY(Id_pres);
--Creación de las llaves foraneas
ALTER TABLE Jugador ADD FOREIGN KEY(Id_equi) REFERENCES Equipo(Id_equi) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Partido ADD FOREIGN KEY(Id_equi) REFERENCES Equipo(Id_equi) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE presidente ADD FOREIGN KEY(Id_equi) REFERENCES Equipo(Id_equi) ON DELETE CASCADE ON UPDATE CASCADE;
--Modificación de un campo
ALTER TABLE presidente CHANGE Nombre Npres VARCHAR(30);
--Introducción de registros en las tablas
--Equipo
INSERT INTO Equipo VALUES(1,"Cuervos","2001-10-10","Toledo");
INSERT INTO Equipo VALUES(2,"Gatitos","2001-10-10","San miguel");
INSERT INTO Equipo VALUES(3,"Orificios","2001-10-10","allendo");
INSERT INTO Equipo VALUES(4,"Pumas","2001-10-10","Ciudad Universitaria");
INSERT INTO Equipo VALUES(5,"America","2002-04-12","Villa Nueva");
INSERT INTO Equipo VALUES(6,"Yaquibelivers","2002-04-12","Soledad");
INSERT INTO Equipo VALUES(7,"Navajeros","2002-04-12","Barrio Pesado");
INSERT INTO Equipo VALUES(8,"The guardians","2002-04-12","Almendras");
--Jugador
INSERT INTO Jugador VALUES(1,"Alberto","Ramos","Portero","1992-01-23",1);
INSERT INTO Jugador VALUES(2,"Juan","Madero","Delantero","1990-10-12",2);
INSERT INTO Jugador VALUES(3,"Javier","Romiro","Defensa","1993-11-18",3);
INSERT INTO Jugador VALUES(4,"Bartolomeo","Ku","Portero","1992-02-24",4);
INSERT INTO Jugador VALUES(5,"Rafael","Nuñez","Defensa","1992-12-17",5);
INSERT INTO Jugador VALUES(6,"Nolberto","Filey","Delantero","1993-02-22",6);
INSERT INTO Jugador VALUES(7,"Eliezer","Carvajal","Portero","1994-04-21",7);
INSERT INTO Jugador VALUES(8,"Fulanoide","Fapendo","Portero","1992-07-17",5);
--Presidente
INSERT INTO presidente VALUES(1,"Leonardo","Gomez","1988-02-12","Cuervos","2003-03-11",1);
INSERT INTO presidente VALUES(2,"Raquel","Nueva","1989-10-03","Gatitos","2004-02-21",2);
INSERT INTO presidente VALUES(3,"Carlos","Alaman","1989-12-23","Orificios","2001-10-10",3);
INSERT INTO presidente VALUES(4,"Mirian","Carmon","1990-04-22","Pumas","2002-04-12",4);
INSERT INTO presidente VALUES(5,"Uziel","Daymond","1988-12-02","America","2002-04-12",5);
INSERT INTO presidente VALUES(6,"Midoriya","Uzumaki","1987-05-16","Yaquibelivers","2002-04-12",6);
INSERT INTO presidente VALUES(7,"Leandro","Canul","1988-02-01","Navajeros","2002-04-12",7);
INSERT INTO presidente VALUES(8,"Manuel","Bolaños","1989-06-01","The guardians","2002-04-12",8);
--Partido
INSERT INTO Partido VALUES(1,"2018-07-30",3,2,1);
INSERT INTO Partido VALUES(2,"2018-07-30",2,3,2);
INSERT INTO Partido VALUES(3,"2018-07-30",1,0,3);
INSERT INTO Partido VALUES(4,"2018-07-30",0,1,4);
INSERT INTO Partido VALUES(5,"2018-08-01",1,1,5);
INSERT INTO Partido VALUES(6,"2018-08-01",1,1,6);
INSERT INTO Partido VALUES(7,"2018-08-01",2,1,7);
INSERT INTO Partido VALUES(8,"2018-08-01",1,2,8);
--Modificación de 4 registros
UPDATE Jugador SET Posicion="Portero" WHERE Id_jug=2;
UPDATE Jugador SET Posicion="Delantero" WHERE Id_jug=1;
UPDATE Equipo SET Colonia="MiguelAyente" WHERE Id_equi=4;
UPDATE Equipo SET Colonia="Sansalvador" WHERE Id_equi=2;
--Consultas
--1
SELECT Id_jug, Nombre, Apellido, Posicion FROM Jugador WHERE Posicion="Delantero";
--2
SELECT Jugador.Nombre,(YEAR(CURRENT_DATE)-YEAR(Jugador.Fecnac))-(RIGHT(CURRENT_DATE,5)<RIGHT(Jugador.Fecnac,5))AS Edad, Jugador.Posicion,Equipo.Nombre FROM Jugador, Equipo WHERE Jugador.Id_equi=Equipo.Id_equi ORDER BY Jugador.Id_equi; 
--3
SELECT Equipo.Nombre,(YEAR(CURRENT_DATE)-YEAR(Equipo.Fundacion))-(RIGHT(CURRENT_DATE,5)<RIGHT(Equipo.Fundacion,5))AS Años, presidente.Npres FROM Equipo, presidente WHERE Equipo.Id_equi=presidente.Id_equi;
--4
SELECT COUNT(*) AS NumPartido FROM Partido WHERE YEAR(FEC)>=2013;
--5

--6
SELECT Equipo.Nombre, MAX(Partido.Goles_casa) AS equipo_con_mayores_goles_casa from Equipo, Partido WHERE Equipo.Id_equi=Partido.Id_equi;
--7
SELECT Equipo.Nombre, MAX(Partido.Goles_fuera) AS equipo_con_mayores_goles_visita from Equipo, Partido WHERE Equipo.Id_equi=Partido.Id_equi;
--8
SELECT presidente.Npres, MAX((YEAR(CURRENT_DATE)-YEAR(Fecnac))-(RIGHT(CURRENT_DATE,5)<RIGHT(Fecnac,5))) FROM presidente;
--Creación de usuarios
--Administrador
CREATE USER 'Administrador'@'localhost' IDENTIFIED BY '1al8';
GRANT ALL PRIVILEGES ON *.* TO 'Administrador'@'localhost';
FLUSH PRIVILEGES;
--Recepcionista
CREATE USER 'Recepcionista'@'localhost' IDENTIFIED BY '1AL2';
GRANT UPDATE ON * TO 'Recepcionista'@'localhost';
GRANT INSERT ON * TO 'Recepcionista'@'localhost';
FLUSH PRIVILEGES;
--Capturista
CREATE USER 'Capturista'@'localhost' IDENTIFIED BY '1AL4';
GRANT INSERT, UPDATE ON Futbolliga.Equipo TO 'Capturista'@'localhost';
GRANT INSERT, UPDATE ON Futbolliga.presidente TO 'Capturista'@'localhost';
GRANT INSERT, UPDATE ON Futbolliga.Jugador TO 'Capturista'@'localhost';
FLUSH PRIVILEGES;
-Creación de vista
CREATE VIEW View1 AS SELECT Equipo.Nombre,Equipo.Colonia,presidente.Npres,Equipo.Fundacion FROM Equipo, presidente WHERE Equipo.Id_equi=presidente.Id_equi;