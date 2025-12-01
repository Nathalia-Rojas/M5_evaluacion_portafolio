CREATE DATABASE Libreria_Online;
USE Libreria_Online;

-- Crear tabla de Autores (Entidad fuerte)
CREATE TABLE Autores (
    id_autor INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    nacionalidad VARCHAR(50)
);

-- Crear tabla de Libros (Entidad relacionada)
CREATE TABLE Libros (
    id_libro INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(150) NOT NULL,
    precio DECIMAL(10, 2) CHECK (precio > 0),
    stock INT DEFAULT 0,
    id_autor INT,
    -- Definición de Clave Foránea (Foreign Key)
    FOREIGN KEY (id_autor) REFERENCES Autores(id_autor)
);

-- Crear tabla de Clientes
CREATE TABLE Clientes (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(100) UNIQUE NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    direccion VARCHAR(200)
);

INSERT INTO Autores (nombre, nacionalidad) VALUES ('Gabriel García Márquez', 'Colombiana');

INSERT INTO Libros (titulo, precio, stock, id_autor) 
VALUES ('Cien Años de Soledad', 15990, 50, 1);

--UPDATE (Modificar datos): Escenario: Actualizar el precio de un libro.
UPDATE Libros 
SET precio = 17990 
WHERE titulo = 'Cien Años de Soledad';


--DELETE (Eliminar datos): Escenario: Un cliente solicitó borrar su cuenta.
DELETE FROM Clientes WHERE email = 'usuario_inactivo@email.com';


-- Consulta Básica (SELECT + WHERE): Obtener libros con stock bajo.

SELECT titulo, stock 
FROM Libros 
WHERE stock < 5;

-- Consulta Relacional (JOIN): Obtener lista de libros junto con el nombre de su autor (cruzar dos tablas).
SELECT Libros.titulo, Autores.nombre AS autor, Libros.precio
FROM Libros
INNER JOIN Autores ON Libros.id_autor = Autores.id_autor;

-- Consulta de Agregación (GROUP BY): Contar cuántos libros tiene cada autor en el sistema.
SELECT Autores.nombre, COUNT(Libros.id_libro) as cantidad_libros
FROM Autores
LEFT JOIN Libros ON Autores.id_autor = Libros.id_autor
GROUP BY Autores.nombre;