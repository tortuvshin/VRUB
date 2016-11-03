<?php
if(!isset($_SESSION['user']) || $_SESSION['user']['type'] != "registered"){
    header("Location: ".DOCBASE);
    exit();
}

$msg_error = "";
$msg_success = "";
$field_notice = array();

$result_user = $db->query("SELECT * FROM pm_user WHERE id = ".$db->quote($_SESSION['user']['id'])." AND checked = 1");
if($result_user !== false && $db->last_row_count() == 1){
    $row = $result_user->fetch();
    
    $name = $row['name'];
    $login = $row['login'];
    $email = $row['email'];
    $address = $row['address'];
    $postcode = $row['postcode'];
    $city = $row['city'];
    $company = $row['company'];
    $country = $row['country'];
    $mobile = $row['mobile'];
    $phone = $row['phone'];
    
}else{
    $name = "";
    $login = "";
    $email = "";
    $address = "";
    $postcode = "";
    $city = "";
    $company = "";
    $country = "";
    $mobile = "";
    $phone = ""; 
}

if(isset($_POST['edit'])){
    
    $name = $_POST['name'];
    $login = $_POST['login'];
    $email = $_POST['email'];
    $address = $_POST['address'];
    $postcode = $_POST['postcode'];
    $city = $_POST['city'];
    $company = $_POST['company'];
    $country = $_POST['country'];
    $mobile = $_POST['mobile'];
    $phone = $_POST['phone'];
    $password = $_POST['password'];
    $password_confirm = $_POST['password_confirm'];
    
    if($name == "") $field_notice['name'] = $texts['REQUIRED_FIELD'];
    if($login == "") $field_notice['login'] = $texts['REQUIRED_FIELD'];
    if($address == "") $field_notice['address'] = $texts['REQUIRED_FIELD'];
    if($postcode == "") $field_notice['postcode'] = $texts['REQUIRED_FIELD'];
    if($city == "") $field_notice['city'] = $texts['REQUIRED_FIELD'];
    if($country == "" || $country == "0") $field_notice['country'] = $texts['REQUIRED_FIELD'];
    if($password != ""){
        if($password_confirm != $password) $field_notice['password_confirm'] = $texts['PASS_DONT_MATCH'];
        if(strlen($password) < 6) $field_notice['password'] = $texts['PASS_TOO_SHORT'];
    }
    if($phone == "" || preg_match("/([0-9\-\s\+\(\)\.]+)/i", $phone) !== 1) $field_notice['phone'] = $texts['REQUIRED_FIELD'];
    if($email == "" || !preg_match("/^[\w.-]+@[\w.-]+\.[a-zA-Z]{2,6}$/i", $email)) $field_notice['email'] = $texts['INVALID_EMAIL'];
    
    $result_exists = $db->query("SELECT * FROM pm_user WHERE id != ".$db->quote($_SESSION['user']['id'])." AND (email = ".$db->quote($email)." OR login = ".$db->quote($login).")");
    if($result_exists !== false && $db->last_row_count() > 0){
        $row = $result_exists->fetch();
        if($email = $row['email']) $field_notice['email'] = $texts['ACCOUNT_EXISTS'];
        if($login = $row['login']) $field_notice['login'] = $texts['USERNAME_EXISTS'];
    }
    
    if(count($field_notice) == 0){

        $data = array();
        $data['id'] = $_SESSION['user']['id'];
        $data['name'] = $name;
        $data['login'] = $login;
        $data['email'] = $email;
        $data['pass'] = md5($password);
        $data['address'] = $address;
        $data['postcode'] = $postcode;
        $data['city'] = $city;
        $data['company'] = $company;
        $data['country'] = $country;
        $data['mobile'] = $mobile;
        $data['phone'] = $phone;
        $data['edit_date'] = time();

        $result_user = db_prepareUpdate($db, "pm_user", $data);
        if($result_user->execute() !== false){
            
            $_SESSION['user']['login'] = $login;
            $_SESSION['user']['email'] = $email;
            
            $msg_success .= $texts['ACCOUNT_EDIT_SUCCESS'];
        }else
            $msg_error .= $texts['ACCOUNT_EDIT_FAILURE'];
    }else
        $msg_error .= $texts['FORM_ERRORS'];
    
}

require(getFromTemplate("common/header.php", false)); ?>

<section id="page">
    
    <?php include(getFromTemplate("common/page_header.php", false)); ?>
    
    <div id="content" class="pt30 pb30">
        <div class="container">

            <div class="alert alert-success" style="display:none;"></div>
            <div class="alert alert-danger" style="display:none;"></div>
            
            <div class="row">
                <form method="post" action="<?php echo DOCBASE.$page['alias']; ?>" role="form">
                    <div class="col-sm-5">
                        <div class="row form-group">
                            <label class="col-lg-3 control-label"><?php echo $texts['FULLNAME']; ?> *</label>
                            <div class="col-lg-9">
                                <input type="text" class="form-control" name="name" value="<?php echo $name; ?>"/>
                                <div class="field-notice" rel="name"></div>
                            </div>
                        </div>
                        <div class="row form-group">
                            <label class="col-lg-3 control-label"><?php echo $texts['USERNAME']; ?> *</label>
                            <div class="col-lg-9">
                                <input type="text" class="form-control" name="login" value="<?php echo $login; ?>"/>
                                <div class="field-notice" rel="login"></div>
                            </div>
                        </div>
                        <div class="row form-group">
                            <label class="col-lg-3 control-label"><?php echo $texts['EMAIL']; ?> *</label>
                            <div class="col-lg-9">
                                <input type="text" class="form-control" name="email" value="<?php echo $email; ?>"/>
                                <div class="field-notice" rel="email"></div>
                            </div>
                        </div>
                        <div class="row form-group">
                            <label class="col-lg-3 control-label"><?php echo $texts['NEW_PASSWORD']; ?></label>
                            <div class="col-lg-9">
                                <input type="password" class="form-control" name="password" value=""/>
                                <div class="field-notice" rel="password"></div>
                            </div>
                        </div>
                        <div class="row form-group">
                            <label class="col-lg-3 control-label"><?php echo $texts['PASSWORD_CONFIRM']; ?></label>
                            <div class="col-lg-9">
                                <input type="password" class="form-control" name="password_confirm" value=""/>
                                <div class="field-notice" rel="password_confirm"></div>
                            </div>
                        </div>
                        <div class="row form-group">
                            <label class="col-lg-3 control-label"><?php echo $texts['COMPANY']; ?></label>
                            <div class="col-lg-9">
                                <input type="text" class="form-control" name="company" value="<?php echo $company; ?>"/>
                                <div class="field-notice" rel="company"></div>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-5">
                        <div class="row form-group">
                            <label class="col-lg-3 control-label"><?php echo $texts['ADDRESS']; ?> *</label>
                            <div class="col-lg-9">
                                <input type="text" class="form-control" name="address" value="<?php echo $address; ?>"/>
                                <div class="field-notice" rel="address"></div>
                            </div>
                        </div>
                        <div class="row form-group">
                            <label class="col-lg-3 control-label"><?php echo $texts['POSTCODE']; ?> *</label>
                            <div class="col-lg-9">
                                <input type="text" class="form-control" name="postcode" value="<?php echo $postcode; ?>"/>
                                <div class="field-notice" rel="postcode"></div>
                            </div>
                        </div>
                        <div class="row form-group">
                            <label class="col-lg-3 control-label"><?php echo $texts['CITY']; ?> *</label>
                            <div class="col-lg-9">
                                <input type="text" class="form-control" name="city" value="<?php echo $city; ?>"/>
                                <div class="field-notice" rel="city"></div>
                            </div>
                        </div>
                        <div class="row form-group">
                            <label class="col-lg-3 control-label"><?php echo $texts['COUNTRY']; ?> *</label>
                            <div class="col-lg-9">
                                <select class="form-control" name="country">
                                    <option value="0">-</option>
                                    <?php
                                    $result_country = $db->query("SELECT * FROM pm_country");
                                    if($result_country !== false){
                                        foreach($result_country as $i => $row){
                                            $id_country = $row['id'];
                                            $country_name = $row['name'];
                                            $selected = ($country == $country_name) ? " selected=\"selected\"" : "";
                                            
                                            echo "<option value=\"".$country_name."\"".$selected.">".$country_name."</option>";
                                        }
                                    } ?>
                                </select>
                                <div class="field-notice" rel="country"></div>
                            </div>
                        </div>
                        <div class="row form-group">
                            <label class="col-lg-3 control-label"><?php echo $texts['PHONE']; ?> *</label>
                            <div class="col-lg-9">
                                <input type="text" class="form-control" name="phone" value="<?php echo $phone; ?>"/>
                                <div class="field-notice" rel="phone"></div>
                            </div>
                        </div>
                        <div class="row form-group">
                            <label class="col-lg-3 control-label"><?php echo $texts['MOBILE']; ?></label>
                            <div class="col-lg-9">
                                <input type="text" class="form-control" name="mobile" value="<?php echo $mobile; ?>"/>
                                <div class="field-notice" rel="mobile"></div>
                            </div>
                        </div>
                        
                        <div class="form-group row">
                            <span class="col-sm-12"><button type="submit" class="btn btn-primary" name="edit"><i class="fa fa-pencil"></i> <?php echo $texts['EDIT']; ?></button> <i> * <?php echo $texts['REQUIRED_FIELD']; ?></i></span>
                        </div>
                    </div>
                </form>
                <div class="col-sm-3">
                    
                </div>
            </div>
        </div>
    </div>
</section>
