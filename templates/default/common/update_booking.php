<?php
require_once("../../../common/lib.php");
require_once("../../../common/define.php");
$response = array("html" => "", "notices" => array(), "error" => "", "success" => "");

if(isset($db) && $db !== false){
        
    if(isset($_SESSION['book'])){
    
        if(isset($_SESSION['book']['amount_rooms'])){
            $total = $_SESSION['book']['amount_rooms']+$_SESSION['book']['tourist_tax']+$_SESSION['book']['amount_activities'];
            $vat_total = $_SESSION['book']['vat_rooms']+$_SESSION['book']['vat_activities'];
        }
        $people = $_SESSION['book']['adults']+$_SESSION['book']['children'];
        $nights = $_SESSION['book']['nights'];
        
        if(isset($_POST['extra_services']) && count($_POST['extra_services']) > 0){

            $extra_services = array();
            $total_services = 0;
            $vat_services = 0;

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
                        $total_services += $price;
                        $extra_services[$id]['title'] = $title;
                        $extra_services[$id]['qty'] = $qty;
                        $extra_services[$id]['price'] = $price;
                        
                        if(isset($_SESSION['book']['amount_rooms'])) $vat_services += $price-($price/($vat_rate/100+1));
                    }
                }
            }
            if($total_services > 0){
                
                $_SESSION['book']['extra_services'] = $extra_services;
                
                if(isset($_SESSION['book']['amount_rooms'])){
                    $total += $total_services;
                    $vat_total += $vat_services;
                    $_SESSION['book']['amount_services'] = $total_services;
                    $_SESSION['book']['vat_services'] = $vat_services;
                    $_SESSION['book']['down_payment'] = (ENABLE_DOWN_PAYMENT == 1 && DOWN_PAYMENT_RATE > 0) ? $total*DOWN_PAYMENT_RATE/100 : 0;
                }
            }
        }
        if(isset($_SESSION['book']['amount_rooms'])) $response['html'] = formatPrice($total*CURRENCY_RATE)."<br><small>".formatPrice($vat_total*CURRENCY_RATE)."</small>";
        
        echo json_encode($response);
    }
}
