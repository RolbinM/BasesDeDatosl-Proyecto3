<?php
        if(isset($_GET['editarEmpleados'])){
            $editar_id = $_GET ['editarEmpleados'];
            $consulta = "EXECUTE dbo.sp_EmpleadoPorDoc $editar_id" ;
            $ejecutar = sqlsrv_query ($conn_sis, $consulta);

            $fila = sqlsrv_fetch_array($ejecutar);
                $id = $fila ['ID'];
                $Nombre = $fila ['Nombre'];
                $identificacion = $fila ['ValorDocumento'];
                $Nacimiento = $fila ['FechaNacimiento']->format('Y-m-d');
                $Puesto = $fila ['NombrePuesto'];
                $Departamento = $fila ['NombreDepartamento'];
                $TipoDoc = $fila ['NombreTipoDoc'];
        }
    
?>


<div class = "col-md-8 col-md-offset-2">

        <form method="POST" action="">
            <!-- <div class="form-group" >
                <label>Id:</label>
                <input type="number" name="ID" class="form-control" placeholder = "Escriba el ID del puesto a crear"required/><br/>
            </div> -->
            <div class="form-group">
                <label>Nombre:</label>
                <input type="text" name="Nombre" class="form-control" value="<?php echo $Nombre; ?>" required/><br/>
            </div>
            <div class="form-group">
                <label>Identificacion:</label>
                <input type="number" name="Identificacion" class="form-control" value="<?php echo $identificacion; ?>" readonly/><br/>
            </div>
            <div class="form-group">
                <label>Nacimiento:</label>
                <input type="date" name="Nacimiento" class="form-control"  value="<?php echo $Nacimiento; ?>" required/><br/>
            </div>
            <div class="form-group">
                <label>Puesto:</label>
                <?php

                $query = "EXECUTE dbo.sp_ConsultaPuestoSinSalario";
                $ejecutar = sqlsrv_query ($conn_sis, $query);

                ?>
                <select name="Puesto" class="form-control">
   
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
                <label>Departamento:</label>
                <?php

                $query = "EXECUTE dbo.sp_ConsultaDepartamento";
                $ejecutar = sqlsrv_query ($conn_sis, $query);

                ?>
                <select name="Departamento"  class="form-control">   
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
                <label>Tipo De Documento:</label>
                <?php

                $query = "EXECUTE dbo.sp_ConsultaTipoDoc";
                $ejecutar = sqlsrv_query ($conn_sis, $query);

                ?>
                <select input type = "number" name="TipoDoc" class="form-control">   
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
                <input type="submit" name="actualizar" class="btn btn-warning" value = "ACTUALIZAR DATOS"><br/>
            </div>
        </form>
    </div>



    <?php
        if(isset($_POST['actualizar'])){

            $actualizar_nombre = $_POST ['Nombre'];
            $actualizar_identificacion = $_POST ['Identificacion'];
            $actualizar_Nacimiento = $_POST ['Nacimiento'];
            $actualizar_Puesto = $_POST ['Puesto'];
            $actualizar_Departamento = $_POST ['Departamento'];
            $actualizar_TipoDoc  = $_POST ['TipoDoc'];

            

            $consulta = "EXECUTE dbo.sp_EditarEmpleados $editar_id, '$actualizar_nombre', $actualizar_identificacion, 
                        '$actualizar_Nacimiento', $actualizar_Puesto, $actualizar_Departamento, $actualizar_TipoDoc" ;
            
            $ejecutar = sqlsrv_query ($conn_sis, $consulta);
           
            if($ejecutar){
                echo"<script>$actualizar_Nacimiento</script>";
                echo"<script>alert('Empleado Editado correctamente')</script>";
                echo"<script>window.open('empleados_filtrados.php', '_self')</script>";
            }
            else{
                echo $actualizar_Nacimiento;
                echo 'hola';
                if( ($errors = sqlsrv_errors() ) != null) {
                    foreach( $errors as $error ) {
                        echo "SQLSTATE: ".$error[ 'SQLSTATE']."<br />";
                        echo "code: ".$error[ 'code']."<br />";
                        echo "message: ".$error[ 'message']."<br />";
                    }
                }
            }

        }
    
?>