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

    $result_hotel = $db->query("SELECT * FROM pm_hotel WHERE lang = ".LANG_ID." AND checked = 1 ORDER BY rank LIMIT ".($lz_offset-1)*$lz_limit.", ".$lz_limit);

    $hotel_id = 0;

    $result_hotel_file = $db->prepare("SELECT * FROM pm_hotel_file WHERE id_item = :hotel_id AND checked = 1 AND lang = ".LANG_ID." AND type = 'image' AND file != '' ORDER BY rank LIMIT 1");
    $result_hotel_file->bindParam(":hotel_id", $hotel_id);

    $result_rate = $db->prepare("
        SELECT DISTINCT(ra.price), type
        FROM pm_rate as ra, pm_room as ro
        WHERE ro.id = id_room
            AND id_hotel = :hotel_id
            AND ra.price IN(SELECT MIN(ra.price) FROM pm_rate as ra, pm_room as ro WHERE ro.id = id_room AND id_hotel = :hotel_id)
        ORDER BY ra.price, CASE type
            WHEN 'week' THEN 1
            WHEN 'mid-week' THEN 2
            WHEN 'week-end' THEN 3
            WHEN '2-nights' THEN 4
            WHEN 'night' THEN 5
            ELSE 6 END
        LIMIT 1");
    $result_rate->bindParam(":hotel_id", $hotel_id);

    foreach($result_hotel as $i => $row){
                                
        $hotel_id = $row['id'];
        $hotel_title = $row['title'];
        $hotel_subtitle = $row['subtitle'];
        $hotel_alias = $row['alias'];
        
        // $hotel_alias = DOCBASE.$page_alias."/".text_format($hotel_alias);
        
        $hotel_alias = DOCBASE.$pages[9]['alias']."/".text_format($row['alias']); 

        $html .= "
        <article class=\"col-sm-4 isotopeItem\" itemscope itemtype=\"http://schema.org/LodgingBusiness\">
            <div class=\"isotopeInner\">
                <a itemprop=\"url\" href=\"".$hotel_alias."\">";
                    
                    if($result_hotel_file->execute() !== false && $db->last_row_count() == 1){
                        $row = $result_hotel_file->fetch(PDO::FETCH_ASSOC);
                        
                        $file_id = $row['id'];
                        $filename = $row['file'];
                        $label = $row['label'];
                        
                        $realpath = SYSBASE."medias/hotel/medium/".$file_id."/".$filename;
                        $thumbpath = DOCBASE."medias/hotel/medium/".$file_id."/".$filename;
                        $zoompath = DOCBASE."medias/hotel/big/".$file_id."/".$filename;
                        
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
                        <h3 itemprop=\"name\">".$hotel_title."</h3>
                        <h4>".$hotel_subtitle."</h4>";
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
                                <div class=\"text-muted\">".$texts['PRICE']." / ".$texts['NIGHT']."</div>
                            </div>
                            <div class=\"col-xs-6\">
                                <span class=\"btn btn-primary mt5 pull-right\">".$texts['MORE_DETAILS']."</span>
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
