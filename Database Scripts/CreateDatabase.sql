USE [BDPlanillaObrera]
GO
/****** Object:  Table [dbo].[DeduccionNoObligatoriaFija]    Script Date: 13/06/2021 1:50:00 ******/
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
/****** Object:  Table [dbo].[DeduccionNoObligatoriaPorcentual]    Script Date: 13/06/2021 1:50:00 ******/
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
/****** Object:  Table [dbo].[DeduccionObligatoriaPorcentual]    Script Date: 13/06/2021 1:50:00 ******/
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
/****** Object:  Table [dbo].[DeduccionXEmpleado]    Script Date: 13/06/2021 1:50:00 ******/
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
/****** Object:  Table [dbo].[DeduccionXMesXEmpleado]    Script Date: 13/06/2021 1:50:00 ******/
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
/****** Object:  Table [dbo].[Departamento]    Script Date: 13/06/2021 1:50:00 ******/
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
/****** Object:  Table [dbo].[Empleado]    Script Date: 13/06/2021 1:50:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Empleado](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](64) NOT NULL,
	[ValorDocumento] [varchar](32) NOT NULL,
	[FechaNacimiento] [date] NOT NULL,
	[IdPuesto] [int] NOT NULL,
	[IdTipoDocumento] [int] NOT NULL,
	[IdDepartamento] [int] NOT NULL,
	[idUsuario] [int] NOT NULL,
	[Activo] [bit] NOT NULL,
 CONSTRAINT [PK_Empleado] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Errores]    Script Date: 13/06/2021 1:50:00 ******/
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
/****** Object:  Table [dbo].[Feriado]    Script Date: 13/06/2021 1:50:00 ******/
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
/****** Object:  Table [dbo].[Jornada]    Script Date: 13/06/2021 1:50:00 ******/
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
/****** Object:  Table [dbo].[MarcaAsistencia]    Script Date: 13/06/2021 1:50:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MarcaAsistencia](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[HoraEntrada] [datetime] NULL,
	[HoraSalida] [datetime] NULL,
	[IdJornada] [int] NOT NULL,
	[HorasOrdinarias] [int] NOT NULL,
	[HorasExtraordinarias] [int] NOT NULL,
	[HorasDobles] [int] NOT NULL,
 CONSTRAINT [PK_MarcaAsistencia] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MesPlanilla]    Script Date: 13/06/2021 1:50:00 ******/
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
/****** Object:  Table [dbo].[MovimientoDeduccion]    Script Date: 13/06/2021 1:50:00 ******/
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
/****** Object:  Table [dbo].[MovimientoGanancia]    Script Date: 13/06/2021 1:50:00 ******/
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
/****** Object:  Table [dbo].[MovimientoPlanilla]    Script Date: 13/06/2021 1:50:00 ******/
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
/****** Object:  Table [dbo].[PlanillaXMesXEmpleado]    Script Date: 13/06/2021 1:50:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlanillaXMesXEmpleado](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SalarioBruto] [decimal](18, 3) NOT NULL,
	[SalarioNeto] [decimal](18, 3) NOT NULL,
	[IdMesPlanilla] [int] NOT NULL,
 CONSTRAINT [PK_PlanillaXMesXEmpleado] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PlanillaXSemanaXEmpleado]    Script Date: 13/06/2021 1:50:00 ******/
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
/****** Object:  Table [dbo].[Puesto]    Script Date: 13/06/2021 1:50:00 ******/
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
/****** Object:  Table [dbo].[SemanaPlanilla]    Script Date: 13/06/2021 1:50:00 ******/
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
/****** Object:  Table [dbo].[TipoDeduccion]    Script Date: 13/06/2021 1:50:00 ******/
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
/****** Object:  Table [dbo].[TipoDocumentoIdentidad]    Script Date: 13/06/2021 1:50:00 ******/
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
/****** Object:  Table [dbo].[TipoJornada]    Script Date: 13/06/2021 1:50:00 ******/
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
/****** Object:  Table [dbo].[TipoMovimiento]    Script Date: 13/06/2021 1:50:00 ******/
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
/****** Object:  Table [dbo].[Usuario]    Script Date: 13/06/2021 1:50:00 ******/
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
ALTER TABLE [dbo].[Empleado]  WITH CHECK ADD  CONSTRAINT [FK_Empleado_Usuario] FOREIGN KEY([idUsuario])
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
/****** Object:  StoredProcedure [dbo].[sp_CargarCatalogos]    Script Date: 13/06/2021 1:50:00 ******/
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
	FROM OPENROWSET(BULK 'C:\Users\rolbi\Desktop\Datos_Tarea3.xml', SINGLE_BLOB) AS T(MY_XML)

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
/****** Object:  StoredProcedure [dbo].[sp_CargarInsercionEmpleados]    Script Date: 13/06/2021 1:50:00 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_CargarTipoDeduccion]    Script Date: 13/06/2021 1:50:00 ******/
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
				BULK 'C:\Users\rolbi\Desktop\Datos_Tarea3.xml',
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
/****** Object:  StoredProcedure [dbo].[sp_InsertarEmpleado]    Script Date: 13/06/2021 1:50:00 ******/
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
