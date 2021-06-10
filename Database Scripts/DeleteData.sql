USE BDPlanillaObrera

DELETE FROM MarcaAsistencia
DBCC CHECKIDENT(MarcaAsistencia,RESEED,0)

DELETE FROM Jornada
DBCC CHECKIDENT(Jornada,RESEED,0)

DELETE FROM SemanaPlanilla
DBCC CHECKIDENT(SemanaPlanilla,RESEED,0)

DELETE FROM MesPlanilla
DBCC CHECKIDENT(MesPlanilla,RESEED,0)

DELETE FROM DeduccionXEmpleado
DBCC CHECKIDENT(DeduccionXEmpleado,RESEED,0)

DELETE FROM Empleado
DBCC CHECKIDENT(Empleado,RESEED,0)

DELETE FROM Usuario
DBCC CHECKIDENT(Usuario,RESEED,0)

DELETE FROM Feriado
DBCC CHECKIDENT(Feriado,RESEED,0)

DELETE FROM dbo.DeduccionObligatoriaPorcentual
DELETE FROM dbo.TipoDeduccion
DELETE FROM dbo.TipoMovimiento
DELETE FROM dbo.TipoJornada
DELETE FROM dbo.Departamento
DELETE FROM dbo.TipoDocumentoIdentidad
DELETE FROM dbo.Puesto

DELETE FROM dbo.Errores

-- Eliminacion de Tablas Temporales
DROP TABLE ##Operaciones
DROP TABLE ##InsercionEmpleado
DROP TABLE ##EliminarEmpleados
DROP TABLE ##InsercionJornada
DROP TABLE ##InsercionMarcaAsistencia
DROP TABLE ##InsercionAsociaDeduccion
DROP TABLE ##InsercionDesasociaDeduccion