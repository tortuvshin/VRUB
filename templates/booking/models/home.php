<?php
/* ==============================================
 * CSS AND JAVASCRIPT USED IN THIS MODEL
 * ==============================================
 */
$stylesheets[] = array("file" => DOCBASE."js/plugins/royalslider/royalslider.css", "media" => "all");
$stylesheets[] = array("file" => DOCBASE."js/plugins/royalslider/skins/minimal-white/rs-minimal-white.css", "media" => "all");
$javascripts[] = DOCBASE."js/plugins/royalslider/jquery.royalslider.min.js";

$stylesheets[] = array("file" => DOCBASE."js/plugins/isotope/css/style.css", "media" => "all");
$javascripts[] = DOCBASE."js/plugins/isotope/jquery.isotope.min.js";
$javascripts[] = DOCBASE."js/plugins/isotope/jquery.isotope.sloppy-masonry.min.js";

require(SYSBASE."templates/".TEMPLATE."/common/header.php");

$slide_id = 0;
$result_slide_file = $db->prepare("SELECT * FROM pm_slide_file WHERE id_item = :slide_id AND checked = 1 AND lang = ".DEFAULT_LANG." AND type = 'image' AND file != '' ORDER BY rank LIMIT 1");
$result_slide_file->bindParam("slide_id", $slide_id);

$result_slide = $db->query("SELECT * FROM pm_slide WHERE id_page = ".$page_id." AND checked = 1 AND lang = ".LANG_ID." ORDER BY rank", PDO::FETCH_ASSOC);
if($result_slide !== false){
	$nb_slides = $db->last_row_count();
	if($nb_slides > 0){ ?>
	
		<section id="sliderContainer">
        
            <div id="search-home-wrapper">
                <div id="search-home" class="container">
                    <?php include(SYSBASE."templates/".TEMPLATE."/common/search.php"); ?>
                </div>
            </div>
            
            <div class="royalSlider rsMinW fullSized clearfix">
                <?php
                foreach($result_slide as $i => $row){
                    $slide_id = $row['id'];
                    $slide_legend = $row['legend'];
                    $url_video = $row['url'];
                    $id_page = $row['id_page'];
                    
                    $result_slide_file->execute();
                    
                    if($result_slide_file !== false && $db->last_row_count() == 1){
                        $row = $result_slide_file->fetch();
                        
                        $file_id = $row['id'];
                        $filename = $row['file'];
                        $label = $row['label'];
                        
                        $realpath = SYSBASE."medias/slide/big/".$file_id."/".$filename;
                        $thumbpath = DOCBASE."medias/slide/small/".$file_id."/".$filename;
                        $zoompath = DOCBASE."medias/slide/big/".$file_id."/".$filename;
                            
                        if(is_file($realpath)){ ?>
                        
                            <div class="rsContent">
                                <img class="rsImg" src="<?php echo $zoompath; ?>" alt=""<?php if($url_video != "") echo " data-rsVideo=\"".$url_video."\""; ?>>
                                <?php
                                if($slide_legend != ""){ ?>
                                    <div class="infoBlock" data-fade-effect="" data-move-offset="10" data-move-effect="bottom" data-speed="200">
                                        <?php echo $slide_legend; ?>
                                    </div>
                                    <?php
                                } ?>
                            </div>
                            <?php
                        }
                    }
                } ?>
            </div>
		</section>
		<?php
	}
} ?>
<section id="content" class="pt20 pb30">
    <div class="container">
        <div class="row">
            <div class="col-md-12 text-center mb30">
                <h1 itemprop="name"><?php echo $page['title']; ?></h1>
                <?php
                if($page['subtitle'] != ""){ ?>
                    <h2><?php echo $page['subtitle']; ?></h2>
                    <?php
                } ?>
                <?php echo $page['text']; ?>
            </div>
        </div>
        <div class="row">
            <?php
            $room_id = 0;
            $result_rate = $db->prepare("SELECT DISTINCT(price), type FROM pm_rate WHERE id_room = :room_id AND price IN(SELECT MIN(price) FROM pm_rate WHERE id_room = :room_id)");
            $result_rate->bindParam(":room_id", $room_id);
 
            $result_room = $db->query("SELECT * FROM pm_room WHERE lang = ".LANG_ID." AND checked = 1 AND home = 1 ORDER BY rank");
            if($result_room !== false){
                $nb_rooms = $db->last_row_count();
                $room_id = 0;
                $result_room_file = $db->prepare("SELECT * FROM pm_room_file WHERE id_item = :room_id AND checked = 1 AND lang = ".DEFAULT_LANG." AND type = 'image' AND file != '' ORDER BY rank LIMIT 1");
                $result_room_file->bindParam(":room_id",$room_id);
                foreach($result_room as $i => $row){
                    $room_id = $row['id'];
                    $room_title = $row['title'];
                    $room_alias = $row['title'];
                    $room_subtitle = $row['subtitle'];
                    $min_price = $row['price'];
                    
                    $room_alias = DOCBASE.$pages[9]['alias']."/".text_format($row['alias']); ?>
                    
                    <article class="col-sm-4 mb20" itemscope itemtype="http://schema.org/LodgingBusiness">
                        <a itemprop="url" href="<?php echo $room_alias; ?>" class="moreLink">
                            <?php
                            if($result_room_file->execute() !== false && $db->last_row_count() == 1){
                                $row = $result_room_file->fetch(PDO::FETCH_ASSOC);
                                
                                $file_id = $row['id'];
                                $filename = $row['file'];
                                $label = $row['label'];
                                
                                $realpath = SYSBASE."medias/room/small/".$file_id."/".$filename;
                                $thumbpath = DOCBASE."medias/room/small/".$file_id."/".$filename;
                                $zoompath = DOCBASE."medias/room/big/".$file_id."/".$filename;
                                
                                if(is_file($realpath)){ ?>
                                    <figure class="more-link">
                                        <div class="img-container medium">
                                            <img alt="<?php echo $label; ?>" src="<?php echo $thumbpath; ?>">
                                        </div>
                                        <div class="more-content">
                                            <h3 itemprop="name"><?php echo $room_title; ?></h3>
                                            <?php
                                            $type = "nuit";
                                            $result_rate->execute();
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
                                        </div>
                                        <div class="more-action">
                                            <div class="more-icon">
                                                <i class="fa fa-link"></i>
                                            </div>
                                        </div>
                                    </figure>
                                    <?php
                                }
                            } ?>
                        </a> 
                    </article>
                    <?php
                }
            } ?>
        </div>
        <div class="row">
            <?php
            $result_article = $db->query("SELECT * FROM pm_article WHERE (id_page = ".$page_id." OR home = 1) AND checked = 1 AND (publish_date IS NULL || publish_date <= ".time().") AND (unpublish_date IS NULL || unpublish_date > ".time().") AND lang = ".LANG_ID." ORDER BY rank");
            if($result_article !== false){
                $nb_articles = $db->last_row_count();
                
                if($nb_articles > 0){ ?>
                    <div class="clearfix">
                        <?php
                        $article_id = 0;
                        $result_article_file = $db->prepare("SELECT * FROM pm_article_file WHERE id_item = :article_id AND checked = 1 AND lang = ".DEFAULT_LANG." AND type = 'image' AND file != '' ORDER BY rank LIMIT 1");
                        $result_article_file->bindParam(":article_id",$article_id);
                        foreach($result_article as $i => $row){
                            $article_id = $row['id'];
                            $article_title = $row['title'];
                            $article_alias = $row['alias'];
                            $article_text = strtrunc($row['text'], 1200, true, "");
                            $article_page = $row['id_page'];
                            
                            if(isset($pages[$article_page])){
                            
                                $article_alias = DOCBASE.$pages[$article_page]['alias']."/".text_format($article_alias); ?>
                                
                                <article id="article-<?php echo $article_id; ?>" class="col-sm-12" itemscope itemtype="http://schema.org/Article">
                                    <div class="row">
                                        <a itemprop="url" href="<?php echo $article_alias; ?>" class="moreLink">
                                            <div class="col-sm-8 mb20">
                                                <?php
                                                if($result_article_file->execute() !== false && $db->last_row_count() == 1){
                                                    $row = $result_article_file->fetch(PDO::FETCH_ASSOC);
                                                    
                                                    $file_id = $row['id'];
                                                    $filename = $row['file'];
                                                    $label = $row['label'];
                                                    
                                                    $realpath = SYSBASE."medias/article/big/".$file_id."/".$filename;
                                                    $thumbpath = DOCBASE."medias/article/big/".$file_id."/".$filename;
                                                    $zoompath = DOCBASE."medias/article/big/".$file_id."/".$filename;
                                                    
                                                    if(is_file($realpath)){ ?>
                                                        <figure class="more-link">
                                                            <div class="img-container big">
                                                                <img alt="<?php echo $label; ?>" src="<?php echo $thumbpath; ?>">
                                                            </div>
                                                            <div class="more-action">
                                                                <div class="more-icon">
                                                                    <i class="fa fa-link"></i>
                                                                </div>
                                                            </div>
                                                        </figure>
                                                        <?php
                                                    }
                                                } ?>
                                            </div>
                                            <div class="col-sm-4">
                                                <div class="text-overflow">
                                                    <h3 itemprop="name"><?php echo $article_title; ?></h3>
                                                    <?php echo $article_text; ?>
                                                    <div class="more-btn">
                                                        <span class="btn btn-primary"><?php echo $texts['READMORE']; ?></span>
                                                    </div>
                                                </div>
                                            </div>
                                        </a>
                                    </div>
                                </article>
                                <?php
                            }
                        } ?>
                    </div>
                    <?php
                }
            } ?>
        </div>
    </div>
</section>
