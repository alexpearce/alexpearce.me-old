<?php
// If the page has been requested with AJAX
if(!empty($_SERVER['HTTP_X_REQUESTED_WITH']) && strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest') {
	
	// Content type to return
	header('Content-type: application/json');

	// Get this URL
	$url = 'http://ws.audioscrobbler.com/2.0/?method=user.getRecentTracks&limit=1&page=1&api_key=5554cbdd613bc105d85c1eb6d6c30ba2&user=boba899&format=json';

	// Get the contents of that page
	$contents = fopen($url, "r");

	// If there is something, read and return
	if ($contents) {
	    while (!feof($contents)) {
	        $buffer = fgets($contents, 1024);
	        echo $buffer;
	    }
	    fclose($contents);
	}
} else {
?>
	<!DOCTYPE html>
	<html>
	<head>
		<title>Red Handed</title>
		<meta charset="utf-8">
	</head>
	<body>
		<h2>Caught you snooping!</h2>
	</body>
	</html>
<?php
}
?>