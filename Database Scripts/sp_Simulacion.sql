
USE BDPlanillaObrera

EXEC sp_EliminarDatos					-- Vaciar datos de la base


-- Declaracion de Tablas Variable
DECLARE @Operaciones TABLE(				-- Tabla donde iteramos todas las operaciones
	Operacion DATE,
	Datos XML
)

DECLARE @InsercionMarcas TABLE			-- Tabla donde iteramos las Marcas de Asistencia
(
	ValorDocumentoIdentidad VARCHAR(32),
	FechaEntrada DATETIME,
	FechaSalida DATETIME,
	Secuencia INT,
	ProduceError INT
) 

DECLARE @InsercionEmpleados TABLE(		-- Tabla donde ingresamos todos los empleados a insertar
	Fecha DATE,
	Nombre VARCHAR(64),
	ValorDocumentoIdentidad VARCHAR(32),
	FechaNacimiento DATE,
	IdPuesto INT,
	IdTipoDocumentoIdentidad INT,
	IdDepartamento INT,
	Username VARCHAR(64),
	Pwd VARCHAR(64),
	Secuencia INT,
	ProduceError INT
)

DECLARE @EliminarEmpleados TABLE (		-- Tabla donde guardamos todos los empleados a eliminar
	ValorDocumentoIdentidad VARCHAR(32),
	Secuencia INT,
	ProduceError INT
) 

DECLARE @AsociarEmpleados TABLE			-- Tabla donde guardamos todas las asociaciones 
(
	ValorDocumentoIdentidad VARCHAR(32),
	IdDeduccion INT,
	Monto DECIMAL(18,3),
	Secuencia INT,
	ProduceError INT
) 

DECLARE @DesasociarEmpleados TABLE		-- Tabla donde guardamos todas las desasociaciones
(
	ValorDocumentoIdentidad VARCHAR(32),
	IdDeduccion INT,
	Secuencia INT,
	ProduceError INT
) 

DECLARE @IngresarJornada TABLE			-- Tablas donde almacenamos las siguientes jornadas
(
	ValorDocumentoIdentidad VARCHAR(32),
	IdJornada INT,
	Secuencia INT,
	ProduceError INT
) 


-- Declaracion de Variables
DECLARE @catalogo xml			-- Para dividir el xml en la tabla operaciones
DECLARE @primeraFecha DATE
DECLARE @ultimaFecha DATE
DECLARE @i INT;	

DECLARE @Datos xml				-- Para ejecucion de simulacion
DECLARE @Count INT	
DECLARE @Semanas INT
DECLARE @RecorrerSemanas DATE

DECLARE @Secuencia INT
DECLARE @ProduceError INT

DECLARE @Nombre VARCHAR(64)
DECLARE @ValorDocumentoIdentidad VARCHAR(32)
DECLARE @FechaNacimiento DATE
DECLARE @IdPuesto INT
DECLARE @IdDepartamento INT
DECLARE @IdTipoDocumentoIdentidad INT
DECLARE @Username VARCHAR(64)
DECLARE @Contraseña VARCHAR(64)

DECLARE @IdDeduccion INT
DECLARE @Monto DECIMAL(18,3)
DECLARE @IdJornada INT

DECLARE @FechaEntrada DATETIME
DECLARE @FechaSalida DATETIME


-- SIMULACION
-- Carga de Catalogos ------------------------------------------------------------------------------
exec sp_CargarCatalogos			-- Carga los catalogos

-- Simulacion --------------------------------------------------------------------------------------
SELECT @catalogo = CAST(MY_XML AS xml) 
FROM OPENROWSET(BULK 'C:\Datos_Tarea3.xml', SINGLE_BLOB) AS T(MY_XML)

SELECT TOP 1 @primeraFecha = T.Item.value('@Fecha', 'date') 
FROM @catalogo.nodes('Datos/Operacion') AS T(Item)

SELECT @ultimaFecha = T.Item.value('@Fecha', 'date') 
FROM @catalogo.nodes('Datos/Operacion') AS T(Item)

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


-- Inicia Simulacion ---------------------------------------------------------------
WHILE(@primeraFecha <= @ultimaFecha)
BEGIN
	SELECT @Datos = CONVERT(XML, Datos)
	FROM @Operaciones
	WHERE Operacion = @primeraFecha

	-- Calculo de la semana y mes 
	IF DATEPART(WEEKDAY, @primeraFecha) = 4
	BEGIN
		IF(DATENAME(MONTH,DATEADD(DAY,1,@primeraFecha)) <> DATENAME(MONTH,DATEADD(DAY,-6,@primeraFecha)))
		BEGIN
			SELECT @Semanas = 0
			SELECT @RecorrerSemanas = (SELECT DATEADD(DAY,1,@primeraFecha))
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


	-- Ingreso de la Marca Asistencia 
	IF((SELECT mt.Datos.exist('Operacion/MarcaDeAsistencia') FROM @Operaciones mt WHERE mt.Operacion = @primeraFecha) = 1)
	BEGIN
		INSERT INTO @InsercionMarcas
			SELECT * FROM dbo.CargarInsercionMarca(@Datos)

		SELECT @Count = COUNT(*) FROM @InsercionMarcas;

        WHILE @Count > 0
		BEGIN
			select TOP(1)* from @InsercionMarcas where ValorDocumentoIdentidad = '96311578'
			SELECT TOP(1)
				@ValorDocumentoIdentidad = Emp.ValorDocumentoIdentidad, 
				@FechaEntrada = Emp.FechaEntrada, 
				@FechaSalida = Emp.FechaSalida 
			FROM @InsercionMarcas AS Emp
			
			PRINT('Inicia Marca Asistencia')

			EXEC sp_InsertarMarca
				@ValorDocumentoIdentidad
                , @FechaEntrada
				, @FechaSalida,
				0
			
			DELETE TOP (1) FROM @InsercionMarcas
            SELECT @Count = COUNT(*) FROM @InsercionMarcas;
		END
	END


	-- Ingreso de los empleados nuevos 
	IF((SELECT mt.Datos.exist('Operacion/NuevoEmpleado') FROM @Operaciones mt WHERE mt.Operacion = @primeraFecha) = 1)
	BEGIN
		INSERT INTO @InsercionEmpleados
			SELECT * FROM dbo.CargarInsercionEmpleados(@Datos)

		SELECT @Count = COUNT(*) FROM @InsercionEmpleados;

        WHILE @Count > 0
		BEGIN
			SELECT TOP(1)
				@Nombre = Emp.Nombre, 
				@ValorDocumentoIdentidad = Emp.ValorDocumentoIdentidad, 
				@FechaNacimiento = Emp.FechaNacimiento, 
				@IdPuesto = Emp.IdPuesto, 
				@IdDepartamento = Emp.IdDepartamento, 
				@IdTipoDocumentoIdentidad = Emp.IdTipoDocumentoIdentidad, 
				@Username = Emp.Username, 
				@Contraseña = Emp.Pwd
			FROM @InsercionEmpleados AS Emp


			EXEC sp_InsertarEmpleado
				@Nombre
				, @ValorDocumentoIdentidad
                , @FechaNacimiento
                , @IdPuesto
                , @IdDepartamento
                , @IdTipoDocumentoIdentidad
                , @Username
                , @Contraseña

			DELETE TOP (1) FROM @InsercionEmpleados
            SELECT @Count = COUNT(*) FROM @InsercionEmpleados;
		END
	END


	-- Eliminacion de empleados 
	IF((SELECT mt.Datos.exist('Operacion/EliminarEmpleado') FROM @Operaciones mt WHERE mt.Operacion = @primeraFecha) = 1)
	BEGIN
		INSERT INTO @EliminarEmpleados
			SELECT * FROM dbo.CargarEliminarEmpleados(@Datos)

        SELECT @Count = COUNT(*) FROM @EliminarEmpleados;
		
        WHILE @Count > 0
		BEGIN
            SELECT TOP(1)
				@ValorDocumentoIdentidad = Emp.ValorDocumentoIdentidad  
			FROM @EliminarEmpleados AS Emp

			EXEC sp_EliminarEmpleado
				@ValorDocumentoIdentidad

			DELETE TOP (1) FROM @EliminarEmpleados
            SELECT @Count = COUNT(*) FROM @EliminarEmpleados;
		END
	END
	

	-- Asociacion de empleado a una Deduccion 
	IF((SELECT mt.Datos.exist('Operacion/AsociaEmpleadoConDeduccion') FROM @Operaciones mt WHERE mt.Operacion = @primeraFecha) = 1)
	BEGIN
		INSERT INTO @AsociarEmpleados
			SELECT * FROM dbo.CargarAsociarEmpleados(@Datos)

        SELECT @Count = COUNT(*) FROM @AsociarEmpleados;
		
        WHILE @Count > 0
		BEGIN
            SELECT TOP(1)
				@ValorDocumentoIdentidad = Emp.ValorDocumentoIdentidad,
				@IdDeduccion = Emp.IdDeduccion,
				@Monto = Emp.Monto
			FROM @AsociarEmpleados AS Emp

			EXEC sp_AsociarDeduccion
				@primeraFecha,
				@ValorDocumentoIdentidad,
				@IdDeduccion,
				@Monto

			DELETE TOP (1) FROM @AsociarEmpleados
            SELECT @Count = COUNT(*) FROM @AsociarEmpleados;
		END
	END


	-- Desasociacion de empleado a una Deduccion 
	IF((SELECT mt.Datos.exist('Operacion/DesasociaEmpleadoConDeduccion') FROM @Operaciones mt WHERE mt.Operacion = @primeraFecha) = 1)
	BEGIN
		INSERT INTO @DesasociarEmpleados
			SELECT * FROM dbo.CargarDesasociarEmpleados(@Datos)

        SELECT @Count = COUNT(*) FROM @DesasociarEmpleados;
		
        WHILE @Count > 0
		BEGIN
            SELECT TOP(1)
				@ValorDocumentoIdentidad = Emp.ValorDocumentoIdentidad,
				@IdDeduccion = Emp.IdDeduccion
			FROM @DesasociarEmpleados AS Emp

			EXEC sp_DesasociarDeduccion
				@primeraFecha,
				@ValorDocumentoIdentidad,
				@IdDeduccion

			DELETE TOP (1) FROM @DesasociarEmpleados
            SELECT @Count = COUNT(*) FROM @DesasociarEmpleados;
		END
	END


	-- Asignar Tipos de Jornada
	IF((SELECT mt.Datos.exist('Operacion/TipoDeJornadaProximaSemana') FROM @Operaciones mt WHERE mt.Operacion = @primeraFecha) = 1)
	BEGIN
		INSERT INTO @IngresarJornada
			SELECT * FROM dbo.CargarIngresarJornada(@Datos)

        SELECT @Count = COUNT(*) FROM @IngresarJornada;
		
        WHILE @Count > 0
		BEGIN
            SELECT TOP(1)
				@ValorDocumentoIdentidad = Emp.ValorDocumentoIdentidad,
				@IdJornada = Emp.IdJornada,
				@Secuencia = Emp.Secuencia,
				@ProduceError = Emp.ProduceError
			FROM @IngresarJornada AS Emp
			
			EXEC sp_IngresarJornada
				@ValorDocumentoIdentidad,
				@IdJornada
			
			DELETE TOP (1) FROM @IngresarJornada
            SELECT @Count = COUNT(*) FROM @IngresarJornada;
		END
	END


	SET @primeraFecha = DATEADD(DAY,1,@primeraFecha);
END

SELECT * FROM Empleado

SELECT * FROM MarcaAsistencia AS Ma
INNER JOIN dbo.Jornada AS Jor
ON Ma.IdJornada = Jor.Id 
INNER JOIN dbo.Empleado AS Emp
ON Emp.Id = Jor.IdEmpleado
WHERE Emp.Id = 1