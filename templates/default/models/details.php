<?php
if(!isset($_SESSION['book']) || count($_SESSION['book']) == 0){
    header("Location: ".DOCBASE.$sys_pages['booking']['alias']);
    exit();
}

$msg_error = "";
$msg_success = "";
$field_notice = array();

$id = 0;
$lastname = "";
$firstname = "";
$email = "";
$phone = "";
$comments = "";

if(isset($_SESSION['user'])){
    $result_user = $db->query("SELECT * FROM pm_user WHERE id = ".$db->quote($_SESSION['user']['id'])." AND checked = 1");
    if($result_user !== false && $db->last_row_count() > 0){
        $row = $result_user->fetch();
        
        $lastname = $row['name'];
        $email = $row['email'];
        $company = $row['company'];
        $phone = $row['phone'];
    }
}

if(isset($_SESSION['book']['lastname'])) $lastname = $_SESSION['book']['lastname'];
if(isset($_SESSION['book']['firstname'])) $firstname = $_SESSION['book']['firstname'];
if(isset($_SESSION['book']['email'])) $email = $_SESSION['book']['email'];
if(isset($_SESSION['book']['city'])) $city = $_SESSION['book']['city'];
if(isset($_SESSION['book']['phone'])) $phone = $_SESSION['book']['phone'];
if(isset($_SESSION['book']['comments'])) $comments = $_SESSION['book']['comments'];

if(isset($_POST['book']) || (ENABLE_BOOKING_REQUESTS == 1 && isset($_POST['request']))){
    
    $lastname = $_POST['lastname'];
    $firstname = $_POST['firstname'];
    $email = $_POST['email'];
    $phone = $_POST['phone'];
    $comments = $_POST['comments'];
    
    if($lastname == "") $field_notice['lastname'] = $texts['REQUIRED_FIELD'];
    if($firstname == "") $field_notice['firstname'] = $texts['REQUIRED_FIELD'];
    if($phone == "" || preg_match("/([0-9\-\s\+\(\)\.]+)/i", $phone) !== 1) $field_notice['phone'] = $texts['REQUIRED_FIELD'];
    if($email == "" || !preg_match("/^[\w.-]+@[\w.-]+\.[a-zA-Z]{2,6}$/i", $email)) $field_notice['email'] = $texts['INVALID_EMAIL'];
    
    if(count($field_notice) == 0){

        $_SESSION['book']['lastname'] = $lastname;
        $_SESSION['book']['firstname'] = $firstname;
        $_SESSION['book']['email'] = $email;
        $_SESSION['book']['phone'] = $phone;
        $_SESSION['book']['comments'] = $comments;
        
        if(isset($_SESSION['book']['id'])) unset($_SESSION['book']['id']);
        
        if(isset($_POST['book'])){
            header("Location: ".DOCBASE.$sys_pages['summary']['alias']);
            exit();
        }elseif(ENABLE_BOOKING_REQUESTS == 1 && isset($_POST['request'])){
            
            $mailContent = "
            <p><strong>".$texts['BILLING_ADDRESS']."</strong><br>
            ".$_SESSION['book']['firstname']." ".$_SESSION['book']['lastname']."<br>";
            
            if($_SESSION['book']['phone'] != "") $mailContent .= $texts['PHONE']." : ".$_SESSION['book']['phone']."<br>";
            $mailContent .= $texts['EMAIL']." : ".$_SESSION['book']['email']."</p>
            
            <p>".$texts['HOTEL']." : <strong>".$_SESSION['book']['hotel']."</strong><br>
            ".$texts['ROOM']." : <strong>".$_SESSION['book']['room']."</strong><br>
            ".$texts['CHECK_IN']." <strong>".strftime(DATE_FORMAT, $_SESSION['book']['from_date'])."</strong><br>
            ".$texts['CHECK_OUT']." <strong>".strftime(DATE_FORMAT, $_SESSION['book']['to_date'])."</strong><br>
            <strong>".$_SESSION['book']['nights']."</strong> ".$texts['NIGHTS']."<br>
            <strong>".($_SESSION['book']['adults']+$_SESSION['book']['children'])."</strong> ".$texts['PERSONS']." - 
            ".$texts['ADULTS'].": <strong>".$_SESSION['book']['adults']."</strong> / 
            ".$texts['CHILDREN'].": <strong>".$_SESSION['book']['children']."</strong></p>";
            
            if(!empty($_SESSION['book']['extra_services'])){
                $mailContent .= "<p><strong>".$texts['EXTRA_SERVICES']."</strong><br>";
                foreach($_SESSION['book']['extra_services'] as $i => $extra){
                    $mailContent .= $extra['title']." x ".$extra['qty']." : ".formatPrice($extra['price']*CURRENCY_RATE)." ".$texts['INCL_VAT']."<br>";
                }
                $mailContent .= "</p>";
            }
            
            if($_SESSION['book']['comments'] != "") $mailContent .= "<p><b>".$texts['COMMENTS']."</b><br>".nl2br($_SESSION['book']['comments'])."</p>";
            
            if(sendMail(EMAIL, OWNER, "Захиалгын хүсэлт", $mailContent, $_SESSION['book']['email'], $_SESSION['book']['firstname']." ".$_SESSION['book']['lastname'])){
                sendMail($_SESSION['book']['email'], $_SESSION['book']['firstname']." ".$_SESSION['book']['lastname'], "Захиалгын хүсэлт", $mailContent);
                $msg_success .= $texts['MAIL_DELIVERY_SUCCESS'];
                $lastname = "";
                $firstname = "";
                $email = "";
                $phone = "";
                $comments = "";
            }else
                $msg_error .= $texts['MAIL_DELIVERY_FAILURE'];
        }
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
            
            <div class="row mb30" id="booking-breadcrumb">
                <div class="col-sm-2 col-sm-offset-<?php echo isset($_SESSION['book']['activities']) ? "1" : "2"; ?>">
                    <a href="<?php echo DOCBASE.$sys_pages['booking']['alias']; ?>">
                        <div class="breadcrumb-item done">
                            <i class="fa fa-calendar"></i>
                            <span><?php echo $sys_pages['booking']['name']; ?></span>
                        </div>
                    </a>
                </div>
                <?php
                if(isset($_SESSION['book']['activities'])){ ?>
                    <div class="col-sm-2">
                        <a href="<?php echo DOCBASE.$sys_pages['booking-activities']['alias']; ?>">
                            <div class="breadcrumb-item done">
                                <i class="fa fa-ticket"></i>
                                <span><?php echo $sys_pages['booking-activities']['name']; ?></span>
                            </div>
                        </a>
                    </div>
                    <?php
                } ?>
                <div class="col-sm-2">
                    <div class="breadcrumb-item active">
                        <i class="fa fa-info-circle"></i>
                        <span><?php echo $sys_pages['details']['name']; ?></span>
                    </div>
                </div>
                <div class="col-sm-2">
                    <div class="breadcrumb-item">
                        <i class="fa fa-list"></i>
                        <span><?php echo $sys_pages['summary']['name']; ?></span>
                    </div>
                </div>
                <div class="col-sm-2">
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
            
            <form method="post" action="<?php echo DOCBASE.$page['alias']; ?>" class="ajax-form">
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
                                <label class="col-lg-3 control-label"><?php echo $texts['PHONE']; ?> *</label>
                                <div class="col-lg-9">
                                    <input type="text" class="form-control" name="phone" value="<?php echo $phone; ?>"/>
                                    <div class="field-notice" rel="phone"></div>
                                </div>
                            </div>
                        </fieldset>
                    </div>
                    <div class="col-md-6">
                        <fieldset class="mb20">
                            <legend><?php echo $texts['BOOKING_DETAILS']; ?></legend>
                            <div class="row">
                                <div class="col-md-6">
                                    <h3><?php echo $_SESSION['book']['hotel']; ?></h3>
                                    <h4><?php echo $_SESSION['book']['room']; ?></h4>
                                    <p>
                                        <?php
                                        echo $texts['CHECK_IN']." <strong>".strftime(DATE_FORMAT, $_SESSION['book']['from_date'])."</strong><br>
                                        ".$texts['CHECK_OUT']." <strong>".strftime(DATE_FORMAT, $_SESSION['book']['to_date'])."</strong><br>
                                        <strong>".$_SESSION['book']['nights']."</strong> ".$texts['NIGHTS']." -
                                        <strong>".($_SESSION['book']['adults']+$_SESSION['book']['children'])."</strong> ".$texts['PERSONS']; ?>
                                    </p>
                                </div>
                                <?php
                                if(isset($_SESSION['book']['amount_rooms'])){ ?>
                                    <div class="col-md-6">
                                        <span class="pull-right lead">
                                            <?php echo formatPrice($_SESSION['book']['amount_rooms']*CURRENCY_RATE); ?><br/>
                                        </span>
                                    </div>
                                    <?php
                                } ?>
                            </div>
                            <?php
                            if(ENABLE_TOURIST_TAX == 1 && isset($_SESSION['book']['tourist_tax'])){ ?>
                                <div class="row">
                                    <div class="col-md-12">
                                        <p>
                                            <strong><?php echo $texts['TOURIST_TAX']; ?></strong>
                                            <span class="pull-right"><?php echo formatPrice($_SESSION['book']['tourist_tax']*CURRENCY_RATE); ?></span>
                                        </p>
                                    </div>
                                </div>
                                <?php
                            } ?>
                        </fieldset>
                        <?php
                        if(isset($_SESSION['book']['activities']) && count($_SESSION['book']['activities']) > 0){ ?>
                            <fieldset class="mb20">
                                <legend><?php echo $texts['ACTIVITIES']; ?></legend>
                                <?php
                                foreach($_SESSION['book']['activities'] as $id_activity => $activity){ ?>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <p>
                                                <?php
                                                echo "<strong>".$activity['title']."</strong> - ".$activity['duration']."<br>
                                                <strong>".strftime(DATE_FORMAT." ".TIME_FORMAT, $activity['session_date'])."</strong> -
                                                <strong>".($activity['adults']+$activity['children'])."</strong> ".$texts['PERSONS']; ?>
                                            </p>
                                        </div>
                                        <div class="col-md-6">
                                            <span class="pull-right">
                                                <?php echo formatPrice($activity['amount']*CURRENCY_RATE); ?><br/>
                                            </span>
                                        </div>
                                    </div>
                                    <?php
                                } ?>
                            </fieldset>
                            <?php
                        } ?>
                        <fieldset class="mb20">
                            <legend><?php echo $texts['EXTRA_SERVICES']; ?></legend>
                            <?php
                            $result_service = $db->query("SELECT * FROM pm_service WHERE rooms REGEXP '(^|,)".$_SESSION['book']['room_id']."(,|$)' AND lang = ".LANG_ID." AND checked = 1 ORDER BY rank");
                            if($result_service !== false){
                                $action = getFromTemplate("common/update_booking.php");
                                foreach($result_service as $i => $row){
                                    $id_service = $row['id'];
                                    $service_title = $row['title'];
                                    $service_descr = $row['descr'];
                                    $service_long_descr = $row['long_descr'];
                                    $service_price = $row['price'];
                                    $service_type = $row['type'];

                                    if($service_type == "person") $service_price *= $_SESSION['book']['adults']+$_SESSION['book']['children'];
                                    if($service_type == "person-night" || $service_type == "qty-person-night") $service_price *= ($_SESSION['book']['adults']+$_SESSION['book']['children'])*$_SESSION['book']['nights'];
                                    if($service_type == "qty-night" || $service_type == "night") $service_price *= $_SESSION['book']['nights'];

                                    $checked = array_key_exists($id_service, $_SESSION['book']['extra_services']) ? " checked=\"checked\"" : ""; ?>

                                    <div class="row form-group">
                                        <label class="col-sm-<?php echo (strpos($service_type, "qty") !== false) ? 7 : 10; ?> col-xs-9 control-label">
                                            <input type="checkbox" name="extra_services[]" value="<?php echo $id_service; ?>" class="sendAjaxForm" data-action="<?php echo $action; ?>" data-target="#total_booking"<?php echo $checked;?>>
                                            <?php
                                            echo $service_title;
                                            if($service_descr != ""){ ?>
                                                <br><small><?php echo $service_descr; ?></small>
                                                <?php
                                            }
                                            if($service_long_descr != ""){ ?>
                                                <br><small><a href="#service_<?php echo $id_service; ?>" class="popup-modal"><?php echo $texts['READMORE']; ?></a></small>
                                                <div id="service_<?php echo $id_service; ?>" class="white-popup-block mfp-hide">
                                                    <?php echo $service_long_descr; ?>
                                                </div>
                                                <?php
                                            } ?>
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
                                                    <input class="form-control input-number sendAjaxForm" type="text" max="20" min="1" value="<?php echo $qty; ?>" name="qty_service_<?php echo $id_service; ?>" data-action="<?php echo $action; ?>" data-target="#total_booking">
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
                        <?php
                        if(isset($_SESSION['book']['amount_rooms'])){
                            $total = $_SESSION['book']['amount_rooms']+$_SESSION['book']['tourist_tax']+$_SESSION['book']['amount_activities']+$_SESSION['book']['amount_services'];
                            $vat_total = $_SESSION['book']['vat_rooms']+$_SESSION['book']['vat_activities']+$_SESSION['book']['vat_services'];  ?>
                            <hr>
                            <div class="row">
                                <div class="col-xs-6">
                                    <h3>
                                        <?php
                                        echo $texts['TOTAL'];
                                        if($vat_total > 0) echo " ".$texts['INCL_VAT']; ?>
                                    </h3>
                                    
                                    <?php if($vat_total > 0) echo $texts['VAT_AMOUNT']; ?>
                                </div>
                                <div class="col-xs-6 lead text-right">
                                    <span id="total_booking">
                                        <?php echo formatPrice($total*CURRENCY_RATE); ?><br>
                                        
                                        <?php
                                        if($vat_total > 0){ ?>
                                            <small>
                                                <?php echo formatPrice($vat_total*CURRENCY_RATE); ?>
                                            </small>
                                            <?php
                                        } ?>
                                    </span>
                                </div>
                            </div>
                            <?php
                        } ?>
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
                
                <a class="btn btn-default btn-lg pull-left" href="<?php echo (isset($_SESSION['book']['activities'])) ? DOCBASE.$sys_pages['booking-activities']['alias'] : DOCBASE.$sys_pages['booking']['alias']; ?>"><i class="fa fa-angle-left"></i> <?php echo $texts['PREVIOUS_STEP']; ?></a>
                <?php
                if(isset($_SESSION['book']['amount_rooms'])){ ?>
                    <button type="submit" class="btn btn-primary btn-lg pull-right" name="book"><?php echo $texts['NEXT_STEP']; ?> <i class="fa fa-angle-right"></i></button>
                    <?php
                }else{ ?>
                    <button type="submit" class="btn btn-primary btn-lg pull-right" name="request"><i class="fa fa-send"></i> <?php echo $texts['MAKE_A_REQUEST']; ?></button>
                    <?php
                } ?>
            </form>
        </div>
    </div>
</section>
