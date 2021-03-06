USE [fshoes]
GO
/****** Object:  StoredProcedure [dbo].[pa_cliente]    Script Date: 19/07/2016 4:39:06 ******/
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
	IF @prmtipo = 'obtenerTotal'
		BEGIN
			SELECT COUNT(idcliente) AS total FROM Cliente;
		END
	IF @prmtipo = 'verificarCliente'
		BEGIN
			SELECT count(ruc) AS existe FROM Cliente WHERE ruc = @prmvalor;
		END




GO
/****** Object:  StoredProcedure [dbo].[pa_detalle_orden]    Script Date: 19/07/2016 4:39:06 ******/
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
/****** Object:  StoredProcedure [dbo].[pa_ficha_tecnica]    Script Date: 19/07/2016 4:39:06 ******/
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
				FROM (SELECT codigomodelo, codigoficha, taco, color, plataforma, coleccion, 
				ROW_NUMBER() OVER (ORDER BY codigomodelo desc) as fila 
				FROM FichaTecnica
				WHERE codigomodelo = @prmvalor) as ft --aqui se condicina para el listado de fichas con parámetro por modelo

			INNER JOIN Modelo m ON m.codigomodelo = ft.codigomodelo
			INNER JOIN Cliente c ON m.idcliente = c.idcliente			
			WHERE (ft.fila > 0 and ft.fila <= 10) and m.estado = 1 and ft.codigomodelo = @prmvalor;
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
	IF @prmtipo = 'obtenerTotal'
		BEGIN
			SELECT COUNT(codigoficha) AS total FROM FichaTecnica WHERE codigomodelo = @prmvalor;--condición, obtener total de fichas, por modelo (parámetro)
		END




GO
/****** Object:  StoredProcedure [dbo].[pa_material]    Script Date: 19/07/2016 4:39:06 ******/
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

	IF @prmtipo = 'listarMaterialPaginacion'
		BEGIN
			SELECT  m.idmaterial, m.nombre, m.descripcion, m.unidadmedida, m.cantidaddocena, m.preciounitario, 
					p.razonsocial, m.idproveedor, m.tipo, m.codigoproceso, pr.descripcion as procDescripcion, m.codigoficha
					FROM (SELECT idmaterial, nombre, descripcion, unidadmedida, cantidaddocena, preciounitario, idproveedor,
							tipo, codigoproceso, codigoficha, ROW_NUMBER() OVER (ORDER BY idmaterial desc) as fila 
							FROM Material 
							WHERE codigoficha = @prmvalor) as m --aqui se condicina para el listado de materiales con parámetro por ficha técnica

			INNER JOIN Proveedor p ON m.idproveedor = p.idproveedor
			INNER JOIN Proceso pr ON m.codigoproceso = pr.codigoproceso
			INNER JOIN FichaTecnica ft ON m.codigoficha = ft.codigoficha--codigo ficha modificar
			WHERE (m.fila > @inicio and m.fila <= @fin) and m.codigoficha = @prmvalor;--MODIFICADO EN CASA 23/05/2016 cambiar a id incrementado
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
			 tipo = @tipo, idproveedor= @idproveedor, codigoproceso = @codigoproceso, codigoficha = @codigoficha
			WHERE idmaterial = @idmaterial
		END
	IF @prmtipo = 'obtenerTotal'
	BEGIN
		SELECT COUNT(idmaterial) AS total FROM Material WHERE codigoficha = @prmvalor;--MODIFICADO EN CASA 23/05/2016
	END
	IF @prmtipo = 'obtenerMaterialesPorFichaTecnica'
	BEGIN
		SELECT idmaterial, nombre, m.descripcion, unidadmedida, cantidaddocena, preciounitario, tipo, idproveedor, p.codigoproceso, p.descripcion as proceso_descripcion, codigoficha
		FROM Material m
		INNER JOIN Proceso p ON p.codigoproceso = m.codigoproceso		
		WHERE m.codigoficha = @prmvalor --@prmvalor, aquí se envía el código de ficha técnica
	END
	IF @prmtipo = 'listarMaterial'
	BEGIN
		SELECT m.nombre, m.descripcion, m.unidadmedida, m.cantidaddocena, m.codigoproceso, p.descripcion as procDescripcion FROM Material m
		INNER JOIN Proceso p ON m.codigoproceso = p.codigoproceso
		WHERE m.codigoficha = @prmvalor;
	END
	/*Pruebas de Procedimientos almacenados*/
	--exec pa_material 'F02', 'listarMaterialPaginacion', 0, 10, 0, '', '', '', 0, 0, '', 0, '', ''



GO
/****** Object:  StoredProcedure [dbo].[pa_modelo]    Script Date: 19/07/2016 4:39:06 ******/
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
	
	IF @prmtipo = 'listarModeloPaginacion'-- cuando hay paramtro
		BEGIN
			SELECT  m.codigomodelo, m.horma, m.especificacion, m.idcliente, c.razonsocial, 
					m.estado, ft.codigoficha, ft.taco, ft.plataforma, ft.coleccion
					FROM (SELECT codigomodelo, horma, especificacion, idcliente, estado, 
					ROW_NUMBER() OVER (ORDER BY codigomodelo desc) as fila 
					FROM Modelo
					WHERE codigomodelo = @prmvalor) as m --aquí, también se hace una condición, para filtrar por código de modelo.

			INNER JOIN Cliente c ON m.idcliente = c.idcliente
			INNER JOIN FichaTecnica ft ON ft.codigomodelo = m.codigomodelo
			WHERE (m.fila > @inicio and m.fila <= @fin) and m.codigomodelo = @prmvalor and m.estado = 1;--aquí, agregué el estado para todos los modelo activos
			
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
			SELECT COUNT(codigomodelo) AS total FROM Modelo WHERE codigomodelo = @prmvalor;
		END
	IF @prmtipo = 'verificarModelo'
		BEGIN
			SELECT count(codigomodelo) AS existe FROM Modelo WHERE codigomodelo = @prmvalor;
		END






GO
/****** Object:  StoredProcedure [dbo].[pa_orden]    Script Date: 19/07/2016 4:39:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pa_orden]
	@prmvalor varchar(30),
	@prmtipo varchar(100),
	@inicio int,
	@fin int,
	
	@codigoorden varchar(10),
	@orden_pedido varchar(10),
	@fecha_emision datetime,
	@fecha_entrega datetime,
	@total tinyint,
	@codigoficha varchar(15)
	
	AS 

	IF @prmtipo = 'listarOrden'--ver ordenes por rango de fechas
		BEGIN
			SELECT codigoorden, orden_pedido, fecha_emision, fecha_entrega, total
			FROM Orden
		END
	IF @prmtipo = 'registrarOrden'
		BEGIN 
			INSERT INTO Orden(codigoorden, orden_pedido, fecha_emision, fecha_entrega, codigoficha, total) VALUES(@codigoorden, @orden_pedido, @fecha_emision, @fecha_entrega, @codigoficha, @total);
		END
	IF @prmtipo = 'cabeceraOrden'
		BEGIN
			--PARTE DE LA CABECERA
			SELECT o.codigoorden, o.orden_pedido, o.fecha_emision, o.fecha_entrega, o.total, s.tallas, s.pares,ft.codigoficha, ft.plataforma, ft.taco, ft.color, m.codigomodelo, m.horma, m.especificacion,c.razonsocial FROM Orden o
			INNER JOIN Serie s ON s.codigoorden = o.codigoorden
			INNER JOIN FichaTecnica ft ON o.codigoficha = ft.codigoficha
			INNER JOIN Modelo m ON ft.codigomodelo = m.codigomodelo
			INNER JOIN Cliente c ON m.idcliente = c.idcliente
			WHERE o.codigoorden = @prmvalor;--parámetro de código de orden, matener ft.codigoficha oculto para usarlo como parámetro para materiales
		END
	if @prmtipo = 'listarOrdenTerminadaPaginacion'
		BEGIN
			SELECT o.codigoorden, orden_pedido, fecha_entrega, o.codigoficha , total
			--,do.idempleado, do.estado ,t.codigoproceso
			FROM (SELECT codigoorden, orden_pedido, fecha_entrega, codigoficha, total, ROW_NUMBER() OVER (ORDER BY codigoorden desc) as fila FROM Orden) as o
			INNER JOIN DetalleOrden do ON o.codigoorden = do.codigoorden
			INNER JOIN Trabajador t ON t.idempleado = do.idempleado
			WHERE t.codigoproceso = 'CP4' and do.estado = 1	and  o.fecha_entrega between @fecha_emision and @fecha_entrega 
					and o.fila > @inicio and o.fila <= @fin
		END
	IF @prmtipo = 'obtenerTotal'
		BEGIN
			SELECT COUNT(o.codigoorden) AS total FROM Orden o
			INNER JOIN DetalleOrden do ON o.codigoorden = do.codigoorden
			INNER JOIN Trabajador t ON t.idempleado = do.idempleado
			WHERE t.codigoproceso = 'CP4' and do.estado = 1
					and  o.fecha_entrega between @fecha_emision and @fecha_entrega			
		END
	IF @prmtipo = 'verificarOrden'
		BEGIN
			SELECT count(codigoorden) AS existe FROM Orden WHERE codigoorden = @prmvalor;
		END



/*PARTE DEL CUERPO DE MATERIALES
SELECT m.nombre, m.descripcion, m.unidadmedida, m.cantidaddocena, m.codigoproceso FROM Material m
WHERE m.codigoficha = 'F01'*/







GO
/****** Object:  StoredProcedure [dbo].[pa_proceso]    Script Date: 19/07/2016 4:39:06 ******/
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
/****** Object:  StoredProcedure [dbo].[pa_proveedor]    Script Date: 19/07/2016 4:39:06 ******/
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
	IF @prmtipo = 'obtenerTotal'
		BEGIN
			SELECT COUNT(idproveedor) AS total FROM Proveedor;
		END
	IF @prmtipo = 'verificarProveedor'
		BEGIN
			SELECT count(ruc) AS existe FROM Proveedor WHERE ruc = @prmvalor;
		END





GO
/****** Object:  StoredProcedure [dbo].[pa_serie]    Script Date: 19/07/2016 4:39:06 ******/
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
			SELECT tallas, pares
			FROM Serie WHERE codigoorden = @prmvalor;
		END
	IF @prmtipo = 'registrarSerie'
		BEGIN 
			INSERT INTO Serie(tallas, pares, codigoorden) VALUES(@tallas, @pares, @codigoorden);
		END






GO
/****** Object:  StoredProcedure [dbo].[pa_trabajador]    Script Date: 19/07/2016 4:39:06 ******/
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
/****** Object:  StoredProcedure [dbo].[verificar_acceso]    Script Date: 19/07/2016 4:39:06 ******/
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
/****** Object:  Table [dbo].[Cliente]    Script Date: 19/07/2016 4:39:06 ******/
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
/****** Object:  Table [dbo].[DetalleOrden]    Script Date: 19/07/2016 4:39:06 ******/
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
/****** Object:  Table [dbo].[FichaTecnica]    Script Date: 19/07/2016 4:39:06 ******/
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
/****** Object:  Table [dbo].[Material]    Script Date: 19/07/2016 4:39:06 ******/
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
/****** Object:  Table [dbo].[Modelo]    Script Date: 19/07/2016 4:39:06 ******/
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
/****** Object:  Table [dbo].[Orden]    Script Date: 19/07/2016 4:39:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Orden](
	[codigoorden] [varchar](15) NOT NULL,
	[orden_pedido] [varchar](10) NULL,
	[fecha_emision] [datetime] NULL,
	[fecha_entrega] [datetime] NULL,
	[codigoficha] [varchar](15) NULL,
	[total] [int] NULL,
 CONSTRAINT [PK_Orden] PRIMARY KEY CLUSTERED 
(
	[codigoorden] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Proceso]    Script Date: 19/07/2016 4:39:06 ******/
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
/****** Object:  Table [dbo].[Proveedor]    Script Date: 19/07/2016 4:39:06 ******/
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
/****** Object:  Table [dbo].[Serie]    Script Date: 19/07/2016 4:39:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Serie](
	[tallas] [tinyint] NULL,
	[pares] [tinyint] NULL,
	[codigoorden] [varchar](15) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Trabajador]    Script Date: 19/07/2016 4:39:06 ******/
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

INSERT [dbo].[Cliente] ([idcliente], [razonsocial], [ruc], [direccion], [estado]) VALUES (1, N'PIAZZA', N'14785296321', N'Urb. La rinconada #41', 1)
INSERT [dbo].[Cliente] ([idcliente], [razonsocial], [ruc], [direccion], [estado]) VALUES (2, N'Calzados Calti', N'12345678912', N'El Porvenir ', 1)
INSERT [dbo].[Cliente] ([idcliente], [razonsocial], [ruc], [direccion], [estado]) VALUES (3, N'Calzados Axel', N'14785296332', N'El Porvenir', 1)
INSERT [dbo].[Cliente] ([idcliente], [razonsocial], [ruc], [direccion], [estado]) VALUES (4, N'Copeinser ', N'85296374121', N'Urb. La rinconada', 1)
INSERT [dbo].[Cliente] ([idcliente], [razonsocial], [ruc], [direccion], [estado]) VALUES (5, N'Calzados Kellys', N'14785296332', N'Urb. La rinconada', 1)
INSERT [dbo].[Cliente] ([idcliente], [razonsocial], [ruc], [direccion], [estado]) VALUES (6, N'Calzados Marly Peru SAC', N'12346578912', N'Urb. La rinconada', 1)
INSERT [dbo].[Cliente] ([idcliente], [razonsocial], [ruc], [direccion], [estado]) VALUES (7, N'MODAGIU', N'12345678978', N'El Porvenir', 1)
INSERT [dbo].[Cliente] ([idcliente], [razonsocial], [ruc], [direccion], [estado]) VALUES (8, N'Calzados Bsha', N'12385296341', N'El Porvenir', 1)
INSERT [dbo].[Cliente] ([idcliente], [razonsocial], [ruc], [direccion], [estado]) VALUES (9, N'Calzado Dremy ', N'10852741963', N'El Porvenir', 1)
INSERT [dbo].[Cliente] ([idcliente], [razonsocial], [ruc], [direccion], [estado]) VALUES (10, N'Calzado Velayo', N'10546325941', N'El Porvenir', 1)
INSERT [dbo].[Cliente] ([idcliente], [razonsocial], [ruc], [direccion], [estado]) VALUES (11, N'K SPORT', N'12345435646', N'Urb. La rinconada', 1)
INSERT [dbo].[Cliente] ([idcliente], [razonsocial], [ruc], [direccion], [estado]) VALUES (12, N'Calzado A&G', N'10264987876', N'El Porvenir', 1)
INSERT [dbo].[Cliente] ([idcliente], [razonsocial], [ruc], [direccion], [estado]) VALUES (13, N'Ventura Hermanos', N'20340155115', N'Jr. Ayacucho 446 Cercado de Lima', 1)
INSERT [dbo].[Cliente] ([idcliente], [razonsocial], [ruc], [direccion], [estado]) VALUES (14, N'ABEL. SAC', N'10857491324', N'Urb. la Rinconada #74', 1)
SET IDENTITY_INSERT [dbo].[Cliente] OFF
INSERT [dbo].[DetalleOrden] ([codigoorden], [idempleado], [estado]) VALUES (N'013-P', 2, 1)
INSERT [dbo].[DetalleOrden] ([codigoorden], [idempleado], [estado]) VALUES (N'013-P', 1, 1)
INSERT [dbo].[DetalleOrden] ([codigoorden], [idempleado], [estado]) VALUES (N'013-P', 3, 1)
INSERT [dbo].[DetalleOrden] ([codigoorden], [idempleado], [estado]) VALUES (N'075-v', 2, 1)
INSERT [dbo].[DetalleOrden] ([codigoorden], [idempleado], [estado]) VALUES (N'075-V', 1, 1)
INSERT [dbo].[DetalleOrden] ([codigoorden], [idempleado], [estado]) VALUES (N'075-v', 3, 1)
INSERT [dbo].[DetalleOrden] ([codigoorden], [idempleado], [estado]) VALUES (N'013-P', 4, 1)
INSERT [dbo].[DetalleOrden] ([codigoorden], [idempleado], [estado]) VALUES (N'075-V', 4, 1)
INSERT [dbo].[FichaTecnica] ([codigoficha], [plataforma], [taco], [color], [coleccion], [urlimagen], [codigomodelo]) VALUES (N'F01', N'30PL19', N'9T252PL30', N'Beige', N'Invierno', N'url_imagen', N'FLO-045')
INSERT [dbo].[FichaTecnica] ([codigoficha], [plataforma], [taco], [color], [coleccion], [urlimagen], [codigomodelo]) VALUES (N'F02', N'30PL19', N'9T252PL30', N'NEGRO', N'INVIERNO', N'url_imagen', N'2H03')
INSERT [dbo].[FichaTecnica] ([codigoficha], [plataforma], [taco], [color], [coleccion], [urlimagen], [codigomodelo]) VALUES (N'F03', N'30PL19', N'9T252PL30', N'AZUL', N'INVIERNO', N'url', N'2H03')
SET IDENTITY_INSERT [dbo].[Material] ON 

INSERT [dbo].[Material] ([idmaterial], [nombre], [descripcion], [unidadmedida], [cantidaddocena], [preciounitario], [tipo], [idproveedor], [codigoproceso], [codigoficha]) VALUES (1, N'Capellada 1', N'Sintético Charol ', N'm', CAST(0.43 AS Decimal(18, 2)), CAST(1.50 AS Decimal(18, 2)), N'Sólido', 1, N'CP1', N'F01')
INSERT [dbo].[Material] ([idmaterial], [nombre], [descripcion], [unidadmedida], [cantidaddocena], [preciounitario], [tipo], [idproveedor], [codigoproceso], [codigoficha]) VALUES (2, N'Capellada 2', N'Malla', N'm', CAST(0.36 AS Decimal(18, 2)), CAST(1.60 AS Decimal(18, 2)), N'sólido', 2, N'CP1', N'F01')
INSERT [dbo].[Material] ([idmaterial], [nombre], [descripcion], [unidadmedida], [cantidaddocena], [preciounitario], [tipo], [idproveedor], [codigoproceso], [codigoficha]) VALUES (3, N'Forro 1', N'Badana nude', N'pie 2', CAST(6.50 AS Decimal(18, 2)), CAST(2.50 AS Decimal(18, 2)), N'Sólido', 3, N'CP1', N'F01')
INSERT [dbo].[Material] ([idmaterial], [nombre], [descripcion], [unidadmedida], [cantidaddocena], [preciounitario], [tipo], [idproveedor], [codigoproceso], [codigoficha]) VALUES (4, N'Forro 2', N'Polibadana Bebe Camell', N'm', CAST(0.40 AS Decimal(18, 2)), CAST(2.60 AS Decimal(18, 2)), N'sólido', 1, N'CP1', N'F01')
INSERT [dbo].[Material] ([idmaterial], [nombre], [descripcion], [unidadmedida], [cantidaddocena], [preciounitario], [tipo], [idproveedor], [codigoproceso], [codigoficha]) VALUES (5, N'Hilo Capellada', N'Hilo rio Nude', N'cono', CAST(0.17 AS Decimal(18, 2)), CAST(2.00 AS Decimal(18, 2)), N'sólido', 1, N'CP2', N'F01')
INSERT [dbo].[Material] ([idmaterial], [nombre], [descripcion], [unidadmedida], [cantidaddocena], [preciounitario], [tipo], [idproveedor], [codigoproceso], [codigoficha]) VALUES (6, N'Hilo Forro', N'Hilo rio Cod 123', N'cono', CAST(0.17 AS Decimal(18, 2)), CAST(2.00 AS Decimal(18, 2)), N'sólido', 1, N'CP2', N'F01')
INSERT [dbo].[Material] ([idmaterial], [nombre], [descripcion], [unidadmedida], [cantidaddocena], [preciounitario], [tipo], [idproveedor], [codigoproceso], [codigoficha]) VALUES (7, N'Falsa', N'de línea 911C', N'doc', CAST(1.00 AS Decimal(18, 2)), CAST(1.00 AS Decimal(18, 2)), N'sólido', 2, N'CP3', N'F01')
INSERT [dbo].[Material] ([idmaterial], [nombre], [descripcion], [unidadmedida], [cantidaddocena], [preciounitario], [tipo], [idproveedor], [codigoproceso], [codigoficha]) VALUES (8, N'Refuerzo de falsa', N'Pellejo N 02', N'rollo', CAST(0.01 AS Decimal(18, 2)), CAST(2.30 AS Decimal(18, 2)), N'Sólido', 3, N'CP3', N'F01')
INSERT [dbo].[Material] ([idmaterial], [nombre], [descripcion], [unidadmedida], [cantidaddocena], [preciounitario], [tipo], [idproveedor], [codigoproceso], [codigoficha]) VALUES (9, N'Plantilla', N'Badana Nude', N'pie 2', CAST(5.00 AS Decimal(18, 2)), CAST(2.40 AS Decimal(18, 2)), N'Sólido', 1, N'CP4', N'F01')
INSERT [dbo].[Material] ([idmaterial], [nombre], [descripcion], [unidadmedida], [cantidaddocena], [preciounitario], [tipo], [idproveedor], [codigoproceso], [codigoficha]) VALUES (10, N'Etiqueta', N'Transfer', N'doc', CAST(1.00 AS Decimal(18, 2)), CAST(0.70 AS Decimal(18, 2)), N'sólido', 3, N'CP4', N'F01')
INSERT [dbo].[Material] ([idmaterial], [nombre], [descripcion], [unidadmedida], [cantidaddocena], [preciounitario], [tipo], [idproveedor], [codigoproceso], [codigoficha]) VALUES (11, N'Capellada 1', N'cuero negro punto aguja', N'm', CAST(1.23 AS Decimal(18, 2)), CAST(25.00 AS Decimal(18, 2)), N'sólido', 1, N'CP1', N'F02')
INSERT [dbo].[Material] ([idmaterial], [nombre], [descripcion], [unidadmedida], [cantidaddocena], [preciounitario], [tipo], [idproveedor], [codigoproceso], [codigoficha]) VALUES (12, N'Capellada 2', N'', N'', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'sólido', 1, N'CP1', N'F02')
INSERT [dbo].[Material] ([idmaterial], [nombre], [descripcion], [unidadmedida], [cantidaddocena], [preciounitario], [tipo], [idproveedor], [codigoproceso], [codigoficha]) VALUES (13, N'Hilo capellada', N'Hilo rio negro', N'cono', CAST(0.17 AS Decimal(18, 2)), CAST(6.50 AS Decimal(18, 2)), N'sólido', 1, N'CP2', N'F02')
INSERT [dbo].[Material] ([idmaterial], [nombre], [descripcion], [unidadmedida], [cantidaddocena], [preciounitario], [tipo], [idproveedor], [codigoproceso], [codigoficha]) VALUES (14, N'Hilo forro', N'Hilo rio COD 123', N'cono', CAST(0.17 AS Decimal(18, 2)), CAST(6.50 AS Decimal(18, 2)), N'sólido', 2, N'CP2', N'F02')
INSERT [dbo].[Material] ([idmaterial], [nombre], [descripcion], [unidadmedida], [cantidaddocena], [preciounitario], [tipo], [idproveedor], [codigoproceso], [codigoficha]) VALUES (15, N'Falsa', N'de línea 1190', N'doc', CAST(1.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), N'sólido', 2, N'CP3', N'F02')
INSERT [dbo].[Material] ([idmaterial], [nombre], [descripcion], [unidadmedida], [cantidaddocena], [preciounitario], [tipo], [idproveedor], [codigoproceso], [codigoficha]) VALUES (16, N'Plantilla', N'Badana nude', N'pie 2', CAST(7.00 AS Decimal(18, 2)), CAST(2.70 AS Decimal(18, 2)), N'sólido', 3, N'CP4', N'F02')
INSERT [dbo].[Material] ([idmaterial], [nombre], [descripcion], [unidadmedida], [cantidaddocena], [preciounitario], [tipo], [idproveedor], [codigoproceso], [codigoficha]) VALUES (17, N'Etiqueta', N'Transfer', N'doc', CAST(1.00 AS Decimal(18, 2)), CAST(3.00 AS Decimal(18, 2)), N'sólido', 3, N'CP4', N'F02')
INSERT [dbo].[Material] ([idmaterial], [nombre], [descripcion], [unidadmedida], [cantidaddocena], [preciounitario], [tipo], [idproveedor], [codigoproceso], [codigoficha]) VALUES (18, N'Capellada 1', N'cuero azul punto aguja', N'm', CAST(25.00 AS Decimal(18, 2)), CAST(25.00 AS Decimal(18, 2)), N'sólido', 1, N'CP1', N'F03')
INSERT [dbo].[Material] ([idmaterial], [nombre], [descripcion], [unidadmedida], [cantidaddocena], [preciounitario], [tipo], [idproveedor], [codigoproceso], [codigoficha]) VALUES (19, N'Capellada 2', N'', N'', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'sólido', 1, N'CP1', N'F03')
INSERT [dbo].[Material] ([idmaterial], [nombre], [descripcion], [unidadmedida], [cantidaddocena], [preciounitario], [tipo], [idproveedor], [codigoproceso], [codigoficha]) VALUES (20, N'Hilo capellada', N'Hilo rio azul', N'cono', CAST(6.50 AS Decimal(18, 2)), CAST(6.50 AS Decimal(18, 2)), N'sólido', 1, N'CP2', N'F03')
INSERT [dbo].[Material] ([idmaterial], [nombre], [descripcion], [unidadmedida], [cantidaddocena], [preciounitario], [tipo], [idproveedor], [codigoproceso], [codigoficha]) VALUES (21, N'Hilo forro', N'Hilo rio COD 123', N'cono', CAST(6.50 AS Decimal(18, 2)), CAST(6.50 AS Decimal(18, 2)), N'sólido', 2, N'CP2', N'F03')
INSERT [dbo].[Material] ([idmaterial], [nombre], [descripcion], [unidadmedida], [cantidaddocena], [preciounitario], [tipo], [idproveedor], [codigoproceso], [codigoficha]) VALUES (22, N'Falsa', N'de línea 1190', N'doc', CAST(20.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), N'sólido', 2, N'CP3', N'F03')
INSERT [dbo].[Material] ([idmaterial], [nombre], [descripcion], [unidadmedida], [cantidaddocena], [preciounitario], [tipo], [idproveedor], [codigoproceso], [codigoficha]) VALUES (23, N'Plantilla', N'Badana nude', N'pie 2', CAST(2.70 AS Decimal(18, 2)), CAST(2.70 AS Decimal(18, 2)), N'sólido', 3, N'CP4', N'F03')
INSERT [dbo].[Material] ([idmaterial], [nombre], [descripcion], [unidadmedida], [cantidaddocena], [preciounitario], [tipo], [idproveedor], [codigoproceso], [codigoficha]) VALUES (24, N'Etiqueta', N'Transfer', N'doc', CAST(3.00 AS Decimal(18, 2)), CAST(3.00 AS Decimal(18, 2)), N'sólido', 3, N'CP4', N'F03')
INSERT [dbo].[Material] ([idmaterial], [nombre], [descripcion], [unidadmedida], [cantidaddocena], [preciounitario], [tipo], [idproveedor], [codigoproceso], [codigoficha]) VALUES (25, N'Tira de falsa', N'Sintético Charol Nude', N'm', CAST(0.19 AS Decimal(18, 2)), CAST(1.50 AS Decimal(18, 2)), N'sólido', 1, N'CP1', N'F01')
INSERT [dbo].[Material] ([idmaterial], [nombre], [descripcion], [unidadmedida], [cantidaddocena], [preciounitario], [tipo], [idproveedor], [codigoproceso], [codigoficha]) VALUES (26, N'Puntera', N'Sintético Charol Nude', N'm', CAST(0.12 AS Decimal(18, 2)), CAST(2.00 AS Decimal(18, 2)), N'sólido', 1, N'CP1', N'F03')
INSERT [dbo].[Material] ([idmaterial], [nombre], [descripcion], [unidadmedida], [cantidaddocena], [preciounitario], [tipo], [idproveedor], [codigoproceso], [codigoficha]) VALUES (27, N'Forro de Plataforma', N'Sintético Charol Nude', N'm', CAST(0.30 AS Decimal(18, 2)), CAST(2.00 AS Decimal(18, 2)), N'sólido', 1, N'CP1', N'F01')
INSERT [dbo].[Material] ([idmaterial], [nombre], [descripcion], [unidadmedida], [cantidaddocena], [preciounitario], [tipo], [idproveedor], [codigoproceso], [codigoficha]) VALUES (28, N'forro de Taco', N'Sintético Charol Nude', N'm', CAST(0.25 AS Decimal(18, 2)), CAST(2.30 AS Decimal(18, 2)), N'sólido', 1, N'CP1', N'F01')
INSERT [dbo].[Material] ([idmaterial], [nombre], [descripcion], [unidadmedida], [cantidaddocena], [preciounitario], [tipo], [idproveedor], [codigoproceso], [codigoficha]) VALUES (29, N'Puntera', N'Sintético Charol Nude', N'm', CAST(0.12 AS Decimal(18, 2)), CAST(2.50 AS Decimal(18, 2)), N'sólido', 1, N'CP1', N'F01')
INSERT [dbo].[Material] ([idmaterial], [nombre], [descripcion], [unidadmedida], [cantidaddocena], [preciounitario], [tipo], [idproveedor], [codigoproceso], [codigoficha]) VALUES (30, N'Hilo refuerzo', N'Hilo piramide color Nude', N'cono', CAST(0.17 AS Decimal(18, 2)), CAST(2.50 AS Decimal(18, 2)), N'sólido', 2, N'CP2', N'F01')
INSERT [dbo].[Material] ([idmaterial], [nombre], [descripcion], [unidadmedida], [cantidaddocena], [preciounitario], [tipo], [idproveedor], [codigoproceso], [codigoficha]) VALUES (31, N'Refuerzo 1', N'Lona delgada - capellada', N'm', CAST(0.40 AS Decimal(18, 2)), CAST(1.50 AS Decimal(18, 2)), N'sólido', 1, N'CP2', N'F01')
INSERT [dbo].[Material] ([idmaterial], [nombre], [descripcion], [unidadmedida], [cantidaddocena], [preciounitario], [tipo], [idproveedor], [codigoproceso], [codigoficha]) VALUES (32, N'Refuerzo 2', N'Cintillo Grueso', N'cono', CAST(0.06 AS Decimal(18, 2)), CAST(1.50 AS Decimal(18, 2)), N'sólido', 2, N'CP2', N'F01')
INSERT [dbo].[Material] ([idmaterial], [nombre], [descripcion], [unidadmedida], [cantidaddocena], [preciounitario], [tipo], [idproveedor], [codigoproceso], [codigoficha]) VALUES (33, N'Refuerzo 3', N'Lona - costura guante', N'cono', CAST(0.10 AS Decimal(18, 2)), CAST(2.50 AS Decimal(18, 2)), N'sólido', 1, N'CP2', N'F01')
INSERT [dbo].[Material] ([idmaterial], [nombre], [descripcion], [unidadmedida], [cantidaddocena], [preciounitario], [tipo], [idproveedor], [codigoproceso], [codigoficha]) VALUES (34, N'Accesorio 1', N'Botón Vilma dorado', N'doc', CAST(1.00 AS Decimal(18, 2)), CAST(0.50 AS Decimal(18, 2)), N'sólido', 3, N'CP2', N'F01')
INSERT [dbo].[Material] ([idmaterial], [nombre], [descripcion], [unidadmedida], [cantidaddocena], [preciounitario], [tipo], [idproveedor], [codigoproceso], [codigoficha]) VALUES (35, N'Accesorio 2', N'Hebilla cod 182', N'doc', CAST(1.00 AS Decimal(18, 2)), CAST(0.50 AS Decimal(18, 2)), N'sólido', 2, N'CP2', N'F01')
INSERT [dbo].[Material] ([idmaterial], [nombre], [descripcion], [unidadmedida], [cantidaddocena], [preciounitario], [tipo], [idproveedor], [codigoproceso], [codigoficha]) VALUES (36, N'Refuerzo', N'Jebe líquido', N'Lata', CAST(0.07 AS Decimal(18, 2)), CAST(2.50 AS Decimal(18, 2)), N'Líquido', 3, N'CP2', N'F01')
INSERT [dbo].[Material] ([idmaterial], [nombre], [descripcion], [unidadmedida], [cantidaddocena], [preciounitario], [tipo], [idproveedor], [codigoproceso], [codigoficha]) VALUES (37, N'Unión ', N'Pegamento', N'Lata', CAST(0.01 AS Decimal(18, 2)), CAST(1.50 AS Decimal(18, 2)), N'Líquido', 3, N'CP2', N'F01')
INSERT [dbo].[Material] ([idmaterial], [nombre], [descripcion], [unidadmedida], [cantidaddocena], [preciounitario], [tipo], [idproveedor], [codigoproceso], [codigoficha]) VALUES (38, N'Contrafuerte', N'Maxin N° 619', N'', CAST(0.33 AS Decimal(18, 2)), CAST(1.50 AS Decimal(18, 2)), N'Sólido', 1, N'CP3', N'F01')
INSERT [dbo].[Material] ([idmaterial], [nombre], [descripcion], [unidadmedida], [cantidaddocena], [preciounitario], [tipo], [idproveedor], [codigoproceso], [codigoficha]) VALUES (39, N'Puntera', N'', N'', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'Sólido', 1, N'CP3', N'F01')
INSERT [dbo].[Material] ([idmaterial], [nombre], [descripcion], [unidadmedida], [cantidaddocena], [preciounitario], [tipo], [idproveedor], [codigoproceso], [codigoficha]) VALUES (40, N'Plataforma', N'De línea 30PL19', N'doc', CAST(1.00 AS Decimal(18, 2)), CAST(1.50 AS Decimal(18, 2)), N'Sólido', 1, N'CP3', N'F01')
INSERT [dbo].[Material] ([idmaterial], [nombre], [descripcion], [unidadmedida], [cantidaddocena], [preciounitario], [tipo], [idproveedor], [codigoproceso], [codigoficha]) VALUES (41, N'Taco', N'De línea 9T252 PL 30', N'doc', CAST(1.00 AS Decimal(18, 2)), CAST(1.25 AS Decimal(18, 2)), N'Sólido', 2, N'CP3', N'F01')
INSERT [dbo].[Material] ([idmaterial], [nombre], [descripcion], [unidadmedida], [cantidaddocena], [preciounitario], [tipo], [idproveedor], [codigoproceso], [codigoficha]) VALUES (42, N'Tapilla', N'Color Nude', N'doc', CAST(1.00 AS Decimal(18, 2)), CAST(1.50 AS Decimal(18, 2)), N'sólido', 3, N'CP3', N'F01')
INSERT [dbo].[Material] ([idmaterial], [nombre], [descripcion], [unidadmedida], [cantidaddocena], [preciounitario], [tipo], [idproveedor], [codigoproceso], [codigoficha]) VALUES (43, N'Piso', N'Neolit', N'doc', CAST(1.00 AS Decimal(18, 2)), CAST(1.50 AS Decimal(18, 2)), N'sólido', 2, N'CP3', N'F01')
INSERT [dbo].[Material] ([idmaterial], [nombre], [descripcion], [unidadmedida], [cantidaddocena], [preciounitario], [tipo], [idproveedor], [codigoproceso], [codigoficha]) VALUES (44, N'Aplique de piso', N'Placa Vilma Dorado', N'doc', CAST(1.00 AS Decimal(18, 2)), CAST(1.50 AS Decimal(18, 2)), N'sólido', 2, N'CP3', N'F01')
INSERT [dbo].[Material] ([idmaterial], [nombre], [descripcion], [unidadmedida], [cantidaddocena], [preciounitario], [tipo], [idproveedor], [codigoproceso], [codigoficha]) VALUES (45, N'Inmersión', N'Disolvente', N'Lata', CAST(0.02 AS Decimal(18, 2)), CAST(1.00 AS Decimal(18, 2)), N'Líquido', 2, N'CP3', N'F01')
INSERT [dbo].[Material] ([idmaterial], [nombre], [descripcion], [unidadmedida], [cantidaddocena], [preciounitario], [tipo], [idproveedor], [codigoproceso], [codigoficha]) VALUES (46, N'Empaste ', N'Terolan', N'balde', CAST(0.06 AS Decimal(18, 2)), CAST(2.00 AS Decimal(18, 2)), N'líquido', 1, N'CP3', N'F01')
INSERT [dbo].[Material] ([idmaterial], [nombre], [descripcion], [unidadmedida], [cantidaddocena], [preciounitario], [tipo], [idproveedor], [codigoproceso], [codigoficha]) VALUES (47, N'Enfalsado', N'Chinches N° 02', N'kilo', CAST(0.05 AS Decimal(18, 2)), CAST(2.50 AS Decimal(18, 2)), N'líquido', 2, N'CP3', N'F01')
INSERT [dbo].[Material] ([idmaterial], [nombre], [descripcion], [unidadmedida], [cantidaddocena], [preciounitario], [tipo], [idproveedor], [codigoproceso], [codigoficha]) VALUES (48, N'Centrado de corte', N'Clavo', N'kilo', CAST(0.05 AS Decimal(18, 2)), CAST(1.50 AS Decimal(18, 2)), N'líquido', 2, N'CP3', N'F01')
INSERT [dbo].[Material] ([idmaterial], [nombre], [descripcion], [unidadmedida], [cantidaddocena], [preciounitario], [tipo], [idproveedor], [codigoproceso], [codigoficha]) VALUES (49, N'Armado-adhesivo', N'Pegamento Calzapeg', N'Lata', CAST(0.03 AS Decimal(18, 2)), CAST(1.50 AS Decimal(18, 2)), N'líquido', 3, N'CP3', N'F01')
INSERT [dbo].[Material] ([idmaterial], [nombre], [descripcion], [unidadmedida], [cantidaddocena], [preciounitario], [tipo], [idproveedor], [codigoproceso], [codigoficha]) VALUES (50, N'Armado', N'', N'', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'líquido', 3, N'CP3', N'F01')
INSERT [dbo].[Material] ([idmaterial], [nombre], [descripcion], [unidadmedida], [cantidaddocena], [preciounitario], [tipo], [idproveedor], [codigoproceso], [codigoficha]) VALUES (51, N'Limpieza de piso ', N'Halógeno', N'frasco', CAST(0.04 AS Decimal(18, 2)), CAST(1.50 AS Decimal(18, 2)), N'líquido', 1, N'CP3', N'F01')
INSERT [dbo].[Material] ([idmaterial], [nombre], [descripcion], [unidadmedida], [cantidaddocena], [preciounitario], [tipo], [idproveedor], [codigoproceso], [codigoficha]) VALUES (52, N'Pegado', N'PVC-Killing', N'Lata', CAST(0.01 AS Decimal(18, 2)), CAST(1.00 AS Decimal(18, 2)), N'líquido', 2, N'CP3', N'F01')
INSERT [dbo].[Material] ([idmaterial], [nombre], [descripcion], [unidadmedida], [cantidaddocena], [preciounitario], [tipo], [idproveedor], [codigoproceso], [codigoficha]) VALUES (53, N'Clavado de Taco', N'Clavo tornillo N° 22', N'caja', CAST(0.05 AS Decimal(18, 2)), CAST(3.00 AS Decimal(18, 2)), N'líquido', 2, N'CP3', N'F01')
INSERT [dbo].[Material] ([idmaterial], [nombre], [descripcion], [unidadmedida], [cantidaddocena], [preciounitario], [tipo], [idproveedor], [codigoproceso], [codigoficha]) VALUES (54, N'Confort', N'Esponja', N'pl', CAST(0.17 AS Decimal(18, 2)), CAST(2.50 AS Decimal(18, 2)), N'sólido', 3, N'CP4', N'F01')
INSERT [dbo].[Material] ([idmaterial], [nombre], [descripcion], [unidadmedida], [cantidaddocena], [preciounitario], [tipo], [idproveedor], [codigoproceso], [codigoficha]) VALUES (55, N'Papel', N'Vilma', N'doc', CAST(1.00 AS Decimal(18, 2)), CAST(1.00 AS Decimal(18, 2)), N'sólido', 1, N'CP4', N'F01')
INSERT [dbo].[Material] ([idmaterial], [nombre], [descripcion], [unidadmedida], [cantidaddocena], [preciounitario], [tipo], [idproveedor], [codigoproceso], [codigoficha]) VALUES (56, N'Caja', N'Vilma', N'doc', CAST(1.00 AS Decimal(18, 2)), CAST(1.20 AS Decimal(18, 2)), N'sólido', 3, N'CP4', N'F01')
INSERT [dbo].[Material] ([idmaterial], [nombre], [descripcion], [unidadmedida], [cantidaddocena], [preciounitario], [tipo], [idproveedor], [codigoproceso], [codigoficha]) VALUES (57, N'Pintado', N'Tinte', N'frasco', CAST(0.10 AS Decimal(18, 2)), CAST(2.50 AS Decimal(18, 2)), N'líquido', 2, N'CP4', N'F01')
INSERT [dbo].[Material] ([idmaterial], [nombre], [descripcion], [unidadmedida], [cantidaddocena], [preciounitario], [tipo], [idproveedor], [codigoproceso], [codigoficha]) VALUES (58, N'Limpieza', N'Bencina', N'galon', CAST(0.05 AS Decimal(18, 2)), CAST(1.50 AS Decimal(18, 2)), N'líquido', 1, N'CP4', N'F01')
INSERT [dbo].[Material] ([idmaterial], [nombre], [descripcion], [unidadmedida], [cantidaddocena], [preciounitario], [tipo], [idproveedor], [codigoproceso], [codigoficha]) VALUES (59, N'Limpieza', N'Disolvente', N'Lata', CAST(0.01 AS Decimal(18, 2)), CAST(1.50 AS Decimal(18, 2)), N'líquido', 3, N'CP4', N'F01')
INSERT [dbo].[Material] ([idmaterial], [nombre], [descripcion], [unidadmedida], [cantidaddocena], [preciounitario], [tipo], [idproveedor], [codigoproceso], [codigoficha]) VALUES (60, N'Emplantillado', N'Pegamento CALZAPEG', N'lata', CAST(0.01 AS Decimal(18, 2)), CAST(1.50 AS Decimal(18, 2)), N'líquido', 2, N'CP4', N'F01')
INSERT [dbo].[Material] ([idmaterial], [nombre], [descripcion], [unidadmedida], [cantidaddocena], [preciounitario], [tipo], [idproveedor], [codigoproceso], [codigoficha]) VALUES (61, N'Encremado', N'Tinte', N'frasco', CAST(0.10 AS Decimal(18, 2)), CAST(2.50 AS Decimal(18, 2)), N'líquido', 2, N'CP4', N'F01')
INSERT [dbo].[Material] ([idmaterial], [nombre], [descripcion], [unidadmedida], [cantidaddocena], [preciounitario], [tipo], [idproveedor], [codigoproceso], [codigoficha]) VALUES (62, N'Prueba uno', N'prueba descripción', N'doc', CAST(2.00 AS Decimal(18, 2)), CAST(1.50 AS Decimal(18, 2)), N'sólido', 2, N'CP4', N'F02')
INSERT [dbo].[Material] ([idmaterial], [nombre], [descripcion], [unidadmedida], [cantidaddocena], [preciounitario], [tipo], [idproveedor], [codigoproceso], [codigoficha]) VALUES (66, N'prueba cuatro', N'Prueba tres otra vez', N'doc', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', 1, N'CP3', N'F02')
SET IDENTITY_INSERT [dbo].[Material] OFF
INSERT [dbo].[Modelo] ([codigomodelo], [horma], [especificacion], [idcliente], [estado]) VALUES (N'2H03', N'50240', N'CORTADO: Area de Material en uso de cuero negro.', 1, 1)
INSERT [dbo].[Modelo] ([codigomodelo], [horma], [especificacion], [idcliente], [estado]) VALUES (N'FLO-045', N'50763', N'CORTADO: Area de Material en uso: 1,34 x 1,36', 1, 1)
INSERT [dbo].[Orden] ([codigoorden], [orden_pedido], [fecha_emision], [fecha_entrega], [codigoficha], [total]) VALUES (N'013-P', N'001-2016', CAST(0x0000A63300000000 AS DateTime), CAST(0x0000A63500000000 AS DateTime), N'F01', 60)
INSERT [dbo].[Orden] ([codigoorden], [orden_pedido], [fecha_emision], [fecha_entrega], [codigoficha], [total]) VALUES (N'075-V', N'1618', CAST(0x0000A63300000000 AS DateTime), CAST(0x0000A63500000000 AS DateTime), N'F03', 12)
INSERT [dbo].[Proceso] ([codigoproceso], [descripcion]) VALUES (N'CP1', N'Corte')
INSERT [dbo].[Proceso] ([codigoproceso], [descripcion]) VALUES (N'CP2', N'Aparado')
INSERT [dbo].[Proceso] ([codigoproceso], [descripcion]) VALUES (N'CP3', N'Armado')
INSERT [dbo].[Proceso] ([codigoproceso], [descripcion]) VALUES (N'CP4', N'Alistado')
SET IDENTITY_INSERT [dbo].[Proveedor] ON 

INSERT [dbo].[Proveedor] ([idproveedor], [razonsocial], [ruc], [direccion], [estado]) VALUES (1, N'ABEL', N'74185296332', N'Urb. La Rinconada', 1)
INSERT [dbo].[Proveedor] ([idproveedor], [razonsocial], [ruc], [direccion], [estado]) VALUES (2, N'ROSITA', N'21457896324', N'Urb. Palermo', 1)
INSERT [dbo].[Proveedor] ([idproveedor], [razonsocial], [ruc], [direccion], [estado]) VALUES (3, N'ELVIS', N'43534534534', N'El Porvenir', 1)
INSERT [dbo].[Proveedor] ([idproveedor], [razonsocial], [ruc], [direccion], [estado]) VALUES (4, N'RODOLFO', N'34567677868', N'Urb. La Rinconada', 1)
INSERT [dbo].[Proveedor] ([idproveedor], [razonsocial], [ruc], [direccion], [estado]) VALUES (5, N'ISABEL', N'10524596321', N'Urb. La Rinconada', 1)
INSERT [dbo].[Proveedor] ([idproveedor], [razonsocial], [ruc], [direccion], [estado]) VALUES (6, N'JULIO', N'10854596317', N'El Porvenir', 1)
INSERT [dbo].[Proveedor] ([idproveedor], [razonsocial], [ruc], [direccion], [estado]) VALUES (7, N'ADRIANO', N'10234568714', N'El Porvenir', 1)
INSERT [dbo].[Proveedor] ([idproveedor], [razonsocial], [ruc], [direccion], [estado]) VALUES (8, N'Raulito S.A.C', N'21457896325', N'El Porvenir #147', 1)
INSERT [dbo].[Proveedor] ([idproveedor], [razonsocial], [ruc], [direccion], [estado]) VALUES (9, N'Julia S.A.C', N'21897452365', N'El Porvenir #100', 1)
SET IDENTITY_INSERT [dbo].[Proveedor] OFF
INSERT [dbo].[Serie] ([tallas], [pares], [codigoorden]) VALUES (35, 10, N'013-P')
INSERT [dbo].[Serie] ([tallas], [pares], [codigoorden]) VALUES (36, 20, N'013-P')
INSERT [dbo].[Serie] ([tallas], [pares], [codigoorden]) VALUES (37, 30, N'013-P')
INSERT [dbo].[Serie] ([tallas], [pares], [codigoorden]) VALUES (38, 0, N'013-P')
INSERT [dbo].[Serie] ([tallas], [pares], [codigoorden]) VALUES (39, 0, N'013-P')
INSERT [dbo].[Serie] ([tallas], [pares], [codigoorden]) VALUES (40, 0, N'013-P')
INSERT [dbo].[Serie] ([tallas], [pares], [codigoorden]) VALUES (35, 3, N'075-V')
INSERT [dbo].[Serie] ([tallas], [pares], [codigoorden]) VALUES (36, 3, N'075-V')
INSERT [dbo].[Serie] ([tallas], [pares], [codigoorden]) VALUES (37, 3, N'075-V')
INSERT [dbo].[Serie] ([tallas], [pares], [codigoorden]) VALUES (38, 3, N'075-V')
INSERT [dbo].[Serie] ([tallas], [pares], [codigoorden]) VALUES (39, 0, N'075-V')
INSERT [dbo].[Serie] ([tallas], [pares], [codigoorden]) VALUES (40, 0, N'075-V')
SET IDENTITY_INSERT [dbo].[Trabajador] ON 

INSERT [dbo].[Trabajador] ([idempleado], [dni], [nombres], [ape_paterno], [ape_materno], [direccion], [telefono], [celular], [fecha_nacimiento], [usuario], [contrasena], [estado], [codigoproceso]) VALUES (1, N'41138268', N'Santos ', N'Gutierrez', N'Amaya', N'Poroto, caserillo, huayavito', N'044216544', N'992810664', N'25/11/1981', N'san', N'123', 1, N'CP2')
INSERT [dbo].[Trabajador] ([idempleado], [dni], [nombres], [ape_paterno], [ape_materno], [direccion], [telefono], [celular], [fecha_nacimiento], [usuario], [contrasena], [estado], [codigoproceso]) VALUES (2, N'47153287', N'David', N'Montoya', N'Loyola', N'Urb. La Rinconada #123', N'044211641', N'948512657', N'21/03/1989', N'dav', N'123', 1, N'CP1')
INSERT [dbo].[Trabajador] ([idempleado], [dni], [nombres], [ape_paterno], [ape_materno], [direccion], [telefono], [celular], [fecha_nacimiento], [usuario], [contrasena], [estado], [codigoproceso]) VALUES (3, N'41692143', N'Miguel', N'Avila', N'Mantilla', N'Urb. La Libertad MZ N lote 10', N'044219832', N'948512748', N'21/10/1988', N'mig', N'123', 1, N'CP3')
INSERT [dbo].[Trabajador] ([idempleado], [dni], [nombres], [ape_paterno], [ape_materno], [direccion], [telefono], [celular], [fecha_nacimiento], [usuario], [contrasena], [estado], [codigoproceso]) VALUES (4, N'42856321', N'Gerardo', N'Garcia', N'Llique', N'Urb. Palermo #45', N'044214578', N'948532145', N'10/07/1998', N'ger', N'123', 1, N'CP4')
INSERT [dbo].[Trabajador] ([idempleado], [dni], [nombres], [ape_paterno], [ape_materno], [direccion], [telefono], [celular], [fecha_nacimiento], [usuario], [contrasena], [estado], [codigoproceso]) VALUES (5, N'47456312', N'Manuel', N'Polo', N'Medina', N'Urb. Libertad MZ U lote 8', N'044217584', N'941555945', N'1990-10-14', N'man', N'123', 1, N'CP1')
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
