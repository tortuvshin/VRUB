<?php
$javascripts[] = DOCBASE."js/plugins/jquery-activmap/js/markercluster.min.js";
$javascripts[] = DOCBASE."js/plugins/jquery-activmap/js/jquery-activmap.js";
$stylesheets[] = array("file" => DOCBASE."js/plugins/jquery-activmap/css/jquery-activmap.css", "media" => "all");

require(getFromTemplate("common/header.php", false)); ?>

<script>
    var locations = [
        <?php
        $result_location = $db->query("SELECT * FROM pm_location WHERE checked = 1 AND pages REGEXP '(^|,)".$page_id."(,|$)'");
        if($result_location !== false){
            $nb_locations = $db->last_row_count();
            foreach($result_location as $i => $row){
                $location_name = $row['name'];
                $location_address = $row['address'];
                $location_lat = $row['lat'];
                $location_lng = $row['lng'];
                $location_tags = $row['tags'];
                
                if($location_tags != "") $location_tags = "'tag".str_replace(",","', 'tag",$location_tags)."'";

                echo "{title: '".addslashes($location_name)."', address: '".addslashes($location_address)."', url: '', tags: [".$location_tags."], lat: ".$location_lat.", lng: ".$location_lng.", img: '', icon: ''}";
                if($i+1 < $nb_locations) echo ",\n";
            }
        } ?>
    ];
</script>

<section id="page">
    
    <?php include(getFromTemplate("common/page_header.php", false)); ?>
    
    <div id="content" class="clearfix">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-3 pt20">
                    
                    <a id="activmap-reset" class="btn btn-default" href="#"><i class="fa fa-ban"></i> Reset</a>
                    <div class="form-group">
                        <div class="input-group">
                            <div class="input-group-addon"><i class="fa fa-location-arrow"></i></div>
                            <input id="activmap-location" type="text" class="form-control" name="location" value="" placeholder="Location...">
                        </div>
                        <p>
                            Radius: 
                            <input type="radio" name="activmap_radius" value="0"> None
                            <input type="radio" name="activmap_radius" value="3"> 3 km
                            <input type="radio" name="activmap_radius" value="20"> 20 km
                            <input type="radio" name="activmap_radius" value="50"> 50 km
                            <input type="radio" name="activmap_radius" value="100"> 100 km
                        </p>
                    </div>
                    
                    <?php
                    $result_tag = $db->query("SELECT * FROM pm_tag WHERE pages REGEXP '(^|,)".$page_id."(,|$)' AND checked = 1 AND lang = ".LANG_ID." ORDER BY rank");
                    if($result_tag !== false){
                        $nb_tags = $db->last_row_count();
                        
                        if($nb_tags > 0){
                            foreach($result_tag as $i => $row){
                                $tag_id = $row['id'];
                                $tag_value = $row['value']; ?>
                                
                                <input type="checkbox" name="marker_type[]" value="tag<?php echo $tag_id; ?>"> <?php echo $tag_value; ?><br>
                                <?php
                            }
                        }
                    } ?>
                </div>
                <div class="col-md-9">
                    <div id="activmap-wrapper" data-lat="4.1761906" data-lng="73.5080069" data-radius="20" data-zoom="16">
                        <!-- Places panel (auto removable) -->
                        <div id="activmap-places" class="hidden-xs">
                            <div id="activmap-results-num"></div>
                        </div>
                        <!-- Map wrapper -->
                        <div id="activmap-canvas"></div>
                    </div>  
                </div>  
            </div>         
        </div>
    </div>
</section>
