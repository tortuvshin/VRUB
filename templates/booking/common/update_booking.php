<?php
define("SYSBASE",realpath(__DIR__."/../../../")."/");
require_once(SYSBASE."common/lib.php");
require_once(SYSBASE."common/define.php");
$response = array("html" => "", "notices" => array(), "error" => "", "success" => "");

$amount = $_SESSION['book']['amount']+$_SESSION['book']['tourist_tax'];
$vat_amount = $_SESSION['book']['vat_amount'];
$people = $_SESSION['book']['adults']+$_SESSION['book']['children'];
$nights = $_SESSION['book']['nights'];
$total = $amount;
$vat_total = $vat_amount;
    
if(isset($_POST['extra_services']) && count($_POST['extra_services']) > 0){

    $extra_services = array();
    $total_services = 0;

    $result_service = $db->query("SELECT * FROM pm_service WHERE id IN(".implode(",", $_POST['extra_services']).") AND checked = 1 AND lang = ".LANG_ID);
    if($result_service !== false){
        foreach($result_service as $i => $row){
            $id = $row['id'];
            $type = $row['type'];
            $title = $row['title'];
            $price = $row['price'];
            $vat_rate = $row['vat_rate'];
            
            $qty = 0;
            $rate = 0;
            if(strpos($type, "qty") !== false && isset($_POST['qty_service_'.$id])){
                $qty = $_POST['qty_service_'.$id];
                $rate = $qty;
                if($type == "qty-night") $rate *= $nights;
                if($type == "qty-person-night") $rate *= $nights*$people;
            }else{
                if($type == "person-night") $qty = $nights*$people;
                if($type == "person") $qty = $people;
                if($type == "night") $qty = $nights;
                if($type == "package") $qty = 1;
                $rate = $qty;
            }

            if($qty > 0){
                $price = $rate*$price;
                $vat_total += $price-($price/($vat_rate/100+1));
                $total_services += $price;
                $extra_services[$id]['title'] = $title;
                $extra_services[$id]['qty'] = $qty;
                $extra_services[$id]['price'] = $price;
            }
        }
    }
    if($total_services > 0){
        $total = $amount+$total_services;
        $_SESSION['book']['extra_services'] = $extra_services;
        $_SESSION['book']['total'] = $total;
        $_SESSION['book']['vat_total'] = $vat_total;
        $_SESSION['book']['down_payment'] = (ENABLE_DOWN_PAYMENT == 1 && DOWN_PAYMENT_RATE > 0) ? $_SESSION['book']['total']*DOWN_PAYMENT_RATE/100 : 0;
    }
}
$response['html'] = formatPrice($total*CURRENCY_RATE)."<br><small>".formatPrice($vat_total*CURRENCY_RATE)."</small>";
echo json_encode($response);
