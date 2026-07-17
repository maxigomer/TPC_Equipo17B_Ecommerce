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
INSERT INTO COLECCIONES_MENU (Nombre,IdCriterio,Criterio,Estado) VALUES ('Televisores',1,1,1), ('Notebooks',2,1,1), ('Celulares',3,1,1), ('Monitores',4,1,1)

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
-- ----------------------------------------------------
-- 25 PRODUCTOS ADICIONALES (IdProducto 26 al 50)
-- Requiere ejecutar previamente los inserts anteriores en una base vacia.
-- ----------------------------------------------------

-- TELEVISORES (Categoria 1)
INSERT INTO PRODUCTOS (Sku, IdCategoria, IdMarca, Nombre, Descripcion, Precio, Costo, Stock, Estado) VALUES
('TV-LG-65-QNED', 1, 1, 'Smart TV LG 65" QNED', 'Televisor 4K QNED de 65 pulgadas con webOS, HDR y ThinQ AI.', 1680000, 1320000, 7, 1),
('TV-SAM-75-CU', 1, 2, 'Smart TV Samsung 75" Crystal UHD', 'Televisor Crystal UHD 4K de 75 pulgadas con Tizen y HDR.', 2050000, 1640000, 5, 1),
('TV-SON-55-X80', 1, 4, 'Smart TV Sony Bravia 55" X80L', 'Google TV 4K de 55 pulgadas con HDR y procesador 4K X1.', 1350000, 1060000, 9, 1),
('TV-HIS-58-A6', 1, 16, 'Smart TV Hisense 58" A6', 'Televisor UHD 4K de 58 pulgadas con VIDAA, Dolby Vision y HDR.', 870000, 680000, 13, 1);

-- NOTEBOOKS (Categoria 2)
INSERT INTO PRODUCTOS (Sku, IdCategoria, IdMarca, Nombre, Descripcion, Precio, Costo, Stock, Estado) VALUES
('NB-LEN-THK-E14', 2, 3, 'Lenovo ThinkPad E14', 'Notebook empresarial con Intel Core i5, 16GB RAM y SSD de 512GB.', 1280000, 990000, 10, 1),
('NB-DEL-INS-3520', 2, 5, 'Dell Inspiron 15 3520', 'Notebook de 15.6 pulgadas con Intel Core i5, 8GB RAM y SSD de 512GB.', 980000, 760000, 14, 1),
('NB-ASU-VIV-16', 2, 6, 'ASUS VivoBook 16', 'Notebook con Ryzen 7, pantalla de 16 pulgadas, 16GB RAM y SSD de 512GB.', 1220000, 950000, 11, 1),
('NB-ACE-SWI-14', 2, 7, 'Acer Swift Go 14', 'Ultrabook con Intel Core Ultra 5, pantalla OLED, 16GB RAM y SSD de 512GB.', 1490000, 1180000, 6, 1);

-- CELULARES (Categoria 3)
INSERT INTO PRODUCTOS (Sku, IdCategoria, IdMarca, Nombre, Descripcion, Precio, Costo, Stock, Estado) VALUES
('CEL-SAM-A55', 3, 2, 'Samsung Galaxy A55 5G', 'Smartphone con pantalla AMOLED de 6.6 pulgadas, 256GB y cámara de 50MP.', 720000, 555000, 24, 1),
('CEL-APP-IP15', 3, 10, 'Apple iPhone 15', 'Smartphone con pantalla Super Retina XDR de 6.1 pulgadas y 128GB.', 1580000, 1270000, 12, 1),
('CEL-XIA-RN13', 3, 9, 'Xiaomi Redmi Note 13 Pro', 'Smartphone 5G con pantalla AMOLED, 256GB y cámara de 200MP.', 680000, 520000, 22, 1),
('CEL-MOT-EDGE40', 3, 8, 'Motorola Edge 40 Neo', 'Smartphone 5G con pantalla pOLED de 144Hz, 256GB y 12GB RAM.', 610000, 465000, 18, 1);

-- MONITORES (Categoria 4)
INSERT INTO PRODUCTOS (Sku, IdCategoria, IdMarca, Nombre, Descripcion, Precio, Costo, Stock, Estado) VALUES
('MON-LG-34-UW', 4, 1, 'Monitor LG UltraWide 34"', 'Monitor IPS UltraWide de 34 pulgadas, resolución WQHD y compatibilidad HDR.', 690000, 530000, 12, 1),
('MON-SAM-G5-27', 4, 2, 'Monitor Samsung Odyssey G5 27"', 'Monitor gamer curvo QHD de 27 pulgadas con frecuencia de 165Hz.', 560000, 430000, 16, 1),
('MON-DEL-P2422H', 4, 5, 'Monitor Dell P2422H 24"', 'Monitor profesional IPS Full HD de 24 pulgadas con soporte ajustable.', 310000, 235000, 21, 1),
('MON-ASU-VG27', 4, 6, 'Monitor ASUS TUF Gaming VG27AQ', 'Monitor gamer IPS QHD de 27 pulgadas, 165Hz y 1ms.', 650000, 500000, 10, 1);

-- AURICULARES (Categoria 5)
INSERT INTO PRODUCTOS (Sku, IdCategoria, IdMarca, Nombre, Descripcion, Precio, Costo, Stock, Estado) VALUES
('AUR-SON-CH720', 5, 4, 'Sony WH-CH720N', 'Auriculares Bluetooth over-ear con cancelación activa de ruido.', 210000, 158000, 32, 1),
('AUR-JBL-770NC', 5, 11, 'JBL Tune 770NC', 'Auriculares inalámbricos con cancelación de ruido y hasta 70 horas de batería.', 175000, 128000, 38, 1),
('AUR-HYP-CLD3', 5, 14, 'HyperX Cloud III', 'Headset gamer con sonido DTS, micrófono desmontable y conexión USB.', 195000, 148000, 27, 1),
('AUR-APP-MAX', 5, 10, 'Apple AirPods Max', 'Auriculares over-ear con cancelación activa de ruido y audio espacial.', 980000, 790000, 8, 1);

-- PERIFERICOS (Categoria 6)
INSERT INTO PRODUCTOS (Sku, IdCategoria, IdMarca, Nombre, Descripcion, Precio, Costo, Stock, Estado) VALUES
('PER-LOG-GPRO', 6, 12, 'Mouse Logitech G Pro X Superlight 2', 'Mouse gamer inalámbrico ultraliviano con sensor HERO 2.', 185000, 140000, 23, 1),
('PER-RED-DRAC', 6, 13, 'Teclado Redragon Draconic K530', 'Teclado mecánico compacto 60 por ciento con Bluetooth y RGB.', 92000, 67000, 36, 1),
('PER-HYP-PULSE', 6, 14, 'Mouse HyperX Pulsefire Haste 2', 'Mouse gamer ultraliviano con sensor de 26000 DPI y conexión USB.', 98000, 72000, 31, 1),
('PER-LOG-C922', 6, 12, 'Webcam Logitech C922 Pro', 'Webcam Full HD para streaming con enfoque automático y micrófonos estéreo.', 125000, 93000, 20, 1),
('PER-RED-ZEUS', 6, 13, 'Gamepad Redragon Saturn G807', 'Control USB para PC con vibración, diseño ergonómico y doce botones.', 58000, 41000, 42, 1);
GO

-- IMAGENES PARA PRODUCTOS 26 AL 50
-- Se incluyen dos URLs por producto.
INSERT INTO IMAGENES (Url, IdProducto) VALUES
('https://images.unsplash.com/photo-1593784991095-a205069470b6', 26),
('https://images.unsplash.com/photo-1461151304267-38535e780c79', 26),
('https://images.unsplash.com/photo-1593359677879-a4bb92f829d1', 27),
('https://images.unsplash.com/photo-1571415060716-baff5f717c37', 27),
('https://images.unsplash.com/photo-1593784991095-a205069470b6', 28),
('https://images.unsplash.com/photo-1511884642898-4c92249e20b6', 28),
('https://images.unsplash.com/photo-1461151304267-38535e780c79', 29),
('https://images.unsplash.com/photo-1593359677879-a4bb92f829d1', 29),
('https://images.unsplash.com/photo-1496181133206-80ce9b88a853', 30),
('https://images.unsplash.com/photo-1517336714739-489689fd1ca8', 30),
('https://images.unsplash.com/photo-1593642632823-8f785ba67e45', 31),
('https://images.unsplash.com/photo-1588872657578-7efd1f1555ed', 31),
('https://images.unsplash.com/photo-1603302576837-37561b2e2302', 32),
('https://images.unsplash.com/photo-1496181133206-80ce9b88a853', 32),
('https://images.unsplash.com/photo-1517336714739-489689fd1ca8', 33),
('https://images.unsplash.com/photo-1593642632823-8f785ba67e45', 33),
('https://images.unsplash.com/photo-1610945265064-0e34e5519bbf', 34),
('https://images.unsplash.com/photo-1510557880182-3d4d3cba35a5', 34),
('https://images.unsplash.com/photo-1598327105666-5b89351cb315', 35),
('https://images.unsplash.com/photo-1580910051074-3eb694886505', 35),
('https://images.unsplash.com/photo-1511707171634-5f897ff02aa9', 36),
('https://images.unsplash.com/photo-1598327105666-5b89351cb315', 36),
('https://images.unsplash.com/photo-1580910051074-3eb694886505', 37),
('https://images.unsplash.com/photo-1610945265064-0e34e5519bbf', 37),
('https://images.unsplash.com/photo-1527443224154-c4a3942d3acf', 38),
('https://images.unsplash.com/photo-1542393545-10f5cde2c810', 38),
('https://images.unsplash.com/photo-1552831388-6a0b35077328', 39),
('https://images.unsplash.com/photo-1527443224154-c4a3942d3acf', 39),
('https://images.unsplash.com/photo-1542393545-10f5cde2c810', 40),
('https://images.unsplash.com/photo-1552831388-6a0b35077328', 40),
('https://images.unsplash.com/photo-1527443224154-c4a3942d3acf', 41),
('https://images.unsplash.com/photo-1542393545-10f5cde2c810', 41),
('https://images.unsplash.com/photo-1618366712010-f4ae9c647dcb', 42),
('https://images.unsplash.com/photo-1505740420928-5e560c06d30e', 42),
('https://images.unsplash.com/photo-1606220588913-b3eea4141126', 43),
('https://images.unsplash.com/photo-1618366712010-f4ae9c647dcb', 43),
('https://images.unsplash.com/photo-1590658268037-6bf12165a8df', 44),
('https://images.unsplash.com/photo-1505740420928-5e560c06d30e', 44),
('https://images.unsplash.com/photo-1606220588913-b3eea4141126', 45),
('https://images.unsplash.com/photo-1590658268037-6bf12165a8df', 45),
('https://images.unsplash.com/photo-1527814050087-379381547913', 46),
('https://images.unsplash.com/photo-1586816879360-004f5b0c51e3', 46),
('https://images.unsplash.com/photo-1595225476474-87563907a212', 47),
('https://images.unsplash.com/photo-1555680202-c86f0e12f086', 47),
('https://images.unsplash.com/photo-1527814050087-379381547913', 48),
('https://images.unsplash.com/photo-1586816879360-004f5b0c51e3', 48),
('https://images.unsplash.com/photo-1587829741301-dc798b83add3', 49),
('https://images.unsplash.com/photo-1595225476474-87563907a212', 49),
('https://images.unsplash.com/photo-1600086827875-a63b01f1335c', 50),
('https://images.unsplash.com/photo-1592840496694-26d035b52b48', 50);
GO

-- ----------------------------------------------------
-- CUENTAS, DIRECCIONES Y COMPRAS ADICIONALES
-- Se ejecuta despues de toda la carga anterior.
-- ----------------------------------------------------

-- 4 cuentas nuevas con rol Cliente (IdRol 2)
INSERT INTO USUARIOS (Usuario, Clave, IdRol) VALUES
('jperez', '1234', 2),
('lfernandez', '1234', 2),
('msosa', '1234', 2),
('aguirre', '1234', 2);
GO

-- Clientes asociados a los usuarios 4 al 7
INSERT INTO CLIENTES (Nombre, Apellido, Dni, Email, Telefono, IdUsuario) VALUES
('Juan', 'Perez', '35111222', 'juan.perez@email.com', '1160012233', 4),
('Lucia', 'Fernandez', '36777888', 'lucia.fernandez@email.com', '1144556677', 5),
('Martin', 'Sosa', '38999111', 'martin.sosa@email.com', '1133445566', 6),
('Ana', 'Aguirre', '40222555', 'ana.aguirre@email.com', '1177889900', 7);
GO

-- Direcciones adicionales. Los Id esperados son 3 al 7.
INSERT INTO DIRECCIONES (IdCliente, Calle, Numero, Localidad, CodigoPostal, Observaciones) VALUES
(4, 'Av. Rivadavia', 3250, 'CABA', 'C1203', 'Piso 7, departamento A'),
(5, 'Calle 12', 1456, 'La Plata', 'B1900', 'Casa con porton negro'),
(6, 'Av. Maipu', 2210, 'Olivos', 'B1636', NULL),
(7, 'Italia', 785, 'Rosario', 'S2000', 'Entregar por la tarde'),
(4, 'Av. Cabildo', 1850, 'CABA', 'C1428', 'Direccion laboral');
GO

-- PEDIDOS ADICIONALES
-- Los totales coinciden con la suma de sus ITEM_PEDIDOS.
-- IdPedido esperados: 3 al 8.
INSERT INTO PEDIDOS
(IdCliente, IdDireccion, IdMetodoDePago, Fecha, Precio, IdFormaDeEntrega, IdEstado)
VALUES
(4, 3, 1, '2026-06-18T10:30:00', 1270000.00, 1, 3),
(5, 4, 2, '2026-06-24T15:45:00', 1735000.00, 1, 3),
(6, 5, 1, '2026-07-02T09:10:00', 755000.00, 1, 2),
(7, 6, 2, '2026-07-08T18:20:00', 1580000.00, 1, 1),
(4, 7, 1, '2026-07-12T12:05:00', 462000.00, 2, 2),
(5, 4, 1, '2026-07-15T16:40:00', 2420000.00, 1, 1);
GO

-- DETALLE DE LOS PEDIDOS
-- El precio guardado corresponde al precio unitario al momento de la compra.
INSERT INTO ITEM_PEDIDOS (IdPedido, IdProducto, Cantidad, Precio) VALUES
-- Pedido 3: Juan = Samsung Galaxy A55 + Sony WH-CH720N + mouse HyperX
(3, 34, 1, 720000.00),
(3, 42, 1, 210000.00),
(3, 48, 2, 170000.00),

-- Pedido 4: Lucia = MacBook Air M2 + JBL Tune 770NC
(4, 11, 1, 1500000.00),
(4, 43, 1, 175000.00),
(4, 47, 1, 60000.00),

-- Pedido 5: Martin = Monitor Dell + teclado Redragon + webcam Logitech
(5, 40, 1, 310000.00),
(5, 47, 2, 92000.00),
(5, 49, 1, 125000.00),
(5, 23, 2, 68000.00),

-- Pedido 6: Ana = iPhone 15
(6, 35, 1, 1580000.00),

-- Pedido 7: Juan = auriculares, mouse y teclado
(7, 19, 1, 65000.00),
(7, 22, 1, 75000.00),
(7, 24, 2, 110000.00),
(7, 25, 1, 102000.00),

-- Pedido 8: Lucia = Smart TV LG QNED + AirPods Max
(8, 26, 1, 1680000.00),
(8, 45, 1, 740000.00);
GO

-- Observaciones para algunos pedidos
INSERT INTO OBSERVACIONES_PEDIDOS (IdPedido, Observacion) VALUES
(3, 'Entregar despues de las 14:00.'),
(5, 'El cliente solicito factura A.'),
(6, 'Pedido pendiente de acreditacion de la transferencia.'),
(8, 'Coordinar la entrega por telefono antes de salir.');
GO

-- CARRITOS DE EJEMPLO AUN NO CONVERTIDOS EN PEDIDO
-- IdCarrito esperados: 1 y 2.
INSERT INTO CARRITOS (Fecha, Precio, IdCliente) VALUES
('2026-07-16T11:25:00', 745000.00, 6),
('2026-07-17T09:50:00', 360000.00, 7);
GO

INSERT INTO ITEM_CARRITOS (IdCarrito, IdProducto, Cantidad, Precio) VALUES
-- Carrito de Martin
(1, 37, 1, 610000.00),
(1, 21, 1, 120000.00),
(1, 23, 1, 15000.00),
-- Carrito de Ana
(2, 18, 1, 350000.00),
(2, 50, 1, 10000.00);
GO
