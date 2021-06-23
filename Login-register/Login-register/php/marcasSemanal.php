<!DOCTYPE html>
<?php
    include 'driver.php';
?>
<meta charset="UTF-8">
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Empleados</title>
    <link href="..//assets/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <center>

    <div class = "col-md-8 col-md-offset-2">
        <h1>Marcas de Asistencia</h1>
        <a style="color:#616161;" href="empleados.php">Regresar a Empleados</a>
        <br> <br>

    <div class = "col-md-8 col-md-offset-2" >
    <table class = "table table-bordered table-responsive" >
        <tr>
            <td align="center">ID</td>
            <td align="center">Fecha Entrada</td>
            <td align="center">Fecha Salida</td>
            <td align="center">Id Jornada</td>
            <td align="center">Horas Ordinarias</td>
            <td align="center">Horas Extraordinarias</td>
            <td align="center">Horas Extraordinarias Dobles</td>
            <td align="center">Monto Ganado</td>
        </tr>

        <?php
        if(isset($_GET['MarcasAsistencia'])){
            $id_Planilla_Empleado = $_GET ['MarcasAsistencia'];
            $consulta = "EXECUTE sp_HorasSemanal $id_Planilla_Empleado, 0" ;
            $ejecutar = sqlsrv_query ($conn_sis, $consulta);

            $i = 0;
            while ($fila = sqlsrv_fetch_array($ejecutar)){
                    $id = $fila ['Id'];
                    $HoraEntrada = $fila ['HoraEntrada']->format("D M j G:i:s T Y");
                    $HoraSalida = $fila ['HoraSalida']->format("D M j G:i:s T Y");
                    $IdJornada = $fila ['IdJornada'];
                    $HorasOrdinarias = $fila ['HorasOrdinarias'];
                    $HorasExtra = $fila ['HorasExtraordinarias'];
                    $HorasExtraDobles = $fila ['HorasDobles'];
                    $Monto = $fila ['Monto'];
                    $i++;
            
            
            ?>
        <tr align = "center">
        <td><?php echo $id; ?></td>
        <td><?php echo $HoraEntrada; ?></td>
        <td><?php echo $HoraSalida; ?></td>
        <td><?php echo $IdJornada; ?></td>
        <td><?php echo $HorasOrdinarias; ?></td>
        <td><?php echo $HorasExtra; ?></td>
        <td><?php echo $HorasExtraDobles; ?></td>
        <td><?php echo $Monto; ?></td>

        </tr>

            <<?php } ?>
                </table>
                </div>
                <?php
            }
    ?>
    

</center>
</body>
</html>