<?php
error_reporting(E_ALL);

// Messages
if(!isset($_SESSION['msg_error'])) $_SESSION['msg_error'] = "";
if(!isset($_SESSION['msg_success'])) $_SESSION['msg_success'] = "";
if(!isset($_SESSION['msg_notice'])) $_SESSION['msg_notice'] = "";

if(!defined("SYSBASE")) define("SYSBASE", str_replace("\\", "/", realpath(dirname(__FILE__)."/../")."/"));

if(trim(substr($_SERVER['REQUEST_URI'], strrpos($_SERVER['REQUEST_URI'], "/")), "/") != "setup.php"){
    $base = getenv("BASE");
    if($base === false){
        $request_uri = explode("/", trim($_SERVER['REQUEST_URI'], "/"));
        $pos = strrpos(SYSBASE, "/".$request_uri[0]);
        $base = false;
        if($pos !== false) $base = substr(SYSBASE, $pos);
        if($base === false || $base == "") $base = "/";
    }
    define("DOCBASE", $base);
}

$http = "http";
if((!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== "off") || $_SERVER['SERVER_PORT'] == 443) $http .= "s";
define("HTTP", $http);
