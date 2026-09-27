<?php
require_once __DIR__ . '/../config/conexion.php';

$equipos = [];
$error = null;

try {
    $conexion = getConexion();
    $stmtEquipos = $conexion->prepare("CALL sp_listar_equipos()");
    $stmtEquipos->execute();
    $equipos = $stmtEquipos->fetchAll();
    $stmtEquipos->closeCursor();

    foreach ($equipos as &$equipo) {
        $stmtJugadores = $conexion->prepare("CALL sp_listar_jugadores_equipo(?)");
        $stmtJugadores->execute([$equipo['id_equipo']]);
        $equipo['jugadores'] = $stmtJugadores->fetchAll();
        $stmtJugadores->closeCursor();
    }
    unset($equipo);
} catch (PDOException $e) {
    $error = "Error al cargar los equipos y jugadores.";
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Equipos - Liga Colombiana</title>
</head>
<body>
    <h1>Equipos participantes</h1>

    <?php if ($error): ?>
        <p><?= htmlspecialchars($error) ?></p>
    <?php endif; ?>

    <?php if (!$equipos): ?>
        <p>No hay equipos registrados.</p>
    <?php else: ?>
        <?php foreach ($equipos as $equipo): ?>
            <section>
                <h2><?= htmlspecialchars($equipo['nombre']) ?></h2>
                <p><strong>Ciudad:</strong> <?= htmlspecialchars($equipo['ciudad']) ?></p>
                <h3>Jugadores</h3>
                <?php if (empty($equipo['jugadores'])): ?>
                    <p>No hay jugadores registrados.</p>
                <?php else: ?>
                    <ul>
                        <?php foreach ($equipo['jugadores'] as $jugador): ?>
                            <li><?= htmlspecialchars($jugador['nombre']) ?> - <?= htmlspecialchars($jugador['posicion'] ?? 'Sin posición') ?></li>
                        <?php endforeach; ?>
                    </ul>
                <?php endif; ?>
            </section>
        <?php endforeach; ?>
    <?php endif; ?>
</body>
</html>
