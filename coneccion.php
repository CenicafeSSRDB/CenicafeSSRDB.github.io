<?php
  $mysqli=mysqli_connect("localhost","root","","genomas");
  if($mysqli)
    echo 'si';
  else
    echo 'no';
?>