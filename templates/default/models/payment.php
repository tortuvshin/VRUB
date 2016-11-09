<?php
if(!isset($_SESSION['book']) || count($_SESSION['book']) == 0){
    header("Location: ".DOCBASE.$sys_pages['booking']['alias']);
    exit();
}

$msg_error = "";
$msg_success = "";
$field_notice = array();

$payment_arr = array_map("trim", explode(",", PAYMENT_TYPE));
if(count($payment_arr) == 1){
    $payment_type = PAYMENT_TYPE;
    $handle = true;
}elseif(isset($_POST['payment_type'])){
    $payment_type = $_POST['payment_type'];
    $handle = true;
}else{
    $payment_type = PAYMENT_TYPE;
    $handle = false;
}

if(isset($_SESSION['book']['id'])){
    $result_booking = $db->query("SELECT * FROM pm_booking WHERE id = ".$_SESSION['book']['id']." AND status != 1 AND trans != ''");
    if($result_booking !== false && $db->last_row_count() > 0){
        unset($_SESSION['book']);
        header("Location: ".DOCBASE.$sys_pages['booking']['alias']);
        exit();
    }
}

require(getFromTemplate("common/paypal.php", false));

$total = $_SESSION['book']['amount_rooms']+$_SESSION['book']['tourist_tax']+$_SESSION['book']['amount_activities']+$_SESSION['book']['amount_services'];
$amount = (ENABLE_DOWN_PAYMENT == 1 && $_SESSION['book']['down_payment'] > 0) ? $_SESSION['book']['down_payment'] : $total;

if($handle && (!isset($_SESSION['book']['id']) || is_null($_SESSION['book']['id']))){
        
    $extra_services = array();
    foreach($_SESSION['book']['extra_services'] as $extra)
        $extra_services[] = $extra['title'].";".$extra['qty'].";".$extra['price'];

    $extra_services = implode("|", $extra_services);
                           
    $data = array();
    $data['id'] = null;
    $data['firstname'] = $_SESSION['book']['firstname'];
    $data['lastname'] = $_SESSION['book']['lastname'];
    $data['email'] = $_SESSION['book']['email'];
    $data['company'] = $_SESSION['book']['company'];
    $data['address'] = $_SESSION['book']['address'];
    $data['postcode'] = $_SESSION['book']['postcode'];
    $data['city'] = $_SESSION['book']['city'];
    $data['phone'] = $_SESSION['book']['phone'];
    $data['mobile'] = $_SESSION['book']['mobile'];
    $data['country'] = $_SESSION['book']['country'];
    $data['extra_services'] = $extra_services;
    $data['comments'] = $_SESSION['book']['comments'];
    $data['room'] = $_SESSION['book']['hotel']." - ".$_SESSION['book']['room'];
    $data['id_room'] = $_SESSION['book']['room_id'];
    $data['from_date'] = $_SESSION['book']['from_date'];
    $data['to_date'] = $_SESSION['book']['to_date'];
    $data['nights'] = $_SESSION['book']['nights'];
    $data['adults'] = $_SESSION['book']['adults'];
    $data['children'] = $_SESSION['book']['children'];
    $data['amount'] = number_format($_SESSION['book']['amount_rooms'], 2, ".", "");
    $data['tourist_tax'] = number_format($_SESSION['book']['tourist_tax'], 2, ".", "");
    $data['total'] = number_format($total, 2, ".", "");
    $data['down_payment'] = number_format($_SESSION['book']['down_payment'], 2, ".", "");
    $data['add_date'] = time();
    $data['edit_date'] = null;
    $data['status'] = 1;
    
    switch($payment_type){
        case "check": $data['payment_method'] = "Дансаар";
        break;
        case "arrival": $data['payment_method'] = "Биеэр";
        break;
        case "paypal": $data['payment_method'] = "PayPal";
        break;
        case "cards": $data['payment_method'] = "Кредит карт (2Checkout.com)";
        break;
    }
    
    $result_booking = db_prepareInsert($db, "pm_booking", $data);
    if($result_booking->execute() !== false){

        $_SESSION['book']['id'] = $db->lastInsertId();
        
        if(isset($_SESSION['book']['activities']) && count($_SESSION['book']['activities']) > 0){
            foreach($_SESSION['book']['activities'] as $id_activity => $activity){
                $data = array();
                $data['id'] = null;
                $data['id_booking'] = $_SESSION['book']['id'];
                $data['id_activity'] = $id_activity;
                $data['title'] = $activity['title'];
                $data['adults'] = $activity['adults'];
                $data['children'] = $activity['children'];
                $data['duration'] = $activity['duration'];
                $data['amount'] = $activity['amount'];
                $data['date'] = $activity['session_date'];
                
                $result_activity = db_prepareInsert($db, "pm_booking_activity", $data);
                $result_activity->execute();
            }
        }
        
        $_SESSION['tmp_book'] = $_SESSION['book'];
        
        if($payment_type == "check" || $payment_type == "arrival"){
            
            $mailContent = "
            <p><b>".$texts['BILLING_ADDRESS']."</b></p>
            <p>".$_SESSION['book']['firstname']." ".$_SESSION['book']['lastname']."<br>";
            if($_SESSION['book']['company'] != "") $mailContent .= $texts['COMPANY']." : ".$_SESSION['book']['company']."<br>";
            $mailContent .= nl2br($_SESSION['book']['address'])."<br>
            ".$_SESSION['book']['postcode']." ".$_SESSION['book']['city']."<br>
            ".$texts['PHONE']." : ".$_SESSION['book']['phone']."<br>";
            if($_SESSION['book']['mobile'] != "") $mailContent .= $texts['MOBILE']." : ".$_SESSION['book']['mobile']."<br>";
            $mailContent .= $texts['EMAIL']." : ".$_SESSION['book']['email']."</p>
            
            <p>".$texts['HOTEL']." : <b>".$_SESSION['book']['hotel']."</b><br>
            ".$texts['ROOM']." : <b>".$_SESSION['book']['room']."</b><br>
            ".$texts['CHECK_IN']." <b>".strftime(DATE_FORMAT, $_SESSION['book']['from_date'])."</b><br>
            ".$texts['CHECK_OUT']." <b>".strftime(DATE_FORMAT, $_SESSION['book']['to_date'])."</b><br>
            <b>".$_SESSION['book']['nights']."</b> ".$texts['NIGHTS']."<br>
            <b>".($_SESSION['book']['adults']+$_SESSION['book']['children'])."</b> ".$texts['PERSONS']." - 
            ".$texts['ADULTS'].": <b>".$_SESSION['book']['adults']."</b> / 
            ".$texts['CHILDREN'].": <b>".$_SESSION['book']['children']."</b><br>
            ".$texts['AMOUNT'].": ".formatPrice($_SESSION['book']['amount_rooms']*CURRENCY_RATE)." ".$texts['INCL_VAT']."</p>";

            if(!empty($_SESSION['book']['extra_services'])){
                $mailContent .= "<p><b>".$texts['EXTRA_SERVICES']."</b></p><p>";
                foreach($_SESSION['book']['extra_services'] as $i => $extra){
                    $mailContent .= $extra['title']." x ".$extra['qty']." : ".formatPrice($extra['price']*CURRENCY_RATE)." ".$texts['INCL_VAT']."<br>";
                }
                $mailContent .= "</p>";
            }
            
            if(isset($_SESSION['book']['activities']) && count($_SESSION['book']['activities']) > 0){
                $mailContent .= "<p><b>".$texts['ACTIVITIES']."</b></p>";
                foreach($_SESSION['book']['activities'] as $id_activity => $activity){
                    $mailContent .= "<p><b>".$activity['title']."</b> - ".$activity['duration']." - ".strftime(DATE_FORMAT." ".TIME_FORMAT, $activity['session_date'])."<br>
                    ".($activity['adults']+$activity['children'])." ".$texts['PERSONS']." - 
                    ".$texts['ADULTS'].": ".$activity['adults']." / 
                    ".$texts['CHILDREN'].": ".$activity['children']."<br>
                    ".$texts['PRICE']." : ".formatPrice($activity['amount']*CURRENCY_RATE)."</p>";
                }
            }

            if(ENABLE_TOURIST_TAX == 1 && $_SESSION['book']['tourist_tax'] > 0) $mailContent .= "<p>".$texts['TOURIST_TAX']." : ".formatPrice($_SESSION['book']['tourist_tax']*CURRENCY_RATE)."</p>";
            
            if($_SESSION['book']['comments'] != "") $mailContent .= "<p><b>".$texts['COMMENTS']."</b><br>".nl2br($_SESSION['book']['comments'])."</p>";
            
            $mailContent .= "<p>".$texts['TOTAL']." : <b>".formatPrice($total*CURRENCY_RATE)." ".$texts['INCL_VAT']."</b></p>";
            
            if(ENABLE_DOWN_PAYMENT == 1 && $_SESSION['book']['down_payment'] > 0)
                $mailContent .= "<p>".$texts['DOWN_PAYMENT']." : <b>".formatPrice($_SESSION['book']['down_payment']*CURRENCY_RATE)." ".$texts['INCL_VAT']."</b></p>";
              
            sendMail(EMAIL, OWNER, "Booking notice", $mailContent, $_SESSION['book']['email'], $_SESSION['book']['firstname']." ".$_SESSION['book']['lastname']);
            
            if($payment_type == "check") $mailContent .= "<p>".str_replace("{amount}", "<b>".formatPrice($amount*CURRENCY_RATE)." ".$texts['INCL_VAT']."</b>", $texts['PAYMENT_CHECK_NOTICE'])."</p>";
            if($payment_type == "arrival") $mailContent .= "<p>".str_replace("{amount}", "<b>".formatPrice($total)." ".$texts['INCL_VAT']."</b>", $texts['PAYMENT_ARRIVAL_NOTICE'])."</p>";
            
            sendMail($_SESSION['book']['email'], $_SESSION['book']['firstname']." ".$_SESSION['book']['lastname'], "Booking notice", $mailContent);
            
            unset($_SESSION['book']);
        }
    }
}

/* ==============================================
 * CSS AND JAVASCRIPT USED IN THIS MODEL
 * ==============================================
 */
if($payment_type == "cards")
    $javascripts[] = "https://www.2checkout.com/static/checkout/javascript/direct.min.js";

require(getFromTemplate("common/header.php", false)); ?>

<section id="page">
    
    <?php include(getFromTemplate("common/page_header.php", false)); ?>
    
    <div id="content" class="pt30 pb30">
        <div class="container">

            <div class="alert alert-success" style="display:none;"></div>
            <div class="alert alert-danger" style="display:none;"></div>
            
            <div class="row mb30" id="booking-breadcrumb">
                <div class="col-sm-2 col-sm-offset-<?php echo (isset($_SESSION['tmp_book']['activities']) || isset($_SESSION['book']['activities'])) ? "1" : "2"; ?>">
                    <a href="<?php echo DOCBASE.$sys_pages['booking']['alias']; ?>">
                        <div class="breadcrumb-item done">
                            <i class="fa fa-calendar"></i>
                            <span><?php echo $sys_pages['booking']['name']; ?></span>
                        </div>
                    </a>
                </div>
                <?php
                if(isset($_SESSION['tmp_book']['activities']) || isset($_SESSION['book']['activities'])){ ?>
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
                    <a href="<?php echo DOCBASE.$sys_pages['details']['alias']; ?>">
                        <div class="breadcrumb-item done">
                            <i class="fa fa-info-circle"></i>
                            <span><?php echo $sys_pages['details']['name']; ?></span>
                        </div>
                    </a>
                </div>
                <div class="col-sm-2">
                    <a href="<?php echo DOCBASE.$sys_pages['summary']['alias']; ?>">
                        <div class="breadcrumb-item done">
                            <i class="fa fa-list"></i>
                            <span><?php echo $sys_pages['summary']['name']; ?></span>
                        </div>
                    </a>
                </div>
                <div class="col-sm-2">
                    <div class="breadcrumb-item active">
                        <i class="fa fa-credit-card"></i>
                        <span><?php echo $sys_pages['payment']['name']; ?></span>
                    </div>
                </div>
            </div>
            
            <?php echo $page['text']; ?>
            
            <?php
            if($payment_type == "paypal"){ ?>
                <div class="text-center">
                    <?php echo $texts['PAYMENT_PAYPAL_NOTICE']; ?><br>
                    <img src="<?php echo getFromTemplate("images/paypal-cards.png"); ?>" alt="PayPal" class="img-responsive mt10 mb30">
                    <form action="https://www.<?php if(PAYMENT_TEST_MODE == 1) echo "sandbox."; ?>paypal.com/cgi-bin/webscr" method="post">
                        <input type='hidden' value="<?php echo str_replace(",", ".", round($amount*CURRENCY_RATE, 2)); ?>" name="amount">
                        <input name="currency_code" type="hidden" value="<?php echo CURRENCY_CODE; ?>">
                        <input name="shipping" type="hidden" value="0.00">
                        <input name="tax" type="hidden" value="0.00">
                        <input name="return" type="hidden" value="<?php echo getUrl(true).DOCBASE.$sys_pages['booking']['alias']."?action=confirm"; ?>">
                        <input name="cancel_return" type="hidden" value="<?php echo getUrl(true).DOCBASE.$sys_pages['booking']['alias']."?action=cancel"; ?>">
                        <input name="notify_url" type="hidden" value="<?php echo getUrl(true).getFromTemplate("common/paypal_notify.php"); ?>">
                        <input name="cmd" type="hidden" value="_xclick">
                        <input name="business" type="hidden" value="<?php echo PAYPAL_EMAIL; ?>">
                        <input name="item_name" type="hidden" value="<?php echo addslashes($_SESSION['tmp_book']['hotel']." - ".$_SESSION['tmp_book']['room']." - ".strftime(DATE_FORMAT, $_SESSION['tmp_book']['from_date'])." > ".strftime(DATE_FORMAT, $_SESSION['tmp_book']['to_date'])." - ".$_SESSION['tmp_book']['nights']." ".$texts['NIGHTS']." - ".($_SESSION['tmp_book']['adults']+$_SESSION['tmp_book']['children'])." ".$texts['PERSONS']); ?>">
                        <input name="no_note" type="hidden" value="1">
                        <input name="lc" type="hidden" value="<?php echo strtoupper(LANG_TAG); ?>">
                        <input name="bn" type="hidden" value="PP-BuyNowBF">
                        <input name="custom" type="hidden" value="<?php echo $_SESSION['tmp_book']['id']; ?>">
                        
                        <button type="submit" name="submit" class="btn btn-primary btn-lg pull-right"><i class="fa fa-paypal"></i> <?php echo $texts['PAY']; ?></button>
                    </form>
                </div>
                <?php
            }elseif($payment_type == "cards"){ ?>
                <div class="text-center">
                    <?php echo $texts['PAYMENT_CARDS_NOTICE']; ?><br>
                    <img src="<?php echo getFromTemplate("images/2checkout-cards.png"); ?>" alt="2Checkout.com" class="img-responsive mt10 mb30">
                    <form action="https://<?php if(PAYMENT_TEST_MODE == 1) echo "sandbox"; else echo "www"; ?>.2checkout.com/checkout/purchase" method="post">
                        <input type="hidden" name="sid" value="<?php echo VENDOR_ID; ?>">
                        <input type="hidden" name="mode" value="2CO">
                        <input type="hidden" name="merchant_order_id" value="<?php echo $_SESSION['tmp_book']['id']; ?>">
                        <input type="hidden" name="li_0_type" value="product">
                        <input type="hidden" name="li_0_name" value="<?php echo addslashes($_SESSION['tmp_book']['hotel']." - ".$_SESSION['tmp_book']['room']." - ".strftime(DATE_FORMAT, $_SESSION['tmp_book']['from_date'])." > ".strftime(DATE_FORMAT, $_SESSION['tmp_book']['to_date'])." - ".$_SESSION['tmp_book']['nights']." ".$texts['NIGHTS']." - ".($_SESSION['tmp_book']['adults']+$_SESSION['tmp_book']['children'])." ".$texts['PERSONS']); ?>">
                        <input type="hidden" name="li_0_price" value="<?php echo str_replace(",", ".", round($amount*CURRENCY_RATE, 2)); ?>">
                        <input type="hidden" name="card_holder_name" value="<?php echo $_SESSION['book']['lastname']." ".$_SESSION['book']['lastname']; ?>">
                        <input type="hidden" name="street_address" value="<?php echo $_SESSION['book']['address']; ?>">
                        <input type="hidden" name="street_address2" value="">
                        <input type="hidden" name="city" value="<?php echo $_SESSION['book']['city']; ?>">
                        <input type="hidden" name="state" value="">
                        <input type="hidden" name="zip" value="<?php echo $_SESSION['book']['postcode']; ?>">
                        <input type="hidden" name="country" value="<?php echo $_SESSION['book']['country']; ?>">
                        <input type="hidden" name="email" value="<?php echo $_SESSION['book']['email']; ?>">
                        <input type="hidden" name="phone" value="<?php echo $_SESSION['book']['phone']; ?>">
                        <input type="hidden" name="x_receipt_link_url" value="<?php echo getUrl(true).getFromTemplate("common/payment_notify.php"); ?>">
                        
                        <button type="submit" name="submit" class="btn btn-primary btn-lg pull-right"><i class="fa fa-credit-card"></i> <?php echo $texts['PAY']; ?></button>
                    </form>
                </div>
                <?php
            }else{ ?>
            
                <div class="text-center lead pt20 pb20">

                    <form method="post" action="<?php echo DOCBASE.$sys_pages['payment']['alias']; ?>">
                        <?php
                        if(!isset($_POST['payment_type'])){
                            $payments = array_map("trim", explode(",", PAYMENT_TYPE));
                            if(count($payments) > 1){ ?>
                                <div class="mb10">
                                    <?php echo $texts['CHOOSE_PAYMENT']; ?>
                                </div>
                                <?php
                                foreach($payments as $payment){ ?>
                                    <button type="submit" name="payment_type" class="btn btn-default" value="<?php echo $payment; ?>">
                                        <?php
                                        switch($payment){
                                            case "cards": ?>
                                                <i class="fa fa-credit-card"></i><br><?php echo $texts['PAYMENT_CREDIT_CARDS'];
                                            break;
                                            case "paypal": ?>
                                                <i class="fa fa-paypal"></i><br>PayPal
                                                <?php
                                            break;
                                            case "check": ?>
                                                <i class="fa fa-envelope"></i><br><?php echo $texts['PAYMENT_CHECK']; ?>
                                                <?php
                                            break;
                                            case "arrival": ?>
                                                <i class="fa fa-building"></i><br><?php echo $texts['PAYMENT_ARRIVAL']; ?>
                                                <?php
                                            break;
                                        } ?>
                                    </button>
                                    <?php
                                }
                            }
                        }else{ ?>
                            <input type="hidden" name="payment_type" value="<?php echo $payment_type; ?>">
                            <?php
                        } ?>
                    </form>
                    
                    <?php
                    if($payment_type == "check") echo str_replace("{amount}", "<b>".formatPrice($amount*CURRENCY_RATE)." ".$texts['INCL_VAT']."</b>", $texts['PAYMENT_CHECK_NOTICE']);
                    
                    if($payment_type == "arrival") echo str_replace("{amount}", "<b>".formatPrice($total)." ".$texts['INCL_VAT']."</b>", $texts['PAYMENT_ARRIVAL_NOTICE']); ?>
                </div>
                    
                <div class="clearfix"></div>
                <a class="btn btn-default btn-lg pull-left" href="<?php echo DOCBASE.$sys_pages['summary']['alias']; ?>"><i class="fa fa-angle-left"></i> <?php echo $texts['PREVIOUS_STEP']; ?></a>
                
                <?php
            } ?>
        </div>
    </div>
</section>
