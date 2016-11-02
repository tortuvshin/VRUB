<?php
/**
 * Script called (Ajax) on drag and drop event
 * orders the medias of an item
 */
session_start();
if(!isset($_SESSION['user'])) exit();

define("ADMIN", true);
require_once("../../common/lib.php");
require_once("../../common/define.php");

if(isset($_GET['table']) && isset($_GET['list']) && isset($_GET['prefix'])){
    
    $table = $_GET['table'];
    
    $res = explode("|", $_GET['list']);
    
    for($i = 1; $i <= count($res); $i++){
        $id = str_replace($_GET['prefix']."_", "", $res[$i-1]);
        
        if(is_numeric($id))
            $db->query("UPDATE pm_".$table." SET rank = ".$i." WHERE id = ".$id);
    }
}
