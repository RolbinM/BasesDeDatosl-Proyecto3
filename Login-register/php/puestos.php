<!DOCTYPE html>
<?php
    include 'driver.php';
?>
<meta charset="UTF-8">
<html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Puestos</title>
        <link href="..//assets/css/bootstrap.min.css" rel="stylesheet">
    </head>
<body>
<center>
    <div class = "col-md-8 col-md-offset-2">
        <h1>Puestos Disponibles</h1>
        <a style="color:#616161;" href="..//inicio.php">Regresar a pagina principal</a>
        <br> <br>

        <form method="POST" action="puestos.php">
            <div class="form-group" >
                <label >Id:</label>
                <input type="number" name="ID" class="form-control" placeholder = "Escriba el ID del puesto a crear"required/><br/>
            </div>
            <div class="form-group">
                <label>Nombre:</label>
                <input type="text" name="Nombre" class="form-control" placeholder = "Ingrese el nombre del puesto" required/><br/>
            </div>
            <div class="form-group">
                <label>SalarioxHora:</label>
                <input type = "number" name="SalarioxHora" class="form-control" placeholder = "Escriba el salario por hora del puesto"required/><br/>
            </div>
            <div class="form-group">
                <input type="submit" name="insert" class="btn btn-warning" value = "Insertar informacion" /><br/>
            </div>
        </form>
    </div>
    <br /> <br /> <br />

    <?php
        if(isset($_POST['insert'])){
            $id = $_POST ['ID'];
            $nombre = $_POST ['Nombre'];
            $salarioxhora = $_POST ['SalarioxHora'];

            $insertar = "EXECUTE dbo.Puesto_insertar $id, $nombre, $salarioxhora";
            $ejecutar = sqlsrv_query ($conn_sis, $insertar);

            if($ejecutar){
                echo"<script>alert('Insertado correctamente')</script>";
                echo"<script>window.open('puestos.php', '_self')</script>";
            }
            else{
                echo"<script>alert('Ese ID ya esta siendo utilizado')</script>";
                echo"<script>window.open('puestos.php', '_self')</script>";
            }

        }
    ?>

    <div class = "col-md-8 col-md-offset-2">
    <table class = "table table-bordered table-responsive">
        <tr>
            <td align="center"> ID</td>
            <td align="center">Nombre</td>
            <td align="center">SalarioXhora</td>
            <td align="center">Edicion</td>
            <td align="center">Borrado</td>
        </tr>

        <?php
            
            //$consulta = "SELECT * FROM dbo.Puesto";
            $consulta = "EXECUTE dbo.Puesto_consulta";
            $ejecutar = sqlsrv_query ($conn_sis, $consulta);

            $i = 0;
            while ($fila = sqlsrv_fetch_array($ejecutar)){
                    $id = $fila ['ID'];
                    $Nombre = $fila ['nombre_P'];
                    $salarioxhora = $fila ['salarioXhora'];

                    $i++;
            
            
            ?>
        <tr align = "center">
        <td><?php echo $id; ?></td>
        <td><?php echo $Nombre; ?></td>
        <td><?php echo $salarioxhora; ?></td>
        <td><a href="puestos.php?editarPuesto=<?php echo $id; ?>">Editar</a></td>
        <td><a href="puestos.php?borrarPuesto=<?php echo $id; ?>">Eliminar</a></td>
        </tr>

            <?php } ?>
        
    </table>
    </div>

    <?php
        if(isset($_GET['editarPuesto'])){
            include ("editarPuesto.php");
        }
    
    ?>

    <?php
    if(isset($_GET['borrarPuesto'])){

        $borrar_Id = $_GET['borrarPuesto'];
        $borrar = "EXECUTE dbo.Puesto_eliminar $borrar_Id";
        $ejecutar = sqlsrv_query ($conn_sis, $borrar);

        if($ejecutar){
            echo"<script>alert('Puesto Eliminado correctamente')</script>";
            echo"<script>window.open('puestos.php', '_self')</script>";
        }
    }
    ?>
</center>
</body>
</html>