<?php
/**
 * This form serves you to modify the basic configuration of your installation
 */
session_start();
if(!isset($_SESSION['user'])){
    header("Location: login.php");
    exit();
}
define("ADMIN", true);
require_once("../common/lib.php");
require_once("../common/setenv.php");
        
$config_file = "../common/config.php";
$field_notice = array();
$config_tmp = array();
$db = false;

require_once("../common/define.php");

$email = $_SESSION['user']['email'];
$user = $_SESSION['user']['login'];
$password = "";

if(isset($_POST['edit_settings'])){
    
    if($_SESSION['user']['type'] == "administrator"){
        $config_tmp['site_title'] = htmlentities($_POST['site_title'], ENT_QUOTES, "UTF-8");
        $config_tmp['time_zone'] = htmlentities($_POST['time_zone'], ENT_QUOTES, "UTF-8");
        $config_tmp['date_format'] = htmlentities($_POST['date_format'], ENT_QUOTES, "UTF-8");
        $config_tmp['time_format'] = htmlentities($_POST['time_format'], ENT_QUOTES, "UTF-8");
        $config_tmp['currency_enabled'] = isset($_POST['currency_enabled']) ? htmlentities($_POST['currency_enabled'], ENT_QUOTES, "UTF-8") : "";
        $config_tmp['lang_enabled'] = isset($_POST['lang_enabled']) ? htmlentities($_POST['lang_enabled'], ENT_QUOTES, "UTF-8") : "";
        $config_tmp['template'] = htmlentities($_POST['template'], ENT_QUOTES, "UTF-8");
        $config_tmp['owner'] = htmlentities($_POST['owner'], ENT_QUOTES, "UTF-8");
        $config_tmp['address'] = preg_replace("/([\n\r])/", "", nl2br(htmlentities($_POST['address'], ENT_QUOTES, "UTF-8")));
        $config_tmp['phone'] = htmlentities($_POST['phone'], ENT_QUOTES, "UTF-8");
        $config_tmp['mobile'] = htmlentities($_POST['mobile'], ENT_QUOTES, "UTF-8");
        $config_tmp['fax'] = htmlentities($_POST['fax'], ENT_QUOTES, "UTF-8");
        $config_tmp['email'] = htmlentities($_POST['email2'], ENT_QUOTES, "UTF-8");
        $config_tmp['db_name'] = htmlentities($_POST['db_name'], ENT_QUOTES, "UTF-8");
        $config_tmp['db_host'] = htmlentities($_POST['db_host'], ENT_QUOTES, "UTF-8");
        $config_tmp['db_port'] = htmlentities($_POST['db_port'], ENT_QUOTES, "UTF-8");
        $config_tmp['db_user'] = htmlentities($_POST['db_user'], ENT_QUOTES, "UTF-8");
        $config_tmp['db_pass'] = $_POST['db_pass'];
        $config_tmp['sender_email'] = htmlentities($_POST['sender_email'], ENT_QUOTES, "UTF-8");
        $config_tmp['sender_name'] = htmlentities($_POST['sender_name'], ENT_QUOTES, "UTF-8");
        $config_tmp['use_smtp'] = isset($_POST['use_smtp']) ? htmlentities($_POST['use_smtp'], ENT_QUOTES, "UTF-8") : 0;
        $config_tmp['smtp_security'] = htmlentities($_POST['smtp_security'], ENT_QUOTES, "UTF-8");
        $config_tmp['smtp_auth'] = isset($_POST['smtp_auth']) ? htmlentities($_POST['smtp_auth'], ENT_QUOTES, "UTF-8") : 0;
        $config_tmp['smtp_host'] = htmlentities($_POST['smtp_host'], ENT_QUOTES, "UTF-8");
        $config_tmp['smtp_user'] = htmlentities($_POST['smtp_user'], ENT_QUOTES, "UTF-8");
        $config_tmp['smtp_pass'] = $_POST['smtp_pass'];
        $config_tmp['smtp_port'] = htmlentities($_POST['smtp_port'], ENT_QUOTES, "UTF-8");
        
        $config_tmp['payment_type'] = htmlentities($_POST['payment_type'], ENT_QUOTES, "UTF-8");
        $config_tmp['enable_down_payment'] = isset($_POST['enable_down_payment']) ? htmlentities($_POST['enable_down_payment'], ENT_QUOTES, "UTF-8") : 0;
        $config_tmp['down_payment_rate'] = htmlentities($_POST['down_payment_rate'], ENT_QUOTES, "UTF-8");
        $config_tmp['tourist_tax'] = htmlentities($_POST['tourist_tax'], ENT_QUOTES, "UTF-8");
        $config_tmp['tourist_tax_type'] = isset($_POST['tourist_tax_type']) ? htmlentities($_POST['tourist_tax_type'], ENT_QUOTES, "UTF-8") : "";
        $config_tmp['allow_comments'] = isset($_POST['allow_comments']) ? htmlentities($_POST['allow_comments'], ENT_QUOTES, "UTF-8") : 0;
        $config_tmp['allow_ratings'] = isset($_POST['allow_ratings']) ? htmlentities($_POST['allow_ratings'], ENT_QUOTES, "UTF-8") : 0;
    }
    $email = htmlentities($_POST['email'], ENT_QUOTES, "UTF-8");
    $user = htmlentities($_POST['user'], ENT_QUOTES, "UTF-8");
    $password = $_POST['password'];

    if(check_token("/admin/settings.php", "settings", "post")){

        if($_SESSION['user']['type'] == "administrator"){
            if($config_tmp['time_zone'] == "") $field_notice['time_zone'] = $texts['REQUIRED_FIELD'];
            if(!is_numeric($config_tmp['lang_enabled'])) $field_notice['lang_enabled'] = $texts['REQUIRED_FIELD'];
            if(!is_numeric($config_tmp['currency_enabled'])) $field_notice['currency_enabled'] = $texts['REQUIRED_FIELD'];
            if($config_tmp['template'] == "") $field_notice['template'] = $texts['REQUIRED_FIELD'];
            if($config_tmp['db_name'] == "") $field_notice['db_name'] = $texts['REQUIRED_FIELD'];
            if($config_tmp['db_host'] == "") $field_notice['db_host'] = $texts['REQUIRED_FIELD'];
            if($config_tmp['db_port'] == "") $field_notice['db_port'] = $texts['REQUIRED_FIELD'];
            if($config_tmp['db_user'] == "") $field_notice['db_user'] = $texts['REQUIRED_FIELD'];
            if($config_tmp['db_pass'] == "") $field_notice['db_pass'] = $texts['REQUIRED_FIELD'];
            
            if($config_tmp['payment_type'] == "") $field_notice['payment_type'] = $texts['REQUIRED_FIELD'];
            if($config_tmp['enable_down_payment'] == "") $field_notice['enable_down_payment'] = $texts['REQUIRED_FIELD'];
            if(!is_numeric($config_tmp['down_payment_rate']) || $config_tmp['down_payment_rate'] < 0) $field_notice['down_payment_rate'] = $texts['REQUIRED_FIELD'];
            if(!is_numeric($config_tmp['tourist_tax']) || $config_tmp['tourist_tax'] < 0) $field_notice['tourist_tax'] = $texts['REQUIRED_FIELD'];
            if($config_tmp['tourist_tax_type'] == "") $field_notice['tourist_tax_type'] = $texts['REQUIRED_FIELD'];
            if($config_tmp['allow_comments'] == "") $field_notice['allow_comments'] = $texts['REQUIRED_FIELD'];
            if($config_tmp['allow_ratings'] == "") $field_notice['allow_ratings'] = $texts['REQUIRED_FIELD'];
            
            if($config_tmp['email'] == "" || !preg_match("/^[\w.-]+@[\w.-]+\.[a-zA-Z]{2,6}$/i", $config_tmp['email'])) $field_notice['email2'] = $texts['INVALID_EMAIL'];
        }
        
        if($user == "") $field_notice['user'] = $texts['REQUIRED_FIELD'];
        if($password != "" && mb_strlen($password, "UTF-8") < 6) $field_notice['password'] = $texts['PASSWORD_TOO_SHORT'];
        elseif($password != $_POST['password2']) $field_notice['password'] = $texts['PASSWORD_DONT_MATCH'];
        
        if($email == "" || !preg_match("/^[\w.-]+@[\w.-]+\.[a-zA-Z]{2,6}$/i", $email)) $field_notice['email'] = $texts['INVALID_EMAIL'];

        $result_user = $db->query("SELECT * FROM pm_user WHERE login = ".$db->quote($user));
        if($result_user === false || $db->last_row_count() > 1) $field_notice['user'] = $texts['USER_EXISTS'];

        if(count($field_notice) == 0){
            
            if($_SESSION['user']['type'] == "administrator"){
                try{
                    $db = new db("mysql:host=".$config_tmp['db_host'].";port=".$config_tmp['db_port'].";dbname=".$config_tmp['db_name'].";charset=utf8", $config_tmp['db_user'], $config_tmp['db_pass']);
                    $db->exec("SET NAMES 'utf8'");
                }catch(PDOException $e){
                    $_SESSION['msg_error'] .= $texts['DATABASE_ERROR'];
                }
            }

            if($db !== false){

                if($_SESSION['user']['type'] == "administrator"){

                    $config_str = file_get_contents($config_file);

                    foreach($config_tmp as $key => $value){
                        $key = mb_strtoupper($key, "UTF-8");
                        $config_str = preg_replace("/define\((\"|')".$key."(\"|'),\s*(\"|')?([^\n\"']*)(\"|')?\);/i", "define(\"".$key."\", \"".$value."\");", $config_str);
                    }

                    if(file_put_contents($config_file, $config_str) === false){
                        $_SESSION['msg_notice'] .= $texts['CONFIG_NOTICE'];
                        $_SESSION['msg_notice'] .= preg_replace("/(\r\n|\n|\r)/", "", nl2br(htmlentities($config_str, ENT_QUOTES, "UTF-8")));
                    }else
                        $_SESSION['msg_success'] .= $texts['CONFIG_SAVED'];
                }
                
                $data = array();
                $data['id'] = $_SESSION['user']['id'];
                $data['login'] = $user;
                $data['email'] = $email;
                if($password != "") $data['pass'] = md5($password);
                
                $result_user = db_prepareUpdate($db, "pm_user", $data);
                if($result_user->execute() !== false){
                    $_SESSION['user']['email'] = $email;
                    $_SESSION['user']['login'] = $user;
                    $_SESSION['msg_success'] .= $texts['PROFILE_SUCCESS'];
                }
                    
                header("Location: settings.php");
                exit();
            }
        }else
            $_SESSION['msg_error'] .= $texts['FORM_ERRORS'];
    }else
        $_SESSION['msg_error'] .= $texts['BAD_TOKEN1'];
}
define("TITLE_ELEMENT", $texts['SETTINGS']);

$config_tmp['site_title'] = SITE_TITLE;
$config_tmp['time_zone'] = TIME_ZONE;
$config_tmp['date_format'] = DATE_FORMAT;
$config_tmp['time_format'] = TIME_FORMAT;
$config_tmp['lang_enabled'] = LANG_ENABLED;
$config_tmp['currency_enabled'] = CURRENCY_ENABLED;
$config_tmp['template'] = TEMPLATE;
$config_tmp['owner'] = OWNER;
$config_tmp['address'] = ADDRESS;
$config_tmp['phone'] = PHONE;
$config_tmp['mobile'] = MOBILE;
$config_tmp['fax'] = FAX;
$config_tmp['email'] = EMAIL;
$config_tmp['db_name'] = DB_NAME;
$config_tmp['db_host'] = DB_HOST;
$config_tmp['db_port'] = DB_PORT;
$config_tmp['db_user'] = DB_USER;
$config_tmp['db_pass'] = DB_PASS;
$config_tmp['sender_email'] = SENDER_EMAIL;
$config_tmp['sender_name'] = SENDER_NAME;
$config_tmp['use_smtp'] = USE_SMTP;
$config_tmp['smtp_security'] = SMTP_SECURITY;
$config_tmp['smtp_auth'] = SMTP_AUTH;
$config_tmp['smtp_host'] = SMTP_HOST;
$config_tmp['smtp_user'] = SMTP_USER;
$config_tmp['smtp_pass'] = SMTP_PASS;
$config_tmp['smtp_port'] = SMTP_PORT;

$config_tmp['payment_type'] = PAYMENT_TYPE;
$config_tmp['enable_down_payment'] = ENABLE_DOWN_PAYMENT;
$config_tmp['down_payment_rate'] = DOWN_PAYMENT_RATE;
$config_tmp['tourist_tax'] = TOURIST_TAX;
$config_tmp['tourist_tax_type'] = TOURIST_TAX_TYPE;
$config_tmp['allow_comments'] = ALLOW_COMMENTS;
$config_tmp['allow_ratings'] = ALLOW_RATINGS;

require_once("includes/fn_module.php");
$csrf_token = get_token("settings"); ?>
<!DOCTYPE html>
<head>
    <?php include("includes/inc_header_common.php"); ?>
     <script>
        $(function(){
            $('#db_name').bind('blur keyup', function(){
                $('#db_user').val($(this).val());
            });
            <?php foreach($field_notice as $field => $notice) echo "$('.field-notice[rel=\"".$field."\"]').html('".addslashes($notice)."').fadeIn('slow').parent().addClass('alert alert-danger');\n"; ?>
        });
    </script>
</head>
<body>
    <div id="overlay"><div id="loading"></div></div>
    <div id="wrapper">
        <?php include(SYSBASE."admin/includes/inc_top.php"); ?>
        
        <form id="form" class="form-horizontal" role="form" action="settings.php" method="post" enctype="multipart/form-data">
            <input type="hidden" name="csrf_token" value="<?php echo $csrf_token; ?>">
            <div id="page-wrapper">
                <div class="page-header">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-xs-6 col-md-6 col-sm-8 clearfix">
                                <h1 class="pull-left"><i class="fa fa-cog"></i> <?php echo TITLE_ELEMENT; ?></h1>
                            </div>
                            <div class="col-xs-6 col-md-6 col-sm-4 clearfix pb15 text-right">
                                <button type="submit" name="edit_settings" class="btn btn-success mt15">
                                    <i class="fa fa-floppy-o"></i> <?php echo $texts['SAVE']; ?>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="container-fluid">
                <div class="alert-container">
                    <div class="alert alert-success alert-dismissable"></div>
                    <div class="alert alert-warning alert-dismissable"></div>
                    <div class="alert alert-danger alert-dismissable"></div>
                </div>
                <div class="panel panel-default">
                    <ul class="nav nav-tabs pt5">
                        <?php
                        if($_SESSION['user']['type'] == "administrator"){ ?>
                            <li class="active"><a data-toggle="tab" href="#general"><i class="fa fa-cog"></i> <?php echo $texts['GENERAL']; ?></a></li>
                            <li><a data-toggle="tab" href="#contact"><i class="fa fa-phone-square"></i> <?php echo $texts['CONTACT']; ?></a></li>
                            <li><a data-toggle="tab" href="#database"><i class="fa fa-database"></i> <?php echo $texts['DATABASE']; ?></a></li>
                            <li><a data-toggle="tab" href="#email_settings"><i class="fa fa-envelope"></i> <?php echo $texts['EMAIL_SETTINGS']; ?></a></li>
                            <?php
                        } ?>
                        <li<?php if($_SESSION['user']['type'] != "administrator") echo " class=\"active\""; ?>>
                            <a data-toggle="tab" href="#profile"><i class="fa fa-user"></i> <?php echo $texts['PROFILE']; ?></a>
                        </li>
                        <?php
                        if($_SESSION['user']['type'] == "administrator"){ ?>
                            <li><a data-toggle="tab" href="#booking"><i class="fa fa-calendar"></i> <?php echo $texts['BOOKING']; ?></a></li>
                            <?php
                        } ?>
                    </ul>
                    <div class="panel-body">
                        <div class="tab-content">
                            <?php
                            if($_SESSION['user']['type'] == "administrator"){ ?>
                                <div id="general" class="tab-pane fade in active">
                                    <div class="row mb10">
                                        <div class="col-md-8">
                                            <div class="row">
                                                <label class="col-md-3 control-label">
                                                    <?php echo $texts['SITE_TITLE']; ?>
                                                </label>
                                                <div class="col-md-8">
                                                    <input class="form-control" type="text" value="<?php echo $config_tmp['site_title']; ?>" name="site_title">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row mb10">
                                        <label class="col-md-2 control-label">
                                            <?php echo $texts['ENABLE_LANGUAGES']; ?> <span class="red">*</span>
                                        </label>
                                        <div class="col-md-6">
                                            <label class="radio-inline">
                                                <input name="lang_enabled" type="radio" value="0"<?php if($config_tmp['lang_enabled'] == 0) echo " checked=\"checked\""; ?>>&nbsp;<?php echo $texts['NO_OPTION']; ?><br>
                                            </label>
                                            <label class="radio-inline">
                                                <input name="lang_enabled" type="radio" value="1"<?php if($config_tmp['lang_enabled'] == 1) echo " checked=\"checked\""; ?>>&nbsp;<?php echo $texts['YES_OPTION']; ?><br>
                                            </label>
                                            <div class="field-notice" rel="lang_enabled"></div>
                                        </div>
                                    </div>
                                    <div class="row mb10">
                                        <label class="col-md-2 control-label">
                                            <?php echo $texts['ENABLE_CURRENCIES']; ?> <span class="red">*</span>
                                        </label>
                                        <div class="col-md-6">
                                            <label class="radio-inline">
                                                <input name="currency_enabled" type="radio" value="0"<?php if($config_tmp['currency_enabled'] == 0) echo " checked=\"checked\""; ?>>&nbsp;<?php echo $texts['NO_OPTION']; ?><br>
                                            </label>
                                            <label class="radio-inline">
                                                <input name="currency_enabled" type="radio" value="1"<?php if($config_tmp['currency_enabled'] == 1) echo " checked=\"checked\""; ?>>&nbsp;<?php echo $texts['YES_OPTION']; ?><br>
                                            </label>
                                            <div class="field-notice" rel="currency_enabled"></div>
                                        </div>
                                    </div>
                                    <div class="row mb10">
                                        <div class="col-md-8">
                                            <div class="row">
                                                <label class="col-md-3 control-label">
                                                    <?php echo $texts['TEMPLATE']; ?> <span class="red">*</span>
                                                </label>
                                                <div class="col-md-8">
                                                    <div class="form-inline">
                                                        <select name="template" class="form-control">
                                                            <?php
                                                            $dir = "../templates/";
                                                            $rep = opendir($dir) or die("Error directory opening : ".$dir);
                                                            while($entry = @readdir($rep)){
                                                                if(is_dir($dir."/".$entry) && $entry != "." && $entry != ".."){
                                                                    $selected = ($config_tmp['template'] == $entry) ? " selected=\"selected\"" : ""; ?>
                                                                    <option value="<?php echo $entry; ?>"<?php echo $selected; ?>><?php echo $entry; ?></option>
                                                                    <?php
                                                                }
                                                            } ?>
                                                        </select>
                                                        <div class="field-notice" rel="template"></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row mb10">
                                        <div class="col-md-8">
                                            <div class="row">
                                                <label class="col-md-3 control-label">
                                                    <?php echo $texts['TIME_ZONE']; ?> <span class="red">*</span>
                                                </label>
                                                <div class="col-md-8">
                                                    <input class="form-control" type="text" value="<?php echo $config_tmp['time_zone']; ?>" name="time_zone">
                                                    <div class="field-notice" rel="time_zone"></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row mb10">
                                        <div class="col-md-8">
                                            <div class="row">
                                                <label class="col-md-3 control-label">
                                                    <?php echo $texts['DATE_FORMAT']; ?> <span class="red">*</span>
                                                </label>
                                                <div class="col-md-8">
                                                    <div class="form-inline">
                                                        <select name="date_format" class="form-control">
                                                            <option value="%e %B %Y"<?php if($config_tmp['date_format'] == "%e %B %Y") echo " selected=\"selected\""; ?>><?php echo strftime("%e %B %Y"); ?></option>
                                                            <option value="%e %b %Y"<?php if($config_tmp['date_format'] == "%e %b %Y") echo " selected=\"selected\""; ?>><?php echo strftime("%e %b %Y"); ?></option>
                                                            <option value="%B %e, %Y"<?php if($config_tmp['date_format'] == "%B %e, %Y") echo " selected=\"selected\""; ?>><?php echo strftime("%B %e, %Y"); ?></option>
                                                            <option value="%b %e, %Y"<?php if($config_tmp['date_format'] == "%b %e, %Y") echo " selected=\"selected\""; ?>><?php echo strftime("%b %e, %Y"); ?></option>
                                                            <option value="%A %e %B %Y"<?php if($config_tmp['date_format'] == "%A %e %B %Y") echo " selected=\"selected\""; ?>><?php echo strftime("%A %e %B %Y"); ?></option>
                                                            <option value="%a %e %b %Y"<?php if($config_tmp['date_format'] == "%a %e %b %Y") echo " selected=\"selected\""; ?>><?php echo strftime("%a %e %b %Y"); ?></option>
                                                            <option value="%A %B %e, %Y"<?php if($config_tmp['date_format'] == "%A %B %e, %Y") echo " selected=\"selected\""; ?>><?php echo strftime("%A %B %e, %Y"); ?></option>
                                                            <option value="%a %b %e, %y"<?php if($config_tmp['date_format'] == "%a %b %e, %y") echo " selected=\"selected\""; ?>><?php echo strftime("%a %b %e, %y"); ?></option>
                                                            <option value="%F"<?php if($config_tmp['date_format'] == "%F") echo " selected=\"selected\""; ?>><?php echo strftime("%F"); ?></option>
                                                            <option value="%Y/%m/%d"<?php if($config_tmp['date_format'] == "%Y/%m/%d") echo " selected=\"selected\""; ?>><?php echo strftime("%Y/%m/%d"); ?></option>
                                                            <option value="%m/%d/%Y"<?php if($config_tmp['date_format'] == "%m/%d/%Y") echo " selected=\"selected\""; ?>><?php echo strftime("%m/%d/%Y"); ?></option>
                                                            <option value="%d/%m/%Y"<?php if($config_tmp['date_format'] == "%d/%m/%Y") echo " selected=\"selected\""; ?>><?php echo strftime("%d/%m/%Y"); ?></option>
                                                            <option value="%d-%m-%Y"<?php if($config_tmp['date_format'] == "%d-%m-%Y") echo " selected=\"selected\""; ?>><?php echo strftime("%d-%m-%Y"); ?></option>
                                                        </select>
                                                    </div>
                                                    <div class="field-notice" rel="date_format"></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row mb10">
                                        <div class="col-md-8">
                                            <div class="row">
                                                <label class="col-md-3 control-label">
                                                    <?php echo $texts['TIME_FORMAT']; ?> <span class="red">*</span>
                                                </label>
                                                <div class="col-md-8">
                                                    <div class="form-inline">
                                                        <select name="time_format" class="form-control">
                                                            <option value="%l:%M%P"<?php if($config_tmp['time_format'] == "%l:%M%P") echo " selected=\"selected\""; ?>><?php echo strftime("%l:%M%P"); ?></option>
                                                            <option value="%R"<?php if($config_tmp['time_format'] == "%R") echo " selected=\"selected\""; ?>><?php echo strftime("%R"); ?></option>
                                                            <option value="%Hh%M"<?php if($config_tmp['time_format'] == "%Hh%M") echo " selected=\"selected\""; ?>><?php echo strftime("%Hh%M"); ?></option>
                                                        </select>
                                                    </div>
                                                    <div class="field-notice" rel="time_format"></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div id="contact" class="tab-pane fade">
                                    <div class="row mb10">
                                        <div class="col-md-8">
                                            <div class="row">
                                                <label class="col-md-3 control-label">
                                                    <?php echo $texts['NAME']; ?>
                                                </label>
                                                <div class="col-md-8">
                                                    <input class="form-control" type="text" value="<?php echo $config_tmp['owner']; ?>" name="owner">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row mb10">
                                        <div class="col-md-8">
                                            <div class="row">
                                                <label class="col-md-3 control-label">
                                                    <?php echo $texts['ADDRESS']; ?>
                                                </label>
                                                <div class="col-md-8">
                                                    <textarea class="form-control" name="address"><?php echo br2nl($config_tmp['address']); ?></textarea>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row mb10">
                                        <div class="col-md-8">
                                            <div class="row">
                                                <label class="col-md-3 control-label">
                                                    <?php echo $texts['PHONE']; ?>
                                                </label>
                                                <div class="col-md-8">
                                                    <input class="form-control" type="text" value="<?php echo $config_tmp['phone']; ?>" name="phone">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row mb10">
                                        <div class="col-md-8">
                                            <div class="row">
                                                <label class="col-md-3 control-label">
                                                    <?php echo $texts['MOBILE']; ?>
                                                </label>
                                                <div class="col-md-8">
                                                    <input class="form-control" type="text" value="<?php echo $config_tmp['mobile']; ?>" name="mobile">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row mb10">
                                        <div class="col-md-8">
                                            <div class="row">
                                                <label class="col-md-3 control-label">
                                                    <?php echo $texts['FAX']; ?>
                                                </label>
                                                <div class="col-md-8">
                                                    <input class="form-control" type="text" value="<?php echo $config_tmp['fax']; ?>" name="fax">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row mb10">
                                        <div class="col-md-8">
                                            <div class="row">
                                                <label class="col-md-3 control-label">
                                                    <?php echo $texts['EMAIL']; ?>
                                                </label>
                                                <div class="col-md-8">
                                                    <input class="form-control" type="text" value="<?php echo $config_tmp['email']; ?>" name="email2">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div id="database" class="tab-pane fade">
                                    <div class="row mb10">
                                        <div class="col-md-8">
                                            <div class="row">
                                                <label class="col-md-3 control-label">
                                                    <?php echo $texts['NAME']; ?> <span class="red">*</span>
                                                </label>
                                                <div class="col-md-8">
                                                    <input class="form-control" type="text" value="<?php echo $config_tmp['db_name']; ?>" name="db_name">
                                                    <div class="field-notice" rel="db_name"></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row mb10">
                                        <div class="col-md-8">
                                            <div class="row">
                                                <label class="col-md-3 control-label">
                                                    <?php echo $texts['HOST']; ?> <span class="red">*</span>
                                                </label>
                                                <div class="col-md-8">
                                                    <input class="form-control" type="text" value="<?php echo $config_tmp['db_host']; ?>" name="db_host">
                                                    <div class="field-notice" rel="db_host"></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row mb10">
                                        <div class="col-md-8">
                                            <div class="row">
                                                <label class="col-md-3 control-label">
                                                    <?php echo $texts['PORT']; ?> <span class="red">*</span>
                                                </label>
                                                <div class="col-md-8">
                                                    <input class="form-control" type="text" value="<?php echo $config_tmp['db_port']; ?>" name="db_port">
                                                    <div class="field-notice" rel="db_port"></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row mb10">
                                        <div class="col-md-8">
                                            <div class="row">
                                                <label class="col-md-3 control-label">
                                                    <?php echo $texts['USER']; ?> <span class="red">*</span>
                                                </label>
                                                <div class="col-md-8">
                                                    <input class="form-control" type="text" value="<?php echo $config_tmp['db_user']; ?>" name="db_user">
                                                    <div class="field-notice" rel="db_user"></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row mb10">
                                        <div class="col-md-8">
                                            <div class="row">
                                                <label class="col-md-3 control-label">
                                                    <?php echo $texts['PASSWORD']; ?> <span class="red">*</span>
                                                </label>
                                                <div class="col-md-8">
                                                    <input class="form-control" type="password" value="<?php echo $config_tmp['db_pass']; ?>" name="db_pass">
                                                    <div class="field-notice" rel="db_pass"></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div id="email_settings" class="tab-pane fade">
                                    <div class="row mb10">
                                        <div class="col-md-8">
                                            <div class="row">
                                                <label class="col-md-3 control-label">
                                                    <?php echo $texts['SENDER_EMAIL']; ?>
                                                </label>
                                                <div class="col-md-8">
                                                    <input class="form-control" type="text" value="<?php echo $config_tmp['sender_email']; ?>" name="sender_email">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row mb10">
                                        <div class="col-md-8">
                                            <div class="row">
                                                <label class="col-md-3 control-label">
                                                    <?php echo $texts['SENDER_NAME']; ?>
                                                </label>
                                                <div class="col-md-8">
                                                    <input class="form-control" type="text" value="<?php echo $config_tmp['sender_name']; ?>" name="sender_name">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row mb10">
                                        <div class="col-md-8">
                                            <div class="row">
                                                <label class="col-md-3 control-label">
                                                    <?php echo $texts['USE_SMTP']; ?>
                                                </label>
                                                <div class="col-md-8">
                                                    <label class="radio-inline">
                                                        <input name="use_smtp" type="radio" value="0"<?php if($config_tmp['use_smtp'] == 0) echo " checked=\"checked\""; ?>>&nbsp;<?php echo $texts['NO_OPTION']; ?><br>
                                                    </label>
                                                    <label class="radio-inline">
                                                        <input name="use_smtp" type="radio" value="1"<?php if($config_tmp['use_smtp'] == 1) echo " checked=\"checked\""; ?>>&nbsp;<?php echo $texts['YES_OPTION']; ?><br>
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row mb10">
                                        <div class="col-md-8">
                                            <div class="row">
                                                <label class="col-md-3 control-label">
                                                    <?php echo $texts['SMTP_SECURITY']; ?>
                                                </label>
                                                <div class="col-md-8">
                                                    <div class="form-inline">
                                                        <select class="form-control" name="smtp_security">
                                                            <option value=""<?php if($config_tmp['smtp_security'] == "") echo " selected=\"selected\""; ?>>None</option>
                                                            <option value="ssl"<?php if($config_tmp['smtp_security'] == "ssl") echo " selected=\"selected\""; ?>>SSL</option>
                                                            <option value="tls"<?php if($config_tmp['smtp_security'] == "tls") echo " selected=\"selected\""; ?>>TLS</option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row mb10">
                                        <div class="col-md-8">
                                            <div class="row">
                                                <label class="col-md-3 control-label">
                                                    <?php echo $texts['SMTP_AUTH']; ?>
                                                </label>
                                                <div class="col-md-8">
                                                    <label class="radio-inline">
                                                        <input name="smtp_auth" type="radio" value="0"<?php if($config_tmp['smtp_auth'] == 0) echo " checked=\"checked\""; ?>>&nbsp;<?php echo $texts['NO_OPTION']; ?><br>
                                                    </label>
                                                    <label class="radio-inline">
                                                        <input name="smtp_auth" type="radio" value="1"<?php if($config_tmp['smtp_auth'] == 1) echo " checked=\"checked\""; ?>>&nbsp;<?php echo $texts['YES_OPTION']; ?><br>
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row mb10">
                                        <div class="col-md-8">
                                            <div class="row">
                                                <label class="col-md-3 control-label">
                                                    <?php echo $texts['SMTP_HOST']; ?>
                                                </label>
                                                <div class="col-md-8">
                                                    <input class="form-control" type="text" value="<?php echo $config_tmp['smtp_host']; ?>" name="smtp_host">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row mb10">
                                        <div class="col-md-8">
                                            <div class="row">
                                                <label class="col-md-3 control-label">
                                                    <?php echo $texts['SMTP_PORT']; ?>
                                                </label>
                                                <div class="col-md-8">
                                                    <input class="form-control" type="text" value="<?php echo $config_tmp['smtp_port']; ?>" name="smtp_port">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row mb10">
                                        <div class="col-md-8">
                                            <div class="row">
                                                <label class="col-md-3 control-label">
                                                    <?php echo $texts['SMTP_USER']; ?>
                                                </label>
                                                <div class="col-md-8">
                                                    <input class="form-control" type="text" value="<?php echo $config_tmp['smtp_user']; ?>" name="smtp_user">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row mb10">
                                        <div class="col-md-8">
                                            <div class="row">
                                                <label class="col-md-3 control-label">
                                                    <?php echo $texts['SMTP_PASS']; ?>
                                                </label>
                                                <div class="col-md-8">
                                                    <input class="form-control" type="password" value="<?php echo $config_tmp['smtp_pass']; ?>" name="smtp_pass">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <?php
                            } ?>
                            <div id="profile" class="tab-pane fade<?php if($_SESSION['user']['type'] != "administrator") echo " in active"; ?>">
                                <div class="row mb10">
                                    <div class="col-md-8">
                                        <div class="row">
                                            <label class="col-md-3 control-label">
                                                <?php echo $texts['USER']; ?> <span class="red">*</span>
                                            </label>
                                            <div class="col-md-8">
                                                <input class="form-control" type="text" value="<?php echo $user; ?>" name="user">
                                                <div class="field-notice" rel="user"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row mb10">
                                    <div class="col-md-8">
                                        <div class="row">
                                            <label class="col-md-3 control-label">
                                                <?php echo $texts['PASSWORD']; ?>
                                            </label>
                                            <div class="col-md-4">
                                                <input class="form-control" type="password" value="<?php echo $password; ?>" name="password" placeholder="<?php echo $texts['PASSWORD_NOTICE']; ?>">
                                                <div class="field-notice" rel="password"></div>
                                            </div>
                                            <div class="col-md-4">
                                                <input class="form-control" type="password" value="" name="password2" placeholder="<?php echo $texts['PASSWORD_CONFIRM']; ?>">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row mb10">
                                    <div class="col-md-8">
                                        <div class="row">
                                            <label class="col-md-3 control-label">
                                                <?php echo $texts['EMAIL']; ?> <span class="red">*</span>
                                            </label>
                                            <div class="col-md-8">
                                                <input class="form-control" type="text" value="<?php echo $email; ?>" name="email">
                                                <div class="field-notice" rel="email"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <?php
                            if($_SESSION['user']['type'] == "administrator"){ ?>
                                <div id="booking" class="tab-pane fade">
                                    <div class="row mb10">
                                        <div class="col-md-8">
                                            <div class="row">
                                                <label class="col-md-3 control-label">
                                                    <?php echo $texts['PAYMENT_TYPE']; ?> <span class="red">*</span>
                                                </label>
                                                <div class="col-md-8">
                                                    <div class="form-inline">
                                                        <select class="form-control" name="payment_type">
                                                            <option value="paypal"<?php if($config_tmp['payment_type'] == "paypal") echo " selected=\"selected\""; ?>>PayPal</option>
                                                            <option value="check"<?php if($config_tmp['payment_type'] == "check") echo " selected=\"selected\""; ?>>Check</option>
                                                            <option value="arrival"<?php if($config_tmp['payment_type'] == "arrival") echo " selected=\"selected\""; ?>>On arrival</option>
                                                        </select>
                                                        <div class="field-notice" rel="payment_type"></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row mb10">
                                        <div class="col-md-8">
                                            <div class="row">
                                                <label class="col-md-3 control-label">
                                                    <?php echo $texts['ENABLE_DOWN_PAYMENT']; ?> <span class="red">*</span>
                                                </label>
                                                <div class="col-md-8">
                                                    <div class="form-inline">
                                                        <label class="radio-inline">
                                                            <input type="radio" name="enable_down_payment" value="1"<?php if($config_tmp['enable_down_payment'] == "1") echo " checked=\"checked\""; ?>> <?php echo $texts['YES_OPTION']; ?><br>
                                                        </label>
                                                        <label class="radio-inline">
                                                            <input type="radio" name="enable_down_payment" value="0"<?php if($config_tmp['enable_down_payment'] == "0") echo " checked=\"checked\""; ?>> <?php echo $texts['NO_OPTION']; ?>
                                                        </label>
                                                        <div class="field-notice" rel="enable_down_payment"></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row mb10">
                                        <div class="col-md-8">
                                            <div class="row">
                                                <label class="col-md-3 control-label">
                                                    <?php echo $texts['DOWN_PAYMENT_RATE']; ?> <span class="red">*</span>
                                                </label>
                                                <div class="col-md-8">
                                                    <div class="form-inline">
                                                        <input class="form-control" type="text" value="<?php echo $config_tmp['down_payment_rate']; ?>" name="down_payment_rate">
                                                        <div class="field-notice" rel="down_payment_rate"></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="pt5 pb5 bg-info text-info">
                                                <i class="fa fa-info"></i> %
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row mb10">
                                        <div class="col-md-8">
                                            <div class="row">
                                                <label class="col-md-3 control-label">
                                                    <?php echo $texts['TOURIST_TAX']; ?> <span class="red">*</span>
                                                </label>
                                                <div class="col-md-8">
                                                    <div class="form-inline">
                                                        <input class="form-control" type="text" value="<?php echo $config_tmp['tourist_tax']; ?>" name="tourist_tax">
                                                        <label class="radio-inline">
                                                            <input type="radio" name="tourist_tax_type" value="fixed"<?php if($config_tmp['tourist_tax_type'] == "fixed") echo " checked=\"checked\""; ?>> <?php echo CURRENCY_SIGN." ".$texts['FIXED_OPTION']; ?><br>
                                                        </label>
                                                        <label class="radio-inline">
                                                            <input type="radio" name="tourist_tax_type" value="rate"<?php if($config_tmp['tourist_tax_type'] == "rate") echo " checked=\"checked\""; ?>> <?php echo $texts['RATE_OPTION']; ?>
                                                        </label>
                                                        <div class="field-notice" rel="tourist_tax"></div>
                                                        <div class="field-notice" rel="tourist_tax_type"></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row mb10">
                                        <div class="col-md-8">
                                            <div class="row">
                                                <label class="col-md-3 control-label">
                                                    <?php echo $texts['ALLOW_COMMENTS']; ?> <span class="red">*</span>
                                                </label>
                                                <div class="col-md-8">
                                                    <div class="form-inline">
                                                        <label class="radio-inline">
                                                            <input type="radio" name="allow_comments" value="1"<?php if($config_tmp['allow_comments'] == "1") echo " checked=\"checked\""; ?>> <?php echo $texts['YES_OPTION']; ?><br>
                                                        </label>
                                                        <label class="radio-inline">
                                                            <input type="radio" name="allow_comments" value="0"<?php if($config_tmp['allow_comments'] == "0") echo " checked=\"checked\""; ?>> <?php echo $texts['NO_OPTION']; ?>
                                                        </label>
                                                        <div class="field-notice" rel="allow_comments"></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row mb10">
                                        <div class="col-md-8">
                                            <div class="row">
                                                <label class="col-md-3 control-label">
                                                    <?php echo $texts['ALLOW_RATINGS']; ?> <span class="red">*</span>
                                                </label>
                                                <div class="col-md-8">
                                                    <div class="form-inline">
                                                        <label class="radio-inline">
                                                            <input type="radio" name="allow_ratings" value="1"<?php if($config_tmp['allow_ratings'] == "1") echo " checked=\"checked\""; ?>> <?php echo $texts['YES_OPTION']; ?><br>
                                                        </label>
                                                        <label class="radio-inline">
                                                            <input type="radio" name="allow_ratings" value="0"<?php if($config_tmp['allow_ratings'] == "0") echo " checked=\"checked\""; ?>> <?php echo $texts['NO_OPTION']; ?>
                                                        </label>
                                                        <div class="field-notice" rel="allow_ratings"></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="pt5 pb5 bg-info text-info">
                                                <i class="fa fa-info"></i> <?php echo $texts['ALLOW_RATINGS_NOTICE']; ?>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <?php
                            } ?>
                        </div>
                    </div>
                    <div class="panel-footer"></div>
                </div>
            </div>
        </form>
    </div>
</body>
</html>
<?php
$_SESSION['msg_error'] = "";
$_SESSION['msg_success'] = "";
$_SESSION['msg_notice'] = ""; ?>
