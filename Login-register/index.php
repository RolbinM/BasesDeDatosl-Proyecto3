<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login and Register -Prueba1</title>

    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap" rel="stylesheet">

    <link rel ="stylesheet" href="assets/css/estilos.css">
</head>
<body>

    <main>

        <div class="contenedor__todo">

            <div class="caja__trasera">

                <div class="caja__trasera-login">

                    <!-- <h3>Ya posee una cuenta?</h3>
                    <p>Inicia Sesion para entrar en la pagina</p>
                    <button id="btn__iniciar-sesion">Iniciar Sesion</button> -->


                </div>
                <!-- <div class="caja__trasera-register">

                    <h3>Aun no posee una cuenta?</h3>
                    <p>Registrese para iniciar sesion</p>
                    <button id="btn__iniciar-registrarse">Registrarse</button>


                </div> -->

            </div>
            
            <div class="contenedor__register-login">
                <!--Formularios para iniciar o crear usuario-->
                <form action="php/login.php" method="POST" class="formulario__login">

                    <h2>Iniciar Sesion</h2>
                    <input type = "text" placeholder="Usuario Administrador" name= "usuario" required/>
                    <input type = "password" placeholder="Password" name= "contrasena" required/>
                    <button>Entrar </button>

                </form>

                <!-- <form action="php/registro_usuario_be.php" method="POST" class="formulario__register">

                    <h2>Registrarse</h2>
                    <input type = "text" placeholder="Nombre Completo" name= "nombre_completo" required/>
                    <input type = "text" placeholder="Correo Electronico" name= "correo" required/>
                    <input type = "text" placeholder="Usuario" name= "usuario" required/>
                    <input type = "password" placeholder="Password" name= "contrasena" required/>
                    <button>Registrarse</button>

                </form> -->

            </div>
        </div>

    </main>
    <script src="assets/js/script.js"></script>
</body>
</html>