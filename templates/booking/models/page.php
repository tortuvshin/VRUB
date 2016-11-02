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

require(SYSBASE."templates/".TEMPLATE."/common/send_comment.php");

require(SYSBASE."templates/".TEMPLATE."/common/header.php"); ?>

<section id="page">
    
    <?php include(SYSBASE."templates/".TEMPLATE."/common/page_header.php"); ?>
    
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

            <div class="row">
                <?php
                $lz_offset = 1;
                $lz_limit = 4;
                $lz_pages = 0;
                $num_records = 0;
                $result = $db->query("SELECT count(*) FROM pm_article WHERE id_page = ".$page_id." AND checked = 1 AND (publish_date IS NULL || publish_date <= ".time().") AND (unpublish_date IS NULL || unpublish_date > ".time().") AND lang = ".LANG_ID);
                if($result !== false){
                    $num_records = $result->fetchColumn(0);
                    $lz_pages = ceil($num_records/$lz_limit);
                }
                if($num_records > 0){
                    
                    $result_tag = $db->query("SELECT * FROM pm_tag WHERE pages REGEXP '(^|,)".$page_id."(,|$)' AND checked = 1 AND lang = ".LANG_ID." ORDER BY rank");
                    if($result_tag !== false){
                        $nb_tags = $db->last_row_count();
                        
                        if($nb_tags > 0){ ?>
                    
                            <nav id="filter" class="text-center mt20">
                                <div class="btn-group">
                                    <a href="" class="btn btn-default" data-filter="*"><?php echo $texts['ALL']; ?></a>
                                    <?php
                                    foreach($result_tag as $i => $row){
                                        $tag_id = $row['id'];
                                        $tag_value = $row['value']; ?>
                                        
                                        <a href="" class="btn btn-default" data-filter=".tag<?php echo $tag_id; ?>"><?php echo $tag_value; ?></a>
                                        
                                        <?php
                                    } ?>
                                </div>
                            </nav>
                            <?php
                        }
                    } ?>
                    
                    <div class="isotopeWrapper clearfix isotope lazy-wrapper" data-loader="<?php echo DOCBASE."templates/".TEMPLATE."/common/get_articles.php"; ?>" data-mode="click" data-limit="<?php echo $lz_limit; ?>" data-pages="<?php echo $lz_pages; ?>" data-is_isotope="true" data-variables="page_id=<?php echo $page_id; ?>&page_alias=<?php echo $page['alias']; ?>">
                        <?php include(SYSBASE."templates/".TEMPLATE."/common/get_articles.php"); ?>
                    </div>
                    <?php
                } ?>
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
            include(SYSBASE."templates/".TEMPLATE."/common/comments.php"); ?>
        </div>
    </div>
</section>
