<?php
/**
 * This form serves you to modify the basic configuration of your installation
 */
session_start();

define("ADMIN", true);
define("TITLE_ELEMENT", "Quick installation");
require_once("../common/lib.php");
require_once("../common/setenv.php");
        
$dbsql_file = "../common/db.sql";
$tmp_config_file = "../common/config-tmp.php";
$config_file = "../common/config.php";
$tmp_htaccess_file = "../htaccess.txt";
$htaccess_file = "../.htaccess";
$field_notice = array();
$config_tmp = array();
$db = false;
$db_success = false;
$installed = false;

$config_tmp['site_title'] = "";
$config_tmp['db_name'] = "";
$config_tmp['db_host'] = "localhost";
$config_tmp['db_port'] = "3306";
$config_tmp['db_user'] = "";
$config_tmp['db_pass'] = "";

$email = "";
$user = "";
$password = "";

if(is_file($config_file)){
    require_once($config_file);
    try{
        $db = new db("mysql:host=".DB_HOST.";port=".DB_PORT.";dbname=".DB_NAME.";charset=utf8", DB_USER, DB_PASS);
    }catch(PDOException $e){}
}

if($db !== false && db_table_exists($db, "pm_%") === true){
    $installed = true;
    $_SESSION['msg_notice'] .= "It seems that Pandao CMS is already installed. Remove your former tables from your database to reinstall it <a class=\"btn btn-default\" href=\"login.php\">Log in</a>";
}

if(isset($_POST['install']) && !$installed){
    
    $config_tmp['site_title'] = htmlentities($_POST['site_title'], ENT_QUOTES, "UTF-8");
    $config_tmp['db_name'] = htmlentities($_POST['db_name'], ENT_QUOTES, "UTF-8");
    $config_tmp['db_host'] = htmlentities($_POST['db_host'], ENT_QUOTES, "UTF-8");
    $config_tmp['db_port'] = htmlentities($_POST['db_port'], ENT_QUOTES, "UTF-8");
    $config_tmp['db_user'] = htmlentities($_POST['db_user'], ENT_QUOTES, "UTF-8");
    $config_tmp['db_pass'] = htmlentities($_POST['db_pass'], ENT_QUOTES, "UTF-8");

    $email = htmlentities($_POST['email'], ENT_QUOTES, "UTF-8");
    $user = htmlentities($_POST['user'], ENT_QUOTES, "UTF-8");
    $password = $_POST['password'];
    
    $config_tmp['email'] = $email;
    
    if(check_token("/admin/setup.php", "setup", "post")){
        
        if($config_tmp['db_name'] == "") $field_notice['db_name'] = "Required field";
        if($config_tmp['db_host'] == "") $field_notice['db_host'] = "Required field";
        if($config_tmp['db_port'] == "") $field_notice['db_port'] = "Required field";
        if($config_tmp['db_user'] == "") $field_notice['db_user'] = "Required field";
        if($config_tmp['db_pass'] == "") $field_notice['db_pass'] = "Required field";
    
        if($user == "") $field_notice['user'] = "Required field";
        if($password == "") $field_notice['password'] = "Required field";
        elseif($password != $_POST['password2']) $field_notice['password'] = "The passwords don't match";
        elseif(mb_strlen($password, "UTF-8") < 6) $field_notice['password'] = "The password is too short";
        if($email == "" || !preg_match("/^[\w.-]+@[\w.-]+\.[a-zA-Z]{2,6}$/i", $email)) $field_notice['email'] = "Invalid email address";
        
        if(count($field_notice) == 0){

            try{
                $db = new db("mysql:host=".$config_tmp['db_host'].";port=".$config_tmp['db_port'].";dbname=".$config_tmp['db_name'].";charset=utf8", $config_tmp['db_user'], $config_tmp['db_pass']);
                $db->exec("SET NAMES 'utf8'");
            }catch(PDOException $e){
                $_SESSION['msg_error'] .= "Unable to connect to the database. Please check the database connection parameters.<br>".$e->getMessage()."<br>";
            }
            
            if($db !== false){
                
                if(db_table_exists($db, "pm_%") === false){

                    $dbsql = file_get_contents($dbsql_file);
                    $dbsql = str_replace("MY_DATABASE", $config_tmp['db_name'], $dbsql);
                    $dbsql = str_replace("MY_DB_USER", $config_tmp['db_user'], $dbsql);
                    $dbsql = str_replace("MY_DB_PASS", $config_tmp['db_pass'], $dbsql);
                    $dbsql = str_replace("USER_LOGIN", $user, $dbsql);
                    $dbsql = str_replace("USER_EMAIL", $email, $dbsql);
                    $dbsql = str_replace("USER_PASS", md5($password), $dbsql);
                    $dbsql = str_replace("INSTALL_DATE", time(), $dbsql);

                    if($db->query($dbsql) !== false) $db_success = true;
                }else
                    $db_success = true;

                if($db_success === true){

                    $_SESSION['msg_success'] .= "Congratulations! You have successfully finished the quick installation of your website. Click on <a class=\"btn btn-default\" href=\"login.php\">Log in</a> to begin.<br>";

                    $installed = true;

                    $config_str = file_get_contents($tmp_config_file);
                            
                    foreach($config_tmp as $key => $value){
                        $key = mb_strtoupper($key, "UTF-8");
                        if($value != "")
                            $config_str = preg_replace("/define\((\"|')".$key."(\"|'),\s*(\"|')?([^\n\"']*)(\"|')?\);/", "define(\"".$key."\", \"".$value."\");", $config_str);
                    }
                    
                    if(file_put_contents($config_file, $config_str) === false){
                        $_SESSION['msg_notice'] .= "<b>But... We cannot write into the file common/config.php.<br>";
                        $_SESSION['msg_notice'] .= "To complete the installation, edit manualy this file, copy and past the following lines:</b><br>";
                        $_SESSION['msg_notice'] .= preg_replace("/(\r\n|\n|\r)/", "", nl2br(htmlentities($config_str, ENT_QUOTES, "UTF-8")));
                    }

                    if(!is_file($htaccess_file)){
                        $ht_content = str_replace("{DOCBASE}", DOCBASE, file_get_contents($tmp_htaccess_file));
                        if(file_put_contents($htaccess_file, $ht_content) === false){
                            $_SESSION['msg_notice'] .= "<b>We cannot write into the file .htaccess.<br>";
                            $_SESSION['msg_notice'] .= "To complete the installation, edit manualy this file, copy and past the following lines:</b><br>";
                            $_SESSION['msg_notice'] .= preg_replace("/(\r\n|\n|\r)/", "", nl2br(htmlentities($ht_content, ENT_QUOTES, "UTF-8")));
                        }
                    }
                }else
                    $_SESSION['msg_error'] .= "We cannot modify the database. Try to execute the script common/db.sql in your SQL manager.<br/>";
            }
        }else
            $_SESSION['msg_error'] .= "The following form contains some errors.<br/>";
    }else
        $_SESSION['msg_error'] .= "Bad token! Thank you for re-trying by clicking on \"Install\".<br>";
}

$csrf_token = get_token("setup"); ?>
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
<body class="white">
    <div class="container">
        <div class="alert-container">
            <div class="alert alert-success alert-dismissable"></div>
            <div class="alert alert-warning alert-dismissable"></div>
            <div class="alert alert-danger alert-dismissable"></div>
        </div>
        <?php
        if(!$installed){ ?>
            <h1>Welcome</h1>
            <p>Fill fields with your information. It will take only a few seconds. You can always modify these parameters later.</p>
            <form id="form" class="form-horizontal" role="form" action="setup.php" method="post">
                <input type="hidden" name="csrf_token" value="<?php echo $csrf_token; ?>">
                <fieldset>
                    <legend>Général</legend>
                    <div class="row mb10">
                        <label class="col-md-3 control-label">
                            Site title
                        </label>
                        <div class="col-md-6">
                            <input class="form-control" type="text" value="<?php echo $config_tmp['site_title']; ?>" name="site_title">
                        </div>
                    </div>
                    <div class="row mb10">
                        <label class="col-md-3 control-label">
                            E-mail
                        </label>
                        <div class="col-md-6">
                            <input class="form-control" type="text" value="<?php echo $email; ?>" name="email">
                            <div class="field-notice" rel="email"></div>
                        </div>
                    </div>
                    <div class="row mb10">
                        <label class="col-md-3 control-label">
                            Username
                        </label>
                        <div class="col-md-6">
                            <input class="form-control" type="text" value="<?php echo $user; ?>" name="user">
                            <div class="field-notice" rel="user"></div>
                        </div>
                    </div>
                    <div class="row mb10">
                        <label class="col-md-3 control-label">
                            Password
                        </label>
                        <div class="col-md-3">
                            <input class="form-control" type="password" value="<?php echo $password; ?>" name="password" placeholder="> 5 caracters">
                            <div class="field-notice" rel="password"></div>
                        </div>
                        <div class="col-md-3">
                            <input class="form-control" type="password" value="" name="password2" placeholder="Confirm password">
                        </div>
                    </div>
                </fieldset>
                <fieldset>
                    <legend>Database</legend>
                    <div class="row mb10">
                        <label class="col-md-3 control-label">
                            Name
                        </label>
                        <div class="col-md-6">
                            <input class="form-control" type="text" value="<?php echo $config_tmp['db_name']; ?>" name="db_name">
                            <div class="field-notice" rel="db_name"></div>
                        </div>
                    </div>
                    <div class="row mb10">
                        <label class="col-md-3 control-label">
                            Host
                        </label>
                        <div class="col-md-6">
                            <input class="form-control" type="text" value="<?php echo $config_tmp['db_host']; ?>" name="db_host">
                            <div class="field-notice" rel="db_host"></div>
                        </div>
                    </div>
                    <div class="row mb10">
                        <label class="col-md-3 control-label">
                            Port
                        </label>
                        <div class="col-md-6">
                            <input class="form-control" type="text" value="<?php echo $config_tmp['db_port']; ?>" name="db_port">
                            <div class="field-notice" rel="db_port"></div>
                        </div>
                    </div>
                    <div class="row mb10">
                        <label class="col-md-3 control-label">
                            User
                        </label>
                        <div class="col-md-6">
                            <input class="form-control" type="text" value="<?php echo $config_tmp['db_user']; ?>" name="db_user">
                            <div class="field-notice" rel="db_user"></div>
                        </div>
                    </div>
                    <div class="row mb10">
                        <label class="col-md-3 control-label">
                            Password
                        </label>
                        <div class="col-md-6">
                            <input class="form-control" type="password" value="<?php echo $config_tmp['db_pass']; ?>" name="db_pass">
                            <div class="field-notice" rel="db_pass"></div>
                        </div>
                    </div>
                </fieldset>
                <div class="row mb10">
                    <div class="col-md-9 text-right">
                        <button type="submit" name="install" class="btn btn-default mt15">
                            <i class="fa fa-download"></i> Install
                        </button> 
                    </div>C O D E L I S T . C C
                </div>
            </form>
            <?php
        } ?>
    </div>
</body>
</html>
<?php
$_SESSION['msg_error'] = "";
$_SESSION['msg_success'] = "";
$_SESSION['msg_notice'] = ""; ?>
