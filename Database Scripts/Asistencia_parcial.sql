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
		
		DECLARE @TablaDeducciones TABLE
		(	
			Id INT,
			IdEmpleado INT,
			IdTipoDeduccion INT
		)

		DECLARE @idEmp INT
		DECLARE @horasTrabajadas INT
		DECLARE @idSPXE INT
		DECLARE @idMPXE INT
		DECLARE @idJornada INT
		DECLARE @horasJornada INT
		DECLARE @horasOrdinarias INT
		DECLARE @horasExtra INT
		DECLARE @horasExtraDobles INT = 0
		DECLARE @diaDeLaSemana VARCHAR(10)
		DECLARE @SalarioxHora DECIMAL (18,3)
		DECLARE @SalarioNormal DECIMAL (18,3)
		DECLARE @SalarioExtra DECIMAL (18,3)
		DECLARE @SalarioDoble DECIMAL (18,3)
		DECLARE @diaMov DATE
		---------------------------------------------------
		DECLARE @IdUltimoMov INT
		DECLARE @IdUltimaMarca INT
		DECLARE @Count INT
		DECLARE @TotalDeduccion INT
		DECLARE @TipoObligatoria BIT
		DECLARE @TipoMovObl INT
		DECLARE @Monto DECIMAL (18,3)
		DECLARE @Porcentaje DECIMAL (18,3)
		DECLARE @SalarioBruto DECIMAL (18,3)
		DECLARE @SalarioNeto DECIMAL (18,3)

		 SELECT
			@OutResultCode=0  -- codigo de ejecucion exitoso

		
		SELECT @idEmp = Id 
		FROM dbo.Empleado 
		WHERE @inValDocEmpleado = ValorDocumento

		SELECT @idSPXE = MAX(Id) 
		FROM dbo.PlanillaXSemanaXEmpleado 
		WHERE @idEmp = IdEmpleado

		SELECT @idMPXE = MAX(IdPlanillaXMesXEmpleado) 
		FROM dbo.PlanillaXSemanaXEmpleado 
		WHERE @idEmp = IdEmpleado

		SELECT @idJornada = MAX(IdTipoJornada)
		FROM dbo.Jornada 
		WHERE @idEmp = IdEmpleado

		SELECT @SalarioxHora  = SalarioXHora
		FROM dbo.Empleado
		INNER JOIN dbo.Puesto ON dbo.Empleado.IDPuesto = dbo.Puesto.ID
		WHERE @inValDocEmpleado = ValorDocumento

		SET @horasTrabajadas = DATEDIFF(MINUTE, @inFechaEntrada, @inFechaSalida)
		SET @horasTrabajadas = @horasTrabajadas / 60

		SELECT @horasJornada = DATEDIFF(HOUR, HoraEntrada, HoraSalida) 
		FROM TipoJornada
		WHERE Id = @idJornada

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

		SET @diaDeLaSemana = DATENAME(dw, @inFechaEntrada)
		IF (@diaDeLaSemana = 'Domingo' OR @diaDeLaSemana = 'Sunday') OR (SELECT COUNT(*) FROM Feriado WHERE Fecha = CAST(@inFechaEntrada AS DATE))>0
		BEGIN 
			SET @horasExtraDobles = @horasExtra
			SET @horasExtra = 0
		END

		INSERT INTO MarcaAsistencia (HoraEntrada, HoraSalida, IdJornada, HorasOrdinarias, HorasExtraordinarias, HorasDobles)
		VALUES (@inFechaEntrada, @inFechaSalida,@idJornada,@horasOrdinarias, @horasExtra, @horasExtraDobles)

		SET @diaMov = CONVERT (DATE, @inFechaEntrada)

		IF (@horasOrdinarias > 0)
		BEGIN
			SET @SalarioNormal = @SalarioxHora * @horasOrdinarias
			INSERT INTO dbo.MovimientoPlanilla 
			VALUES 
			(
				@diaMov, 
				@SalarioNormal, 
				1, 
				@idSPXE
			)
			SELECT @IdUltimoMov = MAX(Id) FROM dbo.MovimientoPlanilla 
			SELECT @IdUltimaMarca = MAX(Id) FROM dbo.MarcaAsistencia

			INSERT INTO dbo.MovimientoGanancia
			VALUES
			(
				@IdUltimoMov,
				@IdUltimaMarca
			)
			--- Movimiento de salario horas normales
			UPDATE dbo.PlanillaXSemanaXEmpleado
			SET SalarioBruto = SalarioBruto + @SalarioNormal,
				SalarioNeto = SalarioNeto + @SalarioNormal
			WHERE dbo.PlanillaXSemanaXEmpleado.Id = @idSPXE
		END
		
		IF (@horasExtra > 0)
		BEGIN
			SET @SalarioExtra = (@SalarioxHora * @horasExtra) * 1.5
			INSERT INTO dbo.MovimientoPlanilla
			VALUES 
			(
				@diaMov, 
				@SalarioExtra, 
				2, 
				@idSPXE
			)
			SELECT @IdUltimoMov = MAX(Id) FROM dbo.MovimientoPlanilla 
			SELECT @IdUltimaMarca = MAX(Id) FROM dbo.MarcaAsistencia

			INSERT INTO dbo.MovimientoGanancia
			VALUES
			(
				@IdUltimoMov,
				@IdUltimaMarca
			)
			--- Movimiento de salario horas extra, despues de la hora
			UPDATE dbo.PlanillaXSemanaXEmpleado
			SET SalarioBruto = SalarioBruto + @SalarioExtra,
				SalarioNeto = SalarioNeto + @SalarioExtra
			WHERE dbo.PlanillaXSemanaXEmpleado.Id = @idSPXE
		END 

		IF (@horasExtraDobles > 0)
		BEGIN
			SET @SalarioDoble = (@SalarioxHora * @horasExtraDobles)*2
			INSERT INTO dbo.MovimientoPlanilla 
			VALUES 
			(
				@diaMov, 
				@SalarioDoble, 
				3, 
				@idSPXE
			)
			SELECT @IdUltimoMov = MAX(Id) FROM dbo.MovimientoPlanilla 
			SELECT @IdUltimaMarca = MAX(Id) FROM dbo.MarcaAsistencia

			INSERT INTO dbo.MovimientoGanancia
			VALUES
			(
				@IdUltimoMov,
				@IdUltimaMarca
			)
			--- Movimiento de salario horas Extra dobles, feriados
			UPDATE dbo.PlanillaXSemanaXEmpleado
			SET SalarioBruto = SalarioBruto + @SalarioDoble,
				SalarioNeto = SalarioNeto + @SalarioDoble
			WHERE dbo.PlanillaXSemanaXEmpleado.Id = @idSPXE
		END
		
		IF DATEPART(WEEKDAY, @diaMov) = 4
		BEGIN
			/*
			Aplicar deducciones, esto es, generar los movimientos respecto de las
			deducciones.
			o Acumular en las instancias de Deducciones Mensuales por empleado, las
			deducciones de la semana que termina.
			o Actualizar la instancia de planilla mensual del empleado, respecto de salario
			Bruto y TotalDeducciones.
			o Determinar si la semana que finaliza es la última del mes, si es así, crear una
			nueva instancia de la planilla mensual del empleado.
			o Crear nueva semana para Planilla semanal del empleado. 
			*/

			INSERT INTO @TablaDeducciones
				SELECT
					Deduc.Id,
					Deduc.IdEmpleado,
					Deduc.IdTipoDeduccion
				FROM dbo.DeduccionXEmpleado AS Deduc
				WHERE Deduc.FechaInicio <= @diaMov AND 
					 (Deduc.FechaFinal <> NULL OR Deduc.FechaFinal >= @diaMov) --Revisar

			SELECT @Count = COUNT(*) FROM @TablaDeducciones;
			SELECT @TotalDeduccion = 0

			WHILE @Count > 0

			SELECT @SalarioBruto  = SalarioBruto
					FROM dbo.PlanillaXSemanaXEmpleado
					WHERE dbo.PlanillaXSemanaXEmpleado.Id = @idSPXE --Revisar

			BEGIN
				SELECT @TipoObligatoria  = EsObligatoria
					FROM dbo.DeduccionXEmpleado
					INNER JOIN dbo.TipoDeduccion 
					ON dbo.DeduccionXEmpleado.IdTipoDeduccion = dbo.TipoDeduccion.ID
					WHERE dbo.DeduccionXEmpleado.IdTipoDeduccion = (SELECT TOP(1) IdTipoDeduccion FROM @TablaDeducciones)
					--- Revisar ese select-- Aca defino si es obligatoria o no

				IF (@TipoObligatoria = 1)
				BEGIN
					SELECT @Porcentaje  = Porcentaje
					FROM dbo.DeduccionXEmpleado
					INNER JOIN dbo.TipoDeduccion 
					ON dbo.DeduccionXEmpleado.IdTipoDeduccion = dbo.TipoDeduccion.ID
					INNER JOIN dbo.DeduccionObligatoriaPorcentual
					ON dbo.TipoDeduccion.ID = dbo.DeduccionObligatoriaPorcentual.Id
					WHERE dbo.DeduccionXEmpleado.IdTipoDeduccion = (SELECT TOP(1) IdTipoDeduccion FROM @TablaDeducciones)

					-- Cambiar alias a las tablas

					SET @Monto = (@SalarioBruto * @Porcentaje) * -1
					SET @TipoMovObl = 4
					
				END
				ELSE ---Defino tipo de moviento, es o no obligatorio
				BEGIN
					IF EXISTS (SELECT 1 FROM dbo.DeduccionNoObligatoriaFija 
					WHERE Id = (SELECT TOP(1) Id FROM @TablaDeducciones))

					begin
						SELECT @Porcentaje  = Monto
						FROM dbo.DeduccionXEmpleado
						INNER JOIN dbo.DeduccionNoObligatoriaFija 
						ON dbo.DeduccionXEmpleado.Id = dbo.DeduccionNoObligatoriaFija.Id
						WHERE dbo.DeduccionXEmpleado.Id = (SELECT TOP(1) Id FROM @TablaDeducciones)

						SET @Monto = (@Porcentaje) * -1
					end
					else			

					begin
						SELECT @Porcentaje  = Porcentaje
						FROM dbo.DeduccionXEmpleado
						INNER JOIN dbo.DeduccionNoObligatoriaPorcentual
						ON dbo.DeduccionXEmpleado.Id = dbo.DeduccionNoObligatoriaPorcentual.Id
						WHERE dbo.DeduccionXEmpleado.Id = (SELECT TOP(1) Id FROM @TablaDeducciones)

						SET @Monto = (@SalarioBruto * @Porcentaje) * -1

					end
					SET @TipoMovObl = 5
				END
				
				INSERT INTO dbo.MovimientoPlanilla 
				VALUES 
				(
					@diaMov, 
					@Monto, 
					@TipoMovObl, 
					@idSPXE
				)
				
				SELECT @IdUltimoMov = MAX(Id) FROM dbo.MovimientoPlanilla 
				SELECT @IdUltimaMarca = (SELECT TOP (1) Id FROM @TablaDeducciones)

				INSERT INTO dbo.MovimientoDeduccion
				VALUES
				(
					@IdUltimoMov,
					@IdUltimaMarca
				)

				UPDATE dbo.PlanillaXSemanaXEmpleado
				SET SalarioNeto = SalarioNeto + @Monto ---Monto negativo por el (*-1)
				WHERE dbo.PlanillaXSemanaXEmpleado.Id = @idSPXE

--- Deducciones en Deducciones x Mes por empleado
			
				DELETE TOP (1) FROM @TablaDeducciones
				SELECT @Count = COUNT(*) FROM @TablaDeducciones;

			END

			--- Actualizar PlanillaxMesxEmpleado con salario y salario Bruto

			SELECT @SalarioNeto = SalarioNeto
					FROM dbo.PlanillaXSemanaXEmpleado
					WHERE dbo.PlanillaXSemanaXEmpleado.Id = @idSPXE --Revisar

			UPDATE dbo.PlanillaXMesXEmpleado
			SET SalarioBruto = SalarioBruto + @SalarioBruto,
				SalarioNeto = SalarioNeto + @SalarioNeto
			WHERE dbo.PlanillaXMesXEmpleado.Id = @idMPXE

			---Formato

			-------------------------------------------------------------------------------------

			IF(DATENAME(MONTH,DATEADD(DAY,1,@diaMov)) <> DATENAME(MONTH,DATEADD(DAY,-6,@diaMov))) ---Arreglar Don Rolbin
			BEGIN
				SET @idMPXE = @idMPXE + 1
				INSERT INTO PlanillaXMesXEmpleado
				VALUES
				(
					0,
					0,
					(SELECT MAX(Id) FROM dbo.PlanillaXMesXEmpleado)
				)
			END

			SET @idSPXE = @idSPXE + 1
			INSERT INTO PlanillaXSemanaXEmpleado
			VALUES
			(
				@idSPXE,
				0,
				@idEmp,
				(SELECT MAX(Id) FROM dbo.SemanaPlanilla),
				@idMPXE
			)


		END


	END TRY
	BEGIN CATCH
		Set @OutResultCode=50005; -- error de ejecucion
	END CATCH
	SET NOCOUNT OFF;
END
GO
