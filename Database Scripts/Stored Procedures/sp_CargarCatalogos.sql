USE [BDPlanillaObrera]
GO

/****** Object:  StoredProcedure [dbo].[sp_CargarCatalogos]    Script Date: 11/06/2021 2:24:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_CargarCatalogos]
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @catalogo xml
	SELECT @catalogo = CAST(MY_XML AS xml)
	FROM OPENROWSET(BULK 'C:\Users\rolbi\Desktop\Datos_Tarea3.xml', SINGLE_BLOB) AS T(MY_XML)

	INSERT INTO dbo.Puesto (Id, Nombre, SalarioXHora, Activo)
	SELECT	ID			 = T.Item.value('@Id', 'int'),
			nombre_P	 = T.Item.value('@Nombre', 'varchar(64)'),
			salarioXhora = T.Item.value('@SalarioXHora', 'decimal(18,3)'),
			Activo = 1
	FROM   @catalogo.nodes('Datos/Catalogos/Puestos/Puesto') AS T(Item)

	INSERT INTO dbo.Departamento(Id, Nombre, Activo)
	SELECT	ID				= T.Item.value('@Id', 'int'),
			nombre_Dpt			= T.Item.value('@Nombre', 'nvarchar(64)'),
			Activo = 1
	FROM   @catalogo.nodes('Datos/Catalogos/Departamentos/Departamento') AS T(Item)

	INSERT INTO dbo.TipoDocumentoIdentidad(Id, Nombre, Activo)
	SELECT	ID				= T.Item.value('@Id', 'int'),
			nombre_Doc			= T.Item.value('@Nombre', 'varchar(64)'),
			Activo = 1
	FROM   @catalogo.nodes('Datos/Catalogos/Tipos_de_Documento_de_Identificacion/TipoIdDoc') AS T(Item)

	INSERT INTO dbo.TipoJornada(ID, Nombre, HoraEntrada, HoraSalida, Activo)
	SELECT	ID					= T.Item.value('@Id', 'int'),
			Nombre				= T.Item.value('@Nombre', 'varchar(64)'),
			HoraInicio			= T.Item.value('@HoraEntrada', 'time'),
			HoraFin				= T.Item.value('@HoraSalida', 'time'),
			Activo = 1
	FROM   @catalogo.nodes('Datos/Catalogos/TiposDeJornada/TipoDeJornada') AS T(Item)

	INSERT INTO dbo.TipoMovimiento(Id, Nombre)
	SELECT	ID				= T.Item.value('@Id', 'int'),
			Nombre			= T.Item.value('@Nombre', 'varchar(64)')
	FROM   @catalogo.nodes('Datos/Catalogos/TiposDeMovimiento/TipoDeMovimiento') AS T(Item)

	INSERT INTO dbo.Feriado(Nombre, Fecha, Activo)
	SELECT	Nombre			= T.Item.value('@Nombre', 'varchar(64)'),
			Fecha			= T.Item.value('@Fecha', 'date'),
			Activo			= 1
	FROM   @catalogo.nodes('Datos/Catalogos/Feriados/Feriado') AS T(Item)

	EXEC sp_CargarTipoDeduccion

	INSERT INTO Usuario(Username, Pwd, Tipo, Activo)
	SELECT	nombre		= T.Item.value('@username', 'varchar(64)'),
			contrasena	= T.Item.value('@pwd', 'varchar(64)'),
			tipo		= T.Item.value('@tipo', 'nchar(10)'),
			activo = 1
	FROM   @catalogo.nodes('Datos/Usuarios/Usuario') AS T(Item)

	SET NOCOUNT OFF
END
GO


