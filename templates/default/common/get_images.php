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
    && isset($_POST['article_id']) && is_numeric($_POST['article_id'])){
        $article_id = $_POST['article_id'];
        $lz_offset = $_POST['offset'];
        $lz_limit =	$_POST['limit'];
    }
}

if(isset($db) && $db !== false){
    
    if(isset($article_id)){

        $result_article_file = $db->query("SELECT * FROM pm_article_file WHERE id_item = ".$article_id." AND checked = 1 AND lang = ".DEFAULT_LANG." AND type = 'image' AND file != '' ORDER BY rank LIMIT ".($lz_offset-1)*$lz_limit.", ".$lz_limit);
        if($result_article_file !== false){
                                
            foreach($result_article_file as $i => $row){
                                    
                $file_id = $row['id'];
                $filename = $row['file'];
                $label = $row['label'];
                
                $realpath = SYSBASE."medias/article/medium/".$file_id."/".$filename;
                $thumbpath = DOCBASE."medias/article/medium/".$file_id."/".$filename;
                $zoompath = DOCBASE."medias/article/big/".$file_id."/".$filename;
                
                if(is_file($realpath)){
                    $html .= "<figure class=\"col-sm-4 isotopeItem\">
                        <div class=\"isotopeInner\">
                            <a href=\"".$zoompath."\" class=\"more-link image-link\" title=\"".$label."\">
                                <img alt=\"".$label."\" src=\"".$thumbpath."\" class=\"img-responsive\">
                                <span class=\"more-action\">
                                    <figcaption><p>".$label."</p></figcaption>
                                    <span class=\"more-icon\">
                                        <i class=\"fa fa-search-plus\"></i>
                                    </span>
                                </span>
                            </a>
                        </div>
                    </figure>";
                }
            }
        }
    }
    if(isset($_POST['ajax']) && $_POST['ajax'] == 1)
        echo json_encode(array("html" => $html));
    else
        echo $html;
}
