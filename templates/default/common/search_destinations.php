<?php
require_once("../../../common/lib.php");
require_once("../../../common/define.php");

if(isset($_GET['q']) && $_GET['q'] != ""){
    
	$q = $_GET['q'];
    
	$query_destination = db_getSearchRequest($db, "pm_destination", array("name"), $q, 6, 0, "", "", "", "", 1);
	$result_destination = $db->query($query_destination);
	if($result_destination !== false){
		foreach($result_destination as $row){
			$destination_id	= $row['id'];
			$destination_name = $row['name'];
			
			echo "<a href=\"#\" class=\"live-search-result\" data-id=\"".$destination_id."\" data-descr=\"".$destination_name."\">".highlight($destination_name, $q)."</a>";
		}
	}
}
?>
