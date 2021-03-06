USE [fshoes]
GO
/****** Object:  Table [dbo].[Cliente]    Script Date: 12/04/2016 8:23:22 ******/
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
/****** Object:  Table [dbo].[Materiales]    Script Date: 12/04/2016 8:23:22 ******/
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
/****** Object:  Table [dbo].[Modelo]    Script Date: 12/04/2016 8:23:22 ******/
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
/****** Object:  Table [dbo].[Orden]    Script Date: 12/04/2016 8:23:22 ******/
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
/****** Object:  Table [dbo].[Proceso]    Script Date: 12/04/2016 8:23:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Proceso](
	[codigoproceso] [varchar](10) NOT NULL,
	[descripccion] [varchar](50) NULL,
	[idmateriales] [int] NULL,
 CONSTRAINT [PK_Proceso] PRIMARY KEY CLUSTERED 
(
	[codigoproceso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Proveedor]    Script Date: 12/04/2016 8:23:22 ******/
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
/****** Object:  Table [dbo].[Serie]    Script Date: 12/04/2016 8:23:22 ******/
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
/****** Object:  Table [dbo].[Trabajador]    Script Date: 12/04/2016 8:23:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Trabajador](
	[idtrabajador] [int] NOT NULL,
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
 CONSTRAINT [PK_Trabajador] PRIMARY KEY CLUSTERED 
(
	[idtrabajador] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
