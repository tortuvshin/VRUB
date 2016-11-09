<?php
require_once("../../../common/lib.php");
require_once("../../../common/define.php");

if(isset($_POST['message_type']) && $_POST['message_type'] == "ORDER_CREATED"){

    $insMessage = array();
    foreach($_POST as $k => $v) $insMessage[$k] = $v;

    $hashSecretWord = SECRET_WORD;
    $hashSid = VENDOR_ID;
    $hashOrder = $insMessage['sale_id'];
    $hashInvoice = $insMessage['invoice_id'];
    $StringToHash = strtoupper(md5($hashOrder.$hashSid.$hashInvoice.$hashSecretWord));

    if($StringToHash != $insMessage['md5_hash']) die("Хэш код буруу байна");

    $payment_amount = $_POST['invoice_list_amount'];
    $payment_currency = $_POST['list_currency'];
    $vendor_id = $_POST['vendor_id'];
    $id_booking = $_POST['vendor_order_id'];
    $txn_id = $_POST['invoice_id'];
    
    $result_booking = $db->query("SELECT * FROM pm_booking WHERE id = ".$id_booking." AND status = 1 AND (trans IS NULL OR trans = '')");
    if($result_booking !== false && $db->last_row_count() == 1){
        
        $row = $result_booking->fetch();

        if($vendor_id == VENDOR_ID && $payment_currency == CURRENCY_CODE
        && ((ENABLE_DOWN_PAYMENT == 1 && $payment_amount == $row['down_payment']) || (ENABLE_DOWN_PAYMENT == 0 && $payment_amount == $row['total']))){
            
            $data['id'] = $id_booking;
            $data['status'] = 4;
            $data['payment_date'] = time();
            $data['trans'] = $txn_id;
            
            $result_booking = db_prepareUpdate($db, "pm_booking", $data);
            if($result_booking->execute() !== false){
                
                $mailContent = "
                <p><b>".$texts['BILLING_ADDRESS']."</b></p>
                <p>".$row['firstname']." ".$row['lastname']."<br>";
                if($row['company'] != "") $mailContent .= $texts['COMPANY']." : ".$row['company']."<br>";
                $mailContent .= nl2br($row['address'])."<br>
                ".$row['postcode']." ".$row['city']."<br>
                ".$texts['PHONE']." : ".$row['phone']."<br>";
                if($row['mobile'] != "") $mailContent .= $texts['MOBILE']." : ".$row['mobile']."<br>";
                $mailContent .= $texts['EMAIL']." : ".$row['email']."</p>
                
                <p>".$texts['ROOM']." : <b>".$row['room']."</b><br>
                ".$texts['CHECK_IN']." <b>".strftime(DATE_FORMAT, $row['from_date'])."</b><br>
                ".$texts['CHECK_OUT']." <b>".strftime(DATE_FORMAT, $row['to_date'])."</b><br>
                <b>".$row['nights']."</b> ".$texts['NIGHTS']."<br>
                <b>".($row['adults']+$row['children'])."</b> ".$texts['PERSONS']." - 
                ".$texts['ADULTS'].": <b>".$row['adults']."</b> / 
                ".$texts['CHILDREN'].": <b>".$row['children']."</b><br>
                ".$texts['AMOUNT'].": ".formatPrice($row['amount']*CURRENCY_RATE)." ".$texts['INCL_VAT']."</p>";

                if(ENABLE_TOURIST_TAX == 1 && $row['tourist_tax'] > 0) $mailContent .= "<p>".$texts['TOURIST_TAX']." : ".formatPrice($row['tourist_tax']*CURRENCY_RATE)."</p>";

                if($row['extra_services'] != ""){
                    $extra_services = explode("|", $row['extra_services']);
                    if(is_array($extra_services) && !empty($extra_services)){
                            
                        $mailContent .= "<p><b>".$texts['EXTRA_SERVICES']."</b></p><p>";
                        foreach($extra_services as $extra){
                            $extra = explode(";", $extra);
                            $mailContent .= $extra[0]." x ".$extra[1]." : ".formatPrice($extra[2]*CURRENCY_RATE)." ".$texts['INCL_VAT']."<br>";
                        }
                        $mailContent .= "</p>";
                    }
                }
                
                $result_activity = $db->query("SELECT * FROM pm_booking_activity WHERE id_booking = ".$id_booking);
                if($result_activity !== false && $db->last_row_count() > 0){
                    $mailContent .= "<p><b>".$texts['ACTIVITIES']."</b></p>";
                    foreach($result_activity as $activity){
                        $mailContent .= "<p><b>".$activity['title']."</b> - ".$activity['duration']." - ".strftime(DATE_FORMAT." ".TIME_FORMAT, $activity['date'])."<br>
                        ".($activity['adults']+$activity['children'])." ".$texts['PERSONS']." - 
                        ".$texts['ADULTS'].": ".$activity['adults']." / 
                        ".$texts['CHILDREN'].": ".$activity['children']."<br>
                        ".$texts['PRICE']." : ".formatPrice($activity['amount']*CURRENCY_RATE)."</p>";
                    }
                }
                
                if($row['comments'] != "") $mailContent .= "<p><b>".$texts['COMMENTS']."</b><br>".nl2br($row['comments'])."</p>";
                
                $mailContent .= "<p>".$texts['TOTAL']." : <b>".formatPrice($row['total']*CURRENCY_RATE)." ".$texts['INCL_VAT']."</b></p>";
                
                if(ENABLE_DOWN_PAYMENT == 1 && $row['down_payment'] > 0)
                    $mailContent .= "<p>".$texts['DOWN_PAYMENT']." : <b>".formatPrice($row['down_payment']*CURRENCY_RATE)." ".$texts['INCL_VAT']."</b></p>";
                
                sendMail(EMAIL, OWNER, "Захиалгын мэдээлэл", $mailContent, $row['email'], $row['firstname']." ".$row['lastname']);
                sendMail($row['email'], $row['firstname']." ".$row['lastname'], "Захиалгын мэдээлэл", $mailContent);
            }
        }
    }
}
