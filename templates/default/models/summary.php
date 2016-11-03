<?php
if(!isset($_SESSION['book']) || count($_SESSION['book']) == 0){
    header("Location: ".DOCBASE.$sys_pages['booking']['alias']);
    exit();
}

require(getFromTemplate("common/header.php", false)); ?>

<section id="page">
    
    <?php include(getFromTemplate("common/page_header.php", false)); ?>
    
    <div id="content" class="pt30 pb20">
        <div class="container">
            
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
                    <a href="<?php echo DOCBASE.$sys_pages['details']['alias']; ?>">
                        <div class="breadcrumb-item done">
                            <i class="fa fa-info-circle"></i>
                            <span><?php echo $sys_pages['details']['name']; ?></span>
                        </div>
                    </a>
                </div>
                <div class="col-sm-2">
                    <div class="breadcrumb-item active">
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
            
            <form method="post" action="<?php echo DOCBASE.$sys_pages['payment']['alias']; ?>">
                <div class="row mb30">
                    <div class="col-md-4 col-md-offset-2">
                        <?php
                        $total = $_SESSION['book']['amount_rooms']+$_SESSION['book']['tourist_tax']+$_SESSION['book']['amount_activities']+$_SESSION['book']['amount_services'];
                        $vat_total = $_SESSION['book']['vat_rooms']+$_SESSION['book']['vat_activities']+$_SESSION['book']['vat_services'];
                            
                        echo "<p>".$texts['HOTEL']." : <strong>".$_SESSION['book']['hotel']."</strong><br>
                        ".$texts['ROOM']." : <strong>".$_SESSION['book']['room']."</strong><br>
                        ".$texts['CHECK_IN']." <strong>".strftime(DATE_FORMAT, $_SESSION['book']['from_date'])."</strong><br>
                        ".$texts['CHECK_OUT']." <strong>".strftime(DATE_FORMAT, $_SESSION['book']['to_date'])."</strong><br>
                        <strong>".$_SESSION['book']['nights']."</strong> ".$texts['NIGHTS']."<br>
                        <strong>".($_SESSION['book']['adults']+$_SESSION['book']['children'])."</strong> ".$texts['PERSONS']." - 
                        ".$texts['ADULTS'].": <strong>".$_SESSION['book']['adults']."</strong> / 
                        ".$texts['CHILDREN'].": <strong>".$_SESSION['book']['children']."</strong><br>
                        ".$texts['AMOUNT'].": ".formatPrice($_SESSION['book']['amount_rooms']*CURRENCY_RATE)."</p>";

                        if(ENABLE_TOURIST_TAX == 1) echo "<p>".$texts['TOURIST_TAX']." : ".formatPrice($_SESSION['book']['tourist_tax']*CURRENCY_RATE)."</p>";

                        if(!empty($_SESSION['book']['extra_services'])){
                            echo "<h4><b>".$texts['EXTRA_SERVICES']."</b></h4>
                            <p>";
                            foreach($_SESSION['book']['extra_services'] as $i => $extra){
                                echo $extra['title']." x ".$extra['qty']." : ".formatPrice($extra['price']*CURRENCY_RATE)."<br>";
                            }
                            echo "</p>";
                        }
                        if(isset($_SESSION['book']['activities']) && count($_SESSION['book']['activities']) > 0){
                            echo "<h4><b>".$texts['ACTIVITIES']."</b></h4>";
                            foreach($_SESSION['book']['activities'] as $id_activity => $activity){
                                echo "<p><b>".$activity['title']."</b> - ".$activity['duration']." - ".strftime(DATE_FORMAT." ".TIME_FORMAT, $activity['session_date'])."<br>
                                ".($activity['adults']+$activity['children'])." ".$texts['PERSONS']." - 
                                ".$texts['ADULTS'].": ".$activity['adults']." / 
                                ".$texts['CHILDREN'].": ".$activity['children']."<br>
                                ".$texts['PRICE']." : ".formatPrice($activity['amount']*CURRENCY_RATE)."</p>";
                            }
                        }
                        
                        if($_SESSION['book']['comments'] != "") echo "<p><b>".$texts['COMMENTS']."</b><br>".nl2br($_SESSION['book']['comments'])."</p>"; ?>
                    </div>
                    <div class="col-md-4">
                        <?php
                        echo "<h4><b>".$texts['BILLING_ADDRESS']."</b></h4>
                        <p>".$_SESSION['book']['firstname']." ".$_SESSION['book']['lastname']."<br>";
                        if($_SESSION['book']['company'] != "") echo $texts['COMPANY']." : ".$_SESSION['book']['company']."<br>";
                        echo nl2br($_SESSION['book']['address'])."<br>
                        ".$_SESSION['book']['postcode']." ".$_SESSION['book']['city']."<br>
                        ".$texts['PHONE']." : ".$_SESSION['book']['phone']."<br>";
                        if($_SESSION['book']['mobile'] != "") echo $texts['MOBILE']." : ".$_SESSION['book']['mobile']."<br>";
                        echo $texts['EMAIL']." : ".$_SESSION['book']['email']."</p>";
                        
                        echo "<p class=\"lead mt20\">".$texts['TOTAL']." : <b>".formatPrice($total*CURRENCY_RATE)." ".$texts['INCL_VAT']."</b><br><small>".$texts['VAT_AMOUNT']." : ".formatPrice($vat_total*CURRENCY_RATE)."</small></p>";
                        
                        if(ENABLE_DOWN_PAYMENT == 1 && $_SESSION['book']['down_payment'] > 0)
                            echo "<p>".$texts['DOWN_PAYMENT']." : <b>".formatPrice($_SESSION['book']['down_payment']*CURRENCY_RATE)." ".$texts['INCL_VAT']."</b></p>"; ?>
                    </div>
                </div>
                
                <a class="btn btn-default btn-lg pull-left" href="<?php echo DOCBASE.$sys_pages['details']['alias']; ?>"><i class="fa fa-angle-left"></i> <?php echo $texts['PREVIOUS_STEP']; ?></a>
                <button type="submit" name="confirm_booking" class="btn btn-primary btn-lg pull-right"><?php echo $texts['CONFIRM_BOOKING']; ?> <i class="fa fa-angle-right"></i></button>
            </form>
        </div>
    </div>
</section>
