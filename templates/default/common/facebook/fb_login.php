<?php
require_once("config.php");
require_once("db_conn.php");
require_once("lib.php");
require_once("inc_lang.php");
require_once("facebook.php");

$facebook = new Facebook(array(
	"appId" => "194398910928420",
	"secret" => "646766d08dea2c372ce097269e363012",
	"cookie" => true)
);
	
$user = $facebook->getUser();

if(empty($user)){	
	header("Location: ".$facebook->getLoginUrl(array(
		"redirect_uri" => "http://www.good-spot.com/includes/php/fb_connect.php?",
		"scope" => "email",
		"display" => "popup",
		"locale" => LOCALE
	)));
}else{
	try{
		$uid = $facebook->getUser();
		$me = $facebook->api("/me");
		
		$email = $me['email'];
		$lastname = $me['last_name'];
		$firstname = $me['first_name'];
		$fb_id = $me['id'];
		
		$result_exists = $db->query("SELECT * FROM user WHERE email = ".$db->quote($email));
		if($result_exists !== false){
			$count = $db->last_row_count();
            $row = $result_exists->fetch();
			if($count == 1){
				$user_id = $row['id'];
				
				$_SESSION['user_id'] 	= $user_id;
				
				$db->query("UPDATE user SET fb_id = '".$fb_id."' WHERE id = ".$user_id);
				$_SESSION['first_connection'] = 0;
				echo "ok";
				
			}elseif($count == 0){
			
				$data = array();
				$data['id'] = "";
				$data['name'] = $firstname." ".$lastname;
				$data['email'] = $email;
				$data['login'] = $email;
				$data['type'] = "registered";
				$data['fb_id'] = $fb_id;
				$data['checked'] = 0;
				$data['add_date'] = time();
				
				$result = db_prepareInsert($db, "pm_user", $data);
                $result->execute();
				$_SESSION['first_connection'] = 1;
				
				if($result !== false){
                    
                    $_SESSION['user_id'] = $user_id;
                    
                    echo "ok";
				}
			}
		}
		
	}catch(FacebookApiException $e){
		error_log($e);
		$user = null;
	}
}
