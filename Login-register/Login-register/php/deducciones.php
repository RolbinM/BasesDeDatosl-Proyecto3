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
    <title>Deducciones</title>
    <link href="..//assets/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <center>

    <div class = "col-md-8 col-md-offset-2">
    <h1>Deducciones Por Empleado No Obligatoria</h1>
        <a style="color:#616161;" href="empleados.php">Regresar a Empleados</a>
        <br> <br>
    
        <form method="POST" action="deducciones.php">

            <div class="form-group">
                <label>Id empleado:</label>
                <input type="number" step="0.01" name="Identificacion" class="form-control"  value="<?php echo $_GET ['Empleado']; ?>" readonly/><br/>
            </div>

            <div class="form-group">
                <label>Deduccion:</label>
                <?php
                $query = "EXECUTE sp_ConsultaDeduccionesTipos";
                $ejecutar = sqlsrv_query ($conn_sis, $query);

                ?>
                <select name="idDeduccion" class="form-control">
   
                    <?php    
                    while ($fila = sqlsrv_fetch_array($ejecutar))    
                    {
                        $id = $fila['ID'];
					    $nombre = $fila['Nombre']?>
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
                <label>Monto o Porcentaje:</label>
                <input type="number" step="0.01" name="Monto" class="form-control"  placeholder = "Escriba el monto o porcentaje a aplicar" required/><br/>
            </div>
            <br/>
            <div class="form-group">
                <input type="submit" name="Ingresar" class="btn btn-warning" value = "Asociar Deduccion"><br/>
            </div>
        </form>
    </div>
    <br /> <br /> <br />

    <?php
        if(isset($_POST['Ingresar'])){
            $identificacion = $_POST ['Identificacion'];
            $idDeduccion = $_POST ['idDeduccion'];
            $Monto  = $_POST ['Monto'];

            $consulta = "EXECUTE dbo.sp_AsociarNuevaDeduccion $identificacion, $idDeduccion, $Monto, 0" ;
            
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
            <td align="center">Id Tipo Deduccion</td>
            <td align="center">Nombre</td>
            <td align="center">Es Porcentual</td>
            <td align="center">Monto</td>
            <td align="center">Porcentaje</td>
            <td align="center">FechaInicio</td>
            <td align="center">Edicion</td>
            <td align="center">Borrado</td>
        </tr>

        <?php
            if(isset($_GET['Empleado'])){
            $id_Planilla_Empleado = $_GET ['Empleado'];
            $consulta = "EXECUTE sp_ConsultaDeducciones $id_Planilla_Empleado, 0" ;
            $ejecutar = sqlsrv_query ($conn_sis, $consulta);

            $i = 0;
            while ($fila = sqlsrv_fetch_array($ejecutar)){
                    $id = $fila ['Id'];
                    $IdTipoDeduccion = $fila ['IdTipoDeduccion'];
                    $Nombre = $fila ['Nombre'];
                    $Bool = $fila ['EsPorcentual'];
                    $Monto = $fila ['Monto'];
                    $Porcentaje = $fila ['Porcentaje'];
                    $FechaInicio = $fila ['FechaInicio']->format('Y-m-d');
                    $i++;
            
            
            ?>
        <tr align = "center">
        <td><?php echo $id; ?></td>
        <td><?php echo $IdTipoDeduccion; ?></td>
        <td><?php echo $Nombre; ?></td>
        <td><?php echo $Bool; ?></td>
        <td><?php echo $Monto; ?></td>
        <td><?php echo $Porcentaje; ?></td>
        <td><?php echo $FechaInicio; ?></td>

        <td><a href="deducciones.php?Empleado=<?php echo $id_Planilla_Empleado; ?>&editardeducciones=<?php echo $id; ?>">Editar</a></td>
        <td><a href="deducciones.php?Empleado=<?php echo $id_Planilla_Empleado; ?>&desasocia=<?php echo $id; ?>">Desasociar</a></td>

        </tr>

            <<?php } ?>
                </table>
                </div>
                <?php
            }
        
    ?>

    <?php
        if(isset($_GET['editardeducciones'])){
            include ("editardeducciones.php");
        }
    
    ?>

    <?php
    if(isset($_GET['desasocia'])){

        $desasocia_Id = $_GET['desasocia'];
        $borrar = "EXECUTE dbo.sp_DesasociarNuevaDeduccion $desasocia_Id,0";
        $ejecutar = sqlsrv_query ($conn_sis, $borrar);

        if($ejecutar){
            echo"<script>alert('Deduccion Eliminada Correctamente')</script>";
            echo"<script>window.open('empleados.php', '_self')</script>";
        }
    }
    ?>

</center>
</body>
</html>