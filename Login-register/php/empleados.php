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

        <form method="POST" action="empleados.php">

        <div class="form-group">
                <label>Nombre:</label>
                <input type="text" name="Nombre" class="form-control" placeholder = "Escriba el nombre del empleado nuevo" required/><br/>
            </div>
            <div class="form-group">
                <label>Identificacion:</label>
                <input type="number" name="Identificacion" class="form-control"  placeholder = "Escriba la identificacion" required/><br/>
            </div>
            <div class="form-group">
                <label>Nacimiento:</label>
                <input type="date" name="Nacimiento" class="form-control"  placeholder = "Escriba la fecha de Nacimiento del empleado" required/><br/>
            </div>
            <div class="form-group">
                <label>Puesto:</label>
                <?php

                $query = "EXECUTE dbo.Puesto_consulta_ID";
                $ejecutar = sqlsrv_query ($conn_sis, $query);

                ?>
                <select name="Puesto" class="form-control">
   
                    <?php    
                    while ($fila = sqlsrv_fetch_array($ejecutar))    
                    {
                        $id = $fila['ID'];
					    $nombre = $fila['nombre_P']?>
                        ?>

                        <option value="<?php echo $id ?>"><?php echo $nombre ?>
                        </option> 
                    
                        <?php
                    }    
                    ?>       
                </select>
            </div>
            <br/>
            <div class="form-group">
                <label>Departamento:</label>
                <?php

                $query = "EXECUTE dbo.departamento_consulta_ID";
                $ejecutar = sqlsrv_query ($conn_sis, $query);

                ?>
                <select name="Departamento"  class="form-control">   
                    <?php    
                    while ($fila = sqlsrv_fetch_array($ejecutar))    
                    {
                        $id = $fila['ID'];
					    $nombre = $fila['nombre_Dpt']?>
                        ?>
					    <option value="<?php echo $id ?>"><?php echo $nombre ?>
                        </option>                    
                        <?php
                    }    
                    ?>       
                </select>
            </div>
            <br/>
            <div class="form-group">
                <label>Tipo De Documento:</label>
                <?php

                $query = "EXECUTE dbo.tipoDoc_consulta_ID";
                $ejecutar = sqlsrv_query ($conn_sis, $query);

                ?>
                <select input type = "number" name="TipoDoc" class="form-control">   
                    <?php    
                    while ($fila = sqlsrv_fetch_array($ejecutar))    
                    {
                        $id = $fila['ID'];
					    $nombre = $fila['nombre_Doc']?>
                        ?>

                        <option value="<?php echo $id ?>"><?php echo $nombre ?>
                        </option>  
                    
                        <?php
                    }    
                    ?>       
                </select>
            </div>
            <br/>
            <div class="form-group">
                <input type="submit" name="insert" class="btn btn-warning" value = "Insertar informacion" /><br/>
            </div>
        </form>
    </div>
    <br /> <br /> <br />

    <?php
        if(isset($_POST['insert'])){
            $nombre = $_POST ['Nombre'];
            $identificacion = $_POST ['Identificacion'];
            $Nacimiento = $_POST ['Nacimiento'];
            $Puesto = $_POST ['Puesto'];
            $Departamento = $_POST ['Departamento'];
            $TipoDoc  = $_POST ['TipoDoc'];

            $consulta = "EXECUTE dbo.Empleado_insertar '$nombre', $identificacion, 
                        '$Nacimiento', $Puesto, $Departamento, $TipoDoc" ;
            
            $ejecutar = sqlsrv_query ($conn_sis, $consulta);
            if($ejecutar){
                echo"<script>alert('Insertado correctamente')</script>";
                echo"<script>window.open('empleados.php', '_self')</script>";
            }
            else{
                echo"<script>alert('Ese ID ya esta siendo utilizado')</script>";
                echo"<script>window.open('empleados.php', '_self')</script>";
            }

        }
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
            
            //$consulta = "SELECT * FROM dbo.Puesto";
            $consulta = "EXECUTE dbo.Empleado_consulta";
            $ejecutar = sqlsrv_query ($conn_sis, $consulta);

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

        <td><a href="empleados.php?editarEmpleados=<?php echo $id; ?>">Editar</a></td>
        <td><a href="empleados.php?borrarEmpleados=<?php echo $id; ?>">Eliminar</a></td>
        </tr>

            <?php } ?>
        
    </table>
    </div>

    <?php
        if(isset($_GET['editarEmpleados'])){
            include ("editarEmpleados.php");
        }
    
    ?>

    <?php
    if(isset($_GET['borrarEmpleados'])){

        $borrar_Id = $_GET['borrarEmpleados'];
        $borrar = "EXECUTE dbo.Empleado_eliminar $borrar_Id";
        $ejecutar = sqlsrv_query ($conn_sis, $borrar);

        if($ejecutar){
            echo"<script>alert('Empeado Eliminado Correctamente')</script>";
            echo"<script>window.open('empleados.php', '_self')</script>";
        }
    }
    ?>
</center>
</body>
</html>