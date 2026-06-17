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
	Dni VARCHAR(11) NOT NULL,
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
	Nombre VARCHAR(100) NOT NULL,
	Descripcion VARCHAR(255) NULL,
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
	IdDireccion INTEGER NOT NULL FOREIGN KEY REFERENCES DIRECCIONES(Id),
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
@descripcion varchar(255),
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
@descripcion varchar(255),
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

EXEC spAltaMarca 'Huawei'
EXEC spAltaMarca 'Samsung'

EXEC spAltaCategoria 'Televisores'

-- 1. Insertamos un producto usando los IDs de Categoría (1) y Marca (2 = Samsung)
EXEC spAltaProducto 'TV-SAM-001', 1, 2, 'Smart TV Samsung 50"', 'Televisor 4K UHD con sistema Tizen y bordes ultra finos.', 500000.00, 400000.00, 10, 1;

-- 2. Asumiendo que el ID de ese producto generado fue el 1, le cargamos dos fotos:
EXEC spAltaImagen 'https://tse1.mm.bing.net/th/id/OIP.fKqqpnyRVm9NSxMFOs8KLwHaHa?r=0&cb=thfvnextfalcon2&rs=1&pid=ImgDetMain&o=7&rm=3', 1;
EXEC spAltaImagen 'https://a-static.mlcdn.com.br/1500x1500/smart-tv-50-crystal-4k-samsung-50au7700-wi-fi-bluetooth-hdr-alexa-built-in-3-hdmi-1-usb/magazineluiza/193441200/15a3134ca277772436f19af65d9960ec.jpg', 1;