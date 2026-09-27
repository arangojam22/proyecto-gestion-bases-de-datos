<?php
require_once __DIR__ . '/../config/conexion.php';

$clasificacion = [];
$error = null;

try {
    $conexion = getConexion();
    $stmt = $conexion->prepare("CALL sp_listar_clasificacion()");
    $stmt->execute();
    $clasificacion = $stmt->fetchAll();
    $stmt->closeCursor();
} catch (PDOException $e) {
    $error = "Error al cargar la clasificación.";
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Clasificación - Liga Colombiana</title>
</head>
<body>
    <h1>Tabla de clasificación</h1>

    <?php if ($error): ?>
        <p><?= htmlspecialchars($error) ?></p>
    <?php endif; ?>

    <?php if (!$clasificacion): ?>
        <p>No hay datos de clasificación disponibles.</p>
    <?php else: ?>
        <table border="1">
            <thead>
                <tr><th>Pos</th><th>Equipo</th><th>PJ</th><th>PG</th><th>PE</th><th>PP</th><th>GF</th><th>GC</th><th>DG</th><th>Puntos</th></tr>
            </thead>
            <tbody>
                <?php foreach ($clasificacion as $fila): ?>
                    <tr>
                        <td><?= (int) $fila['posicion'] ?></td>
                        <td><?= htmlspecialchars($fila['equipo']) ?></td>
                        <td><?= (int) $fila['pj'] ?></td>
                        <td><?= (int) $fila['pg'] ?></td>
                        <td><?= (int) $fila['pe'] ?></td>
                        <td><?= (int) $fila['pp'] ?></td>
                        <td><?= (int) $fila['gf'] ?></td>
                        <td><?= (int) $fila['gc'] ?></td>
                        <td><?= (int) $fila['dg'] ?></td>
                        <td><?= (int) $fila['puntos'] ?></td>
                    </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
    <?php endif; ?>
</body>
</html>
