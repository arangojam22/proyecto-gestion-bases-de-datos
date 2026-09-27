<?php
require_once __DIR__ . '/../config/conexion.php';

$ultimosPartidos = [];
$proximosPartidos = [];
$error = null;

try {
    $conexion = getConexion();
    $stmt = $conexion->prepare("CALL sp_listar_partidos()");
    $stmt->execute();
    $partidos = $stmt->fetchAll();
    $stmt->closeCursor();

    foreach ($partidos as $partido) {
        $estado = strtolower($partido['estado'] ?? '');
        if ($estado === 'jugado' || $estado === 'finalizado') {
            $ultimosPartidos[] = $partido;
        } else {
            $proximosPartidos[] = $partido;
        }
    }

    $ultimosPartidos = array_slice($ultimosPartidos, 0, 5);
    $proximosPartidos = array_slice($proximosPartidos, 0, 5);
} catch (PDOException $e) {
    $error = "Error al cargar los datos de la liga.";
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liga Colombiana</title>
</head>
<body>
    <h1>Sistema de Gestión de la Liga Colombiana</h1>
    <p>Consulta los resultados más recientes, la tabla de posiciones y las plantillas de todos los equipos.</p>

    <?php if ($error): ?>
        <p><?= htmlspecialchars($error) ?></p>
    <?php endif; ?>

    <h2>Últimos resultados</h2>
    <?php if (!$ultimosPartidos): ?>
        <p>No hay resultados registrados aún.</p>
    <?php else: ?>
        <?php foreach ($ultimosPartidos as $partido): ?>
            <p><?= htmlspecialchars($partido['equipo_local']) ?>
                <?= (int) $partido['goles_local'] ?> - <?= (int) $partido['goles_visitante'] ?>
                <?= htmlspecialchars($partido['equipo_visitante']) ?></p>
        <?php endforeach; ?>
    <?php endif; ?>

    <h2>Próximos partidos</h2>
    <?php if (!$proximosPartidos): ?>
        <p>No hay partidos próximos programados.</p>
    <?php else: ?>
        <?php foreach ($proximosPartidos as $partido): ?>
            <p><?= htmlspecialchars($partido['equipo_local']) ?> vs <?= htmlspecialchars($partido['equipo_visitante']) ?></p>
        <?php endforeach; ?>
    <?php endif; ?>
</body>
</html>
