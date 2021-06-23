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
    <title>Historial</title>
    <link href="..//assets/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <center>

    <div class = "col-md-8 col-md-offset-2">
        <h1>Historial de Cambios</h1>
        <a style="color:#616161;" href="..//inicio.php">Regresar a pagina principal</a>
    <br /> <br /> <br />

    <div class = "col-md-8 col-md-offset-2" >
    <table class = "table table-bordered table-responsive" >
        <tr>
            <td align="center">ID</td>
            <td align="center">Operacion</td>
            <td align="center">Descripcion Antes</td>
            <td align="center">Descripcion Despues</td>
            <td align="center">Fecha</td>
        </tr>

        <?php
            
            //$consulta = "SELECT * FROM dbo.Puesto";
            $consulta = "EXECUTE dbo.sp_ConsultaHistorial";
            $ejecutar = sqlsrv_query ($conn_sis, $consulta);

            $i = 0;
            while ($fila = sqlsrv_fetch_array($ejecutar)){
                    $id = $fila ['ID'];
                    $Operacion = $fila ['Operacion'];
                    $DescripcionA = $fila ['DescripcionA'];
                    $DescripcionD = $fila ['DescripcionB'];
                    $Fecha = $fila ['Fecha']->format('Y-m-d');
                    $i++;
            
            
            ?>
        <tr align = "center">
        <td><?php echo $id; ?></td>
        <td><?php echo $Operacion; ?></td>
        <td><?php echo $DescripcionA; ?></td>
        <td><?php echo $DescripcionD; ?></td>
        <td><?php echo $Fecha; ?></td>
        </tr>

            <?php } ?>
        
    </table>
    </div>
    ?>
</center>
</body>
</html>
