<?php
require_once("../../../common/lib.php");
require_once("../../../common/define.php");
$response = array("html" => "", "notices" => array(), "error" => "", "success" => "");

if(isset($db) && $db !== false){
        
    if(isset($_POST['activity']) && is_numeric($_POST['activity'])){
        
        $activity_id = $_POST['activity'];
        
        if($activity_id > 0 && isset($_POST['adults_'.$activity_id]) && isset($_POST['children_'.$activity_id]) && isset($_POST['date_'.$activity_id])
        && is_numeric($_POST['adults_'.$activity_id]) && is_numeric($_POST['children_'.$activity_id]) && is_numeric($_POST['date_'.$activity_id])){

            $adults = $_POST['adults_'.$activity_id];
            $children = $_POST['children_'.$activity_id];
            $date = $_POST['date_'.$activity_id];
            $day = date("j", $date);
            $month = date("n", $date);
            $year = date("Y", $date);
            $n = ((date("w", $date)+6)%7)+1;
            
            $people = $adults+$children;
            
            $amount = 0;
            $full_price = 0;

            $bookings = array();
            $sessions = array();

            $result_session = $db->query("
                            SELECT vat_rate, discount, s.price, price_child, start_date, end_date, days, id_activity_session, start_h, start_m, max_people
                            FROM pm_activity as a, pm_activity_session as s, pm_activity_session_hour as h
                            WHERE
                                start_date <= ".$date." AND end_date >= ".$date."
                                AND id_activity_session = s.id
                                AND id_activity = a.id
                                AND id_activity = ".$activity_id."
                            GROUP BY h.id");
            if($result_session !== false){
                foreach($result_session as $i => $row){
                    $start_h = $row['start_h'];
                    $start_m = $row['start_m'];
                    $max_people = $row['max_people'];
                    $price_adult = $row['price'];
                    $price_child = $row['price_child'];
                    $discount = $row['discount'];
                    $vat_rate = $row['vat_rate'];
                    $opening_days = explode(",", $row['days']);
                    
                    if($amount == 0){
                        $amount = ($adults*$price_adult)+($children*$price_child);
                        $full_price = $amount;
                        if($discount > 0) $amount = $amount-($amount*$discount/100);
                        $vat_amount = $amount-($amount/($vat_rate/100+1));
                    }
                    
                    $time = mktime($start_h, $start_m, 0, $month, $day, $year);
                    
                    if($people <= $max_people){
                        if(in_array($n, $opening_days) && $time > time()+86400) $sessions[$time] = strftime(TIME_FORMAT, $time);
                    }
                }
            }
            
            ksort($sessions);
            
            $result_book = $db->query("
                            SELECT date, max_people, ba.adults, ba.children, id_activity, from_date, to_date
                            FROM pm_booking as b, pm_booking_activity as ba, pm_activity as a
                            WHERE
                                lang = ".DEFAULT_LANG."
                                AND id_booking = b.id
                                AND id_activity = a.id
                                AND status = 4
                                AND date IN(".implode(",", $sessions).")
                                AND id_activity = ".$activity_id."
                            GROUP BY ba.id");
            if($result_book !== false){
                foreach($result_book as $i => $row){
                    $date = $row['date'];
                    $max_people = $row['max_people'];
                    $num_adults = $row['adults'];
                    $num_children = $row['children'];
                    
                    $num_people = $num_adults+$num_children;
                    
                    $bookings[$date] = isset($bookings[$date]) ? $bookings[$date]+$num_people : $num_people;
                    
                    if($bookings[$date]+$people > $max_people && array_key_exists($date, $sessions)) unset($sessions[$date]);
                }
            }
            if(!empty($sessions) && $amount > 0){
                $response['html'] .= "
                <div class=\"form-group\">
                    <div class=\"input-group input-group-sm\">
                        <div class=\"input-group-addon\"><i class=\"fa fa-clock-o\"></i> ".$texts['TIMESLOT']."</div>
                            <select name=\"session_date_".$activity_id."\" class=\"form-control selectpicker\">";
                                foreach($sessions as $date => $hour)
                                    $response['html'] .= "<option value=\"".$date."\">".$hour."</option>";
                
                                $response['html'] .= "
                            </select>
                        </div>
                    </div>
                </div>
                <div class=\"price\">
                    <span>".formatPrice($amount*CURRENCY_RATE)."</span>";
                    if($full_price > 0 && $full_price > $amount)
                        $response['html'] .= "<br><s class=\"text-warning\">".formatPrice($full_price*CURRENCY_RATE)."</s>";
                    $response['html'] .= "
                </div>
                <span class=\"mb10 text-muted\">".$texts['PRICE']." / ".$people." ".$texts['PERSONS']."</span>
                <input type=\"hidden\" name=\"amount_".$activity_id."\" value=\"".$amount."\">
                <input type=\"hidden\" name=\"vat_amount_".$activity_id."\" value=\"".$vat_amount."\">";
            }
        }
    }
}
echo json_encode($response);
