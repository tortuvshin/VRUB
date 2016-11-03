<?php
require_once("../../../common/lib.php");
require_once("../../../common/define.php");

if(isset($db) && $db !== false){
        
    if(isset($_POST['currentMonth']) && is_numeric($_POST['currentMonth'])
    && isset($_POST['currentYear']) && is_numeric($_POST['currentYear'])){

        $currentMonth = $_POST['currentMonth'];
        $currentYear = $_POST['currentYear'];
        
        if(isset($_POST['room']) && is_numeric($_POST['room'])) $room_id = $_POST['room'];
        else $room_id = 0;

        $bookings = array();
        $days = array("booked" => array(), "free" => array());

        $start_month = mktime(0, 0, 0, $currentMonth, 1, $currentYear);
        $nb_days = date("t", $start_month);
        $end_month = mktime(0, 0, 0, $currentMonth, $nb_days, $currentYear);

        $query_rate = "SELECT start_date, end_date FROM pm_rate WHERE start_date <= ".$end_month." AND end_date >= ".$start_month;
        if($room_id != 0) $query_rate .= " AND id_room = ".$room_id;
        $result_rate = $db->query($query_rate);
        if($result_rate !== false){
            foreach($result_rate as $i => $row){
                $start_date = $row['start_date'];
                $end_date = $row['end_date'];
                $d = 0;
                $dst = false;

                $start = ($start_date < $start_month) ? $start_month : $start_date;
                $end = ($end_date > $end_month) ? $end_month : $end_date;
                
                $d = (int)date("j", $start);
                
                for($date = $start; $date <= $end; $date += 86400){

                    $cur_dst = date("I", $date);
                    if($dst != $cur_dst){
                        if($cur_dst == 0) $date += 3600;
                        else $date -= 3600;
                        $dst = $cur_dst;
                    }
                    
                    if(!in_array($d, $days['free'])) $days['free'][] = $d;
                    $d++;
                }
            }
        }
        
        $query_book = "SELECT stock, id_room, from_date, to_date FROM pm_booking as b, pm_room as r WHERE lang = ".DEFAULT_LANG." AND id_room = r.id AND status = 4 AND from_date <= ".$end_month." AND to_date >= ".$start_month;
        if($room_id != 0) $query_book .= " AND id_room = ".$room_id;
        $query_book .= " GROUP BY b.id";
        $result_book = $db->query($query_book);
        if($result_book !== false){
            foreach($result_book as $i => $row){
                $start_date = $row['from_date'];
                $end_date = $row['to_date'];
                $stock = $row['stock'];
                $d = 0;
                $dst = false;

                $start = ($start_date < $start_month) ? $start_month : $start_date;
                $end = ($end_date > $end_month) ? $end_month : $end_date;
                
                $d = (int)date("j", $start);
                for($date = $start; $date <= $end; $date += 86400){

                    $cur_dst = date("I", $date);
                    if($dst != $cur_dst){
                        if($cur_dst == 0) $date += 3600;
                        else $date -= 3600;
                        $dst = $cur_dst;
                    }
                    
                    $bookings[$d] = isset($bookings[$d]) ? $bookings[$d]+1 : 1;
                    if($bookings[$d] >= $stock && !in_array($d, $days['booked'])) $days['booked'][] = $d;
                    $d++;
                }
            }
        }
        echo json_encode($days);
    }
}
