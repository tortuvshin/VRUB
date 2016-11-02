<?php
if(!isset($_SESSION['book']) || count($_SESSION['book']) == 0){
    header("Location: ".DOCBASE.$sys_pages['booking']['alias']);
    exit();
}

$msg_error = "";
$msg_success = "";
$field_notice = array();

$id = 0;
$lastname = isset($_SESSION['book']['lastname']) ? $_SESSION['book']['lastname'] : "";
$firstname = isset($_SESSION['book']['firstname']) ? $_SESSION['book']['firstname'] : "";
$email = isset($_SESSION['book']['email']) ? $_SESSION['book']['email'] : "";
$address = isset($_SESSION['book']['address']) ? $_SESSION['book']['address'] : "";
$postcode = isset($_SESSION['book']['postcode']) ? $_SESSION['book']['postcode'] : "";
$city = isset($_SESSION['book']['city']) ? $_SESSION['book']['city'] : "";
$company = isset($_SESSION['book']['company']) ? $_SESSION['book']['company'] : "";
$country = isset($_SESSION['book']['country']) ? $_SESSION['book']['country'] : "";
$mobile = isset($_SESSION['book']['mobile']) ? $_SESSION['book']['mobile'] : "";
$phone = isset($_SESSION['book']['phone']) ? $_SESSION['book']['phone'] : "";
$comments = isset($_SESSION['book']['comments']) ? $_SESSION['book']['comments'] : "";

if(isset($_POST['book'])){
    
    $lastname = $_POST['lastname'];
    $firstname = $_POST['firstname'];
    $email = $_POST['email'];
    $address = $_POST['address'];
    $postcode = $_POST['postcode'];
    $city = $_POST['city'];
    $company = $_POST['company'];
    $country = $_POST['country'];
    $mobile = $_POST['mobile'];
    $phone = $_POST['phone'];
    $comments = $_POST['comments'];
    
    if($lastname == "") $field_notice['lastname'] = $texts['REQUIRED_FIELD'];
    if($firstname == "") $field_notice['firstname'] = $texts['REQUIRED_FIELD'];
    if($email == "") $field_notice['email'] = $texts['REQUIRED_FIELD'];
    if($address == "") $field_notice['address'] = $texts['REQUIRED_FIELD'];
    if($postcode == "") $field_notice['postcode'] = $texts['REQUIRED_FIELD'];
    if($city == "") $field_notice['city'] = $texts['REQUIRED_FIELD'];
    if($country == "") $field_notice['country'] = $texts['REQUIRED_FIELD'];
    if($phone == "" || preg_match("/([0-9\-\s\+\(\)\.]+)/i", $phone) !== 1) $field_notice['phone'] = $texts['REQUIRED_FIELD'];
    
    if(count($field_notice) == 0){

        $_SESSION['book']['lastname'] = $lastname;
        $_SESSION['book']['firstname'] = $firstname;
        $_SESSION['book']['email'] = $email;
        $_SESSION['book']['company'] = $company;
        $_SESSION['book']['address'] = $address;
        $_SESSION['book']['postcode'] = $postcode;
        $_SESSION['book']['city'] = $city;
        $_SESSION['book']['phone'] = $phone;
        $_SESSION['book']['mobile'] = $mobile;
        $_SESSION['book']['country'] = $country;
        $_SESSION['book']['comments'] = $comments;
        
        if(isset($_SESSION['book']['id'])) unset($_SESSION['book']['id']);

        header("Location: ".DOCBASE.$sys_pages['summary']['alias']);
        exit();

    }else
        $msg_error .= $texts['FORM_ERRORS'];
}

require(SYSBASE."templates/".TEMPLATE."/common/header.php"); ?>

<section id="page">
    
    <?php include(SYSBASE."templates/".TEMPLATE."/common/page_header.php"); ?>
    
    <div id="content" class="pt30 pb30">
        <div class="container">

            <div class="alert alert-success" style="display:none;"></div>
            <div class="alert alert-danger" style="display:none;"></div>
            
            <div class="row mb30" id="booking-breadcrumb">
                <div class="col-xs-3">
                    <a href="<?php echo DOCBASE.$sys_pages['booking']['alias']; ?>">
                        <div class="breadcrumb-item done">
                            <i class="fa fa-calendar"></i>
                            <span><?php echo $sys_pages['booking']['name']; ?></span>
                        </div>
                    </a>
                </div>
                <div class="col-xs-3">
                    <div class="breadcrumb-item active">
                        <i class="fa fa-info-circle"></i>
                        <span><?php echo $sys_pages['details']['name']; ?></span>
                    </div>
                </div>
                <div class="col-xs-3">
                    <div class="breadcrumb-item">
                        <i class="fa fa-list"></i>
                        <span><?php echo $sys_pages['summary']['name']; ?></span>
                    </div>
                </div>
                <div class="col-xs-3">
                    <div class="breadcrumb-item">
                        <i class="fa fa-credit-card"></i>
                        <span><?php echo $sys_pages['payment']['name']; ?></span>
                    </div>
                </div>
            </div>
            
            <?php
            if($page['text'] != ""){ ?>
                <div class="clearfix mb20"><?php echo $page['text']; ?></div>
                <?php
            } ?>
            
            <form method="post" action="" class="ajax-form">
                <div class="row">
                    <div class="col-md-6">
                        <fieldset>
                            <legend><?php echo $texts['CONTACT_DETAILS']; ?></legend>
            
                            <div class="row form-group">
                                <label class="col-lg-3 control-label"><?php echo $texts['LASTNAME']; ?> *</label>
                                <div class="col-lg-9">
                                    <input type="text" class="form-control" name="lastname" value="<?php echo $lastname; ?>"/>
                                    <div class="field-notice" rel="lastname"></div>
                                </div>
                            </div>
                            <div class="row form-group">
                                <label class="col-lg-3 control-label"><?php echo $texts['FIRSTNAME']; ?> *</label>
                                <div class="col-lg-9">
                                    <input type="text" class="form-control" name="firstname" value="<?php echo $firstname; ?>"/>
                                    <div class="field-notice" rel="firstname"></div>
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
                                <label class="col-lg-3 control-label"><?php echo $texts['COMPANY']; ?></label>
                                <div class="col-lg-9">
                                    <input type="text" class="form-control" name="company" value="<?php echo $company; ?>"/>
                                    <div class="field-notice" rel="company"></div>
                                </div>
                            </div>
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
                        </fieldset>
                    </div>
                    <div class="col-md-6">
                        <fieldset class="mb20">
                            <legend><?php echo $texts['BOOKING_DETAILS']; ?></legend>
                            <div class="ctaBox">
                                <div class="row">
                                    <div class="col-md-6">
                                        <h3><?php echo $_SESSION['book']['room']; ?></h3>
                                        <p>
                                            <?php
                                            echo $texts['CHECK_IN']." <strong>".strftime(DATE_FORMAT, $_SESSION['book']['from_date'])."</strong><br>
                                            ".$texts['CHECK_OUT']." <strong>".strftime(DATE_FORMAT, $_SESSION['book']['to_date'])."</strong><br>
                                            <strong>".$_SESSION['book']['nights']."</strong> ".$texts['NIGHTS']." -
                                            <strong>".($_SESSION['book']['adults']+$_SESSION['book']['children'])."</strong> ".$texts['PERSONS']; ?>
                                        </p>
                                    </div>
                                    <div class="col-md-6">
                                        <span class="pull-right lead text-center">
                                            <?php echo formatPrice($_SESSION['book']['amount']*CURRENCY_RATE); ?><br/>
                                        </span>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <p>
                                            <strong><?php echo $texts['TOURIST_TAX']; ?></strong>
                                            <span class="pull-right"><?php echo formatPrice($_SESSION['book']['tourist_tax']*CURRENCY_RATE); ?></span>
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </fieldset>
                        <fieldset class="mb20">
                            <legend><?php echo $texts['EXTRA_SERVICES']; ?></legend>
                            <?php
                            $result_service = $db->query("SELECT * FROM pm_service WHERE rooms REGEXP '(^|,)".$_SESSION['book']['room_id']."(,|$)' AND lang = ".LANG_ID." AND checked = 1 ORDER BY rank");
                            if($result_service !== false){
                                foreach($result_service as $i => $row){
                                    $id_service = $row['id'];
                                    $service_title = $row['title'];
                                    $service_descr = $row['descr'];
                                    $service_price = $row['price'];
                                    $service_type = $row['type'];

                                    if($service_type == "person") $service_price *= $_SESSION['book']['adults']+$_SESSION['book']['children'];
                                    if($service_type == "person-night" || $service_type == "qty-person-night") $service_price *= ($_SESSION['book']['adults']+$_SESSION['book']['children'])*$_SESSION['book']['nights'];
                                    if($service_type == "qty-night" || $service_type == "night") $service_price *= $_SESSION['book']['nights'];

                                    $checked = array_key_exists($id_service, $_SESSION['book']['extra_services']) ? " checked=\"checked\"" : ""; ?>

                                    <div class="row form-group">
                                        <label class="col-sm-<?php echo (strpos($service_type, "qty") !== false) ? 7 : 10; ?> col-xs-9 control-label">
                                            <input type="checkbox" name="extra_services[]" value="<?php echo $id_service; ?>" class="sendAjaxForm" data-action="<?php echo DOCBASE; ?>templates/<?php echo TEMPLATE; ?>/common/update_booking.php" data-target="#total_booking"<?php echo $checked;?>>
                                            <?php
                                            echo $service_title;
                                            if($service_descr != "") echo "<br><small>".$service_descr."</small>"; ?>
                                        </label>
                                        <?php
                                        if(strpos($service_type, "qty") !== false){
                                            $qty = isset($_SESSION['book']['extra_services'][$id_service]['qty']) ? $_SESSION['book']['extra_services'][$id_service]['qty'] : 1; ?>
                                            <div class="col-sm-3 col-xs-9">
                                                <div class="input-group">
                                                    <span class="input-group-btn">
                                                        <button class="btn btn-default btn-number" data-field="qty_service_<?php echo $id_service; ?>" data-type="minus" disabled="disabled" type="button">
                                                            <i class="fa fa-minus"></i>
                                                        </button>
                                                    </span>
                                                    <input class="form-control input-number sendAjaxForm" type="text" max="20" min="1" value="<?php echo $qty; ?>" name="qty_service_<?php echo $id_service; ?>" data-action="<?php echo DOCBASE; ?>templates/<?php echo TEMPLATE; ?>/common/update_booking.php" data-target="#total_booking">
                                                    <span class="input-group-btn">
                                                        <button class="btn btn-default btn-number" data-field="qty_service_<?php echo $id_service; ?>" data-type="plus" type="button">
                                                            <i class="fa fa-plus"></i>
                                                        </button>
                                                    </span>
                                                </div>
                                            </div>
                                            <?php
                                        } ?>
                                        <div class="col-sm-2 col-xs-3 text-right">
                                            <?php
                                            if(strpos($service_type, "qty") !== false) echo "x ";
                                            echo formatPrice($service_price*CURRENCY_RATE); ?>
                                        </div>
                                    </div>
                                    <?php
                                }
                            } ?>
                        </fieldset>
                        <hr>
                        <div class="row">
                            <div class="col-xs-6">
                                <h3><?php echo $texts['TOTAL']." ".$texts['INCL_VAT']; ?></h3>
                                <?php echo $texts['VAT_AMOUNT']; ?>
                            </div>
                            <div class="col-xs-6 lead text-right">
                                <span id="total_booking">
                                    <?php echo formatPrice($_SESSION['book']['total']*CURRENCY_RATE); ?><br>
                                    <small><?php echo formatPrice($_SESSION['book']['vat_total']*CURRENCY_RATE); ?></small>
                                </span>
                            </div>
                        </div>
                        <fieldset>
                            <legend><?php echo $texts['SPECIAL_REQUESTS']; ?></legend>
                            <div class="form-group">
                                <textarea class="form-control" name="comments"><?php echo $comments; ?></textarea>
                                <div class="field-notice" rel="comments"></div>
                            </div>
                            <p><?php //echo $texts['BOOKING_TERMS']; ?></p>
                        </fieldset>
                    </div>
                </div>
                <a class="btn btn-default btn-lg pull-left" href="<?php echo DOCBASE.$sys_pages['booking']['alias']; ?>"><i class="fa fa-angle-left"></i> <?php echo $texts['PREVIOUS_STEP']; ?></a>
                <button type="submit" class="btn btn-primary btn-lg pull-right" name="book"><?php echo $texts['NEXT_STEP']; ?> <i class="fa fa-angle-right"></i></button>
            </form>
        </div>
    </div>
</section>
