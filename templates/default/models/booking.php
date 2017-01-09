<?php
$field_notice = array();
$msg_error = "";
$msg_success = "";
$response = "";
$room_stock = 1;
$max_people = 30;

if(isset($_POST['num_adults'])) $num_adults = $_POST['num_adults'];
elseif(isset($_SESSION['book']['adults'])) $num_adults = $_SESSION['book']['adults'];
else $num_adults = 1;

if(isset($_POST['num_children'])) $num_children = $_POST['num_children'];
elseif(isset($_SESSION['book']['children'])) $num_children = $_SESSION['book']['children'];
else $num_children = 0;

if(isset($_SESSION['book']['from_date'])) $from_time = $_SESSION['book']['from_date'];
else $from_time = time();

if(isset($_SESSION['book']['to_date'])) $to_time = $_SESSION['book']['to_date'];
else $to_time = time()+86400;

$from_date = date("d/m/Y", $from_time);
$to_date = date("d/m/Y", $to_time);

if(isset($_POST['from_date'])) $from_date = htmlentities($_POST['from_date'], ENT_QUOTES, "UTF-8");
if(isset($_POST['to_date'])) $to_date = htmlentities($_POST['to_date'], ENT_QUOTES, "UTF-8");

if(isset($_POST['hotel_id']) && is_numeric($_POST['hotel_id'])) $hotel_id = $_POST['hotel_id'];
else $hotel_id = 0;

if(isset($_POST['book']) || (ENABLE_BOOKING_REQUESTS == 1 && isset($_POST['request']))){
    $num_adults = $_POST['adults'];
    $num_children = $_POST['children'];
    $num_nights = $_POST['nights'];
    
    $_SESSION['book']['hotel'] = $_POST['hotel'];
    $_SESSION['book']['hotel_id'] = $_POST['id_hotel'];
    $_SESSION['book']['room'] = $_POST['room'];
    $_SESSION['book']['room_id'] = $_POST['id_room'];
    $_SESSION['book']['from_date'] = $_POST['from_date'];
    $_SESSION['book']['to_date'] = $_POST['to_date'];
    $_SESSION['book']['nights'] = $num_nights;
    $_SESSION['book']['adults'] = $num_adults;
    $_SESSION['book']['children'] = $num_children;
    $_SESSION['book']['extra_services'] = array();
    
    if(isset($_POST['book'])){
        $_SESSION['book']['amount_rooms'] = $_POST['amount'];
        $_SESSION['book']['amount_activities'] = 0;
        $_SESSION['book']['amount_services'] = 0;
        $_SESSION['book']['vat_rooms'] = $_POST['vat_amount'];
        $_SESSION['book']['vat_activities'] = 0;
        $_SESSION['book']['vat_services'] = 0;
        
        $tourist_tax = (TOURIST_TAX_TYPE == "fixed") ? $num_adults*$num_nights*TOURIST_TAX : $_SESSION['book']['amount_rooms']*TOURIST_TAX/100;
        
        $_SESSION['book']['tourist_tax'] = (ENABLE_TOURIST_TAX == 1) ? $tourist_tax : 0;
        
        $_SESSION['book']['down_payment'] = (ENABLE_DOWN_PAYMENT == 1 && DOWN_PAYMENT_RATE > 0) ? ($_SESSION['book']['amount_rooms']+$_SESSION['book']['tourist_tax'])*DOWN_PAYMENT_RATE/100 : 0;
    }
    
    if(isset($_SESSION['book']['id'])) unset($_SESSION['book']['id']);

    $result_activity = $db->query("SELECT * FROM pm_activity WHERE hotels REGEXP '(^|,)".$_SESSION['book']['hotel_id']."(,|$)' AND checked = 1 AND lang = ".LANG_ID);
    if(isset($_SESSION['book']['activities'])) unset($_SESSION['book']['activities']);
    
    if($result_activity !== false && $db->last_row_count() > 0){
        $_SESSION['book']['activities'] = array();
        header("Location: ".DOCBASE.$sys_pages['booking-activities']['alias']);
    }else
        header("Location: ".DOCBASE.$sys_pages['details']['alias']);
    
    exit();
}

$num_people = $num_adults+$num_children;

if(!is_numeric($num_adults)) $field_notice['num_adults'] = $texts['REQUIRED_FIELD'];
if(!is_numeric($num_children)) $field_notice['num_children'] = $texts['REQUIRED_FIELD'];

if($from_date == "") $field_notice['dates'] = $texts['REQUIRED_FIELD'];
else{
    $from_time = explode("/", $from_date);
    $from_time = mktime(0, 0, 0, $from_time[1], $from_time[0], $from_time[2]);
    if(!is_numeric($from_time)) $field_notice['dates'] = $texts['REQUIRED_FIELD'];
}
if($to_date == "") $field_notice['dates'] = $texts['REQUIRED_FIELD'];
else{
    $to_time = explode("/", $to_date);
    $to_time = mktime(0, 0, 0, $to_time[1], $to_time[0], $to_time[2]);
    if(!is_numeric($to_time)) $field_notice['dates'] = $texts['REQUIRED_FIELD'];
}

$period = $to_time-$from_time;
if(date("I", $to_time) XOR date("I", $from_time)) $period -= 3600;
$num_nights = ceil($period/86400);

if(count($field_notice) == 0){

    if($num_nights <= 0) {
        $days = array();
        $booked = array();

        $query_book = "
            SELECT stock, id_room, from_date, to_date
            FROM pm_booking as b, pm_room as r
            WHERE
                lang = ".DEFAULT_LANG."
                AND id_room = r.id
                AND status = 4
                AND r.checked = 1
                AND from_date < ".$to_time."
                AND to_date > ".$from_time."
            GROUP BY b.id";
        $result_book = $db->query($query_book);
        if($result_book !== false){
            foreach($result_book as $i => $row){
                $start_date = $row['from_date'];
                $end_date = $row['to_date'];
                $id_room = $row['id_room'];
                $room_stock = $row['stock'];
                
                $d = 0;
                $start = ($start_date < $from_time) ? $from_time : $start_date;
                $end = ($end_date > $to_time) ? $to_time : $end_date;
                $dst = date("I", $start);
                
                for($date = $start; $date <= $end; $date += 86400){

                    $cur_dst = date("I", $date);
                    if($dst != $cur_dst){
                        if($cur_dst == 0) $date += 3600;
                        else $date -= 3600;
                        $dst = $cur_dst;
                    }
                    $days[$id_room][$date] = isset($days[$id_room][$date]) ? $days[$id_room][$date]+1 : 1;
                    
                    if($days[$id_room][$date]+1 > $room_stock && !in_array($date, $booked)) $booked[$id_room][] = $date;
                }
            }
        }
        $amount = 0;
        $total_nights = 0;
        $res_hotel = array();
        $query_rate = "
            SELECT DISTINCT max_adults, max_children, min_people, max_people, id_hotel, id_room, start_date, end_date, ra.price, child_price, discount, type, people, price_sup, fixed_sup, vat_rate, min_stay, day_start, day_end
            FROM pm_rate as ra, pm_room as ro
            WHERE
                id_room = ro.id
                AND ro.checked = 1
                AND (end_lock IS NULL OR end_lock < ".$from_time." OR
                    start_lock IS NULL OR start_lock > ".$to_time.")
                AND start_date <= ".$to_time."
                AND end_date >= ".$from_time;
        if(!empty($booked)) $query_rate .= " AND id_room NOT IN(".implode(",", array_keys($booked)).")";
        $query_rate .= "
            ORDER BY CASE type
                WHEN 'week' THEN 1
                WHEN 'mid-week' THEN 2
                WHEN 'week-end' THEN 3
                WHEN '2-nights' THEN 4
                WHEN 'night' THEN 5
                ELSE 6 END, min_stay DESC";

        $result_room_rate = $db->query($query_rate);
        if($result_room_rate !== false){
            foreach($result_room_rate as $i => $row){

                $id_room = $row['id_room'];
                $id_hotel = $row['id_hotel'];
                $start_date = $row['start_date'];
                $end_date = $row['end_date'];
                $price = $row['price'];
                $child_price = $row['child_price'];
                $discount = $row['discount'];
                $type = $row['type'];
                $people = $row['people'];
                $price_sup = $row['price_sup'];
                $fixed_sup = $row['fixed_sup'];
                $day_start = $row['day_start'];
                $day_end = $row['day_end'];
                $vat_rate = $row['vat_rate'];
                $min_stay = $row['min_stay'];
                $min_people = $row['min_people'];
                $max_people = $row['max_people'];
                $max_adults = $row['max_adults'];
                $max_children = $row['max_children'];
                
                if(!isset($res_hotel[$id_hotel][$id_room]['days'])) $res_hotel[$id_hotel][$id_room]['days'] = array();
                
                $from_n = date("N", $from_time);
                $to_n = date("N", $to_time);
                
                $error = false;
                if($num_nights < $min_stay){
                    if(!isset($res_hotel[$id_hotel][$id_room]['min_stay'])) $res_hotel[$id_hotel][$id_room]['min_stay'] = $min_stay;
                    $error = true;
                    $res_hotel[$id_hotel][$id_room]['notice'] = $texts['MIN_NIGHTS']." : ".$min_stay;
                }
                if($num_adults+$num_children > $max_people){
                    $error = true;
                    $res_hotel[$id_hotel][$id_room]['notice'] = $texts['MAX_PEOPLE']." : ".$max_people;
                }
                if($num_adults+$num_children < $min_people){
                    $error = true;
                    $res_hotel[$id_hotel][$id_room]['notice'] = $texts['MIN_PEOPLE']." : ".$min_people;
                }
                if($num_adults > $max_adults){
                    $error = true;
                    $res_hotel[$id_hotel][$id_room]['notice'] = $texts['MAX_ADULTS']." : ".$max_adults;
                }
                if($num_children > $max_children){
                    $error = true;
                    $res_hotel[$id_hotel][$id_room]['notice'] = $texts['MAX_CHILDREN']." : ".$max_children;
                }
                
                if($error === false){
                    // custom day start and day end
                    if(($day_start == 0 || $from_n == $day_start) && ($day_end == 0 || $to_n == $day_end)){

                        // existing package with default conditions
                        if((($type == "week-end" && ($from_n >= 5 || $to_n == 1))
                        || ($type == "mid-week" && $num_nights >= 3 && $num_nights <= 5 && $from_n >= 1 && $from_n <= 3 && $to_n <= 5)
                        || ($type == "2-nights" && $num_nights == 2 && $from_n <= 5)
                        || ($type == "week" && $num_nights >= 6))
                        XOR ($type == "night")){
                        
                            // get common period between current rate and selected period
                            $start = ($start_date < $from_time) ? $from_time : $start_date;
                            $end = ($end_date > $to_time) ? $to_time : $end_date;
                            if($start_date > $from_time) $start-= 86400;
                            
                            $period = $end-$start;
                            if(date("I", $end) XOR date("I", $start)) $period -= 3600;
                            $n_period = ceil($period/86400);
                            
                            // number of nights
                            $nnights = 0;
                            $dst = date("I", $start);
                            for($date = $start; $date < ($start+(86400*$n_period)); $date += 86400){
                                $cur_dst = date("I", $date);
                                if($dst != $cur_dst){
                                    if($cur_dst == 0) $date += 3600;
                                    else $date -= 3600;
                                    $dst = $cur_dst;
                                }
                                $d = date("N", $date);
                                if(!in_array($date, $res_hotel[$id_hotel][$id_room]['days']) && (($type == "week-end" && ($d >= 5 && $to_n != 5)) || $type != "week-end")){
                                    $res_hotel[$id_hotel][$id_room]['days'][] = $date;
                                    $nnights++;
                                }
                            }
                            
                            if($num_people > $people && $people > 0){
                                
                                $extra_adults = ($num_adults > $people) ? $num_adults-$people : 0;
                                $extra_children = ($num_children > 0) ? $num_people-$people-$extra_adults : 0;
                                
                                if($child_price == 0 && $price_sup > 0) $child_price = $price_sup;
                                if($extra_children > 0) $price += $child_price*$extra_children;
                                if($price_sup > 0) $price += $price_sup*$extra_adults;
                            }
                            
                            $price = $nnights*$price;
                            $full_price = $price;
                            if($discount > 0) $price = $price-($price*$discount/100);
                            $vat_amount = $price-($price/($vat_rate/100+1));

                            if(!isset($res_hotel[$id_hotel][$id_room]['total_nights']) || $res_hotel[$id_hotel][$id_room]['total_nights']+$nnights <= $num_nights){
                                
                                if(isset($res_hotel[$id_hotel][$id_room]['amount'])) $res_hotel[$id_hotel][$id_room]['amount'] += $price;
                                else $res_hotel[$id_hotel][$id_room]['amount'] = $price;
                                
                                if(isset($res_hotel[$id_hotel][$id_room]['full_price'])) $res_hotel[$id_hotel][$id_room]['full_price'] += $full_price;
                                else $res_hotel[$id_hotel][$id_room]['full_price'] = $full_price;
                                
                                if(isset($res_hotel[$id_hotel][$id_room]['total_nights'])) $res_hotel[$id_hotel][$id_room]['total_nights'] += $nnights;
                                else $res_hotel[$id_hotel][$id_room]['total_nights'] = $nnights;
                                
                                if(isset($res_hotel[$id_hotel][$id_room]['vat_amount'])) $res_hotel[$id_hotel][$id_room]['vat_amount'] += $vat_amount;
                                else $res_hotel[$id_hotel][$id_room]['vat_amount'] = $vat_amount;
                                
                                $res_hotel[$id_hotel][$id_room]['min_stay'] = ((isset($res_hotel[$id_hotel][$id_room]['min_stay']) && $min_stay > $res_hotel[$id_hotel][$id_room]['min_stay']) || !isset($res_hotel[$id_hotel][$id_room]['min_stay'])) ? $min_stay : 0;
                                if($num_nights < $res_hotel[$id_hotel][$id_room]['min_stay']){
                                    $res_hotel[$id_hotel][$id_room]['error'] = true;
                                    $res_hotel[$id_hotel][$id_room]['notice'] = $texts['MIN_NIGHTS']." : ".$res_hotel[$id_hotel][$id_room]['min_stay'];
                                }
                                if((isset($res_hotel[$id_hotel][$id_room]['fixed_sup']) && $fixed_sup > $res_hotel[$id_hotel][$id_room]['fixed_sup']) || !isset($res_hotel[$id_hotel][$id_room]['fixed_sup'])){
                                    $res_hotel[$id_hotel][$id_room]['fixed_sup_amount'] = $fixed_sup;
                                    $res_hotel[$id_hotel][$id_room]['fixed_sup_vat'] = $fixed_sup-($fixed_sup/($vat_rate/100+1));
                                }else{
                                    $res_hotel[$id_hotel][$id_room]['fixed_sup_amount'] = 0;
                                    $res_hotel[$id_hotel][$id_room]['fixed_sup_vat'] = 0;
                                }
                            }
                        }
                    }
                }else
                    $res_hotel[$id_hotel][$id_room]['error'] = true;
            }
            
            foreach($res_hotel as $id_hotel => $hotel){
                foreach($hotel as $id_room => $result){
                    if(!isset($result['amount']) || $result['amount'] == 0 || $result['total_nights'] != $num_nights) $res_hotel[$id_hotel][$id_room]['error'] = true;
                    elseif(isset($res_hotel[$id_hotel][$id_room]['error'])) unset($res_hotel[$id_hotel][$id_room]['error']);
                    if(empty($res_hotel[$id_hotel])) unset($res_hotel[$id_hotel]);
                }
            }

            if(empty($res_hotel)) $msg_error .= $texts['NO_AVAILABILITY'];
        }
    }
}

if(isset($_GET['action'])){
    if($_GET['action'] == "confirm")
        $msg_success .= "<p class=\"text-center lead\">".$texts['PAYMENT_SUCCESS_NOTICE']."</p>";
    elseif($_GET['action'] == "cancel")
        $msg_error .= "<p class=\"text-center lead\">".$texts['PAYMENT_CANCEL_NOTICE']."</p>";
}

$result_rating = $db->prepare("SELECT AVG(rating) as avg_rating FROM pm_comment WHERE item_type = 'hotel' AND id_item = :id_hotel AND checked = 1 AND rating > 0 AND rating <= 5");
$result_rating->bindParam(":id_hotel", $id_hotel);
                
$id_facility = 0;
$result_facility_file = $db->prepare("SELECT * FROM pm_facility_file WHERE id_item = :id_facility AND checked = 1 AND lang = ".DEFAULT_LANG." AND type = 'image' AND file != '' ORDER BY rank LIMIT 1");
$result_facility_file->bindParam(":id_facility", $id_facility);

$room_facilities = "0";
$result_room_facilities = $db->prepare("SELECT * FROM pm_facility WHERE lang = ".LANG_ID." AND FIND_IN_SET(id, :room_facilities) ORDER BY rank LIMIT 18");
$result_room_facilities->bindParam(":room_facilities", $room_facilities);

$hotel_facilities = "0";
$result_hotel_facilities = $db->prepare("SELECT * FROM pm_facility WHERE lang = ".LANG_ID." AND FIND_IN_SET(id, :hotel_facilities) ORDER BY rank LIMIT 8");
$result_hotel_facilities->bindParam(":hotel_facilities", $hotel_facilities);

$query_room = "SELECT * FROM pm_room WHERE id_hotel = :id_hotel AND checked = 1 AND lang = ".LANG_ID." ORDER BY";
if(isset($res_hotel[$id_hotel])) $query_room .= " CASE WHEN id IN(".implode(",", array_keys($res_hotel[$id_hotel])).") THEN 3 ELSE 4 END,";
$query_room .= " rank";
$result_room = $db->prepare($query_room);
$result_room->bindParam(":id_hotel", $id_hotel);

$id_room = 0;
$result_room_rate = $db->prepare("
    SELECT DISTINCT(price), type
    FROM pm_rate
    WHERE
        id_room = :id_room
        AND price IN(SELECT MIN(price) FROM pm_rate WHERE id_room = :id_room)
    ORDER BY price, CASE type
        WHEN 'week' THEN 1
        WHEN 'mid-week' THEN 2
        WHEN 'week-end' THEN 3
        WHEN '2-nights' THEN 4
        WHEN 'night' THEN 5
        ELSE 6 END
    LIMIT 1");
$result_room_rate->bindParam(":id_room", $id_room);

$result_hotel_rate = $db->prepare("
    SELECT DISTINCT(ra.price), type
    FROM pm_rate as ra, pm_room as ro
    WHERE ro.id = id_room
        AND id_hotel = :id_hotel
        AND ra.price IN(SELECT MIN(ra.price) FROM pm_rate as ra, pm_room as ro WHERE ro.id = id_room AND id_hotel = :id_hotel)
    ORDER BY ra.price, CASE type
        WHEN 'week' THEN 1
        WHEN 'mid-week' THEN 2
        WHEN 'week-end' THEN 3
        WHEN '2-nights' THEN 4
        WHEN 'night' THEN 5
        ELSE 6 END
    LIMIT 1");
$result_hotel_rate->bindParam(":id_hotel", $id_hotel);

$result_room_file = $db->prepare("SELECT * FROM pm_room_file WHERE id_item = :id_room AND checked = 1 AND lang = ".LANG_ID." AND type = 'image' AND file != '' ORDER BY rank LIMIT 1");
$result_room_file->bindParam(":id_room", $id_room);

$result_hotel_file = $db->prepare("SELECT * FROM pm_hotel_file WHERE id_item = :id_hotel AND checked = 1 AND lang = ".LANG_ID." AND type = 'image' AND file != '' ORDER BY rank LIMIT 1");
$result_hotel_file->bindParam(":id_hotel", $id_hotel);

$query_hotel = "SELECT * FROM pm_hotel WHERE checked = 1 AND lang = ".LANG_ID;
$query_hotel .= " ORDER BY";
if($hotel_id != 0) $query_hotel .= " CASE WHEN id = ".$hotel_id." THEN 1 ELSE 2 END,";
if(!empty($res_hotel)) $query_hotel .= " CASE WHEN id IN(".implode(",", array_keys($res_hotel)).") THEN 3 ELSE 4 END,";
$query_hotel .= " rank";
$result_hotel = $db->query($query_hotel);
if($result_hotel !== false && $db->last_row_count() == 0){
    $msg_error .= $texts['NO_HOTEL_FOUND'];
    if($destination_name != "") $msg_error .= " ".$texts['FOR']." <b>".$destination_name."</b>";
}

/* ==============================================
 * CSS AND JAVASCRIPT USED IN THIS MODEL
 * ==============================================
 */
$javascripts[] = DOCBASE."js/plugins/jquery.event.calendar/js/jquery.event.calendar.js";

if(is_file(SYSBASE."js/plugins/jquery.event.calendar/js/languages/jquery.event.calendar.".LANG_TAG.".js"))
    $javascripts[] = DOCBASE."js/plugins/jquery.event.calendar/js/languages/jquery.event.calendar.".LANG_TAG.".js";
else
    $javascripts[] = DOCBASE."js/plugins/jquery.event.calendar/js/languages/jquery.event.calendar.en.js";
    
$stylesheets[] = array("file" => DOCBASE."js/plugins/jquery.event.calendar/css/jquery.event.calendar.css", "media" => "all");

$stylesheets[] = array("file" => DOCBASE."js/plugins/star-rating/css/star-rating.min.css", "media" => "all");
$javascripts[] = DOCBASE."js/plugins/star-rating/js/star-rating.min.js";

$stylesheets[] = array("file" => DOCBASE."js/plugins/owl-carousel/owl.carousel.css", "media" => "all");
$stylesheets[] = array("file" => DOCBASE."js/plugins/owl-carousel/owl.theme.css", "media" => "all");
$javascripts[] = DOCBASE."js/plugins/owl-carousel/owl.carousel.min.js";

$stylesheets[] = array("file" => DOCBASE."js/plugins/live-search/jquery.liveSearch.css", "media" => "all");
$javascripts[] = DOCBASE."js/plugins/live-search/jquery.liveSearch.js";

require(getFromTemplate("common/header.php", false)); ?>

<section id="page">

    
    <?php include(getFromTemplate("common/page_header.php", false)); ?>
    
    <div id="content" class="pb30">
        
        <div id="search-page" class="mb30">
            <div class="container">
                <?php include(getFromTemplate("common/search.php", false)); ?>
            </div>
        </div>
        
        <div class="container boxed mb20">
            <p>
                <?php echo $texts['CHECK_IN']." <b>".$from_date."</b> ".$texts['CHECK_OUT']." <b>".$to_date."</b><br>";
                if(isset($num_nights) && $num_nights > 0) echo "<b>".$num_nights."</b> ".$texts['NIGHTS']." - ";
                echo "<b>".($num_adults+$num_children)."</b> ".$texts['PERSONS']; ?>
            </p>
            <div class="alert alert-success" style="display:none;"></div>
            <div class="alert alert-danger" style="display:none;"></div>
        </div>
        
        <?php
        if($page['text'] != ""){ ?>
            <div class="container mb20"><?php echo $page['text']; ?></div>
            <?php
        }
        
        if($result_hotel !== false){
            foreach($result_hotel as $i => $row){
                $id_hotel = $row['id'];
                $hotel_title = $row['title'];
                $hotel_alias = $row['alias'];
                $hotel_subtitle = $row['subtitle'];
                $hotel_descr = $row['descr'];
                $hotel_facilities = $row['facilities']; ?>
                    
                <div class="container boxed mb20 booking-result">
                    <div class="row">
                        <div class="col-sm-4 mb10">
                            <?php
                            $result_hotel_file->execute();
                            if($result_hotel_file !== false && $db->last_row_count() > 0){
                                $row = $result_hotel_file->fetch(PDO::FETCH_ASSOC);

                                $file_id = $row['id'];
                                $filename = $row['file'];
                                $label = $row['label'];

                                $realpath = SYSBASE."medias/hotel/medium/".$file_id."/".$filename;
                                $thumbpath = DOCBASE."medias/hotel/medium/".$file_id."/".$filename;
                                $zoompath = DOCBASE."medias/hotel/big/".$file_id."/".$filename;

                                if(is_file($realpath)){ ?>
                                    <div class="img-container md">
                                        <img alt="<?php echo $label; ?>" src="<?php echo $thumbpath; ?>" itemprop="photo">
                                    </div>
                                    <?php
                                }
                            } ?>
                        </div>
                        <div class="col-sm-4 col-md-5">
                            <h3><?php echo $hotel_title; ?></h3>
                            <h4><?php echo $hotel_subtitle; ?></h4>
                            <?php echo strtrunc(strip_tags($hotel_descr), 120); ?>
                            <div class="clearfix mt10">
                                <?php
                                $result_hotel_facilities->execute();
                                if($result_hotel_facilities !== false && $db->last_row_count() > 0){
                                    foreach($result_hotel_facilities as $row){
                                        $id_facility = $row['id'];
                                        $facility_name = $row['name'];
                                        
                                        $result_facility_file->execute();
                                        if($result_facility_file !== false && $db->last_row_count() > 0){
                                            $row = $result_facility_file->fetch();
                                            
                                            $file_id = $row['id'];
                                            $filename = $row['file'];
                                            $label = $row['label'];
                                            
                                            $realpath = SYSBASE."medias/facility/big/".$file_id."/".$filename;
                                            $thumbpath = DOCBASE."medias/facility/big/".$file_id."/".$filename;
                                                
                                            if(is_file($realpath)){ ?>
                                                <span class="facility-icon">
                                                    <img alt="<?php echo $facility_name; ?>" title="<?php echo $facility_name; ?>" src="<?php echo $thumbpath; ?>" class="tips">
                                                </span>
                                                <?php
                                            }
                                        }
                                    } ?>
                                    <span class="facility-icon">
                                        <a href="<?php echo DOCBASE.LANG_ALIAS.text_format($hotel_alias); ?>" title="<?php echo $texts['READMORE']; ?>" class="tips">...</a>
                                    </span>
                                    <?php
                                } ?>
                            </div>
                        </div>
                        <div class="col-sm-4 col-md-3 text-center sep">
                            <div class="price text-primary">
                                <?php
                                $min_price = 0;
                                $result_hotel_rate->execute();
                                if($result_hotel_rate !== false && $db->last_row_count() > 0){
                                    $row = $result_hotel_rate->fetch();
                                    $price = $row['price'];
                                    if($price > 0) $min_price = $price;
                                }
                                if($min_price > 0){
                                    echo $texts['FROM_PRICE']; ?>
                                    <span itemprop="priceRange">
                                        <?php echo formatPrice($min_price*CURRENCY_RATE); ?>
                                    </span>
                                    / <?php echo $texts['NIGHT'];
                                } ?>
                            </div>
                            <?php
                            $result_rating->execute();
                            if($result_rating !== false && $db->last_row_count() > 0){
                                $row = $result_rating->fetch();
                                $hotel_rating = $row['avg_rating'];
                                
                                if($hotel_rating > 0 && $hotel_rating <= 5){ ?>
                                
                                    <input type="hidden" class="rating" value="<?php echo $hotel_rating; ?>" data-rtl="<?php echo (RTL_DIR) ? true : false; ?>" data-size="xs" readonly="true">
                                    <?php
                                }
                            } ?>
                            <a class="btn btn-primary mt10 btn-block" href="<?php echo DOCBASE.LANG_ALIAS.text_format($hotel_alias); ?>">
                                <i class="fa fa-plus-circle"></i>
                                <?php echo $texts['READMORE']; ?>
                            </a>
                        </div>
                        <div class="col-md-12">
                            <a data-toggle="collapse" data-target="#collapse-<?php echo $id_hotel; ?>" href="#collapse-<?php echo $id_hotel; ?>" class="btn-toggle btn-warning<?php if($i > 0) echo " collapsed"; ?>">
                                <i class="fa fa-angle-down"></i>
                            </a>
                        </div>
                        <div class="col-md-12 panel-collapse<?php if($i > 0) echo " collapse"; ?>" id="collapse-<?php echo $id_hotel; ?>">
                            <div class="boxed">
                                <?php
                                $result_room->execute();
                                if($result_room !== false){
                                    foreach($result_room as $row){
                                        
                                        $id_room = $row['id'];
                                        $room_title = $row['title'];
                                        $room_alias = $row['alias'];
                                        $room_subtitle = $row['subtitle'];
                                        $room_descr = $row['descr'];
                                        $room_price = $row['price'];
                                        $room_stock = $row['stock'];
                                        $max_adults = $row['max_adults'];
                                        $max_children = $row['max_children'];
                                        $max_people = $row['max_people'];
                                        $min_people = $row['min_people'];
                                        $room_facilities = $row['facilities'];
                                
                                        $min_price = $room_price;
                                        $result_room_rate->execute();
                                        if($result_room_rate !== false && $db->last_row_count() > 0){
                                            $row = $result_room_rate->fetch();
                                            $price = $row['price'];
                                            if($price > 0) $min_price = $price;
                                        }
                                        $type = $texts['NIGHT'];
                                        if(!isset($res_hotel[$id_hotel][$id_room])
                                        || isset($res_hotel[$id_hotel][$id_room]['error'])
                                        || ($num_adults+$num_children > $max_people)
                                        || ($num_adults+$num_children < $min_people)
                                        || ($num_adults > $max_adults)
                                        || ($num_children > $max_children)){
                                            $amount = $min_price;
                                            $full_price = 0;
                                        }else{
                                            $amount = $res_hotel[$id_hotel][$id_room]['amount']+$res_hotel[$id_hotel][$id_room]['fixed_sup_amount'];
                                            $full_price = $res_hotel[$id_hotel][$id_room]['full_price']+$res_hotel[$id_hotel][$id_room]['fixed_sup_amount'];
                                            $type = $num_nights." ".$texts['NIGHTS'];
                                        } ?>

                                        <form action="<?php echo DOCBASE.$sys_pages['booking']['alias']; ?>" method="post">
                                            <input type="hidden" name="hotel" value="<?php echo $hotel_title; ?>">
                                            <input type="hidden" name="id_hotel" value="<?php echo $id_hotel; ?>">
                                            <input type="hidden" name="room" value="<?php echo $room_title; ?>">
                                            <input type="hidden" name="id_room" value="<?php echo $id_room; ?>">
                                            <input type="hidden" name="from_date" value="<?php echo $from_time; ?>">
                                            <input type="hidden" name="to_date" value="<?php echo $to_time; ?>">
                                            <input type="hidden" name="nights" value="<?php echo $num_nights; ?>">
                                            <input type="hidden" name="adults" value="<?php echo $num_adults; ?>">
                                            <input type="hidden" name="children" value="<?php echo $num_children; ?>">
                                            <?php
                                            if(isset($res_hotel[$id_hotel][$id_room]) && !isset($res_hotel[$id_hotel][$id_room]['error'])){ ?>
                                                <input type="hidden" name="amount" value="<?php echo number_format($res_hotel[$id_hotel][$id_room]['amount']+$res_hotel[$id_hotel][$id_room]['fixed_sup_amount'], 10, ".", ""); ?>">
                                                <input type="hidden" name="vat_amount" value="<?php echo number_format($res_hotel[$id_hotel][$id_room]['vat_amount']+$res_hotel[$id_hotel][$id_room]['fixed_sup_vat'], 10, ".", ""); ?>">
                                                <?php
                                            } ?>
                                            <div class="row room-result">
                                                <div class="col-md-3">
                                                    <?php
                                                    $result_room_file->execute();
                                                    if($result_room_file !== false && $db->last_row_count() > 0){
                                                        $row = $result_room_file->fetch(PDO::FETCH_ASSOC);

                                                        $file_id = $row['id'];
                                                        $filename = $row['file'];
                                                        $label = $row['label'];

                                                        $realpath = SYSBASE."medias/room/medium/".$file_id."/".$filename;
                                                        $thumbpath = DOCBASE."medias/room/medium/".$file_id."/".$filename;
                                                        $zoompath = DOCBASE."medias/room/big/".$file_id."/".$filename;

                                                        if(is_file($realpath)){ ?>
                                                            <div class="img-container md">
                                                                <img alt="<?php echo $label; ?>" src="<?php echo $thumbpath; ?>" itemprop="photo">
                                                            </div>
                                                            <?php
                                                        }
                                                    } ?>
                                                </div>
                                                <div class="col-lg-4 col-md-3 col-sm-4">
                                                    <h4><?php echo $room_title; ?></h4>
                                                    <p><?php echo $room_subtitle; ?></p>
                                                    <?php echo strtrunc(strip_tags($room_descr), 100); ?>
                                                    <div class="clearfix mt10">
                                                        <?php
                                                        $result_room_facilities->execute();
                                                        if($result_room_facilities !== false && $db->last_row_count() > 0){
                                                            foreach($result_room_facilities as $row){
                                                                $id_facility = $row['id'];
                                                                $facility_name = $row['name'];
                                                                
                                                                $result_facility_file->execute();
                                                                if($result_facility_file !== false && $db->last_row_count() > 0){
                                                                    $row = $result_facility_file->fetch();
                                                                    
                                                                    $file_id = $row['id'];
                                                                    $filename = $row['file'];
                                                                    $label = $row['label'];
                                                                    
                                                                    $realpath = SYSBASE."medias/facility/big/".$file_id."/".$filename;
                                                                    $thumbpath = DOCBASE."medias/facility/big/".$file_id."/".$filename;
                                                                        
                                                                    if(is_file($realpath)){ ?>
                                                                        <span class="facility-icon">
                                                                            <img alt="<?php echo $facility_name; ?>" title="<?php echo $facility_name; ?>" src="<?php echo $thumbpath; ?>" class="tips">
                                                                        </span>
                                                                        <?php
                                                                    }
                                                                }
                                                            }
                                                        } ?>
                                                    </div>
                                                </div>
                                                <div class="col-lg-2 col-md-2 col-sm-3 text-center sep">
                                                    <div class="price">
                                                        <span itemprop="priceRange"><?php echo formatPrice($amount*CURRENCY_RATE); ?></span>
                                                        <?php
                                                        if($full_price > 0 && $full_price > $amount){ ?>
                                                            <br><s class="text-warning"><?php echo formatPrice($full_price*CURRENCY_RATE); ?></s>
                                                            <?php
                                                        } ?>
                                                    </div>
                                                    <div class="mb10 text-muted"><?php echo $texts['PRICE']." / ".$type; ?></div>
                                                    <?php echo $texts['CAPACITY']; ?> : <i class="fa fa-male"></i>x<?php echo $max_people; ?>
                                                    <p class="lead pt10">
                                                 
                                                       
                                                            <button name="book" class="btn btn-success btn-lg btn-block"><i class="fa fa-hand-o-right"></i> <?php echo $texts['BOOK'] ?></button>
                                                           
                                                        <span class="clearfix"></span>
                                                        <a class="btn btn-primary mt10 btn-block popup-modal btn-sm" href="#room-<?php echo $id_room; ?>">
                                                            <i class="fa fa-plus-circle"></i>
                                                            <?php echo $texts['READMORE']; ?>
                                                        </a>
                                                    </p>
                                                    <div id="room-<?php echo $id_room; ?>" class="white-popup-block mfp-hide">
                                                        <div class="fluid-container">
                                                            <div class="row">
                                                                <div class="col-xs-12 mb20">
                                                                    <div class="owl-carousel" data-items="1" data-autoplay="true" data-dots="true" data-nav="false" data-rtl="<?php echo (RTL_DIR) ? "true" : "false"; ?>">
                                                                        <?php
                                                                        $result_room_file->execute();
                                                                        if($result_room_file !== false){
                                                                            foreach($result_room_file as $i => $row){
                                                        
                                                                                $file_id = $row['id'];
                                                                                $filename = $row['file'];
                                                                                $label = $row['label'];
                                                                                
                                                                                $realpath = SYSBASE."medias/room/medium/".$file_id."/".$filename;
                                                                                $thumbpath = DOCBASE."medias/room/medium/".$file_id."/".$filename;
                                                                                
                                                                                if(is_file($realpath)){ ?>
                                                                                    <div><img alt="<?php echo $label; ?>" src="<?php echo $thumbpath; ?>" class="img-responsive" style="max-height:600px;"></div>
                                                                                    <?php
                                                                                }
                                                                            }
                                                                        } ?>
                                                                    </div>
                                                                </div>
                                                                <div class="col-sm-8">
                                                                    <h3 class="mb0"><?php echo $room_title; ?></h3>
                                                                    <h4 class="mb0"><?php echo $room_subtitle; ?></h4>
                                                                </div>
                                                                <div class="col-sm-4 text-right">
                                                                    <?php
                                                                    $min_price = $room_price;
                                                                    $result_room_rate->execute();
                                                                    if($result_room_rate !== false && $db->last_row_count() > 0){
                                                                        $row = $result_room_rate->fetch();
                                                                        $price = $row['price'];
                                                                        if($price > 0) $min_price = $price;
                                                                    } ?>
                                                                    <div class="price text-primary">
                                                                        <?php echo $texts['FROM_PRICE']; ?>
                                                                        <span itemprop="priceRange">
                                                                            <?php echo formatPrice($min_price*CURRENCY_RATE); ?>
                                                                        </span>
                                                                        / <?php echo $texts['NIGHT']; ?>
                                                                    </div>
                                                                    <p>
                                                                        <?php echo $texts['CAPACITY']; ?> : <i class="fa fa-male"></i>x<?php echo $max_people; ?>
                                                                    </p>
                                                                </div>
                                                                <div class="col-xs-12">
                                                                    <div class="clearfix mb5">
                                                                        <?php
                                                                        $result_room_facilities->execute();
                                                                        if($result_room_facilities !== false && $db->last_row_count() > 0){
                                                                            foreach($result_room_facilities as $row){
                                                                                $id_facility = $row['id'];
                                                                                $facility_name = $row['name'];
                                                                                
                                                                                $result_facility_file->execute();
                                                                                if($result_facility_file !== false && $db->last_row_count() > 0){
                                                                                    $row = $result_facility_file->fetch();
                                                                                    
                                                                                    $file_id = $row['id'];
                                                                                    $filename = $row['file'];
                                                                                    $label = $row['label'];
                                                                                    
                                                                                    $realpath = SYSBASE."medias/facility/big/".$file_id."/".$filename;
                                                                                    $thumbpath = DOCBASE."medias/facility/big/".$file_id."/".$filename;
                                                                                        
                                                                                    if(is_file($realpath)){ ?>
                                                                                        <span class="facility-icon">
                                                                                            <img alt="<?php echo $facility_name; ?>" title="<?php echo $facility_name; ?>" src="<?php echo $thumbpath; ?>" class="tips">
                                                                                        </span>
                                                                                        <?php
                                                                                    }
                                                                                }
                                                                            }
                                                                        } ?>
                                                                    </div>
                                                                    <?php echo $room_descr; ?>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                             
                                            </div>
                                            <hr>
                                        </form>
                                        <?php
                                    }
                                } ?>
                            </div>
                        </div>
                    </div>
                </div>
                <?php
            }
        } ?>
    </div>
</section>
