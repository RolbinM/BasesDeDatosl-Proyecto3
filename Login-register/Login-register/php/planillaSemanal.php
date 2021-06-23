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
        <h1>Planilla Semanal</h1>
        <a style="color:#616161;" href="empleados.php">Regresar a Empleados</a>
        <br> <br>

    <div class = "col-md-8 col-md-offset-2" >
    <table class = "table table-bordered table-responsive" >
        <tr>
            <td align="center">ID</td>
            <td align="center">Salario Bruto</td>
            <td align="center">Salario Neto</td>
            <td align="center">Total Deducciones</td>
            <td align="center">Horas Ordinarias</td>
            <td align="center">Horas Extraordinarias</td>
            <td align="center">Horas Extraordinarias Dobles</td>
            <td align="center">Marcas de Asistencia</td>
        </tr>

        <?php
        if(isset($_GET['PlanillaSemanal'])){
            $id_Planilla_Empleado = $_GET ['PlanillaSemanal'];
            $consulta = "EXECUTE sp_PlanillaSemanal $id_Planilla_Empleado, 0" ;
            $ejecutar = sqlsrv_query ($conn_sis, $consulta);

            $i = 0;
            while ($fila = sqlsrv_fetch_array($ejecutar)){
                    $id = $fila ['Id'];
                    $SalarioBruto = $fila ['SalarioBruto'];
                    $SalarioNeto = $fila ['SalarioNeto'];
                    $Total = $fila ['TotalDeducciones'];
                    $HorasOrdinarias = $fila ['HorasOrdinarias'];
                    $HorasExtra = $fila ['HorasExtraordinarias'];
                    $HorasExtraDobles = $fila ['HorasExtraordinariasDobles'];
                    $i++;
            
            
            ?>
        <tr align = "center">
        <td><?php echo $id; ?></td>
        <td><?php echo $SalarioBruto; ?></td>
        <td><?php echo $SalarioNeto; ?></td>
        <td><a href="deduciones_semanal.php?deduciones=<?php echo $id; ?>"><?php echo $Total; ?></a></td>
        <td><?php echo $HorasOrdinarias; ?></td>
        <td><?php echo $HorasExtra; ?></td>
        <td><?php echo $HorasExtraDobles; ?></td>
        <td><a href="marcasSemanal.php?MarcasAsistencia=<?php echo $id; ?>">Visualizar</a></td>

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