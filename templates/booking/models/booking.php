<?php
$field_notice = array();
$msg_error = "";
$msg_success = "";
$response = "";
$room_stock = 1;
$max_adults = 15;
$max_children = 14;
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

if(isset($_POST['room_id']) && is_numeric($_POST['room_id'])) $room_id = $_POST['room_id'];
else $room_id = 0;

if(isset($_POST['book'])){
    $num_adults = $_POST['adults'];
    $num_children = $_POST['children'];
    $num_nights = $_POST['nights'];
    
    $_SESSION['book']['room'] = $_POST['room'];
    $_SESSION['book']['room_id'] = $_POST['id_room'];
    $_SESSION['book']['from_date'] = $_POST['from_date'];
    $_SESSION['book']['to_date'] = $_POST['to_date'];
    $_SESSION['book']['nights'] = $num_nights;
    $_SESSION['book']['adults'] = $num_adults;
    $_SESSION['book']['children'] = $num_children;
    $_SESSION['book']['amount'] = $_POST['amount'];
    $_SESSION['book']['vat_amount'] = $_POST['vat_amount'];
    $_SESSION['book']['vat_total'] = $_POST['vat_amount'];
    
    $tourist_tax = (TOURIST_TAX_TYPE == "fixed") ? $num_adults*$num_nights*TOURIST_TAX : $_SESSION['book']['amount']*TOURIST_TAX/100;
    
    $_SESSION['book']['tourist_tax'] = $tourist_tax;
    $_SESSION['book']['extra_services'] = array();
    $_SESSION['book']['total'] = $_SESSION['book']['amount']+$tourist_tax;
    
    $_SESSION['book']['down_payment'] = (ENABLE_DOWN_PAYMENT == 1 && DOWN_PAYMENT_RATE > 0) ? $_SESSION['book']['total']*DOWN_PAYMENT_RATE/100 : 0;
    
    if(isset($_SESSION['book']['id'])) unset($_SESSION['book']['id']);

    header("Location: ".DOCBASE.$sys_pages['details']['alias']);
    exit();
}

$num_people = $num_adults+$num_children;

if(!is_numeric($num_adults)) $field_notice['num_adults'] = $texts['REQUIRED_FIELD'];
if(!is_numeric($num_children)) $field_notice['num_children'] = $texts['REQUIRED_FIELD'];

if($from_date == "") $field_notice['from_date'] = $texts['REQUIRED_FIELD'];
else{
    $from_time = explode("/", $from_date);
    $from_time = mktime(0, 0, 0, $from_time[1], $from_time[0], $from_time[2]);
    if(!is_numeric($from_time)) $field_notice['from_date'] = $texts['REQUIRED_FIELD'];
}
if($to_date == "") $field_notice['to_date'] = $texts['REQUIRED_FIELD'];
else{
    $to_time = explode("/", $to_date);
    $to_time = mktime(0, 0, 0, $to_time[1], $to_time[0], $to_time[2]);
    if(!is_numeric($to_time)) $field_notice['to_date'] = $texts['REQUIRED_FIELD'];
}

$period = $to_time-$from_time;
if(date("I", $to_time) XOR date("I", $from_time)) $period -= 3600;
$num_nights = ceil($period/86400);

if(count($field_notice) == 0){

    if($num_nights <= 0) $msg_error .= $texts['NO_AVAILABILITY'];
    else{
        $days = array();
        $booked = array();

        $query_book = "SELECT stock, id_room, from_date, to_date FROM pm_booking as b, pm_room as r WHERE lang = ".DEFAULT_LANG." AND id_room = r.id AND status = 4 AND r.checked = 1 AND from_date < ".$to_time." AND to_date > ".$from_time." GROUP BY b.id";
        $result_book = $db->query($query_book);
        if($result_book !== false){
            foreach($result_book as $i => $row){
                $start_date = $row['from_date'];
                $end_date = $row['to_date'];
                $id_room = $row['id_room'];
                $room_stock = $row['stock'];
                $d = 0;
                $dst = false;

                $start = ($start_date < $from_time) ? $from_time : $start_date;
                $end = ($end_date > $to_time) ? $to_time : $end_date;
                
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
        $res_room = array();
        $query_rate = "SELECT DISTINCT id_room, start_date, end_date, ra.price, type, people, price_sup, fixed_sup, vat_rate, min_stay, day_start, day_end FROM pm_rate as ra, pm_room as ro WHERE id_room = ro.id AND ro.checked = 1 AND start_date <= ".$to_time." AND end_date >= ".$from_time;
        if(!empty($booked)) $query_rate .= " AND id_room NOT IN(".implode(",", array_keys($booked)).")";
        $query_rate .= "
            ORDER BY CASE type
            WHEN 'week' THEN 1
            WHEN 'mid-week' THEN 2
            WHEN 'week-end' THEN 3
            WHEN '2-nights' THEN 4
            WHEN 'nights' THEN 5
            ELSE 6 END";

        $result_rate = $db->query($query_rate);
        if($result_rate !== false){
            foreach($result_rate as $i => $row){

                $id_room = $row['id_room'];
                $start_date = $row['start_date'];
                $end_date = $row['end_date'];
                $price = $row['price'];
                $type = $row['type'];
                $people = $row['people'];
                $price_sup = $row['price_sup'];
                $fixed_sup = $row['fixed_sup'];
                $day_start = $row['day_start'];
                $day_end = $row['day_end'];
                $vat_rate = $row['vat_rate'];
                $min_stay = $row['min_stay'];

                if(($day_start == 0 || date("N", $from_time) == $day_start) && ($day_end == 0 || date("N", $to_time) == $day_end)){

                    if((($type == "week-end" && $num_nights <= 2)
                    || ($type == "2-nights" && $num_nights >= 2 && $num_nights < 4)
                    || ($type == "mid-week" && $num_nights >= 4 && $num_nights < 7)
                    || ($type == "week" && $num_nights >= 7))
                    XOR ($type == "night")){
                    
                        $start = ($start_date < $from_time) ? $from_time : $start_date;
                        $end = ($end_date > $to_time) ? $to_time : $end_date;
                        if($start_date > $from_time) $start-= 86400;
                        $period = $end-$start;
                        if(date("I", $start) XOR date("I", $end)) $period -= 3600;

                        $nnights = ceil($period/86400);
                       
                        if($type == "week-end" || $type == "2-nights") $price = $price/2;
                        if($type == "mid-week") $price = $price/4;
                        if($type == "week") $price = $price/7;

                        if($people > 0 && $price_sup > 0 && $num_people > $people)
                            $price += $price_sup*($num_people-$people);
                        
                        $price = $nnights*$price;
                        $vat_amount = $price-($price/($vat_rate/100+1));

                        if(!isset($res_room[$id_room]['total_nights']) || $res_room[$id_room]['total_nights']+$nnights <= $num_nights){
                            if(isset($res_room[$id_room]['amount'])) $res_room[$id_room]['amount'] += $price;
                            else $res_room[$id_room]['amount'] = $price;
                            if(isset($res_room[$id_room]['total_nights'])) $res_room[$id_room]['total_nights'] += $nnights;
                            else $res_room[$id_room]['total_nights'] = $nnights;
                            if(isset($res_room[$id_room]['vat_amount'])) $res_room[$id_room]['vat_amount'] += $vat_amount;
                            else $res_room[$id_room]['vat_amount'] = $vat_amount;
                            $res_room[$id_room]['min_stay'] = ((isset($res_room[$id_room]['min_stay']) && $min_stay > $res_room[$id_room]['min_stay']) || !isset($res_room[$id_room]['min_stay'])) ? $min_stay : 0;
                            if((isset($res_room[$id_room]['fixed_sup']) && $fixed_sup > $res_room[$id_room]['fixed_sup']) || !isset($res_room[$id_room]['fixed_sup'])){
                                $res_room[$id_room]['fixed_sup_amount'] = $fixed_sup;
                                $res_room[$id_room]['fixed_sup_vat'] = $fixed_sup-($fixed_sup/($vat_rate/100+1));
                            }else{
                                $res_room[$id_room]['fixed_sup_amount'] = 0;
                                $res_room[$id_room]['fixed_sup_vat'] = 0;
                            }
                        }
                    }
                }
            }
            
            foreach($res_room as $id_room => $result){
                if($result['amount'] == 0 || $result['total_nights'] != $num_nights) unset($res_room[$id_room]);
            }

            if(empty($res_room)) $msg_error .= $texts['NO_AVAILABILITY'];
        }
    }
}

/* ==============================================
 * CSS AND JAVASCRIPT USED IN THIS MODEL
 * ==============================================
 */
$javascripts[] = DOCBASE."js/plugins/jquery.event.calendar/js/jquery.event.calendar.js";
$javascripts[] = DOCBASE."js/plugins/jquery.event.calendar/js/languages/jquery.event.calendar.".LANG_TAG.".js";
$stylesheets[] = array("file" => DOCBASE."js/plugins/jquery.event.calendar/css/jquery.event.calendar.css", "media" => "all");

require(SYSBASE."templates/".TEMPLATE."/common/header.php"); ?>

<section id="page">
    
    <?php include(SYSBASE."templates/".TEMPLATE."/common/page_header.php"); ?>
    
    <div id="content" class="pt30 pb30">
        
        <?php
        if($page['text'] != ""){ ?>
            <div class="container mb20"><?php echo $page['text']; ?></div>
            <?php
        } ?>
        
        <div class="container boxed mb20">
            <legend><?php echo $texts['AVAILABILITIES']; ?></legend>
            <div class="alert alert-success" style="display:none;"></div>
            <div class="alert alert-danger" style="display:none;"></div>
            <?php include(SYSBASE."templates/".TEMPLATE."/common/search.php"); ?>
        </div>
        <div class="container boxed">
            <div class="mb20">
                <p>
                    <?php echo $texts['CHECK_IN']." <b>".$from_date."</b> ".$texts['CHECK_OUT']." <b>".$to_date."</b><br>";
                    if(isset($num_nights) && $num_nights > 0) echo "<b>".$num_nights."</b> ".$texts['NIGHTS']." - ";
                    echo "<b>".($num_adults+$num_children)."</b> ".$texts['PERSONS']; ?>
                </p>
            </div>
            <?php
            $id_facility = 0;
            $result_facility_file = $db->prepare("SELECT * FROM pm_facility_file WHERE id_item = :id_facility AND checked = 1 AND lang = ".DEFAULT_LANG." AND type = 'image' AND file != '' ORDER BY rank LIMIT 1");
            $result_facility_file->bindParam(":id_facility", $id_facility);

            $room_facilities = "0";
            $result_facility = $db->prepare("SELECT * FROM pm_facility WHERE lang = ".LANG_ID." AND FIND_IN_SET(id, :room_facilities) ORDER BY rank LIMIT 8");
            $result_facility->bindParam(":room_facilities", $room_facilities);

            $id_room = 0;
            $result_rate = $db->prepare("SELECT DISTINCT(price), type FROM pm_rate WHERE id_room = :id_room AND price IN(SELECT MIN(price) FROM pm_rate WHERE id_room = :id_room)");
            $result_rate->bindParam(":id_room", $id_room);

            $result_room_file = $db->prepare("SELECT * FROM pm_room_file WHERE id_item = :id_room AND checked = 1 AND lang = ".LANG_ID." AND type = 'image' AND file != '' ORDER BY rank LIMIT 1");
            $result_room_file->bindParam(":id_room", $id_room, PDO::PARAM_STR);

            $query_room = "SELECT * FROM pm_room WHERE checked = 1 AND lang = ".LANG_ID." ORDER BY";
            if($room_id != 0) $query_room .= " CASE WHEN id = ".$room_id." THEN 1 ELSE 2 END,";
            if(!empty($res_room)) $query_room .= " CASE WHEN id IN(".implode(",", array_keys($res_room)).") THEN 3 ELSE 4 END,";
            $query_room .= " rank";
            $result_room = $db->query($query_room);
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
                    
                    $type = "night";
                    $min_price = $room_price;
                    $result_rate->execute();
                    if($result_rate !== false && $db->last_row_count() == 1){
                        $row = $result_rate->fetch();
                        $price = $row['price'];
                        $type = $row['type'];
                        if($price > 0){
                            switch($type){
                                case "night": $type = $texts['NIGHT']; break;
                                case "week": $type = $texts['WEEK']; break;
                            }
                            $min_price = $price;
                        }
                    }
                    if(!isset($res_room[$id_room]) || ($num_adults+$num_children > $max_people) || ($num_adults+$num_children < $min_people))
                        $amount = $min_price;
                    else{
                        $amount = $res_room[$id_room]['amount']+$res_room[$id_room]['fixed_sup_amount'];
                        $type = $num_nights." ".$texts['NIGHTS'];
                    } ?>

                    <form action="<?php echo DOCBASE.$sys_pages['booking']['alias']; ?>" method="post">
                        <?php
                        if(isset($res_room[$id_room])){ ?>
                            <input type="hidden" name="room" value="<?php echo $room_title; ?>">
                            <input type="hidden" name="id_room" value="<?php echo $id_room; ?>">
                            <input type="hidden" name="from_date" value="<?php echo $from_time; ?>">
                            <input type="hidden" name="to_date" value="<?php echo $to_time; ?>">
                            <input type="hidden" name="nights" value="<?php echo $num_nights; ?>">
                            <input type="hidden" name="adults" value="<?php echo $num_adults; ?>">
                            <input type="hidden" name="children" value="<?php echo $num_children; ?>">
                            <input type="hidden" name="amount" value="<?php echo number_format($res_room[$id_room]['amount']+$res_room[$id_room]['fixed_sup_amount'], 10, ".", ""); ?>">
                            <input type="hidden" name="vat_amount" value="<?php echo number_format($res_room[$id_room]['vat_amount']+$res_room[$id_room]['fixed_sup_vat'], 10, ".", ""); ?>">
                            <?php
                        } ?>
                        <div class="row booking-result">
                            <div class="col-md-3">
                                <?php
                                $result_room_file->execute();
                                if($result_room_file !== false && $db->last_row_count() == 1){
                                    $row = $result_room_file->fetch(PDO::FETCH_ASSOC);

                                    $file_id = $row['id'];
                                    $filename = $row['file'];
                                    $label = $row['label'];

                                    $realpath = SYSBASE."medias/room/medium/".$file_id."/".$filename;
                                    $thumbpath = DOCBASE."medias/room/medium/".$file_id."/".$filename;
                                    $zoompath = DOCBASE."medias/room/big/".$file_id."/".$filename;

                                    if(is_file($realpath)){ ?>
                                        <div class="img-container medium">
                                            <img alt="<?php echo $label; ?>" src="<?php echo $thumbpath; ?>" itemprop="photo">
                                        </div>
                                        <?php
                                    }
                                } ?>
                            </div>
                            <div class="col-lg-4 col-md-3 col-sm-4">
                                <h3><?php echo $room_title; ?></h3>
                                <h4><?php echo $room_subtitle; ?></h4>
                                <?php echo strtrunc(strip_tags($room_descr), 120); ?>
                                <div class="clearfix mt10">
                                    <?php
                                    $result_facility->execute();
                                    if($result_facility !== false && $db->last_row_count() > 0){
                                        foreach($result_facility as $row){
                                            $id_facility = $row['id'];
                                            $facility_name = $row['name'];
                                            
                                            $result_facility_file->execute();
                                            if($result_facility_file !== false && $db->last_row_count() == 1){
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
                                            <a href="<?php echo DOCBASE.$pages[9]['alias']."/".text_format($room_alias); ?>" title="<?php echo $texts['READMORE']; ?>" class="tips">...</a>
                                        </span>
                                        <?php
                                    } ?>
                                </div>
                            </div>
                            <div class="col-lg-2 col-md-2 col-sm-3 text-center sep">
                                <div class="price">
                                    <span itemprop="priceRange"><?php echo formatPrice($amount*CURRENCY_RATE); ?></span>
                                </div>
                                <div class="mb10 text-muted"><?php echo $texts['PRICE']; ?> / <?php echo $type; ?></div>
                                <?php echo $texts['CAPACITY']; ?> : <i class="fa fa-male"></i>x<?php echo $max_people; ?>
                                <p class="lead pt10">
                                    <?php
                                    if(!isset($res_room[$id_room])){ ?>
                                        <button class="btn btn-danger btn-block" disabled="disabled"><i class="fa fa-warning"></i> <?php echo $texts['NO_AVAILABILITY']; ?></small></button>
                                        <?php
                                    }elseif($num_adults+$num_children > $max_people){ ?>
                                        <button class="btn btn-danger btn-block" disabled="disabled"><i class="fa fa-warning"></i> <small><?php echo $texts['MAX_PEOPLE']; ?> : <?php echo $max_people; ?></small></button>
                                        <?php
                                    }elseif($num_adults+$num_children < $min_people){ ?>
                                        <button class="btn btn-danger btn-block" disabled="disabled"><i class="fa fa-warning"></i> <small><?php echo $texts['MIN_PEOPLE']; ?> : <?php echo $min_people; ?></small></button>
                                        <?php
                                    }elseif($res_room[$id_room]['min_stay'] > 0 && $num_nights < $res_room[$id_room]['min_stay']){ ?>
                                        <button class="btn btn-danger btn-block" disabled="disabled"><i class="fa fa-warning"></i> <small><?php echo $texts['MIN_NIGHTS']; ?> : <?php echo $res_room[$id_room]['min_stay']; ?></small></button>
                                        <?php
                                    }else{ ?>
                                        <button name="book" class="btn btn-success btn-lg btn-block"><i class="fa fa-hand-o-right"></i> <?php echo $texts['BOOK'] ?></button>
                                        <?php
                                    } ?>
                                    <span class="clearfix"></span>
                                    <a class="btn btn-primary mt10 btn-block" href="<?php echo DOCBASE.$pages[9]['alias']."/".text_format($room_alias); ?>">
                                        <i class="fa fa-plus-circle"></i>
                                        <?php echo $texts['READMORE']; ?>
                                    </a>
                                </p>
                            </div>
                            <div class="col-lg-3 col-md-4 col-sm-5 sep">
                                <div class="hb-calendar" data-cur_month="<?php echo date("n", $from_time); ?>" data-cur_year="<?php echo date("Y", $from_time); ?>" data-custom_var="room=<?php echo $id_room; ?>" data-day_loader="<?php echo DOCBASE."templates/".TEMPLATE."/common/get_days.php"; ?>"></div>
                            </div>
                        </div>
                        <hr>
                    </form>
                    <?php
                }
            } ?>
        </div>
    </div>
</section>
