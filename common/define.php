<?php
/**
 * Common file for Pandao CMS
 * gets the configuration values and defines the environment
 */
if(!is_session_started()) session_start();

if(!defined("ADMIN")) define("ADMIN", false);

require_once("setenv.php");

$default_lang = 2;
$default_lang_tag = "mn";
$lang_alias = "";
$locale = "mn_MN";
$default_currency_code = "MNT";
$default_currency_sign = "₮";
$default_currency_rate = 1;
$rtl_dir = false;
$db = false;

if(is_file(SYSBASE."common/config.php")){
    require_once(SYSBASE."common/config.php");
    
    if(ADMIN && is_file(SYSBASE.ADMIN_FOLDER."/includes/lang.ini"))
        $texts = parse_ini_file(SYSBASE.ADMIN_FOLDER."/includes/lang.ini");
    
    try{
        $db = new db("mysql:host=".DB_HOST.";port=".DB_PORT.";dbname=".DB_NAME.";charset=utf8", DB_USER, DB_PASS);
        $db->exec("SET NAMES 'utf8'");
    }catch(PDOException $e){
        if(ADMIN) $_SESSION['msg_error'][] = $texts['DATABASE_ERROR'];
        else die("Өгөгдлийн сантай холбогдох боломжгүй байна. Вебмастертай холбогдох эсвэл дараа дахин оролдоно уу.");
    }
}

if(!defined("ADMIN_FOLDER")) define("ADMIN_FOLDER", "admin");

if(($db !== false && db_table_exists($db, "pm_%") === false) || !is_file(SYSBASE."common/config.php")){
    header("Location: ".DOCBASE.ADMIN_FOLDER."/setup.php");
    exit();
}

if(!ADMIN){
    $request_uri = (DOCBASE != "/") ? substr($_SERVER['REQUEST_URI'], strlen(DOCBASE)) : $_SERVER['REQUEST_URI'];
    $request_uri = trim($request_uri, "/");
    $pos = strpos($request_uri, "?");
    if($pos !== false) $request_uri = substr($request_uri, 0, $pos);
    
    define("REQUEST_URI", $request_uri);
}

if($db !== false){
    
    $result_currency = $db->query("SELECT * FROM pm_currency");
    if($result_currency !== false){
        foreach($result_currency as $i => $row){
            $currency_code = $row['code'];
            $currency_sign = $row['sign'];
            if($row['main'] == 1){
                $default_currency_code = $currency_code;
                $default_currency_sign = $currency_sign;
            }
            $currencies[$currency_code] = $row;
        }
    }
        
    $result_lang = $db->query("SELECT l.id AS lang_id, lf.id AS file_id, title, tag, file, locale, rtl, main FROM pm_lang as l, pm_lang_file as lf WHERE id_item = l.id AND l.checked = 1 AND file != '' ORDER BY l.rank");
    if($result_lang !== false){
        foreach($result_lang as $i => $row){
            $lang_tag = $row['tag'];
            if($row['main'] == 1){
                $default_lang = $row['lang_id'];
                $default_lang_tag = $lang_tag;
            }
            $row['file'] = DOCBASE."medias/lang/big/".$row['file_id']."/".$row['file'];
            $langs[$lang_tag] = $row;
        }
    }
    $id_lang = $default_lang;
    $lang_tag = $default_lang_tag;
    
    if(!ADMIN && (MAINTENANCE_MODE == 0  || (isset($_SESSION['user']) && ($_SESSION['user']['type'] != "administrator" || $_SESSION['user']['type'] != "manager")))){
        if(LANG_ENABLED == 1){
            
            $uri = explode("/", REQUEST_URI);
            $lang_tag = $uri[0];
            
            if(!isset($langs[$lang_tag])){
                
                if(preg_match("/$(index.php)?^/", str_replace(DOCBASE, "", $_SERVER['REQUEST_URI']))){
                    
                    if($lang_tag == ""){
                        if(isset($_COOKIE['LANG_TAG']) && isset($langs[$_COOKIE['LANG_TAG']])){
                            header("HTTP/1.0 404 Not Found");
                            header("Location: ".DOCBASE.$_COOKIE['LANG_TAG']);
                            exit();
                        }else{
                            header("HTTP/1.0 404 Not Found");
                            header("Location: ".DOCBASE.$default_lang_tag);
                            exit();
                        }
                    }else err404(DOCBASE."404.html");
                    
                }elseif(isset($_SESSION['LANG_TAG']))
                    $lang_tag = $_SESSION['LANG_TAG'];
                else
                    $lang_tag = $default_lang_tag;
            }else{
                setcookie("LANG_TAG", $lang_tag, time()+25200);
                
                $_SESSION['LANG_TAG'] = $lang_tag;
                
                $id_lang = $langs[$lang_tag]['lang_id'];
                $locale = $langs[$lang_tag]['locale'];
                $rtl_dir = $langs[$lang_tag]['rtl'];
                
                $sublocale = substr($locale, 0, 2);
                if($sublocale == "tr" || $sublocale == "az") $locale = "en_GB";
            }
            $lang_alias = $lang_tag."/";
        }
        
        $texts = array();
        $result_text = $db->query("SELECT * FROM pm_text WHERE lang = ".$id_lang." GROUP BY id");
        foreach($result_text as $row)
            $texts[$row['name']] = $row['value'];
                
        $widgets = array();
        $result_widget = $db->query("SELECT * FROM pm_widget WHERE checked = 1 AND lang = ".$id_lang." GROUP BY id ORDER BY rank");
        foreach($result_widget as $row)
            $widgets[$row['pos']][] = $row;
    }
}else{
    $id_lang = $default_lang;
    $lang_tag = $default_lang_tag;
}

$currency_code = (isset($_SESSION['currency']['code'])) ? $_SESSION['currency']['code'] : $default_currency_code;
$currency_sign = (isset($_SESSION['currency']['sign'])) ? $_SESSION['currency']['sign'] : $default_currency_sign;
$currency_rate = (isset($_SESSION['currency']['rate'])) ? $_SESSION['currency']['rate'] : $default_currency_rate;

date_default_timezone_set(TIME_ZONE);

if(setlocale(LC_ALL, $locale.".UTF-8", $locale) === false){
    $locale = "en_GB";
    setlocale(LC_ALL, $locale.".UTF-8", $locale);
}

define("DEFAULT_CURRENCY_CODE", $default_currency_code);
define("DEFAULT_CURRENCY_SIGN", $default_currency_sign);
define("CURRENCY_CODE", $currency_code);
define("CURRENCY_SIGN", $currency_sign);
define("CURRENCY_RATE", $currency_rate);
define("DEFAULT_LANG", $default_lang);
define("LOCALE", $locale);
define("LANG_ID", $id_lang);
define("LANG_TAG", $lang_tag);
define("LANG_ALIAS", $lang_alias);
define("RTL_DIR", $rtl_dir);

$allowable_file_exts = array(
    "pdf" => "pdf.png",
    "doc" => "doc.png",
    "docx" => "doc.png",
    "odt" => "doc.png",
    "xls" => "xls.png",
    "xlsx" => "xls.png",
    "ods" => "xls.png",
    "ppt" => "ppt.png",
    "pptx" => "ppt.png",
    "odp" => "ppt.png",
    "txt" => "txt.png",
    "csv" => "txt.png",
    "jpg" => "img.png",
    "jpeg" => "img.png",
    "png" => "img.png",
    "gif" => "img.png",
    "swf" => "swf.png"
);
