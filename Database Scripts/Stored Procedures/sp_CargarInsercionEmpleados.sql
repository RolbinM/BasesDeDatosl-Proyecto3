USE [BDPlanillaObrera]
GO

/****** Object:  StoredProcedure [dbo].[sp_CargarInsercionEmpleados]    Script Date: 13/06/2021 1:51:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_CargarInsercionEmpleados]
@Datos XML
AS
BEGIN
	SET NOCOUNT ON

	BEGIN TRY
		-- Cargar Datos de Insercion de empleados en tabla temporal

		CREATE TABLE ##InsercionEmpleado(
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
		);

		DECLARE @OutResultCode INT

		SET @OutResultCode = 0;

		BEGIN TRANSACTION CargarInsercionEmpleados
			INSERT INTO ##InsercionEmpleado
				SELECT
					CAST(empleado.value('../@Fecha','VARCHAR(64)') AS DATE) AS Fecha,
					empleado.value('@Nombre','VARCHAR(64)') AS Nombre,
					empleado.value('@ValorDocumentoIdentidad','VARCHAR(32)') AS ValorDocIdentidad,
					CAST(empleado.value('@FechaNacimiento','VARCHAR(32)') AS DATE) AS FechaNacimiento,
					empleado.value('@idPuesto','INT') AS IdPuesto,
					empleado.value('@idTipoDocumentacionIdentidad','INT') AS IdTipoDocumento,
					empleado.value('@idDepartamento','INT') AS IdDepartamento,
					empleado.value('@Username','VARCHAR(64)') AS Username,
					empleado.value('@Password','VARCHAR(64)') AS Pwd,
					empleado.value('@Secuencia','INT') AS Secuencia,
					empleado.value('@ProduceError','INT') AS ProduceError
				FROM @Datos.nodes('Operacion/NuevoEmpleado') AS T(empleado)

		COMMIT TRANSACTION CargarInsercionEmpleados

	END TRY
	BEGIN CATCH
		IF @@Trancount>0 
			ROLLBACK TRANSACTION CargarInsercionEmpleados;

		INSERT INTO dbo.Errores VALUES(
			ERROR_NUMBER(),
			ERROR_STATE(),
			ERROR_SEVERITY(),
			ERROR_PROCEDURE(),
			ERROR_LINE(),
			ERROR_MESSAGE(),
			GETDATE()
		)

		SET @OutResultCode = 501;				-- No se inserto en la tabla

	END CATCH

	SET NOCOUNT OFF
END
GO


