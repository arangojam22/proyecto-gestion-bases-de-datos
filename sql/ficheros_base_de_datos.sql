-- ================================================================
-- LIGA COLOMBIANA DE FUTBOL
-- Fichero unificado para entrega
-- Generado: 2026-05-20
-- Orden: estructura + datos -> procedimientos -> triggers
-- ================================================================

CREATE DATABASE IF NOT EXISTS liga_de_colombiana
DEFAULT CHARACTER SET utf8mb4
DEFAULT COLLATE utf8mb4_general_ci;

USE liga_de_colombiana;

CREATE TABLE COMPETICION (
id_competicion INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
categoria ENUM('Primera A','Primera B') NOT NULL,
tipo ENUM('liga','copa') NOT NULL
);

CREATE TABLE EQUIPO (
id_equipo INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
ciudad VARCHAR(100) NOT NULL
);

CREATE TABLE JUGADOR (
id_jugador INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
id_equipo INT NOT NULL,
posicion VARCHAR(30),
FOREIGN KEY (id_equipo) REFERENCES EQUIPO(id_equipo)
);

CREATE TABLE TEMPORADA (
id_temporada INT AUTO_INCREMENT PRIMARY KEY,
anio INT NOT NULL,
id_competicion INT NOT NULL,
FOREIGN KEY (id_competicion) REFERENCES COMPETICION(id_competicion)
);

CREATE TABLE TORNEO (
id_torneo INT AUTO_INCREMENT PRIMARY KEY,
id_temporada INT NOT NULL,
nombre ENUM('Apertura','Finalización') NOT NULL,
estado ENUM('en_juego','finalizado') DEFAULT 'en_juego',
FOREIGN KEY (id_temporada) REFERENCES TEMPORADA(id_temporada)
);

CREATE TABLE FASE (
id_fase INT AUTO_INCREMENT PRIMARY KEY,
id_torneo INT NOT NULL,
tipo_fase ENUM('todos_contra_todos','cuadrangular','final') NOT NULL,
estado_fase ENUM('ABIERTA','CERRADA') DEFAULT 'ABIERTA',
FOREIGN KEY (id_torneo) REFERENCES TORNEO(id_torneo)
);

CREATE TABLE PARTICIPACION_EQUIPO_TORNEO (
id_participacion INT AUTO_INCREMENT PRIMARY KEY,
id_equipo INT NOT NULL,
id_torneo INT NOT NULL,
FOREIGN KEY (id_equipo) REFERENCES EQUIPO(id_equipo),
FOREIGN KEY (id_torneo) REFERENCES TORNEO(id_torneo),
UNIQUE KEY uk_equipo_torneo (id_equipo, id_torneo)
);

CREATE TABLE PARTIDO (
id_partido INT AUTO_INCREMENT PRIMARY KEY,
id_fase INT NOT NULL,
id_local INT NOT NULL,
id_visitante INT NOT NULL,
fecha DATETIME NOT NULL,
goles_local INT DEFAULT 0,
goles_visitante INT DEFAULT 0,
estado ENUM('programado','jugado') DEFAULT 'programado',
motivo_modificacion VARCHAR(255) DEFAULT NULL,
FOREIGN KEY (id_fase) REFERENCES FASE(id_fase),
FOREIGN KEY (id_local) REFERENCES EQUIPO(id_equipo),
FOREIGN KEY (id_visitante) REFERENCES EQUIPO(id_equipo)
);

CREATE TABLE TABLA_FASE (
id_tabla INT AUTO_INCREMENT PRIMARY KEY,
id_fase INT NOT NULL,
id_equipo INT NOT NULL,
pj INT DEFAULT 0,
pg INT DEFAULT 0,
pe INT DEFAULT 0,
pp INT DEFAULT 0,
gf INT DEFAULT 0,
gc INT DEFAULT 0,
dg INT DEFAULT 0,
puntos INT DEFAULT 0,
posicion INT DEFAULT 0,
FOREIGN KEY (id_fase) REFERENCES FASE(id_fase),
FOREIGN KEY (id_equipo) REFERENCES EQUIPO(id_equipo),
UNIQUE KEY uk_fase_equipo (id_fase, id_equipo)
);

CREATE TABLE TABLA_PROMEDIOS (
id_promedio INT AUTO_INCREMENT PRIMARY KEY,
id_equipo INT NOT NULL,
puntos_acumulados INT DEFAULT 0,
partidos_jugados INT DEFAULT 0,
promedio DECIMAL(5,3) GENERATED ALWAYS AS
(puntos_acumulados / NULLIF(partidos_jugados, 0)) STORED,
FOREIGN KEY (id_equipo) REFERENCES EQUIPO(id_equipo),
UNIQUE KEY uk_equipo_promedio (id_equipo)
);

CREATE TABLE GOL (
id_gol INT AUTO_INCREMENT PRIMARY KEY,
id_partido INT NOT NULL,
id_jugador INT NOT NULL,
minuto INT NOT NULL,
FOREIGN KEY (id_partido) REFERENCES PARTIDO(id_partido),
FOREIGN KEY (id_jugador) REFERENCES JUGADOR(id_jugador)
);

CREATE TABLE TARJETA (
id_tarjeta INT AUTO_INCREMENT PRIMARY KEY,
id_jugador INT NOT NULL,
id_partido INT NOT NULL,
id_torneo INT NOT NULL,
tipo_tarjeta ENUM('AMARILLA','ROJA') NOT NULL,
minuto INT NOT NULL,
es_segunda_amarilla TINYINT DEFAULT 0,
motivo VARCHAR(255) DEFAULT NULL,
gravedad ENUM('NORMAL','GRAVE') DEFAULT 'NORMAL',
FOREIGN KEY (id_jugador) REFERENCES JUGADOR(id_jugador),
FOREIGN KEY (id_partido) REFERENCES PARTIDO(id_partido),
FOREIGN KEY (id_torneo) REFERENCES TORNEO(id_torneo)
);

CREATE TABLE SANCION_JUGADOR (
id_sancion INT AUTO_INCREMENT PRIMARY KEY,
id_jugador INT NOT NULL,
id_torneo INT NOT NULL,
tipo_sancion ENUM('SUSPENSION_AMARILLA','SUSPENSION_ROJA') NOT NULL,
fechas_suspension INT DEFAULT 1,
estado ENUM('PENDIENTE','CUMPLIDA') DEFAULT 'PENDIENTE',
arrastrable TINYINT DEFAULT 0,
motivo_roja VARCHAR(255) DEFAULT NULL,
sujeta_a_revision TINYINT DEFAULT 0,
FOREIGN KEY (id_jugador) REFERENCES JUGADOR(id_jugador),
FOREIGN KEY (id_torneo) REFERENCES TORNEO(id_torneo)
);

CREATE TABLE ALINEACION_PARTIDO (
id_alineacion INT AUTO_INCREMENT PRIMARY KEY,
id_partido INT NOT NULL,
id_jugador INT NOT NULL,
posicion VARCHAR(30),
FOREIGN KEY (id_partido) REFERENCES PARTIDO(id_partido),
FOREIGN KEY (id_jugador) REFERENCES JUGADOR(id_jugador),
UNIQUE KEY uk_partido_jugador (id_partido, id_jugador)
);

CREATE TABLE usuarios_admin (
id_admin INT AUTO_INCREMENT PRIMARY KEY,
usuario VARCHAR(50) NOT NULL UNIQUE,
password VARCHAR(255) NOT NULL
);

INSERT INTO EQUIPO (nombre, ciudad) VALUES
('Atlético Nacional', 'Medellín'),
('Millonarios', 'Bogotá'),
('América de Cali', 'Cali'),
('Junior de Barranquilla', 'Barranquilla'),
('Independiente Santa Fe', 'Bogotá'),
('Independiente Medellín', 'Medellín'),
('Deportivo Cali', 'Cali'),
('Deportes Tolima', 'Ibagué'),
('Once Caldas', 'Manizales'),
('Alianza FC', 'Valledupar'),
('Atlético Bucaramanga', 'Bucaramanga'),
('Deportivo Pasto', 'Pasto'),
('Internacional de Bogotá', 'Bogotá'),
('Águilas Doradas', 'Rionegro'),
('Deportivo Pereira', 'Pereira'),
('Boyacá Chicó', 'Tunja'),
('Fortaleza FC', 'Bogotá'),
('Llaneros FC', 'Villavicencio'),
('Jaguares de Córdoba', 'Montería'),
('Cúcuta Deportivo', 'Cúcuta');

INSERT INTO COMPETICION (nombre, categoria, tipo)
VALUES ('Liga BetPlay', 'Primera A', 'liga');

INSERT INTO TEMPORADA (anio, id_competicion)
VALUES (2026, 1);

INSERT INTO TORNEO (id_temporada, nombre, estado)
VALUES (1, 'Apertura', 'en_juego');

INSERT INTO FASE (id_torneo, tipo_fase)
VALUES (1, 'todos_contra_todos');

INSERT INTO PARTICIPACION_EQUIPO_TORNEO (id_equipo, id_torneo) VALUES
(1,1),(2,1),(3,1),(4,1),(5,1),(6,1),(7,1),(8,1),(9,1),(10,1),
(11,1),(12,1),(13,1),(14,1),(15,1),(16,1),(17,1),(18,1),(19,1),(20,1);

INSERT INTO TABLA_FASE (id_fase, id_equipo) VALUES
(1,1),(1,2),(1,3),(1,4),(1,5),(1,6),(1,7),(1,8),(1,9),(1,10),
(1,11),(1,12),(1,13),(1,14),(1,15),(1,16),(1,17),(1,18),(1,19),(1,20);

INSERT INTO TABLA_PROMEDIOS (id_equipo) VALUES
(1),(2),(3),(4),(5),(6),(7),(8),(9),(10),
(11),(12),(13),(14),(15),(16),(17),(18),(19),(20);

-- Los procedimientos almacenados y triggers deben mantenerse en archivos separados
-- hasta completar la revisión de nombres y dependencias.
