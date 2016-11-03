<?php
/**
 * Script called (Ajax) on login
 */
require_once("../../../../common/lib.php");
require_once("../../../../common/define.php");
    
$response = array("html" => "", "notices" => array(), "error" => "", "success" => "", "redirect" => "");

$user = htmlentities($_POST['user'], ENT_COMPAT, "UTF-8");
$password = $_POST['password'];
        
$result_user = $db->query("SELECT * FROM pm_user WHERE (login = ".$db->quote($user)." OR email = ".$db->quote($user).") AND pass = '".md5($password)."' AND checked = 1");
if($result_user !== false && $db->last_row_count() == 1){
    $row = $result_user->fetch();
    $_SESSION['user']['id'] = $row['id'];
    $_SESSION['user']['login'] = $row['login'];
    $_SESSION['user']['email'] = $row['email'];
    $_SESSION['user']['type'] = $row['type'];
    
    if($_SESSION['user']['type'] != "registered") $response['redirect'] = DOCBASE."admin";
}else
    $response['error'] = $texts['INCORRECT_LOGIN'];

echo json_encode($response);
