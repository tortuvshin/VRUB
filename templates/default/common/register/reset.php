<?php
/**
 * Script called (Ajax) on reset password
 */
require_once("../../../../common/lib.php");
require_once("../../../../common/define.php");

if(isset($_GET['token']) && isset($_GET['id']) && is_numeric($_GET['id'])){
    $result_token = $db->query("SELECT * FROM pm_user WHERE token = ".$db->quote(htmlentities($_GET['token'], ENT_COMPAT, "UTF-8"))." AND id = ".$_GET['id']." AND checked = 1");
    if($result_token !== false && $db->last_row_count() > 0){
        $row = $result_token->fetch();
        $new_pass = genPass(6);
        $mailContent = "
        <p>Сайн байна уу,<br>Та шинэ нууц үг захиалсан байна<br>
        Доор таны бүртгэлийн шинэчилсэн мэдээлэл байна<br>
        Хэрэглэгчийн нэр: ".$row['login']."<br>
        Нууц үг: <b>".$new_pass."</b><br>
        Та сайтын хэрэглэгчийн удирдлагын хэсэгт нэвтэрч уг нууц үгээ өөрийн хүссэнээр солих боломтой.</p>";
        if(sendMail($row['email'], $row['name'], "таны шинэ нууц үг", $mailContent) !== false){
            $db->query("UPDATE pm_user SET token = '', pass = '".md5($new_pass)."' WHERE id = ".$row['id']);
            header("Location: ".DOCBASE.$homepage['alias']);
            exit();
        }
    }
}elseif(isset($_POST['email'])){
        
    $response = array("html" => "", "notices" => array(), "error" => "", "success" => "", "redirect" => "");

    $email = htmlentities($_POST['email'], ENT_COMPAT, "UTF-8");

    $result_user = $db->query("SELECT * FROM pm_user WHERE email = ".$db->quote($email)." AND checked = 1");
    if($result_user !== false && $db->last_row_count() == 1){
        $row = $result_user->fetch();
        $token = md5(uniqid($email, true));
        $mailContent = "
        <p>Сайн байна уу,<br>Та шинэ нууц үг захиалсан байна<br>
        Доорх холбоос дээр дарж шинэ нууц үг үүсгэнэ үү:<br>
        <a href=".getUrl()."?token=".$token."&id=".$row['id'].">Шинэ нууц үг үүсгэх</a></p>";
        if(sendMail($email, $row['name'], "Шинэ нууц үг", $mailContent) !== false){
            $db->query("UPDATE pm_user SET token = '".$token."' WHERE id = ".$row['id']);
            $response['success'] = "Таны и-мэйл хаягруу шинэ нууц үгийг илгээлээ.";
        }
    }
    echo json_encode($response);
}
