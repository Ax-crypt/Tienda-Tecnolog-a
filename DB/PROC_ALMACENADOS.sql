USE BDVENTAS2022eco
GO

CREATE OR ALTER PROC PA_LISTAR_CLIENTES_CC
AS
SELECT C.cod_cli, C.nom_cli, C.tel_cli, C.cred_cli
FROM Clientes C
GO

--exec PA_LISTAR_CLIENTES_CC
--go

--------------------------------
CREATE OR ALTER PROC PA_LISTAR_ARTICULOS
AS
SELECT A.cod_art, nom_art,
        A.pre_art,stk_art
FROM Articulos A
	WHERE A.stk_art>=0 
	
GO

exec PA_LISTAR_ARTICULOS  
go




-- ULTIMA VENTA REGISTRADA
--------------------------------
SELECT TOP(1) VC.*, C.nom_cli 
   FROM Ventas_Cab VC INNER JOIN CLIENTES C
   ON VC.cod_cli=C.cod_cli
   ORDER BY VC.num_vta DESC
GO

SELECT TOP(1) WITH TIES VD.*, A.cod_art
FROM Ventas_Deta VD INNER JOIN Articulos A
	ON VD.cod_art=A.cod_art
	ORDER BY VD.num_vta DESC
GO

----------------- PROC GRABAR  ---------------------
CREATE OR ALTER PROC PA_GRABAR_WEB_VENTAS_CAB
@COD_CLI CHAR(5),@TOT_VTA DECIMAL(10,2)
AS
	-- DECLARANDO VARIABLE PARA EL NUEVO NUMERO DE LA VENTA
	DECLARE @NUMERO VARCHAR(5) 
	-- RECUPERANDO EL MAXIMO NUMERO DE VENTA
	SELECT @NUMERO=RIGHT(MAX(NUM_VTA),4)+1 FROM Ventas_Cab
	-- GENERANDO EL NUEVO NUMERO DE LA VENTA
	SELECT @NUMERO='V'+RIGHT('000'+@NUMERO,4)

	-----------------------------------------------
	-- INSERTANDO LOS DATOS DE LA NUEVA VENTA
	INSERT INTO Ventas_Cab VALUES(@NUMERO,GETDATE(),
	@COD_CLI, 1, @TOT_VTA, 'No')
	-- DEVOLVIENDO EL NUEVO NUMERO DE VENTA GENERADO
	SELECT @NUMERO AS NUMERO
GO

CREATE OR ALTER PROC PA_GRABAR_WEB_VENTAS_DETA
@NUM_VTA CHAR(5), @COD_ART CHAR(5), 
@CANTIDAD INT, @PRECIO DECIMAL(7,2)
AS
	-- INSERTANDO EL NUEVO DETALLE DE LA VENTA
	INSERT INTO Ventas_Deta 
	   VALUES(@NUM_VTA, @COD_ART, @CANTIDAD, @PRECIO, 'No')
	-- ACTUALIZANDO EL STOCK DEL PRODUCTO
	UPDATE Articulos SET stk_art=stk_art -@CANTIDAD
	WHERE cod_art = @COD_ART
GO


-- constraint de tipo check sobre la columna 
-- stk_prod de la tabla ARTICULOS que no permite 
-- tener un stock negativo
/*
ALTER TABLE Articulos
	ADD CONSTRAINT CK_STK_PROD CHECK(STK_ART>=0)
GO
*/


select * from ventas_cab order by num_vta desc
go
select * from ventas_deta order by num_vta desc
go
select * from Articulos order by stk_art asc
go




CREATE OR ALTER PROC FILTRAR_PROD
@NOMBRE varchar(20)
AS
SELECT A.cod_art, nom_art,
        A.pre_art,stk_art
FROM Articulos A
	WHERE A.stk_art>=0 
	AND  nom_art LIKE '%' + @NOMBRE + '%'
GO

exec FILTRAR_PROD  @NOMBRE = 'mous'
go
