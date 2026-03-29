drop database Cbras_db;
CREATE DATABASE IF NOT EXISTS Cbras_db;
use Cbras_db;

CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    estado VARCHAR(20) DEFAULT 'Activo',
    rol VARCHAR(20) DEFAULT 'CLIENTE'
);

CREATE TABLE direcciones (
    id_direccion INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT,
    calle VARCHAR(255) NOT NULL,
    ciudad VARCHAR(100) NOT NULL,
    estado VARCHAR(100) NOT NULL,
    codigo_postal VARCHAR(10) NOT NULL,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id_usuario) ON DELETE CASCADE
);

CREATE TABLE productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10, 2) NOT NULL,
    stock INT DEFAULT 0,
    url_imagen VARCHAR(255)
);

CREATE TABLE carrito (
    id_carrito INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    id_producto INT,
    cantidad INT DEFAULT 1,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto) ON DELETE CASCADE
);

CREATE TABLE pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    numPedido VARCHAR(20) UNIQUE,
    id_usuario INT,
    id_direccion INT,
    fecha_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(10, 2) DEFAULT 0.00,
    estado VARCHAR(50) DEFAULT 'Pendiente',
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_direccion) REFERENCES direcciones(id_direccion)
);

CREATE TABLE detalles_pedidos (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT,
    id_producto INT,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido) ON DELETE CASCADE,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

CREATE TABLE resenas (
    id_resena INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT,
    id_usuario INT,
    calificacion INT CHECK (calificacion BETWEEN 1 AND 5),
    comentario TEXT,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto) ON DELETE CASCADE,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE
);

DELIMITER //
CREATE TRIGGER tg_actualizar_total_automatico
AFTER INSERT ON detalles_pedidos
FOR EACH ROW
BEGIN
    UPDATE pedidos 
    SET total = (SELECT SUM(cantidad * precio_unitario) 
                 FROM detalles_pedidos 
                 WHERE id_pedido = NEW.id_pedido)
    WHERE id_pedido = NEW.id_pedido;
END //
DELIMITER ;

INSERT INTO usuarios (nombre, correo, password, rol, estado) VALUES 
('Administrador', 'admin@cbras.com', 'ITSON', 'ADMIN', 'Activo'), 
('Alberto Jimenez', 'alberto.jimenez@gmail.com', '123456', 'CLIENTE', 'Activo');

INSERT INTO direcciones (usuario_id, calle, ciudad, estado, codigo_postal) VALUES 
(2, 'Calle Ejemplo #123, Col. Centro', 'Ciudad Obregón', 'Sonora', '85000'),
(2, 'Av. Tecnológico #500 (ITSON)', 'Ciudad Obregón', 'Sonora', '85100');

INSERT INTO productos (nombre, descripcion, precio, stock, url_imagen) VALUES 
('Chaqueta Clásica de Cuero', 'Cuero sintético negro, forro térmico.', 899.50, 15, 'https://th.bing.com/th/id/OIP.A3y6d-h00K0j1PIfA6yZsgHaIq?rs=1&pid=ImgDetMain'),
('Playera Básica Blanca', '100% algodón, cuello redondo.', 149.90, 50, 'https://th.bing.com/th/id/OIP.mU5wzJdG0k2A-44zV33qKgHaHa?rs=1&pid=ImgDetMain'),
('Jeans Slim Fit Azul', 'Mezclilla elástica, corte moderno.', 549.00, 30, 'https://th.bing.com/th/id/OIP.iW5QYn_K3i_hZ-k3N1lq0gHaJ4?rs=1&pid=ImgDetMain'),
('Sudadera con Capucha Gris', 'Felpa suave con bolsillo canguro.', 399.00, 20, 'https://th.bing.com/th/id/OIP.x_aU8Kx2w0E_u8Fw05Z_cwHaHa?rs=1&pid=ImgDetMain'),
('Tenis Deportivos Blancos', 'Suela antideslizante, ligeros.', 749.99, 12, 'https://th.bing.com/th/id/OIP.6Z2PZ2Vz587y968wX2Z08AHaHa?rs=1&pid=ImgDetMain');

INSERT INTO pedidos (id_pedido, id_usuario, id_direccion, total, estado) VALUES 
(1, 2, 1, 0, 'Pendiente'),
(2, 2, 2, 0, 'Enviado');

INSERT INTO detalles_pedidos (id_pedido, id_producto, cantidad, precio_unitario) VALUES 
(1, 1, 1, 899.50),
(1, 2, 2, 149.90);

INSERT INTO detalles_pedidos (id_pedido, id_producto, cantidad, precio_unitario) VALUES 
(2, 3, 1, 549.00),
(2, 4, 1, 399.00);

INSERT INTO resenas (id_producto, id_usuario, calificacion, comentario) VALUES 
(1, 2, 5, 'Excelente calidad, me quedó perfecta.'),
(2, 2, 4, 'Muy cómoda, pero un poco transparente.');

INSERT INTO carrito (id_usuario, id_producto, cantidad) VALUES 
(2, 5, 1);