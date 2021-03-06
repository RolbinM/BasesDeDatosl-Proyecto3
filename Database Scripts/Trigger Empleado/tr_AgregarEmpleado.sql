USE [BDPlanillaObrera]
GO
/****** Object:  Trigger [dbo].[tr_AgregarEmpleado]    Script Date: 21/06/2021 10:41:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TRIGGER [dbo].[tr_AgregarEmpleado]
ON [dbo].[Empleado]
AFTER INSERT
AS 
BEGIN 
    SET NOCOUNT ON
    DECLARE @Maximo INT
    SELECT @Maximo =  MAX(Id) FROM dbo.SemanaPlanilla

    DECLARE @Fecha DATE
    SELECT @Fecha = (SELECT FechaInicio FROM dbo.SemanaPlanilla WHERE Id = @Maximo)

    INSERT INTO DeduccionXEmpleado
    (
    IdEmpleado,
    IDTipoDeduccion,
    FechaInicio, 
    Activo
    )
    SELECT 
		I.Id, 
		T.Id, 
		@Fecha, 
		1 
	FROM inserted I INNER JOIN TipoDeduccion T 
	ON T.EsObligatoria = 1


    --------------------------------------------------------------------------------------

    INSERT INTO PlanillaXMesXEmpleado
	(
		IdEmpleado,
		SalarioBruto,
		SalarioNeto,
		IdMesPlanilla
	)
    SELECT
        I.Id,
        0,
        0,
        (SELECT MAX(Id) FROM dbo.MesPlanilla)
	FROM inserted I

    INSERT INTO PlanillaXSemanaXEmpleado 
	(
		SalarioBruto,
		SalarioNeto,
		IdEmpleado,
		IdSemanaPlanilla,
		IdPlanillaXMesXEmpleado
	)
    SELECT
        0,
        0,
        I.Id,
        (SELECT MAX(Id) FROM dbo.SemanaPlanilla),
        (SELECT MAX(Id) FROM dbo.PlanillaXMesXEmpleado)
    FROM Inserted I

    SET NOCOUNT OFF
END