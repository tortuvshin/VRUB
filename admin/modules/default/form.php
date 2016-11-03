<?php
/**
 * Template of the module form
 */
debug_backtrace() || die ("Шууд хандах боломжгүй");
 
// Item ID
if(isset($_GET['id']) && is_numeric($_GET['id'])) $id = $_GET['id'];
elseif(isset($_POST['id']) && is_numeric($_POST['id'])) $id = $_POST['id'];
else{
    header("Location: index.php?view=list");
    exit();
}

// Item ID to delete
$id_file = (isset($_GET['file']) && is_numeric($_GET['file'])) ? $_GET['file'] : 0;
$id_row = (isset($_GET['row']) && is_numeric($_GET['row'])) ? $_GET['row'] : 0;

// Action to perform
$back = false;
$action = (isset($_GET['action'])) ? htmlentities($_GET['action'], ENT_QUOTES, "UTF-8") : "";
if(isset($_POST['edit']) || isset($_POST['edit_back'])){
    $action = "edit";
    if(isset($_POST['edit_back'])) $back = true;
}
if(isset($_POST['add']) || isset($_POST['add_back'])){
    $action = "add";
    $id = 0;
    if(isset($_POST['add_back'])) $back = true;
}

// Initializations
$file = array();
$img = array();
$img_label = array();
$file_label = array();
$fields_checked = true;
$total_lang = 1;
$rank = 0;
$old_rank = 0;
$home = 0;
$checked = 0;
$add_date = null;
$edit_date = time();
$publish_date = time();
$unpublish_date = null;
$id_user = $_SESSION['user']['id'];
$referer = DIR."index.php?view=form";

// Messages
if(NB_FILES > 0) $_SESSION['msg_notice'][] = $texts['EXPECTED_IMAGES_SIZE']." ".MAX_W_BIG." x ".MAX_H_BIG."px<br>";

// Creation of the unique token for uploadifive
if(!isset($_SESSION['uniqid'])) $_SESSION['uniqid'] = uniqid();
if(!isset($_SESSION['timestamp'])) $_SESSION['timestamp'] = time();
if(!isset($_SESSION['token'])) $_SESSION['token'] = md5("sessid_".$_SESSION['uniqid'].$_SESSION['timestamp']);

// Getting languages
if(MULTILINGUAL && $db != false){
    $result_lang = $db->query("SELECT id, title FROM pm_lang WHERE checked = 1 ORDER BY CASE main WHEN 1 THEN 0 ELSE 1 END, rank");
    if($result_lang !== false){
        $total_lang = $db->last_row_count();
        $langs = $result_lang->fetchAll(PDO::FETCH_ASSOC);
    }
}

// Last rank selection
if(RANKING && $db != false){
    $result_rank = $db->query("SELECT rank FROM pm_".MODULE." ORDER BY rank DESC LIMIT 1");
    $rank = ($result_rank !== false && $db->last_row_count() > 0) ? $result_rank->fetchColumn(0) + 1 : 1;
}

// Inclusions
require_once(SYSBASE.ADMIN_FOLDER."/includes/fn_form.php");

$fields = getFields($db);
if(is_null($fields)) $fields = array();

// Getting datas in the database
if($db !== false){
    $result = $db->query("SELECT * FROM pm_".MODULE." WHERE id = ".$id);
    if($result !== false){
        
        // Datas of the module
            
        foreach($result as $row){
            
            $id_lang = (MULTILINGUAL) ? $row['lang'] : 0;
            
            foreach($fields[MODULE]['fields'] as $fieldName => $field){
                if($field->getType() != "separator")
                    $field->setValue($row[$fieldName], 0, $id_lang);
            }
            
            if($id_lang == DEFAULT_LANG || $id_lang == 0){
                if(HOME) $home = $row['home'];
                if(VALIDATION) $checked = $row['checked'];
                if(RANKING) $old_rank = $row['rank'];
                if(DATES) $add_date = $row['add_date'];
                if(RELEASE){
                    $publish_date = $row['publish_date'];
                    $unpublish_date = $row['unpublish_date'];
                }
                if(db_column_exists($db, "pm_".MODULE, "id_user")){
                    $id_user = $row['id_user'];
                    if(!in_array($_SESSION['user']['type'], array("administrator", "manager", "editor")) && $id_user != $_SESSION['user']['id']){
                        header("Location: index.php?view=list");
                        exit();
                    }
                }
            }
        }
    }
    
    // Datas of the module's tables
        
    foreach($fields as $tableName => $fields_table){
        
        if($tableName != MODULE){
        
            $result = $db->query("SELECT * FROM pm_".$tableName." WHERE ".$fields_table['table']['fieldRef']." = ".$id);
            if($result !== false){
                
                foreach($result as $i => $row){
                    
                    $id_lang = (MULTILINGUAL) ? $row['lang'] : 0;
                
                    foreach($fields_table['fields'] as $fieldName => $field){
                        if($field->getType() != "separator")
                            $field->setValue($row[$fieldName], $i, $id_lang);
                    }
                }
            }
        }
    }
    
    // Insersion / update
    if(in_array("add", $permissions) || in_array("edit", $permissions) || in_array("all", $permissions)){
        if((($action == "add") || ($action == "edit")) && check_token($referer, "form", "post")){
            
            $files = array();
                    
            // Getting POST values
            for($i = 0; $i < $total_lang; $i++){
                
                $id_lang = (MULTILINGUAL) ? $langs[$i]['id'] : 0;
                
                foreach($fields as $tableName => $fields_table){
                    
                    foreach($fields_table['fields'] as $fieldName => $field){
                        $fieldName = $tableName."_".$fieldName."_";
                        $fieldName .= (MULTILINGUAL && !$field->isMultilingual()) ? DEFAULT_LANG : $id_lang;
                        
                        if(isset($_POST[$fieldName])){
                            
                            foreach($_POST[$fieldName] as $index => $value){
                        
                                switch($field->getType()){
                                    case "date" :
                                        $date = isset($_POST[$fieldName][$index]['date']) ? $_POST[$fieldName][$index]['date'] : "";
                                        if(!empty($date)) $date = strtotime($date." 00:00:00");
                                        if(is_numeric($date) && $date !== false)
                                            $field->setValue($date, $index, $id_lang);
                                        else
                                            $field->setValue(NULL, $index, $id_lang);
                                    break;
                                    case "datetime" :
                                        $date = isset($_POST[$fieldName][$index]['date']) ? $_POST[$fieldName][$index]['date'] : "";
                                        $hour = isset($_POST[$fieldName][$index]['hour']) ? $_POST[$fieldName][$index]['hour'] : "";
                                        $minute = isset($_POST[$fieldName][$index]['minute']) ? $_POST[$fieldName][$index]['minute'] : 0;
                                        if(!empty($date) && is_numeric($hour) && is_numeric($minute)) $date = strtotime($date." ".$hour.":".$minute.":00");
                                        if(is_numeric($date) && $date !== false)
                                            $field->setValue($date, $index, $id_lang);
                                        else
                                            $field->setValue(NULL, $index, $id_lang);
                                    break;
                                    case "password" :
                                        $value = ($value != "") ? md5($value) : "";
                                        if($value == "") $value = $field->getValue(false, $index, $id_lang);
                                        $field->setValue($value, $index, $id_lang);
                                    break;
                                    case "checkbox" :
                                    case "multiselect" :
                                        $value = isset($_POST[$fieldName][$index]) ? implode(",", $_POST[$fieldName][$index]) : "";
                                        $field->setValue($value, $index, $id_lang);
                                    break;
                                    case "alias" :
                                        $value = text_format($_POST[$fieldName][$index]);
                                        $field->setValue($value, $index, $id_lang);
                                    break;
                                    default :
                                        $value = isset($_POST[$fieldName][$index]) ? $_POST[$fieldName][$index] : "";
                                        $field->setValue($value, $index, $id_lang);
                                    break;
                                }
                            }
                        }
                    }
                }
            }
            
            // Remove row if (all fields = empty) and if (tableName != MODULE)
            
            foreach($fields as $tableName => $fields_table){
                if($tableName != MODULE){
                    $numRows = getNumMaxRows($fields, $tableName);
                    for($index = 0; $index < $numRows; $index++){
                        
                        $empty = true;
                        $id_row = 0;
                        if(isset($_POST[$tableName."_id_".DEFAULT_LANG][$index]))
                            $id_row = $_POST[$tableName."_id_".DEFAULT_LANG][$index];
                            
                        if($id_row == 0 || $id_row == ""){
                        
                            foreach($fields_table['fields'] as $fieldName => $field){
                                $value = $field->getValue(false, $index);
                                if(!empty($value)) $empty = false;
                            }
                            if($empty){
                                foreach($fields_table['fields'] as $fieldName => $field){
                                    $field->removeValue($index);
                                }
                            }
                        }
                    }
                }
            }
            
            if(VALIDATION && isset($_POST['checked']) && is_numeric($_POST['checked'])) $checked = $_POST['checked'];
            if(HOME && isset($_POST['home']) && is_numeric($_POST['home'])) $home = $_POST['home'];
            if(DATES && (!is_numeric($add_date) || $add_date == 0)) $add_date = time();
            if(RELEASE){
                $day = (isset($_POST['publish_date_day'])) ? $_POST['publish_date_day'] : "";
                $month = (isset($_POST['publish_date_month'])) ? $_POST['publish_date_month'] : "";
                $year = (isset($_POST['publish_date_year'])) ? $_POST['publish_date_year'] : "";
                $hour = (isset($_POST['publish_date_hour'])) ? $_POST['publish_date_hour'] : "";
                $minute = (isset($_POST['publish_date_minute'])) ? $_POST['publish_date_minute'] : "";
                if(is_numeric($day) && is_numeric($month) && is_numeric($year) && is_numeric($hour) && is_numeric($minute))
                    $publish_date = mktime($hour, $minute, 0, $month, $day, $year);
                else
                    $publish_date = NULL;
                    
                $day = (isset($_POST['unpublish_date_day'])) ? $_POST['unpublish_date_day'] : "";
                $month = (isset($_POST['unpublish_date_month'])) ? $_POST['unpublish_date_month'] : "";
                $year = (isset($_POST['unpublish_date_year'])) ? $_POST['unpublish_date_year'] : "";
                $hour = (isset($_POST['unpublish_date_hour'])) ? $_POST['unpublish_date_hour'] : "";
                $minute = (isset($_POST['unpublish_date_minute'])) ? $_POST['unpublish_date_minute'] : "";
                if(is_numeric($day) && is_numeric($month) && is_numeric($year) && is_numeric($hour) && is_numeric($minute))
                    $unpublish_date = mktime($hour, $minute, 0, $month, $day, $year);
                else
                    $unpublish_date = NULL;
            }
            if(isset($_POST['id_user'])) $id_user = $_POST['id_user'];
            
            if(checkFields($db, $fields, $id)){
                
                for($i = 0; $i < $total_lang; $i++){
                    
                    $id_lang = (MULTILINGUAL) ? $langs[$i]['id'] : 0;
                    
                    // Add / Edit item in the table of the module
                    
                    $data = array();
                    $data['id'] = $id;
                    $data['lang'] = $id_lang;
                    $data['rank'] = $rank;
                    $data['home'] = $home;
                    $data['checked'] = $checked;
                    $data['add_date'] = $add_date;
                    $data['edit_date'] = $edit_date;
                    $data['publish_date'] = $publish_date;
                    $data['unpublish_date'] = $unpublish_date;
                    $data['id_user'] = $id_user;
                        
                    foreach($fields[MODULE]['fields'] as $fieldName => $field)
                        $data[$fieldName] = $field->getValue(false, 0, $id_lang);
                    
                    if($action == "add" && (in_array("add", $permissions) || in_array("all", $permissions))){
                            
                        $result_insert = db_prepareInsert($db, "pm_".MODULE, $data);
                        
                        add_item($db, MODULE, $result_insert, $id_lang);

                    }elseif($action == "edit" && (in_array("edit", $permissions) || in_array("all", $permissions))){
                        
                        $query_exist = "SELECT * FROM pm_".MODULE." WHERE id = ".$id;
                        if(MULTILINGUAL) $query_exist .= " AND lang = ".$id_lang;
                        $result_exist = $db->query($query_exist);
                        
                        $data['rank'] = $old_rank;
                        
                        if($result_exist !== false){
                            if($db->last_row_count() > 0){
                                    
                                $result_update = db_prepareUpdate($db, "pm_".MODULE, $data);
                                
                                edit_item($db, MODULE, $result_update, $id, $id_lang);
                            }else{
                                $result_insert = db_prepareInsert($db, "pm_".MODULE, $data);
                                
                                add_item($db, MODULE, $result_insert, $id_lang);
                            }
                        }
                    }
                    
                    // Add / Edit items in other tables
                    if(empty($_SESSION['msg_error']) && $id > 0){
                    
                        foreach($fields as $tableName => $fields_table){
                            if($tableName != MODULE){
                                $numRows = getNumMaxRows($fields, $tableName);
                                for($index = 0; $index < $numRows; $index++){
                                    
                                    $id_row = $fields_table['fields']['id']->getValue(false, $index, $id_lang);
                                    
                                    $data = array();
                                    $data['lang'] = $id_lang;
                                    $data[$fields_table['table']['fieldRef']] = $id;
                                        
                                    foreach($fields_table['fields'] as $fieldName => $field)
                                        $data[$fieldName] = $field->getValue(false, $index, $id_lang);
                                    
                                    if($id_row == 0 && (in_array("add", $permissions) || in_array("all", $permissions))){
                                            
                                        $result_insert = db_prepareInsert($db, "pm_".$tableName, $data);
                                        if($result_insert->execute() !== false){
                                            $fields_table['fields']['id']->setValue($db->lastInsertId(), $index, $id_lang);
                                        }

                                    }elseif($id_row > 0 && (in_array("edit", $permissions) || in_array("all", $permissions))){
                                        
                                        $query_exist = "SELECT * FROM pm_".$tableName." WHERE id = ".$id_row;
                                        if(MULTILINGUAL) $query_exist .= " AND lang = ".$id_lang;
                                        $result_exist = $db->query($query_exist);
                                        
                                        if($result_exist !== false){
                                            if($db->last_row_count() > 0){
                                                    
                                                $result_update = db_prepareUpdate($db, "pm_".$tableName, $data);
                                                $result_update->execute();
                                                
                                            }else{
                                                $result_insert = db_prepareInsert($db, "pm_".$tableName, $data);
                                                if($result_insert->execute() !== false){
                                                    $fields_table['fields']['id']->setValue($db->lastInsertId(), $index, $id_lang);
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }else
                $_SESSION['msg_error'][] = $texts['FORM_ERRORS'];
        }
    }

    if(($back === true) && empty($_SESSION['msg_error']) && !empty($_SESSION['msg_success'])){
        header("Location: index.php?view=list");
        exit();
    }

    if(in_array("edit", $permissions) || in_array("all", $permissions)){
        // Row deletion
        if($action == "delete_row" && $id_row > 0 && isset($_GET['table']) && isset($_GET['fieldref']) && check_token($referer, "form", "get"))
            delete_row($db, $id, $id_row, "pm_".$_GET['table'], $_GET['fieldref']);
            
        // File deletion
        if($action == "delete_file" && $id_file > 0 && check_token($referer, "form", "get"))
            delete_file($db, $id_file);
            
        if($action == "delete_multi_file" && isset($_POST['multiple_file']) && check_token($referer, "form", "get"))
            delete_multi_file($db, $_POST['multiple_file'], $id);
            
        // File activation/deactivation
        if($action == "check_file" && $id_file > 0 && check_token($referer, "form", "get"))
            check($db, "pm_".MODULE."_file", $id_file, 1);

        if($action == "uncheck_file" && $id_file > 0 && check_token($referer, "form", "get"))
            check($db, "pm_".MODULE."_file", $id_file, 2);
            
        if($action == "check_multi_file" && isset($_POST['multiple_file']) && check_token($referer, "form", "get"))
            check_multi($db, "pm_".MODULE."_file", 1, $_POST['multiple_file']);
            
        if($action == "uncheck_multi_file" && isset($_POST['multiple_file']) && check_token($referer, "form", "get"))
            check_multi($db, "pm_".MODULE."_file", 2, $_POST['multiple_file']);
            
        // Files displayed in homepage
        if($action == "display_home_file" && $id_file > 0 && check_token($referer, "form", "get"))
            display_home($db, "pm_".MODULE."_file", $id_file, 1);

        if($action == "remove_home_file" && $id_file > 0 && check_token($referer, "form", "get"))
            display_home($db, "pm_".MODULE."_file", $id_file, 0);
            
        if($action == "display_home_multi_file" && isset($_POST['multiple_file']) && check_token($referer, "form", "get"))
            display_home_multi($db, "pm_".MODULE."_file", 1, $_POST['multiple_file']);
            
        if($action == "remove_home_multi_file" && isset($_POST['multiple_file']) && check_token($referer, "form", "get"))
            display_home_multi($db, "pm_".MODULE."_file", 0, $_POST['multiple_file']);
    }
}

// File download
if($action == "download" && isset($_GET['type'])){
    $type = $_GET['type'];
    if($id_file > 0){
        if($type == "image" || $type == "other"){
            $query_file = "SELECT file FROM pm_".MODULE."_file WHERE id = ".$id_file;
            if(MULTILINGUAL) $query_file .= " AND lang = ".DEFAULT_LANG;
            $result_file = $db->query($query_file);
            if($result_file !== false && $db->last_row_count() > 0){
                $file = $result_file->fetchColumn(0);
                
                if($type == "image"){
                    if(is_file(SYSBASE."medias/".MODULE."/big/".$id_file."/".$file))
                        $filepath = SYSBASE."medias/".MODULE."/big/".$id_file."/".$file;
                    elseif(is_file(SYSBASE."medias/".MODULE."/medium/".$id_file."/".$file))
                        $filepath = SYSBASE."medias/".MODULE."/medium/".$id_file."/".$file;
                    elseif(is_file(SYSBASE."medias/".MODULE."/small/".$id_file."/".$file))
                        $filepath = SYSBASE."medias/".MODULE."/small/".$id_file."/".$file;
                }elseif($type == "other" && is_file(SYSBASE."medias/".MODULE."/other/".$id_file."/".$file))
                    $filepath = SYSBASE."medias/".MODULE."/other/".$id_file."/".$file;
                if(isset($filepath)){
                    $mime = getFileMimeType($filepath);
                    if(strstr($_SERVER["HTTP_USER_AGENT"], "MSIE") == false){
                        header("Content-disposition: attachment; filename=".$file);
                        header("Content-Type: ".$mime);
                        header("Content-Transfer-Encoding: ".$mime."\n");
                        header("Content-Length: ".filesize($filepath));
                        header("Pragma: no-cache");
                        header("Cache-Control: must-revalidate, post-check=0, pre-check=0, public");
                        header("Expires: 0");
                    }
                    readfile($filepath);
                }
            }
        }
    }
}
$csrf_token = get_token("form"); ?>
<!DOCTYPE html>
<head>
    <?php include(SYSBASE.ADMIN_FOLDER."/includes/inc_header_form.php"); ?>
</head>
<body>
    <div id="overlay"><div id="loading"></div></div>
    <div id="wrapper">
        <?php
        include(SYSBASE.ADMIN_FOLDER."/includes/inc_top.php");
        
        if(!in_array("no_access", $permissions)){
            include(SYSBASE.ADMIN_FOLDER."/includes/inc_library.php"); ?>
            <form id="form" class="form-horizontal" role="form" action="index.php?view=form" method="post" enctype="multipart/form-data">
                <div id="page-wrapper">
                    <div class="page-header">
                        <div class="container-fluid">
                            <div class="row">
                                <div class="col-xs-6 col-sm-6 clearfix">
                                    <h1 class="pull-left"><i class="fa fa-<?php echo ICON; ?>"></i> <?php echo TITLE_ELEMENT; ?></h1>
                                </div>
                                <div class="col-xs-6 col-sm-6 clearfix pb15 text-right">
                                    <?php
                                    if(in_array("add", $permissions) || in_array("all", $permissions)){ ?>
                                        <a href="javascript:if(confirm('<?php echo $texts['LOOSE_DATAS']; ?>')) window.location = 'index.php?view=form&id=0';">
                                            <button type="button" class="btn btn-primary mt15" data-toggle="tooltip" data-placement="bottom" title="<?php echo $texts['NEW']; ?>">
                                                <i class="fa fa-plus-circle"></i><span class="hidden-sm hidden-xs"> <?php echo $texts['NEW']; ?></span>
                                            </button
                                        </a>
                                        <?php
                                    } ?>
                                    <a href="index.php?view=list">
                                        <button type="button" class="btn btn-default mt15" data-toggle="tooltip" data-placement="bottom" title="<?php echo $texts['BACK_TO_LIST']; ?>">
                                            <i class="fa fa-reply"></i><span class="hidden-sm hidden-xs"> <?php echo $texts['BACK_TO_LIST']; ?></span>
                                        </button>
                                    </a>
                                    <?php
                                    if($db !== false){
                                        if($id > 0){
                                            if(in_array("edit", $permissions) || in_array("all", $permissions)){ ?>
                                                <span><button type="submit" name="edit" class="btn btn-default mt15 hidden-sm" data-toggle="tooltip" data-placement="bottom" data-placement="bottom" title="<?php echo $texts['SAVE']; ?>"><i class="fa fa-floppy-o"></i><span class="hidden-sm hidden-xs"> <?php echo $texts['SAVE']; ?></span></button></span>
                                                <span><button type="submit" name="edit_back" class="btn btn-success mt15" data-toggle="tooltip" data-placement="bottom" title="<?php echo $texts['SAVE_EXIT']; ?>"><i class="fa fa-floppy-o"></i><span class="hidden-sm hidden-xs"> <?php echo $texts['SAVE_EXIT']; ?></span></button></span>
                                                <?php
                                            }
                                            if(in_array("add", $permissions) || in_array("all", $permissions)){ ?>
                                                <span><button type="submit" name="add" class="btn btn-default mt15" data-toggle="tooltip" data-placement="bottom" title="<?php echo $texts['REPLICATE']; ?>"><i class="fa fa-files-o"></i><span class="hidden-sm hidden-xs"> <?php echo $texts['REPLICATE']; ?></span></button></span>
                                                <?php
                                            }
                                        }else{
                                            if(in_array("add", $permissions) || in_array("all", $permissions)){ ?>
                                                <span><button type="submit" name="add" class="btn btn-default mt15 hidden-sm" data-toggle="tooltip" data-placement="bottom" title="<?php echo $texts['SAVE']; ?>"><i class="fa fa-floppy-o"></i><span class="hidden-sm hidden-xs"> <?php echo $texts['SAVE']; ?></span></button></span>
                                                <span><button type="submit" name="add_back" class="btn btn-success mt15" data-toggle="tooltip" data-placement="bottom" title="<?php echo $texts['SAVE_EXIT']; ?>"><i class="fa fa-floppy-o"></i><span class="hidden-sm hidden-xs"> <?php echo $texts['SAVE_EXIT']; ?></span></button></span>
                                                <?php
                                            }
                                        }
                                    } ?>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="container-fluid">
                    <div class="alert-container">
                        <div class="alert alert-success alert-dismissable"></div>
                        <div class="alert alert-warning alert-dismissable"></div>
                        <div class="alert alert-danger alert-dismissable"></div>
                    </div>
                    <?php
                    if($db !== false){ ?>
                        <input type="hidden" name="id" value="<?php echo $id; ?>"/>
                        <input type="hidden" name="csrf_token" value="<?php echo $csrf_token; ?>"/>
                        <div class="panel panel-default">
                            <?php
                            if(MULTILINGUAL){ ?>
                                <ul class="nav nav-tabs pt5">
                                    <?php
                                    for($i = 0; $i < $total_lang; $i++){
                                        $id_lang = $langs[$i]['id'];
                                        $title_lang = $langs[$i]['title']; ?>
                                    
                                        <li<?php if(DEFAULT_LANG == $id_lang) echo " class=\"active\""; ?>>
                                            <a data-toggle="tab" href="#lang_<?php echo $id_lang; ?>">
                                                <?php
                                                $result_img_lang = $db->query("SELECT id, file FROM pm_lang_file WHERE type = 'image' AND id_item = ".$id_lang." AND file != '' ORDER BY rank LIMIT 1");
                                                if($result_img_lang !== false && $db->last_row_count() > 0){
                                                    $row_img_lang = $result_img_lang->fetch();
                                                    $id_img_lang = $row_img_lang[0];
                                                    $file_img_lang = $row_img_lang[1];
                                                    
                                                    if(is_file(SYSBASE."medias/lang/big/".$id_img_lang."/".$file_img_lang))
                                                        echo "<img src=\"".DOCBASE."medias/lang/big/".$id_img_lang."/".$file_img_lang."\" alt=\"\" border=\"0\"> ";
                                                } ?>
                                                <span class="hidden-xs">
                                                    <?php echo $title_lang;
                                                    if(DEFAULT_LANG == $id_lang) echo " <em>(default)</em>"; ?>
                                                </span>
                                            </a>
                                        </li>
                                        <?php
                                    } ?>
                                </ul>
                                <?php
                            } ?>
                            <div class="panel-body">
                                <div class="tab-content">
                                    <?php
                                    for($i = 0; $i < $total_lang; $i++){
                                        
                                        $id_lang = (MULTILINGUAL) ? $langs[$i]['id'] : 0; ?>
                                        
                                        <div id="lang_<?php echo $id_lang; ?>" class="<?php if(MULTILINGUAL) echo "tab-pane fade"; if(DEFAULT_LANG == $id_lang) echo " in active"; ?>">
                                        
                                            <?php
                                            // Display fields
                                            
                                            foreach($fields as $tableName => $fields_table){
                                                if($tableName != MODULE){ ?>
                                                
                                                    <div class="row mb10">
                                                        <label class="col-lg-2 control-label text-left">
                                                            <?php
                                                            echo $fields_table['table']['tableLabel']; ?>
                                                        </label>
                                                        <div class="col-lg-10">
                                                            <div class="table-responsive">
                                                                <table class="table table-bordered table-hover table-striped form-table" id="table_<?php echo $tableName; ?>">
                                                                    <thead>
                                                                        <tr>
                                                                            <?php
                                                                            foreach($fields_table['fields'] as $field){ ?>
                                                                                <th>
                                                                                    <?php
                                                                                    echo $field->getLabel();
                                                                                    $comment = $field->getComment();
                                                                                    if($comment != ""){ ?>
                                                                                        <div class="text-info"><small><i class="fa fa-info"></i> <?php echo $comment; ?></small></div>
                                                                                        <?php
                                                                                    } ?>
                                                                                </th>
                                                                                <?php
                                                                            } ?>
                                                                            <th width="50"><?php echo $texts['ACTIONS']; ?></th>
                                                                        </th>
                                                                    </thead>
                                                                    <tbody>
                                                                        <?php
                                                                        $numRows = getNumMaxRows($fields, $tableName);
                                                                        for($index = 0; $index < $numRows; $index++){ ?>
                                                                            <tr>
                                                                                <?php
                                                                                foreach($fields_table['fields'] as $fieldName => $field){
                                                                                    $notice = $field->getNotice($index);
                                                                                    $type = $field->getType(); ?>
                                                                                    <td class="text-center input-<?php echo $type.getClassAttr($type, $field->getValidation(), $notice, $id_lang); ?>">
                                                                                        <?php
                                                                                        displayField($field, $tableName, $index, $id_lang);
                                                                                        if($notice != "" && ($id_lang == DEFAULT_LANG || $id_lang == 0)){ ?>
                                                                                            <span class="glyphicon glyphicon-remove form-control-feedback"></span>
                                                                                            <?php
                                                                                        }
                                                                                        if($notice != "" && ($id_lang == DEFAULT_LANG || $id_lang == 0)){ ?>
                                                                                            <p class="help-block"><?php echo $notice; ?></p>
                                                                                            <?php
                                                                                        } ?>
                                                                                    </td>
                                                                                    <?php
                                                                                } ?>
                                                                                <td class="text-center">
                                                                                    <?php
                                                                                    if(in_array("delete", $permissions) || in_array("all", $permissions)){ ?>
                                                                                        <a class="tips" href="javascript:if(confirm('<?php echo $texts['DELETE_CONFIRM2']." ".$texts['LOOSE_DATAS']; ?>')) window.location = 'index.php?view=form&id=<?php echo $id; ?>&table=<?php echo $tableName; ?>&row=<?php echo $fields_table['fields']['id']->getValue(false, $index); ?>&fieldref=<?php echo $fields_table['table']['fieldRef']; ?>&csrf_token=<?php echo $csrf_token; ?>&action=delete_row';" title="<?php echo $texts['DELETE']; ?>"><i class="fa fa-remove text-danger"></i></a>
                                                                                        <?php
                                                                                    } ?>
                                                                                </td>
                                                                            </tr>
                                                                            <?php
                                                                        }
                                                                        if($index == 0){ ?>
                                                                            <tr>
                                                                                <?php
                                                                                foreach($fields_table['fields'] as $fieldName => $field){
                                                                                    $type = $field->getType(); ?>
                                                                                    <td class="text-center input-<?php echo $type.getClassAttr($type, $field->getValidation(), "", $id_lang); ?>">
                                                                                        <?php displayField($field, $tableName, $index, $id_lang); ?>
                                                                                    </td>
                                                                                    <?php
                                                                                } ?>
                                                                                <td></td>
                                                                            </tr>
                                                                            <?php
                                                                        } ?>
                                                                    </tbody>
                                                                </table>
                                                            </div>
                                                            <a href="#table_<?php echo $tableName; ?>" class="new_entry btn btn-link"><i class="fa fa-plus"></i> <?php echo $texts['NEW_ENTRY']; ?></a>
                                                        </div>
                                                    </div>
                                                    <?php
                                                }else{
                                                
                                                    foreach($fields_table['fields'] as $fieldName => $field){
                                                    
                                                        if($id_lang == DEFAULT_LANG || $field->isMultilingual() || $id_lang == 0){
                                                            
                                                            $type = $field->getType();
                                                            $notice = $field->getNotice();
                                                            $comment = $field->getComment();
                                                            
                                                            if($type == "separator"){ ?>
                                                                <div class="row mb10">
                                                                    <div class="col-lg-12">
                                                                        <p><big><b><?php echo $label; ?></b></big></p>
                                                                        <hr class="mt0 mb0">
                                                                    </div>
                                                                </div>
                                                                <?php
                                                            }else{
                                                                $class = getClassAttr($type, $field->getValidation(), $notice, $id_lang); ?>
                                                                
                                                                <div class="row mb10">
                                                                    <label class="col-lg-2 control-label">
                                                                        <?php
                                                                        echo $field->getLabel();
                                                                        if(($id_lang == DEFAULT_LANG || $id_lang == 0) && $field->isRequired()) echo "&nbsp;<span class=\"red\">*</span>\n"; ?>
                                                                    </label>
                                                                    <div class="col-lg-6">
                                                                        <div class="<?php echo $class; ?>">
                                                                            <?php
                                                                            displayField($field, $tableName, 0, $id_lang);
                                                                            if($notice != "" && ($id_lang == DEFAULT_LANG || $id_lang == 0)){ ?>
                                                                                <span class="glyphicon glyphicon-remove form-control-feedback"></span>
                                                                                <?php
                                                                            }
                                                                            if($notice != "" && ($id_lang == DEFAULT_LANG || $id_lang == 0)){ ?>
                                                                                <p class="help-block"><?php echo $notice; ?></p>
                                                                                <?php
                                                                            } ?>
                                                                        </div>
                                                                    </div>
                                                                    <?php
                                                                    if($comment != ""){ ?>
                                                                        <div class="col-lg-4">
                                                                            <div class="pt5 pb5 bg-info text-info"><i class="fa fa-info"></i> <?php echo $comment; ?></div>
                                                                        </div>
                                                                        <?php
                                                                    } ?>
                                                                </div>
                                                                <?php
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                            
                                            if($id_lang == DEFAULT_LANG || $id_lang == 0){
                                                if(in_array("publish", $permissions) || in_array("all", $permissions)){
                                                    if(RELEASE){ ?>
                                                        <div class="row mb10">
                                                            <label class="col-md-2 control-label"><?php echo $texts['PUBLISH_DATE']; ?></label>
                                                            <div class="col-md-6 form-inline">
                                                                <?php
                                                                if(is_numeric($publish_date)){
                                                                    $day = date("j", $publish_date);
                                                                    $month = date("n", $publish_date);
                                                                    $year = date("Y", $publish_date);
                                                                    $hour = date("H", $publish_date);
                                                                    $minute = date("i", $publish_date);
                                                                }else{
                                                                    $day = "";
                                                                    $month = "";
                                                                    $year = "";
                                                                    $hour = "";
                                                                    $minute = "";
                                                                } ?>
                                                                
                                                                <select name="publish_date_year" class="form-control">
                                                                    <option value="">-</option>
                                                                    <?php
                                                                    for($y = date("Y") + 4; $y >= date("Y"); $y--){
                                                                        $selected = ($y == $year) ? " selected=\"selected\"" : "";
                                                                        echo "<option value=\"".$y."\"".$selected.">".$y."</option>\n";
                                                                    } ?>
                                                                </select>&nbsp;/&nbsp;
                                                                
                                                                <select name="publish_date_month" class="form-control">
                                                                    <option value="">-</option>
                                                                    <?php
                                                                    for($n = 1; $n <= 12; $n++){
                                                                        $selected = ($n == $month) ? " selected=\"selected\"" : "";
                                                                        echo "<option value=\"".$n."\"".$selected.">".$n."</option>\n";
                                                                    } ?>
                                                                </select>&nbsp;/&nbsp;
                                                                
                                                                <select name="publish_date_day" class="form-control">
                                                                    <option value="">-</option>
                                                                    <?php
                                                                    for($d = 1; $d <= 31; $d++){
                                                                        $selected = ($d == $day) ? " selected=\"selected\"" : "";
                                                                        echo "<option value=\"".$d."\"".$selected.">".$d."</option>\n";
                                                                    } ?>
                                                                </select>
                                                                
                                                                &nbsp;at&nbsp;
                                                                <select name="publish_date_hour" class="form-control">
                                                                    <option value="">-</option>
                                                                    <?php
                                                                    for($h = 0; $h <= 23; $h++){
                                                                        $selected = ($h == $hour) ? " selected=\"selected\"" : "";
                                                                        echo "<option value=\"".$h."\"".$selected.">".$h."</option>\n";
                                                                    } ?>
                                                                </select>&nbsp;:&nbsp;
                                                                
                                                                <select name="publish_date_minute" class="form-control">
                                                                    <option value="">-</option>
                                                                    <?php
                                                                    for($m = 0; $m <= 59; $m++){
                                                                        $selected = ($m == $minute) ? " selected=\"selected\"" : "";
                                                                        echo "<option value=\"".$m."\"".$selected.">".$m."</option>\n";
                                                                    } ?>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="row mb10">
                                                            <label class="col-md-2 control-label"><?php echo $texts['UNPUBLISH_DATE']; ?></label>
                                                            <div class="col-md-6 form-inline">
                                                                <?php
                                                                if(is_numeric($unpublish_date)){
                                                                    $day = date("j", $unpublish_date);
                                                                    $month = date("n", $unpublish_date);
                                                                    $year = date("Y", $unpublish_date);
                                                                    $hour = date("H", $unpublish_date);
                                                                    $minute = date("i", $unpublish_date);
                                                                }else{
                                                                    $day = "";
                                                                    $month = "";
                                                                    $year = "";
                                                                    $hour = "";
                                                                    $minute = "";
                                                                } ?>
                                                                
                                                                <select name="unpublish_date_year" class="form-control">
                                                                    <option value="">-</option>
                                                                    <?php
                                                                    for($y = date("Y") + 4; $y >= date("Y"); $y--){
                                                                        $selected = ($y == $year) ? " selected=\"selected\"" : "";
                                                                        echo "<option value=\"".$y."\"".$selected.">".$y."</option>\n";
                                                                    } ?>
                                                                </select>&nbsp;/&nbsp;
                                                                
                                                                <select name="unpublish_date_month" class="form-control">
                                                                    <option value="">-</option>
                                                                    <?php
                                                                    for($n = 1; $n <= 12; $n++){
                                                                        $selected = ($n == $month) ? " selected=\"selected\"" : "";
                                                                        echo "<option value=\"".$n."\"".$selected.">".$n."</option>\n";
                                                                    } ?>
                                                                </select>&nbsp;/&nbsp;
                                                                
                                                                <select name="unpublish_date_day" class="form-control">
                                                                    <option value="">-</option>
                                                                    <?php
                                                                    for($d = 1; $d <= 31; $d++){
                                                                        $selected = ($d == $day) ? " selected=\"selected\"" : "";
                                                                        echo "<option value=\"".$d."\"".$selected.">".$d."</option>\n";
                                                                    } ?>
                                                                </select>
                                                                
                                                                &nbsp;at&nbsp;
                                                                <select name="unpublish_date_hour" class="form-control">
                                                                    <option value="">-</option>
                                                                    <?php
                                                                    for($h = 0; $h <= 23; $h++){
                                                                        $selected = ($h == $hour) ? " selected=\"selected\"" : "";
                                                                        echo "<option value=\"".$h."\"".$selected.">".$h."</option>\n";
                                                                    } ?>
                                                                </select>&nbsp;:&nbsp;
                                                                
                                                                <select name="unpublish_date_minute" class="form-control">
                                                                    <option value="">-</option>
                                                                    <?php
                                                                    for($m = 0; $m <= 59; $m++){
                                                                        $selected = ($m == $minute) ? " selected=\"selected\"" : "";
                                                                        echo "<option value=\"".$m."\"".$selected.">".$m."</option>\n";
                                                                    } ?>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <?php
                                                    }
                                                    if(VALIDATION){ ?>
                                                        <div class="row mb10">
                                                            <label class="col-md-2 control-label"><?php echo $texts['RELEASE']; ?></label>
                                                            <div class="col-md-6">
                                                                <label class="radio-inline">
                                                                    <input name="checked" type="radio" value="1"<?php if($checked == 1) echo " checked=\"checked\""; ?>/>&nbsp;<?php echo $texts['PUBLISHED']; ?><br>
                                                                </label>
                                                                <label class="radio-inline">
                                                                    <input name="checked" type="radio" value="2"<?php if($checked == 2) echo " checked=\"checked\""; ?>/>&nbsp;<?php echo $texts['NOT_PUBLISHED']; ?><br>
                                                                </label>
                                                                <label class="radio-inline">
                                                                    <input name="checked" type="radio" value="0"<?php if($checked == 0) echo " checked=\"checked\""; ?>/>&nbsp;<?php echo $texts['AWAITING']; ?>
                                                                </label>
                                                            </div>
                                                        </div>
                                                        
                                                        <?php
                                                    }
                                                    if(HOME){ ?>
                                                        <div class="row mb10">
                                                            <label class="col-md-2 control-label"><?php echo $texts['HOMEPAGE']; ?></label>
                                                            <div class="col-md-6">
                                                                <label class="radio-inline">
                                                                    <input name="home" type="radio" value="1"<?php if($home == 1) echo " checked=\"checked\""; ?>/>&nbsp;<?php echo $texts['YES_OPTION']; ?><br>
                                                                </label>
                                                                <label class="radio-inline">
                                                                    <input name="home" type="radio" value="0"<?php if($home == 0) echo " checked=\"checked\""; ?>/>&nbsp;<?php echo $texts['NO_OPTION']; ?>
                                                                </label>
                                                            </div>
                                                        </div>
                                                        
                                                        <?php
                                                    }
                                                }
                                                if($_SESSION['user']['type'] == "administrator" && db_column_exists($db, "pm_".MODULE, "id_user")){ ?>
                                                    <div class="row mb10">
                                                        <div class="col-lg-8">
                                                            <div class="row">
                                                                <label class="col-lg-3 control-label"><?php echo $texts['USER']; ?></label>
                                                                <div class="col-lg-9">
                                                                    <div class=" form-inline">
                                                                        <select name="id_user" class="form-control">
                                                                            <?php
                                                                            $result_user = $db->query("SELECT * FROM pm_user ORDER BY login");
                                                                            if($result_user !== false){
                                                                                foreach($result_user as $user){ ?>
                                                                                    <option value="<?php echo $user['id']; ?>"<?php if($user['id'] == $id_user) echo " selected=\"selected\""; ?>>
                                                                                        <?php echo $user['login']; ?>
                                                                                    </option>
                                                                                    <?php
                                                                                }
                                                                            } ?>
                                                                        </select>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <?php
                                                }
                                            }
                                            if(NB_FILES > 0){ ?>
                                            
                                                <fieldset class="medias-gallery mt20">
                                                    <?php
                                                    $query_file = "SELECT * FROM pm_".MODULE."_file WHERE id_item = ".$id." AND file != ''";
                                                    if(MULTILINGUAL) $query_file .= " AND lang = ".$id_lang;
                                                    $query_file .= " ORDER BY rank";
                                                    $result_file = $db->query($query_file);
                                                    if($result_file != false){
                                                        
                                                        $nb_file = $db->last_row_count();
                                                        
                                                        $uploaded = $nb_file;
                                                        if(!empty($_SESSION['msg_error']) && empty($_SESSION['msg_success'])){
                                                            $files = browse_files(SYSBASE."medias/".MODULE."/tmp/".$_SESSION['token']."/".$id_lang);
                                                            $uploaded += count($files);
                                                        }
                                                        
                                                        $max_file = NB_FILES-$uploaded; ?>
                                                        
                                                        <legend class="form-inline">
                                                            <?php
                                                            echo "<span>".mb_strtoupper($texts['MEDIAS'], "UTF-8")."</span>";
                                                            
                                                            if($id_lang == DEFAULT_LANG || FILE_MULTI || $id_lang == 0){
                                                            
                                                                echo "&nbsp;&nbsp;".$uploaded."/".NB_FILES." - ".$max_file." ".$texts['REMAINING'];
                                                            
                                                                if($upload_allowed){
                                                                    if($nb_file > 0){
                                                                        if(in_array("edit", $permissions) || in_array("all", $permissions)){ ?>
                                                                            <select name="multiple_actions_file" class="form-control">
                                                                                <option value="">- <?php echo $texts['ACTIONS']; ?> -</option>
                                                                                <option value="check_multi_file"><?php echo $texts['PUBLISH']; ?></option>
                                                                                <option value="uncheck_multi_file"><?php echo $texts['UNPUBLISH']; ?></option>
                                                                                <option value="display_home_multi_file"><?php echo $texts['SHOW_HOMEPAGE']; ?></option>
                                                                                <option value="remove_home_multi_file"><?php echo $texts['REMOVE_HOMEPAGE']; ?></option>
                                                                                <option value="delete_multi_file"><?php echo $texts['DELETE']; ?></option>
                                                                            </select>
                                                                            <?php
                                                                        }
                                                                    }
                                                                    if($max_file > 0){ ?>
                                                                        <input type="file" name="file_upload_<?php echo $id_lang; ?>" id="file_upload_<?php echo $id_lang; ?>" class="file_upload" rel="<?php echo $id_lang.", ".$max_file; ?>"/>
                                                                        <?php
                                                                    }
                                                                }
                                                            } ?>
                                                        </legend>
                                                        
                                                        <?php
                                                        if(in_array("upload", $permissions) || in_array("all", $permissions)){ ?>
                                                            <div id="file_upload_<?php echo $id_lang; ?>-queue" class="uploadify-queue"></div>
                                                            <?php
                                                        } ?>
                                                        
                                                        <div class="uploaded clearfix alert alert-success" id="file_uploaded_<?php echo $id_lang; ?>">
                                                            <p><?php echo $texts['FILES_READY_UPLOAD']; ?></p>
                                                            <?php
                                                            if(!empty($_SESSION['msg_error']) && empty($_SESSION['msg_success'])){
                                                                foreach($files as $file){ ?>
                                                                    <div class="prev-file">
                                                                        <?php
                                                                        if($file[4] == 0 && $file[5] == 0 && array_key_exists($file[2], $allowable_file_exts)){
                                                    
                                                                            $icon_file = $allowable_file_exts[$file[2]]; ?>
                                                        
                                                                            <img src="<?php echo DOCBASE.ADMIN_FOLDER; ?>/images/<?php echo $icon_file; ?>" alt=""><br>
                                                                            <?php
                                                                            echo substr($file[1], 0, 15).((count($file[1]) >= 15) ? "..." : ".").$file[2]."<br>".$file[3];
                                                                        }else{ ?>
                                                                            <img src="<?php echo str_replace(SYSBASE, DOCBASE, $file[0]); ?>" alt="">
                                                                            <?php
                                                                            echo substr($file[1], 0, 15).((count($file[1]) >= 15) ? "..." : ".").$file[2]."<br>".$file[3]." | ".$file[4]." x ".$file[5];
                                                                        } ?>
                                                                    </div>
                                                                    <?php
                                                                }
                                                            } ?>
                                                        </div>
                                                        <ul class="files-list<?php if($id_lang == DEFAULT_LANG || FILE_MULTI || $id_lang == 0) echo " sortable"; ?>" id="files_list_<?php echo $id_lang; ?>">
                                                            <?php
                                                            foreach($result_file as $row_file){
                                                            
                                                                $filename = $row_file['file'];
                                                                $id_file = $row_file['id'];
                                                                $checked = $row_file['checked'];
                                                                $home = $row_file['home'];
                                                                $type = $row_file['type'];
                                                                
                                                                $label_file = htmlentities($row_file['label'], ENT_QUOTES, "UTF-8");
                                                        
                                                                $fieldname = "file_".$id_file."_".$id_lang;
                                                                
                                                                if($type == "other")
                                                                
                                                                    $file_path = "medias/".MODULE."/other/".$id_file."/".$filename;
                                                                
                                                                elseif($type == "image"){
                                                                
                                                                    $big_path = "medias/".MODULE."/big/".$id_file."/".$filename;
                                                                    $medium_path = "medias/".MODULE."/medium/".$id_file."/".$filename;
                                                                    $small_path = "medias/".MODULE."/small/".$id_file."/".$filename;
                                                                    
                                                                    if(RESIZING == 0 && is_file(SYSBASE.$big_path)) $preview_path = $big_path;
                                                                    elseif(RESIZING == 1 && is_file(SYSBASE.$medium_path)) $preview_path = $medium_path;
                                                                    elseif(is_file(SYSBASE.$small_path)) $preview_path = $small_path;
                                                                    elseif(is_file(SYSBASE.$medium_path)) $preview_path = $medium_path;
                                                                    elseif(is_file(SYSBASE.$big_path)) $preview_path = $big_path;
                                                                    else $preview_path = "";
                                                                                
                                                                    if(is_file(SYSBASE.$big_path)) $zoom_path = $big_path;
                                                                    elseif(is_file(SYSBASE.$medium_path)) $zoom_path = $medium_path;
                                                                    elseif(is_file(SYSBASE.$small_path)) $zoom_path = $small_path;
                                                                    else $zoom_path = "";
                                                                    
                                                                    $dim = @getimagesize(SYSBASE.$zoom_path);
                                                                    if(is_array($dim)){
                                                                        $w = $dim[0];
                                                                        $h = $dim[1];
                                                                    }else{
                                                                        $w = 0;
                                                                        $h = 0;
                                                                    }
                                                                }
                                                                
                                                                if(($type == "other" && is_file(SYSBASE.$file_path)) || ($type == "image" && is_file(SYSBASE.$preview_path) && is_file(SYSBASE.$zoom_path))){
                                                                    
                                                                    $ext = strtolower(ltrim(strrchr($filename, "."), "."));
                                                                    $filesize = "";
                                                                
                                                                    if($type == "other"){
                                                                        $weight = filesize(SYSBASE.$file_path);
                                                                        $preview_path = (isset($allowable_file_exts[$ext])) ? "common/images/".$allowable_file_exts[$ext] : "";
                                                                    }elseif($type == "image"){
                                                                        $weight = filesize(SYSBASE.$zoom_path);
                                                                        $filesize = $w." x ".$h." | ";
                                                                    }
                                                                        
                                                                    $filesize .= fileSizeConvert($weight); ?>
                                                                    
                                                                    <li id="file_<?php echo $id_file; ?>">
                                                                        <div class="prev-file">
                                                                            <img src="<?php echo DOCBASE.$preview_path; ?>" alt="" border="0">
                                                                        </div>
                                                                        <div class="actions-file">
                                                                            <?php
                                                                            if($type == "image"){ ?>
                                                                                <a class="image-link" href="<?php echo DOCBASE.$zoom_path; ?>" target="_blank"><i class="fa fa-search-plus"></i></a>
                                                                                <?php
                                                                            }
                                                                            if(in_array("edit", $permissions) || in_array("all", $permissions)){
                                                                                if($checked == 0){ ?>
                                                                                    <a class="tips" href="index.php?view=form&id=<?php echo $id; ?>&file=<?php echo $id_file; ?>&csrf_token=<?php echo $csrf_token; ?>&action=check_file" title="<?php echo $texts['PUBLISH']; ?>"><i class="fa fa-check text-success"></i></a>
                                                                                    <a class="tips" href="index.php?view=form&id=<?php echo $id; ?>&file=<?php echo $id_file; ?>&csrf_token=<?php echo $csrf_token; ?>&action=uncheck_file" title="<?php echo $texts['UNPUBLISH']; ?>"><i class="fa fa-ban text-danger"></i></a>
                                                                                    <?php
                                                                                }elseif($checked == 1){ ?>
                                                                                    <i class="fa fa-check text-muted"></i>
                                                                                    <a class="tips" href="index.php?view=form&id=<?php echo $id; ?>&file=<?php echo $id_file; ?>&csrf_token=<?php echo $csrf_token; ?>&action=uncheck_file" title="<?php echo $texts['UNPUBLISH']; ?>"><i class="fa fa-ban text-danger"></i></a>
                                                                                    <?php
                                                                                }elseif($checked == 2){ ?>
                                                                                    <a class="tips" href="index.php?view=form&id=<?php echo $id; ?>&file=<?php echo $id_file; ?>&csrf_token=<?php echo $csrf_token; ?>&action=check_file" title="<?php echo $texts['PUBLISH']; ?>"><i class="fa fa-check text-success"></i></a>
                                                                                    <i class="fa fa-ban text-muted"></i>
                                                                                    <?php
                                                                                }
                                                                                if($home == 0){ ?>
                                                                                    <a class="tips" href="index.php?view=form&id=<?php echo $id; ?>&file=<?php echo $id_file; ?>&csrf_token=<?php echo $csrf_token; ?>&action=display_home_file" title="<?php echo $texts['SHOW_HOMEPAGE']; ?>"><i class="fa fa-home text-danger"></i></a>
                                                                                    <?php
                                                                                }elseif($home == 1){ ?>
                                                                                    <a class="tips" href="index.php?view=form&id=<?php echo $id; ?>&file=<?php echo $id_file; ?>&csrf_token=<?php echo $csrf_token; ?>&action=remove_home_file" title="<?php echo $texts['REMOVE_HOMEPAGE']; ?>"><i class="fa fa-home text-success"></i></a>
                                                                                    <?php
                                                                                }
                                                                                if($upload_allowed){ ?>
                                                                                    <a class="tips" href="javascript:if(confirm('<?php echo $texts['DELETE_FILE_CONFIRM']." ".$texts['LOOSE_DATAS']; ?>')) window.location = 'index.php?view=form&id=<?php echo $id; ?>&file=<?php echo $id_file; ?>&csrf_token=<?php echo $csrf_token; ?>&action=delete_file';" title="<?php echo $texts['DELETE']; ?>"><i class="fa fa-remove text-danger"></i></a>
                                                                                    <?php
                                                                                }
                                                                            } ?>
                                                                            <a href="index.php?view=form&action=download&file=<?php echo $id_file; ?>&id=<?php echo $id; ?>&type=<?php echo $type; ?>"><i class="fa fa-download"></i></a>    
                                                                                
                                                                            <input type="checkbox" name="multiple_file[]" value="<?php echo $id_file; ?>"/>
                                                                        </div>
                                                                        <div class="infos-file">
                                                                            <input name="<?php echo $fieldname."_label"; ?>" placeholder="Label" class="form-control" type="text" value="<?php echo $label_file; ?>"/>
                                                                            <span class="filename"><?php echo strtrunc(substr($filename, 0, strrpos($filename, ".")), 23, "..", true).".".$ext; ?></span><br>
                                                                            <span class="filesize"><?php echo $filesize; ?></span>
                                                                        </div>
                                                                    </li>    
                                                                    <?php
                                                                }
                                                            } ?>
                                                        </ul>
                                                        
                                                        <?php
                                                    } ?>
                                                    <div style="clear:left;"></div>
                                                </fieldset>
                                                <?php
                                            } ?>
                                        </div>
                                        <?php
                                    }
                                    if(isset($result_lang)) $result_lang->closeCursor(); ?>
                                </div>
                            </div>
                        </div>
                        <?php
                    } ?>
                </div>
            </form>
            <?php
        }else echo "<p>".$texts['ACCESS_DENIED']."</p>"; ?>
    </div>
</body>
</html>
<?php
if(empty($_SESSION['msg_error'])) recursive_rmdir(SYSBASE."medias/".MODULE."/tmp/".$_SESSION['token']);
$_SESSION['redirect'] = false;
$_SESSION['msg_error'] = array();
$_SESSION['msg_success'] = array();
$_SESSION['msg_notice'] = array(); ?>
