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
        <h1>Deducciones Semanales</h1>
        <a style="color:#616161;" href="empleados.php">Regresar a Empleados</a>
        <br> <br>

    <div class = "col-md-8 col-md-offset-2" >
    <table class = "table table-bordered table-responsive" >
        <tr>
            <td align="center">ID</td>
            <td align="center">Nombre</td>
            <td align="center">Es Obligatoria</td>
            <td align="center">Porcentaje</td>
            <td align="center">Monto</td>
        </tr>


        <?php
    if(isset($_GET['deduciones'])){
        

            $id_Planilla_Empleado = $_GET ['deduciones'];
            $consulta = "EXECUTE sp_DeduccionesSemanales $id_Planilla_Empleado, 0" ;
            $ejecutar = sqlsrv_query ($conn_sis, $consulta);

            $i = 0;
            while ($fila = sqlsrv_fetch_array($ejecutar)){
                    $id = $fila ['Id'];
                    $Nombre = $fila ['Nombre'];
                    $Bool = $fila ['EsObligatoria'];
                    $Porcentaje = $fila ['Porcentaje'];
                    $Monto = $fila ['Monto'];
                    $i++;
            
            
            ?>
        <tr align = "center">
        <td><?php echo $id; ?></td>
        <td><?php echo $Nombre; ?></td>
        <td><?php echo $Bool; ?></td>
        <td><?php echo $Porcentaje; ?></td>
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
