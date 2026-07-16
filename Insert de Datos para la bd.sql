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
INSERT INTO ESTADOS_DE_PEDIDO (Estado) VALUES ('Pendiente'), ('Enviado'), ('Entregado'), ('Cancelado');
GO

-- 6. Finalmente, creamos los 3 Pedidos
-- Estructura: IdCliente, IdDireccion, IdMetodoDePago, Fecha, Precio, IdFormaDeEntrega, IdEstado
INSERT INTO PEDIDOS (IdCliente, IdDireccion, IdMetodoDePago, Fecha, Precio, IdFormaDeEntrega, IdEstado) VALUES 
(2, 1, 1, GETDATE(), 8990.00, 1, 2),  -- María, Envío, Enviado, Tarjeta de Crédito
(3, 2, 2, '2026-06-10', 45000.00, 2, 3); -- Carlos, Retiro, Entregado, Transferencia
GO

-- Agrego colecciones vacias
INSERT INTO COLECCIONES_MENU (Nombre,IdCriterio,Criterio,Estado) VALUES (null,null,null,0), (null,null,null,0), (null,null,null,0), (null,null,null,0)

INSERT INTO BANNERS(Url) VALUES('')
GO

-- ----------------------------------------------------
-- CARGA ADICIONAL DE DATOS DE MUESTRA
-- ----------------------------------------------------

-- MÁS CELULARES (Categoria 3)
INSERT INTO PRODUCTOS (Sku, IdCategoria, IdMarca, Nombre, Descripcion, Precio, Costo, Stock, Estado) VALUES 
('CEL-SAM-S23', 3, 2, 'Samsung Galaxy S23 Ultra', 'Pantalla 6.8" Dynamic AMOLED, 256GB, Cámara 200MP.', 1200000, 950000, 15, 1),
('CEL-APP-IP14', 3, 10, 'Apple iPhone 14 Pro', 'Pantalla 6.1" Super Retina, 128GB, Chip A16 Bionic.', 1400000, 1100000, 10, 1),
('CEL-XIA-13T', 3, 9, 'Xiaomi 13T', 'Pantalla 6.67" AMOLED 144Hz, 256GB, Leica Camera.', 850000, 680000, 20, 1),
('CEL-MOT-E40', 3, 8, 'Motorola Moto G84', 'Pantalla 6.5" pOLED, 256GB, Batería 5000mAh.', 450000, 350000, 25, 1);

-- MÁS NOTEBOOKS (Categoria 2)
INSERT INTO PRODUCTOS (Sku, IdCategoria, IdMarca, Nombre, Descripcion, Precio, Costo, Stock, Estado) VALUES 
('NB-APP-M2', 2, 10, 'MacBook Air M2', 'Pantalla 13.6" Liquid Retina, 256GB SSD, 8GB RAM.', 1500000, 1200000, 8, 1),
('NB-DEL-XPS', 2, 5, 'Dell XPS 13', 'Intel Core i7 12va, 512GB SSD, 16GB RAM, Windows 11.', 1350000, 1050000, 5, 1),
('NB-ASU-ROG', 2, 6, 'ASUS ROG Zephyrus G14', 'AMD Ryzen 9, RTX 4060, 1TB SSD, 16GB RAM. Gamer.', 1800000, 1450000, 12, 1),
('NB-ACE-NIT', 2, 7, 'Acer Nitro 5', 'Intel Core i5 11va, GTX 1650, 256GB SSD, 8GB RAM.', 890000, 710000, 15, 1);

-- MÁS MONITORES (Categoria 4)
INSERT INTO PRODUCTOS (Sku, IdCategoria, IdMarca, Nombre, Descripcion, Precio, Costo, Stock, Estado) VALUES 
('MON-LG-27', 4, 1, 'Monitor LG 27" IPS', 'Monitor LG Full HD IPS 75Hz, FreeSync.', 250000, 190000, 30, 1),
('MON-SAM-32', 4, 2, 'Monitor Curvo Samsung 32"', 'Monitor Curvo 1500R, Full HD, 75Hz.', 320000, 240000, 20, 1),
('MON-ASU-24', 4, 6, 'Monitor Gamer ASUS TUF 24"', '144Hz, 1ms, Full HD IPS, G-Sync compatible.', 380000, 290000, 15, 1);

-- MÁS AURICULARES (Categoria 5)
INSERT INTO PRODUCTOS (Sku, IdCategoria, IdMarca, Nombre, Descripcion, Precio, Costo, Stock, Estado) VALUES 
('AUR-SON-1000', 5, 4, 'Auriculares Sony WH-1000XM4', 'Cancelación de ruido activa, Inalámbricos Bluetooth.', 350000, 280000, 40, 1),
('AUR-JBL-510', 5, 11, 'Auriculares JBL Tune 510BT', 'Inalámbricos On-Ear, batería de 40 horas.', 65000, 45000, 50, 1),
('AUR-APP-APD', 5, 10, 'Apple AirPods Pro 2', 'Auriculares In-Ear con cancelación de ruido.', 280000, 220000, 25, 1),
('AUR-HYP-CLD', 5, 14, 'HyperX Cloud II', 'Auriculares Gamer con sonido envolvente 7.1.', 120000, 95000, 35, 1);

-- MÁS PERIFERICOS (Categoria 6)
INSERT INTO PRODUCTOS (Sku, IdCategoria, IdMarca, Nombre, Descripcion, Precio, Costo, Stock, Estado) VALUES 
('PER-LOG-G502', 6, 12, 'Mouse Logitech G502 Hero', 'Sensor óptico 25K, pesas ajustables, RGB.', 75000, 55000, 45, 1),
('PER-RED-K552', 6, 13, 'Teclado Redragon Kumara K552', 'Teclado mecánico TKL, switches Outemu Red, RGB.', 65000, 45000, 60, 1),
('PER-LOG-MX3', 6, 12, 'Mouse Logitech MX Master 3S', 'Ergonómico, sensor láser, inalámbrico para productividad.', 110000, 85000, 20, 1),
('PER-HYP-ALL', 6, 14, 'Teclado HyperX Alloy Origins', 'Teclado mecánico completo, switches HyperX Red.', 105000, 80000, 25, 1);

-- AGREGAMOS IMÁGENES GENÉRICAS PARA LOS NUEVOS PRODUCTOS (Id 7 al 25)
INSERT INTO IMAGENES (Url, IdProducto) VALUES 
('https://images.unsplash.com/photo-1610945265064-0e34e5519bbf', 7),
('https://images.unsplash.com/photo-1510557880182-3d4d3cba35a5', 8),
('https://images.unsplash.com/photo-1598327105666-5b89351cb315', 9),
('https://images.unsplash.com/photo-1580910051074-3eb694886505', 10),
('https://images.unsplash.com/photo-1517336714739-489689fd1ca8', 11),
('https://images.unsplash.com/photo-1593642632823-8f785ba67e45', 12),
('https://images.unsplash.com/photo-1603302576837-37561b2e2302', 13),
('https://images.unsplash.com/photo-1588872657578-7efd1f1555ed', 14),
('https://images.unsplash.com/photo-1527443224154-c4a3942d3acf', 15),
('https://images.unsplash.com/photo-1542393545-10f5cde2c810', 16),
('https://images.unsplash.com/photo-1552831388-6a0b35077328', 17),
('https://images.unsplash.com/photo-1618366712010-f4ae9c647dcb', 18),
('https://images.unsplash.com/photo-1505740420928-5e560c06d30e', 19),
('https://images.unsplash.com/photo-1606220588913-b3eea4141126', 20),
('https://images.unsplash.com/photo-1590658268037-6bf12165a8df', 21),
('https://images.unsplash.com/photo-1527814050087-379381547913', 22),
('https://images.unsplash.com/photo-1595225476474-87563907a212', 23),
('https://images.unsplash.com/photo-1586816879360-004f5b0c51e3', 24),
('https://images.unsplash.com/photo-1555680202-c86f0e12f086', 25);
GO