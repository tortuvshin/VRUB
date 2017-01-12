<?php
/* ==============================================
 * CSS AND JAVASCRIPT USED IN THIS MODEL
 * ==============================================
 */
$stylesheets[] = array("file" => DOCBASE."js/plugins/isotope/css/style.css", "media" => "all");
$javascripts[] = DOCBASE."js/plugins/isotope/jquery.isotope.min.js";
$javascripts[] = DOCBASE."js/plugins/isotope/jquery.isotope.sloppy-masonry.min.js";

$stylesheets[] = array("file" => DOCBASE."js/plugins/lazyloader/lazyloader.css", "media" => "all");
$javascripts[] = DOCBASE."js/plugins/lazyloader/lazyloader.js";

$stylesheets[] = array("file" => DOCBASE."js/plugins/star-rating/css/star-rating.min.css", "media" => "all");
$javascripts[] = DOCBASE."js/plugins/star-rating/js/star-rating.min.js";

require(getFromTemplate("common/send_comment.php", false));

require(getFromTemplate("common/header.php", false)); ?>

<section id="page">
    
    <?php include(getFromTemplate("common/page_header.php", false)); ?>
    
    <div id="content" class="pt30 pb20">
        <div class="container" itemprop="text">

            <div class="alert alert-success" style="display:none;"></div>
            <div class="alert alert-danger" style="display:none;"></div>
            
            <div class="row">
                <?php
                $widgetsLeft = getWidgets("left", $page_id);
                $widgetsRight = getWidgets("right", $page_id);
                
                displayWidgets("left", $page_id); ?>
                
                <section class="col-sm-<?php if(!empty($widgetsLeft) && !empty($widgetsRight)) echo 6; elseif(!empty($widgetsLeft) || !empty($widgetsRight)) echo 9; else echo 12; ?>">
                    <?php echo $page['text']; ?>
                </section>
                
                <?php
                displayWidgets("right", $page_id); ?>
            </div>
            
            <?php
            $nb_comments = 0;
            $item_type = "page";
            $item_id = $page_id;
            $allow_comment = $page['comment'];
            $allow_rating = $page['rating'];
            if($allow_comment == 1){
                $result_comment = $db->query("SELECT * FROM pm_comment WHERE id_item = ".$item_id." AND item_type = '".$item_type."' AND checked = 1 ORDER BY add_date DESC");
                if($result_comment !== false)
                    $nb_comments = $db->last_row_count();
            }
            include(getFromTemplate("common/comments.php", false)); ?>
        </div>
    </div>
</section>
