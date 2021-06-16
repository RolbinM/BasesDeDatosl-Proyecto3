<?php 

$serverName = 'Localhost';
//$serverName = "DESKTOP-JPI5I7C\MSSQLSERVER"; //serverName\instanceName
$connectionInfo = array("Database"=>"Proyecto_I", "UID"=>"sa","PWD"=>"sa","CharacterSet"=>"UTF-8");

//$connectionInfo = array( "Database"=>"Proyecto");

$conn_sis = sqlsrv_connect ($serverName, $connectionInfo);
/*
if($conn_sis){

    echo "Conexion lista PAPA";
    
}else {
    echo "fallamos mi pana";
    die(print_r(sqlsrv_errors(), true));
} */
?>