<?php
debug_backtrace() || die ("Шууд хандах боломжгүй");
/**
 * Library of actions performed since the listing and the form of a module
 */
$view = (isset($_GET['view'])) ? $_GET['view'] : "";

$redirection = "index.php?view=".$view;

if(isset($_POST['id'])) $redirection .= "&id=".$_POST['id'];
elseif(isset($_GET['id']) && $view == "form") $redirection .= "&id=".$_GET['id'];

define("REDIRECTION", $redirection);

/***********************************************************************
 * browse_files() browses the medias directory and get all files
 *
 * @param $dir      directory containing files
 * @param $files    file data array
 *
 * @return array
 *
 */
function browse_files($dir, $files = array())
{
    if(is_dir($dir)) $rep = opendir($dir) or die("Хавтас нээх үед алдаа гарлаа : ".$dir);
    
    while($entry = @readdir($rep)){
        if(is_dir($dir."/".$entry) && $entry != "." && $entry != "..")
            
            $files = browse_files($dir."/".$entry, $files);
            
        else{
            if(is_file($dir."/".$entry)){
                
                $ext = substr($entry, strrpos($entry, ".")+1);
                $weight = fileSizeConvert(filesize($dir."/".$entry));
                $dim = @getimagesize($dir."/".$entry);
                
                if((is_array($dim) && $dim[0] > 0 && $dim[1] > 0) || stripos(getFileMimeType($dir."/".$entry), "image") !== false){
                    $w = $dim[0];
                    $h = $dim[1];
                }else{
                    $w = "";
                    $h = "";
                }
                $filename = str_replace(".".$ext, "", substr($dir."/".$entry, strrpos($dir."/".$entry, "/")+1));
                
                $files[] = array($dir."/".$entry, $filename, $ext, $weight, $w, $h);
            }
        }
    }
    return $files;
}

/***********************************************************************
 * upload_files() copies the files uploaded and inserts the recordings into the database
 *
 * @param $db       database connection ressource
 * @param $id       ID of the item
 * @param $id_lang  ID of the current language
 * @param $dir      directory containing files
 *
 * @return void
 *
 */
function upload_files($db, $id, $id_lang, $dir)
{
    global $files;
    
    if($id_lang == 0 || $id_lang == DEFAULT_LANG || FILE_MULTI){
        
        $browsed_files = browse_files($dir);
    
        foreach($browsed_files as $file){
        
            $type = ($file[4] == "" && $file[5] == "") ? "other" : "image";
                            
            if($id_lang == 0 || $id_lang == DEFAULT_LANG || FILE_MULTI){

                $data['id'] = null;
                $data['lang'] = $id_lang;
                $data['file'] = $file[1].".".$file[2];
                $data['id_item'] = $id;
                $data['type'] = $type;
                $data['checked'] = 1;
                $data['home'] = 0;
                    
                $result_rank = $db->query("SELECT rank FROM pm_".MODULE."_file ORDER BY rank DESC LIMIT 1");
                $rank = ($result_rank !== false && $db->last_row_count() > 0) ? $result_rank->fetchColumn(0) + 1 : 1;
                $data['rank'] = $rank;
                
                $result = db_prepareInsert($db, "pm_".MODULE."_file", $data);
                
                if($result->execute() !== false){
                    
                    $error = true;
                    
                    $id_file = $db->lastInsertId();
                
                    if($type == "other"){
                        
                        if(!is_dir(SYSBASE."medias/".MODULE."/other/".$id_file))
                            mkdir(SYSBASE."medias/".MODULE."/other/".$id_file, 0777);
                        chmod(SYSBASE."medias/".MODULE."/other/".$id_file, 0777);
                        
                        if(copy($file[0], SYSBASE."medias/".MODULE."/other/".$id_file."/".$file[1].".".$file[2]))
                            $error = false;
                        
                    }elseif($type == "image"){
                        
                        if(RESIZING == 0 || RESIZING == 1){
                        
                            if(!is_dir(SYSBASE."medias/".MODULE."/big/".$id_file))
                                mkdir(SYSBASE."medias/".MODULE."/big/".$id_file, 0777);
                            chmod(SYSBASE."medias/".MODULE."/big/".$id_file, 0777);
                            
                            if(img_resize($file[0], SYSBASE."medias/".MODULE."/big/".$id_file, MAX_W_BIG, MAX_H_BIG))
                                $error = false;
                        }
                        if(RESIZING == 1){
                            
                            if(!is_dir(SYSBASE."medias/".MODULE."/medium/".$id_file))
                                mkdir(SYSBASE."medias/".MODULE."/medium/".$id_file, 0777);
                            chmod(SYSBASE."medias/".MODULE."/medium/".$id_file, 0777);
                            
                            if(img_resize($file[0], SYSBASE."medias/".MODULE."/medium/".$id_file, MAX_W_MEDIUM, MAX_H_MEDIUM))
                                $error = false;
                            
                            if(!is_dir(SYSBASE."medias/".MODULE."/small/".$id_file))
                                mkdir(SYSBASE."medias/".MODULE."/small/".$id_file, 0777);
                            chmod(SYSBASE."medias/".MODULE."/small/".$id_file, 0777);
                            
                            if(img_resize($file[0], SYSBASE."medias/".MODULE."/small/".$id_file, MAX_W_SMALL, MAX_H_SMALL))
                                $error = false;
                        }
                    }
                    if(is_file($file[0])) unlink($file[0]);
                    
                    if($error === true)
                        $db->query("DELETE FROM pm_".MODULE."_file WHERE id = ".$id_file);
                    else{
                        $data['id'] = $id_file;
                        $files[] = $data;
                    }
                }
            }
        }
    }else{
        foreach($files as $file){
            $file['lang'] = $id_lang;
            $result = db_prepareInsert($db, "pm_".MODULE."_file", $file);
            $result->execute();
        }
    }
}

/***********************************************************************
 * add_item() inserts an item into the database and handles the update of files
 *
 * @param $db               database connection ressource
 * @param $table            concerned table
 * @param $result_insert    PDOStatement object (prepared query)
 * @param $id_lang          ID of the current language
 *
 * @return void
 *
 */
function add_item($db, $table, $result_insert, $id_lang)
{
    global $id;
    global $texts;
    global $files;
    $lang = "";
    
    if(MULTILINGUAL){
        $result_lang = $db->query("SELECT title FROM pm_lang WHERE id = ".$id_lang);
        if($result_lang !== false && $db->last_row_count() > 0) $lang = $result_lang->fetchColumn(0)." - ";
    }
    
    if($result_insert->execute() !== false){
        
        if($id == 0) $id = $db->lastInsertId();
        
        if(is_numeric($id) && $id > 0)
            $_SESSION['msg_success'][] = $lang." ".$texts['ADD_SUCCESS'];
        else
            $_SESSION['msg_error'][] = $lang." ".$texts['UPDATE_ERROR'];
    }else
        $_SESSION['msg_error'][] = $lang." ".$texts['UPDATE_ERROR'];
        
    if(NB_FILES > 0){
        
        $dir = SYSBASE."medias/".MODULE."/tmp/".$_SESSION['token']."/".$id_lang;
        
        upload_files($db, $id, $id_lang, $dir);
        
        update_file_label($db, $id, $id_lang);
    }

    if(MODULE == "lang") complete_lang($db, $id);
}

/***********************************************************************
 * edit_item() updates an item in the database and handles the update of files
 *
 * @param $db               database connection ressource
 * @param $table            concerned table
 * @param $result_update    PDOStatement object (prepared query)
 * @param $id_lang          ID of the current language
 *
 * @return void
 *
 */
function edit_item($db, $table, $result_update, $id, $id_lang)
{
    global $texts;
    global $files;
    $lang = "";
    
    if(MULTILINGUAL){
        $result_lang = $db->query("SELECT title FROM pm_lang WHERE id = ".$id_lang);
        if($result_lang !== false && $db->last_row_count() > 0) $lang = $result_lang->fetchColumn(0)." - ";
    }
    
    if($result_update->execute() !== false)
        $_SESSION['msg_success'][] = $lang." ".$texts['UPDATE_SUCCESS'];
    else
        $_SESSION['msg_error'][] = $lang." ".$texts['UPDATE_ERROR'];
        
    if(NB_FILES > 0){
        
        $dir = SYSBASE."medias/".MODULE."/tmp/".$_SESSION['token']."/".$id_lang;
        
        upload_files($db, $id, $id_lang, $dir);
        
        update_file_label($db, $id, $id_lang);
    }
}

/***********************************************************************
 * update_file_label() updates the label of a media in the database
 *
 * @param $db       database connection ressource
 * @param $id       ID of the item
 * @param $id_lang  ID of the current language
 *
 * @return void
 *
 */
function update_file_label($db, $id, $id_lang)
{
    $query_file = "SELECT * FROM pm_".MODULE."_file WHERE id_item = ".$id;
    if(MULTILINGUAL) $query_file .= " AND lang = ".$id_lang;

    $result_file = $db->query($query_file);
    if($result_file !== false){
        
        foreach($result_file as $row){
            
            $file_id = $row['id'];
            $file_type = $row['type'];
            
            if(isset($_POST['file_'.$file_id.'_'.$id_lang.'_label'])){
                $file_label = html_entity_decode($_POST['file_'.$file_id.'_'.$id_lang.'_label'], ENT_QUOTES, "UTF-8");
                    
                $query = "UPDATE pm_".MODULE."_file SET label = '".$file_label."' WHERE id = ".$file_id;
                if(MULTILINGUAL) $query .= " AND lang = ".$id_lang;
                
                $db->query($query);
            }
        }
    }
}

/***********************************************************************
 * define_main() updates the column "main" in the database for an item
 *
 * @param $db       database connection ressource
 * @param $table    concerned table
 * @param $id       ID of the item
 *
 * @return void
 *
 */
function define_main($db, $table, $id)
{
    global $texts;
    if(MODULE == "lang") complete_lang($db, $id);
    if($db->query("UPDATE ".$table." SET main = 0") !== false){
        if($db->query("UPDATE ".$table." SET main = 1 WHERE id = ".$id) !== false)
            $_SESSION['msg_success'][] = $texts['MAIN_DEFINED'];
        else
            $_SESSION['msg_error'][] = $texts['UPDATE_ERROR'];
    }else
        $_SESSION['msg_error'][] = $texts['UPDATE_ERROR'];
        
    
    $_SESSION['redirect'] = true;
    header("Location: ".REDIRECTION);
    exit();
}

/***********************************************************************
 * display_home() updates the column "home" in the database for an item
 *
 * @param $db       database connection ressource
 * @param $table    concerned table
 * @param $id       ID of the item
 * @param $value    value of the column "home" 
 *
 * @return void
 *
 */
function display_home($db, $table, $id, $value, $redirection = true)
{
    global $texts;
    if($db->query("UPDATE ".$table." SET home = ".$value." WHERE id = ".$id) !== false)
        if($redirection) $_SESSION['msg_success'][] = ($value == 1) ? $texts['HOME_ADD']."<br>" : $texts['HOME_REMOVE'];
    else
        if($redirection) $_SESSION['msg_error'][] = $texts['UPDATE_ERROR'];
        
    if($redirection){
        $_SESSION['redirect'] = true;
        header("Location: ".REDIRECTION);
        exit();
    }
}

/***********************************************************************
 * display_home_multi() updates the column "home" in the database for multiple items
 *
 * @param $db       database connection ressource
 * @param $table    concerned table
 * @param $value    value of the column "home"
 * @param $items    array of items IDs
 *
 * @return void
 *
 */
function display_home_multi($db, $table, $value, $items)
{
    foreach($items as $id) display_home($db, $table, $id, $value, false);
        
    $_SESSION['redirect'] = true;
    header("Location: ".REDIRECTION);
    exit();
}

/***********************************************************************
 * check() updates the column "check" in the database for an item
 *
 * @param $db       database connection ressource
 * @param $table    concerned table
 * @param $id       ID of the item
 * @param $value    value of the column "check" 
 *
 * @return void
 *
 */
function check($db, $table, $id, $value, $redirection = true)
{
    global $texts;
    if($db->query("UPDATE ".$table." SET checked = ".$value." WHERE id = ".$id) !== false)
        if($redirection) $_SESSION['msg_success'][] = ($value == 1) ? $texts['ELMT_ENABLED']."<br>" : $texts['ELMT_DISABLED'];
    else
        if($redirection) $_SESSION['msg_error'][] = $texts['UPDATE_ERROR'];
        
    if($redirection){
        $_SESSION['redirect'] = true;
        header("Location: ".REDIRECTION);
        exit();
    }
}

/***********************************************************************
 * check() updates the column "check" in the database for multiple items
 *
 * @param $db       database connection ressource
 * @param $table    concerned table
 * @param $value    value of the column "check"
 * @param $items    array of items IDs
 *
 * @return void
 *
 */
function check_multi($db, $table, $value, $items)
{
    foreach($items as $id) check($db, $table, $id, $value, false);
        
    $_SESSION['redirect'] = true;
    header("Location: ".REDIRECTION);
    exit();
}

/***********************************************************************
 * delete_item() deletes an item from the database and handles the deletion of its associated files
 *
 * @param $db   database connection ressource
 * @param $id   ID of the item
 *
 * @return void
 *
 */
function delete_item($db, $id, $redirection = true)
{
    global $texts;
    if(NB_FILES > 0){
    
        $result_file = $db->query("SELECT file, id FROM pm_".MODULE."_file WHERE id_item = ".$id);
        if($result_file !== false){
        
            foreach($result_file as $row){
                $filename = $row['file'];
                $id_file = $row['id'];
                
                delete_file($db, $id_file, false);
            }
        }
    }
    
    if(RANKING) update_rank($db, "pm_".MODULE, $id);
    
    if($db->query("DELETE FROM pm_".MODULE." WHERE id = ".$id) !== false)
        if($redirection) $_SESSION['msg_success'][] = $texts['DELETE_SUCCESS'];
    else
        if($redirection) $_SESSION['msg_error'][] = $texts['UPDATE_ERROR'];
    
    if($redirection){
        $_SESSION['redirect'] = true;
        header("Location: ".REDIRECTION);
        exit();
    }
}

/***********************************************************************
 * update_rank() updates the column "rank" in the database for all items
 *
 * @param $db       database connection ressource
 * @param $table    concerned table
 * @param $id       ID of the item
 *
 * @return void
 *
 */
function update_rank($db, $table, $id, $id_item = 0)
{
    $result = $db->query("SELECT rank FROM ".$table." WHERE id = ".$id);
    if($result !== false && $db->last_row_count() > 0){
        
        $rank = $result->fetchColumn(0);
        $query = "SELECT id, rank FROM ".$table." WHERE rank > ".$rank;
        if($id_item > 0) $query .= " AND id_item = ".$id_item;
        $result = $db->query($query);

        foreach($result as $row){
            
            $old_rank = $row['rank'];
            $id_curr = $row['id'];
            $new_rank = $old_rank-1;
            $db->query("UPDATE ".$table." SET rank = ".$new_rank." WHERE id = ".$id_curr);
        }
    }
}

/***********************************************************************
 * delete_file() deletes a media from the database and handles the deletion of the concerned file
 *
 * @param $db       database connection ressource
 * @param $id_file  ID of the media
 *
 * @return void
 *
 */
function delete_file($db, $id_file, $redirection = true)
{
    global $texts;
    $result = $db->query("SELECT * FROM pm_".MODULE."_file WHERE id = ".$id_file);
    if($result !== false && $db->last_row_count() > 0){
        
        $row = $result->fetch();
        
        $filename = $row['file'];
        $id_item = $row['id_item'];
        $type_item = $row['type'];
        
        if($type_item == "other"){
    
            if(is_file(SYSBASE."medias/".MODULE."/other/".$id_file."/".$filename))
                unlink(SYSBASE."medias/".MODULE."/other/".$id_file."/".$filename);
            
        }elseif($type_item == "image"){
            
            if(is_file(SYSBASE."medias/".MODULE."/big/".$id_file."/".$filename))
                unlink(SYSBASE."medias/".MODULE."/big/".$id_file."/".$filename);
            
            if(is_dir(SYSBASE."medias/".MODULE."/big/".$id_file))
                rmdir(SYSBASE."medias/".MODULE."/big/".$id_file);
                
            if(is_file(SYSBASE."medias/".MODULE."/medium/".$id_file."/".$filename))
                unlink(SYSBASE."medias/".MODULE."/medium/".$id_file."/".$filename);
            
            if(is_dir(SYSBASE."medias/".MODULE."/medium/".$id_file))
                rmdir(SYSBASE."medias/".MODULE."/medium/".$id_file);
                
            if(is_file(SYSBASE."medias/".MODULE."/small/".$id_file."/".$filename))
                unlink(SYSBASE."medias/".MODULE."/small/".$id_file."/".$filename);
            
            if(is_dir(SYSBASE."medias/".MODULE."/small/".$id_file))
                rmdir(SYSBASE."medias/".MODULE."/small/".$id_file);
        }
        
        update_rank($db, MODULE."_file", $id_file, $id_item);
            
        if($db->query("DELETE FROM pm_".MODULE."_file WHERE id = ".$id_file) !== false)
            if($redirection) $_SESSION['msg_success'][] = $filename." - ".$texts['DELETE_SUCCESS'];
        else
            if($redirection) $_SESSION['msg_error'][] = $filename." - ".$texts['UPDATE_ERROR'];
    }
        
    if($redirection){
        $_SESSION['redirect'] = true;
        header("Location: ".REDIRECTION);
        exit();
    }
}

/***********************************************************************
 * delete_multi_file() deletes multiple medias from the database and handles the deletion of the concerned files
 *
 * @param $db       database connection ressource
 * @param $items    array of medias IDs
 *
 * @return void
 *
 */
function delete_multi_file($db, $items)
{
    foreach($items as $id_file) delete_file($db, $id_file, false);
    
    $_SESSION['redirect'] = true;
    header("Location: ".REDIRECTION);
    exit();
}

/***********************************************************************
 * delete_multi() deletes multiple items from the database
 *
 * @param $db       database connection ressource
 * @param $items    array of items IDs
 *
 * @return void
 *
 */
function delete_multi($db, $items)
{
    foreach($items as $id) delete_item($db, $id, false);
    
    $_SESSION['redirect'] = true;
    header("Location: ".REDIRECTION);
    exit();
}

/***********************************************************************
 * delete_row() deletes a row in the table of the form
 *
 * @param $db           database connection ressource
 * @param $id           ID of the item
 * @param $id_row       ID of the row
 * @param $table        concerned table
 * @param $fieldref     column of the foreign key
 *
 * @return void
 *
 */
function delete_row($db, $id, $id_row, $table, $fieldref)
{
    global $texts;
    if(db_table_exists($db, $table) && db_column_exists($db, $table, $fieldref)){
        if($db->query("DELETE FROM ".$table." WHERE id = ".$id_row." AND ".$fieldref." = ".$id) !== false)
            $_SESSION['msg_success'][] = $table." (ID ".$id_row.") - ".$texts['DELETE_SUCCESS'];
    }
    $_SESSION['redirect'] = true;
    header("Location: ".REDIRECTION);
    exit();
}

/***********************************************************************
 * complete_lang_module() fills the empty columns of a language with the
 * corresponding values in the default language for a module
 *
 * @param $db       database connection ressource
 * @param $module   module name
 * @param $id_lang  ID of the current language
 *
 * @return void
 *
 */
function complete_lang_module($db, $module, $id_lang, $loop = false)
{
    global $texts;
    $error = false;
    $title = "";
    
    if(db_table_exists($db, $module)){
        
        if(db_column_exists($db, $module, "lang")){
                    
            $title = db_getFieldValue($db, "pm_lang", "title", $id_lang);
            
            $cols_list = array();
            
            $result_default = $db->query("SELECT * FROM ".$module." WHERE lang = ".DEFAULT_LANG." ORDER BY id");
            $result_origin = $db->query("SELECT * FROM ".$module." WHERE lang = ".$id_lang." ORDER BY id");
            
            if($result_default !== false && $result_origin !== false){
                
                $nb_rows_default = $db->last_row_count();
                
                $rows_default = $result_default->fetchAll(PDO::FETCH_ASSOC);
                
                foreach($rows_default as $j => $row_default){
                    
                    $id = $row_default['id'];
                    
                    $result_exist = $db->query("SELECT * FROM ".$module." WHERE id = ".$id." AND lang = ".$id_lang);
                    
                    if($result_exist !== false && $db->last_row_count() == 1){
                    
                        $row_origin = $result_exist->fetch(PDO::FETCH_ASSOC);
                        
                        $query = "UPDATE ".$module." SET ";
                        
                        $k = 0;
                        foreach($row_origin as $colname => $value){    
                            
                            $query .= "".$colname." = ";
                            
                            if($value == ""){
                                $col_type = db_column_type($db, $module, $colname);
                                $query .= (is_null($value) || (preg_match("/.*(char|text).*/i", $col_type) === false && $value == "")) ? "NULL" : $db->quote($row_default[$colname]);
                            }else
                                $query .= $db->quote($value);
                                
                            if($k < count($row_origin)-1) $query .= ", ";
                            $k++;
                        }
                        $query .= " WHERE lang = ".$id_lang." AND id = ".$id;
                    
                    }else{
                        
                        $row_default['lang'] = $id_lang;
                        
                        $query = "INSERT INTO ".$module." VALUES(";
                        
                        $k = 0;
                        foreach($row_default as $colname => $value){            
                            
                            if($value == ""){
                                $col_type = db_column_type($db, $module, $colname);
                                $query .= (is_null($value) || (preg_match("/.*(char|text).*/i", $col_type) === false && $value == "")) ? "NULL" : "'".$value."'";
                            }else
                                $query .= $db->quote($value);
                            
                            if($k < count($row_default)-1) $query .= ", ";
                            $k++;
                        }
                        $query .= ")";
                    }
                    if($db->query($query) === false) $error = true;
                }
            }else $error = true;
        }
    }
    
    if($error !== true){
        if(!$loop) $_SESSION['msg_success'][] = $title." - ".$texts['TRANSLATE_SUCCESS'];
        if(substr($module, -5) != "_file") complete_lang_module($db, $module."_file", $id_lang, true);
        return true;
    }else{
        if(!$loop) $_SESSION['msg_error'][] = $title." - ".$texts['UPDATE_ERROR'];
        return false;
    }
}

/***********************************************************************
 * complete_lang() fills the empty columns of a language with the
 * corresponding values in the default language for all modules
 *
 * @param $db       database connection ressource
 * @param $id_lang  ID of the current language
 *
 * @return void
 *
 */
function complete_lang($db, $id_lang)
{
    global $texts;
    $modules_list = getModules(ADMIN_FOLDER."/modules");
    
    $error = false;
    
    $title = db_getFieldValue($db, "pm_lang", "title", $id_lang);
    
    foreach($modules_list as $module){
        if(complete_lang_module($db, "pm_".$module->getName(), $id_lang, true) === false) $error = true;
    }
    if(!$error)
        $_SESSION['msg_success'][] = $title." - ".$texts['TRANSLATE_SUCCESS'];
    else
        $_SESSION['msg_error'][] = $title." - ".$texts['UPDATE_ERROR'];
}
