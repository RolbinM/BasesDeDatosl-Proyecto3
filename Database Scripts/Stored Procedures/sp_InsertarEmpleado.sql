USE [BDPlanillaObrera]
GO

/****** Object:  StoredProcedure [dbo].[sp_InsertarEmpleado]    Script Date: 13/06/2021 1:51:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_InsertarEmpleado]
@Nombre VARCHAR(64)
, @ValorDocumentoIdentidad VARCHAR(32)
, @FechaNacimiento DATE
, @IdPuesto INT
, @IdDepartamento INT
, @IdTipoDocumentoIdentidad INT
, @Username VARCHAR(64)
, @Contraseña VARCHAR(64)
AS
BEGIN
	SET NOCOUNT ON

	BEGIN TRY
		DECLARE @OutResultCode INT
		SET @OutResultCode = 0;

		BEGIN TRANSACTION InsertarEmpleado
			INSERT INTO dbo.Usuario
			VALUES
			(
				@Username,
				@Contraseña,
				2,
				1
			)
			
			INSERT INTO dbo.Empleado
			VALUES
			(
				@Nombre,
				@ValorDocumentoIdentidad,
				@FechaNacimiento,
				@IdPuesto,
				@IdTipoDocumentoIdentidad,
				@IdDepartamento,
				(SELECT MAX(Id) AS Id FROM dbo.Usuario),
				1
			)
				

		COMMIT TRANSACTION InsertarEmpleado

	END TRY
	BEGIN CATCH
		IF @@Trancount>0 
			ROLLBACK TRANSACTION InsertarEmpleado;

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


