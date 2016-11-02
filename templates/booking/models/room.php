<?php
if($article_alias == "") err404();

$result = $db->query("SELECT * FROM pm_room WHERE checked = 1 AND lang = ".LANG_ID." AND alias = ".$db->quote($article_alias));
if($result !== false && $db->last_row_count() == 1){
    
    $room = $result->fetch(PDO::FETCH_ASSOC);
    
    $room_id = $room['id'];
    $article_id = $room_id;
    $title_tag = $room['title']." - ".$title_tag;
    $page_title = $room['title'];
    $page_subtitle = "";
    $page_alias = DOCBASE.$pages[$page_id]['alias']."/".text_format($room['alias']);
    
}else err404();

check_URI($page_alias);

/* ==============================================
 * CSS AND JAVASCRIPT USED IN THIS MODEL
 * ==============================================
 */
$javascripts[] = DOCBASE."js/plugins/jquery.sharrre-1.3.4/jquery.sharrre-1.3.4.min.js";

$javascripts[] = DOCBASE."js/plugins/jquery.event.calendar/js/jquery.event.calendar.js";
$javascripts[] = DOCBASE."js/plugins/jquery.event.calendar/js/languages/jquery.event.calendar.".LANG_TAG.".js";
$stylesheets[] = array("file" => DOCBASE."js/plugins/jquery.event.calendar/css/jquery.event.calendar.css", "media" => "all");

$stylesheets[] = array("file" => DOCBASE."js/plugins/owl-carousel/owl.carousel.css", "media" => "all");
$stylesheets[] = array("file" => DOCBASE."js/plugins/owl-carousel/owl.theme.css", "media" => "all");
$javascripts[] = DOCBASE."js/plugins/owl-carousel/owl.carousel.min.js";

$stylesheets[] = array("file" => DOCBASE."js/plugins/star-rating/css/star-rating.min.css", "media" => "all");
$javascripts[] = DOCBASE."js/plugins/star-rating/js/star-rating.min.js";

require(SYSBASE."templates/".TEMPLATE."/common/send_comment.php");

require(SYSBASE."templates/".TEMPLATE."/common/header.php"); ?>

<article id="page">
    <?php include(SYSBASE."templates/".TEMPLATE."/common/page_header.php"); ?>
    
    <div id="content" class="pt20 pb30">
        <div class="container boxed mb20">
            <legend><?php echo $texts['AVAILABILITIES']; ?></legend>
            <div class="alert alert-success" style="display:none;"></div>
            <div class="alert alert-danger" style="display:none;"></div>
            <?php include(SYSBASE."templates/".TEMPLATE."/common/search.php"); ?>
        </div>
        <div class="container">
            <div class="row">
                <div class="col-md-8 boxed mb20">
                    <div class="row mb10">
                        <div class="col-sm-8">
                            <h1 class="mb0"><?php echo $room['title']; ?></h1>
                            <?php
                            $result_rating = $db->query("SELECT count(*) as count_rating, AVG(rating) as avg_rating FROM pm_comment WHERE item_type = 'room' AND id_item = ".$room_id." AND checked = 1 AND rating > 0 AND rating <= 5");
                            if($result_rating !== false && $db->last_row_count() == 1){
                                $row = $result_rating->fetch();
                                $room_rating = $row['avg_rating'];
                                $count_rating = $row['count_rating'];
                                
                                if($room_rating > 0 && $room_rating <= 5){ ?>
                                
                                    <input type="hidden" class="rating pull-left" value="<?php echo $room_rating; ?>" data-rtl="<?php echo (RTL_DIR) ? true : false; ?>" data-size="xs" readonly="true" data-default-caption="<?php echo $count_rating." ".$texts['RATINGS']; ?>" data-show-caption="true">
                                    <?php
                                }
                            } ?>
                            <div class="clearfix"></div>
                            <h2><?php echo $room['subtitle']; ?></h2>
                        </div>
                        <div class="col-sm-4 text-right">
                            <div class="price text-primary">
                                <?php
                                $type = "night";
                                $min_price = $room['price'];
                                $result_rate = $db->query("SELECT DISTINCT(price), type FROM pm_rate WHERE id_room = ".$room_id." AND price IN(SELECT MIN(price) FROM pm_rate WHERE id_room = ".$room_id.")");
                                if($result_rate !== false && $db->last_row_count() == 1){
                                    $row = $result_rate->fetch();
                                    $price = $row['price'];
                                    $type = $row['type'];
                                    switch($type){
                                        case "night": $type = $texts['NIGHT']; break;
                                        case "week": $type = $texts['WEEK']; break;
                                    }
                                    if($price > 0) $min_price = $price;
                                } ?>
                                <?php echo $texts['FROM_PRICE']; ?>
                                <span itemprop="priceRange">
                                    <?php echo formatPrice($min_price*CURRENCY_RATE); ?>
                                </span>
                                /<?php echo $type; ?>
                            </div>
                            <p>
                                <?php echo $texts['CAPACITY']; ?> : <i class="fa fa-male"></i>x<?php echo $room['max_people']; ?>
                            </p>
                        </div>
                    </div>
                    <div class="row mb10">
                        <div class="col-sm-12">
                            <?php
                            $result_facility = $db->query("SELECT * FROM pm_facility WHERE lang = ".LANG_ID." AND id IN(".$room['facilities'].") ORDER BY name",PDO::FETCH_ASSOC);
                            if($result_facility !== false && $db->last_row_count() > 0){
                                foreach($result_facility as $i => $row){
                                    $facility_id 	= $row['id'];
                                    $facility_name  = $row['name'];
                                    
                                    $result_facility_file = $db->query("SELECT * FROM pm_facility_file WHERE id_item = ".$facility_id." AND checked = 1 AND lang = ".DEFAULT_LANG." AND type = 'image' AND file != '' ORDER BY rank LIMIT 1",PDO::FETCH_ASSOC);
                                    if($result_facility_file !== false && $db->last_row_count() == 1){
                                        $row = $result_facility_file->fetch();
                                        
                                        $file_id 	= $row['id'];
                                        $filename 	= $row['file'];
                                        $label	 	= $row['label'];
                                        
                                        $realpath	= SYSBASE."medias/facility/big/".$file_id."/".$filename;
                                        $thumbpath	= DOCBASE."medias/facility/big/".$file_id."/".$filename;
                                            
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
                    <div class="row mb10">
                        <div class="col-md-12">
                            <div class="owl-carousel owlWrapper" data-items="1" data-autoplay="true" data-dots="true" data-nav="false" data-rtl="<?php echo (RTL_DIR) ? "true" : "false"; ?>">
                                <?php
                                $result_room_file = $db->query("SELECT * FROM pm_room_file WHERE id_item = ".$room_id." AND checked = 1 AND lang = ".DEFAULT_LANG." AND type = 'image' AND file != '' ORDER BY rank");
                                if($result_room_file !== false){
                                    
                                    foreach($result_room_file as $i => $row){
                                    
                                        $file_id = $row['id'];
                                        $filename = $row['file'];
                                        $label = $row['label'];
                                        
                                        $realpath = SYSBASE."medias/room/big/".$file_id."/".$filename;
                                        $thumbpath = DOCBASE."medias/room/big/".$file_id."/".$filename;
                                        
                                        if(is_file($realpath)){ ?>
                                            <img alt="<?php echo $label; ?>" src="<?php echo $thumbpath; ?>" class="img-responsive" style="max-height:600px;"/>
                                            <?php
                                        }
                                    }
                                } ?>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12" itemprop="description">
                            <?php echo $room['descr']; ?>
                        </div>
                    </div>
                </div>
                <aside class="col-md-4 mb20">
                    <div class="boxed">
                        <?php
                        $result_room = $db->query("SELECT * FROM pm_room WHERE id != ".$room_id." AND checked = 1 AND lang = ".LANG_ID." ORDER BY rank", PDO::FETCH_ASSOC);
                        if($result_room !== false && $db->last_row_count() > 0){ ?>
                            <p class="widget-title"><?php echo $texts['ALSO_DISCOVER']; ?></p>
                            
                            <?php
                            foreach($result_room as $i => $row){
                                $room_id 	= $row['id'];
                                $room_title = $row['title'];
                                $room_subtitle = $row['subtitle'];
                                $room_alias = $row['alias'];
                                
                                $result_room_file = $db->query("SELECT * FROM pm_room_file WHERE id_item = ".$room_id." AND checked = 1 AND lang = ".DEFAULT_LANG." AND type = 'image' AND file != '' ORDER BY rank LIMIT 1",PDO::FETCH_ASSOC);
                                if($result_room_file !== false && $db->last_row_count() == 1){
                                    $row = $result_room_file->fetch();
                                    
                                    $file_id 	= $row['id'];
                                    $filename 	= $row['file'];
                                    $label	 	= $row['label'];
                                    
                                    $realpath	= SYSBASE."medias/room/big/".$file_id."/".$filename;
                                    $thumbpath	= DOCBASE."medias/room/small/".$file_id."/".$filename;
                                    $zoompath	= DOCBASE."medias/room/big/".$file_id."/".$filename;
                                        
                                    if(is_file($realpath)){ ?>
                                        <div class="row">
                                            <div class="col-xs-3 mb20">
                                                <div class="img-container small">
                                                    <img alt="" src="<?php echo $thumbpath; ?>">
                                                </div>
                                            </div>
                                            <div class="col-xs-9">
                                                <h3 class="mb0"><?php echo $room_title; ?></h3>
                                                <h4 class="mb0"><?php echo $room_subtitle; ?></h4>
                                                <a href="<?php echo DOCBASE.$page['alias']."/".$room_alias; ?>" title=""><?php echo $texts['MORE_DETAILS']; ?></a>
                                            </div>
                                        </div>
                                        <?php
                                    }
                                }
                            } ?>
                            <?php
                        } ?>
                    </div>
                </aside>
                <div class="col-md-8">
                    <?php
                    $nb_comments = 0;
                    $item_type = "room";
                    $item_id = $room_id;
                    $allow_comment = ALLOW_COMMENTS;
                    $allow_rating = ALLOW_RATINGS;
                    if($allow_comment == 1){
                        $result_comment = $db->query("SELECT * FROM pm_comment WHERE id_item = ".$item_id." AND item_type = '".$item_type."' AND checked = 1 ORDER BY add_date DESC");
                        if($result_comment !== false)
                            $nb_comments = $db->last_row_count();
                    }
                    include(SYSBASE."templates/".TEMPLATE."/common/comments.php"); ?>
                </div>
            </div>
        </div>
    </div>
</article>
