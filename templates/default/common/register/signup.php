<?php
/**
 * Script called (Ajax) on login
 */
require_once("../../../../common/lib.php");
require_once("../../../../common/define.php");

if(isset($_GET['token']) && isset($_GET['id']) && is_numeric($_GET['id'])){
    $id = $_GET['id'];
    $result_token = $db->query("SELECT * FROM pm_user WHERE token = ".$db->quote(htmlentities($_GET['token'], ENT_COMPAT, "UTF-8"))." AND id = ".$id." AND (checked = 0 OR checked IS NULL)");
    if($result_token !== false && $db->last_row_count() > 0){
        if($db->query("UPDATE pm_user SET checked = 1, token = '' WHERE id = ".$id) !== false){
            
            $row = $result_token->fetch();
            
            $_SESSION['user']['id'] = $id;
            $_SESSION['user']['login'] = $row['login'];
            $_SESSION['user']['email'] = $row['email'];
            $_SESSION['user']['type'] = $row['type'];
        }
    }    
    header("Location: ".DOCBASE.$homepage['alias']);
    exit();
}else{
    $response = array("html" => "", "notices" => array(), "error" => "", "success" => "", "redirect" => "");

    $login = htmlentities($_POST['username'], ENT_COMPAT, "UTF-8");
    $email = htmlentities($_POST['email'], ENT_COMPAT, "UTF-8");
    $name = htmlentities($_POST['name'], ENT_COMPAT, "UTF-8");
    $password = $_POST['password'];

    if($name == "") $response['notices']['name'] = $texts['REQUIRED_FIELD'];
    if($login == "") $response['notices']['username'] = $texts['REQUIRED_FIELD'];
    if(strlen($password) < 6) $response['notices']['password'] = $texts['PASS_TOO_SHORT'];
    if($email == "" || !preg_match("/^[\w.-]+@[\w.-]+\.[a-zA-Z]{2,6}$/i", $email)) $response['notices']['email'] = $texts['INVALID_EMAIL'];

    $result_exists = $db->query("SELECT * FROM pm_user WHERE email = ".$db->quote($email)." OR login = ".$db->quote($login));
    if($result_exists !== false && $db->last_row_count() > 0){
        $row = $result_exists->fetch();
        if($email = $row['email']) $response['notices']['email'] = $texts['ACCOUNT_EXISTS'];
        if($login = $row['login']) $response['notices']['username'] = $texts['USERNAME_EXISTS'];
    }
            
    if(count($response['notices']) == 0){

        $token = md5(uniqid($email, true));
    
        $data = array();
        $data['id'] = null;
        $data['name'] = $name;
        $data['login'] = $login;
        $data['email'] = $email;
        $data['pass'] = md5($password);
        $data['type'] = "registered";
        $data['checked'] = 0;
        $data['add_date'] = time();
        $data['token'] = $token;

        $result_user = db_prepareInsert($db, "pm_user", $data);
        if($result_user->execute() !== false){
            
            $id = $db->lastInsertId();
            
            $mailContent = "
            <p>Сайн байна уу,<br>Та шинээр өөрийн бүртгэлээ үүсгэлээ.<br>
            Доорх холбоос дээр дарж өөрийн бүртгэлийг баталгаажуулна уу:<br>
            <a href=".getUrl()."?token=".$token."&id=".$id.">Шинэ бүртгэлээ баталгаажуулах</a></p>";
            if(sendMail($email, $name, "бүртгэлээ баталгаажуулна уу", $mailContent) !== false)
                $response['success'] = $texts['ACCOUNT_CREATED'];
            else
                $response['error'] = $texts['ACCOUNT_CREATE_FAILURE'];
        }else
            $response['error'] = $texts['ACCOUNT_CREATE_FAILURE'];
    }else
        $response['error'] = $texts['FORM_ERRORS'];

    echo json_encode($response);
}
