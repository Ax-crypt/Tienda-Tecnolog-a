-- SCRIPT  DE  IMPLANTACION  DE  BD. MS SQL SERVER  
-- CREACION DE BASE DE DATOS  (DATA y LOG)
USE master
GO

IF db_id('BDVENTAS2022eco') is not null
begin
	ALTER DATABASE BDVENTAS2022eco
	SET SINGLE_USER WITH ROLLBACK IMMEDIATE

	DROP DATABASE BDVENTAS2022eco
end
go

CREATE DATABASE BDVENTAS2022eco
COLLATE Modern_Spanish_CI_AI
GO

SET LANGUAGE SPANISH
SET NOCOUNT ON
GO

USE BDVENTAS2022eco
GO
-- Creacion de las Tablas
CREATE TABLE Articulos (
	cod_art char (5) NOT NULL Primary key,
	nom_art varchar (50) NULL ,
	uni_med varchar (10) NULL ,
	pre_art decimal(7,2) NULL ,
	stk_art int NULL )
GO

CREATE TABLE Distritos (
	cod_dist int primary key,
	nom_dist varchar(35) not null
)
GO

CREATE TABLE Clientes (
	cod_cli char (5) NOT NULL Primary Key check(cod_cli like 'C[0-9][0-9][0-9][0-9]'),
	nom_cli varchar(50) NOT NULL Unique,
	tel_cli varchar(10) default('Sin telefono'),
	cor_cli varchar(50) default('Sin correo electronico') , --correo electronico
	dir_cli varchar (50) default('Sin direccion'),
    cred_cli int default(1000),
	fec_nac date default('10/03/2000'),
	cod_dist int references Distritos)
GO

-- tambien se puede alterar la tabla cuando se ha creado
--Alter Table Clientes
--add
--CONSTRAINT CK_Cliente_Telefono CHECK (Cli_tel like '[2345][0-9][0-9]-[0-9][0-9][0-9][0-9]')
--go

CREATE TABLE Ventas_Cab (
	num_vta char (5) NOT NULL Primary Key,
	fec_vta date NULL ,
	cod_cli char (5) NULL ,
    cod_ven int  )
GO

CREATE TABLE Ventas_Deta (
	num_vta char (5) NOT NULL ,
	cod_art char (5) NOT NULL  ,
	cantidad  int NULL , 
        Primary Key(num_vta,cod_art))
GO

CREATE TABLE Vendedor(
	cod_ven int identity(1,1) not null primary key,
	nom_ven varchar (50) NULL ,
	fecing_ven date NULL --fecha de ingreso 
)
GO

-- Ingreso de Data a las Tablas
set dateformat dmy
set language spanish
go
 
INSERT INTO Distritos VALUES (1, 'Lima'),
	(2, 'Los Olivos'),(3, 'Magdalena'),(4, 'Pueblo Libre'),
	(5, 'Rimac'),(6, 'San Martin de Porres'),(7, 'Jesus Maria'),
	(8, 'Lince'),(9, 'Miraflores'),(10, 'Surco')
GO

INSERT INTO clientes VALUES ('C0001','Alvarez Peña, Angel','981234567','importa@hotmail.com','Av. La Marina 1234',3500,default,1)
INSERT INTO clientes VALUES ('C0002','Ponte Gomez, Alejandro','6584503','alex@yahoo.com','Av. Pardo 456  ',2800,'15/10/1999',2)
INSERT INTO clientes VALUES ('C0003','Zuñiga Mateo, Carlos','5674566',default,'Av. Principal 123 ',1200,'21/03/1998',3)
INSERT INTO clientes VALUES ('C0004','Tucto de Souza, Bernardo','5634166',default,'Av. Principal 123 ',1200,'5/12/1998',4)
INSERT INTO clientes VALUES ('C0005','Vilela Bustamante, Percy','4568596' ,'obando@hotmail.com','Calle San Pedro 134',1600,'15/10/1999',5)
INSERT INTO clientes VALUES ('C0006','Garcia Robles, Armando','5894126','importa06@hotmail.com','Jr. Naranjos 5689',3100,'12/01/1999',6)
INSERT INTO clientes VALUES ('C0007','Montes Diaz, Miguel','5678356','importa06@hotmail.com','Jr. Naranjos 5689',3100,'15/07/1998',7)
INSERT INTO clientes VALUES ('C0008','Rojas Gallo, Jorge','7894568','importa22@yahoo.com','Av. Habich 543',2700,'22/03/1999',8)
INSERT INTO clientes VALUES ('C0009','Garcia La Riva, Yuliana','7894073','conde@idat.com','Av. Iquitos 228',3400,'8/10/1997',9)
INSERT INTO clientes VALUES ('C0010','Malpartida Romero, Susana','7596258','importa10@hotmail.com','Jr. Naranjos 5689',3100,default,10)
INSERT INTO clientes VALUES ('C0011','Wong Atoccsa, Israel','7685704',default,'Calle Cueva 432',2000,'15/10/1999',1)
INSERT INTO clientes VALUES ('C0012','Liñan Arias, Fernando','98564125','redondo@hotmail.com','Av. Javier Prado 114',1600,default,2)
INSERT INTO clientes VALUES ('C0013','Vergara Hidalgo, Jose','5678466','importa03@hotmail.com','Jr. Pio XII 112',2500,'15/10/1999',3)
INSERT INTO clientes VALUES ('C0014','Bustamante Moptta, Diego','5674566',default,'Av. Principal 123',1200,'15/10/1999',4)
INSERT INTO clientes VALUES ('C0015','Alvarado Cueva, Rosa','4563457','campos@yahoo.com','Jr. Dominicos 554',5000,'15/10/1999',6)
INSERT INTO clientes VALUES ('C0016','Antero Flores, Gregorio','7460647','ramirez@idat.com','Jr. Salavery 876',2100,'15/10/1999',5)
INSERT INTO clientes VALUES ('C0017','Diaz Mal Partida, Jose','5674566',default,'Av. Guardia Civil 123 ',1200,'15/10/1999',9)
INSERT INTO clientes VALUES ('C0018','Gutierrez Pazos, Mauricio','988425783','importa04@hotmail.com','Av. Habich 4567',1800,default,7)
INSERT INTO clientes VALUES ('C0019','Mendoza Ramirez, Esther','989583569','importa05@yahoo.com','Av. Wilson 678',2600,default,8)
INSERT INTO clientes VALUES ('C0020','Salazar Santiago, Marlon','6546534','pardo@walla.com','Av. Pardo 567',4100,'15/10/1999',10)
INSERT INTO clientes VALUES ('C0021','Carrasco Lee, Laura','2678958','importa05@hotmail.com','Av. Wilson 1267',2700,default,3)

INSERT INTO clientes VALUES ('C0022','Rosas La Riva, Daniela','789-4073','rosasdaniela@idat.com','Av. Iquitos 228',1400,'15/10/1999',1)
INSERT INTO clientes VALUES ('C0023','Caceres Atoccsa, Ismael','768-5704',default,'Calle Cueva 432',2000,'30/01/1998',2)
INSERT INTO clientes VALUES ('C0024','Sanchez Briceño, Fermin','963527105','redondo@hotmail.com','Av. Javier Prado 114',1600,'28/10/1995',6)
INSERT INTO clientes VALUES ('C0025','Mego Mendoza, Jose','5678466','noimporta03@hotmail.com','Jr. Pio XII 112',3000,'13/06/1996',4)
INSERT INTO clientes VALUES ('C0026','Bustamante Porta, Diego','5674566',default,'Av. Principal 123 ',2200,'11/09/1997',5)
INSERT INTO clientes VALUES ('C0027','Meza Cuadra, Mariana','4563457','campos@yahoo.com','Jr. Dominico 897',2000,'15/12/1997',7)
INSERT INTO clientes VALUES ('C0028','Portila Flores, Gregorio','7460647','ramirez@idat.com','Jr. Salavery 876',2100,'07/04/1999',9)
INSERT INTO clientes VALUES ('C0029','Quiroz Salvador,Jose','5674566',default,'Av. Guardia Civil 123 ',1200,'26/08/1997',8)
INSERT INTO clientes VALUES ('C0030','Sotelo Mateo , Mauricio','8975783','importa04@hotmail.com','Av. Habich 4567',1800,'15/02/2000',10)
INSERT INTO clientes VALUES ('C0031','Mendez landeo, Ester','9583569','importa05@yahoo.com','Av. Wilson 800',2600,'24/07/1999',2)
INSERT INTO clientes VALUES ('C0032','Inafuku Salazar, Milo','6546534','pardo@walla.com','Av. Pardo 567',4100,'29/06/1998',4)
INSERT INTO clientes VALUES ('C0033','Chuquizita Leonardo, Laura','2678958','importa05@hotmail.com','Av. Wilson 1267',2700,'13/07/1998',6)


INSERT INTO articulos VALUES ('A0001','MOUSE GENIOUS','UNIDAD', 25,235)
INSERT INTO articulos VALUES ('A0002','PENTIUM III 600','UNIDAD',150,220)
INSERT INTO articulos VALUES ('A0003','PENTIUM IV 2.5 GB','UNIDAD',150,220)
INSERT INTO articulos VALUES ('A0004','FUNDAS NAYLON','METROS', 40, 35)
INSERT INTO articulos VALUES ('A0005','MEMORIA ZIP 32','PAQUETE', 60, 80)
INSERT INTO articulos VALUES ('A0006','TINTA BJC21 B/N','CAJA', 20, 20)
INSERT INTO articulos VALUES ('A0007','IMPRESORA EPSON 1234','PAQUETE',355,120)
INSERT INTO articulos VALUES ('A0008','MONITOR SYNMASTER 3N','UNIDAD',300, 33)
INSERT INTO articulos VALUES ('A0009','MONITOR VIEWSONIC 17','UNIDAD',450, 92)
INSERT INTO articulos VALUES ('A0010','PENTIUM MMX 260','UNIDAD',120, 97)
INSERT INTO articulos VALUES ('A0011','MOUSE MICROSOFT','UNIDAD', 50,320)
INSERT INTO articulos VALUES ('A0012','MEMORIA 2 GB','PAQUETE', 60, 25)
INSERT INTO articulos VALUES ('A0013','MEMORIA 4 GB','PAQUETE', 92, 25)
INSERT INTO articulos VALUES ('A0014','IMPRESORA CANON 1000','UNIDAD',205,200)
INSERT INTO articulos VALUES ('A0015','IMPRESORA Samsung Laser','UNIDAD',1805,200)
INSERT INTO articulos VALUES ('A0016','TINTA BJC21 COLOR','CAJA', 20,120)
INSERT INTO articulos VALUES ('A0017','TINTA B/n  484','CAJA', 20,120)
INSERT INTO articulos VALUES ('A0018','TINTA Color 624','CAJA', 20,120)
INSERT INTO articulos VALUES ('A0019','TECLADO EPSON 102','UNIDAD', 75,122)
INSERT INTO articulos VALUES ('A0020','MOUSE TECH','UNIDAD', 30,190)
INSERT INTO articulos VALUES ('A0021','USB KINGSTON 2GB','UNIDAD',60, 97)
INSERT INTO articulos VALUES ('A0022','USB KINGSTON 4GB','UNIDAD',90, 20)
INSERT INTO articulos VALUES ('A0023','USB KINGSTON 8GB','UNIDAD',120, 25)
INSERT INTO articulos VALUES ('A0024','AMPLIFICADOR TRINITON','UNIDAD',100,20)
INSERT INTO articulos VALUES ('A0025','PARLANTES DE 50 watss','UNIDAD', 70,12)
INSERT INTO articulos VALUES ('A0026','TECLADO EPSON 102','UNIDAD', 75,122)
INSERT INTO articulos VALUES ('A0027','MOUSE TECH INALAMBRICO','UNIDAD', 80,190)
GO


INSERT INTO Ventas_Cab VALUES ('V0001','02/03/2020','C0007',1)
INSERT INTO Ventas_Cab VALUES ('V0002','02/03/2020','C0005',2)
INSERT INTO Ventas_Cab VALUES ('V0003','02/03/2020','C0016',2)
INSERT INTO Ventas_Cab VALUES ('V0004','08/05/2020','C0002',1)
INSERT INTO Ventas_Cab VALUES ('V0005','08/05/2020','C0005',3)
INSERT INTO Ventas_Cab VALUES ('V0006','08/05/2020','C0004',4)
INSERT INTO Ventas_Cab VALUES ('V0007','10/07/2020','C0016',5)
INSERT INTO Ventas_Cab VALUES ('V0008','10/07/2020','C0005',5)
INSERT INTO Ventas_Cab VALUES ('V0009','12/08/2020','C0020',6)
INSERT INTO Ventas_Cab VALUES ('V0010','01/08/2020','C0005',7)
INSERT INTO Ventas_Cab VALUES ('V0011','01/09/2020','C0012',10)
INSERT INTO Ventas_Cab VALUES ('V0012','01/09/2020','C0012',7)
INSERT INTO Ventas_Cab VALUES ('V0013','02/10/2020','C0002',6)
INSERT INTO Ventas_Cab VALUES ('V0014','02/10/2020','C0011',1)
INSERT INTO Ventas_Cab VALUES ('V0015','02/10/2020','C0018',2)
INSERT INTO Ventas_Cab VALUES ('V0016','03/12/2020','C0012',1)
INSERT INTO Ventas_Cab VALUES ('V0017','03/12/2020','C0001',3)

INSERT INTO Ventas_Cab VALUES ('V0018','03/01/2021','C0002',3)
INSERT INTO Ventas_Cab VALUES ('V0019','03/01/2021','C0001',4)
INSERT INTO Ventas_Cab VALUES ('V0020','15/01/2021','C0002',5)
INSERT INTO Ventas_Cab VALUES ('V0021','27/01/2021','C0003',6)
INSERT INTO Ventas_Cab VALUES ('V0022','12/02/2021','C0004',7)
INSERT INTO Ventas_Cab VALUES ('V0023','20/02/2021','C0005',9)
INSERT INTO Ventas_Cab VALUES ('V0024','28/02/2021','C0004',9)
INSERT INTO Ventas_Cab VALUES ('V0025','03/03/2021','C0005',1)
INSERT INTO Ventas_Cab VALUES ('V0026','25/03/2021','C0004',4)
INSERT INTO Ventas_Cab VALUES ('V0027','09/04/2021','C0005',1)
INSERT INTO Ventas_Cab VALUES ('V0028','10/05/2021','C0004',10)
INSERT INTO Ventas_Cab VALUES ('V0029','25/05/2021','C0005',4)
INSERT INTO Ventas_Cab VALUES ('V0030','15/06/2021','C0006',3)
INSERT INTO Ventas_Cab VALUES ('V0031','05/07/2021','C0004',4)
INSERT INTO Ventas_Cab VALUES ('V0032','20/07/2021','C0007',8)
INSERT INTO Ventas_Cab VALUES ('V0033','05/08/2021','C0008',7)
INSERT INTO Ventas_Cab VALUES ('V0034','25/08/2021','C0008',6)
INSERT INTO Ventas_Cab VALUES ('V0035','30/09/2021','C0004',7)
INSERT INTO Ventas_Cab VALUES ('V0036','05/10/2021','C0009',4)
INSERT INTO Ventas_Cab VALUES ('V0037','24/10/2021','C0010',1)
INSERT INTO Ventas_Cab VALUES ('V0038','22/12/2021','C0010',1)

INSERT INTO Ventas_Cab VALUES ('V0039','05/01/2022','C0015',9)
INSERT INTO Ventas_Cab VALUES ('V0040','08/01/2022','C0014',1)
INSERT INTO Ventas_Cab VALUES ('V0041','10/01/2022','C0005',3)
INSERT INTO Ventas_Cab VALUES ('V0042','18/01/2022','C0011',6)
INSERT INTO Ventas_Cab VALUES ('V0043','23/01/2022','C0014',1)
INSERT INTO Ventas_Cab VALUES ('V0044','25/01/2022','C0012',2)
INSERT INTO Ventas_Cab VALUES ('V0045','30/01/2022','C0007',4)
INSERT INTO Ventas_Cab VALUES ('V0046','04/02/2022','C0008',4)
INSERT INTO Ventas_Cab VALUES ('V0047','08/02/2022','C0009',3)
INSERT INTO Ventas_Cab VALUES ('V0048','11/02/2022','C0011',7)
INSERT INTO Ventas_Cab VALUES ('V0049','14/02/2022','C0019',8)
INSERT INTO Ventas_Cab VALUES ('V0050','18/02/2022','C0004',2)


-- NUEVOS
INSERT INTO Ventas_Cab VALUES ('V0051','20/02/2022','C0002',7)
INSERT INTO Ventas_Cab VALUES ('V0052','25/02/2022','C0013',10)
INSERT INTO Ventas_Cab VALUES ('V0053','01/03/2022','C0014',7)
INSERT INTO Ventas_Cab VALUES ('V0054','08/03/2022','C0005',6)
INSERT INTO Ventas_Cab VALUES ('V0055','12/03/2022','C0016',1)
INSERT INTO Ventas_Cab VALUES ('V0056','23/03/2022','C0017',2)
INSERT INTO Ventas_Cab VALUES ('V0057','29/03/2022','C0018',1)
INSERT INTO Ventas_Cab VALUES ('V0058','03/04/2022','C0009',3)
INSERT INTO Ventas_Cab VALUES ('V0059','13/04/2022','C0010',3)
INSERT INTO Ventas_Cab VALUES ('V0060','15/04/2022','C0001',4)
INSERT INTO Ventas_Cab VALUES ('V0061','25/04/2022','C0002',5)
INSERT INTO Ventas_Cab VALUES ('V0062','27/04/2022','C0003',6)
INSERT INTO Ventas_Cab VALUES ('V0063','30/04/2022','C0004',7)
INSERT INTO Ventas_Cab VALUES ('V0064','10/05/2022','C0005',9)
INSERT INTO Ventas_Cab VALUES ('V0065','14/05/2022','C0006',9)
INSERT INTO Ventas_Cab VALUES ('V0066','25/05/2022','C0007',1)
INSERT INTO Ventas_Cab VALUES ('V0067','30/05/2022','C0008',4)

INSERT INTO Ventas_Cab VALUES ('V0068','05/06/2022','C0009',1)
INSERT INTO Ventas_Cab VALUES ('V0069','10/06/2022','C0010',10)
INSERT INTO Ventas_Cab VALUES ('V0070','25/06/2022','C0020',4)
INSERT INTO Ventas_Cab VALUES ('V0071','04/07/2022','C0018',3)
INSERT INTO Ventas_Cab VALUES ('V0072','15/07/2022','C0016',4)
INSERT INTO Ventas_Cab VALUES ('V0073','20/07/2022','C0014',8)
INSERT INTO Ventas_Cab VALUES ('V0074','25/07/2022','C0012',7)
INSERT INTO Ventas_Cab VALUES ('V0075','30/07/2022','C0010',6)
INSERT INTO Ventas_Cab VALUES ('V0076','06/08/2022','C0019',7)
INSERT INTO Ventas_Cab VALUES ('V0077','12/08/2022','C0017',4)
INSERT INTO Ventas_Cab VALUES ('V0078','18/08/2022','C0015',1)
INSERT INTO Ventas_Cab VALUES ('V0079','24/08/2022','C0013',2)
INSERT INTO Ventas_Cab VALUES ('V0080','30/08/2022','C0011',9)
GO

--------------------------------------------

INSERT INTO Ventas_Deta VALUES ('V0001','A0007',3)
INSERT INTO Ventas_Deta VALUES ('V0001','A0001', 2)
INSERT INTO Ventas_Deta VALUES ('V0002','A0002',16)
INSERT INTO Ventas_Deta VALUES ('V0002','A0004', 4)
INSERT INTO Ventas_Deta VALUES ('V0002','A0005', 6)
INSERT INTO Ventas_Deta VALUES ('V0003','A0004', 5)
INSERT INTO Ventas_Deta VALUES ('V0004','A0007',3)
INSERT INTO Ventas_Deta VALUES ('V0004','A0002',2)
INSERT INTO Ventas_Deta VALUES ('V0005','A0006', 12)
INSERT INTO Ventas_Deta VALUES ('V0005','A0010',11)
INSERT INTO Ventas_Deta VALUES ('V0005','A0011', 4)
INSERT INTO Ventas_Deta VALUES ('V0005','A0014',11)
INSERT INTO Ventas_Deta VALUES ('V0006','A0007',13)
INSERT INTO Ventas_Deta VALUES ('V0007','A0020', 23)
INSERT INTO Ventas_Deta VALUES ('V0008','A0020', 2)
INSERT INTO Ventas_Deta VALUES ('V0009','A0001', 2)
INSERT INTO Ventas_Deta VALUES ('V0010','A0006', 8)
INSERT INTO Ventas_Deta VALUES ('V0010','A0005', 7)
INSERT INTO Ventas_Deta VALUES ('V0010','A0011', 5)
INSERT INTO Ventas_Deta VALUES ('V0011','A0005', 6)
INSERT INTO Ventas_Deta VALUES ('V0011','A0004', 4)
INSERT INTO Ventas_Deta VALUES ('V0011','A0010',13)
INSERT INTO Ventas_Deta VALUES ('V0012','A0002',14)
INSERT INTO Ventas_Deta VALUES ('V0013','A0014',21)
INSERT INTO Ventas_Deta VALUES ('V0014','A0014',2)
INSERT INTO Ventas_Deta VALUES ('V0015','A0007',3)
INSERT INTO Ventas_Deta VALUES ('V0016','A0014',2)
INSERT INTO Ventas_Deta VALUES ('V0016','A0006', 5)
INSERT INTO Ventas_Deta VALUES ('V0017','A0006', 7)
INSERT INTO Ventas_Deta VALUES ('V0017','A0011', 5)
INSERT INTO Ventas_Deta VALUES ('V0018','A0012', 4)
INSERT INTO Ventas_Deta VALUES ('V0018','A0002', 1)
INSERT INTO Ventas_Deta VALUES ('V0018','A0004', 4)
INSERT INTO Ventas_Deta VALUES ('V0018','A0005', 11)
INSERT INTO Ventas_Deta VALUES ('V0019','A0008', 13)
INSERT INTO Ventas_Deta VALUES ('V0019','A0007', 6)
INSERT INTO Ventas_Deta VALUES ('V0019','A0006', 7)
INSERT INTO Ventas_Deta VALUES ('V0020','A0007', 6)
INSERT INTO Ventas_Deta VALUES ('V0020','A0009', 15)
INSERT INTO Ventas_Deta VALUES ('V0021','A0009', 11)
INSERT INTO Ventas_Deta VALUES ('V0021','A0004', 2)
INSERT INTO Ventas_Deta VALUES ('V0021','A0007', 3)
INSERT INTO Ventas_Deta VALUES ('V0022','A0001', 4)
INSERT INTO Ventas_Deta VALUES ('V0023','A0003', 5)
INSERT INTO Ventas_Deta VALUES ('V0023','A0006', 7)
INSERT INTO Ventas_Deta VALUES ('V0024','A0007', 13)
INSERT INTO Ventas_Deta VALUES ('V0024','A0003', 15)
INSERT INTO Ventas_Deta VALUES ('V0025','A0008', 11)
INSERT INTO Ventas_Deta VALUES ('V0026','A0010', 4)
INSERT INTO Ventas_Deta VALUES ('V0026','A0011', 3)

INSERT INTO Ventas_Deta VALUES ('V0027','A0001', 2)
INSERT INTO Ventas_Deta VALUES ('V0027','A0003', 1)
INSERT INTO Ventas_Deta VALUES ('V0028','A0006', 3)
INSERT INTO Ventas_Deta VALUES ('V0029','A0008', 4)
INSERT INTO Ventas_Deta VALUES ('V0030','A0009', 3)
INSERT INTO Ventas_Deta VALUES ('V0031','A0011', 2)
INSERT INTO Ventas_Deta VALUES ('V0032','A0010', 3)
INSERT INTO Ventas_Deta VALUES ('V0033','A0013', 1)
INSERT INTO Ventas_Deta VALUES ('V0033','A0014', 3)
INSERT INTO Ventas_Deta VALUES ('V0034','A0013', 2)
INSERT INTO Ventas_Deta VALUES ('V0035','A0012', 3)
INSERT INTO Ventas_Deta VALUES ('V0036','A0001', 4)
INSERT INTO Ventas_Deta VALUES ('V0037','A0003', 6)
INSERT INTO Ventas_Deta VALUES ('V0038','A0001', 5)
INSERT INTO Ventas_Deta VALUES ('V0039','A0004', 2)
INSERT INTO Ventas_Deta VALUES ('V0039','A0007', 1)
INSERT INTO Ventas_Deta VALUES ('V0040','A0001', 2)
INSERT INTO Ventas_Deta VALUES ('V0040','A0004', 2)
INSERT INTO Ventas_Deta VALUES ('V0041','A0005', 6)
INSERT INTO Ventas_Deta VALUES ('V0042','A0007', 2)
INSERT INTO Ventas_Deta VALUES ('V0042','A0011', 1)
INSERT INTO Ventas_Deta VALUES ('V0043','A0010', 2)
INSERT INTO Ventas_Deta VALUES ('V0044','A0012', 3)
INSERT INTO Ventas_Deta VALUES ('V0045','A0014', 2)
INSERT INTO Ventas_Deta VALUES ('V0046','A0012', 1)
INSERT INTO Ventas_Deta VALUES ('V0047','A0001', 2)
INSERT INTO Ventas_Deta VALUES ('V0048','A0004', 1)
INSERT INTO Ventas_Deta VALUES ('V0049','A0007', 2)

INSERT INTO Ventas_Deta VALUES ('V0050','A0011', 3)
INSERT INTO Ventas_Deta VALUES ('V0050','A0012', 4)
GO

-- NUEVOS
INSERT INTO Ventas_Deta VALUES ('V0051','A0002', 6)
INSERT INTO Ventas_Deta VALUES ('V0051','A0004', 15)
INSERT INTO Ventas_Deta VALUES ('V0052','A0006', 11)
INSERT INTO Ventas_Deta VALUES ('V0052','A0007', 2)
INSERT INTO Ventas_Deta VALUES ('V0052','A0010', 3)
INSERT INTO Ventas_Deta VALUES ('V0053','A0012', 4)
INSERT INTO Ventas_Deta VALUES ('V0054','A0003', 5)
INSERT INTO Ventas_Deta VALUES ('V0054','A0006', 7)
INSERT INTO Ventas_Deta VALUES ('V0055','A0007', 13)
INSERT INTO Ventas_Deta VALUES ('V0055','A0003', 15)
INSERT INTO Ventas_Deta VALUES ('V0056','A0008', 11)
INSERT INTO Ventas_Deta VALUES ('V0057','A0010', 4)
INSERT INTO Ventas_Deta VALUES ('V0057','A0011', 3)

INSERT INTO Ventas_Deta VALUES ('V0058','A0001', 2)
INSERT INTO Ventas_Deta VALUES ('V0058','A0003', 1)
INSERT INTO Ventas_Deta VALUES ('V0059','A0006', 3)
INSERT INTO Ventas_Deta VALUES ('V0060','A0008', 4)
INSERT INTO Ventas_Deta VALUES ('V0061','A0009', 3)
INSERT INTO Ventas_Deta VALUES ('V0062','A0011', 2)
INSERT INTO Ventas_Deta VALUES ('V0063','A0010', 3)
INSERT INTO Ventas_Deta VALUES ('V0064','A0013', 1)
INSERT INTO Ventas_Deta VALUES ('V0064','A0014', 3)
INSERT INTO Ventas_Deta VALUES ('V0065','A0013', 2)
INSERT INTO Ventas_Deta VALUES ('V0066','A0012', 3)
INSERT INTO Ventas_Deta VALUES ('V0067','A0001', 4)
INSERT INTO Ventas_Deta VALUES ('V0068','A0003', 6)
INSERT INTO Ventas_Deta VALUES ('V0069','A0001', 5)
INSERT INTO Ventas_Deta VALUES ('V0070','A0004', 2)
INSERT INTO Ventas_Deta VALUES ('V0070','A0007', 1)


INSERT INTO Ventas_Deta VALUES ('V0071','A0001', 2)
INSERT INTO Ventas_Deta VALUES ('V0071','A0004', 2)
INSERT INTO Ventas_Deta VALUES ('V0072','A0005', 6)
INSERT INTO Ventas_Deta VALUES ('V0072','A0011', 2)
INSERT INTO Ventas_Deta VALUES ('V0072','A0010', 3)
INSERT INTO Ventas_Deta VALUES ('V0073','A0007', 2)
INSERT INTO Ventas_Deta VALUES ('V0073','A0011', 1)
INSERT INTO Ventas_Deta VALUES ('V0074','A0010', 2)
INSERT INTO Ventas_Deta VALUES ('V0075','A0012', 3)
INSERT INTO Ventas_Deta VALUES ('V0075','A0013', 1)
INSERT INTO Ventas_Deta VALUES ('V0076','A0014', 3)
INSERT INTO Ventas_Deta VALUES ('V0076','A0019', 2)
INSERT INTO Ventas_Deta VALUES ('V0077','A0007', 2)
INSERT INTO Ventas_Deta VALUES ('V0077','A0012', 1)
INSERT INTO Ventas_Deta VALUES ('V0078','A0001', 2)
INSERT INTO Ventas_Deta VALUES ('V0079','A0004', 1)
INSERT INTO Ventas_Deta VALUES ('V0079','A0007', 2)
INSERT INTO Ventas_Deta VALUES ('V0080','A0011', 3)
INSERT INTO Ventas_Deta VALUES ('V0080','A0012', 4)
GO
-------------------------------------------
INSERT INTO Vendedor VALUES ('Diaz Vera, Paola Isabel','01/03/2008')
INSERT INTO Vendedor VALUES ('Pardo Campos, Carlos','11/05/2008')
INSERT INTO Vendedor VALUES ('Linares Moreno, Susana Claudia','12/06/2008')
INSERT INTO Vendedor VALUES ('Mendoza Obando, Maria del Carmen','21/11/2008')
INSERT INTO Vendedor VALUES ('Narvaez Gomez, Mario Dario','15/12/2008')
INSERT INTO Vendedor VALUES ('Murillo Mancini, Juan Carlos','02/05/2009')
INSERT INTO Vendedor VALUES ('Gonzales Vera, Erlinda','12/07/2009')
INSERT INTO Vendedor VALUES ('Diaz Choque, Susy Elizabeth','11/08/2009')
INSERT INTO Vendedor VALUES ('Huamani Rios, Karen Lizet ','21/10/2009')
INSERT INTO Vendedor VALUES ('Camarena Peralta, Cristina Romina','10/11/2009')
GO
/*
SELECT * FROM VENDEDOR
SELECT * FROM CLIENTES
SELECT * FROM Ventas_Deta
GO
*/
-- Adicionando una nueva columna art_pre a la tabla Ventas_Deta
Alter Table Ventas_Deta
Add precio decimal(7,2)
GO
-- Actualizando el precio de la columna art_pre de la
-- tabla Ventas_Deta con los precios de los articulos
Update D 
  Set D.precio=A.pre_art
  From Ventas_Deta D,Articulos A 
Where D.cod_art=A.cod_art
GO

--Select * from Ventas_Deta
--GO

ALTER TABLE ARTICULOS
ADD eli_art	char(2) default 'No' with values
GO

ALTER TABLE CLIENTES
ADD eli_cli	char(2) default 'No' with values
GO

ALTER TABLE VENDEDOR
ADD eli_ven	char(2) default 'No' with values
GO

ALTER TABLE Ventas_Deta
ADD anulado char(2) default 'No' with values
GO

ALTER TABLE Ventas_Cab
ADD tot_vta decimal(8,2) default 0 with values
GO

UPDATE VC
	SET tot_vta = VD.Total
FROM Ventas_Cab VC INNER JOIN
  (SELECT num_vta, SUM(Precio*Cantidad) as Total FROM Ventas_Deta
     GROUP BY num_vta) VD
	on VC.num_vta=VD.num_vta
GO
		
ALTER TABLE Ventas_Cab
ADD anulado char(2) default 'No' with values
GO

INSERT INTO Articulos 
VALUES('A0028', 'CD PRINCO X 50', N'CONO', 25, 10, 'No'),
      ('A0029', 'DVD PRINCO X 50', N'CONO', 30, 20, 'No'),
      ('A0030', 'SCANNER CODIGO DE BARRAS', N'UNI', 190, 10, 'No'),
      ('A0031', 'CD PRINCO X 100', N'CONO', 45, 10, 'No'),
      ('A0032', 'DVD PRINCO X 100', N'CONO', 55, 20, 'No'),
      ('A0033', 'LECTOR-QUEMADOR CD LG', N'UNI', 45, 10, 'No'),
      ('A0034', 'LECTOR-QUEMADOR DVD LG', N'UNI', 75, 20, 'No')
GO

-- Creando las Claves Foráneas
alter table Ventas_Cab
	add constraint fk_Ventas_Cab_cod_cli foreign key(cod_cli)
		references clientes(cod_cli)
go
alter table Ventas_Cab
	add constraint fk_Ventas_Cab_cod_ven foreign key(cod_ven)
		references vendedor(cod_ven)
go

alter table Ventas_Deta
	add constraint fk_Ventas_Deta_num_vta foreign key(num_vta)
		references Ventas_Cab(num_vta)
go
alter table Ventas_Deta
	add constraint fk_Ventas_Deta_cod_art foreign key(cod_art)
		references articulos(cod_art)
go

----------------------------------------

SET NOCOUNT OFF
SELECT MENSAJE='BASE DE DATOS BDVENTAS2022eco CREADA CORRECTAMENTE'
GO
