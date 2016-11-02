<?php
error_reporting(E_ALL);

if(!defined("SYSBASE")) define("SYSBASE", str_replace("\\", "/", realpath(dirname(__FILE__)."/../")."/"));

$request_uri = explode("/", trim($_SERVER['REQUEST_URI'], "/"));
$pos = strrpos(SYSBASE, "/".$request_uri[0]);
$docbase = false;
if($pos !== false) $docbase = substr(SYSBASE, $pos);
if($docbase === false) $docbase = "/";

define("DOCBASE", $docbase);

$http = "http";
if((!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== "off") || $_SERVER['SERVER_PORT'] == 443) $http .= "s";
define("HTTP", $http);
