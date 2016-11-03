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
    && isset($_POST['limit']) && is_numeric($_POST['limit'])){
        $lz_offset = $_POST['offset'];
        $lz_limit =	$_POST['limit'];
    }
    if(isset($_POST['hotel']) && is_numeric($_POST['hotel'])) $hotel_id = $_POST['hotel'];
}
if(isset($db) && $db !== false){

    $query_activity = "SELECT * FROM pm_activity WHERE lang = ".LANG_ID." AND checked = 1";
    if(isset($hotel_id)) $query_activity .= " AND hotels REGEXP '(^|,)".$hotel_id."(,|$)'";
    $query_activity .= " ORDER BY rank LIMIT ".($lz_offset-1)*$lz_limit.", ".$lz_limit;
    $result_activity = $db->query($query_activity);

    $activity_id = 0;

    $result_activity_file = $db->prepare("SELECT * FROM pm_activity_file WHERE id_item = :activity_id AND checked = 1 AND lang = ".LANG_ID." AND type = 'image' AND file != '' ORDER BY rank LIMIT 1");
    $result_activity_file->bindParam(":activity_id", $activity_id);

    $result_rate = $db->prepare("
        SELECT DISTINCT(price)
        FROM pm_activity_session
        WHERE id_activity = :id_activity
            AND price IN(SELECT MIN(price) FROM pm_activity_session WHERE id_activity = :id_activity)
        ORDER BY price
        LIMIT 1");
    $result_rate->bindParam(":id_activity", $activity_id);

    foreach($result_activity as $i => $row){
                                
        $activity_id = $row['id'];
        $activity_title = $row['title'];
        $activity_subtitle = $row['subtitle'];
        $activity_alias = $row['alias'];
        
        $activity_alias = DOCBASE.$sys_pages['activities']['alias']."/".text_format($activity_alias);
        
        $html .= "
        <article class=\"col-sm-4 isotopeItem\" itemscope itemtype=\"http://schema.org/LodgingBusiness\">
            <div class=\"isotopeInner\">
                <a itemprop=\"url\" href=\"".$activity_alias."\">";
                    
                    if($result_activity_file->execute() !== false && $db->last_row_count() == 1){
                        $row = $result_activity_file->fetch(PDO::FETCH_ASSOC);
                        
                        $file_id = $row['id'];
                        $filename = $row['file'];
                        $label = $row['label'];
                        
                        $realpath = SYSBASE."medias/activity/medium/".$file_id."/".$filename;
                        $thumbpath = DOCBASE."medias/activity/medium/".$file_id."/".$filename;
                        $zoompath = DOCBASE."medias/activity/big/".$file_id."/".$filename;
                        
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
                        <h3 itemprop=\"name\">".$activity_title."</h3>
                        <h4>".$activity_subtitle."</h4>";
                        $min_price = 0;
                        $result_rate->execute();
                        if($result_rate !== false && $db->last_row_count() == 1){
                            $row = $result_rate->fetch();
                            $price = $row['price'];
                            if($price > 0) $min_price = $price;
                        }
                        $html .= "
                        <div class=\"row\">
                            <div class=\"col-xs-6\">
                                <div class=\"price text-primary\">
                                    ".$texts['FROM_PRICE']."
                                    <span itemprop=\"priceRange\">
                                        ".formatPrice($min_price*CURRENCY_RATE)."
                                    </span>
                                </div>
                                <div class=\"text-muted\">".$texts['PRICE']." / ".$texts['PERSON']."</div>
                            </div>
                            <div class=\"col-xs-6\">
                                <span class=\"btn btn-primary mt5 pull-right\"><i class=\"fa fa-search\"></i></span>
                            </div>
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
