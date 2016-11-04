<?php
debug_backtrace() || die ("Шууд хандах боломжгүй");

$msg_error = "";
$msg_success = "";
$field_notice = array();

if(isset($_POST['send_comment'])){
    
    $captcha = strtoupper($_POST['captcha']);
    require(SYSBASE."includes/securimage/securimage.php");
    $img = new Securimage();
    $valid = $img->check($captcha);

    if($valid === false) $field_notice['captcha'] = $texts['INVALID_CAPTCHA_CODE'];
    
    $name = html_entity_decode($_POST['name'], ENT_QUOTES, "UTF-8");
    $email = html_entity_decode($_POST['email'], ENT_QUOTES, "UTF-8");
    $msg = html_entity_decode($_POST['msg'], ENT_QUOTES, "UTF-8");
    $item_id = $_POST['item_id'];
    $item_type = $_POST['item_type'];
    
    $rating = (isset($_POST['rating'])) ? $_POST['rating'] : false;
    
    if($name == "") $field_notice['name'] = $texts['REQUIRED_FIELD'];
    if($msg == "") $field_notice['msg'] = $texts['REQUIRED_FIELD'];
    if($rating !== false && (!is_numeric($rating) || $rating < 0 || $rating > 5)) $rating = null;
    
    if($email == "" || !preg_match("/^[\w.-]+@[\w.-]+\.[a-zA-Z]{2,6}$/i", $email)) $field_notice['email'] = $texts['INVALID_EMAIL'];
    
    if(!isset($_COOKIE['COMMENT_'.$item_type.'_'.$item_id])){
        $result_rating = $db->query("SELECT * FROM pm_comment WHERE item_type = ".$db->quote($item_type)." AND id_item = ".$db->quote($item_id)." AND rating > 0 AND rating <= 5 AND (UPPER(email) = ".$db->quote(mb_strtoupper($email, "UTF-8"))." OR ip = ".$db->quote($_SERVER['REMOTE_ADDR']).")");
        if($result_rating === false || $db->last_row_count() > 0)
            $rating = null;
    }else
        $rating = null;

    if(is_numeric($item_id) && count($field_notice) == 0){
        
        $data = array();
        $data['id_item'] = $item_id;
        $data['item_type'] = $item_type;
        $data['name'] = $name;
        $data['email'] = $email;
        $data['msg'] = $msg;
        $data['checked'] = 0;
        $data['add_date'] = time();
        $data['ip'] = $_SERVER['REMOTE_ADDR'];
        
        if($rating !== false) $data['rating'] = $rating;
        
        $result_insert = db_prepareInsert($db, "pm_comment", $data);
        
        if($result_insert->execute() !== false){
            if($rating !== false && $rating > 0 && $rating <= 5) setcookie("COMMENT_".$item_type."_".$item_id, 1, time()+2592000);
    
            $msg_success .= $texts['COMMENT_SUCCESS']."<br>";
    
            $mailContent = "Нэр: ".$name."<br> \n\n";
            $mailContent .= "И-мэйл: ".$email."<br> \n\n";
            if($rating > 0) $mailContent .= "Үнэлгээ: ".$rating."/5<br> \n\n";
            $mailContent .= "<b>Захидал:</b><br>".nl2br($msg)." \n\n";
            
            if(!sendMail(EMAIL, OWNER, "Шинэ сэтгэгдэл", $mailContent, $email, $name))
                $msg_error .= $texts['MAIL_DELIVERY_FAILURE']."<br>";
                
            $email = "";
            $name = "";
            $msg = "";
            $rating = "";
        }
    }else
        $msg_error .= $texts['FORM_ERRORS']."<br>";
    
}else{
    $name = "";
    $email = "";
    $msg = "";
    $rating = 0;
}
