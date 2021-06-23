
<?php

    session_start();

    if(!isset($_SESSION['usuario'])){
        echo '
        <script>
            alert("Por favor iniciar sesion");
            window.location = "index.php";
        </script>
        ';
        //header ("location: index.php");
        session_destroy();
        die();
    }   
?>



<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bienvenida</title>

    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap" rel="stylesheet">

    <link rel ="stylesheet" href="assets/css/estilos_bienvenida.css">
</head>
<body>

    <div class="caja_1">

         <a style="color:#F5F5F5;" href="php/puestos.php">Puestos</a>
    </div>
    <br> <br>
    <div class="caja_2">

         <a style="color:#EEEEEE;" href="php/empleados.php">Empleados</a>
    </div>
    <br> <br>
    <div class="caja_3">

        <a style="color:#757575;" href="php/historial.php">Historial De Cambios</a>
    </div>
    <br> <br>
    <div class="caja_4">

        <a style="color:#616161;" href="php/cerrar_sesion.php">Cerrar Sesion</a>
    </div>
    
</body>
</html>