USE [fshoes]
GO
/****** Object:  StoredProcedure [dbo].[verificar_acceso]    Script Date: 16/04/2016 13:46:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[verificar_acceso]
@prmUsuario varchar(50), 
@prmContrasena varchar(50)
AS
BEGIN
	SELECT usuario, contrasena, t.nombres, t.ape_paterno, t.ape_materno, p.codigoproceso, p.descripcion 
	FROM Trabajador t INNER JOIN Proceso p
	ON t.codigoproceso = p.codigoproceso
	WHERE usuario = @prmUsuario and contrasena = @prmContrasena
END	

GO
/****** Object:  Table [dbo].[Cliente]    Script Date: 16/04/2016 13:46:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cliente](
	[idcliente] [int] NOT NULL,
	[razonsocial] [varchar](100) NULL,
	[ruc] [varchar](11) NULL,
	[direccion] [varchar](100) NULL,
	[estado] [tinyint] NULL,
 CONSTRAINT [PK_Cliente] PRIMARY KEY CLUSTERED 
(
	[idcliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Empleado]    Script Date: 16/04/2016 13:46:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Empleado](
	[idempleado] [int] NOT NULL,
	[dni] [varchar](8) NULL,
	[nombres] [varchar](50) NULL,
	[ape_paterno] [varchar](50) NULL,
	[ape_materno] [varchar](50) NULL,
	[direccion] [varbinary](100) NULL,
	[telefono] [varchar](15) NULL,
	[celular] [varchar](15) NULL,
	[fecha_nacimiento] [date] NULL,
	[usuario] [varchar](50) NULL,
	[contrasena] [varchar](50) NULL,
	[estado] [tinyint] NULL,
	[codigoproceso] [varchar](10) NULL,
 CONSTRAINT [PK_Empleado] PRIMARY KEY CLUSTERED 
(
	[idempleado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Materiales]    Script Date: 16/04/2016 13:46:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Materiales](
	[idmateriales] [int] NOT NULL,
	[descripccion] [varchar](50) NULL,
	[unidadmedida] [varchar](50) NULL,
	[cantidaddocena] [int] NULL,
	[preciounitario] [decimal](18, 0) NULL,
	[tipo] [varchar](50) NULL,
	[color] [varchar](30) NULL,
	[idproveedor] [int] NULL,
 CONSTRAINT [PK_MATERIALES] PRIMARY KEY CLUSTERED 
(
	[idmateriales] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Modelo]    Script Date: 16/04/2016 13:46:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Modelo](
	[codigomodelo] [varchar](10) NOT NULL,
	[urlimagen] [varchar](100) NULL,
	[horma] [varchar](50) NULL,
	[taco] [varchar](50) NULL,
	[plataforma] [varchar](50) NULL,
	[coleccion] [varchar](50) NULL,
	[especificacion] [text] NULL,
	[idcliente] [int] NULL,
 CONSTRAINT [PK_Modelo] PRIMARY KEY CLUSTERED 
(
	[codigomodelo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Orden]    Script Date: 16/04/2016 13:46:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Orden](
	[codigoorden] [varchar](10) NOT NULL,
	[orden_pedido] [varchar](10) NULL,
	[fecha_emision] [datetime] NULL,
	[fecha_entrega] [datetime] NULL,
	[total] [decimal](18, 0) NULL,
 CONSTRAINT [PK_Orden] PRIMARY KEY CLUSTERED 
(
	[codigoorden] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Proceso]    Script Date: 16/04/2016 13:46:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Proceso](
	[codigoproceso] [varchar](10) NOT NULL,
	[descripcion] [varchar](50) NULL,
	[idmateriales] [int] NULL,
 CONSTRAINT [PK_Proceso] PRIMARY KEY CLUSTERED 
(
	[codigoproceso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Proveedor]    Script Date: 16/04/2016 13:46:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Proveedor](
	[idproveedor] [int] NOT NULL,
	[razonsocial] [varchar](100) NULL,
	[ruc] [varchar](11) NULL,
	[direccion] [varchar](100) NULL,
	[estado] [tinyint] NULL,
 CONSTRAINT [PK_Proveedor] PRIMARY KEY CLUSTERED 
(
	[idproveedor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Serie]    Script Date: 16/04/2016 13:46:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Serie](
	[idserie] [int] NOT NULL,
	[tallas] [tinyint] NULL,
	[pares] [tinyint] NULL,
	[codigoorden] [varchar](10) NULL,
 CONSTRAINT [PK_Serie] PRIMARY KEY CLUSTERED 
(
	[idserie] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Trabajador]    Script Date: 16/04/2016 13:46:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Trabajador](
	[idempleado] [int] IDENTITY(1,1) NOT NULL,
	[dni] [varchar](8) NULL,
	[nombres] [varchar](50) NULL,
	[ape_paterno] [varchar](50) NULL,
	[ape_materno] [varchar](50) NULL,
	[direccion] [varchar](100) NULL,
	[telefono] [varchar](15) NULL,
	[celular] [varchar](15) NULL,
	[fecha_nacimiento] [date] NULL,
	[usuario] [varchar](50) NULL,
	[contrasena] [varchar](50) NULL,
	[estado] [tinyint] NULL,
	[codigoproceso] [varchar](10) NULL,
 CONSTRAINT [PK_Trabajador] PRIMARY KEY CLUSTERED 
(
	[idempleado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[Proceso] ([codigoproceso], [descripcion], [idmateriales]) VALUES (N'CP1', N'CORTE', NULL)
INSERT [dbo].[Proceso] ([codigoproceso], [descripcion], [idmateriales]) VALUES (N'CP2', N'APARADO', NULL)
INSERT [dbo].[Proceso] ([codigoproceso], [descripcion], [idmateriales]) VALUES (N'CP3', N'ARMADADO', NULL)
INSERT [dbo].[Proceso] ([codigoproceso], [descripcion], [idmateriales]) VALUES (N'CP4', N'ALISTADO', NULL)
SET IDENTITY_INSERT [dbo].[Trabajador] ON 

INSERT [dbo].[Trabajador] ([idempleado], [dni], [nombres], [ape_paterno], [ape_materno], [direccion], [telefono], [celular], [fecha_nacimiento], [usuario], [contrasena], [estado], [codigoproceso]) VALUES (1, N'30748596', N'David', N'Rojas', N'Avila', N'Urb. La Libertad', N'044214578', N'948565217', CAST(0x450F0B00 AS Date), N'dav', N'123', 1, N'CP1')
INSERT [dbo].[Trabajador] ([idempleado], [dni], [nombres], [ape_paterno], [ape_materno], [direccion], [telefono], [celular], [fecha_nacimiento], [usuario], [contrasena], [estado], [codigoproceso]) VALUES (2, N'31854521', N'Miguel', N'Torres', N'Vega', N'Rinconada N 145', N'044217403', N'945862324', CAST(0x3D100B00 AS Date), N'mig', N'123', 1, N'CP2')
SET IDENTITY_INSERT [dbo].[Trabajador] OFF
ALTER TABLE [dbo].[Materiales]  WITH CHECK ADD  CONSTRAINT [FK_Materiales_Proveedor] FOREIGN KEY([idproveedor])
REFERENCES [dbo].[Proveedor] ([idproveedor])
GO
ALTER TABLE [dbo].[Materiales] CHECK CONSTRAINT [FK_Materiales_Proveedor]
GO
ALTER TABLE [dbo].[Modelo]  WITH CHECK ADD  CONSTRAINT [FK_Modelo_Cliente] FOREIGN KEY([idcliente])
REFERENCES [dbo].[Cliente] ([idcliente])
GO
ALTER TABLE [dbo].[Modelo] CHECK CONSTRAINT [FK_Modelo_Cliente]
GO
ALTER TABLE [dbo].[Proceso]  WITH CHECK ADD  CONSTRAINT [FK_Proceso_Materiales] FOREIGN KEY([idmateriales])
REFERENCES [dbo].[Materiales] ([idmateriales])
GO
ALTER TABLE [dbo].[Proceso] CHECK CONSTRAINT [FK_Proceso_Materiales]
GO
ALTER TABLE [dbo].[Serie]  WITH CHECK ADD  CONSTRAINT [FK_Serie_Orden] FOREIGN KEY([codigoorden])
REFERENCES [dbo].[Orden] ([codigoorden])
GO
ALTER TABLE [dbo].[Serie] CHECK CONSTRAINT [FK_Serie_Orden]
GO
ALTER TABLE [dbo].[Trabajador]  WITH CHECK ADD  CONSTRAINT [FK_Trabajador_Proceso] FOREIGN KEY([codigoproceso])
REFERENCES [dbo].[Proceso] ([codigoproceso])
GO
ALTER TABLE [dbo].[Trabajador] CHECK CONSTRAINT [FK_Trabajador_Proceso]
GO
