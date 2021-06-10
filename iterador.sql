USE [Proyecto_2]
GO

/****** Object:  StoredProcedure [dbo].[Iterador]    Script Date: 6/10/2021 12:34:36 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Iterador]
-- parametros de entrada
-- parametros de salida
  @OutResultCode INT OUTPUT
  
AS
BEGIN
  SET NOCOUNT ON;
  EXEC dbo.LectorXML
DECLARE @catalogo xml
SELECT @catalogo = CAST(MY_XML AS xml)
FROM OPENROWSET(BULK 'C:\xampp\htdocs\proyectos\Tarea2\Datos_Tarea2.xml', SINGLE_BLOB) AS T(MY_XML)

DECLARE @MiTabla TABLE
(
Identificador DATE,
MiXML XML
)

DECLARE @lowDate DATE
SELECT TOP 1 @lowDate = T.Item.value('@Fecha', 'date')
FROM @catalogo.nodes('Datos/Operacion') AS T(Item)

DECLARE @highDate DATE
SELECT @highDate = T.Item.value('@Fecha', 'date')
FROM @catalogo.nodes('Datos/Operacion') AS T(Item)

DECLARE @i INT;
SELECT @i = 1;

WHILE(@lowDate<=@highDate)
BEGIN
	INSERT INTO @MiTabla
	VALUES(@lowDate, @catalogo.query('/Datos/Operacion[sql:variable("@i")]'))
	SET @lowDate = DATEADD(DAY,1,@lowDate);
	SELECT @i = @i + 1;
END

SELECT * FROM @MiTabla

SELECT TOP 1 @lowDate = T.Item.value('@Fecha', 'date')
FROM @catalogo.nodes('Datos/Operacion') AS T(Item)
DECLARE @idMes INT;
SELECT @idMes = 0;
DECLARE @idSemana INT;
SELECT @idSemana = 0;

WHILE(@lowDate<=@highDate)
BEGIN
	DECLARE @MiXML xml;
	SELECT @MiXML = CONVERT(XML, MiXML)
	FROM @MiTabla
	WHERE Identificador = @lowDate

	IF DATENAME(weekday, @lowDate) IN (N'Thursday')
	BEGIN
		IF(DATENAME(MONTH,@lowDate)<>DATENAME(MONTH,DATEADD(DAY,-7,@lowDate)))
			SELECT @idMes = @idMes + 1;
			INSERT INTO dbo.MesPlanilla (ID, FechaInicio, FechaFinal)
			VALUES(@idMes,(SELECT DATEADD(DAY,1,@lowDate)), (SELECT DATEADD(MONTH,1,@lowDate)))
		SELECT @idSemana = @idSemana + 1;
		INSERT INTO dbo.SemanaPlanilla(ID, FechaInicio, FechaFin, IDMesPlanilla)
		VALUES(@idSemana, @lowDate, (SELECT DATEADD(WEEK,1,@lowDate)), @idMes)



	END
	-- Inserta empleados inicio
	IF((SELECT mt.MiXML.exist('Operacion/NuevoEmpleado') FROM @MiTabla mt WHERE mt.Identificador=@lowDate) = 1)
	BEGIN
		INSERT INTO dbo.Empleado(	fechaNacimiento,
									nombre,
									contrasena,
									usuario,
									valorDocIdent,
									IDDepartamento,
									IDPuesto,
									IDTipoDocIdent,
									Activo)
		SELECT	Tabla.Col.value('@FechaNacimiento', 'DATE') AS 'fechaNacimiento',
				Tabla.Col.value('@Nombre', 'NVARCHAR(64)') AS 'nombre',
				Tabla.Col.value('@Password', 'NVARCHAR(50)') AS 'contrasena',
				Tabla.Col.value('@Username', 'NVARCHAR(50)') AS 'usuario',
				Tabla.Col.value('@ValorDocumentoIdentidad', 'INT') AS 'valorDocIdent',
				Tabla.Col.value('@idDepartamento', 'NUMERIC(18,0)') AS 'IDDepartamento',
				Tabla.Col.value('@idPuesto', 'NUMERIC(18,0)') AS 'IDPuesto',
				Tabla.Col.value('@idTipoDocumentacionIdentidad', 'NUMERIC(18,0)') AS 'IDTipoDocIdent',
				1 AS 'Activo'
		FROM	@MiXML.nodes('Operacion/NuevoEmpleado') Tabla(Col);

	END -- Inserta Empleado fin
	-- Inserta Jornada inicio
	IF((SELECT mt.MiXML.exist('Operacion/TipoDeJornadaProximaSemana') FROM @MiTabla mt WHERE mt.Identificador=@lowDate) = 1)
	BEGIN 
		INSERT INTO dbo.Jornada(	IDTipoJornada,
									IDSemanaPlanilla,
									IDEmpleado)
			SELECT	Tabla.Col.value('@IdJornada', 'NUMERIC(18,0)') AS 'IDTipoJornada',
					@idSemana AS 'IDSemanaPlanilla',
					Tabla.Col.value('@ValorDocumentoIdentidad', 'INT') AS 'IDEmpleado'
			FROM	@MiXML.nodes('Operacion/TipoDeJornadaProximaSemana') Tabla(Col);
	END -- Inserta Jornada fin
	-- Inserta DeduccionXEmpleado inicio
	IF((SELECT mt.MiXML.exist('Operacion/AsociaEmpleadoConDeduccion') FROM @MiTabla mt WHERE mt.Identificador=@lowDate) = 1)
		BEGIN
			INSERT INTO dbo.DeduccionXEmpleado(	IDTipoDeduccion,
												IDEmpleado,
												Activo)
				SELECT	Tabla.Col.value('@IdDeduccion', 'NUMERIC(18,0)') AS 'IDTipoDeduccion',
						Tabla.Col.value('@ValorDocumentoIdentidad', 'INT') AS 'IDEmpleado',
						1 AS 'Activo'
				FROM	@MiXML.nodes('Operacion/AsociaEmpleadoConDeduccion') Tabla(Col);
			INSERT INTO dbo.FijaNoObligatoria(	ID,
												Monto)
				SELECT	IDENT_CURRENT('dbo.DeduccionXEmpleado') AS 'ID',
						Tabla.Col.value('@Monto', 'FLOAT') AS 'Monto'
				FROM	@MiXML.nodes('Operacion/AsociaEmpleadoConDeduccion') Tabla(Col);
		END	-- Inserta DeduccionXEmpleado fin
		-- Inserta MarcaAsistencia inicio
		IF((SELECT mt.MiXML.exist('Operacion/MarcaDeAsistencia') FROM @MiTabla mt WHERE mt.Identificador=@lowDate) = 1)
		BEGIN
			INSERT INTO dbo.MarcaAsistencia(	MarcaInicio,
												MarcaFinal,
												IDEmpleado)
				SELECT	Tabla.Col.value('@FechaEntrada', 'DATETIME') AS 'MarcaInicio',
						Tabla.Col.value('@FechaSalida', 'DATETIME') AS 'MarcaFinal',
						Tabla.Col.value('@ValorDocumentoIdentidad', 'INT') AS 'IDEmpleado'
				FROM	@MiXML.nodes('Operacion/MarcaDeAsistencia') Tabla(Col);
		END -- Inserta MarcaAsistencia fin

		-- Elimina Empleado inicio
		IF((SELECT mt.MiXML.exist('Operacion/EliminarEmpleado') FROM @MiTabla mt WHERE mt.Identificador=@lowDate) = 1)
		BEGIN 
			UPDATE dbo.Empleado
			SET Activo = 0
			WHERE dbo.Empleado.valorDocIdent = (SELECT Tabla.Col.value('@ValorDocumentoIdentidad','INT')
												FROM @MiXML.nodes('Operacion/EliminarEmpleado') Tabla(Col))
		END -- Elimina Empleado fin
		-- Desasocia deduccion con empleado inicio
		IF((SELECT mt.MiXML.exist('Operacion/DesasociaEmpleadoConDeduccion') FROM @MiTabla mt WHERE mt.Identificador=@lowDate) = 1)
		BEGIN 
			UPDATE dbo.DeduccionXEmpleado
			SET Activo = 0
			WHERE dbo.DeduccionXEmpleado.IDEmpleado = (SELECT Tabla.Col.value('@ValorDocumentoIdentidad','INT')
												FROM @MiXML.nodes('Operacion/DesasociaEmpleadoConDeduccion') Tabla(Col))
		END -- Desasocia deduccion con empleado fin



	SET @lowDate = DATEADD(DAY,1,@lowDate);
END

  SET NOCOUNT OFF;
END
GO

