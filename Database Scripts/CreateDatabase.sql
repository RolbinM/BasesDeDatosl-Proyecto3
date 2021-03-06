USE [master]
GO
/****** Object:  Database [BDPlanillaObrera]    Script Date: 6/23/2021 6:06:52 PM ******/
CREATE DATABASE [BDPlanillaObrera]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BDPlanillaObrera', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\BDPlanillaObrera.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'BDPlanillaObrera_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\BDPlanillaObrera_log.ldf' , SIZE = 401408KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [BDPlanillaObrera] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BDPlanillaObrera].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BDPlanillaObrera] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BDPlanillaObrera] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BDPlanillaObrera] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BDPlanillaObrera] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BDPlanillaObrera] SET ARITHABORT OFF 
GO
ALTER DATABASE [BDPlanillaObrera] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [BDPlanillaObrera] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BDPlanillaObrera] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BDPlanillaObrera] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BDPlanillaObrera] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BDPlanillaObrera] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BDPlanillaObrera] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BDPlanillaObrera] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BDPlanillaObrera] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BDPlanillaObrera] SET  DISABLE_BROKER 
GO
ALTER DATABASE [BDPlanillaObrera] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BDPlanillaObrera] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BDPlanillaObrera] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BDPlanillaObrera] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BDPlanillaObrera] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BDPlanillaObrera] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BDPlanillaObrera] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BDPlanillaObrera] SET RECOVERY FULL 
GO
ALTER DATABASE [BDPlanillaObrera] SET  MULTI_USER 
GO
ALTER DATABASE [BDPlanillaObrera] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BDPlanillaObrera] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BDPlanillaObrera] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BDPlanillaObrera] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [BDPlanillaObrera] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [BDPlanillaObrera] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [BDPlanillaObrera] SET QUERY_STORE = OFF
GO
USE [BDPlanillaObrera]
GO
/****** Object:  User [RolbinMendez]    Script Date: 6/23/2021 6:06:52 PM ******/
CREATE USER [RolbinMendez] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [RolbinMendez]
GO
ALTER ROLE [db_accessadmin] ADD MEMBER [RolbinMendez]
GO
ALTER ROLE [db_securityadmin] ADD MEMBER [RolbinMendez]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [RolbinMendez]
GO
ALTER ROLE [db_backupoperator] ADD MEMBER [RolbinMendez]
GO
ALTER ROLE [db_datareader] ADD MEMBER [RolbinMendez]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [RolbinMendez]
GO
ALTER ROLE [db_denydatareader] ADD MEMBER [RolbinMendez]
GO
ALTER ROLE [db_denydatawriter] ADD MEMBER [RolbinMendez]
GO
/****** Object:  UserDefinedFunction [dbo].[CalcularHorasDobles]    Script Date: 6/23/2021 6:06:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[CalcularHorasDobles]( 
	@IdPlanilla INT
)
RETURNS INT
AS
BEGIN
	DECLARE @Horas INT

	SELECT DISTINCT @Horas = SUM(MA.HorasDobles) FROM dbo.MarcaAsistencia AS MA INNER JOIN dbo.MovimientoGanancia AS MG
	ON MA.Id = MG.IdMarcaAsistencia
	INNER JOIN dbo.MovimientoPlanilla AS MP
	ON MP.Id = MG.Id
	WHERE MP.IdPlanillaXSemanaXEmpleado = @IdPlanilla

	RETURN @Horas

END
GO
/****** Object:  UserDefinedFunction [dbo].[CalcularHorasExtras]    Script Date: 6/23/2021 6:06:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[CalcularHorasExtras]( 
	@IdPlanilla INT
)
RETURNS INT
AS
BEGIN
	DECLARE @Horas INT

	SELECT DISTINCT @Horas = SUM(MA.HorasExtraordinarias) FROM dbo.MarcaAsistencia AS MA INNER JOIN dbo.MovimientoGanancia AS MG
	ON MA.Id = MG.IdMarcaAsistencia
	INNER JOIN dbo.MovimientoPlanilla AS MP
	ON MP.Id = MG.Id
	WHERE MP.IdPlanillaXSemanaXEmpleado = @IdPlanilla

	RETURN @Horas

END
GO
/****** Object:  UserDefinedFunction [dbo].[CalcularHorasOrdinarias]    Script Date: 6/23/2021 6:06:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[CalcularHorasOrdinarias]( 
	@IdPlanilla INT
)
RETURNS INT
AS
BEGIN
	DECLARE @Horas INT

	SELECT DISTINCT @Horas = SUM(MA.HorasOrdinarias) FROM dbo.MarcaAsistencia AS MA INNER JOIN dbo.MovimientoGanancia AS MG
	ON MA.Id = MG.IdMarcaAsistencia
	INNER JOIN dbo.MovimientoPlanilla AS MP
	ON MP.Id = MG.Id
	WHERE MP.IdPlanillaXSemanaXEmpleado = @IdPlanilla

	RETURN @Horas

END
GO
/****** Object:  UserDefinedFunction [dbo].[CargarAsociarEmpleados]    Script Date: 6/23/2021 6:06:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[CargarAsociarEmpleados] (@Datos XML)
RETURNS 
	@AsociarEmpleados TABLE 
	(
		ValorDocumentoIdentidad INT,
		IdDeduccion INT,
		Monto DECIMAL(18,3),
		Secuencia INT,
		ProduceError INT
	) 
AS
BEGIN
    INSERT INTO @AsociarEmpleados
		SELECT
			empleado.value('@ValorDocumentoIdentidad','INT') AS ValorDocIdentidad,
			empleado.value('@IdDeduccion','INT') AS IdDeduccion,
			empleado.value('@Monto','DECIMAL(18,3)') AS Monto,
			empleado.value('@Secuencia','INT') AS Secuencia,
			empleado.value('@ProduceError','INT') AS ProduceError
		FROM @Datos.nodes('Operacion/AsociaEmpleadoConDeduccion') AS T(empleado)
	RETURN
END
GO
/****** Object:  UserDefinedFunction [dbo].[CargarDesasociarEmpleados]    Script Date: 6/23/2021 6:06:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[CargarDesasociarEmpleados] (@Datos XML)
RETURNS 
	@DesasociarEmpleados TABLE 
	(
		ValorDocumentoIdentidad INT,
		IdDeduccion INT,
		Secuencia INT,
		ProduceError INT
	) 
AS
BEGIN
    INSERT INTO @DesasociarEmpleados
		SELECT
			empleado.value('@ValorDocumentoIdentidad','INT') AS ValorDocIdentidad,
			empleado.value('@IdDeduccion','INT') AS IdDeduccion,
			empleado.value('@Secuencia','INT') AS Secuencia,
			empleado.value('@ProduceError','INT') AS ProduceError
		FROM @Datos.nodes('Operacion/DesasociaEmpleadoConDeduccion') AS T(empleado)
	RETURN
END
GO
/****** Object:  UserDefinedFunction [dbo].[CargarEliminarEmpleados]    Script Date: 6/23/2021 6:06:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[CargarEliminarEmpleados] (@Datos XML)
RETURNS 
	@EliminarEmpleados TABLE 
	(
		ValorDocumentoIdentidad INT,
		Secuencia INT,
		ProduceError INT
	) 
AS
BEGIN
    INSERT INTO @EliminarEmpleados
		SELECT
			empleado.value('@ValorDocumentoIdentidad','INT') AS ValorDocIdentidad,
			empleado.value('@Secuencia','INT') AS Secuencia,
			empleado.value('@ProduceError','INT') AS ProduceError
		FROM @Datos.nodes('Operacion/EliminarEmpleado') AS T(empleado)
	RETURN
END
GO
/****** Object:  UserDefinedFunction [dbo].[CargarIngresarJornada]    Script Date: 6/23/2021 6:06:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[CargarIngresarJornada] (@Datos XML)
RETURNS 
	@IngresarJornada TABLE 
	(
		ValorDocumentoIdentidad INT,
		IdJornada INT,
		Secuencia INT,
		ProduceError INT
	) 
AS
BEGIN
    INSERT INTO @IngresarJornada
		SELECT
			empleado.value('@ValorDocumentoIdentidad','INT') AS ValorDocIdentidad,
			empleado.value('@IdJornada','INT') AS IdJornada,
			empleado.value('@Secuencia','INT') AS Secuencia,
			empleado.value('@ProduceError','INT') AS ProduceError
		FROM @Datos.nodes('Operacion/TipoDeJornadaProximaSemana') AS T(empleado)
	RETURN
END
GO
/****** Object:  UserDefinedFunction [dbo].[CargarInsercionEmpleados]    Script Date: 6/23/2021 6:06:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[CargarInsercionEmpleados] (@Datos XML)
RETURNS 
	@InsercionEmpleados TABLE 
	(
		Fecha DATE,
		Nombre VARCHAR(64),
		ValorDocumentoIdentidad INT,
		FechaNacimiento DATE,
		IdPuesto INT,
		IdTipoDocumentoIdentidad INT,
		IdDepartamento INT,
		Username VARCHAR(64),
		Pwd VARCHAR(64),
		Secuencia INT,
		ProduceError INT
	) 
AS
BEGIN
    INSERT INTO @InsercionEmpleados
		SELECT
			CAST(empleado.value('../@Fecha','VARCHAR(64)') AS DATE) AS Fecha,
			empleado.value('@Nombre','VARCHAR(64)') AS Nombre,
			empleado.value('@ValorDocumentoIdentidad','INT') AS ValorDocIdentidad,
			CAST(empleado.value('@FechaNacimiento','VARCHAR(32)') AS DATE) AS FechaNacimiento,
			empleado.value('@idPuesto','INT') AS IdPuesto,
			empleado.value('@idTipoDocumentacionIdentidad','INT') AS IdTipoDocumento,
			empleado.value('@idDepartamento','INT') AS IdDepartamento,
			empleado.value('@Username','VARCHAR(64)') AS Username,
			empleado.value('@Password','VARCHAR(64)') AS Pwd,
			empleado.value('@Secuencia','INT') AS Secuencia,
			empleado.value('@ProduceError','INT') AS ProduceError
		FROM @Datos.nodes('Operacion/NuevoEmpleado') AS T(empleado)
	RETURN 
END
GO
/****** Object:  UserDefinedFunction [dbo].[CargarInsercionMarca]    Script Date: 6/23/2021 6:06:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[CargarInsercionMarca] (@Datos XML)
RETURNS 
	@InsercionMarcas TABLE 
	(
		ValorDocumentoIdentidad INT,
		FechaEntrada DATETIME2,
		FechaSalida DATETIME2,
		Secuencia INT,
		ProduceError INT
	) 
AS
BEGIN
    INSERT INTO @InsercionMarcas
		SELECT
			empleado.value('@ValorDocumentoIdentidad','INT') AS ValorDocIdentidad,
			empleado.value('@FechaEntrada','DATETIME2') AS FechaEntrada,
			empleado.value('@FechaSalida','DATETIME2') AS FechaSalida,
			empleado.value('@Secuencia','INT') AS Secuencia,
			empleado.value('@ProduceError','INT') AS ProduceError
		FROM @Datos.nodes('Operacion/MarcaDeAsistencia') AS T(empleado)
	RETURN
END
GO
/****** Object:  Table [dbo].[PlanillaXMesXEmpleado]    Script Date: 6/23/2021 6:06:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlanillaXMesXEmpleado](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdEmpleado] [int] NOT NULL,
	[SalarioBruto] [decimal](18, 3) NOT NULL,
	[SalarioNeto] [decimal](18, 3) NOT NULL,
	[IdMesPlanilla] [int] NOT NULL,
 CONSTRAINT [PK_PlanillaXMesXEmpleado] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Departamento]    Script Date: 6/23/2021 6:06:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Departamento](
	[Id] [int] NOT NULL,
	[Nombre] [varchar](64) NOT NULL,
	[Activo] [bit] NOT NULL,
 CONSTRAINT [PK_Departamentos] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Empleado]    Script Date: 6/23/2021 6:06:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Empleado](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](64) NOT NULL,
	[ValorDocumento] [int] NOT NULL,
	[FechaNacimiento] [date] NOT NULL,
	[IdPuesto] [int] NOT NULL,
	[IdTipoDocumento] [int] NOT NULL,
	[IdDepartamento] [int] NOT NULL,
	[IdUsuario] [int] NOT NULL,
	[Activo] [bit] NOT NULL,
 CONSTRAINT [PK_Empleado] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Rango]    Script Date: 6/23/2021 6:06:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Rango]
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

GO
/****** Object:  Table [dbo].[Bitacora]    Script Date: 6/23/2021 6:06:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bitacora](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](128) NOT NULL,
	[Fecha] [date] NOT NULL,
 CONSTRAINT [PK_Bitacora] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Corrida]    Script Date: 6/23/2021 6:06:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Corrida](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FechaOperacion] [date] NOT NULL,
	[TipoRegistro] [int] NOT NULL,
	[PostTime] [date] NOT NULL,
 CONSTRAINT [PK_Corrida] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DeduccionNoObligatoriaFija]    Script Date: 6/23/2021 6:06:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DeduccionNoObligatoriaFija](
	[Id] [int] NOT NULL,
	[Monto] [decimal](18, 3) NOT NULL,
 CONSTRAINT [PK_DeduccionNoObligatoriaFija] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DeduccionNoObligatoriaPorcentual]    Script Date: 6/23/2021 6:06:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DeduccionNoObligatoriaPorcentual](
	[Id] [int] NOT NULL,
	[Porcentaje] [decimal](18, 3) NOT NULL,
 CONSTRAINT [PK_DeduccionNoObligatoriaPorcentual] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DeduccionObligatoriaPorcentual]    Script Date: 6/23/2021 6:06:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DeduccionObligatoriaPorcentual](
	[Id] [int] NOT NULL,
	[Porcentaje] [decimal](18, 3) NOT NULL,
 CONSTRAINT [PK_DeduccionObligatoriaPorcentual] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DeduccionXEmpleado]    Script Date: 6/23/2021 6:06:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DeduccionXEmpleado](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdEmpleado] [int] NOT NULL,
	[IdTipoDeduccion] [int] NOT NULL,
	[FechaInicio] [date] NULL,
	[FechaFinal] [date] NULL,
	[Activo] [bit] NULL,
 CONSTRAINT [PK_DeduccionXEmpleado] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DeduccionXMesXEmpleado]    Script Date: 6/23/2021 6:06:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DeduccionXMesXEmpleado](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TotalDeduccion] [decimal](18, 3) NOT NULL,
	[IdPlanillaXMesXEmpleado] [int] NOT NULL,
	[IdTipoDeduccion] [int] NOT NULL,
 CONSTRAINT [PK_DeduccionXMesXEmpleado] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DetalleCorrida]    Script Date: 6/23/2021 6:06:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DetalleCorrida](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdCorrida] [int] NOT NULL,
	[TipoOperacion] [int] NOT NULL,
	[RefId] [int] NOT NULL,
 CONSTRAINT [PK_DetalleCorrida] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Errores]    Script Date: 6/23/2021 6:06:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Errores](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ErrorNumber] [int] NULL,
	[ErrorState] [int] NULL,
	[ErrorSeverity] [int] NULL,
	[ErrorProcedure] [varchar](max) NULL,
	[ErrorLine] [int] NULL,
	[ErrorMessage] [varchar](max) NULL,
	[ErrorDate] [datetime] NULL,
 CONSTRAINT [PK_Errores] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Feriado]    Script Date: 6/23/2021 6:06:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Feriado](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](64) NOT NULL,
	[Fecha] [date] NOT NULL,
	[Activo] [bit] NOT NULL,
 CONSTRAINT [PK_Feriado] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Historial]    Script Date: 6/23/2021 6:06:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Historial](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Fecha] [date] NULL,
	[Operacion] [varchar](64) NULL,
	[DescripcionA] [varchar](256) NULL,
	[DescripcionB] [varchar](256) NULL,
 CONSTRAINT [PK_Historial] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Jornada]    Script Date: 6/23/2021 6:06:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Jornada](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdEmpleado] [int] NOT NULL,
	[IdTipoJornada] [int] NOT NULL,
	[IdSemanaPlanilla] [int] NOT NULL,
 CONSTRAINT [PK_Jornada] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MarcaAsistencia]    Script Date: 6/23/2021 6:06:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MarcaAsistencia](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[HoraEntrada] [datetime] NULL,
	[HoraSalida] [datetime] NULL,
	[IdJornada] [int] NOT NULL,
	[IdEmpleado] [int] NOT NULL,
	[HorasOrdinarias] [int] NOT NULL,
	[HorasExtraordinarias] [int] NOT NULL,
	[HorasDobles] [int] NOT NULL,
 CONSTRAINT [PK_MarcaAsistencia] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MesPlanilla]    Script Date: 6/23/2021 6:06:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MesPlanilla](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FechaInicio] [date] NOT NULL,
	[FechaFin] [date] NULL,
 CONSTRAINT [PK_MesPlanilla] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MovimientoDeduccion]    Script Date: 6/23/2021 6:06:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MovimientoDeduccion](
	[Id] [int] NOT NULL,
	[IdDeduccionXEmpleado] [int] NOT NULL,
 CONSTRAINT [PK_MovimientoDeduccion] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MovimientoGanancia]    Script Date: 6/23/2021 6:06:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MovimientoGanancia](
	[Id] [int] NOT NULL,
	[IdMarcaAsistencia] [int] NOT NULL,
 CONSTRAINT [PK_MovimientoGanancia] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MovimientoPlanilla]    Script Date: 6/23/2021 6:06:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MovimientoPlanilla](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Fecha] [date] NOT NULL,
	[Monto] [decimal](18, 3) NOT NULL,
	[IdTipoMovimientoPlanilla] [int] NOT NULL,
	[IdPlanillaXSemanaXEmpleado] [int] NOT NULL,
 CONSTRAINT [PK_MovimientoPlanilla] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PlanillaXSemanaXEmpleado]    Script Date: 6/23/2021 6:06:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlanillaXSemanaXEmpleado](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SalarioBruto] [decimal](18, 3) NOT NULL,
	[SalarioNeto] [decimal](18, 3) NOT NULL,
	[IdEmpleado] [int] NOT NULL,
	[IdSemanaPlanilla] [int] NOT NULL,
	[IdPlanillaXMesXEmpleado] [int] NOT NULL,
 CONSTRAINT [PK_PlanillaXSemanaXEmpleado] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Puesto]    Script Date: 6/23/2021 6:06:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Puesto](
	[Id] [int] NOT NULL,
	[Nombre] [varchar](64) NOT NULL,
	[SalarioXHora] [decimal](18, 3) NOT NULL,
	[Activo] [bit] NOT NULL,
 CONSTRAINT [PK_Puestos] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SemanaPlanilla]    Script Date: 6/23/2021 6:06:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SemanaPlanilla](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FechaInicio] [date] NOT NULL,
	[FechaFinal] [date] NOT NULL,
	[IdMesPlanilla] [int] NOT NULL,
 CONSTRAINT [PK_SemanaPlanilla] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TipoDeduccion]    Script Date: 6/23/2021 6:06:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoDeduccion](
	[Id] [int] NOT NULL,
	[Nombre] [varchar](64) NOT NULL,
	[EsObligatoria] [bit] NOT NULL,
	[EsPorcentual] [bit] NOT NULL,
 CONSTRAINT [PK_TipoDeduccion] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TipoDocumentoIdentidad]    Script Date: 6/23/2021 6:06:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoDocumentoIdentidad](
	[Id] [int] NOT NULL,
	[Nombre] [varchar](64) NOT NULL,
	[Activo] [bit] NOT NULL,
 CONSTRAINT [PK_TiposDocumentoIdentidad] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TipoJornada]    Script Date: 6/23/2021 6:06:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoJornada](
	[Id] [int] NOT NULL,
	[Nombre] [varchar](64) NOT NULL,
	[HoraEntrada] [time](0) NOT NULL,
	[HoraSalida] [time](0) NOT NULL,
	[Activo] [bit] NOT NULL,
 CONSTRAINT [PK_TiposJornada] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TipoMovimiento]    Script Date: 6/23/2021 6:06:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoMovimiento](
	[Id] [int] NOT NULL,
	[Nombre] [varchar](64) NOT NULL,
 CONSTRAINT [PK_TipoMovimiento] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 6/23/2021 6:06:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuario](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](64) NOT NULL,
	[Pwd] [varchar](64) NOT NULL,
	[Tipo] [int] NOT NULL,
	[Activo] [bit] NOT NULL,
 CONSTRAINT [PK_Usuario] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DeduccionNoObligatoriaFija]  WITH CHECK ADD  CONSTRAINT [FK_DeduccionNoObligatoriaFija_DeduccionXEmpleado] FOREIGN KEY([Id])
REFERENCES [dbo].[DeduccionXEmpleado] ([Id])
GO
ALTER TABLE [dbo].[DeduccionNoObligatoriaFija] CHECK CONSTRAINT [FK_DeduccionNoObligatoriaFija_DeduccionXEmpleado]
GO
ALTER TABLE [dbo].[DeduccionNoObligatoriaPorcentual]  WITH CHECK ADD  CONSTRAINT [FK_DeduccionNoObligatoriaPorcentual_DeduccionXEmpleado] FOREIGN KEY([Id])
REFERENCES [dbo].[DeduccionXEmpleado] ([Id])
GO
ALTER TABLE [dbo].[DeduccionNoObligatoriaPorcentual] CHECK CONSTRAINT [FK_DeduccionNoObligatoriaPorcentual_DeduccionXEmpleado]
GO
ALTER TABLE [dbo].[DeduccionObligatoriaPorcentual]  WITH CHECK ADD  CONSTRAINT [FK_DeduccionObligatoriaPorcentual_TipoDeduccion] FOREIGN KEY([Id])
REFERENCES [dbo].[TipoDeduccion] ([Id])
GO
ALTER TABLE [dbo].[DeduccionObligatoriaPorcentual] CHECK CONSTRAINT [FK_DeduccionObligatoriaPorcentual_TipoDeduccion]
GO
ALTER TABLE [dbo].[DeduccionXEmpleado]  WITH CHECK ADD  CONSTRAINT [FK_DeduccionXEmpleado_Empleado] FOREIGN KEY([IdEmpleado])
REFERENCES [dbo].[Empleado] ([Id])
GO
ALTER TABLE [dbo].[DeduccionXEmpleado] CHECK CONSTRAINT [FK_DeduccionXEmpleado_Empleado]
GO
ALTER TABLE [dbo].[DeduccionXEmpleado]  WITH CHECK ADD  CONSTRAINT [FK_DeduccionXEmpleado_TipoDeduccion] FOREIGN KEY([IdTipoDeduccion])
REFERENCES [dbo].[TipoDeduccion] ([Id])
GO
ALTER TABLE [dbo].[DeduccionXEmpleado] CHECK CONSTRAINT [FK_DeduccionXEmpleado_TipoDeduccion]
GO
ALTER TABLE [dbo].[DeduccionXMesXEmpleado]  WITH CHECK ADD  CONSTRAINT [FK_DeduccionXMesXEmpleado_PlanillaXMesXEmpleado] FOREIGN KEY([IdPlanillaXMesXEmpleado])
REFERENCES [dbo].[PlanillaXMesXEmpleado] ([Id])
GO
ALTER TABLE [dbo].[DeduccionXMesXEmpleado] CHECK CONSTRAINT [FK_DeduccionXMesXEmpleado_PlanillaXMesXEmpleado]
GO
ALTER TABLE [dbo].[DeduccionXMesXEmpleado]  WITH CHECK ADD  CONSTRAINT [FK_DeduccionXMesXEmpleado_TipoDeduccion] FOREIGN KEY([IdTipoDeduccion])
REFERENCES [dbo].[TipoDeduccion] ([Id])
GO
ALTER TABLE [dbo].[DeduccionXMesXEmpleado] CHECK CONSTRAINT [FK_DeduccionXMesXEmpleado_TipoDeduccion]
GO
ALTER TABLE [dbo].[DetalleCorrida]  WITH CHECK ADD  CONSTRAINT [FK_DetalleCorrida_Corrida] FOREIGN KEY([IdCorrida])
REFERENCES [dbo].[Corrida] ([Id])
GO
ALTER TABLE [dbo].[DetalleCorrida] CHECK CONSTRAINT [FK_DetalleCorrida_Corrida]
GO
ALTER TABLE [dbo].[Empleado]  WITH CHECK ADD  CONSTRAINT [FK_Empleado_Departamento] FOREIGN KEY([IdDepartamento])
REFERENCES [dbo].[Departamento] ([Id])
GO
ALTER TABLE [dbo].[Empleado] CHECK CONSTRAINT [FK_Empleado_Departamento]
GO
ALTER TABLE [dbo].[Empleado]  WITH CHECK ADD  CONSTRAINT [FK_Empleado_Puesto] FOREIGN KEY([IdPuesto])
REFERENCES [dbo].[Puesto] ([Id])
GO
ALTER TABLE [dbo].[Empleado] CHECK CONSTRAINT [FK_Empleado_Puesto]
GO
ALTER TABLE [dbo].[Empleado]  WITH CHECK ADD  CONSTRAINT [FK_Empleado_TipoDocumentoIdentidad] FOREIGN KEY([IdTipoDocumento])
REFERENCES [dbo].[TipoDocumentoIdentidad] ([Id])
GO
ALTER TABLE [dbo].[Empleado] CHECK CONSTRAINT [FK_Empleado_TipoDocumentoIdentidad]
GO
ALTER TABLE [dbo].[Empleado]  WITH CHECK ADD  CONSTRAINT [FK_Empleado_Usuario] FOREIGN KEY([IdUsuario])
REFERENCES [dbo].[Usuario] ([Id])
GO
ALTER TABLE [dbo].[Empleado] CHECK CONSTRAINT [FK_Empleado_Usuario]
GO
ALTER TABLE [dbo].[Jornada]  WITH CHECK ADD  CONSTRAINT [FK_Jornada_Empleado] FOREIGN KEY([IdEmpleado])
REFERENCES [dbo].[Empleado] ([Id])
GO
ALTER TABLE [dbo].[Jornada] CHECK CONSTRAINT [FK_Jornada_Empleado]
GO
ALTER TABLE [dbo].[Jornada]  WITH CHECK ADD  CONSTRAINT [FK_Jornada_SemanaPlanilla1] FOREIGN KEY([IdSemanaPlanilla])
REFERENCES [dbo].[SemanaPlanilla] ([Id])
GO
ALTER TABLE [dbo].[Jornada] CHECK CONSTRAINT [FK_Jornada_SemanaPlanilla1]
GO
ALTER TABLE [dbo].[Jornada]  WITH CHECK ADD  CONSTRAINT [FK_Jornada_TipoJornada] FOREIGN KEY([IdTipoJornada])
REFERENCES [dbo].[TipoJornada] ([Id])
GO
ALTER TABLE [dbo].[Jornada] CHECK CONSTRAINT [FK_Jornada_TipoJornada]
GO
ALTER TABLE [dbo].[MarcaAsistencia]  WITH CHECK ADD  CONSTRAINT [FK_MarcaAsistencia_Empleado] FOREIGN KEY([IdEmpleado])
REFERENCES [dbo].[Empleado] ([Id])
GO
ALTER TABLE [dbo].[MarcaAsistencia] CHECK CONSTRAINT [FK_MarcaAsistencia_Empleado]
GO
ALTER TABLE [dbo].[MarcaAsistencia]  WITH CHECK ADD  CONSTRAINT [FK_MarcaAsistencia_Jornada] FOREIGN KEY([IdJornada])
REFERENCES [dbo].[Jornada] ([Id])
GO
ALTER TABLE [dbo].[MarcaAsistencia] CHECK CONSTRAINT [FK_MarcaAsistencia_Jornada]
GO
ALTER TABLE [dbo].[MovimientoDeduccion]  WITH CHECK ADD  CONSTRAINT [FK_MovimientoDeduccion_DeduccionXEmpleado] FOREIGN KEY([IdDeduccionXEmpleado])
REFERENCES [dbo].[DeduccionXEmpleado] ([Id])
GO
ALTER TABLE [dbo].[MovimientoDeduccion] CHECK CONSTRAINT [FK_MovimientoDeduccion_DeduccionXEmpleado]
GO
ALTER TABLE [dbo].[MovimientoDeduccion]  WITH CHECK ADD  CONSTRAINT [FK_MovimientoDeduccion_MovimientoPlanilla] FOREIGN KEY([Id])
REFERENCES [dbo].[MovimientoPlanilla] ([Id])
GO
ALTER TABLE [dbo].[MovimientoDeduccion] CHECK CONSTRAINT [FK_MovimientoDeduccion_MovimientoPlanilla]
GO
ALTER TABLE [dbo].[MovimientoGanancia]  WITH CHECK ADD  CONSTRAINT [FK_MovimientoGanancia_MarcaAsistencia] FOREIGN KEY([IdMarcaAsistencia])
REFERENCES [dbo].[MarcaAsistencia] ([Id])
GO
ALTER TABLE [dbo].[MovimientoGanancia] CHECK CONSTRAINT [FK_MovimientoGanancia_MarcaAsistencia]
GO
ALTER TABLE [dbo].[MovimientoGanancia]  WITH CHECK ADD  CONSTRAINT [FK_MovimientoGanancia_MovimientoPlanilla] FOREIGN KEY([Id])
REFERENCES [dbo].[MovimientoPlanilla] ([Id])
GO
ALTER TABLE [dbo].[MovimientoGanancia] CHECK CONSTRAINT [FK_MovimientoGanancia_MovimientoPlanilla]
GO
ALTER TABLE [dbo].[MovimientoPlanilla]  WITH CHECK ADD  CONSTRAINT [FK_MovimientoPlanilla_PlanillaXSemanaXEmpleado] FOREIGN KEY([IdPlanillaXSemanaXEmpleado])
REFERENCES [dbo].[PlanillaXSemanaXEmpleado] ([Id])
GO
ALTER TABLE [dbo].[MovimientoPlanilla] CHECK CONSTRAINT [FK_MovimientoPlanilla_PlanillaXSemanaXEmpleado]
GO
ALTER TABLE [dbo].[MovimientoPlanilla]  WITH CHECK ADD  CONSTRAINT [FK_MovimientoPlanilla_TipoMovimiento] FOREIGN KEY([IdTipoMovimientoPlanilla])
REFERENCES [dbo].[TipoMovimiento] ([Id])
GO
ALTER TABLE [dbo].[MovimientoPlanilla] CHECK CONSTRAINT [FK_MovimientoPlanilla_TipoMovimiento]
GO
ALTER TABLE [dbo].[PlanillaXMesXEmpleado]  WITH CHECK ADD  CONSTRAINT [FK_PlanillaXMesXEmpleado_Empleado] FOREIGN KEY([IdEmpleado])
REFERENCES [dbo].[Empleado] ([Id])
GO
ALTER TABLE [dbo].[PlanillaXMesXEmpleado] CHECK CONSTRAINT [FK_PlanillaXMesXEmpleado_Empleado]
GO
ALTER TABLE [dbo].[PlanillaXMesXEmpleado]  WITH CHECK ADD  CONSTRAINT [FK_PlanillaXMesXEmpleado_MesPlanilla] FOREIGN KEY([IdMesPlanilla])
REFERENCES [dbo].[MesPlanilla] ([Id])
GO
ALTER TABLE [dbo].[PlanillaXMesXEmpleado] CHECK CONSTRAINT [FK_PlanillaXMesXEmpleado_MesPlanilla]
GO
ALTER TABLE [dbo].[PlanillaXSemanaXEmpleado]  WITH CHECK ADD  CONSTRAINT [FK_PlanillaXSemanaXEmpleado_Empleado] FOREIGN KEY([IdEmpleado])
REFERENCES [dbo].[Empleado] ([Id])
GO
ALTER TABLE [dbo].[PlanillaXSemanaXEmpleado] CHECK CONSTRAINT [FK_PlanillaXSemanaXEmpleado_Empleado]
GO
ALTER TABLE [dbo].[PlanillaXSemanaXEmpleado]  WITH CHECK ADD  CONSTRAINT [FK_PlanillaXSemanaXEmpleado_PlanillaXMesXEmpleado] FOREIGN KEY([IdPlanillaXMesXEmpleado])
REFERENCES [dbo].[PlanillaXMesXEmpleado] ([Id])
GO
ALTER TABLE [dbo].[PlanillaXSemanaXEmpleado] CHECK CONSTRAINT [FK_PlanillaXSemanaXEmpleado_PlanillaXMesXEmpleado]
GO
ALTER TABLE [dbo].[PlanillaXSemanaXEmpleado]  WITH CHECK ADD  CONSTRAINT [FK_PlanillaXSemanaXEmpleado_SemanaPlanilla1] FOREIGN KEY([IdSemanaPlanilla])
REFERENCES [dbo].[SemanaPlanilla] ([Id])
GO
ALTER TABLE [dbo].[PlanillaXSemanaXEmpleado] CHECK CONSTRAINT [FK_PlanillaXSemanaXEmpleado_SemanaPlanilla1]
GO
ALTER TABLE [dbo].[SemanaPlanilla]  WITH CHECK ADD  CONSTRAINT [FK_SemanaPlanilla_MesPlanilla] FOREIGN KEY([IdMesPlanilla])
REFERENCES [dbo].[MesPlanilla] ([Id])
GO
ALTER TABLE [dbo].[SemanaPlanilla] CHECK CONSTRAINT [FK_SemanaPlanilla_MesPlanilla]
GO
/****** Object:  StoredProcedure [dbo].[sp_AsociarDeduccion]    Script Date: 6/23/2021 6:06:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_AsociarDeduccion]
@FechaOperacion DATE,
@ValorDocumentoIdentidad INT,
@IdDeduccion INT,
@Monto DECIMAL(18,3)
AS
BEGIN
	SET NOCOUNT ON

	BEGIN TRY
		DECLARE @OutResultCode INT
		SET @OutResultCode = 0;

		DECLARE @idEmpleado INT
		DECLARE @Maximo INT
		DECLARE @Fecha DATE
		DECLARE @IdUltimaDeduccion INT

		BEGIN TRANSACTION AsociaDeduccion
			SELECT @idEmpleado = (SELECT Id FROM dbo.Empleado WHERE ValorDocumento = @ValorDocumentoIdentidad)
			SELECT @Maximo =  MAX(Id) FROM dbo.SemanaPlanilla
			
			IF DATEPART(WEEKDAY, @FechaOperacion) = 4
				SELECT @Fecha = (SELECT FechaInicio FROM dbo.SemanaPlanilla WHERE Id = @Maximo)

			ELSE
				SELECT @Fecha = (SELECT DATEADD(DAY, 1 , (SELECT FechaFinal FROM dbo.SemanaPlanilla WHERE Id = @Maximo)))


			INSERT INTO DeduccionXEmpleado 
			VALUES(@idEmpleado, @IdDeduccion, @Fecha, NULL, 1)

			SELECT @IdUltimaDeduccion = MAX(Id) FROM dbo.DeduccionXEmpleado WHERE IdEmpleado = @idEmpleado

			IF(SELECT EsPorcentual FROM dbo.TipoDeduccion WHERE Id = @IdDeduccion) = 1
			BEGIN
				INSERT INTO DeduccionNoObligatoriaPorcentual
				VALUES(@IdUltimaDeduccion, @Monto)
			END
			ELSE
			BEGIN 
				INSERT INTO DeduccionNoObligatoriaFija
				VALUES(@IdUltimaDeduccion, @Monto)
			END
			
			INSERT INTO Historial (
				Fecha,
				Operacion,
				DescripcionA,
				DescripcionB
			)
			SELECT
				@FechaOperacion,
				'Asociacion de Deduccion',
				'Id: ' + CONVERT(varchar(10), DE.Id) + 
				' Id Empleado: ' + CONVERT(varchar(10), DE.IdEmpleado) +
				' Id Tipo de Deduccion: ' + CONVERT(varchar(10), DE.IdTipoDeduccion) +
				' Nombre Deduccion: ' + TP.Nombre +
				' Es Obligatoria: ' + CONVERT(varchar(1), TP.EsObligatoria) +
				' Es Porcentual: ' + CONVERT(varchar(1), TP.EsPorcentual),
				NULL
			FROM dbo.DeduccionXEmpleado AS DE
			INNER JOIN dbo.TipoDeduccion AS TP
			ON DE.IdTipoDeduccion = TP.Id
			WHERE DE.Id = (SELECT MAX(Id) FROM DeduccionXEmpleado)

		COMMIT TRANSACTION AsociaDeduccion

	END TRY
	BEGIN CATCH
		IF @@Trancount>0 
			ROLLBACK TRANSACTION AsociaDeduccion;

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
/****** Object:  StoredProcedure [dbo].[sp_AsociarNuevaDeduccion]    Script Date: 6/23/2021 6:06:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_AsociarNuevaDeduccion]
	-- Parametros de entrada
	@IdEmpleado INT,
	@IdDeduccion INT,
	@Monto DECIMAL(18,3),

	-- Parametros de salida
	@OutResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		SET @OutResultCode = 0
		
		DECLARE @Fecha DATE
		DECLARE @IdUltimaDeduccion INT

		IF NOT EXISTS (SELECT 1 FROM dbo.TipoDeduccion WHERE Id = @IdDeduccion)
		BEGIN
			SET @OutResultCode = 5001			-- Error por si no encuentra el empleado
			RETURN
		END

		BEGIN TRANSACTION AsociaDeduccion
			IF DATEPART(WEEKDAY, GETDATE()) = 4
				SELECT @Fecha = (SELECT DATEADD(DAY, 1 , GETDATE()))

			ELSE
				SELECT @Fecha = (SELECT DATEADD(DAY, 2 , GETDATE()))

			INSERT INTO DeduccionXEmpleado 
			VALUES(@idEmpleado, @IdDeduccion, @Fecha, NULL, 1)

			SELECT @IdUltimaDeduccion = MAX(Id) FROM dbo.DeduccionXEmpleado WHERE IdEmpleado = @idEmpleado

			IF(SELECT EsPorcentual FROM dbo.TipoDeduccion WHERE Id = @IdDeduccion) = 1
			BEGIN
				INSERT INTO DeduccionNoObligatoriaPorcentual
				VALUES(@IdUltimaDeduccion, @Monto)
			END
			ELSE
			BEGIN 
				INSERT INTO DeduccionNoObligatoriaFija
				VALUES(@IdUltimaDeduccion, @Monto)
			END

			INSERT INTO Historial (
				Fecha,
				Operacion,
				DescripcionA,
				DescripcionB
			)
			SELECT
				GETDATE(),
				'Asociacion de Deduccion',
				'Id: ' + CONVERT(varchar(10), DE.Id) + 
				' Id Empleado: ' + CONVERT(varchar(10), DE.IdEmpleado) +
				' Id Tipo de Deduccion: ' + CONVERT(varchar(10), DE.IdTipoDeduccion) +
				' Nombre Deduccion: ' + TP.Nombre +
				' Es Obligatoria: ' + CONVERT(varchar(1), TP.EsObligatoria) +
				' Es Porcentual: ' + CONVERT(varchar(1), TP.EsPorcentual),
				NULL
			FROM dbo.DeduccionXEmpleado AS DE
			INNER JOIN dbo.TipoDeduccion AS TP
			ON DE.IdTipoDeduccion = TP.Id
			WHERE DE.Id = (SELECT MAX(Id) FROM DeduccionXEmpleado)
				
		COMMIT TRANSACTION AsociaDeduccion

	END TRY
	BEGIN CATCH
		IF @@Trancount>0 
			ROLLBACK TRANSACTION AsociaDeduccion;



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
/****** Object:  StoredProcedure [dbo].[sp_CargarCatalogos]    Script Date: 6/23/2021 6:06:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_CargarCatalogos]
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @catalogo xml
	SELECT @catalogo = CAST(MY_XML AS xml)
	FROM OPENROWSET(BULK 'C:\Datos_Tarea3.xml', SINGLE_BLOB) AS T(MY_XML)

	INSERT INTO dbo.Puesto (Id, Nombre, SalarioXHora, Activo)
	SELECT	ID			 = T.Item.value('@Id', 'int'),
			nombre_P	 = T.Item.value('@Nombre', 'varchar(64)'),
			salarioXhora = T.Item.value('@SalarioXHora', 'decimal(18,3)'),
			Activo = 1
	FROM   @catalogo.nodes('Datos/Catalogos/Puestos/Puesto') AS T(Item)

	INSERT INTO dbo.Departamento(Id, Nombre, Activo)
	SELECT	ID				= T.Item.value('@Id', 'int'),
			nombre_Dpt			= T.Item.value('@Nombre', 'nvarchar(64)'),
			Activo = 1
	FROM   @catalogo.nodes('Datos/Catalogos/Departamentos/Departamento') AS T(Item)

	INSERT INTO dbo.TipoDocumentoIdentidad(Id, Nombre, Activo)
	SELECT	ID				= T.Item.value('@Id', 'int'),
			nombre_Doc			= T.Item.value('@Nombre', 'varchar(64)'),
			Activo = 1
	FROM   @catalogo.nodes('Datos/Catalogos/Tipos_de_Documento_de_Identificacion/TipoIdDoc') AS T(Item)

	INSERT INTO dbo.TipoJornada(ID, Nombre, HoraEntrada, HoraSalida, Activo)
	SELECT	ID					= T.Item.value('@Id', 'int'),
			Nombre				= T.Item.value('@Nombre', 'varchar(64)'),
			HoraInicio			= T.Item.value('@HoraEntrada', 'time'),
			HoraFin				= T.Item.value('@HoraSalida', 'time'),
			Activo = 1
	FROM   @catalogo.nodes('Datos/Catalogos/TiposDeJornada/TipoDeJornada') AS T(Item)

	INSERT INTO dbo.TipoMovimiento(Id, Nombre)
	SELECT	ID				= T.Item.value('@Id', 'int'),
			Nombre			= T.Item.value('@Nombre', 'varchar(64)')
	FROM   @catalogo.nodes('Datos/Catalogos/TiposDeMovimiento/TipoDeMovimiento') AS T(Item)

	INSERT INTO dbo.Feriado(Nombre, Fecha, Activo)
	SELECT	Nombre			= T.Item.value('@Nombre', 'varchar(64)'),
			Fecha			= T.Item.value('@Fecha', 'date'),
			Activo			= 1
	FROM   @catalogo.nodes('Datos/Catalogos/Feriados/Feriado') AS T(Item)

	EXEC sp_CargarTipoDeduccion

	INSERT INTO Usuario(Username, Pwd, Tipo, Activo)
	SELECT	nombre		= T.Item.value('@username', 'varchar(64)'),
			contrasena	= T.Item.value('@pwd', 'varchar(64)'),
			tipo		= T.Item.value('@tipo', 'nchar(10)'),
			activo = 1
	FROM   @catalogo.nodes('Datos/Usuarios/Usuario') AS T(Item)

	SET NOCOUNT OFF
END
GO
/****** Object:  StoredProcedure [dbo].[sp_CargarTipoDeduccion]    Script Date: 6/23/2021 6:06:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_CargarTipoDeduccion]
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @count INT;						-- Contador para recorrer la tabla temporal

	CREATE TABLE #TiposDeduccion(			-- Tabla temporal
		Id INT, 
		Nombre VARCHAR(64),
		Obligatorio VARCHAR(2),
		Porcentual VARCHAR(2),
		Valor DECIMAL(18, 3)
	);
	
	INSERT INTO #TiposDeduccion
		SELECT
			tipDeduccion.value('@Id','INT') AS Id,
			tipDeduccion.value('@Nombre','VARCHAR(64)') AS Nombre,
			tipDeduccion.value('@Obligatorio','VARCHAR(2)') AS EsObligatorio,
			tipDeduccion.value('@Porcentual','VARCHAR(2)') AS EsPorcentual,
			tipDeduccion.value('@Valor','DECIMAL(18, 3)') AS Valor
		FROM
		(
			SELECT CAST(c AS XML) FROM
			OPENROWSET(
				BULK 'C:\Datos_Tarea3.xml',
				SINGLE_BLOB
			) AS T(c)
		) AS S(C)
		CROSS APPLY c.nodes('Datos/Catalogos/Deducciones/TipoDeDeduccion') AS A(tipDeduccion)

	SELECT @count = COUNT(*) FROM #TiposDeduccion

	WHILE @count > 0
	BEGIN
		DECLARE @Id INT = (SELECT TOP(1) Id FROM #TiposDeduccion);
		DECLARE @Nombre VARCHAR(64) = (SELECT TOP(1) Nombre FROM #TiposDeduccion);
		DECLARE @Obligatorio VARCHAR(2) = (SELECT TOP(1) Obligatorio FROM #TiposDeduccion);
		DECLARE @Porcentual VARCHAR(2) = (SELECT TOP(1) Porcentual FROM #TiposDeduccion);
		DECLARE @Valor DECIMAL(18,3) = (SELECT TOP(1) Valor FROM #TiposDeduccion);

		DECLARE @ObligatorioBit BIT, @PorcentualBit BIT
		SET @ObligatorioBit = 0
		SET @PorcentualBit = 0

		IF @Porcentual = 'Si'
		BEGIN
			SET @PorcentualBit = 1
		END
		
		IF @Obligatorio = 'Si'
		BEGIN
			SET @ObligatorioBit = 1
		END

		INSERT INTO dbo.TipoDeduccion 
		VALUES(
			@Id,
			@Nombre,
			@ObligatorioBit,
			@PorcentualBit
		)

		IF @Obligatorio = 'Si' AND @Porcentual = 'Si'
		BEGIN
			INSERT INTO dbo.DeduccionObligatoriaPorcentual
			VALUES(
				@Id,
				@Valor
			)
		END

		DELETE TOP (1) FROM #TiposDeduccion
		SELECT @count = COUNT(*) FROM #TiposDeduccion;
	END

	DROP TABLE #TiposDeduccion

	SET NOCOUNT OFF
END
GO
/****** Object:  StoredProcedure [dbo].[sp_ConsultaDeducciones]    Script Date: 6/23/2021 6:06:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ConsultaDeducciones]
	-- Parametros de entrada
	@InEmpleado INT,

	-- Parametros de salida
	@OutResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		SET @OutResultCode = 0

		IF NOT EXISTS (SELECT 1 FROM dbo.DeduccionXEmpleado WHERE Id = @InEmpleado)
		BEGIN
			SET @OutResultCode = 5001			-- Error por si no encuentra el empleado
			RETURN
		END

		SELECT
			DE.Id,
			DE.IdTipoDeduccion,
			TP.Nombre,
			TP.EsPorcentual,
			DNOF.Monto,
			DNOP.Porcentaje,
			DE.FechaInicio,
			DE.FechaFinal
		FROM dbo.DeduccionXEmpleado AS DE
			INNER JOIN dbo.TipoDeduccion AS TP
				ON TP.Id = DE.IdTipoDeduccion
			LEFT JOIN dbo.DeduccionNoObligatoriaFija AS DNOF
				ON DNOF.Id = DE.Id
			LEFT JOIN dbo.DeduccionNoObligatoriaPorcentual AS DNOP
				ON DNOP.Id = DE.Id
		WHERE DE.IdEmpleado = @InEmpleado AND DE.Activo = 1 AND EsObligatoria = 0

	END TRY
	BEGIN CATCH
		IF @@Trancount>0 
			ROLLBACK TRANSACTION Modificacion;



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
/****** Object:  StoredProcedure [dbo].[sp_ConsultaDeduccionesTipos]    Script Date: 6/23/2021 6:06:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ConsultaDeduccionesTipos]
AS
BEGIN
SET NOCOUNT ON;

	SELECT 
	ID,
	Nombre 
	FROM dbo.TipoDeduccion
	WHERE EsObligatoria = 0

SET NOCOUNT OFF;

END
GO
/****** Object:  StoredProcedure [dbo].[sp_ConsultaDeduccionXId]    Script Date: 6/23/2021 6:06:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ConsultaDeduccionXId]
	-- Parametros de entrada
	@InDeduccion INT,

	-- Parametros de salida
	@OutResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		SET @OutResultCode = 0

		IF NOT EXISTS (SELECT 1 FROM dbo.DeduccionXEmpleado WHERE Id = @InDeduccion)
		BEGIN
			SET @OutResultCode = 5001			-- Error por si no encuentra el empleado
			RETURN
		END

		SELECT
			DE.Id,
			TP.Nombre,
			DNOF.Monto,
			DNOP.Porcentaje
		FROM dbo.DeduccionXEmpleado AS DE
			INNER JOIN dbo.TipoDeduccion AS TP
				ON TP.Id = DE.IdTipoDeduccion
			LEFT JOIN dbo.DeduccionNoObligatoriaFija AS DNOF
				ON DNOF.Id = DE.Id
			LEFT JOIN dbo.DeduccionNoObligatoriaPorcentual AS DNOP
				ON DNOP.Id = DE.Id
		WHERE DE.Id = @InDeduccion AND DE.Activo = 1 AND EsObligatoria = 0

	END TRY
	BEGIN CATCH
		IF @@Trancount>0 
			ROLLBACK TRANSACTION Modificacion;



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
/****** Object:  StoredProcedure [dbo].[sp_ConsultaDepartamento]    Script Date: 6/23/2021 6:06:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ConsultaDepartamento]
AS
BEGIN
SET NOCOUNT ON;

	SELECT 
	ID, 
	Nombre 
	FROM dbo.Departamento

SET NOCOUNT OFF;

END
GO
/****** Object:  StoredProcedure [dbo].[sp_ConsultaHistorial]    Script Date: 6/23/2021 6:06:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_ConsultaHistorial]
AS
BEGIN
SET NOCOUNT ON;

    SELECT 
        Historial.ID,
        Historial.Operacion,
        Historial.DescripcionA,
        Historial.DescripcionB,
        Historial.Fecha
	FROM Historial
	Order by ID DESC

SET NOCOUNT OFF;

END
GO
/****** Object:  StoredProcedure [dbo].[sp_ConsultaPuesto]    Script Date: 6/23/2021 6:06:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ConsultaPuesto]
AS
BEGIN
SET NOCOUNT ON;

		SELECT 
		ID,
		Nombre,
		SalarioXHora 
		FROM dbo.Puesto 
		WHERE Activo = 1
		ORDER BY Id;

SET NOCOUNT OFF;

END
GO
/****** Object:  StoredProcedure [dbo].[sp_ConsultaPuestoSinSalario]    Script Date: 6/23/2021 6:06:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_ConsultaPuestoSinSalario]
AS
BEGIN
SET NOCOUNT ON;

		SELECT 
		ID,
		Nombre
		FROM dbo.Puesto 
		WHERE Activo = 1;

SET NOCOUNT OFF;

END

GO
/****** Object:  StoredProcedure [dbo].[sp_ConsultasEmpleados]    Script Date: 6/23/2021 6:06:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_ConsultasEmpleados]
AS
BEGIN
SET NOCOUNT ON;

	SELECT 
		dbo.Empleado.ID,
		dbo.Empleado.Nombre,
		dbo.Empleado.ValorDocumento,
		dbo.Empleado.FechaNacimiento,
		dbo.Puesto.Nombre AS NombrePuesto,
		dbo.Departamento.Nombre AS NombreDepartamento,
		dbo.TipoDocumentoIdentidad.Nombre AS NombreTipoDoc
		FROM dbo.Empleado
		INNER JOIN dbo.Puesto ON dbo.Empleado.IDPuesto = dbo.Puesto.ID
		INNER JOIN dbo.Departamento ON dbo.Empleado.IDDepartamento = dbo.Departamento.ID
		INNER JOIN dbo.TipoDocumentoIdentidad ON dbo.Empleado.IdTipoDocumento = dbo.TipoDocumentoIdentidad.ID
		WHERE dbo.Empleado.Activo = 1

SET NOCOUNT OFF;

END
GO
/****** Object:  StoredProcedure [dbo].[sp_ConsultaTipoDoc]    Script Date: 6/23/2021 6:06:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ConsultaTipoDoc]
AS
BEGIN
SET NOCOUNT ON;

	SELECT 
	ID,
	Nombre 
	FROM TipoDocumentoIdentidad

SET NOCOUNT OFF;

END
GO
/****** Object:  StoredProcedure [dbo].[sp_DeduccionesMensuales]    Script Date: 6/23/2021 6:06:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_DeduccionesMensuales]
	-- Parametros de entrada
	@InPlanilla INT,

	-- Parametros de salida
	@OutResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		SET @OutResultCode = 0

		IF NOT EXISTS (SELECT 1 FROM dbo.PlanillaXMesXEmpleado WHERE Id = @InPlanilla)
		BEGIN
			SET @OutResultCode = 5001			-- Error por si no encuentra la planilla
			RETURN
		END

		SELECT DISTINCT
			DE.Id,
			TP.Nombre,
			TP.EsObligatoria,
			DOP.Porcentaje,
			DE.TotalDeduccion
		FROM dbo.DeduccionXMesXEmpleado AS DE
			INNER JOIN dbo.TipoDeduccion AS TP
				ON TP.Id = DE.IdTipoDeduccion
			LEFT JOIN dbo.DeduccionObligatoriaPorcentual AS DOP
				ON DOP.Id = TP.Id
		WHERE DE.IdPlanillaXMesXEmpleado = @InPlanilla


	END TRY
	BEGIN CATCH
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
/****** Object:  StoredProcedure [dbo].[sp_DeduccionesSemanales]    Script Date: 6/23/2021 6:06:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_DeduccionesSemanales]
	-- Parametros de entrada
	@InPlanilla INT,

	-- Parametros de salida
	@OutResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		SET @OutResultCode = 0

		IF NOT EXISTS (SELECT 1 FROM dbo.PlanillaXSemanaXEmpleado WHERE Id = @InPlanilla)
		BEGIN
			SET @OutResultCode = 5001			-- Error por si no encuentra el empleado
			RETURN
		END

		SELECT DISTINCT
			DE.Id,
			TP.Nombre,
			TP.EsObligatoria,
			DOP.Porcentaje,
			MP.Monto * -1 AS Monto
		FROM dbo.DeduccionXEmpleado AS DE 
			INNER JOIN dbo.MovimientoDeduccion AS MD
				ON De.Id = MD.IdDeduccionXEmpleado
			INNER JOIN dbo.MovimientoPlanilla AS MP
				ON MP.Id = MD.Id
			INNER JOIN dbo.TipoDeduccion AS TP
				ON TP.Id = DE.IdTipoDeduccion
			LEFT JOIN dbo.DeduccionObligatoriaPorcentual AS DOP
				ON DOP.Id = TP.Id
		WHERE MP.IdPlanillaXSemanaXEmpleado = @InPlanilla


	END TRY
	BEGIN CATCH
		IF @@Trancount>0 
			ROLLBACK TRANSACTION Modificacion;

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
/****** Object:  StoredProcedure [dbo].[sp_DesasociarDeduccion]    Script Date: 6/23/2021 6:06:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_DesasociarDeduccion]
@FechaOperacion DATE,
@ValorDocumentoIdentidad INT,
@IdDeduccion INT
AS
BEGIN
	SET NOCOUNT ON

	BEGIN TRY
		DECLARE @OutResultCode INT
		SET @OutResultCode = 0;

		DECLARE @IdEmpleado INT
		DECLARE @IdDedXEmp INT
		DECLARE @Maximo INT
		DECLARE @Fecha DATE

		BEGIN TRANSACTION DesasociaDeduccion
			SELECT @IdEmpleado = (SELECT Id FROM dbo.Empleado 
								  WHERE ValorDocumento = @ValorDocumentoIdentidad)

			SELECT @Maximo =  MAX(Id) FROM dbo.SemanaPlanilla
			
			SELECT @IdDedXEmp = (SELECT MAX(Id) FROM DeduccionXEmpleado 
								 WHERE IdEmpleado = @IdEmpleado AND IdTipoDeduccion = @IdDeduccion)

			IF DATEPART(WEEKDAY, @FechaOperacion) = 4
				SELECT @Fecha = @FechaOperacion

			ELSE
				SELECT @Fecha = (SELECT FechaFinal FROM dbo.SemanaPlanilla WHERE Id = @Maximo)


			UPDATE DeduccionXEmpleado 
			SET FechaFinal = @Fecha, Activo = 0
			WHERE Id = @IdDedXEmp

			INSERT INTO Historial (
				Fecha,
				Operacion,
				DescripcionA,
				DescripcionB
			)
			SELECT
				@Fecha,
				'Desasocia  Deduccion',
				'Id: ' + CONVERT(varchar(10), DE.Id) + 
				' Id Empleado: ' + CONVERT(varchar(10), DE.IdEmpleado) +
				' Id Tipo de Deduccion: ' + CONVERT(varchar(10), DE.IdTipoDeduccion) +
				' Nombre Deduccion: ' + TP.Nombre +
				' Es Obligatoria: ' + CONVERT(varchar(1), TP.EsObligatoria) +
				' Es Porcentual: ' + CONVERT(varchar(1), TP.EsPorcentual),
				NULL
			FROM dbo.DeduccionXEmpleado AS DE
			INNER JOIN dbo.TipoDeduccion AS TP
			ON DE.IdTipoDeduccion = TP.Id
			WHERE DE.Id = (SELECT MAX(Id) FROM DeduccionXEmpleado)

		COMMIT TRANSACTION DesasociaDeduccion

	END TRY
	BEGIN CATCH
		IF @@Trancount>0 
			ROLLBACK TRANSACTION DesasociaDeduccion;

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
/****** Object:  StoredProcedure [dbo].[sp_DesasociarNuevaDeduccion]    Script Date: 6/23/2021 6:06:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_DesasociarNuevaDeduccion]
	-- Parametros de entrada
	@IdDeduccionXEmpleado INT,

	-- Parametros de salida
	@OutResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		SET @OutResultCode = 0


		IF NOT EXISTS (SELECT 1 FROM dbo.DeduccionXEmpleado WHERE Id = @IdDeduccionXEmpleado)
		BEGIN
			SET @OutResultCode = 5001			-- Error por si no encuentra la deduccion
			RETURN
		END
		BEGIN TRANSACTION DesasociaDeduccion
			UPDATE DeduccionXEmpleado 
			SET FechaFinal = GETDATE(), Activo = 0
			WHERE Id = @IdDeduccionXEmpleado

		INSERT INTO Historial (
				Fecha,
				Operacion,
				DescripcionA,
				DescripcionB
			)
			SELECT
				GETDATE(),
				'Desasocia  Deduccion',
				'Id: ' + CONVERT(varchar(10), DE.Id) + 
				' Id Empleado: ' + CONVERT(varchar(10), DE.IdEmpleado) +
				' Id Tipo de Deduccion: ' + CONVERT(varchar(10), DE.IdTipoDeduccion) +
				' Nombre Deduccion: ' + TP.Nombre +
				' Es Obligatoria: ' + CONVERT(varchar(1), TP.EsObligatoria) +
				' Es Porcentual: ' + CONVERT(varchar(1), TP.EsPorcentual),
				NULL
			FROM dbo.DeduccionXEmpleado AS DE
			INNER JOIN dbo.TipoDeduccion AS TP
			ON DE.IdTipoDeduccion = TP.Id
			WHERE DE.Id = (SELECT MAX(Id) FROM DeduccionXEmpleado)

		COMMIT TRANSACTION DesasociaDeduccion

	END TRY
	BEGIN CATCH
		IF @@Trancount>0 
			ROLLBACK TRANSACTION DesasociaDeduccion;



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
/****** Object:  StoredProcedure [dbo].[sp_EditarEmpleados]    Script Date: 6/23/2021 6:06:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_EditarEmpleados] 
	-- Add the parameters for the stored procedure here
	@inID INT,
	@innombre NVARCHAR(64),
	@invalorDocIdent INT,
	@infechaNacimiento DATE,
	@inIDPuesto INT,
	@inIDDepartamento INT,
	@inIDTipoDocIdent INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	INSERT INTO Historial (
		Fecha,
		Operacion,
		DescripcionA,
		DescripcionB
	)
	SELECT
		GETDATE(),
		'Edicion de Empleado de Id: ' + CONVERT(varchar(10), Emp.Id),
		'Nombre: ' + Emp.Nombre + 
		' Tipo de Documento: ' + TDI.Nombre + 
		' Valor de Documento: ' + CONVERT(varchar(16), Emp.ValorDocumento) +
		' Fecha de Nacimiento: ' + CONVERT(varchar(16), Emp.FechaNacimiento) +
		' Puesto: ' + P.Nombre +
		' Departamento: ' + D.Nombre,
		NULL
	FROM dbo.Empleado AS Emp 
	INNER JOIN dbo.TipoDocumentoIdentidad AS TDI
	ON Emp.IdTipoDocumento = TDI.Id
	INNER JOIN dbo.Puesto AS P
	ON Emp.IdPuesto = P.Id
	INNER JOIN dbo.Departamento AS D
	ON Emp.IdDepartamento = D.Id
	WHERE Emp.Id = @inID

	UPDATE dbo.Empleado
	SET	nombre = @innombre,
	ValorDocumento = @invalorDocIdent,
	fechaNacimiento = @infechaNacimiento,
	IDPuesto = @inIDPuesto,
	IDDepartamento = @inIDDepartamento,
	IdTipoDocumento = @inIDTipoDocIdent
	WHERE  ID = @inID

	UPDATE Historial
	SET DescripcionB = 
		(SELECT
			'Nombre: ' + Emp.Nombre + 
			' Tipo de Documento: ' + TDI.Nombre + 
			' Valor de Documento: ' + CONVERT(varchar(16), Emp.ValorDocumento) +
			' Fecha de Nacimiento: ' + CONVERT(varchar(16), Emp.FechaNacimiento) +
			' Puesto: ' + P.Nombre +
			' Departamento: ' + D.Nombre
		FROM dbo.Empleado AS Emp 
		INNER JOIN dbo.TipoDocumentoIdentidad AS TDI
		ON Emp.IdTipoDocumento = TDI.Id
		INNER JOIN dbo.Puesto AS P
		ON Emp.IdPuesto = P.Id
		INNER JOIN dbo.Departamento AS D
		ON Emp.IdDepartamento = D.Id
		WHERE Emp.Id = @inID  AND Historial.Id = (SELECT MAX(Id) FROM dbo.Historial))

	WHERE Id = (SELECT MAX(Id) FROM Historial)

	SET NOCOUNT OFF;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_EditarPuesto]    Script Date: 6/23/2021 6:06:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_EditarPuesto]
	@inID INT,
	@innombre NVARCHAR(64),
	@inSalario INT,

-- parametros de salida
	@OutResultCode INT OUTPUT
	
	AS
	BEGIN
		SET NOCOUNT ON;
		BEGIN TRY
			SELECT
				@OutResultCode=0  -- codigo de ejecucion exitoso

			UPDATE dbo.Puesto
			SET	Nombre = @innombre,
			SalarioXHora = @inSalario
			WHERE  ID = @inID

		END TRY
		BEGIN CATCH
			Set @OutResultCode=50005; -- error de ejecucion
		END CATCH;
		SET NOCOUNT OFF;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_EliminarDatos]    Script Date: 6/23/2021 6:06:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_EliminarDatos]
AS
BEGIN
	DELETE FROM DeduccionXMesXEmpleado
	DBCC CHECKIDENT(DeduccionXMesXEmpleado,RESEED,0)

	DELETE FROM MovimientoDeduccion
	DELETE FROM MovimientoGanancia

	DELETE FROM MovimientoPlanilla
	DBCC CHECKIDENT(MovimientoPlanilla,RESEED,0)

	DELETE FROM MarcaAsistencia
	DBCC CHECKIDENT(MarcaAsistencia,RESEED,0)

	DELETE FROM Jornada
	DBCC CHECKIDENT(Jornada,RESEED,0)

	DELETE FROM PlanillaXSemanaXEmpleado
	DBCC CHECKIDENT(PlanillaXSemanaXEmpleado,RESEED,0)

	DELETE FROM PlanillaXMesXEmpleado
	DBCC CHECKIDENT(PlanillaXMesXEmpleado,RESEED,0)

	DELETE FROM SemanaPlanilla
	DBCC CHECKIDENT(SemanaPlanilla,RESEED,0)

	DELETE FROM MesPlanilla
	DBCC CHECKIDENT(MesPlanilla,RESEED,0)

	DELETE FROM DeduccionNoObligatoriaFija

	DELETE FROM DeduccionNoObligatoriaPorcentual

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

	DELETE FROM dbo.Bitacora
	DBCC CHECKIDENT(Bitacora,RESEED,0)

	DELETE FROM dbo.Historial
	DBCC CHECKIDENT(Historial,RESEED,0)

	DELETE FROM DetalleCorrida
	DBCC CHECKIDENT(DetalleCorrida,RESEED,0)

	DELETE FROM Corrida
	DBCC CHECKIDENT(Corrida,RESEED,0)
END
GO
/****** Object:  StoredProcedure [dbo].[sp_EliminarEmpleado]    Script Date: 6/23/2021 6:06:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_EliminarEmpleado]
@ValorDocumentoIdentidad INT
AS
BEGIN
	SET NOCOUNT ON

	BEGIN TRY
		DECLARE @OutResultCode INT
		SET @OutResultCode = 0;
		DECLARE @IdEmpleado INT

		BEGIN TRANSACTION EliminarEmpleado
			INSERT INTO Historial (
				Fecha,
				Operacion,
				DescripcionA,
				DescripcionB
			)
			SELECT
				GETDATE(),
				'Eliminacion de Empleado de Id: ' + CONVERT(varchar(10), Emp.Id),
				'Nombre: ' + Emp.Nombre + 
				' Tipo de Documento: ' + TDI.Nombre + 
				' Valor de Documento: ' + CONVERT(varchar(16), Emp.ValorDocumento) +
				' Fecha de Nacimiento: ' + CONVERT(varchar(16), Emp.FechaNacimiento) +
				' Puesto: ' + P.Nombre +
				' Departamento: ' + D.Nombre,
				NULL
			FROM dbo.Empleado AS Emp 
			INNER JOIN dbo.TipoDocumentoIdentidad AS TDI
			ON Emp.IdTipoDocumento = TDI.Id
			INNER JOIN dbo.Puesto AS P
			ON Emp.IdPuesto = P.Id
			INNER JOIN dbo.Departamento AS D
			ON Emp.IdDepartamento = D.Id
			WHERE Emp.ValorDocumento = @ValorDocumentoIdentidad;

			UPDATE dbo.Empleado
			SET Empleado.Activo = 0
			WHERE Empleado.ValorDocumento = @ValorDocumentoIdentidad;

		COMMIT TRANSACTION EliminarEmpleado

	END TRY
	BEGIN CATCH
		IF @@Trancount>0 
			ROLLBACK TRANSACTION EliminarEmpleado;

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
/****** Object:  StoredProcedure [dbo].[sp_EliminarPuesto]    Script Date: 6/23/2021 6:06:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_EliminarPuesto]
	@inID INT,

-- parametros de salida
	@OutResultCode INT OUTPUT
	
	AS
	BEGIN
		SET NOCOUNT ON;
		BEGIN TRY
			SELECT
				@OutResultCode=0  -- codigo de ejecucion exitoso

			UPDATE dbo.Puesto
			SET Activo = 0
			WHERE dbo.Puesto.ID = @inID
		END TRY
		BEGIN CATCH
			Set @OutResultCode=50005; -- error de ejecucion
		END CATCH;
		SET NOCOUNT OFF;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_EmpleadoPorDoc]    Script Date: 6/23/2021 6:06:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_EmpleadoPorDoc]
@inID INT
AS
BEGIN
SET NOCOUNT ON;

	SELECT 
		dbo.Empleado.ID,
		dbo.Empleado.Nombre,
		dbo.Empleado.ValorDocumento,
		dbo.Empleado.FechaNacimiento,
		dbo.Puesto.Nombre AS NombrePuesto,
		dbo.Departamento.Nombre AS NombreDepartamento,
		dbo.TipoDocumentoIdentidad.Nombre AS NombreTipoDoc
		FROM dbo.Empleado
		INNER JOIN dbo.Puesto ON dbo.Empleado.IDPuesto = dbo.Puesto.ID
		INNER JOIN dbo.Departamento ON dbo.Empleado.IDDepartamento = dbo.Departamento.ID
		INNER JOIN dbo.TipoDocumentoIdentidad ON dbo.Empleado.IdTipoDocumento = dbo.TipoDocumentoIdentidad.ID
		WHERE dbo.Empleado.Activo = 1 AND dbo.Empleado.Id = @inID

SET NOCOUNT OFF;

END
GO
/****** Object:  StoredProcedure [dbo].[sp_FiltrarEmpleados]    Script Date: 6/23/2021 6:06:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_FiltrarEmpleados] 

@infiltro NVARCHAR (64)
AS
BEGIN
SET NOCOUNT ON;


	SELECT 
		dbo.Empleado.ID,
		dbo.Empleado.Nombre,
		dbo.Empleado.ValorDocumento,
		dbo.Empleado.FechaNacimiento,
		dbo.Puesto.Nombre AS NombrePuesto,
		dbo.Departamento.Nombre AS NombreDepartamento,
		dbo.TipoDocumentoIdentidad.Nombre AS NombreTipoDoc
		FROM dbo.Empleado
		INNER JOIN dbo.Puesto ON dbo.Empleado.IDPuesto = dbo.Puesto.ID
		INNER JOIN dbo.Departamento ON dbo.Empleado.IDDepartamento = dbo.Departamento.ID
		INNER JOIN dbo.TipoDocumentoIdentidad ON dbo.Empleado.IdTipoDocumento = dbo.TipoDocumentoIdentidad.ID
		WHERE dbo.Empleado.Activo = 1 AND dbo.Empleado.Nombre = @infiltro
		ORDER BY dbo.Empleado.Nombre;

SET NOCOUNT OFF;

END
GO
/****** Object:  StoredProcedure [dbo].[sp_FiltroPuesto]    Script Date: 6/23/2021 6:06:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_FiltroPuesto]
	@inID INT,

-- parametros de salida
	@OutResultCode INT OUTPUT
	
	AS
	BEGIN
		SET NOCOUNT ON;
		BEGIN TRY
			SELECT
				@OutResultCode=0  -- codigo de ejecucion exitoso

			SELECT 
			ID,
			Nombre,
			SalarioXHora 
			FROM dbo.Puesto 
			WHERE Activo = 1 
			AND ID = @inID

		END TRY
		BEGIN CATCH
			Set @OutResultCode=50005; -- error de ejecucion
		END CATCH;
		SET NOCOUNT OFF;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_HorasSemanal]    Script Date: 6/23/2021 6:06:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_HorasSemanal]
	-- Parametros de entrada
	@InSemanaId INT,

	-- Parametros de salida
	@OutResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		SET @OutResultCode = 0
		
		SELECT DISTINCT
			Ma.Id,
			Ma.HoraEntrada,
			Ma.HoraSalida,
			Ma.IdJornada,
			Ma.HorasOrdinarias,
			Ma.HorasExtraordinarias,
			Ma.HorasDobles,
			Mp.Monto
		FROM dbo.MarcaAsistencia AS MA 
		INNER JOIN dbo.MovimientoGanancia AS MG
		ON MA.Id = MG.IdMarcaAsistencia
		INNER JOIN dbo.MovimientoPlanilla AS MP
		ON MP.Id = MG.Id
		WHERE MP.IdPlanillaXSemanaXEmpleado = @InSemanaId


	END TRY
	BEGIN CATCH
		IF @@Trancount>0 
			ROLLBACK TRANSACTION Modificacion;

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
/****** Object:  StoredProcedure [dbo].[sp_IngresarJornada]    Script Date: 6/23/2021 6:06:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_IngresarJornada]
@ValorDocumentoIdentidad INT
,@IdJornada INT

AS
BEGIN
	SET NOCOUNT ON

	BEGIN TRY
		DECLARE @OutResultCode INT
		SET @OutResultCode = 0;

		DECLARE @IdEmpleado INT
		DECLARE @IdSemana INT

		BEGIN TRANSACTION IngresarJornada
			SELECT @IdEmpleado = Id 
			FROM dbo.Empleado 
			WHERE @ValorDocumentoIdentidad = ValorDocumento

			SELECT @IdSemana = MAX(Id) 
			FROM dbo.SemanaPlanilla

			INSERT INTO dbo.Jornada
			VALUES
			(
				@IdEmpleado, @IdJornada, @IdSemana
			)

		COMMIT TRANSACTION IngresarJornada

	END TRY
	BEGIN CATCH
		IF @@Trancount>0 
			ROLLBACK TRANSACTION IngresarJornada;

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
/****** Object:  StoredProcedure [dbo].[sp_InsertarEmpleado]    Script Date: 6/23/2021 6:06:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_InsertarEmpleado]
@Nombre VARCHAR(64)
, @ValorDocumentoIdentidad INT
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
/****** Object:  StoredProcedure [dbo].[sp_InsertarMarca]    Script Date: 6/23/2021 6:06:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_InsertarMarca]
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

		DECLARE @TablaDeducciones TABLE				-- Tabla con DeduccionesXEmpleado de cada User
		(	
			Id INT,
			IdEmpleado INT,
			IdTipoDeduccion INT
		)
										-- Declaracion de Variables
		DECLARE @idEmp INT								
		DECLARE @diaDeLaSemana VARCHAR(10)
		DECLARE @diaMov DATE		
		DECLARE @IdMesActual INT
		DECLARE @esJueves BIT = 0

		DECLARE @idSPXE INT							-- Id de semana y mes planilla
		DECLARE @idMPXE INT

		DECLARE @idJornada INT						-- Horas de la jornada
		DECLARE @horasJornada INT

		DECLARE @horasTrabajadas INT				-- Horas trabajadas
		DECLARE @horasOrdinarias INT
		DECLARE @horasExtra INT
		DECLARE @horasExtraDobles INT = 0

		DECLARE @SalarioxHora DECIMAL (18,3)		-- Variables donde se almacena el salario de cada uno
		DECLARE @SalarioNormal DECIMAL (18,3)
		DECLARE @SalarioExtra DECIMAL (18,3)
		DECLARE @SalarioDoble DECIMAL (18,3)
		---------------------------------------------------
		DECLARE @IdUltimoMov INT					-- Variables para creacion de planillas
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
			@diaDeLaSemana = DATENAME(dw, @inFechaEntrada),
			@IdMesActual = (SELECT IdMesPlanilla FROM dbo.PlanillaXMesXEmpleado WHERE Id = @idMPXE),
			@horasTrabajadas = DATEDIFF(MINUTE, @inFechaEntrada, @inFechaSalida),
			@diaMov = CONVERT (DATE, @inFechaEntrada)

		SELECT							-- Buscar el empleado en el 
			@idEmp = Id							
		FROM dbo.Empleado 
		WHERE @inValDocEmpleado = ValorDocumento

		SELECT							-- Con el empleado encontrado se busca en la PlanillaXSemanaXEmpleado
			@idSPXE = MAX(Id), 
			@idMPXE = MAX(IdPlanillaXMesXEmpleado) 
		FROM dbo.PlanillaXSemanaXEmpleado 
		WHERE @idEmp = IdEmpleado

		SELECT							-- Busca Jornada para saber los rangos de tiempo
			@idJornada = MAX(Id)
		FROM dbo.Jornada 
		WHERE @idEmp = IdEmpleado

		SELECT							-- Calcula el Salario del empleado 
			@SalarioxHora  = SalarioXHora
		FROM dbo.Empleado INNER JOIN dbo.Puesto 
			ON dbo.Empleado.IDPuesto = dbo.Puesto.ID
		WHERE @inValDocEmpleado = ValorDocumento

		SELECT							-- Calcula las horas trabajadas
			@horasTrabajadas = @horasTrabajadas/60

		SELECT							-- Calcula las horas de jornada
			@horasJornada = DATEDIFF(HOUR, TJ.HoraEntrada, TJ.HoraSalida) 
		FROM TipoJornada AS TJ INNER JOIN Jornada AS J
		ON J.IdTipoJornada = TJ.Id
		WHERE J.Id = @idJornada


		SELECT
			@horasExtra = @horasTrabajadas - @horasJornada,
			@horasOrdinarias = @horasJornada
		WHERE @horasTrabajadas > @horasJornada


		SELECT
			@horasExtra = 0,
			@horasOrdinarias = @horasTrabajadas
		WHERE @horasTrabajadas <= @horasJornada


		SELECT 
			@horasExtraDobles = @horasExtra,
			@horasExtra = 0
		WHERE (@diaDeLaSemana = 'Domingo' OR @diaDeLaSemana = 'Sunday') OR (SELECT COUNT(*) FROM Feriado WHERE Fecha = CAST(@inFechaEntrada AS DATE))>0

		SELECT 
			@SalarioNormal = @SalarioxHora * @horasOrdinarias,
			@SalarioExtra = (@SalarioxHora * @horasExtra) * 1.5,
			@SalarioDoble = (@SalarioxHora * @horasExtraDobles)*2,
			@TotalDeduccion = 0											-- Inicializar el valor de total en 0				

		IF DATEPART(WEEKDAY, @diaMov) = 4					-- Define si la fecha es jueves
			SET @esJueves = 1
		

		INSERT INTO @TablaDeducciones			-- Se cargan todas las deducciones en una variable 
			SELECT
				Deduc.Id,
				Deduc.IdEmpleado,
				Deduc.IdTipoDeduccion
			FROM dbo.DeduccionXEmpleado AS Deduc
			WHERE Activo = 1 AND Deduc.IdEmpleado = @idEmp AND @esJueves = 1

		SELECT								-- Contador para iterar sobre la tabla @TablaDeducciones
			@Count = COUNT(*) 
		FROM @TablaDeducciones


		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

		BEGIN TRANSACTION InsertarMarca     
			INSERT INTO MarcaAsistencia (
				HoraEntrada, 
				HoraSalida, 
				IdJornada, 
				IdEmpleado, 
				HorasOrdinarias, 
				HorasExtraordinarias, 
				HorasDobles)
			VALUES (
				@inFechaEntrada, 
				@inFechaSalida,
				@idJornada, 
				@idEmp, 
				@horasOrdinarias, 
				@horasExtra, 
				@horasExtraDobles
			)

			-- Movimiento de salario horas normales
			INSERT INTO dbo.MovimientoPlanilla (
				Fecha,
				Monto,
				IdTipoMovimientoPlanilla,
				IdPlanillaXSemanaXEmpleado
			)
			SELECT
				@diaMov, 
				@SalarioNormal, 
				1, 
				@idSPXE
			WHERE @horasOrdinarias > 0


			INSERT INTO dbo.MovimientoGanancia (
				Id,
				IdMarcaAsistencia
			)
			SELECT
				(SELECT MAX(Id) FROM dbo.MovimientoPlanilla) ,
				(SELECT MAX(Id) FROM dbo.MarcaAsistencia)
			WHERE @horasOrdinarias > 0


			UPDATE dbo.PlanillaXSemanaXEmpleado
			SET SalarioBruto = SalarioBruto + @SalarioNormal,
				SalarioNeto = SalarioNeto + @SalarioNormal
			WHERE @horasOrdinarias > 0 AND dbo.PlanillaXSemanaXEmpleado.Id = @idSPXE




			-- Movimiento de salario horas extra, despues de la hora
			INSERT INTO dbo.MovimientoPlanilla (
				Fecha,
				Monto,
				IdTipoMovimientoPlanilla,
				IdPlanillaXSemanaXEmpleado
			)
			SELECT
				@diaMov, 
				@SalarioExtra, 
				2, 
				@idSPXE
			WHERE @horasExtra > 0


			INSERT INTO dbo.MovimientoGanancia (
				Id,
				IdMarcaAsistencia
			)
			SELECT
				(SELECT MAX(Id) FROM dbo.MovimientoPlanilla) ,
				(SELECT MAX(Id) FROM dbo.MarcaAsistencia)
			WHERE @horasExtra > 0


			UPDATE dbo.PlanillaXSemanaXEmpleado
			SET SalarioBruto = SalarioBruto + @SalarioExtra,
				SalarioNeto = SalarioNeto + @SalarioExtra
			WHERE @horasExtra > 0 AND dbo.PlanillaXSemanaXEmpleado.Id = @idSPXE
			
			




			--- Movimiento de salario horas Extra dobles, feriados
			INSERT INTO dbo.MovimientoPlanilla (
				Fecha,
				Monto,
				IdTipoMovimientoPlanilla,
				IdPlanillaXSemanaXEmpleado
			)
			SELECT
				@diaMov, 
				@SalarioDoble, 
				3, 
				@idSPXE
			WHERE @horasExtraDobles > 0
				

			INSERT INTO dbo.MovimientoGanancia (
				Id,
				IdMarcaAsistencia
			)
			SELECT
				(SELECT MAX(Id) FROM dbo.MovimientoPlanilla) ,
				(SELECT MAX(Id) FROM dbo.MarcaAsistencia)
			WHERE @horasExtraDobles > 0

			UPDATE dbo.PlanillaXSemanaXEmpleado
			SET SalarioBruto = SalarioBruto + @SalarioDoble,
				SalarioNeto = SalarioNeto + @SalarioDoble
			WHERE @horasExtraDobles > 0 AND dbo.PlanillaXSemanaXEmpleado.Id = @idSPXE
			




			/* Proceso de Movimientos de Deduccion
			Si el dia es jueves se procede a hacer un cierre de semana*/		

			SELECT									-- Salario bruto de toda la semana planilla
				@SalarioBruto  = SalarioBruto
			FROM dbo.PlanillaXSemanaXEmpleado
			WHERE dbo.PlanillaXSemanaXEmpleado.Id = @idSPXE AND @esJueves = 1

			WHILE @Count > 0
			BEGIN
				SELECT @TipoObligatoria  = EsObligatoria		-- Se define en una variable si la deduccion es obligatoria
				FROM dbo.DeduccionXEmpleado INNER JOIN dbo.TipoDeduccion 
					ON dbo.DeduccionXEmpleado.IdTipoDeduccion = dbo.TipoDeduccion.Id
				WHERE dbo.DeduccionXEmpleado.IdTipoDeduccion = (SELECT TOP(1) IdTipoDeduccion FROM @TablaDeducciones)
					
				IF (@TipoObligatoria = 1)						-- Ejecutamos deducciones obligatorias por ley
				BEGIN
					SELECT @Porcentaje  = Porcentaje			-- Definimos el porcentaje que se utilizara
					FROM dbo.DeduccionXEmpleado
					INNER JOIN dbo.TipoDeduccion 
					ON dbo.DeduccionXEmpleado.IdTipoDeduccion = dbo.TipoDeduccion.Id
					INNER JOIN dbo.DeduccionObligatoriaPorcentual
					ON dbo.TipoDeduccion.Id = dbo.DeduccionObligatoriaPorcentual.Id
					WHERE dbo.DeduccionXEmpleado.IdTipoDeduccion = (SELECT TOP(1) IdTipoDeduccion FROM @TablaDeducciones)

					SELECT										-- Aplicamos el monto que se reducira
						@Monto = (@SalarioBruto * @Porcentaje) * -1,
						@TipoMovObl = 4
					
				END
				ELSE						-- En caso contrario ingresamos la deduccion como no obligatoria
				BEGIN						-- Verificamos que sea de Monto fijo
					IF EXISTS (SELECT 1 FROM dbo.DeduccionNoObligatoriaFija 
					WHERE Id = (SELECT TOP(1) Id FROM @TablaDeducciones))
					BEGIN
						SELECT @Porcentaje  = Monto		-- Definimos el porcentaje
						FROM DeduccionNoObligatoriaFija
						WHERE Id = (SELECT TOP(1) Id FROM @TablaDeducciones)

						SELECT
								@Monto = (@Porcentaje) * -1	-- Y aplicamos el monto que se reducira
					END
					ELSE					-- De lo contrario lo procesamos como monto porcentual		
					BEGIN
						SELECT @Porcentaje  = Porcentaje		-- Definimos el porcentaje
						FROM DeduccionNoObligatoriaPorcentual
						WHERE Id = (SELECT TOP(1) Id FROM @TablaDeducciones)

						SELECT									-- Y aplicamos el monto que se reducira
							@Monto = (@SalarioBruto * @Porcentaje) * -1

					END
					SELECT 
						@TipoMovObl = 5
				END


				INSERT INTO dbo.MovimientoPlanilla (				-- Ingresamos el movimiento Planilla
					Fecha,
					Monto,
					IdTipoMovimientoPlanilla,
					IdPlanillaXSemanaXEmpleado
				)
				SELECT
					@diaMov, 
					@Monto, 
					@TipoMovObl, 
					@idSPXE
				WHERE @esJueves = 1



				INSERT INTO dbo.MovimientoDeduccion (				-- Y a la vez el movimiento deduccion
					Id,
					IdDeduccionXEmpleado
				)
				SELECT
					(SELECT MAX(Id) FROM dbo.MovimientoPlanilla),
					(SELECT TOP (1) Id FROM @TablaDeducciones)
				WHERE @esJueves = 1

				UPDATE dbo.PlanillaXSemanaXEmpleado					-- Se actualiza la planilla semanal
					SET SalarioNeto = SalarioNeto + @Monto				-- Monto negativo por el (*-1)
				WHERE @esJueves = 1 AND dbo.PlanillaXSemanaXEmpleado.Id = @idSPXE
				

				-- Calcula DeduccionXMesXEmpleado
															-- Si existe una fila para esta planilla de este mes
				IF EXISTS (SELECT 1 FROM dbo.DeduccionXMesXEmpleado 
						   WHERE IdTipoDeduccion = (SELECT TOP(1) IdTipoDeduccion FROM @TablaDeducciones) AND			-- If necesario
						   IdPlanillaXMesXEmpleado = @idMPXE)
				BEGIN									-- La actualiza agregando el nuevo monto
					UPDATE dbo.DeduccionXMesXEmpleado
						SET TotalDeduccion = TotalDeduccion + (@Monto*-1)
					WHERE (
						IdTipoDeduccion = (SELECT TOP(1) IdTipoDeduccion FROM @TablaDeducciones) AND
						IdPlanillaXMesXEmpleado = @idMPXE
					)

				END
				ELSE								-- En caso contrario
				BEGIN										-- Se ingresa una nueva entidad para el nuevo mes
					INSERT INTO dbo.DeduccionXMesXEmpleado
					VALUES(
						(@Monto*-1),						-- Y se le agrega el nuevo monto
						@idMPXE, 
						(SELECT TOP(1) IdTipoDeduccion FROM @TablaDeducciones)
					)
				END

				DELETE TOP (1) FROM @TablaDeducciones
				SELECT @Count = COUNT(*) FROM @TablaDeducciones;
			END

				-- Actualizar PlanillaxMesxEmpleado con salario y salario Bruto
			SELECT									-- Seleccion de salario neto 
				@SalarioNeto = SalarioNeto
			FROM dbo.PlanillaXSemanaXEmpleado
			WHERE @esJueves = 1 AND dbo.PlanillaXSemanaXEmpleado.Id = @idSPXE

			UPDATE dbo.PlanillaXMesXEmpleado
			SET SalarioBruto = SalarioBruto + @SalarioBruto,
				SalarioNeto = SalarioNeto + @SalarioNeto
			WHERE @esJueves = 1 AND dbo.PlanillaXMesXEmpleado.Id = @idMPXE

			SELECT										-- Busca Ultimo mes
			@IdMesActual = (SELECT TOP(1) IdMesPlanilla 
						    FROM PlanillaXMesXEmpleado 
							WHERE Id = @idMPXE)


			-- Verifica si se deben crear planillas mensuales y semanales para el empleado
			INSERT INTO PlanillaXMesXEmpleado		-- Inserta planilla mensual
			SELECT
				@idEmp,
				0,
				0,
				(SELECT MAX(Id) FROM dbo.MesPlanilla)
			WHERE @esJueves = 1 AND @diaMov = (SELECT FechaFin FROM MesPlanilla WHERE Id = @IdMesActual)

			INSERT INTO PlanillaXSemanaXEmpleado		-- Inserta la nueva planilla semanal
			SELECT 
				0,
				0,
				@idEmp,
				(SELECT MAX(Id) FROM dbo.SemanaPlanilla),
				(SELECT MAX(Id) FROM dbo.PlanillaXMesXEmpleado WHERE IdEmpleado = @idEmp)
			WHERE @esJueves = 1
		
	COMMIT TRANSACTION InsertarMarca

	END TRY
	BEGIN CATCH
		IF @@Trancount>0 
			ROLLBACK TRANSACTION InsertarMarca;

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
/****** Object:  StoredProcedure [dbo].[sp_InsertarPuesto]    Script Date: 6/23/2021 6:06:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_InsertarPuesto]
	@inID INT,
	@innombre NVARCHAR(64),
	@inSalario INT,

-- parametros de salida
	@OutResultCode INT OUTPUT
	
	AS
	BEGIN
		SET NOCOUNT ON;
		BEGIN TRY
			SELECT
				@OutResultCode=0  -- codigo de ejecucion exitoso

			INSERT INTO dbo.Puesto
			(
			Id,
			Nombre,
			SalarioXHora,
			Activo
			)
			VALUES 
			(
			@inID, 
			@innombre, 
			@inSalario, 
			1
			)
		END TRY
		BEGIN CATCH
			Set @OutResultCode=50005; -- error de ejecucion
		END CATCH;
		SET NOCOUNT OFF;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_ModificarMontoDeduccionNoObligatoria]    Script Date: 6/23/2021 6:06:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ModificarMontoDeduccionNoObligatoria]
	-- Parametros de entrada
	@InDeduccion INT,
	@InMonto DECIMAL(18,3),

	-- Parametros de salida
	@OutResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		SET @OutResultCode = 0

		IF NOT EXISTS (SELECT 1 FROM dbo.DeduccionXEmpleado WHERE Id = @InDeduccion)
		BEGIN
			SET @OutResultCode = 5001			-- Error por si no encuentra la deduccion
			RETURN
		END

		IF EXISTS (SELECT 1 FROM dbo.DeduccionXEmpleado INNER JOIN dbo.TipoDeduccion 
				   ON dbo.DeduccionXEmpleado.IdTipoDeduccion = dbo.TipoDeduccion.Id
				   WHERE (dbo.DeduccionXEmpleado.Id = @InDeduccion AND dbo.TipoDeduccion.EsObligatoria = 1))
		BEGIN
			SET @OutResultCode = 5002			-- Error por si es obligatoria
			RETURN
		END
		INSERT INTO Historial (
				Fecha,
				Operacion,
				DescripcionA,
				DescripcionB
			)
			SELECT
				GETDATE(),
				'Editar  Deduccion',
				'Id: ' + CONVERT(varchar(10), DE.Id) + 
				' Id Empleado: ' + CONVERT(varchar(10), DE.IdEmpleado) +
				' Id Tipo de Deduccion: ' + CONVERT(varchar(10), DE.IdTipoDeduccion) +
				' Nombre Deduccion: ' + TP.Nombre +
				' Es Obligatoria: ' + CONVERT(varchar(1), TP.EsObligatoria) +
				' Es Porcentual: ' + CONVERT(varchar(1), TP.EsPorcentual),
				NULL
			FROM dbo.DeduccionXEmpleado AS DE
			INNER JOIN dbo.TipoDeduccion AS TP
			ON DE.IdTipoDeduccion = TP.Id
			WHERE DE.Id = @InDeduccion

		IF EXISTS (SELECT 1 FROM dbo.DeduccionNoObligatoriaFija WHERE Id = @InDeduccion)
			BEGIN
				UPDATE dbo.DeduccionNoObligatoriaFija
					SET Monto = @InMonto
				WHERE Id = @InDeduccion

				UPDATE Historial
				SET DescripcionB = 
					(SELECT
						'Id: ' + CONVERT(varchar(10), DE.Id) + 
						' Id Empleado: ' + CONVERT(varchar(10), DE.IdEmpleado) +
						' Id Tipo de Deduccion: ' + CONVERT(varchar(10), DE.IdTipoDeduccion) +
						' Nombre Deduccion: ' + TP.Nombre +
						' Es Obligatoria: ' + CONVERT(varchar(1), TP.EsObligatoria) +
						' Es Porcentual: ' + CONVERT(varchar(1), TP.EsPorcentual) +
						' Monto Nuevo: ' + CONVERT(varchar(16), @InMonto)
				FROM dbo.DeduccionXEmpleado AS DE
				INNER JOIN dbo.TipoDeduccion AS TP
				ON DE.IdTipoDeduccion = TP.Id
				WHERE DE.Id = @InDeduccion AND Historial.Id = (SELECT MAX(Id) FROM dbo.Historial))
			END

		ELSE
			BEGIN
				UPDATE dbo.DeduccionNoObligatoriaPorcentual
					SET Porcentaje = @InMonto
				WHERE Id = @InDeduccion
				UPDATE Historial
				SET DescripcionB = 
					(SELECT
						'Id: ' + CONVERT(varchar(10), DE.Id) + 
						' Id Empleado: ' + CONVERT(varchar(10), DE.IdEmpleado) +
						' Id Tipo de Deduccion: ' + CONVERT(varchar(10), DE.IdTipoDeduccion) +
						' Nombre Deduccion: ' + TP.Nombre +
						' Es Obligatoria: ' + CONVERT(varchar(1), TP.EsObligatoria) +
						' Es Porcentual: ' + CONVERT(varchar(1), TP.EsPorcentual) +
						' Porcentaje Nuevo: ' + CONVERT(varchar(16), @InMonto)
					FROM dbo.DeduccionXEmpleado AS DE
					INNER JOIN dbo.TipoDeduccion AS TP
					ON DE.IdTipoDeduccion = TP.Id
					WHERE DE.Id = @InDeduccion AND Historial.Id = (SELECT MAX(Id) FROM dbo.Historial))
			END

	END TRY
	BEGIN CATCH
		IF @@Trancount>0 
			ROLLBACK TRANSACTION Modificacion;

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
/****** Object:  StoredProcedure [dbo].[sp_PlanillaMensual]    Script Date: 6/23/2021 6:06:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_PlanillaMensual]
	-- Parametros de entrada
	@InEmpleado INT,

	-- Parametros de salida
	@OutResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		SET @OutResultCode = 0

		IF NOT EXISTS (SELECT 1 FROM dbo.Empleado WHERE Id = @InEmpleado)
		BEGIN
			SET @OutResultCode = 5001			-- Error por si no encuentra el empleado
			RETURN
		END

		SELECT TOP(12)
			PMes.Id,
			PMes.SalarioBruto,
			PMes.SalarioNeto,
			PMes.SalarioBruto - PMes.SalarioNeto AS TotalDeducciones,
			PMes.IdMesPlanilla
		FROM dbo.PlanillaXMesXEmpleado AS PMes
		WHERE PMes.IdEmpleado = @InEmpleado
		ORDER BY (PMes.Id)DESC

	END TRY
	BEGIN CATCH
		IF @@Trancount>0 
			ROLLBACK TRANSACTION Modificacion;

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
/****** Object:  StoredProcedure [dbo].[sp_PlanillaSemanal]    Script Date: 6/23/2021 6:06:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_PlanillaSemanal]
	-- Parametros de entrada
	@InEmpleado INT,

	-- Parametros de salida
	@OutResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		SET @OutResultCode = 0

		IF NOT EXISTS (SELECT 1 FROM dbo.Empleado WHERE Id = @InEmpleado)
		BEGIN
			SET @OutResultCode = 5001			-- Error por si no encuentra el empleado
			RETURN
		END
		
		SELECT TOP(15)
			Planilla.Id,
			Planilla.SalarioBruto,
			Planilla.SalarioNeto,
			Planilla.SalarioBruto - Planilla.SalarioNeto AS TotalDeducciones,
			dbo.CalcularHorasOrdinarias(Planilla.Id) AS HorasOrdinarias,
			dbo.CalcularHorasExtras(Planilla.Id) AS HorasExtraordinarias,
			dbo.CalcularHorasDobles(Planilla.Id) AS HorasExtraordinariasDobles
		FROM PlanillaXSemanaXEmpleado AS Planilla
		WHERE IdEmpleado = @InEmpleado
		ORDER BY (Id)DESC


	END TRY
	BEGIN CATCH
		IF @@Trancount>0 
			ROLLBACK TRANSACTION Modificacion;

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
/****** Object:  StoredProcedure [dbo].[sp_ValidarUsuario]    Script Date: 6/23/2021 6:06:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_ValidarUsuario]
-- parametros de entrada
	@innombre VARCHAR(64),
	@incontrasena VARCHAR(64),

-- parametros de salida
	@OutResultCode INT OUTPUT
	
	AS
	BEGIN
		SET NOCOUNT ON;
		BEGIN TRY
			SELECT
				@OutResultCode=0  -- codigo de ejecucion exitoso

			SELECT * FROM dbo.Usuario
			WHERE Username = @innombre
			AND Pwd = @incontrasena
			AND activo = 1
		END TRY
		BEGIN CATCH
			Set @OutResultCode=50005; -- error de ejecucion
		END CATCH;
		SET NOCOUNT OFF;
END
GO
USE [master]
GO
ALTER DATABASE [BDPlanillaObrera] SET  READ_WRITE 
GO
