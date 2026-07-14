USE ECOMMERCE_DB
GO

-- MARCAS
INSERT INTO MARCAS (Nombre) VALUES
('LG'),
('Samsung'),
('Lenovo'),
('Sony'),
('Dell'),
('ASUS'),
('Acer'),
('Motorola'),
('Xiaomi'),
('Apple'),
('JBL'),
('Logitech'),
('Redragon'),
('HyperX'),
('TCL'),
('Hisense');

-- CATEGORIAS
INSERT INTO CATEGORIAS (Nombre) VALUES
('Televisores'),
('Notebooks'),
('Celulares'),
('Monitores'),
('Auriculares'),
('Perifericos');
GO


-- PRODUCTOS
EXEC spAltaProducto 'TV-SAM-001', 1, 2, 'Smart TV Samsung 50"', 'Televisor 4K UHD con sistema Tizen y bordes ultra finos.', 500000.00, 400000.00, 10, 1;

INSERT INTO PRODUCTOS
(
Sku,
IdCategoria,
IdMarca,
Nombre,
Descripcion,
Precio,
Costo,
Stock,
Estado
)
VALUES
(
'TV-LG-55-001',
1,
1,
'Smart TV LG 55" UHD AI ThinQ',
'Smart TV LG 55 pulgadas UHD 4K con WebOS y HDR10.',
729999,
565000,
18,
1
);

INSERT INTO PRODUCTOS
VALUES
(
'TV-SONY-65-001',
1,
4,
'Smart TV Sony Bravia 65"',
'Televisor Sony Bravia Google TV 65 pulgadas 4K.',
1399999,
1090000,
8,
1
);

INSERT INTO PRODUCTOS
VALUES
(
'TV-TCL-50-001',
1,
15,
'Smart TV TCL 50"',
'Televisor TCL Android TV 50 pulgadas UHD.',
619999,
470000,
16,
1
);

INSERT INTO PRODUCTOS
VALUES
(
'TV-HIS-43-001',
1,
16,
'Smart TV Hisense 43"',
'Smart TV Hisense UHD con sistema VIDAA.',
489999,
370000,
25,
1
);

INSERT INTO PRODUCTOS
VALUES
(
'NB-LEN-001',
2,
3,
'Notebook Lenovo IdeaPad 15',
'Ryzen 5 7530U, 16GB RAM, SSD 512GB.',
999999,
780000,
14,
1
);

GO
-- IMAGENES DE PRODUCTOS
EXEC spAltaImagen 'https://tse1.mm.bing.net/th/id/OIP.fKqqpnyRVm9NSxMFOs8KLwHaHa?r=0&cb=thfvnextfalcon2&rs=1&pid=ImgDetMain&o=7&rm=3', 1;
EXEC spAltaImagen 'https://a-static.mlcdn.com.br/1500x1500/smart-tv-50-crystal-4k-samsung-50au7700-wi-fi-bluetooth-hdr-alexa-built-in-3-hdmi-1-usb/magazineluiza/193441200/15a3134ca277772436f19af65d9960ec.jpg', 1;

INSERT INTO IMAGENES (Url,IdProducto) VALUES
('https://images.unsplash.com/photo-1593784991095-a205069470b6',2),
('https://images.unsplash.com/photo-1461151304267-38535e780c79',2);

INSERT INTO IMAGENES (Url,IdProducto) VALUES
('https://images.unsplash.com/photo-1571415060716-baff5f717c37',3),
('https://images.unsplash.com/photo-1593359677879-a4bb92f829d1',3);

INSERT INTO IMAGENES (Url,IdProducto) VALUES
('https://images.unsplash.com/photo-1511884642898-4c92249e20b6',4),
('https://images.unsplash.com/photo-1593784991095-a205069470b6',4);

INSERT INTO IMAGENES (Url,IdProducto) VALUES
('https://images.unsplash.com/photo-1461151304267-38535e780c79',5),
('https://images.unsplash.com/photo-1593784991095-a205069470b6',5);

INSERT INTO IMAGENES (Url,IdProducto) VALUES
('https://images.unsplash.com/photo-1496181133206-80ce9b88a853',6),
('https://images.unsplash.com/photo-1517336714739-489689fd1ca8',6);


USE ECOMMERCE_DB;
GO

-- 1. Creamos Roles básicos
INSERT INTO ROLES (Rol) VALUES ('Admin'), ('Cliente');
GO

-- 2. Creamos 3 Usuarios para nuestros clientes (Se asignan al IdRol 2 = Cliente)
INSERT INTO USUARIOS (Usuario, Clave, IdRol) VALUES 
('admin', 'admin', 1),
('mgomez', '1234', 2),
('clopez', '1234', 2);
GO

-- 3. Creamos 3 Clientes vinculados a los usuarios recién creados
INSERT INTO CLIENTES (Nombre, Apellido, Dni, Email, Telefono, IdUsuario) VALUES 
('Admin', 'Admin', '40111222', 'admin@email.com', '1122334455', 1),
('María', 'Gómez', '31222333', 'maria.gomez@email.com', '1199887766', 2),
('Carlos', 'López', '32333444', 'carlos.lopez@email.com', '1155443322', 3);
GO

-- 4. Creamos Direcciones para esos clientes
INSERT INTO DIRECCIONES (IdCliente, Calle, Numero, Localidad, CodigoPostal, Observaciones) VALUES 
(2, 'Calle Falsa', 456, 'CABA', 'C1001', 'Depto 4B'),
(3, 'Av. San Martín', 890, 'Tigre', 'B1648', 'Local a la calle');
GO

-- 5. Llenamos las tablas paramétricas que necesita un Pedido
INSERT INTO METODOS_DE_PAGO (Nombre) VALUES ('Tarjeta de Crédito'), ('Transferencia Bancaria');
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

INSERT INTO BANNERS(Url) VALUES('')