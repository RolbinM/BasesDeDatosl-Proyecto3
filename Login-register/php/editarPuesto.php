<?php
        if(isset($_GET['editarPuesto'])){
            $editar_id = $_GET ['editarPuesto'];
            $consulta = "EXECUTE dbo.Puesto_filtro $editar_id" ;
            $ejecutar = sqlsrv_query ($conn_sis, $consulta);

            $fila = sqlsrv_fetch_array($ejecutar);
                $Nombre = $fila ['nombre_P'];
                $salarioxhora = $fila ['salarioXhora'];
        }
    
?>
    <div class = "col-md-8 col-md-offset-2">
        <h1>Puestos Disponibles</h1>
        <a style="color:#616161;" href="..//inicio.php">Regresar a pagina principal</a>
        <br> <br>

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
                <label>SalarioxHora:</label>
                <input type = "number" name="SalarioxHora" class="form-control" value="<?php echo $salarioxhora; ?>" required/><br/>
            </div>
            <div class="form-group">
                <input type="submit" name="actualizar" class="btn btn-warning" value = "ACTUALIZAR DATOS" /><br/>
            </div>
        </form>
    </div>

<?php
        if(isset($_POST['actualizar'])){

            $actualizar_nombre = $_POST ['Nombre'];
            $actualizar_salario = $_POST ['SalarioxHora'];

            $consulta = "EXECUTE dbo.editar_puesto $editar_id, $actualizar_nombre, $actualizar_salario" ;
            $ejecutar = sqlsrv_query ($conn_sis, $consulta);

            if($ejecutar){
                echo"<script>alert('Puesto Editado correctamente')</script>";
                echo"<script>window.open('puestos.php', '_self')</script>";
            }

        }
    
?>