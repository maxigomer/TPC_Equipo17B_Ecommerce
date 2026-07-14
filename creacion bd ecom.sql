CREATE DATABASE ECOMMERCE_DB
GO

USE ECOMMERCE_DB
GO

CREATE TABLE ROLES(
	Id TINYINT NOT NULL PRIMARY KEY IDENTITY(1,1),
	Rol VARCHAR(50) NOT NULL
)
GO

CREATE TABLE USUARIOS(
	Id INTEGER NOT NULL PRIMARY KEY IDENTITY(1,1),
	Usuario VARCHAR(50) NOT NULL UNIQUE,
	Clave VARCHAR(255) NOT NULL,
	IdRol TINYINT NOT NULL FOREIGN KEY REFERENCES ROLES(Id)
)
GO

CREATE TABLE CLIENTES(
	Id INTEGER NOT NULL PRIMARY KEY IDENTITY(1,1),
	Nombre VARCHAR(50) NOT NULL,
	Apellido VARCHAR(50) NOT NULL,
	Dni VARCHAR(11) NULL,
	Email VARCHAR(50) NOT NULL UNIQUE,
	Telefono VARCHAR(15) NULL,
	IdUsuario INTEGER NOT NULL FOREIGN KEY REFERENCES USUARIOS(Id) UNIQUE
)
GO

CREATE TABLE DIRECCIONES(
	Id INTEGER NOT NULL PRIMARY KEY IDENTITY(1,1),
	IdCliente INTEGER NOT NULL FOREIGN KEY REFERENCES CLIENTES(Id),
	Calle VARCHAR(50) NOT NULL,
	Numero INTEGER NOT NULL,
	Localidad VARCHAR(50) NOT NULL,
	CodigoPostal VARCHAR(20) NOT NULL,
	Observaciones VARCHAR(150) NULL
)
GO

CREATE TABLE CARRITOS(
	Id INTEGER NOT NULL PRIMARY KEY IDENTITY(1,1),
	Fecha DATETIME NOT NULL,
	Precio DECIMAL(18,2) NOT NULL,
	IdCliente INTEGER NOT NULL FOREIGN KEY REFERENCES CLIENTES(Id)
)
GO

CREATE TABLE CATEGORIAS(
	Id INTEGER NOT NULL PRIMARY KEY IDENTITY(1,1),
	Nombre VARCHAR(50) NOT NULL UNIQUE
)
GO

CREATE TABLE MARCAS(
	Id INTEGER NOT NULL PRIMARY KEY IDENTITY(1,1),
	Nombre VARCHAR(70) NOT NULL UNIQUE,
)
GO


CREATE TABLE PRODUCTOS(
	Id INTEGER NOT NULL PRIMARY KEY IDENTITY(1,1),
	Sku VARCHAR(70) NOT NULL UNIQUE,
	IdCategoria INTEGER NOT NULL FOREIGN KEY REFERENCES CATEGORIAS(Id),
	IdMarca INTEGER NOT NULL FOREIGN KEY REFERENCES MARCAS(Id),
	Nombre VARCHAR(200) NOT NULL,
	Descripcion VARCHAR(3000) NULL,
	Precio DECIMAL(18,2) NOT NULL,
	Costo DECIMAL(18,2) NULL,
	Stock INTEGER NULL CHECK (Stock >= 0),
	Estado BIT NOT NULL
)
GO

CREATE TABLE IMAGENES(
	Id INTEGER NOT NULL PRIMARY KEY IDENTITY(1,1),
	Url VARCHAR(255) NOT NULL,
	IdProducto INTEGER NOT NULL FOREIGN KEY REFERENCES PRODUCTOS(Id)
)
GO

CREATE TABLE ITEM_CARRITOS(
	Id INTEGER NOT NULL PRIMARY KEY IDENTITY(1,1),
	IdCarrito INTEGER NOT NULL FOREIGN KEY REFERENCES CARRITOS(Id),
	IdProducto INTEGER NOT NULL FOREIGN KEY REFERENCES PRODUCTOS(Id),
	Cantidad SMALLINT NOT NULL CHECK (Cantidad >= 0),
	Precio DECIMAL(18,2) NOT NULL
)
GO

CREATE TABLE METODOS_DE_PAGO(
	Id INTEGER NOT NULL PRIMARY KEY IDENTITY(1,1),
	Nombre VARCHAR(50) NOT NULL
)
GO

CREATE TABLE FORMAS_DE_ENTREGA(
	Id INTEGER NOT NULL PRIMARY KEY IDENTITY(1,1),
	Nombre VARCHAR(50) NOT NULL
)
GO

CREATE TABLE ESTADOS_DE_PEDIDO(
	Id TINYINT NOT NULL PRIMARY KEY IDENTITY(1,1),
	Estado VARCHAR(50) NOT NULL
)
GO

CREATE TABLE PEDIDOS(
	Id INTEGER NOT NULL PRIMARY KEY IDENTITY(1,1),
	IdCliente INTEGER NOT NULL FOREIGN KEY REFERENCES CLIENTES(Id),
	IdDireccion INTEGER NULL FOREIGN KEY REFERENCES DIRECCIONES(Id),
	IdMetodoDePago INTEGER NOT NULL FOREIGN KEY REFERENCES METODOS_DE_PAGO(Id),
	Fecha DATETIME NOT NULL,
	Precio DECIMAL(18,2) NOT NULL,
	IdFormaDeEntrega INTEGER NOT NULL FOREIGN KEY REFERENCES FORMAS_DE_ENTREGA(Id),
	IdEstado TINYINT NOT NULL FOREIGN KEY REFERENCES ESTADOS_DE_PEDIDO(Id)
)
GO

CREATE TABLE OBSERVACIONES_PEDIDOS(
	Id INTEGER NOT NULL PRIMARY KEY IDENTITY(1,1),
	IdPedido INTEGER NOT NULL FOREIGN KEY REFERENCES PEDIDOS(Id),
	Observacion VARCHAR(255)
)
GO

CREATE TABLE ITEM_PEDIDOS(
	Id INTEGER NOT NULL PRIMARY KEY IDENTITY(1,1),
	IdPedido INTEGER NOT NULL FOREIGN KEY REFERENCES PEDIDOS(Id),
	IdProducto INTEGER NOT NULL FOREIGN KEY REFERENCES PRODUCTOS(Id),
	Cantidad SMALLINT NOT NULL CHECK (Cantidad >= 0),
	Precio DECIMAL(18,2) NOT NULL
)
GO

CREATE TABLE COLECCIONES_MENU(
	Id INTEGER NOT NULL PRIMARY KEY IDENTITY(1,1),
	Nombre VARCHAR(50) NULL,
	IdCriterio INTEGER NULL,
	Criterio BIT NULL,
	Estado BIT NOT NULL
)
GO

CREATE TABLE BANNERS(
	Id integer NOT NULL PRIMARY KEY IDENTITY(1,1),
	Url VARCHAR(255) NOT NULL
)
GO

CREATE PROCEDURE spAltaCategoria(
@nombre varchar(50)
)
as
BEGIN
INSERT INTO CATEGORIAS (Nombre) VALUES(@nombre)
END
GO

CREATE PROCEDURE spAltaMarca(
@nombre varchar(70)
)
AS
BEGIN
INSERT INTO MARCAS (Nombre) VALUES (@nombre)
END
GO

CREATE PROCEDURE spAltaProducto(
@sku varchar(70),
@idCategoria integer,
@idMarca integer,
@nombre varchar(100),
@descripcion varchar(3000),
@precio decimal,
@costo decimal,
@stock integer,
@estado bit
)
AS
BEGIN
INSERT INTO PRODUCTOS (Sku,IdCategoria,IdMarca,Nombre,Descripcion,Precio,Costo,Stock,Estado) VALUES (@sku,@idCategoria,@idMarca,@nombre,@descripcion,@precio,@costo,@stock,@estado)
END
GO

CREATE PROCEDURE spAltaProductoScalar(
@sku varchar(70),
@idCategoria integer,
@idMarca integer,
@nombre varchar(100),
@descripcion varchar(3000),
@precio decimal,
@costo decimal,
@stock integer,
@estado bit
)
AS
BEGIN
INSERT INTO PRODUCTOS (Sku,IdCategoria,IdMarca,Nombre,Descripcion,Precio,Costo,Stock,Estado) VALUES (@sku,@idCategoria,@idMarca,@nombre,@descripcion,@precio,@costo,@stock,@estado)
SELECT SCOPE_IDENTITY();
END
GO

CREATE PROCEDURE spListarProductos
AS
BEGIN
SELECT P.Id, Sku, P.Nombre, P.Descripcion, Precio, Costo, Stock , M.Nombre Marca, C.Nombre Categoria, IdCategoria, IdMarca, Estado FROM PRODUCTOS P, MARCAS M, CATEGORIAS C WHERE M.Id = P.IdMarca and C.Id = P.IdCategoria
END
GO

CREATE PROCEDURE spListarProductosActivos
AS
BEGIN
SELECT P.Id, Sku, P.Nombre, P.Descripcion, Precio, Costo, Stock , M.Nombre Marca, C.Nombre Categoria, IdCategoria, IdMarca, Estado FROM PRODUCTOS P, MARCAS M, CATEGORIAS C WHERE M.Id = P.IdMarca and C.Id = P.IdCategoria and Estado = 1
END
GO

CREATE PROCEDURE spAltaImagen(
@url varchar(255),
@idProducto int
)
AS
BEGIN
INSERT INTO IMAGENES (Url,IdProducto) VALUES (@url,@IdProducto)
END
GO

CREATE PROCEDURE spAltaMarcaScalar(
@nombre varchar(70)
)
AS
BEGIN
INSERT INTO MARCAS (Nombre) VALUES (@nombre)
SELECT SCOPE_IDENTITY();
END
GO

CREATE PROCEDURE spAltaCategoriaScalar(
@nombre varchar(50)
)
as
BEGIN
INSERT INTO CATEGORIAS (Nombre) VALUES(@nombre)
SELECT SCOPE_IDENTITY();
END
GO

CREATE PROCEDURE spListarProductoId(
@id integer
)
AS
BEGIN
SELECT P.Id, Sku, P.Nombre, P.Descripcion, Precio, Costo, Stock , M.Nombre Marca, C.Nombre Categoria, IdCategoria, IdMarca, Estado FROM PRODUCTOS P, MARCAS M, CATEGORIAS C WHERE M.Id = P.IdMarca and C.Id = P.IdCategoria and P.Id = @id
END
GO

CREATE PROCEDURE spModificarProducto(
@id integer,
@sku varchar(70),
@idCategoria integer,
@idMarca integer,
@nombre varchar(100),
@descripcion varchar(255),
@precio decimal(18,2),
@costo decimal(18,2),
@stock integer,
@estado bit
)
AS
BEGIN
UPDATE PRODUCTOS SET Sku = @sku, IdCategoria = @idCategoria, IdMarca = @idMarca, Nombre = @nombre, Descripcion = @descripcion, Precio = @precio, Costo = @costo, Stock = @stock, Estado = @estado
WHERE Id = @id
END
GO

CREATE PROCEDURE spEliminarImagen(
@id integer
)
AS
BEGIN
DELETE FROM iMAGENES WHERE Id = @id
END
GO

CREATE PROCEDURE spEliminarProducto(
@id integer
)
AS
BEGIN
DELETE FROM IMAGENES WHERE IdProducto = @id
DELETE FROM PRODUCTOS WHERE Id = @id
END
GO

CREATE PROCEDURE spCheckCategorias
AS
BEGIN
DELETE FROM CATEGORIAS
WHERE Id NOT IN (
	SELECT DISTINCT IdCategoria FROM PRODUCTOS WHERE IdCategoria IS NOT NULL
)
END
GO

CREATE PROCEDURE spCheckMarcas
AS
BEGIN
DELETE FROM MARCAS
WHERE Id NOT IN (
	SELECT DISTINCT IdMarca FROM PRODUCTOS WHERE IdMarca IS NOT NULL
)
END
GO

CREATE PROCEDURE spActualizarColecciones(
@id INTEGER,
@nombre VARCHAR(50),
@idCriterio INTEGER,
@criterio BIT,
@estado BIT
)
AS
BEGIN
	UPDATE COLECCIONES_MENU SET Nombre = @nombre, IdCriterio = @idCriterio, Criterio = @criterio, Estado = @estado WHERE Id = @id
END
GO

CREATE PROCEDURE spListarProductosActivos_FiltroMarca(
@id INTEGER
)
AS
BEGIN
SELECT P.Id, Sku, P.Nombre, P.Descripcion, Precio, Costo, Stock , M.Nombre Marca, C.Nombre Categoria, IdCategoria, IdMarca, Estado FROM PRODUCTOS P, MARCAS M, CATEGORIAS C WHERE M.Id = P.IdMarca and C.Id = P.IdCategoria and Estado = 1 and P.IdMarca = @id
END
GO

CREATE PROCEDURE spListarProductosActivos_FiltroCategoria(
@id INTEGER
)
AS
BEGIN
SELECT P.Id, Sku, P.Nombre, P.Descripcion, Precio, Costo, Stock , M.Nombre Marca, C.Nombre Categoria, IdCategoria, IdMarca, Estado FROM PRODUCTOS P, MARCAS M, CATEGORIAS C WHERE M.Id = P.IdMarca and C.Id = P.IdCategoria and Estado = 1 and P.IdCategoria = @id
END
GO

CREATE PROCEDURE sp_login(
@usuario VARCHAR(50),
@clave VARCHAR(50)
)
AS
BEGIN
SELECT U.Id, U.IdRol, R.Rol FROM USUARIOS U INNER JOIN ROLES R ON U.IdRol = R.Id WHERE U.Usuario = @usuario AND U.Clave = @clave
END
GO

CREATE PROCEDURE spRegistrarCliente(
@nombre VARCHAR(50),
@apellido VARCHAR(50),
@dni VARCHAR(11),
@email VARCHAR(50),
@telefono VARCHAR(15),
@clave VARCHAR(255)
)
AS
BEGIN
	DECLARE @idUsuario INTEGER;
	
	INSERT INTO USUARIOS(Usuario,Clave,IdRol) VALUES(@email,@clave,2);
	SET @idUsuario = SCOPE_IDENTITY();

	INSERT INTO CLIENTES (Nombre,Apellido,Dni,Email,Telefono,IdUsuario) VALUES(@nombre,@apellido,@dni,@email,@telefono,@idUsuario);

END
GO

CREATE PROCEDURE spAltaPedido(
@idCliente INTEGER,
@idDireccion INTEGER,
@idMetodoDePago INTEGER,
@fecha DATETIME,
@precio DECIMAL(18,2),
@idFormaDeEntrega INTEGER
)
AS
BEGIN
INSERT INTO PEDIDOS (IdCliente,IdDireccion,IdMetodoDePago,Fecha,Precio,IdFormaDeEntrega,IdEstado) VALUES (@idCliente,@idDireccion,@idMetodoDePago,@fecha,@precio,@idFormaDeEntrega,1)
SELECT SCOPE_IDENTITY();
END
GO

CREATE PROCEDURE spAltaDireccion(
@idCliente INTEGER,
@calle VARCHAR(50),
@numero INTEGER,
@localidad VARCHAR(50),
@codigoPostal VARCHAR(20),
@observaciones VARCHAR(150)
)
AS
BEGIN
INSERT INTO DIRECCIONES (IdCliente,Calle,Numero,Localidad,CodigoPostal,Observaciones) VALUES(@idCliente,@calle,@numero,@localidad,@codigoPostal,@observaciones)
SELECT SCOPE_IDENTITY();
END
GO

CREATE PROCEDURE spAltaItemPedido(
@idPedido INTEGER,
@idProducto INTEGER,
@cantidad INTEGER,
@precio DECIMAL(18,2)
)
AS
BEGIN
INSERT INTO ITEM_PEDIDOS (IdPedido,IdProducto,Cantidad,Precio) VALUES (@idPedido,@idProducto,@cantidad,@precio)
END
GO
