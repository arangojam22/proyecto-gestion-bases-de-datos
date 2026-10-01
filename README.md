# Sistema de Gestión de la Liga BetPlay

> Aplicación web y base de datos relacional para gestionar equipos, jugadores, partidos, resultados, clasificaciones y estadísticas de una competición de fútbol.

[Explorar código](#estructura-del-proyecto) · [Ver tecnologías](#tecnologías) · [Instalación](#instalación-local) · [Funcionalidades](#funcionalidades)

---

## Índice

- [Objetivo](#objetivo)
- [Tecnologías](#tecnologías)
- [Funcionalidades](#funcionalidades)
- [Estructura del proyecto](#estructura-del-proyecto)
- [Instalación local](#instalación-local)
- [Próximas mejoras](#próximas-mejoras)
- [Aprendizajes](#aprendizajes)

## Objetivo

Diseñar una aplicación web conectada a MySQL para centralizar la gestión de información de una competición de fútbol: equipos, jugadores, partidos, resultados, clasificaciones, estadísticas y sanciones.

## Tecnologías

| Área | Tecnologías aplicadas |
|---|---|
| Base de datos | MySQL, SQL, procedimientos almacenados y triggers |
| Backend | PHP, PDO y patrón Singleton |
| Frontend | HTML5, CSS3 y JavaScript |
| Entorno | XAMPP, phpMyAdmin y MySQL Workbench |
| Control de versiones | Git y GitHub |

<details>
<summary><strong>Ver detalles técnicos de la base de datos</strong></summary>

- Modelado relacional con claves primarias y foráneas.
- Gestión de equipos, jugadores, partidos, resultados y clasificaciones.
- Consultas y operaciones mediante procedimientos almacenados.
- Automatización de reglas de negocio con triggers y procedimientos almacenados.
- Gestión de estadísticas, tarjetas y sanciones.

</details>

## Funcionalidades

| Módulo | Descripción |
|---|---|
| Inicio | Acceso a las secciones principales de la aplicación |
| Equipos | Consulta de equipos y jugadores asociados |
| Clasificación | Visualización de posiciones y estadísticas |
| Resultados | Consulta de partidos y marcadores |
| Base de datos | Gestión de datos deportivos y relaciones entre entidades |

## Estructura del proyecto

```text
proyecto-gestion-bases-de-datos/
├── sql/
│   └── ficheros_base_de_datos.sql
├── web/
│   ├── index.php
│   ├── equipos.php
│   ├── clasificacion.php
│   └── resultados.php
└── README.md
```

## Instalación local

<details>
<summary><strong>Ver pasos de instalación</strong></summary>

1. Instala XAMPP e inicia Apache y MySQL.
2. Abre phpMyAdmin o MySQL Workbench.
3. Importa `sql/ficheros_base_de_datos.sql`.
4. Copia el proyecto en el directorio `htdocs` de XAMPP.
5. Configura las credenciales de MySQL en tu entorno local.
6. Accede desde el navegador a:

```text
http://localhost/liga_colombia/
```

</details>

## Próximas mejoras

- Añadir capturas de la interfaz y del modelo entidad-relación.
- Mejorar la interfaz visual y la experiencia en móvil.
- Documentar procedimientos almacenados y triggers destacados.
- Añadir una configuración de conexión de ejemplo sin credenciales reales.

## Aprendizajes

- Diseño de una base de datos relacional.
- Consultas SQL, procedimientos almacenados y triggers.
- Conexión entre PHP y MySQL con patrón Singleton.
- Organización de una aplicación web por módulos.
- Documentación y control de versiones con Git y GitHub.

## Autor

**Jam Luis Arango Jiménez**  
Estudiante de ASIR — Redes, Sistemas, Bases de Datos y Ciberseguridad.
