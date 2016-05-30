USE [fshoes]
GO
/****** Object:  StoredProcedure [dbo].[pa_cliente]    Script Date: 30/05/2016 14:19:33 ******/
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
			SELECT TOP 5 idcliente, razonsocial, ruc, direccion
			FROM cliente 
			WHERE (razonsocial LIKE @prmvalor+'%' OR ruc LIKE @prmvalor + '%') AND estado = 1 ; --__% empieza despues de dos letras cualquiera
		END
	IF @prmtipo = 'registrarCliente'
		BEGIN 
			INSERT INTO cliente(razonsocial, ruc, direccion, estado) VALUES(@razonsocial, @ruc, @direccion, @estado);
		END

GO
/****** Object:  StoredProcedure [dbo].[pa_detalle_orden]    Script Date: 30/05/2016 14:19:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pa_detalle_orden]
@prmvalor varchar(30),
@prmtipo varchar(100),
@codigoorden varchar(15),
@idempleado int,
@estado bit

AS 

IF @prmtipo = 'listarDetalleOrden'
	BEGIN
		SELECT do.codigoorden, do.idempleado, do.estado, t.nombres, t.ape_paterno, t.ape_materno, p.codigoproceso, p.descripcion FROM DetalleOrden do 
		INNER JOIN Orden o ON do.codigoorden = o.codigoorden
		INNER JOIN Trabajador t ON do.idempleado = t.idempleado
		INNER JOIN Proceso p ON t.codigoproceso = p.codigoproceso
		WHERE do.codigoorden = @prmvalor;
	END
IF @prmtipo = 'asignarOrden'
	BEGIN
		INSERT INTO DetalleOrden (codigoorden, idempleado, estado) VALUES (@codigoorden, @idempleado, @estado);
	END

GO
/****** Object:  StoredProcedure [dbo].[pa_material]    Script Date: 30/05/2016 14:19:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pa_material]
	@prmvalor varchar(30),
	@prmtipo varchar(100),
	@inicio int,
	@fin int,
	
	@idmaterial int,
	@nombre varchar(50),
	@descripcion varchar(100),
	@unidadmedida varchar(30),
	@cantidaddocena decimal(18,2),
	@preciounitario decimal(18, 2),
	@tipo varchar(25),
	@color varchar(25),
	@idproveedor int,
	@codigoproceso varchar(15), 
	@codigomodelo varchar(15)

	AS 

	IF @prmtipo = 'listarMaterial'
		BEGIN
			SELECT  m.idmaterial, m.nombre, m.descripcion, m.unidadmedida, m.cantidaddocena, m.preciounitario, p.razonsocial, m.idproveedor, m.tipo, m.color, m.codigoproceso, pr.descripcion as procDescripcion, m.codigomodelo
			FROM (SELECT idmaterial, nombre, descripcion, unidadmedida, cantidaddocena, preciounitario, idproveedor, tipo, color, codigoproceso, codigomodelo, ROW_NUMBER() OVER (ORDER BY idmaterial) as fila FROM Material) as m 
			INNER JOIN Proveedor p ON m.idproveedor = p.idproveedor
			INNER JOIN Proceso pr ON m.codigoproceso = pr.codigoproceso
			INNER JOIN Modelo mo ON m.codigomodelo = mo.codigomodelo
			WHERE m.fila > @inicio and m.fila <= @fin;--MODIFICADO EN CASA 23/05/2016 cambiar a id incrementado
		END
	IF @prmtipo = 'registrarMaterial'
		BEGIN 
			INSERT INTO Material(nombre, descripcion, unidadmedida, cantidaddocena, preciounitario, tipo, color, idproveedor, codigoproceso, codigomodelo) 
			VALUES(@nombre, @descripcion, @unidadmedida, @cantidaddocena, @preciounitario, @tipo, @color, @idproveedor, @codigoproceso, @codigomodelo );
		END
	IF @prmtipo = 'modificarMaterial'
		BEGIN 
			UPDATE Material 
			SET nombre = @nombre, descripcion = @descripcion, unidadmedida = @unidadmedida, cantidaddocena = @cantidaddocena, preciounitario = @preciounitario,
			 tipo = @tipo, color = @color, idproveedor= @idproveedor
			WHERE idmaterial = @idmaterial
		END
	IF @prmtipo = 'obtenerTotal'
	BEGIN
		SELECT COUNT(idmaterial) AS total FROM Material;--MODIFICADO EN CASA 23/05/2016
	END

GO
/****** Object:  StoredProcedure [dbo].[pa_modelo]    Script Date: 30/05/2016 14:19:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pa_modelo]
	@prmvalor varchar(30),
	@prmtipo varchar(100),
	@inicio int,
	@fin int,
	
	@codigomodelo varchar(10),
	@urlimagen varchar(100),
	@horma varchar(50),
	@taco varchar(50),
	@plataforma varchar(50),
	@coleccion varchar(50),
	@especificacion text,
	@idcliente int,
	@estado bit

	AS 

	IF @prmtipo = 'listarModeloPaginacion'
		BEGIN
			SELECT  codigomodelo, m.urlimagen, m.horma, m.taco, m.plataforma, m.coleccion, m.especificacion, m.idcliente, c.razonsocial, m.estado
			FROM (SELECT codigomodelo, urlimagen, horma, taco, plataforma, coleccion, especificacion, idcliente, estado, ROW_NUMBER() OVER (ORDER BY codigomodelo desc) as fila FROM Modelo) as m INNER JOIN Cliente c
			ON m.idcliente = c.idcliente
			WHERE m.fila > @inicio and m.fila <= @fin and m.estado = 1;--aquí, agregué el estado para todos los modelo activos
			/*SELECT m.codigomodelo FROM 
			(SELECT codigomodelo, ROW_NUMBER() OVER (ORDER BY codigomodelo) as fila FROM Modelo) as m
			WHERE m.fila > 0 and m.fila <= 7*/
		END
	IF @prmtipo = 'listarModelo'
		BEGIN
			SELECT TOP 5 codigomodelo, horma, taco, plataforma, coleccion, m.idcliente, c.razonsocial
			FROM Modelo m INNER JOIN Cliente c 
			ON m.idcliente = c.idcliente
			WHERE (codigomodelo LIKE @prmvalor+'%' OR c.razonsocial LIKE @prmvalor + '%') AND m.estado = 1 ; --__% empieza despues de dos letras cualquiera
		END
	IF @prmtipo = 'registrarModelo'
		BEGIN 
			INSERT INTO Modelo(codigomodelo, urlimagen, horma, taco, plataforma, coleccion, especificacion, idcliente, estado) 
			VALUES(@codigomodelo, 'urlimagen', @horma, @taco, @plataforma, @coleccion, @especificacion, @idcliente, @estado );
		END
	IF @prmtipo = 'modificarModelo'
		BEGIN 
			UPDATE Modelo 
			SET horma = @horma, taco = @taco, plataforma=@plataforma, coleccion=@coleccion, especificacion=@especificacion, idcliente = @idcliente, estado = @estado
			WHERE codigomodelo = @codigomodelo
		END
	IF @prmtipo = 'obtenerTotal'
		BEGIN
			SELECT COUNT(codigomodelo) AS total FROM Modelo;
		END

GO
/****** Object:  StoredProcedure [dbo].[pa_orden]    Script Date: 30/05/2016 14:19:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pa_orden]
	@prmvalor varchar(30),
	@prmtipo varchar(100),
	
	@codigoorden varchar(10),
	@orden_pedido varchar(10),
	@fecha_emision varchar(10),
	@fecha_entrega varchar(10),
	@total decimal(18,2),
	@codigomodelo varchar(15)
	
	AS 

	IF @prmtipo = 'listarOrden'--ver ordenes por rango de fechas
		BEGIN
			SELECT codigoorden, orden_pedido, fecha_emision, fecha_entrega, total
			FROM Orden
		END
	IF @prmtipo = 'registrarOrden'
		BEGIN 
			INSERT INTO Orden(codigoorden, orden_pedido, fecha_emision, fecha_entrega, codigomodelo, total) VALUES(@codigoorden, @orden_pedido, @fecha_emision, @fecha_entrega, @codigomodelo, @total);
		END

GO
/****** Object:  StoredProcedure [dbo].[pa_proceso]    Script Date: 30/05/2016 14:19:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[pa_proceso]
@prmvalor varchar(30),
@prmtipo varchar(100)
AS
IF @prmtipo = 'listarProceso'
	BEGIN
		SELECT TOP 4 codigoproceso, descripcion
		FROM Proceso 
		WHERE (descripcion LIKE @prmvalor+'%' OR codigoproceso LIKE @prmvalor + '%'); --__% empieza despues de dos letras cualquiera
	END
IF @prmtipo = 'listarcomboProceso'
	BEGIN
		SELECT codigoproceso, descripcion FROM Proceso;		
	END



GO
/****** Object:  StoredProcedure [dbo].[pa_proveedor]    Script Date: 30/05/2016 14:19:33 ******/
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
/****** Object:  StoredProcedure [dbo].[pa_serie]    Script Date: 30/05/2016 14:19:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[pa_serie]
	@prmvalor varchar(30),
	@prmtipo varchar(100),
	
	@tallas int,
	@pares int,
	@codigoorden varchar(10)

	AS 

	IF @prmtipo = 'listarSerie'
		BEGIN
			SELECT tallas, pares, codigoorden
			FROM Serie WHERE codigoorden = @prmvalor;
		END
	IF @prmtipo = 'registrarSerie'
		BEGIN 
			INSERT INTO Serie(tallas, pares, codigoorden) VALUES(@tallas, @pares, @codigoorden);
		END


GO
/****** Object:  StoredProcedure [dbo].[pa_trabajador]    Script Date: 30/05/2016 14:19:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pa_trabajador]
@prmvalor varchar(30),
@prmtipo varchar(100),

@dni varchar(8),
@nombres varchar(50),
@ape_paterno varchar(50),
@ape_materno varchar(50),
@direccion varchar(100),
@telefono varchar(15),
@celular varchar(15),
@fecha_nacimiento varchar(10),
@usuario varchar(50),
@contrasena varchar(50),
@estado varchar(50),
@codigoproceso varchar(10)

AS 

IF @prmtipo = 'listarTrabajador'
    BEGIN
        SELECT TOP 3 dni, nombres, ape_paterno, ape_materno, direccion, p.descripcion
        FROM Trabajador t INNER JOIN Proceso P
		ON T.codigoproceso = P.codigoproceso
        WHERE estado = 1 ;
    END
IF @prmtipo = 'listarcomboTrabajador'
    BEGIN
        SELECT nombres, ape_paterno, ape_materno 
        FROM Trabajador t INNER JOIN Proceso P
		ON T.codigoproceso = P.codigoproceso
        WHERE p.codigoproceso = @prmvalor and estado = 1 ;
    END
IF @prmtipo = 'registrarTrabajador'
    BEGIN 
        INSERT INTO Trabajador(dni, nombres, ape_paterno, ape_materno, direccion, telefono, celular, fecha_nacimiento, usuario, contrasena, estado, codigoproceso) 
				VALUES(@dni, @nombres, @ape_paterno, @ape_materno, @direccion, @telefono, @celular, @fecha_nacimiento, @usuario, @contrasena, @estado, @codigoproceso);
    END
GO
/****** Object:  StoredProcedure [dbo].[verificar_acceso]    Script Date: 30/05/2016 14:19:33 ******/
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
/****** Object:  Table [dbo].[Cliente]    Script Date: 30/05/2016 14:19:33 ******/
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
/****** Object:  Table [dbo].[DetalleOrden]    Script Date: 30/05/2016 14:19:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DetalleOrden](
	[codigoorden] [varchar](15) NULL,
	[idempleado] [int] NULL,
	[estado] [bit] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Material]    Script Date: 30/05/2016 14:19:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Material](
	[idmaterial] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](50) NULL,
	[descripcion] [varchar](100) NULL,
	[unidadmedida] [varchar](30) NULL,
	[cantidaddocena] [decimal](18, 2) NULL,
	[preciounitario] [decimal](18, 2) NULL,
	[tipo] [varchar](25) NULL,
	[color] [varchar](25) NULL,
	[idproveedor] [int] NULL,
	[codigoproceso] [varchar](15) NULL,
	[codigomodelo] [varchar](15) NULL,
 CONSTRAINT [PK_MATERIAL] PRIMARY KEY CLUSTERED 
(
	[idmaterial] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Modelo]    Script Date: 30/05/2016 14:19:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Modelo](
	[codigomodelo] [varchar](15) NOT NULL,
	[urlimagen] [varchar](100) NULL,
	[horma] [varchar](50) NULL,
	[taco] [varchar](50) NULL,
	[plataforma] [varchar](50) NULL,
	[coleccion] [varchar](50) NULL,
	[especificacion] [text] NULL,
	[idcliente] [int] NULL,
	[estado] [bit] NULL,
 CONSTRAINT [PK_Modelo] PRIMARY KEY CLUSTERED 
(
	[codigomodelo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Orden]    Script Date: 30/05/2016 14:19:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Orden](
	[codigoorden] [varchar](15) NOT NULL,
	[orden_pedido] [varchar](10) NULL,
	[fecha_emision] [varchar](10) NULL,
	[fecha_entrega] [varchar](10) NULL,
	[codigomodelo] [varchar](15) NULL,
	[total] [int] NULL,
 CONSTRAINT [PK_Orden] PRIMARY KEY CLUSTERED 
(
	[codigoorden] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Proceso]    Script Date: 30/05/2016 14:19:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Proceso](
	[codigoproceso] [varchar](15) NOT NULL,
	[descripcion] [varchar](50) NULL,
 CONSTRAINT [PK_Proceso] PRIMARY KEY CLUSTERED 
(
	[codigoproceso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Proveedor]    Script Date: 30/05/2016 14:19:33 ******/
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
/****** Object:  Table [dbo].[Serie]    Script Date: 30/05/2016 14:19:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Serie](
	[tallas] [tinyint] NULL,
	[pares] [int] NULL,
	[codigoorden] [varchar](15) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Trabajador]    Script Date: 30/05/2016 14:19:33 ******/
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
	[fecha_nacimiento] [varchar](10) NULL,
	[usuario] [varchar](50) NULL,
	[contrasena] [varchar](50) NULL,
	[estado] [bit] NULL,
	[codigoproceso] [varchar](15) NULL,
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
INSERT [dbo].[Cliente] ([idcliente], [razonsocial], [ruc], [direccion], [estado]) VALUES (6, N'BCDEF', N'12346578912', N'Urb. fsdf 15', 1)
INSERT [dbo].[Cliente] ([idcliente], [razonsocial], [ruc], [direccion], [estado]) VALUES (7, N'CDEGF', N'12345678978', N'Urb. sdf 36', 1)
INSERT [dbo].[Cliente] ([idcliente], [razonsocial], [ruc], [direccion], [estado]) VALUES (8, N'GDKNB', N'12385296341', N'Urb. dfsd 15', 1)
INSERT [dbo].[Cliente] ([idcliente], [razonsocial], [ruc], [direccion], [estado]) VALUES (9, N'FERJK', N'10852741963', N'Urb. uiy 74', 1)
INSERT [dbo].[Cliente] ([idcliente], [razonsocial], [ruc], [direccion], [estado]) VALUES (10, N'RGTHJ', N'10546325941', N'Urb. tyg 12', 1)
INSERT [dbo].[Cliente] ([idcliente], [razonsocial], [ruc], [direccion], [estado]) VALUES (11, N'AASSDSDS', N'12345435646', N'Urb. fgh 30', 1)
INSERT [dbo].[Cliente] ([idcliente], [razonsocial], [ruc], [direccion], [estado]) VALUES (12, N'HOLA', N'10264987876', N'Urb. hola 23', 1)
INSERT [dbo].[Cliente] ([idcliente], [razonsocial], [ruc], [direccion], [estado]) VALUES (13, N'Ventura Hermanos', N'20340155115', N'Jr. Ayacucho 446 Cercado de Lima', 1)
SET IDENTITY_INSERT [dbo].[Cliente] OFF
INSERT [dbo].[Proceso] ([codigoproceso], [descripcion]) VALUES (N'CP1', N'Corte')
INSERT [dbo].[Proceso] ([codigoproceso], [descripcion]) VALUES (N'CP2', N'Aparado')
INSERT [dbo].[Proceso] ([codigoproceso], [descripcion]) VALUES (N'CP3', N'Armado')
INSERT [dbo].[Proceso] ([codigoproceso], [descripcion]) VALUES (N'CP4', N'Alistado')
SET IDENTITY_INSERT [dbo].[Proveedor] ON 

INSERT [dbo].[Proveedor] ([idproveedor], [razonsocial], [ruc], [direccion], [estado]) VALUES (1, N'Aqz', N'74185296332', N'Urb. xyz #123', 1)
INSERT [dbo].[Proveedor] ([idproveedor], [razonsocial], [ruc], [direccion], [estado]) VALUES (2, N'Wer', N'21457896324', N'Urb. gtr #95', 1)
INSERT [dbo].[Proveedor] ([idproveedor], [razonsocial], [ruc], [direccion], [estado]) VALUES (3, N'WERD', N'43534534534', N'HFGHFGH', 1)
INSERT [dbo].[Proveedor] ([idproveedor], [razonsocial], [ruc], [direccion], [estado]) VALUES (4, N'FDGDFGDFG', N'34567677868', N'SDFSDF', 1)
SET IDENTITY_INSERT [dbo].[Proveedor] OFF
SET IDENTITY_INSERT [dbo].[Trabajador] ON 

INSERT [dbo].[Trabajador] ([idempleado], [dni], [nombres], [ape_paterno], [ape_materno], [direccion], [telefono], [celular], [fecha_nacimiento], [usuario], [contrasena], [estado], [codigoproceso]) VALUES (1, N'41138268', N'Santos ', N'Gutierrez', N'Amaya', N'Poroto, caserillo, huayavito', NULL, N'99281066', N'25/11/1981', N'san', N'123', 1, N'CP2')
INSERT [dbo].[Trabajador] ([idempleado], [dni], [nombres], [ape_paterno], [ape_materno], [direccion], [telefono], [celular], [fecha_nacimiento], [usuario], [contrasena], [estado], [codigoproceso]) VALUES (2, N'47153287', N'David', N'Montoya', N'Loyola', N'Urb. La Rinconada #123', N'044211641', N'948512657', N'21/03/1989', N'dav', N'123', 1, N'CP1')
INSERT [dbo].[Trabajador] ([idempleado], [dni], [nombres], [ape_paterno], [ape_materno], [direccion], [telefono], [celular], [fecha_nacimiento], [usuario], [contrasena], [estado], [codigoproceso]) VALUES (3, N'41692143', N'Miguel', N'Avila', N'Mantilla', N'Urb. La Libertad MZ N lote 10', N'044219832', N'948512748', N'21/10/1988', N'mig', N'123', 1, N'CP3')
SET IDENTITY_INSERT [dbo].[Trabajador] OFF
ALTER TABLE [dbo].[DetalleOrden]  WITH CHECK ADD  CONSTRAINT [FK_DetalleOrden_Orden] FOREIGN KEY([codigoorden])
REFERENCES [dbo].[Orden] ([codigoorden])
GO
ALTER TABLE [dbo].[DetalleOrden] CHECK CONSTRAINT [FK_DetalleOrden_Orden]
GO
ALTER TABLE [dbo].[DetalleOrden]  WITH CHECK ADD  CONSTRAINT [FK_DetalleOrden_Trabajador] FOREIGN KEY([idempleado])
REFERENCES [dbo].[Trabajador] ([idempleado])
GO
ALTER TABLE [dbo].[DetalleOrden] CHECK CONSTRAINT [FK_DetalleOrden_Trabajador]
GO
ALTER TABLE [dbo].[Material]  WITH CHECK ADD  CONSTRAINT [FK_Material_Modelo] FOREIGN KEY([codigomodelo])
REFERENCES [dbo].[Modelo] ([codigomodelo])
GO
ALTER TABLE [dbo].[Material] CHECK CONSTRAINT [FK_Material_Modelo]
GO
ALTER TABLE [dbo].[Material]  WITH CHECK ADD  CONSTRAINT [FK_Material_Proceso] FOREIGN KEY([codigoproceso])
REFERENCES [dbo].[Proceso] ([codigoproceso])
GO
ALTER TABLE [dbo].[Material] CHECK CONSTRAINT [FK_Material_Proceso]
GO
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
ALTER TABLE [dbo].[Orden]  WITH CHECK ADD  CONSTRAINT [FK_Orden_Modelo] FOREIGN KEY([codigomodelo])
REFERENCES [dbo].[Modelo] ([codigomodelo])
GO
ALTER TABLE [dbo].[Orden] CHECK CONSTRAINT [FK_Orden_Modelo]
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
