<?php

#mysql:host=mysql 其中mysql 为容器名子

try{
	$db = new pdo('mysql:host=mysql;port=3306;dbname=mysql;charset=utf8','root','147258',array(
		        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,

	));

}catch(PDOException $pe){
        echo $pe->getMessage();

}

