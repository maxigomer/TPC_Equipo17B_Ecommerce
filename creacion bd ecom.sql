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

EXEC spAltaMarca 'Huawei'
EXEC spAltaMarca 'Samsung'

EXEC spAltaCategoria 'Televisores'

-- 1. Insertamos un producto usando los IDs de Categoría (1) y Marca (2 = Samsung)
EXEC spAltaProducto 'TV-SAM-001', 1, 2, 'Smart TV Samsung 50"', 'Televisor 4K UHD con sistema Tizen y bordes ultra finos.', 500000.00, 400000.00, 10, 1;

-- 2. Asumiendo que el ID de ese producto generado fue el 1, le cargamos dos fotos:
EXEC spAltaImagen 'https://tse1.mm.bing.net/th/id/OIP.fKqqpnyRVm9NSxMFOs8KLwHaHa?r=0&cb=thfvnextfalcon2&rs=1&pid=ImgDetMain&o=7&rm=3', 1;
EXEC spAltaImagen 'https://a-static.mlcdn.com.br/1500x1500/smart-tv-50-crystal-4k-samsung-50au7700-wi-fi-bluetooth-hdr-alexa-built-in-3-hdmi-1-usb/magazineluiza/193441200/15a3134ca277772436f19af65d9960ec.jpg', 1;

USE ECOMMERCE_DB;
GO

-- 1. Creamos Roles básicos
INSERT INTO ROLES (Rol) VALUES ('Admin'), ('Cliente');
GO

-- 2. Creamos 3 Usuarios para nuestros clientes (Se asignan al IdRol 2 = Cliente)
INSERT INTO USUARIOS (Usuario, Clave, IdRol) VALUES 
('fluna', '1234', 2),
('mgomez', '1234', 2),
('clopez', '1234', 2);
GO

-- 3. Creamos 3 Clientes vinculados a los usuarios recién creados
INSERT INTO CLIENTES (Nombre, Apellido, Dni, Email, Telefono, IdUsuario) VALUES 
('Facundo', 'Luna', '40111222', 'facundo@email.com', '1122334455', 1),
('María', 'Gómez', '31222333', 'maria.gomez@email.com', '1199887766', 2),
('Carlos', 'López', '32333444', 'carlos.lopez@email.com', '1155443322', 3);
GO

-- 4. Creamos Direcciones para esos clientes
INSERT INTO DIRECCIONES (IdCliente, Calle, Numero, Localidad, CodigoPostal, Observaciones) VALUES 
(1, 'Ruta 197', 1234, 'General Pacheco', 'B1618', 'Casa con rejas negras'),
(2, 'Calle Falsa', 456, 'CABA', 'C1001', 'Depto 4B'),
(3, 'Av. San Martín', 890, 'Tigre', 'B1648', 'Local a la calle');
GO

-- 5. Llenamos las tablas paramétricas que necesita un Pedido
INSERT INTO METODOS_DE_PAGO (Nombre) VALUES ('Tarjeta de Crédito'), ('Mercado Pago'), ('Transferencia Bancaria');
INSERT INTO FORMAS_DE_ENTREGA (Nombre) VALUES ('Envío a Domicilio'), ('Retiro en Sucursal');
INSERT INTO ESTADOS_DE_PEDIDO (Estado) VALUES ('Pendiente'), ('Enviado'), ('Entregado');
GO

-- 6. Finalmente, creamos los 3 Pedidos
-- Estructura: IdCliente, IdDireccion, IdMetodoDePago, Fecha, Precio, IdFormaDeEntrega, IdEstado
INSERT INTO PEDIDOS (IdCliente, IdDireccion, IdMetodoDePago, Fecha, Precio, IdFormaDeEntrega, IdEstado) VALUES 
(1, 1, 2, GETDATE(), 15500.50, 1, 1), -- Facundo, Envío, Pendiente, por Mercado Pago
(2, 2, 1, GETDATE(), 8990.00, 1, 2),  -- María, Envío, Enviado, Tarjeta de Crédito
(3, 3, 3, '2026-06-10', 45000.00, 2, 3); -- Carlos, Retiro, Entregado, Transferencia
GO

-- Agrego colecciones vacias
INSERT INTO COLECCIONES_MENU (Nombre,IdCriterio,Criterio,Estado) VALUES (null,null,null,0), (null,null,null,0), (null,null,null,0), (null,null,null,0)