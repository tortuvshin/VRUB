<?php
if($article_alias == "") err404();

$result = $db->query("SELECT * FROM pm_article WHERE checked = 1 AND lang = ".LANG_ID." AND alias = ".$db->quote($article_alias));
if($result !== false && $db->last_row_count() == 1){
    
    $article = $result->fetch(PDO::FETCH_ASSOC);
    
    $article_id = $article['id'];
    $title_tag = $article['title']." - ".$title_tag;
    $page_title = $article['title'];
    $page_subtitle = $article['title'];
    $page_alias = $pages[$page_id]['alias']."/".text_format($article['alias']);

    if($article['comment'] == 1){
        $result_comment = $db->query("SELECT * FROM pm_comment WHERE id_article = ".$article_id." AND checked = 1 ORDER BY add_date DESC");
        if($result_comment !== false)
            $nb_comments = $db->last_row_count();
    }
}else err404();

check_URI(DOCBASE.$page_alias);

/* ==============================================
 * CSS AND JAVASCRIPT USED IN THIS MODEL
 * ==============================================
 */
$stylesheets[] = array("file" => DOCBASE."js/plugins/isotope/css/style.css", "media" => "all");
$javascripts[] = DOCBASE."js/plugins/isotope/jquery.isotope.min.js";
$javascripts[] = DOCBASE."js/plugins/isotope/jquery.isotope.sloppy-masonry.min.js";

$stylesheets[] = array("file" => DOCBASE."js/plugins/lazyloader/lazyloader.css", "media" => "all");
$javascripts[] = DOCBASE."js/plugins/lazyloader/lazyloader.js";

require(getFromTemplate("common/header.php", false)); ?>

<article id="page">
    <?php include(getFromTemplate("common/page_header.php", false)); ?>
    
    <div id="content" class="pt10 pb30">
        <div class="container">
            <div class="row">
                <?php
                $lz_offset = 1;
                $lz_limit = 9;
                $lz_pages = 0;
                $num_records = 0;
                $result = $db->query("SELECT count(*) FROM pm_article_file WHERE id_item = ".$article_id." AND checked = 1 AND lang = ".DEFAULT_LANG." AND type = 'image' AND file != ''");
                if($result !== false){
                    $num_records = $result->fetchColumn(0);
                    $lz_pages = ceil($num_records/$lz_limit);
                }
                if($num_records > 0){ ?>
                    <div class="isotopeWrapper clearfix isotope popup-gallery lazy-wrapper" data-loader="<?php echo getFromTemplate("common/get_images.php"); ?>" data-mode="click" data-limit="<?php echo $lz_limit; ?>" data-pages="<?php echo $lz_pages; ?>" data-is_isotope="true" data-variables="article_id=<?php echo $article_id; ?>">
                        <?php include(getFromTemplate("common/get_images.php", false)); ?>
                    </div>
                    <?php
                } ?>
                
            </div>
        </div>
    </div>
</article>
