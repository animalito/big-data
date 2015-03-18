<?php
	set_time_limit(0);	
	$html_principal_3 = "http://nuforc.org/webreports/117/S117399.html";
	$html_code_2 = file_get_contents($html_principal_3);
	//var_dump($html_code);
	preg_match_all('/<TD BORDERCOLOR=#d0d7e5 ><FONT style=FONT-SIZE:11pt FACE="Calibri" COLOR=#000000>(.*?)<\/TD>/s', $html_code_2, $opcion_valor_3);
	var_dump($opcion_valor_3[0]);	
	
?>






