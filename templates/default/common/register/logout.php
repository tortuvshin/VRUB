<?php
/**
 * Script called (Ajax) on logout
 */
require_once("../../../../common/lib.php");
require_once("../../../../common/define.php");
    
$response = array("html" => "", "notices" => array(), "error" => "", "success" => "", "redirect" => "");

if(isset($_SESSION['user'])) unset($_SESSION['user']);

echo json_encode($response);
