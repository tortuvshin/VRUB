<?php
require(SYSBASE."templates/".TEMPLATE."/common/header.php"); ?>

<section id="page">
    
    <?php include(SYSBASE."templates/".TEMPLATE."/common/page_header.php"); ?>
    
    <div id="content" class="pt30 pb20">
        <div class="container">
            <div class="row">
                
                <?php
                if($page['text'] != ""){ ?>
                    <div class="col-md-12 clearfix mb20"><?php echo $page['text']; ?></div>
                    <?php
                }
            
                $id_room = 0;
                $result_rate = $db->prepare("SELECT DISTINCT(price), type FROM pm_rate WHERE id_room = :id_room AND price IN(SELECT MIN(price) FROM pm_rate WHERE id_room = :id_room)");
                $result_rate->bindParam(":id_room", $id_room);

                $result_room_file = $db->prepare("SELECT * FROM pm_room_file WHERE id_item = :id_room AND checked = 1 AND lang = ".LANG_ID." AND type = 'image' AND file != '' ORDER BY rank LIMIT 1");
                $result_room_file->bindParam(":id_room", $id_room, PDO::PARAM_STR);
     
                $result_room = $db->query("SELECT * FROM pm_room WHERE lang = ".LANG_ID." AND checked = 1 ORDER BY rank");
                if($result_room !== false){
                    $nb_rooms = $db->last_row_count();
                    foreach($result_room as $i => $row){
                        $id_room = $row['id'];
                        $room_title = $row['title'];
                        $room_subtitle = $row['subtitle'];
                        $room_price = $row['price'];
                        $room_descr = strtrunc(strip_tags($row['descr']),500);
                        
                        $room_alias = DOCBASE.$page['alias']."/".$row['alias']; ?>
                        
                        <article class="col-md-4 mb20" itemscope itemtype="http://schema.org/LodgingBusiness">
                            <a itemprop="url" href="<?php echo $room_alias; ?>">
                                <?php
                                $result_room_file->execute();
                                if($result_room_file !== false && $db->last_row_count() == 1){
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
                                                <img alt="<?php echo $label; ?>" src="<?php echo $thumbpath; ?>" itemprop="photo">
                                            </div>
                                            <span class="more-action">
                                                <span class="more-icon"><i class="fa fa-link"></i></span>
                                            </span>
                                        </figure>
                                        <?php
                                    }
                                } ?>
                                <div class="isotopeContent">
                                    <h3 itemprop="name"><?php echo $room_title; ?></h3>
                                    <h4><?php echo $room_subtitle; ?></h4>
                                    <?php
                                    $type = "night";
                                    $min_price = $room_price;
                                    $result_rate->execute();
                                    if($result_rate !== false && $db->last_row_count() == 1){
                                        $row = $result_rate->fetch();
                                        $price = $row['price'];
                                        $type = $row['type'];
                                        if($price > 0){
                                            switch($type){
                                                case "night": $type = $texts['NIGHT']; break;
                                                case "week": $type = $texts['WEEK']; break;
                                            }
                                            $min_price = $price;
                                        }
                                    } ?>
                                    
                                    <div class="row">
                                        <div class="col-xs-6">
                                            <div class="price text-primary">
                                                <?php echo $texts['FROM_PRICE']; ?>
                                                <span itemprop="priceRange">
                                                    <?php echo formatPrice($min_price*CURRENCY_RATE); ?>
                                                </span>
                                            </div>
                                            <div class="text-muted"><?php echo $texts['PRICE']; ?> / <?php echo $type; ?></div>
                                        </div>
                                        <div class="col-xs-6">
                                            <span class="btn btn-primary mt5 pull-right"><?php echo $texts['MORE_DETAILS']; ?></span>
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </article>
                        <?php
                    }
                } ?>
            </div>
        </div>
    </div>
</section>

