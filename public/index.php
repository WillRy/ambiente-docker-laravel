<?php 
$data = 'some data'.PHP_EOL;
$fp = fopen('somefile', 'a');
fwrite($fp, $data);
?>