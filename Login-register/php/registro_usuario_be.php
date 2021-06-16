<?php


    $conexion = mysqli_connect("localhost", "root", "", "login_register_db");

    $nombre_completo = $_POST['nombre_completo'];
    $correo = $_POST['correo'];
    $usuario = $_POST['usuario'];
    $contrasena = $_POST['contrasena'];
    //$contrasena = hash('sha512', $contrasena);


    $query = "INSERT INTO usuarios (nombre_completo, correo, usuario, contrasena) 
              VALUES ('$nombre_completo', '$correo', '$usuario', '$contrasena')";

    //Verificar no se repita el correo

    $verificar_correo = mysqli_query ($conexion, "SELECT * FROM usuarios WHERE  correo='$correo'");
    $verificar_usuario = mysqli_query ($conexion, "SELECT * FROM usuarios WHERE  usuario='$usuario'");
    
    if(mysqli_num_rows($verificar_correo) > 0 or mysqli_num_rows($verificar_usuario) > 0) {
        echo '
        <script>
            alert("Hubo un problema con informacion repetida, intenta con uno nuevo");
            window.location = "../index.php";
        </script>
    ';
        exit ();

    } 

    $ejecutar = mysqli_query($conexion, $query);

    if ($ejecutar){
        echo '
            <script>
                alert("Usuario almacenado exitosamente");
                window.location = "../index.php";
            </script>
        ';
    }else{
        echo '
            <script>
                alert("Hubo un error, intentarlo nuevamente");
                window.location = "../index.php";
            </script>
        ';
    }

    mysqli_close($conexion);
?>