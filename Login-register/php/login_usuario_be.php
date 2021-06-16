<?php

    session_start();

    $conexion = mysqli_connect("localhost", "root", "", "login_register_db");

    $correo =$_POST ['correo'];
    $contrasena = $_POST ['contrasena'];
    //$contrasena = hash('sha512', $contrasena);

    $validar_login = mysqli_query ($conexion, "SELECT * FROM usuarios WHERE correo = '$correo' 
    and contrasena ='$contrasena'");

    if (mysqli_num_rows($validar_login) > 0){
        $_SESSION ['usuario'] = $correo;
        //header("location: ../driver.php");
        header("location: ../inicio.php");
        exit;
    }else{
        echo '
        <script>
            alert("Usuario inexistente, verificar datos ingresados");
            window.location = "../index.php";
        </script>
    ';
    exit;
    }

?>