<?php
        if(isset($_GET['editardeducciones'])){
            $editar_id = $_GET ['editardeducciones'];
            $consulta = "EXECUTE dbo.sp_ConsultaDeduccionXId $editar_id,0" ;
            $ejecutar = sqlsrv_query ($conn_sis, $consulta);

            $fila = sqlsrv_fetch_array($ejecutar);
                $id = $fila ['Id'];
                $Nombre = $fila ['Nombre'];
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
                <br/>
                <input type="text" name="Nombre" class="form-control" value="<?php echo $Nombre; ?>" readonly/><br/>
            </div>
            <br/>
            <div class="form-group">
                <label>Monto o Porcentaje:</label>
                <br/>
                <input type="number" step="0.01" name="monto" class="form-control"  placeholder = "Escriba el nuevo valor" require/><br/>
            </div>
            <br/>
            <div class="form-group">
                <input type="submit" name="actualizarDeduc" class="btn btn-warning" value = "ACTUALIZAR"><br/>
            </div>
        </form>
    </div>

<?php
        if(isset($_POST['actualizarDeduc'])){

            $actualizar_Monto  = $_POST ['monto'];

            $consulta = "EXECUTE dbo.sp_ModificarMontoDeduccionNoObligatoria $editar_id, $actualizar_Monto, 0" ;
            
            $ejecutar = sqlsrv_query ($conn_sis, $consulta);
           
            if($ejecutar){
                echo $actualizar_Monto;
                echo"<script>alert('Deduccion Editada correctamente')</script>";
                echo"<script>window.open('empleados.php', '_self')</script>";
            }
            else{
                echo $editar_id;
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