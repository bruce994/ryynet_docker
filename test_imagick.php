<?php

$imagePath = "test.jpg";
$imagick = new \Imagick(realpath($imagePath));
$imagick->adaptiveResizeImage(80,100);
header("Content-Type: image/jpg");
echo $imagick->getImageBlob();








