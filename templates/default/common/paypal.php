<?php
$paypal_settings = Array(
    "test_mode" => true, // TRUE for test mode (Sandbox account), FALSE for production (live PayPal account)
    "version" => 56.0,
    "user" => "pandao.merchant_api1.gmail.com", // YOUR_OWN_API_USERNAME
    "pass" => "VRBEQRSU4QS29Y76", // YOUR_OWN_API_PASSWORD
    "signature" => "AFcWxV21C7fd0v3bYYYRCpSSRl31APKJ9JjZA1gPRd-aPsIR2ERTVvEF" // YOUR_OWN_API_SIGNATURE
);

function paypal_request($paypal_settings){

    $api_paypal = ($paypal_settings['test_mode'] === false) ? "https://api-3t.paypal.com/nvp?" : "https://api-3t.sandbox.paypal.com/nvp?";
    $api_paypal .= "VERSION=".$paypal_settings['version']."&USER=".$paypal_settings['user']."&PWD=".$paypal_settings['pass']."&SIGNATURE=".$paypal_settings['signature'];
    return $api_paypal;
}

function get_paypal_params($paypal_result){

    $params = explode("&", $paypal_result);

    foreach($params as $param){
        list($name, $value) = explode("=", $param);
        $params[$name] = urldecode($value);
    }
    return $params;
}
