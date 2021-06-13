USE [Proyecto_2]
GO

/****** Object:  Trigger [dbo].[AsociaeEmpleadosConDeducciones]    Script Date: 6/13/2021 2:05:50 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[AsociaeEmpleadosConDeducciones]
ON [dbo].[Empleado]
AFTER INSERT

AS BEGIN 
	SET NOCOUNT ON
	BEGIN TRY

		DECLARE 
			@idEmpleado INT
			SELECT @idEmpleado = valorDocIdent FROM inserted

			BEGIN TRANSACTION Asociamiento
				---INSERT INTO DeduccionXEmpleado VALUES (@idEmpleado,1,1)
				INSERT INTO DeduccionXEmpleado (IDEmpleado,IDTipoDeduccion,Activo)
				SELECT @idEmpleado, ID, '1' FROM TipoDeduccion WHERE EsObligatoria='Si'
			COMMIT TRANSACTION Asociamiento

	END TRY 

	BEGIN CATCH 
		IF (@@TRANCOUNT>0)
		BEGIN
			PRINT (@@TRANCOUNT)
			ROLLBACK TRANSACTION 
		END
	END CATCH
	SET NOCOUNT OFF
END
GO

ALTER TABLE [dbo].[Empleado] ENABLE TRIGGER [AsociaeEmpleadosConDeducciones]
GO

