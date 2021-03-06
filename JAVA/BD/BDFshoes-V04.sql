USE [fshoes]
GO
/****** Object:  StoredProcedure [dbo].[pa_cliente]    Script Date: 22/06/2016 14:25:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pa_cliente]
	@prmvalor varchar(30),
	@prmtipo varchar(100),
	@inicio int,
	@fin int,
	
	@razonsocial varchar(100),
	@ruc varchar(11),
	@direccion varchar(100),
	@estado bit

	AS 
	IF @prmtipo = 'listarClientePaginacion'
		BEGIN
			SELECT  idcliente, razonsocial, ruc, direccion, estado
			FROM (SELECT idcliente, razonsocial, ruc, direccion, estado, ROW_NUMBER() OVER (ORDER BY idcliente desc) as fila FROM Cliente) as c			
			WHERE c.fila > @inicio and c.fila <= @fin and c.estado = 1;--aquí, agregué el estado para todos los modelo activos			
		END
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
/****** Object:  StoredProcedure [dbo].[pa_detalle_orden]    Script Date: 22/06/2016 14:25:20 ******/
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
	--terminarProcesoOrden
IF @prmtipo = 'terminarProcesoOrden'
	BEGIN
		UPDATE DetalleOrden SET estado = @estado WHERE codigoorden = @codigoorden; 
	END

GO
/****** Object:  StoredProcedure [dbo].[pa_ficha_tecnica]    Script Date: 22/06/2016 14:25:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[pa_ficha_tecnica]
	@prmvalor varchar(30),
	@prmtipo varchar(100),
	@inicio int,
	@fin int,

	@codigoficha varchar(15),
	@plataforma varchar(30),
	@taco varchar(30),
	@color varchar(30),
	@coleccion varchar(30),
	@urlimagen varchar(100),
	@codigomodelo varchar(15)

	AS 
	IF @prmtipo = 'listarFichaTecnica'
		BEGIN
			--IF @prmvalor = ''
				SELECT top 5 ft.codigomodelo, horma, codigoficha, taco, plataforma, color, coleccion, c.idcliente, c.razonsocial FROM FichaTecnica ft
				INNER JOIN Modelo m ON m.codigomodelo = ft.codigomodelo
				INNER JOIN Cliente c ON m.idcliente = c.idcliente			
				WHERE (ft.codigoficha LIKE @prmvalor+'%' OR ft.codigomodelo LIKE @prmvalor + '%') AND m.estado = 1
				ORDER BY codigoficha DESC;
			/*ELSE
				SELECT  ft.codigomodelo, horma, codigoficha, taco, plataforma, color, coleccion, c.idcliente, c.razonsocial FROM FichaTecnica ft
				INNER JOIN Modelo m ON m.codigomodelo = ft.codigomodelo
				INNER JOIN Cliente c ON m.idcliente = c.idcliente			
				WHERE (ft.codigoficha LIKE @prmvalor+'%' OR m.codigomodelo LIKE @prmvalor + '%') AND m.estado = 1 ; --__% empieza despues de dos letras cualquiera*/

		END
	IF @prmtipo = 'listarFichaTecnicaPaginacion'
		BEGIN
			SELECT  ft.codigomodelo, horma, codigoficha, taco, plataforma, color, coleccion, c.idcliente, c.razonsocial
			FROM (SELECT codigomodelo, codigoficha, taco, color, plataforma, coleccion, ROW_NUMBER() OVER (ORDER BY codigomodelo desc) as fila FROM FichaTecnica) as ft 
			INNER JOIN Modelo m ON m.codigomodelo = ft.codigomodelo
			INNER JOIN Cliente c ON m.idcliente = c.idcliente			
			WHERE ft.fila > @inicio and ft.fila <= @fin and m.estado = 1;--aquí, agregué el estado para todos los modelo activos			
		END
	IF @prmtipo = 'registrarFichaTecnica'
		BEGIN 
			INSERT INTO FichaTecnica(codigoficha, plataforma, taco, color, coleccion, urlimagen, codigomodelo)
			VALUES (@codigoficha, @plataforma, @taco, @color, @coleccion, @urlimagen, @codigomodelo);
		END
	IF @prmtipo = 'modificarFichaTecnica'
		BEGIN 
			UPDATE FichaTecnica 
			SET plataforma = @plataforma, taco=@taco, color = @color, coleccion = @coleccion, urlimagen = @urlimagen
			WHERE codigoficha = @codigoficha;
		END
	IF @prmtipo = 'verificarFichaTecnica'
		BEGIN
			SELECT count(codigoficha) AS existe FROM FichaTecnica WHERE codigoficha = @prmvalor;
		END
	IF @prmtipo = 'obtenerFichaTecnica'
		BEGIN
			SELECT ft.codigomodelo, horma, codigoficha, taco, plataforma, color, coleccion, c.idcliente, c.razonsocial FROM FichaTecnica ft
			INNER JOIN Modelo m ON m.codigomodelo = ft.codigomodelo
			INNER JOIN Cliente c ON m.idcliente = c.idcliente
			WHERE ft.codigoficha = @prmvalor  AND m.estado = 1;
		END
GO
/****** Object:  StoredProcedure [dbo].[pa_material]    Script Date: 22/06/2016 14:25:20 ******/
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
	@idproveedor int,
	@codigoproceso varchar(15), 
	@codigoficha varchar(15)

	AS 

	IF @prmtipo = 'listarMaterial'
		BEGIN
			SELECT  m.idmaterial, m.nombre, m.descripcion, m.unidadmedida, m.cantidaddocena, m.preciounitario, p.razonsocial, m.idproveedor, m.tipo, m.codigoproceso, pr.descripcion as procDescripcion, m.codigoficha
			FROM (SELECT idmaterial, nombre, descripcion, unidadmedida, cantidaddocena, preciounitario, idproveedor, tipo, codigoproceso, codigoficha, ROW_NUMBER() OVER (ORDER BY idmaterial) as fila FROM Material) as m 
			INNER JOIN Proveedor p ON m.idproveedor = p.idproveedor
			INNER JOIN Proceso pr ON m.codigoproceso = pr.codigoproceso
			INNER JOIN FichaTecnica ft ON m.codigoficha = ft.codigoficha--codigo ficha modificar
			WHERE m.fila > @inicio and m.fila <= @fin;--MODIFICADO EN CASA 23/05/2016 cambiar a id incrementado
		END
	IF @prmtipo = 'registrarMaterial'
		BEGIN 
			INSERT INTO Material(nombre, descripcion, unidadmedida, cantidaddocena, preciounitario, tipo, idproveedor, codigoproceso, codigoficha) 
			VALUES(@nombre, @descripcion, @unidadmedida, @cantidaddocena, @preciounitario, @tipo, @idproveedor, @codigoproceso, @codigoficha );
		END
	IF @prmtipo = 'modificarMaterial'
		BEGIN 
			UPDATE Material 
			SET nombre = @nombre, descripcion = @descripcion, unidadmedida = @unidadmedida, cantidaddocena = @cantidaddocena, preciounitario = @preciounitario,
			 tipo = @tipo, idproveedor= @idproveedor
			WHERE idmaterial = @idmaterial
		END
	IF @prmtipo = 'obtenerTotal'
	BEGIN
		SELECT COUNT(idmaterial) AS total FROM Material;--MODIFICADO EN CASA 23/05/2016
	END
	IF @prmtipo = 'obtenerMaterialesPorFichaTecnica'
	BEGIN
		SELECT idmaterial, nombre, m.descripcion, unidadmedida, cantidaddocena, p.codigoproceso, p.descripcion as proceso_descripcion, codigoficha
		FROM Material m
		INNER JOIN Proceso p ON p.codigoproceso = m.codigoproceso
		WHERE m.codigoficha = @prmvalor --@prmvalor, aquí se envía el código de ficha técnica
	END

	/*Pruebas de Procedimientos almacenados*/
	--exec pa_material 'F01', 'obtenerMaterialesPorFichaTecnica', 0, 0, 0, '', '', '', 0, 0, '', 0, '', ''
GO
/****** Object:  StoredProcedure [dbo].[pa_modelo]    Script Date: 22/06/2016 14:25:20 ******/
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
	@horma varchar(50),
	@especificacion text,
	@idcliente int,
	@estado bit
	--TENER EN CUENTA COMO CAMPOS CALZADA Y TALLA BASE
	AS 
	
	IF @prmtipo = 'listarModeloPaginacion'
		BEGIN
			SELECT  m.codigomodelo, m.horma, m.especificacion, m.idcliente, c.razonsocial, m.estado, ft.codigoficha, ft.taco, ft.plataforma, ft.coleccion
			FROM (SELECT codigomodelo, horma, especificacion, idcliente, estado, ROW_NUMBER() OVER (ORDER BY codigomodelo desc) as fila FROM Modelo) as m 
			INNER JOIN Cliente c ON m.idcliente = c.idcliente
			INNER JOIN FichaTecnica ft ON ft.codigomodelo = m.codigomodelo
			WHERE m.fila > @inicio and m.fila <= @fin and m.estado = 1;--aquí, agregué el estado para todos los modelo activos
			/*SELECT m.codigomodelo FROM 
			(SELECT codigomodelo, ROW_NUMBER() OVER (ORDER BY codigomodelo) as fila FROM Modelo) as m
			WHERE m.fila > 0 and m.fila <= 7*/
		END
	IF @prmtipo = 'listarModelo'
		BEGIN
			SELECT TOP 5 codigomodelo, horma, m.idcliente, c.razonsocial
			FROM Modelo m INNER JOIN Cliente c 
			ON m.idcliente = c.idcliente
			WHERE (codigomodelo LIKE @prmvalor+'%' OR c.razonsocial LIKE @prmvalor + '%') AND m.estado = 1 ; --__% empieza despues de dos letras cualquiera
		END
	IF @prmtipo = 'registrarModelo'
		BEGIN 
			INSERT INTO Modelo(codigomodelo, horma, especificacion, idcliente, estado) 
			VALUES(@codigomodelo, @horma, @especificacion, @idcliente, @estado );
		END
	IF @prmtipo = 'modificarModelo'
		BEGIN 
			UPDATE Modelo 
			SET horma = @horma, especificacion=@especificacion, idcliente = @idcliente, estado = @estado
			WHERE codigomodelo = @codigomodelo
		END
	IF @prmtipo = 'obtenerTotal'
		BEGIN
			SELECT COUNT(codigomodelo) AS total FROM Modelo;
		END
	IF @prmtipo = 'verificarModelo'
		BEGIN
			SELECT count(codigomodelo) AS existe FROM Modelo WHERE codigomodelo = @prmvalor;
		END



GO
/****** Object:  StoredProcedure [dbo].[pa_orden]    Script Date: 22/06/2016 14:25:20 ******/
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
/****** Object:  StoredProcedure [dbo].[pa_proceso]    Script Date: 22/06/2016 14:25:20 ******/
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
/****** Object:  StoredProcedure [dbo].[pa_proveedor]    Script Date: 22/06/2016 14:25:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[pa_proveedor]
	@prmvalor varchar(30),
	@prmtipo varchar(100),
	@inicio int,
	@fin int,
	
	@razonsocial varchar(100),
	@ruc varchar(11),
	@direccion varchar(100),
	@estado bit

	AS 

	IF @prmtipo = 'listarProveedorPaginacion'
		BEGIN
			SELECT  idproveedor, razonsocial, ruc, direccion, estado
			FROM (SELECT idproveedor, razonsocial, ruc, direccion, estado, ROW_NUMBER() OVER (ORDER BY idproveedor desc) as fila FROM Proveedor) as p
			WHERE p.fila > @inicio and p.fila <= @fin and p.estado = 1;--aquí, agregué el estado para todos los modelo activos			
			SELECT * FROM Proveedor
		END

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
/****** Object:  StoredProcedure [dbo].[pa_serie]    Script Date: 22/06/2016 14:25:20 ******/
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
/****** Object:  StoredProcedure [dbo].[pa_trabajador]    Script Date: 22/06/2016 14:25:20 ******/
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
        SELECT idempleado, nombres, ape_paterno, ape_materno 
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
/****** Object:  StoredProcedure [dbo].[verificar_acceso]    Script Date: 22/06/2016 14:25:20 ******/
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
/****** Object:  Table [dbo].[Cliente]    Script Date: 22/06/2016 14:25:20 ******/
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
/****** Object:  Table [dbo].[DetalleOrden]    Script Date: 22/06/2016 14:25:20 ******/
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
/****** Object:  Table [dbo].[FichaTecnica]    Script Date: 22/06/2016 14:25:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FichaTecnica](
	[codigoficha] [varchar](15) NOT NULL,
	[plataforma] [varchar](30) NULL,
	[taco] [varchar](30) NULL,
	[color] [varchar](30) NULL,
	[coleccion] [varchar](30) NULL,
	[urlimagen] [varchar](100) NULL,
	[codigomodelo] [varchar](15) NULL,
 CONSTRAINT [PK_FichaTecnica] PRIMARY KEY CLUSTERED 
(
	[codigoficha] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Material]    Script Date: 22/06/2016 14:25:20 ******/
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
	[idproveedor] [int] NULL,
	[codigoproceso] [varchar](15) NULL,
	[codigoficha] [varchar](15) NULL,
 CONSTRAINT [PK_MATERIAL] PRIMARY KEY CLUSTERED 
(
	[idmaterial] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Modelo]    Script Date: 22/06/2016 14:25:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Modelo](
	[codigomodelo] [varchar](15) NOT NULL,
	[horma] [varchar](50) NULL,
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
/****** Object:  Table [dbo].[Orden]    Script Date: 22/06/2016 14:25:20 ******/
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
/****** Object:  Table [dbo].[Proceso]    Script Date: 22/06/2016 14:25:20 ******/
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
/****** Object:  Table [dbo].[Proveedor]    Script Date: 22/06/2016 14:25:20 ******/
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
/****** Object:  Table [dbo].[Serie]    Script Date: 22/06/2016 14:25:20 ******/
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
/****** Object:  Table [dbo].[Trabajador]    Script Date: 22/06/2016 14:25:20 ******/
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
INSERT [dbo].[DetalleOrden] ([codigoorden], [idempleado], [estado]) VALUES (N'FLO-01', 1, 0)
INSERT [dbo].[DetalleOrden] ([codigoorden], [idempleado], [estado]) VALUES (N'FLO-01', 2, 1)
INSERT [dbo].[FichaTecnica] ([codigoficha], [plataforma], [taco], [color], [coleccion], [urlimagen], [codigomodelo]) VALUES (N'F01', N'abcdert', N'12', N'rojo', N'verano', N'url_imagen', N'M01')
SET IDENTITY_INSERT [dbo].[Material] ON 

INSERT [dbo].[Material] ([idmaterial], [nombre], [descripcion], [unidadmedida], [cantidaddocena], [preciounitario], [tipo], [idproveedor], [codigoproceso], [codigoficha]) VALUES (1, N'Badana', N'aaa', N'm', CAST(1.00 AS Decimal(18, 2)), CAST(1.50 AS Decimal(18, 2)), N'sólido', 1, N'CP2', N'F01')
INSERT [dbo].[Material] ([idmaterial], [nombre], [descripcion], [unidadmedida], [cantidaddocena], [preciounitario], [tipo], [idproveedor], [codigoproceso], [codigoficha]) VALUES (2, N'Pegamento', N'pega muy fuerte', N'l', CAST(1.00 AS Decimal(18, 2)), CAST(2.00 AS Decimal(18, 2)), N'líquido', 2, N'CP1', N'F01')
INSERT [dbo].[Material] ([idmaterial], [nombre], [descripcion], [unidadmedida], [cantidaddocena], [preciounitario], [tipo], [idproveedor], [codigoproceso], [codigoficha]) VALUES (1002, N'Cuero', N'cuero resistente', N'm', CAST(1.00 AS Decimal(18, 2)), CAST(5.00 AS Decimal(18, 2)), N'sólido', 1, N'CP3', N'F01')
INSERT [dbo].[Material] ([idmaterial], [nombre], [descripcion], [unidadmedida], [cantidaddocena], [preciounitario], [tipo], [idproveedor], [codigoproceso], [codigoficha]) VALUES (1003, N'Caja', N'mediana ', N'cm', CAST(12.00 AS Decimal(18, 2)), CAST(2.00 AS Decimal(18, 2)), N'sólido', 3, N'CP4', N'F01')
INSERT [dbo].[Material] ([idmaterial], [nombre], [descripcion], [unidadmedida], [cantidaddocena], [preciounitario], [tipo], [idproveedor], [codigoproceso], [codigoficha]) VALUES (1004, N'Capellada 1', N'sintetico Charol Beige', N'm', CAST(0.43 AS Decimal(18, 2)), CAST(1.50 AS Decimal(18, 2)), N'sólido', 2, N'CP1', N'F01')
SET IDENTITY_INSERT [dbo].[Material] OFF
INSERT [dbo].[Modelo] ([codigomodelo], [horma], [especificacion], [idcliente], [estado]) VALUES (N'M01', N'abc', N'Cortado: abce ...', 1, 1)
INSERT [dbo].[Orden] ([codigoorden], [orden_pedido], [fecha_emision], [fecha_entrega], [codigomodelo], [total]) VALUES (N'066-V', N'1617', N'01/06/2016', N'02/06/2016', N'2H03', 15)
INSERT [dbo].[Orden] ([codigoorden], [orden_pedido], [fecha_emision], [fecha_entrega], [codigomodelo], [total]) VALUES (N'FLO-01', N'1234', N'01/06/2016', N'04/06/2016', N'M01', 200)
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
INSERT [dbo].[Serie] ([tallas], [pares], [codigoorden]) VALUES (35, 50, N'FLO-01')
INSERT [dbo].[Serie] ([tallas], [pares], [codigoorden]) VALUES (36, 100, N'FLO-01')
INSERT [dbo].[Serie] ([tallas], [pares], [codigoorden]) VALUES (37, 50, N'FLO-01')
INSERT [dbo].[Serie] ([tallas], [pares], [codigoorden]) VALUES (35, 2, N'066-V')
INSERT [dbo].[Serie] ([tallas], [pares], [codigoorden]) VALUES (36, 4, N'066-V')
INSERT [dbo].[Serie] ([tallas], [pares], [codigoorden]) VALUES (37, 5, N'066-V')
INSERT [dbo].[Serie] ([tallas], [pares], [codigoorden]) VALUES (38, 3, N'066-V')
INSERT [dbo].[Serie] ([tallas], [pares], [codigoorden]) VALUES (39, 1, N'066-V')
SET IDENTITY_INSERT [dbo].[Trabajador] ON 

INSERT [dbo].[Trabajador] ([idempleado], [dni], [nombres], [ape_paterno], [ape_materno], [direccion], [telefono], [celular], [fecha_nacimiento], [usuario], [contrasena], [estado], [codigoproceso]) VALUES (1, N'41138268', N'Santos ', N'Gutierrez', N'Amaya', N'Poroto, caserillo, huayavito', N'044216544', N'992810664', N'25/11/1981', N'san', N'123', 1, N'CP2')
INSERT [dbo].[Trabajador] ([idempleado], [dni], [nombres], [ape_paterno], [ape_materno], [direccion], [telefono], [celular], [fecha_nacimiento], [usuario], [contrasena], [estado], [codigoproceso]) VALUES (2, N'47153287', N'David', N'Montoya', N'Loyola', N'Urb. La Rinconada #123', N'044211641', N'948512657', N'21/03/1989', N'dav', N'123', 1, N'CP1')
INSERT [dbo].[Trabajador] ([idempleado], [dni], [nombres], [ape_paterno], [ape_materno], [direccion], [telefono], [celular], [fecha_nacimiento], [usuario], [contrasena], [estado], [codigoproceso]) VALUES (3, N'41692143', N'Miguel', N'Avila', N'Mantilla', N'Urb. La Libertad MZ N lote 10', N'044219832', N'948512748', N'21/10/1988', N'mig', N'123', 1, N'CP3')
INSERT [dbo].[Trabajador] ([idempleado], [dni], [nombres], [ape_paterno], [ape_materno], [direccion], [telefono], [celular], [fecha_nacimiento], [usuario], [contrasena], [estado], [codigoproceso]) VALUES (4, N'42856321', N'Gerardo', N'Garcia', N'Llique', N'Urb. Palermo #45', N'044214578', N'948532145', N'10/07/1998', N'ger', N'123', 1, N'CP4')
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
ALTER TABLE [dbo].[FichaTecnica]  WITH CHECK ADD  CONSTRAINT [FK_FichaTecnica_Modelo] FOREIGN KEY([codigomodelo])
REFERENCES [dbo].[Modelo] ([codigomodelo])
GO
ALTER TABLE [dbo].[FichaTecnica] CHECK CONSTRAINT [FK_FichaTecnica_Modelo]
GO
ALTER TABLE [dbo].[Material]  WITH CHECK ADD  CONSTRAINT [FK_Material_FichaTecnica] FOREIGN KEY([codigoficha])
REFERENCES [dbo].[FichaTecnica] ([codigoficha])
GO
ALTER TABLE [dbo].[Material] CHECK CONSTRAINT [FK_Material_FichaTecnica]
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
