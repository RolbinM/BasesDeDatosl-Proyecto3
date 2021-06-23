CREATE VIEW Rango
AS
	SELECT
		D.Nombre AS NombreDepartamento,
		AVG(PXME.SalarioBruto) AS PromedioSalarioNeto,
		SUM(PXME.SalarioBruto) - SUM(PXME.SalarioNeto) AS TotalDeducciones,
		(SELECT 
			Em.Nombre 
		FROM PlanillaXMesXEmpleado AS Pl INNER JOIN Empleado AS Em 
		ON Pl.IdEmpleado = Em.Id
		WHERE Pl.SalarioNeto = MAX(PXME.SalarioNeto)) AS IdEmpleado,
		MAX(PXME.SalarioNeto) AS Salario
	FROM PlanillaXMesXEmpleado AS PXME
	INNER JOIN Empleado AS E
	ON E.Id = PXME.IdEmpleado
	INNER JOIN Departamento AS D
	ON D.Id = E.IdDepartamento
	GROUP BY D.Nombre



