DROP DATABASE IF EXISTS practica_con_relacion;
CREATE DATABASE practica_con_relacion CHARACTER SET utf8mb4;
USE practica_con_relacion;

CREATE TABLE carreras (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  duracion_semestres INT NOT NULL,
  modalidad VARCHAR(30) NOT NULL
);

CREATE TABLE profesores (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  apellidos VARCHAR(100) NOT NULL,
  correo VARCHAR(100) NOT NULL,
  telefono VARCHAR(15),
  especialidad VARCHAR(100)
);

CREATE TABLE materias (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  creditos INT NOT NULL,
  semestre INT NOT NULL,
  profesor_id INT NOT NULL,
  FOREIGN KEY (profesor_id) REFERENCES profesores(id)
);

CREATE TABLE estudiantes (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  apellidos VARCHAR(100) NOT NULL,
  fecha_nacimiento DATE NOT NULL,
  telefono VARCHAR(15),
  correo VARCHAR(100) NOT NULL,
  ciudad VARCHAR(80),
  carrera_id INT NOT NULL,
  FOREIGN KEY (carrera_id) REFERENCES carreras(id)
);

CREATE TABLE inscripciones (
  id INT AUTO_INCREMENT PRIMARY KEY,
  estudiante_id INT NOT NULL,
  materia_id INT NOT NULL,
  periodo VARCHAR(10) NOT NULL,
  calificacion DECIMAL(4,1),
  FOREIGN KEY (estudiante_id) REFERENCES estudiantes(id),
  FOREIGN KEY (materia_id) REFERENCES materias(id)
);

INSERT INTO carreras (nombre, duracion_semestres, modalidad) VALUES
('Ingeniería en Sistemas Computacionales', 9, 'Escolarizada'),
('Ingeniería Industrial', 9, 'Escolarizada'),
('Ingeniería Civil', 9, 'Escolarizada'),
('Arquitectura', 10, 'Escolarizada'),
('Medicina', 12, 'Escolarizada'),
('Enfermería', 8, 'Escolarizada'),
('Derecho', 9, 'Mixta'),
('Contaduría Pública', 8, 'Mixta'),
('Administración de Empresas', 8, 'Mixta'),
('Psicología', 9, 'Escolarizada'),
('Diseño Gráfico', 8, 'Escolarizada'),
('Ingeniería Electrónica', 9, 'Escolarizada'),
('Biología', 8, 'Escolarizada'),
('Gastronomía', 8, 'Escolarizada'),
('Ciencias de la Comunicación', 8, 'Mixta');

INSERT INTO profesores (nombre, apellidos, correo, telefono, especialidad) VALUES
('Roberto', 'Gómez Cruz', 'roberto.gomez@uni.edu.mx', '9531200001', 'Desarrollo Web'),
('Laura', 'Santos Vega', 'laura.santos@uni.edu.mx', '9531200002', 'Bases de Datos'),
('Miguel', 'Herrera Paz', 'miguel.herrera@uni.edu.mx', '9531200003', 'Redes'),
('Patricia', 'Núñez Ortiz', 'patricia.nunez@uni.edu.mx', '9531200004', 'Matemáticas'),
('Fernando', 'Castillo Rojas', 'fernando.castillo@uni.edu.mx', '9531200005', 'Física'),
('Gabriela', 'Morales León', 'gabriela.morales@uni.edu.mx', '9531200006', 'Programación'),
('Héctor', 'Jiménez Salinas', 'hector.jimenez@uni.edu.mx', '9531200007', 'Derecho Civil'),
('Silvia', 'Ramírez Aguilar', 'silvia.ramirez@uni.edu.mx', '9531200008', 'Contabilidad'),
('Andrés', 'Torres Mejía', 'andres.torres@uni.edu.mx', '9531200009', 'Anatomía'),
('Claudia', 'Domínguez Ríos', 'claudia.dominguez@uni.edu.mx', '9531200010', 'Psicología Clínica'),
('Ricardo', 'Flores Medina', 'ricardo.flores@uni.edu.mx', '9531200011', 'Estructuras'),
('Mariana', 'Cortés Bravo', 'mariana.cortes@uni.edu.mx', '9531200012', 'Diseño Digital'),
('Oscar', 'Pacheco Luna', 'oscar.pacheco@uni.edu.mx', '9531200013', 'Electrónica'),
('Elena', 'Vázquez Soto', 'elena.vazquez@uni.edu.mx', '9531200014', 'Biología Molecular'),
('Daniel', 'Rivera Campos', 'daniel.rivera@uni.edu.mx', '9531200015', 'Comunicación');

INSERT INTO materias (nombre, creditos, semestre, profesor_id) VALUES
('Programación Web', 8, 5, 1),
('Base de Datos', 8, 4, 2),
('Redes de Computadoras', 7, 6, 3),
('Cálculo Diferencial', 6, 1, 4),
('Física General', 6, 2, 5),
('Estructura de Datos', 7, 3, 1),
('Derecho Civil', 6, 3, 7),
('Contabilidad Financiera', 6, 2, 8),
('Anatomía Humana', 10, 1, 9),
('Psicología del Desarrollo', 6, 2, 10),
('Análisis Estructural', 8, 5, 4),
('Diseño Editorial', 6, 3, 12),
('Circuitos Eléctricos', 8, 4, 13),
('Biología Celular', 7, 2, 9),
('Teoría de la Comunicación', 6, 1, 15);

INSERT INTO estudiantes (nombre, apellidos, fecha_nacimiento, telefono, correo, ciudad, carrera_id) VALUES
('Ana', 'López Martínez', '2004-03-15', '9531010001', 'ana.lopez@mail.com', 'Huajuapan de León', 1),
('Luis', 'Pérez García', '2003-07-22', '9531010002', 'luis.perez@mail.com', 'Tlaxiaco', 1),
('Marta', 'Ruiz Sánchez', '2004-11-02', '9531010003', 'marta.ruiz@mail.com', 'Oaxaca de Juárez', 5),
('Carlos', 'Hernández Cruz', '2002-01-30', '9531010004', 'carlos.hernandez@mail.com', 'Huajuapan de León', 2),
('Sofía', 'Ramírez Torres', '2005-05-18', '9531010005', 'sofia.ramirez@mail.com', 'Tehuacán', 7),
('Diego', 'Martínez Ríos', '2003-09-09', '9531010006', 'diego.martinez@mail.com', 'Huajuapan de León', 3),
('Valeria', 'Gómez Luna', '2004-12-25', '9531010007', 'valeria.gomez@mail.com', 'Puebla', 10),
('Jorge', 'Sánchez Mora', '2002-06-14', '9531010008', 'jorge.sanchez@mail.com', 'Oaxaca de Juárez', 4),
('Daniela', 'Flores Vega', '2004-02-08', '9531010009', 'daniela.flores@mail.com', 'Huajuapan de León', 6),
('Emilio', 'Castro Ponce', '2003-10-27', '9531010010', 'emilio.castro@mail.com', 'Silacayoapan', 8),
('Fernanda', 'Ortiz Reyes', '2005-04-03', '9531010011', 'fernanda.ortiz@mail.com', 'Huajuapan de León', 11),
('Ricardo', 'Mendoza Paz', '2002-08-19', '9531010012', 'ricardo.mendoza@mail.com', 'Juxtlahuaca', 12),
('Karla', 'Vargas Díaz', '2004-01-11', '9531010013', 'karla.vargas@mail.com', 'Huajuapan de León', 15),
('Pablo', 'Navarro Silva', '2003-03-29', '9531010014', 'pablo.navarro@mail.com', 'Tezoatlán', 9),
('Lucía', 'Aguilar Peña', '2004-07-06', '9531010015', 'lucia.aguilar@mail.com', 'Huajuapan de León', 14);

INSERT INTO inscripciones (estudiante_id, materia_id, periodo, calificacion) VALUES
(1, 1, '2026-A', 9.5),
(1, 2, '2026-A', 8.8),
(2, 2, '2026-A', 9.0),
(2, 6, '2026-A', 8.0),
(3, 9, '2026-A', 9.7),
(4, 4, '2026-A', 7.5),
(5, 7, '2026-A', 8.9),
(6, 11, '2026-A', 8.2),
(7, 10, '2026-A', 9.1),
(8, 5, '2026-A', 7.8),
(9, 14, '2026-A', 9.3),
(10, 8, '2026-A', 8.4),
(11, 12, '2026-A', 9.0),
(12, 13, '2026-A', 8.6),
(13, 15, '2026-A', 9.4);
