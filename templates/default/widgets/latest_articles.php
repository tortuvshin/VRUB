<?php debug_backtrace() || die ("Шууд хандах боломжгүй"); ?>
<ul class="nostyle">
    <?php
    $result_article = $db->query("
    SELECT DISTINCT(a.id) as article_id, title, alias, id_page, file, af.id as file_id
    FROM (
        SELECT 
            id_item, 
            min(rank) as min_rank
        FROM pm_article_file 
        GROUP BY id_item
    ) as mins
    INNER JOIN pm_article_file as af ON mins.id_item = af.id_item AND mins.min_rank = af.rank
    INNER JOIN pm_article as a ON mins.id_item = a.id
    WHERE a.checked = 1 AND af.checked = 1 AND a.lang = ".LANG_ID." AND (a.publish_date IS NULL || a.publish_date <= ".time().") AND (a.unpublish_date IS NULL || a.unpublish_date > ".time().")
    ORDER BY a.add_date DESC LIMIT 10"
                                );
    if($result_article !== false){
        foreach($result_article as $i => $row){
            $article_id = $row['article_id'];
            $article_title = $row['title'];
            $article_alias = $row['alias'];
            $article_page = $row['id_page'];
            $file_id = $row['file_id'];
            $file = $row['file'];
            
            if(isset($pages[$article_page])){
            
                $article_alias = DOCBASE.$pages[$article_page]['alias']."/".text_format($article_alias); ?>
                
                <li>
                    <a href="<?php echo $article_alias; ?>" title="<?php echo $article_title." - ".$pages[$article_page]['name']; ?>" class="img-container xs pull-<?php echo (RTL_DIR) ? "right" : "left"; ?> tips">
                        <img src="<?php echo DOCBASE."medias/article/small/".$file_id."/".$file; ?>">
                    </a>
                </li>
                <?php
            }
        }
    } ?>
</ul>
