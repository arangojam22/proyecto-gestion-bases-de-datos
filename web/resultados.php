<?php
require_once __DIR__ . '/../config/conexion.php';

$partidos = [];
$error = null;

try {
    $conexion = getConexion();
    $stmt = $conexion->prepare("CALL sp_listar_partidos()");
    $stmt->execute();
    $partidos = $stmt->fetchAll();
    $stmt->closeCursor();
} catch (PDOException $e) {
    $error = "Error al cargar los resultados.";
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Resultados - Liga Colombiana</title>
</head>
<body>
    <h1>Resultados de partidos</h1>

    <?php if ($error): ?>
        <p><?= htmlspecialchars($error) ?></p>
    <?php endif; ?>

    <?php if (!$partidos): ?>
        <p>No hay partidos registrados aún.</p>
    <?php else: ?>
        <table border="1">
            <thead><tr><th>Fecha</th><th>Local</th><th>Marcador</th><th>Visitante</th><th>Estado</th></tr></thead>
            <tbody>
                <?php foreach ($partidos as $partido): ?>
                    <tr>
                        <td><?= htmlspecialchars($partido['fecha']) ?></td>
                        <td><?= htmlspecialchars($partido['equipo_local']) ?></td>
                        <td><?= (int) $partido['goles_local'] ?> - <?= (int) $partido['goles_visitante'] ?></td>
                        <td><?= htmlspecialchars($partido['equipo_visitante']) ?></td>
                        <td><?= htmlspecialchars($partido['estado']) ?></td>
                    </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
    <?php endif; ?>
</body>
</html>
