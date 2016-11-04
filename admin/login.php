<?php
define("ADMIN", true);
require_once("../common/lib.php");
require_once("../common/define.php");
define("TITLE_ELEMENT", $texts['DASHBOARD']." - ".$texts['LOGIN']);

$action = (isset($_GET['action'])) ? $_GET['action'] : "";

if($db !== false && isset($_POST['login'])){
    $user = htmlentities($_POST['user'], ENT_COMPAT, "UTF-8");
    $password = $_POST['password'];
    
    if(check_token("/".ADMIN_FOLDER."/login.php", "login", "post")){
        
        $result_user = $db->query("SELECT * FROM pm_user WHERE login = ".$db->quote($user)." AND pass = '".md5($password)."' AND checked = 1");
        if($result_user !== false && $db->last_row_count() > 0){
            $row = $result_user->fetch();
            $_SESSION['user']['id'] = $row['id'];
            $_SESSION['user']['login'] = $user;
            $_SESSION['user']['email'] = $row['email'];
            $_SESSION['user']['type'] = $row['type'];
            header("Location: index.php");
            exit();
        }else
            $_SESSION['msg_error'][] = $texts['LOGIN_FAILED'];
    }else
        $_SESSION['msg_error'][] = $texts['BAD_TOKEN2'];
}

if($action == "logout" && isset($_SESSION['user'])) unset($_SESSION['user']);

if($db !== false && isset($_POST['reset'])){
    $email = htmlentities($_POST['email'], ENT_COMPAT, "UTF-8");

    if(check_token("/".ADMIN_FOLDER."/login.php", "login", "post")){

        $result_user = $db->query("SELECT * FROM pm_user WHERE email = ".$db->quote($email)." AND checked = 1");
        if($result_user !== false && $db->last_row_count() > 0){
            $row = $result_user->fetch();
            $url = getUrl();
            $new_pass = genPass(6);
            $mailContent = "
            <p>Сайн байна уу,<br>шинэ нууц үг <a href=\"".$url."\" target=\"_blank\">".$url."</a><br>
            Таны шинэ мэдээлэл<br>
            Хэрэглэгчийн нэр: ".$row['login']."<br>
            Нууц үг: <b>".$new_pass."</b><br>
            Та шинэ нууц үгээ шинэчилнэ үү.</p>";
            if(sendMail($email, $row['name'], "Таны шинэ нууц үг", $mailContent) !== false)
                $db->query("UPDATE pm_user SET pass = '".md5($new_pass)."' WHERE id = ".$row['id']);
        }
        $_SESSION['msg_success'][] = "Таны мэйл хаягруу шинэ нууц үг илгээлээ.<br>";
    }else
        $_SESSION['msg_error'][] = "Буруу холбоос байна дахин оролдоно уу \"Шинэ нууц үг авах\".<br>";
}

$csrf_token = get_token("login"); ?>
<!DOCTYPE html>
<head>
    <?php include("includes/inc_header_common.php"); ?>
</head>
<body class="white">
    <div class="container">
        <form id="form" class="form-horizontal" role="form" action="login.php" method="post">
            <input type="hidden" name="csrf_token" value="<?php echo $csrf_token; ?>">
            <div class="col-sm-3 col-md-4"></div>
            <div class="col-sm-9 col-md-4" id="loginWrapper">
                <div id="login">
                    <div class="alert-container">
                        <div class="alert alert-success alert-dismissable"></div>
                        <div class="alert alert-warning alert-dismissable"></div>
                        <div class="alert alert-danger alert-dismissable"></div>
                    </div>
                    <?php
                    if($action == "reset"){ ?>
                        <p>Мэйл хаягаа оруулна уу. Таны мэйл хаягруу шаардлагатай мэдээллийг илгээх болно.</p>
                        <div class="row">
                            <label class="col-sm-12">
                                И-мэйл хаяг
                            </label>
                        </div>
                        <div class="row mb10">
                            <div class="col-sm-12">
                                <input class="form-control" type="text" value="" name="email">
                            </div>
                        </div>
                        <div class="row mb10">
                            <div class="col-xs-3 text-left">
                                <a href="login.php"><i class="fa fa-power-off"></i> Нэвтрэх</a>
                            </div>
                            <div class="col-xs-9 text-right">
                                <button class="btn btn-default" type="submit" value="" name="reset"><i class="fa fa-refresh"></i> Нууц үг шинэчлэх</button>
                            </div>
                        </div>
                        <?php
                    }else{ ?>
                        <div class="row">
                            <label class="col-sm-12">
                                <?php echo $texts['USERNAME']; ?>
                            </label>
                        </div>
                        <div class="row mb10">
                            <div class="col-sm-12">
                                <input class="form-control" type="text" value="" name="user">
                            </div>
                        </div>
                        <div class="row">
                            <label class="col-sm-12">
                                <?php echo $texts['PASSWORD']; ?>
                            </label>
                        </div>
                        <div class="row mb10">
                            <div class="col-sm-12">
                                <input class="form-control" type="password" value="" name="password">
                            </div>
                        </div>
                        <div class="row mb10">
                            <div class="col-sm-7 text-left">
                                <a href="login.php?action=reset">Нууц үг сэргээх&nbsp;?</a>
                            </div>
                            <div class="col-sm-5 text-right">
                                <button class="btn btn-default" type="submit" value="" name="login"><i class="fa fa-power-off"></i> <?php echo $texts['LOGIN']; ?></button>
                            </div>
                        </div>
                        <?php
                    } ?>
                </div>
            </div>
        </form>
    </div>
</body>
</html>
<?php
$_SESSION['msg_error'] = array();
$_SESSION['msg_success'] = array();
$_SESSION['msg_notice'] = array(); ?>
