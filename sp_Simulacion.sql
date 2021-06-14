USE BDPlanillaObrera

exec sp_CargarCatalogos			-- Carga los catalogos

DECLARE @catalogo xml			-- Carga de Data en un dato XML
SELECT @catalogo = CAST(MY_XML AS xml)
FROM OPENROWSET(BULK 'C:\Users\rolbi\Desktop\Datos_Tarea3.xml', SINGLE_BLOB) AS T(MY_XML)

DECLARE @Operaciones TABLE(
Operacion DATE,
Datos XML
)
								-- Declara la primera y ultima operacion 
DECLARE @primeraFecha DATE
SELECT TOP 1 @primeraFecha = T.Item.value('@Fecha', 'date')
FROM @catalogo.nodes('Datos/Operacion') AS T(Item)

DECLARE @ultimaFecha DATE
SELECT @ultimaFecha = T.Item.value('@Fecha', 'date')
FROM @catalogo.nodes('Datos/Operacion') AS T(Item)

DECLARE @i INT;
SELECT @i = 1;
								-- Recorre todas las operaciones dividiendolas
WHILE(@primeraFecha <= @ultimaFecha)
BEGIN
	INSERT INTO @Operaciones
	VALUES(@primeraFecha, @catalogo.query('/Datos/Operacion[sql:variable("@i")]'))
	SET @primeraFecha = DATEADD(DAY,1,@primeraFecha);
	SELECT @i = @i + 1;
END
										-- Reinicia la fecha de la primera operacion
SELECT TOP 1 @primeraFecha = T.Item.value('@Fecha', 'date')
FROM @catalogo.nodes('Datos/Operacion') AS T(Item)

WHILE(@primeraFecha <= @ultimaFecha)
BEGIN
	DECLARE @Datos xml;
	SELECT @Datos = CONVERT(XML, Datos)
	FROM @Operaciones
	WHERE Operacion = @primeraFecha
	DECLARE @Count INT								-- Contador para los whiles

	-- Marca de Asistencia


	-- Calculo de la semana y mes 
	IF DATEPART(WEEKDAY, @primeraFecha) = 4
	BEGIN
		IF(DATENAME(MONTH,DATEADD(DAY,1,@primeraFecha)) <> DATENAME(MONTH,DATEADD(DAY,-6,@primeraFecha)))
		BEGIN
			DECLARE @Semanas INT = 0
			DECLARE @RecorrerSemanas DATE = (SELECT DATEADD(DAY,1,@primeraFecha))
			WHILE (DATENAME(MONTH,DATEADD(DAY,1,@primeraFecha)) = (DATENAME(MONTH,@RecorrerSemanas)))
			BEGIN
				SET @RecorrerSemanas = (SELECT DATEADD(WEEK,1,@RecorrerSemanas))
				SET @Semanas = @Semanas+1
			END
			INSERT INTO dbo.MesPlanilla
			VALUES((SELECT DATEADD(DAY,1,@primeraFecha)), (SELECT DATEADD(DAY,7*@Semanas,@primeraFecha)))
		END
		
		INSERT INTO dbo.SemanaPlanilla
		VALUES((SELECT DATEADD(DAY,1,@primeraFecha)), (SELECT DATEADD(DAY,7,@primeraFecha)), (SELECT MAX(Id) AS Id FROM dbo.MesPlanilla))
	END


	-- Ingreso de los empleados nuevos 
	IF((SELECT mt.Datos.exist('Operacion/NuevoEmpleado') FROM @Operaciones mt WHERE mt.Operacion = @primeraFecha) = 1)
	BEGIN
		EXEC sp_CargarInsercionEmpleados @Datos
        SELECT @Count = COUNT(*) FROM ##InsercionEmpleado;

        WHILE @Count > 0
		BEGIN
			DECLARE @Nombre VARCHAR(64) = (SELECT TOP(1) Nombre FROM ##InsercionEmpleado)
            DECLARE @ValorDocumentoIdentidad VARCHAR(32) =  (SELECT TOP(1) ValorDocumentoIdentidad FROM ##InsercionEmpleado)
            DECLARE @FechaNacimiento DATE = (SELECT TOP(1) FechaNacimiento FROM ##InsercionEmpleado)
            DECLARE @IdPuesto INT = (SELECT TOP(1) IdPuesto FROM ##InsercionEmpleado)
            DECLARE @IdDepartamento INT =  (SELECT TOP(1) IdDepartamento FROM ##InsercionEmpleado)
            DECLARE @IdTipoDocumentoIdentidad INT = (SELECT TOP(1) IdTipoDocumentoIdentidad FROM ##InsercionEmpleado)
            DECLARE @Username VARCHAR(64) = (SELECT TOP(1) Username FROM ##InsercionEmpleado)
            DECLARE @Contraseña VARCHAR(64) = (SELECT TOP(1) Pwd FROM ##InsercionEmpleado)

			EXEC sp_InsertarEmpleado
				@Nombre
				, @ValorDocumentoIdentidad
                , @FechaNacimiento
                , @IdPuesto
                , @IdDepartamento
                , @IdTipoDocumentoIdentidad
                , @Username
                , @Contraseña

			DELETE TOP (1) FROM ##InsercionEmpleado
            SELECT @Count = COUNT(*) FROM ##InsercionEmpleado;
		END

		DROP TABLE ##InsercionEmpleado
	END

	-- Asocia y Desacocia deducciones

	SET @primeraFecha = DATEADD(DAY,1,@primeraFecha);
END
