<?php
/**
 * Template of the module listing
 */
debug_backtrace() || die ("Шууд хандах боломжгүй");
 
// Action to perform
$action = (isset($_GET['action'])) ? htmlentities($_GET['action'], ENT_QUOTES, "UTF-8") : "";

// Item ID
$id = (isset($_GET['id']) && is_numeric($_GET['id'])) ? $_GET['id'] : 0;

// Items per page
if(isset($_GET['limit']) && is_numeric($_GET['limit'])) $limit = $_GET['limit'];
elseif(isset($_SESSION['limit']) && isset($_SESSION['module_referer']) && $_SESSION['module_referer'] == MODULE) $limit = $_SESSION['limit'];
else $limit = 20;

$_SESSION['limit'] = $limit;

// current page
if(isset($_GET['offset']) && is_numeric($_GET['offset'])) $offset = $_GET['offset'];
elseif(isset($_SESSION['offset']) && isset($_SESSION['module_referer']) && $_SESSION['module_referer'] == MODULE) $offset = $_SESSION['offset'];
else $offset = 0;

$_SESSION['offset'] = $offset;

// Inclusions
require_once(SYSBASE.ADMIN_FOLDER."/includes/fn_list.php");

if($db !== false){
    // Initializations
    $cols = getCols();
    $filters = getFilters($db);
    if(is_null($cols)) $cols = array();
    if(is_null($filters)) $filters = array();
    $total = 0;
    $total_page = 0;
    $q_search = "";
    $result_lang = false;
    $total_lang = 1;
    $result = false;
    $referer = DIR."index.php?view=list";

    // Sort order
    if(isset($_GET['order'])) $order = htmlentities($_GET['order'], ENT_QUOTES, "UTF-8");
    elseif(isset($_SESSION['order']) && $_SESSION['order'] != "" && isset($_SESSION['module_referer']) && $_SESSION['module_referer'] == MODULE) $order = $_SESSION['order'];
    else $order = getOrder();

    if(isset($_GET['sort'])) $sort = htmlentities($_GET['sort'], ENT_QUOTES, "UTF-8");
    elseif(isset($_SESSION['sort']) && $_SESSION['sort'] != "" && isset($_SESSION['module_referer']) && $_SESSION['module_referer'] == MODULE) $sort = $_SESSION['sort'];
    else $sort = "asc";

    if(strpos($order, " ") !== false){
        $sort = strtolower(substr($order, strpos($order, " ")+1));
        $order = substr($order, 0, strpos($order, " "));
    }

    $_SESSION['order'] = $order;
    $_SESSION['sort'] = $sort;

    $rsort = ($sort == "asc") ? "desc" : "asc";

    // Getting languages
    if(MULTILINGUAL){
        $result_lang = $db->query("SELECT id, title FROM pm_lang WHERE id != ".DEFAULT_LANG." AND checked = 1");
        if($result_lang !== false)
            $total_lang = $db->last_row_count();
    }

    // Getting filters values
    if(isset($_SESSION['module_referer']) && $_SESSION['module_referer'] !== MODULE){
        unset($_SESSION['filters']);
        unset($_SESSION['q_search']);
    }
    if(isset($_POST['search'])){
        foreach($filters as $filter){
            $fieldName = $filter->getName();
            $value = (isset($_POST[$fieldName])) ? htmlentities($_POST[$fieldName], ENT_QUOTES, "UTF-8") : "";
            $filter->setValue($value);
        }
        $q_search = htmlentities($_POST['q_search'], ENT_QUOTES, "UTF-8");
        $_SESSION['filters'] = serialize($filters);
        $_SESSION['q_search'] = $q_search;
    }else{
        if(isset($_SESSION['filters'])) $filters = unserialize($_SESSION['filters']);
        if(isset($_SESSION['q_search'])) $q_search = $_SESSION['q_search'];
    }

    // Getting items in the database
    $condition = "";

    if(MULTILINGUAL) $condition .= " lang = ".DEFAULT_LANG;

    foreach($filters as $filter){
        $fieldName = $filter->getName();
        $fieldValue = $filter->getValue();
        if($fieldValue != ""){
            if($condition != "") $condition .= " AND";
            $condition .= " ".$fieldName." = '".$fieldValue."'";
        }
    }
    
    if(!in_array($_SESSION['user']['type'], array("administrator", "manager", "editor")) && db_column_exists($db, "pm_".MODULE, "id_user"))
        $condition .= " AND id_user = ".$_SESSION['user']['id'];
    
    $query_search = db_getRequestSelect($db, "pm_".MODULE, getSearchFieldsList($cols), $q_search, $condition, $order." ".$sort);

    $result_total = $db->query($query_search);
    if($result_total !== false)
        $total = $db->last_row_count();
        
    if($limit > 0) $query_search .= " LIMIT ".$limit." OFFSET ".$offset;

    $result = $db->query($query_search);
    if($result !== false)
        $total_page = $db->last_row_count();
        
    if(in_array("edit", $permissions) || in_array("all", $permissions)){
        
        // Setting main item
        if($action == "define_main" && $id > 0 && check_token($referer, "list", "get"))
            define_main($db, "pm_".MODULE, $id, 1);

        if($action == "remove_main" && $id > 0 && check_token($referer, "list", "get"))
            define_main($db, "pm_".MODULE, $id, 0);
            
        // Items displayed in homepage
        if($action == "display_home" && $id > 0 && check_token($referer, "list", "get"))
            display_home($db, "pm_".MODULE, $id, 1);

        if($action == "remove_home" && $id > 0 && check_token($referer, "list", "get"))
            display_home($db, "pm_".MODULE, $id, 0);
            
        if($action == "display_home_multi" && isset($_POST['multiple_item']) && check_token($referer, "list", "get"))
            display_home_multi($db, "pm_".MODULE, 1, $_POST['multiple_item']);
            
        if($action == "remove_home_multi" && isset($_POST['multiple_item']) && check_token($referer, "list", "get"))
            display_home_multi($db, "pm_".MODULE, 0, $_POST['multiple_item']);
            
        // Item activation/deactivation
        if($action == "check" && $id > 0 && check_token($referer, "list", "get"))
            check($db, "pm_".MODULE, $id, 1);

        if($action == "uncheck" && $id > 0 && check_token($referer, "list", "get"))
            check($db, "pm_".MODULE, $id, 2);
            
        if($action == "check_multi" && isset($_POST['multiple_item']) && check_token($referer, "list", "get"))
            check_multi($db, "pm_".MODULE, 1, $_POST['multiple_item']);
            
        if($action == "uncheck_multi" && isset($_POST['multiple_item']) && check_token($referer, "list", "get"))
            check_multi($db, "pm_".MODULE, 2, $_POST['multiple_item']);
    }
    
    if(in_array("delete", $permissions) || in_array("all", $permissions)){

        // Item deletion
        if($action == "delete" && $id > 0 && check_token($referer, "list", "get"))
            delete_item($db, $id);

        if($action == "delete_multi" && isset($_POST['multiple_item']) && check_token($referer, "list", "get"))
            delete_multi($db, $_POST['multiple_item']);
    }
    
    if(in_array("all", $permissions)){
        
        // Languages completion
        if(MULTILINGUAL && isset($_POST['complete_lang']) && isset($_POST['languages']) && check_token($referer, "list", "post")){
            foreach($_POST['languages'] as $id_lang){
                complete_lang_module($db, "pm_".MODULE, $id_lang);
                if(NB_FILES > 0) complete_lang_module($db, "pm_".MODULE."_file", $id_lang, true);
            }
        }
    }
}

$_SESSION['module_referer'] = MODULE;
$csrf_token = get_token("list"); ?>
<!DOCTYPE html>
<head>
    <?php include(SYSBASE.ADMIN_FOLDER."/includes/inc_header_list.php"); ?>
</head>
<body>
    <div id="wrapper">
        <?php include(SYSBASE.ADMIN_FOLDER."/includes/inc_top.php"); ?>
        <div id="page-wrapper">
            <div class="page-header">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-md-12 clearfix">
                            <h1 class="pull-left"><i class="fa fa-<?php echo ICON; ?>"></i> <?php echo TITLE_ELEMENT; ?></h1>
                            <div class="pull-left text-right">
                                &nbsp;&nbsp;
                                <?php
                                if(in_array("add", $permissions) || in_array("all", $permissions)){ ?>
                                    <a href="index.php?view=form&id=0" class="btn btn-primary mt15">
                                        <i class="fa fa-plus-circle"></i> <?php echo $texts['NEW']; ?>
                                    </a>
                                    <?php
                                } ?>
                            </div>
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
            if($db !== false){
                if(!in_array("no_access", $permissions)){ ?>
                    <form id="form" action="index.php?view=list" method="post">
                        <input type="hidden" name="csrf_token" value="<?php echo $csrf_token; ?>"/>
                        <div class="panel panel-default">
                            <div class="panel-heading form-inline clearfix">
                                <div class="row">
                                    <div class="col-md-6 text-left">
                                        <div class="form-inline">
                                            <input type="text" name="q_search" value="<?php echo $q_search; ?>" class="form-control input-sm" placeholder="<?php echo $texts['SEARCH']; ?>..."/>
                                            <?php displayFilters($filters); ?>
                                            <button class="btn btn-default btn-sm" type="submit" id="search" name="search"><i class="fa fa-search"></i> <?php echo $texts['SEARCH']; ?></button>
                                        </div>
                                    </div>
                                    <div class="col-md-6 text-right">
                                        <div class="input-group">
                                            <div class="input-group-addon"><i class="fa fa-th-list"></i> <?php echo $texts['DISPLAY']; ?></div>
                                            <select class="select-url form-control input-sm">
                                                <?php
                                                echo ($limit != 20) ? "<option value=\"index.php?view=list&limit=20\">20</option>" : "<option selected=\"selected\">20</option>";
                                                echo ($limit != 50) ? "<option value=\"index.php?view=list&limit=50\">50</option>" : "<option selected=\"selected\">50</option>";
                                                echo ($limit != 100) ? "<option value=\"index.php?view=list&limit=100\">100</option>" : "<option selected=\"selected\">100</option>"; ?>
                                            </select>
                                        </div>
                                        <?php
                                        if($limit > 0){
                                            $nb_pages = ceil($total/$limit);
                                            if($nb_pages > 1){ ?>
                                                <div class="input-group">
                                                    <div class="input-group-addon"><?php echo $texts['PAGE']; ?></div>
                                                    <select class="select-url form-control input-sm">
                                                        <?php

                                                        for($i = 1; $i <= $nb_pages; $i++){
                                                            $offset2 = ($i-1)*$limit;
                                                            
                                                            if($offset2 == $offset)
                                                                echo "<option value=\"\" selected=\"selected\">".$i."</option>";
                                                            else
                                                                echo "<option value=\"index.php?view=list&offset=".$offset2."\">".$i."</option>";
                                                        } ?>
                                                    </select>
                                                </div>
                                                <?php
                                            }
                                        } ?>
                                    </div>
                                </div>
                            </div>
                            <div class="table-responsive">
                                <table class="table table-bordered table-hover table-striped" id="listing_base">
                                    <thead>
                                        <tr class="nodrop nodrag">
                                            <th width="70">
                                                <?php
                                                if(RANKING){ ?>
                                                    <a href="index.php?view=list&order=rank&sort=<?php echo ($order == "rank") ? $rsort : "asc"; ?>">
                                                        # <i class="fa fa-sort<?php if($order == "rank") echo "-".$sort; ?>"></i>
                                                    </a>
                                                    <?php
                                                } ?>
                                            </th>
                                            <th width="70">
                                                <a href="index.php?view=list&order=id&sort=<?php echo ($order == "id") ? $rsort : "asc"; ?>">
                                                    ID <i class="fa fa-sort<?php if($order == "id") echo "-".$sort; ?>"></i>
                                                </a>
                                            </th>
                                            <?php
                                            if(NB_FILES > 0) echo "<th width=\"160\">".$texts['IMAGE']."</th>";
                                            foreach($cols as $col){ ?>
                                                <th>
                                                    <a href="index.php?view=list&order=<?php echo $col->getName(); ?>&sort=<?php echo ($order == $col->getName()) ? $rsort : "asc"; ?>">
                                                        <?php echo $col->getLabel(); ?>
                                                        <i class="fa fa-sort<?php if($order == $col->getName()) echo "-".$sort; ?>"></i>
                                                    </a>
                                                </th>
                                                <?php
                                            }
                                            if(count($cols) == 0){
                                                $type_module = "file";
                                                if(NB_FILES > 0){ ?>
                                                    <th><?php echo $texts['FILE']; ?></th>
                                                    <th><?php echo $texts['LABEL']; ?></th>
                                                    <?php
                                                }
                                            }
                                            if(DATES){ ?>
                                                <th width="160">
                                                    <a href="index.php?view=list&order=add_date&sort=<?php echo ($order == "add_date") ? $rsort : "asc"; ?>">
                                                        <?php echo $texts['ADDED_ON']; ?> <i class="fa fa-sort<?php if($order == "add_date") echo "-".$sort; ?>"></i>
                                                    </a>
                                                </th>
                                                <th width="160">
                                                    <a href="index.php?view=list&order=edit_date&sort=<?php echo ($order == "edit_date") ? $rsort : "asc"; ?>">
                                                        <?php echo $texts['UPDATED_ON']; ?> <i class="fa fa-sort<?php if($order == "edit_date") echo "-".$sort; ?>"></i>
                                                    </a>
                                                </th>
                                                <?php
                                            }
                                            if(MAIN){ ?>
                                                <th width="100">
                                                    <a href="index.php?view=list&order=main&sort=<?php echo ($order == "main") ? $rsort : "asc"; ?>">
                                                        <?php echo $texts['MAIN']; ?> <i class="fa fa-sort<?php if($order == "main") echo "-".$sort; ?>"></i>
                                                    </a>
                                                </th>
                                                <?php
                                            }
                                            if(HOME){ ?>
                                                <th width="100">
                                                    <a href="index.php?view=list&order=home&sort=<?php echo ($order == "home") ? $rsort : "asc"; ?>">
                                                        <?php echo $texts['HOME']; ?> <i class="fa fa-sort<?php if($order == "home") echo "-".$sort; ?>"></i>
                                                    </a>
                                                </th>
                                                <?php
                                            }
                                            if(VALIDATION){ ?>
                                                <th width="100">
                                                    <a href="index.php?view=list&order=checked&sort=<?php echo ($order == "checked") ? $rsort : "asc"; ?>">
                                                        <?php echo $texts['STATUS']; ?> <i class="fa fa-sort<?php if($order == "checked") echo "-".$sort; ?>"></i>
                                                    </a>
                                                </th>
                                                <?php
                                            } ?>
                                            <th width="110"><?php echo $texts['ACTIONS']; ?></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <?php
                                        if($result !== false){
                                            foreach($result as $i => $row){
                                                
                                                $id = $row['id'];
                                                $cols = getColsValues($db, $row, $i, $cols);
                                                
                                                if(isset($preview_path)) unset($preview_path); ?>
                                                
                                                <tr id="item_<?php echo $id ?>">
                                                
                                                    <td class="text-left">
                                                        <input type="checkbox" class="checkitem" name="multiple_item[]" value="<?php echo $id; ?>"/>
                                                        <?php if(RANKING) echo $row['rank']; ?>
                                                    </td>
                                                    
                                                    <td class="text-center"><?php echo $id; ?></td>
                                                    
                                                    <?php
                                                    if(NB_FILES > 0){
                                                        $query_img = "SELECT * FROM pm_".MODULE."_file WHERE type = 'image' AND id_item = ".$id." AND file != ''";
                                                        if(MULTILINGUAL) $query_img .= " AND lang = ".DEFAULT_LANG;
                                                        $query_img .= " ORDER BY rank LIMIT 1";
                                                        $result_img = $db->query($query_img);
                                                        
                                                        if($result_img !== false && $db->last_row_count() > 0){
                                                            $row_img = $result_img->fetch();
                                                        
                                                            $filename_img = $row_img['file'];
                                                            $id_img_file = $row_img['id'];
                                                            $label = $row_img['label'];
                                                            
                                                            $big_path = "medias/".MODULE."/big/".$id_img_file."/".$filename_img;
                                                            $medium_path = "medias/".MODULE."/medium/".$id_img_file."/".$filename_img;
                                                            $small_path = "medias/".MODULE."/small/".$id_img_file."/".$filename_img;
                                                            
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
                                                        } ?>
                                                    
                                                        <td class="text-center wrap-img">
                                                            <?php
                                                            if(isset($preview_path) && is_file(SYSBASE.$preview_path)){
                                                                    
                                                                $max_w = 160;
                                                                $max_h = 36;
                                                                $dim = getimagesize(SYSBASE.$preview_path);
                                                                $w = $dim[0];
                                                                $h = $dim[1]; ?>
                                                                
                                                                <a href="<?php echo DOCBASE.$zoom_path; ?>" class="image-link" rel="<?php echo DOCBASE.$zoom_path; ?>">
                                                                    <?php
                                                                    if($w < $max_w && $h < $max_h){
                                                                        $new_dim = getNewSize($w, $h, $max_w, $max_h);
                                                                
                                                                        $new_w = $new_dim[0];
                                                                        $new_h = $new_dim[1];
                                                                        
                                                                        $margin_w = round(($max_w-$new_w)/2);
                                                                        $margin_h = round(($max_h-$new_h)/2);
                                                                        
                                                                        echo "<img src=\"".DOCBASE.$preview_path."\" width=\"".$new_w."\" height=\"".$new_h."\" style=\"margin:".$margin_h."px ".$margin_w."px;\">";
                                                                    
                                                                    }elseif(($w/$max_w) > ($h/$max_h))
                                                                        echo "<img src=\"".DOCBASE.$preview_path."\" height=\"".$max_h."\" style=\"margin: 0px -".ceil(((($w*$max_h)/$h)/2)-($max_w/2))."px;\">";
                                                                    else
                                                                        echo "<img src=\"".DOCBASE.$preview_path."\" width=\"".$max_w."\" style=\"margin: -".ceil(((($h*$max_w)/$w)/2)-($max_h/2))."px 0px;\">"; ?>
                                                                </a>
                                                                <?php
                                                            } ?>
                                                        </td>
                                                        <?php
                                                    }
                                                    if(isset($type_module) && $type_module == "file"){
                                                    
                                                        $query_file = "SELECT * FROM pm_".MODULE."_file WHERE id_item = ".$id;
                                                        if(MULTILINGUAL) $query_file .= " AND lang = ".DEFAULT_LANG;
                                                        $query_file .= " ORDER BY rank LIMIT 1";
                                                        $result_file = $db->query($query_file);
                                                        
                                                        if($result_file !== false && $db->last_row_count() > 0){
                                                            $row_file = $result_file->fetch();
                                                            
                                                            $label = $row_file['label'];
                                                            $filename = $row_file['file'];
                                                        }else{
                                                            $label = "";
                                                            $filename = "";
                                                        }
                                                        echo "<td>".$filename."</td>";
                                                        echo "<td>".$label."</td>";
                                                    }
                                                    foreach($cols as $col){
                                                        echo "<td";
                                                        $type = $col->getType();
                                                        if($type == "date" || $type == "date") echo " class=\"text-center\"";
                                                        if($type == "price") echo " class=\"text-right\"";
                                                        echo ">".$col->getValue($i)."</td>";
                                                    }
                                                    if(DATES){
                                                        $add_date = (is_null($row['add_date'])) ? "-" : strftime(DATE_FORMAT." ".TIME_FORMAT, $row['add_date']);
                                                        $edit_date = (is_null($row['edit_date'])) ? "-" : strftime(DATE_FORMAT." ".TIME_FORMAT, $row['edit_date']); ?>
                                                        <td class="text-center">
                                                            <?php echo $add_date; ?>
                                                        </td>
                                                        <td class="text-center">
                                                            <?php echo $edit_date; ?>
                                                        </td>
                                                        <?php
                                                    }
                                                    if(MAIN){
                                                        $main = $row['main']; ?>
                                                        <td class="text-center">
                                                            <?php
                                                            if($main == 0){
                                                                if((in_array("publish", $permissions) || in_array("all", $permissions))){ ?>
                                                                    <a class="tips" href="index.php?view=list&id=<?php echo $id; ?>&csrf_token=<?php echo $csrf_token; ?>&action=define_main" title="<?php echo $texts['DEFINE_MAIN']; ?>"><i class="fa fa-star text-muted"></i></a>
                                                                    <?php
                                                                }else{ ?>
                                                                    <i class="fa fa-star text-muted"></i>
                                                                    <?php
                                                                }
                                                            }elseif($main == 1){ ?>
                                                                <i class="fa fa-star text-primary"></i>
                                                                <?php
                                                            } ?>
                                                        </td>
                                                        <?php
                                                    }
                                                    if(HOME){
                                                        $home = $row['home']; ?>
                                                        <td class="text-center">
                                                            <?php
                                                            if($home == 0){
                                                                if((in_array("publish", $permissions) || in_array("all", $permissions))){ ?>
                                                                    <a class="tips" href="index.php?view=list&id=<?php echo $id; ?>&csrf_token=<?php echo $csrf_token; ?>&action=display_home" title="<?php echo $texts['SHOW_HOMEPAGE']; ?>"><i class="fa fa-home text-danger"></i></a>
                                                                    <?php
                                                                }else{ ?>
                                                                    <i class="fa fa-home text-danger"></i>
                                                                    <?php
                                                                }
                                                            }elseif($home == 1){
                                                                if((in_array("publish", $permissions) || in_array("all", $permissions))){ ?>
                                                                    <a class="tips" href="index.php?view=list&id=<?php echo $id; ?>&csrf_token=<?php echo $csrf_token; ?>&action=remove_home" title="<?php echo $texts['REMOVE_HOMEPAGE']; ?>"><i class="fa fa-home text-success"></i></a>
                                                                    <?php
                                                                }else{ ?>
                                                                    <i class="fa fa-home text-success"></i>
                                                                    <?php
                                                                }
                                                            } ?>
                                                        </td>
                                                        <?php
                                                    }
                                                    if(VALIDATION){
                                                        $checked = $row['checked']; ?>
                                                        <td class="text-center">
                                                            <?php
                                                            if($checked == 0) echo "<span class=\"label label-warning\">".$texts['AWAITING']."</span>";
                                                            elseif($checked == 1) echo "<span class=\"label label-success\">".$texts['PUBLISHED']."</span>";
                                                            elseif($checked == 2) echo "<span class=\"label label-danger\">".$texts['NOT_PUBLISHED']."</span>"; ?>
                                                        </td>
                                                        <?php
                                                    } ?>
                                                    <td class="text-center">
                                                        <?php
                                                        if(VALIDATION && (in_array("publish", $permissions) || in_array("all", $permissions))){
                                                            if($checked == 0){ ?>
                                                                <a class="tips" href="index.php?view=list&id=<?php echo $id; ?>&csrf_token=<?php echo $csrf_token; ?>&action=check" title="<?php echo $texts['PUBLISH']; ?>"><i class="fa fa-check text-success"></i></a>
                                                                <a class="tips" href="index.php?view=list&id=<?php echo $id; ?>&csrf_token=<?php echo $csrf_token; ?>&action=uncheck" title="<?php echo $texts['UNPUBLISH']; ?>"><i class="fa fa-ban text-danger"></i></a>
                                                                <?php
                                                            }elseif($checked == 1){ ?>
                                                                <i class="fa fa-check text-muted"></i>
                                                                <a class="tips" href="index.php?view=list&id=<?php echo $id; ?>&csrf_token=<?php echo $csrf_token; ?>&action=uncheck" title="<?php echo $texts['UNPUBLISH']; ?>"><i class="fa fa-ban text-danger"></i></a>
                                                                <?php
                                                            }elseif($checked == 2){ ?>
                                                                <a class="tips" href="index.php?view=list&id=<?php echo $id; ?>&csrf_token=<?php echo $csrf_token; ?>&action=check" title="<?php echo $texts['PUBLISH']; ?>"><i class="fa fa-check text-success"></i></a>
                                                                <i class="fa fa-ban text-muted"></i>
                                                                <?php
                                                            }
                                                        }
                                                        if(in_array("edit", $permissions) || in_array("all", $permissions)){ ?>
                                                            <a class="tips" href="index.php?view=form&id=<?php echo $id; ?>" title="<?php echo $texts['EDIT']; ?>"><i class="fa fa-pencil"></i></a>
                                                            <?php
                                                        }
                                                        if(in_array("delete", $permissions) || in_array("all", $permissions)){ ?>
                                                            <a class="tips" href="javascript:if(confirm('<?php echo $texts['DELETE_CONFIRM2']; ?>')) window.location = 'index.php?view=list&id=<?php echo $id; ?>&csrf_token=<?php echo $csrf_token; ?>&action=delete';" title="<?php echo $texts['DELETE']; ?>"><i class="fa fa-remove text-danger"></i></a>
                                                            <?php
                                                        } ?>
                                                    </td>
                                                </tr>
                                                <?php
                                            }
                                        } ?>
                                    </tbody>
                                </table>
                            </div>
                            <?php
                            if($total == 0){ ?>
                                <div class="text-center mt20 mb20">- <?php echo $texts['NO_ELEMENT']; ?> -</div>
                                <?php
                            } ?>
                            <div class="panel-footer form-inline clearfix">
                                <div class="row">
                                    <div class="col-md-6 text-left">
                                        <?php
                                        if($total > 0){ ?>
                                            &nbsp;<input type="checkbox" class="selectall"/>
                                            <?php echo $texts['SELECT_ALL']; ?>&nbsp;
                                            <select name="multiple_actions" class="form-control input-sm">
                                                <option value="">- <?php echo $texts['ACTIONS']; ?> -</option>
                                                <?php
                                                if(in_array("publish", $permissions) || in_array("all", $permissions)){
                                                    if(VALIDATION){ ?>
                                                        <option value="check_multi"><?php echo $texts['PUBLISH']; ?></option>
                                                        <option value="uncheck_multi"><?php echo $texts['UNPUBLISH']; ?></option>
                                                        <?php
                                                    }
                                                    if(HOME){ ?>
                                                        <option value="display_home_multi"><?php echo $texts['SHOW_HOMEPAGE']; ?></option>
                                                        <option value="remove_home_multi"><?php echo $texts['REMOVE_HOMEPAGE']; ?></option>
                                                        <?php
                                                    }
                                                }
                                                if(in_array("delete", $permissions) || in_array("all", $permissions)){ ?>
                                                    <option value="delete_multi"><?php echo $texts['DELETE']; ?></option>
                                                    <?php
                                                } ?>
                                            </select>
                                            <?php
                                        } ?>
                                    </div>
                                    <div class="col-md-6 text-right">
                                        <div class="input-group">
                                            <div class="input-group-addon"><i class="fa fa-th-list"></i> <?php echo $texts['DISPLAY']; ?></div>
                                            <select class="select-url form-control input-sm">
                                                <?php
                                                echo ($limit != 20) ? "<option value=\"index.php?view=list&limit=20\">20</option>" : "<option selected=\"selected\">20</option>";
                                                echo ($limit != 50) ? "<option value=\"index.php?view=list&limit=50\">50</option>" : "<option selected=\"selected\">50</option>";
                                                echo ($limit != 100) ? "<option value=\"index.php?view=list&limit=100\">100</option>" : "<option selected=\"selected\">100</option>"; ?>
                                            </select>
                                        </div>
                                        
                                        <?php
                                        if($limit > 0){
                                            $nb_pages = ceil($total/$limit);
                                            if($nb_pages > 1){ ?>
                                                <div class="input-group">
                                                    <div class="input-group-addon"><?php echo $texts['PAGE']; ?></div>
                                                    <select class="select-url form-control input-sm">
                                                        <?php

                                                        for($i = 1; $i <= $nb_pages; $i++){
                                                            $offset2 = ($i-1)*$limit;
                                                            
                                                            if($offset2 == $offset)
                                                                echo "<option value=\"\" selected=\"selected\">".$i."</option>";
                                                            else
                                                                echo "<option value=\"index.php?view=list&offset=".$offset2."\">".$i."</option>";
                                                        } ?>
                                                    </select>
                                                </div>
                                                <?php
                                            }
                                        } ?>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <?php
                        if(in_array("all", $permissions)){ ?>
                            <div class="well">
                                <?php
                                if($db != false && MULTILINGUAL && $total_lang > 0){ ?>
                                        
                                    <div id="translation">
                                        <p><?php echo $texts['COMPLETE_LANGUAGE']; ?></p>
                                        <?php
                                        foreach($result_lang as $row_lang){
                                            $id_lang = $row_lang['id'];
                                            $title_lang = $row_lang['title']; ?>
                                            
                                            <input type="checkbox" name="languages[]" value="<?php echo $id_lang; ?>">
                                            <?php
                                            $result_img_lang = $db->query("SELECT * FROM pm_lang_file WHERE id_item = ".$id_lang." AND type = 'image' AND file != '' ORDER BY rank LIMIT 1");
                                            if($result_img_lang !== false && $db->last_row_count() > 0){
                                                $row_img_lang = $result_img_lang->fetch();
                                                
                                                $id_img_lang = $row_img_lang['id'];
                                                $file_img_lang = $row_img_lang['file'];
                                            
                                                if(is_file(SYSBASE."medias/lang/big/".$id_img_lang."/".$file_img_lang))
                                                    echo "<img src=\"".DOCBASE."medias/lang/big/".$id_img_lang."/".$file_img_lang."\" alt=\"\" border=\"0\" class=\"flag\"> ";
                                            }
                                            echo $title_lang."<br>";
                                        } ?>
                                        <button type="submit" name="complete_lang" class="btn btn-default mt10" data-toggle="tooltip" data-placement="right" title="<?php echo $texts['COMPLETE_LANG_NOTICE']; ?>"><i class="fa fa-magic"></i> <?php echo $texts['APPLY_LANGUAGE']; ?></button>
                                    </div>
                                    <?php
                                } ?>
                            </div>
                            <?php
                        } ?>
                    </form>
                    <?php
                }else echo "<p>".$texts['ACCESS_DENIED']."</p>";
            } ?>
        </div>
    </div>
</body>
</html>
<?php
$_SESSION['redirect'] = false;
$_SESSION['msg_error'] = array();
$_SESSION['msg_success'] = array();
$_SESSION['msg_notice'] = array(); ?>
