<?php
	set_time_limit(0);
	$html_principal = 'http://data.gdeltproject.org/events/index.html';
	$html_code = file_get_contents($html_principal);
	//var_dump($html_code);
	preg_match_all("#<A.*?>([^<]+)</A>#", $html_code, $opcion_texto);
	//var_dump($opcion_texto[1]);
	$URLS = array();
	$i = 1;
	foreach($opcion_texto[1] as $url){
		if($i >= 3){
			$url_base = 'http://data.gdeltproject.org/events/';
			array_push($URLS,$url_base . $url);
			echo $url_base.$url . "\n";
		}
		$i++;
	}
?>
