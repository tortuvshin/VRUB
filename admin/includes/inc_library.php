<?php debug_backtrace() || die ("Шууд хандах боломжгүй"); ?>
<div id="wrap-library" class="hidden-xs">
    <div id="library" class="show-grid">
        <?php
        if($db !== false){
            $nb_medias = 0;
            
            $modules_list = getModules(ADMIN_FOLDER."/modules");
            
            $dirname = dirname($_SERVER['SCRIPT_NAME']);
            $dirname = substr($dirname, strrpos($dirname, "/")+1);
            
            foreach($modules_list as $module){

                $title = $module->getTitle();
                $moduleName = $module->getName();
                $isLibrary = $module->isLibrary();
                $isMulti = $module->isMultilingual();
                
                if($isLibrary){
                    
                    $query_img_module = "SELECT * FROM pm_".$moduleName."_file WHERE file != '' AND type = 'image'";
                    if($isMulti) $query_img_module .= " AND lang = ".DEFAULT_LANG;
                    $query_img_module .= " ORDER BY rank";
                    
                    $result_img_module = $db->query($query_img_module);
                    
                    if($result_img_module !== false){
                        $nb_img = $db->last_row_count();
                        
                        $nb_medias += $nb_img;
                        
                        if($nb_img > 0){ ?>
                            
                            <div class="clearfix heading"><?php echo $title; ?> - <?php echo $texts['IMAGES']; ?></div>
                            <div class="container-fluid">
                                <div class="row">
                                    <?php
                                    foreach($result_img_module as $row_img_module){
                                        
                                        $id_img = $row_img_module['id'];
                                        $filename = $row_img_module['file'];
                                        $label = $row_img_module['label'];
                                        
                                        $big_path = "medias/".$moduleName."/big/".$id_img."/".$filename;
                                        $medium_path = "medias/".$moduleName."/medium/".$id_img."/".$filename;
                                        $small_path = "medias/".$moduleName."/small/".$id_img."/".$filename;
                                        
                                        if(is_file(SYSBASE.$medium_path)) $preview_path = $medium_path;
                                        elseif(is_file(SYSBASE.$big_path)) $preview_path = $big_path;
                                        elseif(is_file(SYSBASE.$small_path)) $preview_path = $small_path;
                                        else $preview_path = "";
                                                    
                                        if(is_file(SYSBASE.$big_path)) $zoom_path = $big_path;
                                        elseif(is_file(SYSBASE.$medium_path)) $zoom_path = $medium_path;
                                        elseif(is_file(SYSBASE.$small_path)) $zoom_path = $small_path;
                                        else $zoom_path = "";
                                        
                                        $abs_zoom_path = DOCBASE.$zoom_path;
                                        $abs_preview_path = DOCBASE.$preview_path;
                                        
                                        $max_w = 60;
                                        $max_h = 50;
                                        
                                        if(is_file(SYSBASE.$preview_path)){
                                            $dim = getimagesize(SYSBASE.$preview_path);
                                            $w = $dim[0];
                                            $h = $dim[1];
                                            
                                            $new_dim = getNewSize($w, $h, $max_w, $max_h);
                                            $new_w = $new_dim[0];
                                            $new_h = $new_dim[1];
                                            
                                            $margin_h = floor(($max_h-$new_h)/2);
                                            $margin_w = floor(($max_w-$new_w)/2); ?>
                                            
                                            <div class="col-xs-4 text-center">
                                                <a href="<?php echo $abs_zoom_path; ?>" title="<?php echo $label; ?>" class="image-link">
                                                    <img src="<?php echo $abs_preview_path; ?>" class="img-responsive" alt="<?php echo $label; ?>">
                                                </a>
                                                <?php
                                                echo $w." x ".$h."<br>";
                                                echo strtrunc($filename, 12, "...", true); ?>
                                            </div>
                                            
                                            <?php
                                        }
                                    } ?>
                                </div>
                            </div>
                            <?php
                        }
                    }
                    
                    $query_file_module = "SELECT * FROM pm_".$moduleName."_file WHERE file != '' AND type = 'other'";
                    if($isMulti) $query_file_module .= " AND lang = ".DEFAULT_LANG;
                    $query_file_module .= " ORDER BY rank";
                    
                    $result_file_module = $db->query($query_file_module);
                    
                    if($result_file_module !== false){
                        $nb_files = $db->last_row_count();
                        
                        $nb_medias += $nb_files;
                        
                        if($nb_files > 0){ ?>
                            
                            <div class="clearfix heading"><?php echo $title; ?> - <?php echo $texts['FILES']; ?></div>
                            <div class="container-fluid">
                                <div class="row">
                                    <?php
                                    foreach($result_file_module as $row_file_module){
                                        
                                        $id_file = $row_file_module['id'];
                                        $filename = $row_file_module['file'];
                                        $label = $row_file_module['label'];
                                        
                                        $ext = strtolower(ltrim(strrchr($filename, "."), "."));
                
                                        $icon_file = (isset($allowable_file_exts[$ext])) ? $allowable_file_exts[$ext] : "";
                                        
                                        $file_path = DOCBASE."medias/".$moduleName."/other/".$id_file."/".$filename; ?>
                                        
                                        <div class="col-xs-4 text-center">
                                            <a href="<?php echo $file_path; ?>" title="<?php echo $label; ?>" target="_blank">
                                                <img src="<?php echo DOCBASE."common/images/".$icon_file; ?>" alt="">
                                            </a>
                                            <?php echo strtrunc($filename, 12, "...", true); ?>
                                        </div>
                                        <?php
                                    } ?>
                                </div>
                            </div>
                            <?php
                        }
                    }
                }
            }
            if($nb_medias == 0) echo $texts['NO_MEDIA'];
        } ?>
        
        <div style="clear:both;"></div>
        
    </div>
    
    <a class="btn-slide left" href="#"></a>
</div>
