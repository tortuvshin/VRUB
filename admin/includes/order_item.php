<?php
/**
 * Script called (Ajax) on drag and drop event
 * orders the items of a module
 */
session_start();
if(!isset($_SESSION['user'])) exit();

define("ADMIN", true);
require_once("../../common/lib.php");
require_once("../../common/define.php");

if(isset($_GET['table'])){
    $table = $_GET['table'];
    
    $offset = (is_numeric($_GET['offset'])) ? $_GET['offset'] : 0;
    
    $res = $_POST['listing_base'];
    for($i = 1; $i <= count($res); $i++){
        $id = str_replace("item_", "", $res[$i - 1]);
        
        if(is_numeric($id)) $db->query("UPDATE pm_".$table." SET rank = ".(($i-1)+$offset)." WHERE id = ".$id);
    }
}
