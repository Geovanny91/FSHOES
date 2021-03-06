USE [fshoes]
GO
/****** Object:  StoredProcedure [dbo].[pa_cliente]    Script Date: 26/04/2016 13:43:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pa_cliente]
	@prmvalor varchar(30),
	@prmtipo varchar(100),
	
	@razonsocial varchar(100),
	@ruc varchar(11),
	@direccion varchar(100),
	@estado bit

	AS 

	IF @prmtipo = 'listarCliente'
		BEGIN
			SELECT TOP 3 idcliente, razonsocial, ruc, direccion
			FROM cliente 
			WHERE (razonsocial LIKE @prmvalor+'%' OR ruc LIKE @prmvalor + '%') AND estado = 1 ; --__% empieza despues de dos letras cualquiera
		END
	IF @prmtipo = 'registrarCliente'
		BEGIN 
			INSERT INTO cliente(razonsocial, ruc, direccion, estado) VALUES(@razonsocial, @ruc, @direccion, @estado);
		END

GO
/****** Object:  StoredProcedure [dbo].[pa_proceso]    Script Date: 26/04/2016 13:43:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[pa_proceso]
AS
BEGIN 
	select codigoproceso, descripcion from Proceso;
END
GO
/****** Object:  StoredProcedure [dbo].[pa_proveedor]    Script Date: 26/04/2016 13:43:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[pa_proveedor]
@prmvalor varchar(30),
	@prmtipo varchar(100),
	
	@razonsocial varchar(100),
	@ruc varchar(11),
	@direccion varchar(100),
	@estado bit

	AS 

	IF @prmtipo = 'listarProveedor'
		BEGIN
			SELECT TOP 3 idproveedor, razonsocial, ruc, direccion
			FROM Proveedor 
			WHERE (razonsocial LIKE @prmvalor+'%' OR ruc LIKE @prmvalor + '%') AND estado = 1 ; --__% empieza despues de dos letras cualquiera
		END
	IF @prmtipo = 'registrarProveedor'
		BEGIN 
			INSERT INTO Proveedor(razonsocial, ruc, direccion, estado) VALUES(@razonsocial, @ruc, @direccion, @estado);
		END


GO
/****** Object:  StoredProcedure [dbo].[verificar_acceso]    Script Date: 26/04/2016 13:43:47 ******/
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
/****** Object:  Table [dbo].[Cliente]    Script Date: 26/04/2016 13:43:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cliente](
	[idcliente] [int] IDENTITY(1,1) NOT NULL,
	[razonsocial] [varchar](100) NULL,
	[ruc] [varchar](11) NULL,
	[direccion] [varchar](100) NULL,
	[estado] [bit] NULL,
 CONSTRAINT [PK_Cliente] PRIMARY KEY CLUSTERED 
(
	[idcliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Material]    Script Date: 26/04/2016 13:43:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Material](
	[idmaterial] [int] NOT NULL,
	[descripccion] [varchar](50) NULL,
	[unidadmedida] [varchar](50) NULL,
	[cantidaddocena] [int] NULL,
	[preciounitario] [decimal](18, 0) NULL,
	[tipo] [varchar](50) NULL,
	[color] [varchar](30) NULL,
	[idproveedor] [int] NULL,
 CONSTRAINT [PK_MATERIAL] PRIMARY KEY CLUSTERED 
(
	[idmaterial] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Modelo]    Script Date: 26/04/2016 13:43:47 ******/
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
/****** Object:  Table [dbo].[Orden]    Script Date: 26/04/2016 13:43:47 ******/
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
/****** Object:  Table [dbo].[Proceso]    Script Date: 26/04/2016 13:43:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Proceso](
	[codigoproceso] [varchar](10) NOT NULL,
	[descripcion] [varchar](50) NULL,
	[idmaterial] [int] NULL,
 CONSTRAINT [PK_Proceso] PRIMARY KEY CLUSTERED 
(
	[codigoproceso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Proveedor]    Script Date: 26/04/2016 13:43:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Proveedor](
	[idproveedor] [int] IDENTITY(1,1) NOT NULL,
	[razonsocial] [varchar](100) NULL,
	[ruc] [varchar](11) NULL,
	[direccion] [varchar](100) NULL,
	[estado] [bit] NULL,
 CONSTRAINT [PK_Proveedor] PRIMARY KEY CLUSTERED 
(
	[idproveedor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Serie]    Script Date: 26/04/2016 13:43:47 ******/
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
/****** Object:  Table [dbo].[Trabajador]    Script Date: 26/04/2016 13:43:47 ******/
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
SET IDENTITY_INSERT [dbo].[Cliente] ON 

INSERT [dbo].[Cliente] ([idcliente], [razonsocial], [ruc], [direccion], [estado]) VALUES (1, N'ABC', N'14785296321', N'urb. abc', 1)
INSERT [dbo].[Cliente] ([idcliente], [razonsocial], [ruc], [direccion], [estado]) VALUES (2, N'ABCDE', N'12345678912', N'urb. edc', 1)
INSERT [dbo].[Cliente] ([idcliente], [razonsocial], [ruc], [direccion], [estado]) VALUES (3, N'DEFGH', N'14785296332', N'urb. qwe 123', 1)
INSERT [dbo].[Cliente] ([idcliente], [razonsocial], [ruc], [direccion], [estado]) VALUES (4, N'JKLN', N'85296374121', N'urb. thg', 1)
INSERT [dbo].[Cliente] ([idcliente], [razonsocial], [ruc], [direccion], [estado]) VALUES (5, N'JKGDT', N'14785296332', N'Urb. qwsa 15', 1)
INSERT [dbo].[Cliente] ([idcliente], [razonsocial], [ruc], [direccion], [estado]) VALUES (6, NULL, NULL, NULL, 1)
INSERT [dbo].[Cliente] ([idcliente], [razonsocial], [ruc], [direccion], [estado]) VALUES (7, NULL, NULL, NULL, 1)
INSERT [dbo].[Cliente] ([idcliente], [razonsocial], [ruc], [direccion], [estado]) VALUES (8, N'gdfgdf', N'76756', N'hjghfjgh', 1)
INSERT [dbo].[Cliente] ([idcliente], [razonsocial], [ruc], [direccion], [estado]) VALUES (9, N'sdfsdfs', N'365654', N'gdfgdfg', 1)
INSERT [dbo].[Cliente] ([idcliente], [razonsocial], [ruc], [direccion], [estado]) VALUES (10, N'razon no se', N'1234556', N'fjsdklfhsdlf', 0)
INSERT [dbo].[Cliente] ([idcliente], [razonsocial], [ruc], [direccion], [estado]) VALUES (11, N'AASSDSDS', N'12345435646', N'QWEW', 1)
SET IDENTITY_INSERT [dbo].[Cliente] OFF
INSERT [dbo].[Proceso] ([codigoproceso], [descripcion], [idmaterial]) VALUES (N'CP1', N'Corte', NULL)
INSERT [dbo].[Proceso] ([codigoproceso], [descripcion], [idmaterial]) VALUES (N'CP2', N'Aparado', NULL)
INSERT [dbo].[Proceso] ([codigoproceso], [descripcion], [idmaterial]) VALUES (N'CP3', N'Armado', NULL)
INSERT [dbo].[Proceso] ([codigoproceso], [descripcion], [idmaterial]) VALUES (N'CP4', N'Alistado', NULL)
SET IDENTITY_INSERT [dbo].[Proveedor] ON 

INSERT [dbo].[Proveedor] ([idproveedor], [razonsocial], [ruc], [direccion], [estado]) VALUES (1, N'Aqz', N'74185296332', N'Urb. xyz #123', 1)
INSERT [dbo].[Proveedor] ([idproveedor], [razonsocial], [ruc], [direccion], [estado]) VALUES (2, N'Wer', N'21457896324', N'Urb. gtr #95', 1)
INSERT [dbo].[Proveedor] ([idproveedor], [razonsocial], [ruc], [direccion], [estado]) VALUES (3, NULL, N'43534534534', N'HFGHFGH', 1)
INSERT [dbo].[Proveedor] ([idproveedor], [razonsocial], [ruc], [direccion], [estado]) VALUES (4, N'FDGDFGDFG', N'34567677868', N'SDFSDF', 1)
SET IDENTITY_INSERT [dbo].[Proveedor] OFF
SET IDENTITY_INSERT [dbo].[Trabajador] ON 

INSERT [dbo].[Trabajador] ([idempleado], [dni], [nombres], [ape_paterno], [ape_materno], [direccion], [telefono], [celular], [fecha_nacimiento], [usuario], [contrasena], [estado], [codigoproceso]) VALUES (1, N'30748596', N'David', N'Rojas', N'Avila', N'Urb. La Libertad', N'044214578', N'948565217', CAST(0x450F0B00 AS Date), N'dav', N'123', 1, N'CP1')
INSERT [dbo].[Trabajador] ([idempleado], [dni], [nombres], [ape_paterno], [ape_materno], [direccion], [telefono], [celular], [fecha_nacimiento], [usuario], [contrasena], [estado], [codigoproceso]) VALUES (2, N'31854521', N'Miguel', N'Torres', N'Vega', N'Rinconada N 145', N'044217403', N'945862324', CAST(0x3D100B00 AS Date), N'mig', N'123', 1, N'CP2')
SET IDENTITY_INSERT [dbo].[Trabajador] OFF
ALTER TABLE [dbo].[Material]  WITH CHECK ADD  CONSTRAINT [FK_Material_Proveedor] FOREIGN KEY([idproveedor])
REFERENCES [dbo].[Proveedor] ([idproveedor])
GO
ALTER TABLE [dbo].[Material] CHECK CONSTRAINT [FK_Material_Proveedor]
GO
ALTER TABLE [dbo].[Modelo]  WITH CHECK ADD  CONSTRAINT [FK_Modelo_Cliente] FOREIGN KEY([idcliente])
REFERENCES [dbo].[Cliente] ([idcliente])
GO
ALTER TABLE [dbo].[Modelo] CHECK CONSTRAINT [FK_Modelo_Cliente]
GO
ALTER TABLE [dbo].[Proceso]  WITH CHECK ADD  CONSTRAINT [FK_Proceso_Materiales] FOREIGN KEY([idmaterial])
REFERENCES [dbo].[Material] ([idmaterial])
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
