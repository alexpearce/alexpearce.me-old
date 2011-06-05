<?php 

function is_online() {
  
  // create curl resource 
  $ch = curl_init(); 

  // set url 
  curl_setopt($ch, CURLOPT_URL, "http://www.google.com/talk/service/badge/Show?tk=z01q6amlqnf4hducke7e7q8ati7ueb44v5fcu4cabfrlqb7b80e3pdjkej1a3nfri87556g269nn1bk4qhd07udf6s6utfgjtpscjavtf7nkbu4o2ga42dbvk6m1qqiv26g23ggs3nk3bjm95qpgn9ehggenvnegqerdj1u0n"); 

  // return the transfer as a string 
  curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1); 

  // $output contains the output string 
  $output = curl_exec($ch); 

  // close curl resource to free up system resources 
  curl_close($ch);

  return (preg_match('/Available/', $output) === 1) ? true : false; 
  
}


$is_online = is_online();