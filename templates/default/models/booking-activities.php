<?php
if(!isset($_SESSION['book']) || count($_SESSION['book']) == 0){
    header("Location: ".DOCBASE.$sys_pages['booking']['alias']);
    exit();
}

if(isset($_POST['book'])){
    
    $_SESSION['book']['activities'] = array();
    $_SESSION['book']['amount_activities'] = 0;
    $_SESSION['book']['vat_activities'] = 0;
    
    if(isset($_POST['activities'])){
        
        foreach($_POST['activities'] as $activity){
            
            if(isset($_POST['amount_'.$activity]) && isset($_POST['adults_'.$activity]) && isset($_POST['children_'.$activity]) && isset($_POST['session_date_'.$activity]) && isset($_POST['duration_'.$activity]) && isset($_POST['vat_amount_'.$activity]) && isset($_POST['title_'.$activity])){
                
                $title = $_POST['title_'.$activity];
                $amount = $_POST['amount_'.$activity];
                $adults = $_POST['adults_'.$activity];
                $children = $_POST['children_'.$activity];
                $session_date = $_POST['session_date_'.$activity];
                $duration = $_POST['duration_'.$activity];
                $vat_amount = $_POST['vat_amount_'.$activity];
                
                if(is_numeric($amount) && $amount > 0 && is_numeric($adults) && is_numeric($children) && ($adults+$children > 0) && is_numeric($session_date) && $session_date > time() && $duration != "" && is_numeric($vat_amount) && $title != ""){
                    
                    $_SESSION['book']['activities'][$activity]['title'] = $title;
                    $_SESSION['book']['activities'][$activity]['amount'] = $amount;
                    $_SESSION['book']['activities'][$activity]['adults'] = $adults;
                    $_SESSION['book']['activities'][$activity]['children'] = $children;
                    $_SESSION['book']['activities'][$activity]['session_date'] = $session_date;
                    $_SESSION['book']['activities'][$activity]['duration'] = $duration;
                    $_SESSION['book']['activities'][$activity]['vat_amount'] = $vat_amount;
                    
                    $_SESSION['book']['amount_activities'] += $amount;
                    $_SESSION['book']['vat_activities'] += $vat_amount;
                }
            }
        }
    }
    $total = $_SESSION['book']['amount_rooms']+$_SESSION['book']['tourist_tax']+$_SESSION['book']['amount_activities']+$_SESSION['book']['amount_services'];
    $_SESSION['book']['down_payment'] = (ENABLE_DOWN_PAYMENT == 1 && DOWN_PAYMENT_RATE > 0) ? $total*DOWN_PAYMENT_RATE/100 : 0;
    
    header("Location: ".DOCBASE.$sys_pages['details']['alias']);
    exit();
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

require(getFromTemplate("common/header.php", false)); ?>

<script>
    $(function(){
        
        function toggleActivities(elm){
            if(elm.prop('checked') == true) elm.parents('.activity-result').addClass('active');
            else elm.parents('.activity-result').removeClass('active');
        }
        $('input[name="activities[]"]').on('change', function(){
            toggleActivities($(this));
        });
        $('input[name="activities[]"]').each(function(){
            toggleActivities($(this));
        });
            
        $('.activity-result').on('click', '.hb-d-free', function(){
            var container = $(this).parents('.activity-result');
            container.find('.hb-day').removeClass('active');
            $(this).addClass('active');
            var day = $(this).html();
            var month = container.find('.hb-current-month').attr('data-month');
            var year = container.find('.hb-current-month').attr('data-year');
            var time = new Date(year, month-1, day, 12, 0, 0, 0).getTime()/1000;
            container.find('input[name^="date"]').val(time).trigger('change');
        });
    });
</script>

<section id="page">
    
    <?php include(getFromTemplate("common/page_header.php", false)); ?>
    
    <div id="content" class="pt30 pb30">
        <div class="container">
            
            <div class="alert alert-success" style="display:none;"></div>
            <div class="alert alert-danger" style="display:none;"></div>
              
            <div class="row mb30" id="booking-breadcrumb">
                <div class="col-sm-2 col-sm-offset-1">
                    <a href="<?php echo DOCBASE.$sys_pages['booking']['alias']; ?>">
                        <div class="breadcrumb-item done">
                            <i class="fa fa-calendar"></i>
                            <span><?php echo $sys_pages['booking']['name']; ?></span>
                        </div>
                    </a>
                </div>
                <div class="col-sm-2">
                    <div class="breadcrumb-item active">
                        <i class="fa fa-ticket"></i>
                        <span><?php echo $sys_pages['booking-activities']['name']; ?></span>
                    </div>
                </div>
                <div class="col-sm-2">
                    <div class="breadcrumb-item">
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
            
            <form action="<?php echo DOCBASE.$sys_pages['booking-activities']['alias']; ?>" class="ajax-form" method="post">
                <?php
                $result_activity_file = $db->prepare("SELECT * FROM pm_activity_file WHERE id_item = :id_activity AND checked = 1 AND lang = ".LANG_ID." AND type = 'image' AND file != '' ORDER BY rank LIMIT 1");
                $result_activity_file->bindParam(":id_activity", $id_activity, PDO::PARAM_STR);
            
                $result_activity = $db->query("SELECT * FROM pm_activity WHERE hotels REGEXP '(^|,)".$_SESSION['book']['hotel_id']."(,|$)' AND checked = 1 AND lang = ".LANG_ID." ORDER BY rank");
                if($result_activity !== false){
                    foreach($result_activity as $i => $row){
                        
                        $id_activity = $row['id'];
                        $activity_title = $row['title'];
                        $activity_subtitle = $row['subtitle'];
                        $activity_descr = $row['descr'];
                        $activity_alias = $row['alias'];
                        $duration_value = $row['duration'];
                        $duration_unit = $row['duration_unit'];
                        $max_adults = $row['max_adults'];
                        $max_children = $row['max_children'];
                        $max_people = $row['max_people'];
                        
                        $action = getFromTemplate("common/get_activity_sessions.php")."?activity=".$id_activity;
                        
                        $min_price = $row['price'];
                        $result_rate = $db->query("
                            SELECT DISTINCT(price)
                            FROM pm_activity_session
                            WHERE id_activity = :id_activity
                                AND price IN(SELECT MIN(price) FROM pm_activity_session WHERE id_activity = :id_activity)
                            ORDER BY price
                            LIMIT 1");
                        if($result_rate !== false && $db->last_row_count() > 0){
                            $row = $result_rate->fetch();
                            $price = $row['price'];
                            if($price > 0) $min_price = $price;
                        } ?>
                        
                        <div class="row booking-result activity-result">
                            <div class="col-xs-1 sep text-center">
                                <div class="checkbox-container">
                                    <label for="activities_<?php echo $id_activity; ?>" class="checkbox-icon"></label>
                                </div>
                                <input type="checkbox" name="activities[]" id="activities_<?php echo $id_activity; ?>" class="hidden" value="<?php echo $id_activity; ?>"<?php if(isset($_SESSION['book']['activities']) && array_key_exists($id_activity, $_SESSION['book']['activities'])) echo " checked=\"checked\""; ?>>
                                <input type="hidden" name="duration_<?php echo $id_activity; ?>" value="<?php echo addslashes($duration_value." ".$duration_unit); ?>">
                                <input type="hidden" name="title_<?php echo $id_activity; ?>" value="<?php echo addslashes($activity_title); ?>">
                            </div>
                            <div class="col-md-3">
                                <?php
                                $result_activity_file->execute();
                                if($result_activity_file !== false && $db->last_row_count() > 0){
                                    $row = $result_activity_file->fetch(PDO::FETCH_ASSOC);

                                    $file_id = $row['id'];
                                    $filename = $row['file'];
                                    $label = $row['label'];

                                    $realpath = SYSBASE."medias/activity/medium/".$file_id."/".$filename;
                                    $thumbpath = DOCBASE."medias/activity/medium/".$file_id."/".$filename;
                                    $zoompath = DOCBASE."medias/activity/big/".$file_id."/".$filename;

                                    if(is_file($realpath)){ ?>
                                        <div class="img-container md">
                                            <img alt="<?php echo $label; ?>" src="<?php echo $thumbpath; ?>" itemprop="photo">
                                        </div>
                                        <?php
                                    }
                                } ?>
                            </div>
                            <div class="col-lg-3 col-md-2 col-sm-4">
                                <h3><?php echo $activity_title; ?></h3>
                                <h4><?php echo $activity_subtitle; ?></h4>
                                <p class="text-muted">
                                    <i class="fa fa-clock-o"></i> <?php echo $texts['DURATION']; ?> : <?php echo $duration_value." ".$duration_unit; ?>
                                </p>
                                <?php echo strtrunc(strip_tags($activity_descr), 120); ?>
                                <p>
                                    <span class="clearfix"></span>
                                    <a class="btn btn-primary mt10 btn-block btn-sm" href="<?php echo DOCBASE.$sys_pages['activities']['alias']."/".text_format($activity_alias); ?>">
                                        <i class="fa fa-plus-circle"></i>
                                        <?php echo $texts['READMORE']; ?>
                                    </a>
                                </p>
                            </div>
                            <div class="col-lg-2 col-md-2 col-sm-3 text-center sep">
                                <div class="price text-primary">
                                    <?php echo $texts['FROM']; ?>
                                    <span itemprop="priceRange"><?php echo formatPrice($min_price*CURRENCY_RATE); ?></span>
                                </div>
                                <div class="mb10 text-muted"><?php echo $texts['PRICE']." / ".$texts['PERSON']; ?></div>
                                <div class="form-group activity-data mt10">
                                    <div class="input-group input-group-sm">
                                        <div class="input-group-addon"><i class="fa fa-male"></i> <?php echo $texts['ADULTS']; ?></div>
                                        <select name="adults_<?php echo $id_activity; ?>" class="form-control sendAjaxForm selectpicker" data-target="#sessions-<?php echo $id_activity; ?>" data-action="<?php echo $action; ?>">
                                            <?php
                                            $num_adults = isset($_SESSION['book']['activities'][$id_activity]['adults']) ? $_SESSION['book']['activities'][$id_activity]['adults'] : 1;
                                            if($max_adults > 20) $max_adults = 20;
                                            for($j = 0; $j <= $max_adults; $j++){
                                                $select = ($j == $num_adults) ? " selected=\"selected\"" : "";
                                                echo "<option value=\"".$j."\"".$select.">".$j."</option>";
                                            } ?>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group activity-data">
                                    <div class="input-group input-group-sm">
                                        <div class="input-group-addon"><i class="fa fa-male"></i> <?php echo $texts['CHILDREN']; ?></div>
                                        <select name="children_<?php echo $id_activity; ?>" class="form-control sendAjaxForm selectpicker" data-target="#sessions-<?php echo $id_activity; ?>" data-action="<?php echo $action; ?>">
                                            <?php
                                            $num_children = isset($_SESSION['book']['activities'][$id_activity]['children']) ? $_SESSION['book']['activities'][$id_activity]['children'] : 0;
                                            if($max_children > 20) $max_children = 20;
                                            for($j = 0; $j <= $max_children; $j++){
                                                $select = ($j == $num_children) ? " selected=\"selected\"" : "";
                                                echo "<option value=\"".$j."\"".$select.">".$j."</option>";
                                            } ?>
                                        </select>
                                    </div>
                                </div>
                                <div class="activity-data">
                                    <input type="hidden" name="date_<?php echo $id_activity; ?>" value="" class="sendAjaxForm" data-target="#sessions-<?php echo $id_activity; ?>" data-action="<?php echo $action; ?>">
                                    <div id="sessions-<?php echo $id_activity; ?>"></div>
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-4 col-sm-5 sep">
                                <div class="activity-data">
                                    <span class="legend"><?php echo $texts['CHOOSE_A_DATE']; ?></span>
                                    <div class="hb-calendar" data-cur_month="<?php echo date("n", $_SESSION['book']['from_date']); ?>" data-cur_year="<?php echo date("Y", $_SESSION['book']['from_date']); ?>" data-custom_var="activity=<?php echo $id_activity; ?>" data-day_loader="<?php echo DOCBASE."templates/".TEMPLATE."/common/get_days_activity.php"; ?>"></div>
                                </div>
                            </div>
                        </div>
                        <hr>
                    <?php
                    
                    }
                } ?>
                <a class="btn btn-default btn-lg pull-left" href="<?php echo DOCBASE.$sys_pages['booking']['alias']; ?>"><i class="fa fa-angle-left"></i> <?php echo $texts['PREVIOUS_STEP']; ?></a>
                
                <button type="submit" class="btn btn-primary btn-lg pull-right" name="book"><?php echo $texts['NEXT_STEP']; ?> <i class="fa fa-angle-right"></i></button>
            </form>
        </div>
    </div>
</section>
