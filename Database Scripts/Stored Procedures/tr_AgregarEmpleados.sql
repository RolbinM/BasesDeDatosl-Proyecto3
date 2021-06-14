CREATE TRIGGER tr_AgregarEmpleado
ON [dbo].[Empleado]
AFTER INSERT
AS 
BEGIN 
	SET NOCOUNT ON

	DECLARE @idEmpleado INT
	SELECT @idEmpleado = Id FROM inserted

	DECLARE @Maximo INT
	SELECT @Maximo =  MAX(Id) FROM dbo.SemanaPlanilla

	DECLARE @Fecha DATE
	SELECT @Fecha = (SELECT FechaFinal FROM dbo.SemanaPlanilla WHERE Id = @Maximo)

	INSERT INTO DeduccionXEmpleado (IdEmpleado,IDTipoDeduccion,FechaInicio, Activo)
	SELECT @idEmpleado, Id, @Fecha, 1 FROM TipoDeduccion WHERE EsObligatoria=1

	--------------------------------------------------------------------------------------

	INSERT INTO PlanillaXMesXEmpleado
	VALUES
	(
		0,
		0,
		(SELECT MAX(Id) FROM dbo.MesPlanilla)
	)

	INSERT INTO PlanillaXSemanaXEmpleado 
	VALUES
	(
		0,
		0,
		@idEmpleado,
		(SELECT MAX(Id) FROM dbo.SemanaPlanilla),
		(SELECT MAX(Id) FROM dbo.PlanillaXMesXEmpleado)
	)

	SET NOCOUNT OFF
END

