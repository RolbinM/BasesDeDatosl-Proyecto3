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
        <h1>Planilla Mensual</h1>
        <a style="color:#616161;" href="empleados.php">Regresar a Empleados</a>
        <br> <br>

    <div class = "col-md-8 col-md-offset-2" >
    <table class = "table table-bordered table-responsive" >
        <tr>
            <td align="center">ID</td>
            <td align="center">Salario Bruto</td>
            <td align="center">Salario Neto</td>
            <td align="center">Total Deducciones</td>
            <td align="center">ID Mes Planilla</td>
        </tr>

        <?php
        if(isset($_GET['PlanillaMensual'])){
            $id_Planilla_Empleado = $_GET ['PlanillaMensual'];
            $consulta = "EXECUTE sp_PlanillaMensual $id_Planilla_Empleado, 0" ;
            $ejecutar = sqlsrv_query ($conn_sis, $consulta);

            $i = 0;
            while ($fila = sqlsrv_fetch_array($ejecutar)){
                    $id = $fila ['Id'];
                    $SalarioBruto = $fila ['SalarioBruto'];
                    $SalarioNeto = $fila ['SalarioNeto'];
                    $Total = $fila ['TotalDeducciones'];
                    $MesPlanilla = $fila ['IdMesPlanilla'];
                    $i++;
            
            
            ?>
        <tr align = "center">
        <td><?php echo $id; ?></td>
        <td><?php echo $SalarioBruto; ?></td>
        <td><?php echo $SalarioNeto; ?></td>
        <td><a href="deducciones_mensuales.php?deduciones=<?php echo $id; ?>"><?php echo $Total; ?></a></td>
        <td><?php echo $MesPlanilla; ?></td>


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