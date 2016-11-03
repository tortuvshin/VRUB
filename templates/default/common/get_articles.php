<?php
/**
 * Script called (Ajax) on scroll or click
 * loads more content with Lazy Loader
 */
$html = "";
if(!isset($lz_offset)) $lz_offset = 1;
if(!isset($lz_limit)) $lz_limit = 30;
if(isset($_POST['ajax']) && $_POST['ajax'] == 1){
    
    require_once("../../../common/lib.php");
    require_once("../../../common/define.php");

    if(isset($_POST['offset']) && is_numeric($_POST['offset'])
    && isset($_POST['limit']) && is_numeric($_POST['limit'])
    && isset($_POST['page_id']) && is_numeric($_POST['page_id'])
    && isset($_POST['page_alias'])){
        $page_id = $_POST['page_id'];
        $lz_offset = $_POST['offset'];
        $lz_limit =	$_POST['limit'];
        $page_alias = $_POST['page_alias'];
    }
}
if(isset($db) && $db !== false){
    
    if(isset($page_id) && isset($pages[$page_id]['alias'])) $page_alias = $pages[$page_id]['alias'];

    $result_article = $db->query("SELECT * FROM pm_article WHERE id_page = ".$page_id." AND checked = 1 AND (publish_date IS NULL || publish_date <= ".time().") AND (unpublish_date IS NULL || unpublish_date > ".time().") AND lang = ".LANG_ID." ORDER BY rank LIMIT ".($lz_offset-1)*$lz_limit.", ".$lz_limit);
    $article_id = 0;
    $result_article_file = $db->prepare("SELECT * FROM pm_article_file WHERE id_item = :article_id AND checked = 1 AND lang = ".DEFAULT_LANG." AND type = 'image' AND file != '' ORDER BY rank LIMIT 1");
    $result_article_file->bindParam(":article_id", $article_id);

    foreach($result_article as $i => $row){
                                
        $article_id = $row['id'];
        $article_title = $row['title'];
        $article_alias = $row['alias'];
        $article_text = strtrunc(strip_tags($row['text']),170);
        $article_tags = $row['tags'];
        
        if($article_tags != "") $article_tags = " tag".str_replace(","," tag",$article_tags);
        
        $article_alias = DOCBASE.$page_alias."/".text_format($article_alias);
        
        $html .= "
        <article class=\"col-sm-4 isotopeItem".$article_tags."\" itemscope itemtype=\"http://schema.org/Article\">
            <div class=\"isotopeInner\">
                <a itemprop=\"url\" href=\"".$article_alias."\">";
                    
                    if($result_article_file->execute() !== false && $db->last_row_count() == 1){
                        $row = $result_article_file->fetch(PDO::FETCH_ASSOC);
                        
                        $file_id = $row['id'];
                        $filename = $row['file'];
                        $label = $row['label'];
                        
                        $realpath = SYSBASE."medias/article/medium/".$file_id."/".$filename;
                        $thumbpath = DOCBASE."medias/article/medium/".$file_id."/".$filename;
                        $zoompath = DOCBASE."medias/article/big/".$file_id."/".$filename;
                        
                        if(is_file($realpath)){
                            $html .= "
                            <figure class=\"more-link\">
                                <img alt=\"".$label."\" src=\"".$thumbpath."\" class=\"img-responsive\">
                                <span class=\"more-action\">
                                    <span class=\"more-icon\"><i class=\"fa fa-link\"></i></span>
                                </span>
                            </figure>";
                        }
                    }
                    $html .= "
                    <div class=\"isotopeContent\">
                        <div class=\"text-overflow\">
                        <h3 itemprop=\"name\">".$article_title."</h3>";
                        if($article_text != "") $html .= "<p>".$article_text."</p>";
                        $html .= "
                        <div class=\"more-btn\">
                            <span class=\"btn btn-primary\">".$texts['READMORE']."</span>
                        </div>
                    </div>
                </a>
            </div>
        </article>";
    }
    if(isset($_POST['ajax']) && $_POST['ajax'] == 1)
        echo json_encode(array("html" => $html));
    else
        echo $html;
}
