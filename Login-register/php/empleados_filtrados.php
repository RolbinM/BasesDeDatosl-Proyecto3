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
        <h1>Empleados</h1>
        <a style="color:#616161;" href="..//inicio.php">Regresar a pagina principal</a>
        <br> <br>

        <form method="POST" action="empleados_filtrados.php">

        <div class="form-group">
            <label>Nombre de busqueda:</label>
            <input type="text" name="Nombre" class="form-control" placeholder = "Escriba el nombre de filtro de empleados" required/><br/>
        </div>
 
        <div class="form-group">
            <input type="submit" name="search" class="btn btn-warning" value = "Buscar Empleados" /><br/>
        </div>
        </form>
    </div>
    <br /> <br /> <br />

    <?php
        if(isset($_POST['search'])){
            $nombre = $_POST ['Nombre'];

            $query = "EXECUTE dbo.Empleados_filtro '$nombre'";
            $ejecutar = sqlsrv_query ($conn_sis, $query);

            if($ejecutar){
                ?>
                <div class = "col-md-8 col-md-offset-2" >
                <table class = "table table-bordered table-responsive" >
                <tr>
                    <td align="center">ID</td>
                    <td align="center">Nombre</td>
                    <td align="center">Identificacion</td>
                    <td align="center">Fecha de Nacimiento</td>
                    <td align="center">Puesto</td>
                    <td align="center">Departamento</td>
                    <td align="center">Tipo de Documento</td>
                    <td align="center">Edicion</td>
                    <td align="center">Borrado</td>
                </tr>

                <?php

                $i = 0;
                while ($fila = sqlsrv_fetch_array($ejecutar)){
                    $id = $fila ['ID'];
                    $Nombre = $fila ['nombre'];
                    $identificacion = $fila ['valorDocIdent'];
                    $Nacimiento = $fila ['fechaNacimiento']->format('Y-m-d');
                    $Puesto = $fila ['nombre_P'];
                    $Departamento = $fila ['nombre_Dpt'];
                    $TipoDoc = $fila ['nombre_Doc'];
                    $i++;


                ?>
                <tr align = "center">
                <td><?php echo $id; ?></td>
                <td><?php echo $Nombre; ?></td>
                <td><?php echo $identificacion; ?></td>
                <td><?php echo $Nacimiento; ?></td>
                <td><?php echo $Puesto; ?></td>
                <td><?php echo $Departamento; ?></td>
                <td><?php echo $TipoDoc; ?></td>

                <td><a href="empleados_filtrados.php?editarEmpleados=<?php echo $id; ?>">Editar</a></td>
                <td><a href="empleados_filtrados.php?borrarEmpleados=<?php echo $id; ?>">Eliminar</a></td>
                </tr>

                <?php } ?>
                </table>
                </div>
                <?php
            }
        }
    ?>
<?php
        if(isset($_GET['editarEmpleados'])){
            include ("editarFiltrados.php");
        }
    
    ?>

    <?php
    if(isset($_GET['borrarEmpleados'])){

        $borrar_Id = $_GET['borrarEmpleados'];
        $borrar = "EXECUTE dbo.Empleado_eliminar $borrar_Id";
        $ejecutar = sqlsrv_query ($conn_sis, $borrar);

        if($ejecutar){
            echo"<script>alert('Empeado Eliminado Correctamente')</script>";
            echo"<script>window.open('empleados_filtrados.php', '_self')</script>";
        }
    }
    ?>

</center>
</body>
</html>