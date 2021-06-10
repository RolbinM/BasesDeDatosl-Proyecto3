USE [BDPlanillaObrera]
GO

/****** Object:  StoredProcedure [dbo].[ProcesarAsistencia]    Script Date: 6/10/2021 2:28:23 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[ProcesarAsistencia]

-- parametros de entrada
	@inValDocEmpleado INT,
	@inFechaEntrada DATETIME,
	@inFechaSalida DATETIME,

-- parametros de salida
	@OutResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY

		 SELECT
			@OutResultCode=0  -- codigo de ejecucion exitoso

		DECLARE @idEmp INT
		SELECT @idEmp = Id 
		FROM dbo.Empleado 
		WHERE @inValDocEmpleado = ValorDocumento

		DECLARE @horasTrabajadas INT
		SET @horasTrabajadas = DATEDIFF(MINUTE, @inFechaEntrada, @inFechaSalida)

		SET @horasTrabajadas = @horasTrabajadas / 60

		DECLARE @idSPXE INT
		SELECT @idSPXE = MAX(Id) 
		FROM dbo.PlanillaXSemanaXEmpleado 
		WHERE @idEmp = IdEmpleado
		
		DECLARE @idJornada INT

		SELECT @idJornada = IdTipoJornada
		FROM dbo.Jornada 
		WHERE @idSPXE = Id

		DECLARE @horasJornada INT
		SELECT @horasJornada = DATEDIFF(HOUR, HoraEntrada, HoraSalida) 
		FROM TipoJornada
		WHERE Id = @idJornada

		DECLARE @horasOrdinarias INT, @horasExtra INT
		DECLARE @horasExtraDobles INT = 0
		
		IF (@horasTrabajadas > @horasJornada)
		BEGIN
			SET @horasExtra = @horasTrabajadas - @horasJornada
			SET @horasOrdinarias = @horasJornada
		END
		ELSE
		BEGIN
			SET @horasExtra = 0
			SET @horasOrdinarias = @horasTrabajadas
		END

		DECLARE @diaDeLaSemana VARCHAR(10)
		SET @diaDeLaSemana = DATENAME(dw, @inFechaEntrada)
		IF (@diaDeLaSemana = 'Domingo' OR @diaDeLaSemana = 'Sunday') OR (SELECT COUNT(*) FROM Feriado WHERE Fecha = CAST(@inFechaEntrada AS DATE))>0
		BEGIN 
			SET @horasExtraDobles = @horasExtra
			SET @horasExtra = 0
		END

		INSERT INTO MarcaAsistencia (HoraEntrada, HoraSalida, IdJornada, HorasOrdinarias, HorasExtraordinarias, HorasDobles)
		VALUES (@inFechaEntrada, @inFechaSalida,@idJornada,@horasOrdinarias, @horasExtra, @horasExtraDobles)


	END TRY
	BEGIN CATCH
		Set @OutResultCode=50005; -- error de ejecucion
	END CATCH
	SET NOCOUNT OFF;
END
GO

