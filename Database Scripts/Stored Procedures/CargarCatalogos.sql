USE [BDPlanillaObrera]
GO

/****** Object:  StoredProcedure [dbo].[LectorXML]    Script Date: 6/4/2021 8:32:54 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[LectorXML] 
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @catalogo xml
	SELECT @catalogo = CAST(MY_XML AS xml)
	FROM OPENROWSET(BULK 'C:\xampp\htdocs\proyectos\Tarea2\Datos_Tarea2.xml', SINGLE_BLOB) AS T(MY_XML)

	INSERT INTO Puesto (ID, nombre_P, salarioXhora, Activo)
	SELECT	ID				= T.Item.value('@Id', 'numeric(18,0)'),
			nombre_P			= T.Item.value('@Nombre', 'nvarchar(64)'),
			salarioXhora	= T.Item.value('@SalarioXHora', 'numeric(18,0)'),
			Activo = 1
	FROM   @catalogo.nodes('Datos/Catalogos/Puestos/Puesto') AS T(Item)

	INSERT INTO Departamento(ID, nombre_Dpt)
	SELECT	ID				= T.Item.value('@Id', 'numeric(18,0)'),
			nombre_Dpt			= T.Item.value('@Nombre', 'nvarchar(64)')
	FROM   @catalogo.nodes('Datos/Catalogos/Departamentos/Departamento') AS T(Item)

	INSERT INTO TipoDocIdent(ID, nombre_Doc)
	SELECT	ID				= T.Item.value('@Id', 'numeric(18,0)'),
			nombre_Doc			= T.Item.value('@Nombre', 'nvarchar(64)')
	FROM   @catalogo.nodes('Datos/Catalogos/Tipos_de_Documento_de_Identificacion/TipoIdDoc') AS T(Item)

	INSERT INTO TipoJornada(ID, Nombre, HoraInicio, HoraFin)
	SELECT	ID					= T.Item.value('@Id', 'numeric(18,0)'),
			Nombre				= T.Item.value('@Nombre', 'nvarchar(64)'),
			HoraInicio			= T.Item.value('@HoraEntrada', 'time'),
			HoraFin				= T.Item.value('@HoraSalida', 'time')
	FROM   @catalogo.nodes('Datos/Catalogos/TiposDeJornada/TipoDeJornada') AS T(Item)

	INSERT INTO TipoMovimientoPlanilla(ID, Nombre)
	SELECT	ID				= T.Item.value('@Id', 'numeric(18,0)'),
			Nombre			= T.Item.value('@Nombre', 'nvarchar(50)')
	FROM   @catalogo.nodes('Datos/Catalogos/TiposDeMovimiento/TipoDeMovimiento') AS T(Item)

	INSERT INTO Feriados(Fecha, Nombre)
	SELECT	Fecha			= T.Item.value('@Fecha', 'date'),
			Nombre			= T.Item.value('@Nombre', 'nvarchar(50)')
	FROM   @catalogo.nodes('Datos/Catalogos/Feriados/Feriado') AS T(Item)

	INSERT INTO TipoDeduccion(ID, Nombre, EsObligatoria, EsPorcentual)				-- Cambiar por el mio
	SELECT	ID			= T.Item.value('@Id', 'numeric(18,0)'),
			Nombre			= T.Item.value('@Nombre', 'nvarchar(50)'),						
			EsObligatoria	= T.Item.value('@Obligatorio', 'nchar(10)'),				
			EsPorcentual	= T.Item.value('@Porcentual', 'nchar(10)')
	FROM   @catalogo.nodes('Datos/Catalogos/Deducciones/TipoDeDeduccion') AS T(Item)

	INSERT INTO DeduccionPorcentualObligatoria(ID, Porcentaje)
	SELECT	ID			= T.Item.value('@Id', 'numeric(18,0)'),
			Porcentaje	= T.Item.value('@Valor', 'float')
	FROM   @catalogo.nodes('Datos/Catalogos/Deducciones/TipoDeDeduccion') AS T(Item)
	WHERE T.Item.value('@Obligatorio', 'nchar(10)') = 'Si'

	--INSERT INTO Empleado(IDTipoDocIdent, IDPuesto, IDDepartamento, valorDocIdent, nombre, fechaNacimiento , Activo, usuario, contrasena)
	--SELECT	IDTipoDocIdent	= T.Item.value('@idTipoDocumentacionIdentidad', 'numeric(18,0)'),
	--		IDPuesto		= T.Item.value('@idPuesto', 'numeric(18,0)'),
	--		IDDepartamento	= T.Item.value('@IdDepartamento', 'numeric(18,0)'),
	--		valorDocIdent	= T.Item.value('@ValorDocumentoIdentidad', 'numeric(18,0)'),
	--		nombre			= T.Item.value('@Nombre', 'nvarchar(64)'),
	--		fechaNacimiento	= T.Item.value('@FechaNacimiento', 'date'),
	--		Activo = 1,
	--		usuario = 'Prueba',
	--		contrasena = 'Prueba'
	--FROM   @catalogo.nodes('Datos/Empleados/Empleado') AS T(Item)

	INSERT INTO Usuario(nombre, contrasena, tipo, activo)
	SELECT	nombre		= T.Item.value('@username', 'nvarchar(64)'),
			contrasena	= T.Item.value('@pwd', 'nvarchar(64)'),
			tipo		= T.Item.value('@tipo', 'nchar(10)'),
			activo = 1
	FROM   @catalogo.nodes('Datos/Usuarios/Usuario') AS T(Item)
END
GO

