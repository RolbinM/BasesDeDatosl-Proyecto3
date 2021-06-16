<?php

    session_start();
    include 'driver.php';


    $usuario =$_POST ['usuario'];
    $contrasena = $_POST ['contrasena'];
    //$contrasena = hash('sha512', $contrasena);

    $validar_login = "EXECUTE dbo.Usuario_validar $usuario, $contrasena";
    $ejecutar = sqlsrv_query ($conn_sis, $validar_login);

    if($ejecutar) {
        if($row = sqlsrv_fetch_array($ejecutar)) {
            $_SESSION ['usuario'] = $usuario;
            //header("location: ../driver.php");
            header("location: ../inicio.php");
            exit;
        } else {
            echo '
            <script>
                alert("Usuario inexistente, verificar datos ingresados");
                window.location = "../index.php";
            </script>
        ';
        }
    } else {
        echo "NO FUNCIONA.";
    }

?>