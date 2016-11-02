<?php
debug_backtrace() || die ("Direct access not permitted");
/**
 * Functions needed by the form of a module
 * build (from config.xml), check and display fields
 */

/***********************************************************************
 * checkFields() checks the values send by POST
 *
 * @param $db database connection ressource
 * @param $table concerned table
 * @param $fields collection of field objects
 * @param $id ID of the item
 *
 * @return boolean
 *
 */
function checkFields($db, $table, $fields, $id)
{
    global $fields;
    global $texts;
    
    $valid = true;
    
    foreach($fields as $field){
        $value = $field->getValue();
        $label = $field->getLabel();
        if($field->isRequired() && $value == ""){
            $field->setNotice($texts['REQUIRED_FIELD']);
            $valid = false;
        }
        switch($field->getValidation()){
            case "mail":
                if(!filter_var($value, FILTER_VALIDATE_EMAIL) && $value != ""){
                    $field->setNotice($texts['INVALID_EMAIL']);
                    $valid = false;
                }
            break;
            case "numeric":
                if(!is_numeric($value)){
                    if($value != ""){
                        $field->setNotice($texts['NUMERIC_EXPECTED']);
                        $valid = false;
                    }else
                        $field->setValue(0);
                }                        
            break;
        }
        if($field->isUnique() && $value != "" && $db != false){
            $query_unique = "SELECT * FROM ".$table." WHERE ".$field->getName()." = '".$value."' AND id != ".$id;
            if(db_column_exists($db, $table, "lang")) $query_unique .= " AND lang = ".DEFAULT_LANG;
            $res_unique = $db->query($query_unique);
            if($res_unique !== false && $db->last_row_count() > 0){
                $field->setNotice($texts['VALUE_ALREADY_EXISTS']);
                $valid = false;
            }
        }
    }
    return $valid;
}

/***********************************************************************
 * getFields() returns a collection of field objects
 *
 * @param $db database connection ressource
 *
 * @return array
 *
 */
function getFields($db)
{
    $file = "config.xml";
    $dom = new DOMDocument();
    if(!$dom->load($file))
        die("Unable to load the XML file");
    if(!$dom->schemaValidate(dirname(__FILE__)."/config.xsd"))
        die("The XML file does not respect the schema");
        
    $root = $dom->getElementsByTagName("module")->item(0);
    $form = $root->getElementsByTagName("form")->item(0);
    $itemList = $form->getElementsByTagName("field");

    $fields = array();

    foreach($itemList as $item){
        
        $type = htmlentities($item->getAttribute("type"), ENT_QUOTES, "UTF-8");
        $label = htmlentities($item->getAttribute("label"), ENT_QUOTES, "UTF-8");
        $name = htmlentities($item->getAttribute("name"), ENT_QUOTES, "UTF-8");
        $required = htmlentities($item->getAttribute("required"), ENT_QUOTES, "UTF-8");
        $multilingual = htmlentities($item->getAttribute("multi"), ENT_QUOTES, "UTF-8");
        $editor = htmlentities($item->getAttribute("editor"), ENT_QUOTES, "UTF-8");
        $options = array();
        $relation = array();
        $validation = htmlentities($item->getAttribute("validation"), ENT_QUOTES, "UTF-8");
        $unique = htmlentities($item->getAttribute("unique"), ENT_QUOTES, "UTF-8");
        $comment = htmlentities($item->getAttribute("comment"), ENT_QUOTES, "UTF-8");
        $active = htmlentities($item->getAttribute("active"), ENT_QUOTES, "UTF-8");
        $optionTable = "";
        $roles = htmlentities($item->getAttribute("roles"), ENT_QUOTES, "UTF-8");
        if($roles == "") $roles = "all";
        $roles = explode(",", str_replace(" ", "", $roles));

        if($comment != "") $comment = str_ireplace("{currency}", DEFAULT_CURRENCY_SIGN, $comment);

        if(($type == "checkbox") || ($type == "select") || ($type == "multiselect") || ($type == "radio")){
            $itemOptions = $item->getElementsByTagName("options")->item(0);
            $optionList = $itemOptions->getElementsByTagName("option");
            $optionTable = htmlentities($itemOptions->getAttribute("table"), ENT_QUOTES, "UTF-8");
            $fieldLabel = htmlentities($itemOptions->getAttribute("fieldlabel"), ENT_QUOTES, "UTF-8");
            $fieldValue = htmlentities($itemOptions->getAttribute("fieldvalue"), ENT_QUOTES, "UTF-8");
            
            if($db != false && $optionTable != "" && $fieldLabel != "" && $fieldValue != ""){
                if($optionList->length > 0){
                    foreach($optionList as $option)
                        $options[htmlentities($option->getAttribute("value"), ENT_QUOTES, "UTF-8")] = htmlentities($option->nodeValue, ENT_QUOTES, "UTF-8");
                }
                
                $order = htmlentities($itemOptions->getAttribute("order"), ENT_QUOTES, "UTF-8");
                
                $query_option = "SELECT * FROM ".$optionTable;
                if(db_column_exists($db, $optionTable, "lang")) $query_option .=  " WHERE lang = ".DEFAULT_LANG;
                if($order != "") $query_option .= " ORDER BY ".$order;

                $result_option = $db->query($query_option);
                if($result_option !== false){
                    $optionLabel = "";
                    $nb_values = $db->last_row_count();
                    foreach($result_option as $j => $row_option){
                        
                        $arr_fieldLabel = preg_split("/([^a-z0-9_]+)/i", $fieldLabel);
                        $seps = array_values(array_filter(preg_split("/([a-z0-9_]+)/i", $fieldLabel)));
                        
                        $optionLabel = "";
                        $n2 = 0;
                        $lgt2 = count($arr_fieldLabel);
                        foreach($arr_fieldLabel as $str_fieldLabel){
                            $optionLabel .= $row_option[$str_fieldLabel];
                            if(isset($seps[$n2]) && $n2+1 < $lgt2) $optionLabel .= $seps[$n2];
                            $n2++;
                        }
                        $optionValue = $row_option[$fieldValue];
                        $options[$optionValue] = $optionLabel;
                    }
                }
                
            }elseif($optionList->length > 0){
                foreach($optionList as $option)
                    $options[htmlentities($option->getAttribute("value"), ENT_QUOTES, "UTF-8")] = htmlentities($option->nodeValue, ENT_QUOTES, "UTF-8");
            
            }elseif($itemOptions->getElementsByTagName("min")->length == 1 && $itemOptions->getElementsByTagName("max")->length == 1){
                $min = htmlentities($itemOptions->getElementsByTagName("min")->item(0)->nodeValue, ENT_QUOTES, "UTF-8");
                $max = htmlentities($itemOptions->getElementsByTagName("max")->item(0)->nodeValue, ENT_QUOTES, "UTF-8");
                if(is_numeric($min) && is_numeric($max)){
                    for($i = $min; $i <= $max; $i++)
                        $options[$i] = $i;
                }
            }
        }
        if($type == "filelist"){
            $itemOptions = $item->getElementsByTagName("options")->item(0);
            $optionDirectory = htmlentities($itemOptions->getAttribute("directory"), ENT_QUOTES, "UTF-8");
            $optionDirectory = str_replace("{template}", TEMPLATE, $optionDirectory);
            $rep = opendir($optionDirectory) or die("Error directory opening : ".$optionDirectory);
            while($entry = @readdir($rep)){
                if($entry != "." && $entry != ".."){
                    $entry = str_replace(".php", "", $entry);
                    $options[$entry] = $entry;
                }
            }
        }
        
        $fields[$name] = new Field($name, $label, $type, $required, $validation, $options, $multilingual, $unique, $comment, $active, $editor, $optionTable, $relation, $roles);
    }
    return $fields;
}

/***********************************************************************
 * displayFields()
 *
 * @param $fields collection of field objects
 * @param $id_lang ID of the current language
 *
 * @return void
 *
 */
function displayFields($fields, $id_lang)
{
    foreach($fields as $field){
        
        $type = $field->getType();
        $label = $field->getLabel();
        $name = $field->getName();
        $required = $field->isRequired();
        $options = $field->getOptions();
        $editor = $field->isEditor();
        $multilingual = $field->isMultilingual();
        $validation = $field->getValidation();
        $comment = $field->getComment();
        $notice = $field->getNotice();
        $active = $field->isActive();
        
        $allowed = $field->isAllowed($_SESSION['user']['type']);
        
        $value = $field->getValue(true, $id_lang);
        if(!is_array($value)) $value = stripslashes($field->getValue(true, $id_lang));
        
        $str_active = ($active == 0) ? " readonly=\"readonly\"" : "";
        
        $inputname = $name.$id_lang;
        
        $i = 0;
        
        if($allowed && (($id_lang == DEFAULT_LANG) || ($multilingual) || ($id_lang == 0))){
            
            if($type == "separator"){ ?>
                <br>
                <?php
            }elseif($type != "current_date"){
                $class = "";
                if(($type == "text" && $validation == "numeric")
                    || $type == "select"
                    || $type == "filelist"
                    || $type == "multiselect"
                    || $type == "date"
                    || $type == "datetime")
                    $class .= " form-inline";
                if($notice != "" && ($id_lang == DEFAULT_LANG || $id_lang == 0))
                    $class .= " has-error has-feedback"; ?>
                
                <div class="row mb10">
                    <div class="col-lg-8">
                        <div class="row">
                            <label class="col-lg-3 control-label">
                                <?php
                                echo $label;
                                if(($id_lang == DEFAULT_LANG || $id_lang == 0) && $required) echo "&nbsp;<span class=\"red\">*</span>\n"; ?>
                            </label>
                            <div class="col-lg-9">
                                <div class="<?php echo $class; ?>">
                                    <?php
                                    switch($type){
                                        case "text" :
                                        case "alias" :
                                            echo "<input type=\"text\"".$str_active." name=\"".$inputname."\" value=\"".$value."\" class=\"form-control\"/>\n";
                                        break;
                                        case "password" :
                                            echo "<input type=\"password\"".$str_active." name=\"".$inputname."\" value=\"\" size=\"30\" class=\"form-control\"/>\n";
                                        break;
                                        case "textarea" :
                                            echo "<textarea name=\"".$inputname."\"".$str_active." id=\"".$inputname."\" cols=\"40\" rows=\"5\" class=\"form-control\">".$value."</textarea>\n";
                                        break;
                                        case "select" :
                                        case "filelist" :
                                            echo "<select name=\"".$inputname."\"".$str_active." class=\"form-control\">\n";
                                            
                                            if(!$required) echo "<option value=\"\">-</option>\n";
                                            
                                            foreach($options as $option){
                                                $key = key($options);
                                                $selected = ($value == $key) ? " selected=\"selected\"" : "";
                                                echo "<option value=\"".$key."\"".$selected.">".$options[$key]."</option>\n";
                                                next($options);
                                            }
                                            echo "</select>\n";
                                        break;
                                        case "multiselect" :
                                            $size = (count($options) > 4) ? 8 : 4;
                                            $selected = array();
                                            $value = explode(",", $value);
                                            
                                            echo "<select name=\"".$inputname."_tmp[]\" multiple=\"multiple\" id=\"".$inputname."_tmp\" size=\"".$size."\"".$str_active." class=\"form-control\">\n";
                                            
                                            foreach($options as $key => $option){
                                                if((is_array($value) && !in_array($key, $value)) || (!is_array($value) && $key != $value))
                                                    echo "<option value=\"".$key."\">".$options[$key]."</option>\n";
                                            }
                                            echo "</select>";
                                            
                                            echo "
                                                <a href=\"#\" class=\"btn btn-default remove_option\" rel=\"".$inputname."\"><i class=\"fa fa-arrow-left\"></i></a>
                                                <a href=\"#\" class=\"btn btn-default add_option\" rel=\"".$inputname."\"><i class=\"fa fa-arrow-right\"></i></a>
                                                <select name=\"".$inputname."[]\" multiple=\"multiple\" id=\"".$inputname."\" size=\"".$size."\"".$str_active." class=\"form-control\">\n";
                                                foreach($options as $key => $option){
                                                    if(((is_array($value) && in_array($key, $value)) || (!is_array($value) && $key == $value)) && $key != "")
                                                        echo "<option value=\"".$key."\" selected=\"selected\">".$options[$key]."</option>\n";
                                                }
                                                echo "</select>\n";
                                        break;
                                        case "checkbox" :
                                            foreach($options as $option){
                                                $key = key($options);
                                                $checked = ($value == $key) ? " checked=\"checked\"" : "";                    
                                                echo "<label class=\"checkbox-inline\"><input name=\"".$inputname."[]\" type=\"checkbox\"".$str_active." value=\"".$key."\"".$checked."/>&nbsp;".$options[$key]."</label>\n";
                                                next($options);
                                                $i++;
                                            }
                                        break;
                                        case "radio" :
                                            foreach($options as $option){
                                                $key = key($options);
                                                $checked = ($value == $key) ? " checked=\"checked\"" : "";        
                                                echo "<label class=\"radio-inline\"><input name=\"".$inputname."\" type=\"radio\"".$str_active." value=\"".$key."\"".$checked."/>&nbsp;".$options[$key]."</label>\n";
                                                next($options);
                                                $i++;
                                            }
                                        break;
                                        case "date" :
                                        case "datetime" :
                                            if($value == "" || $value == 0) $value = ($required) ? time() : NULL;
                                            
                                            if(is_numeric($value)){
                                                $day = date("j", $value);
                                                $month = date("n", $value);
                                                $year = date("Y", $value);
                                            }else{
                                                $day = "";
                                                $month = "";
                                                $year = "";
                                            }
                                            if($type == "datetime"){
                                                if(is_numeric($value)){
                                                    $hour = date("H", $value);
                                                    $minute = date("i", $value);
                                                }else{
                                                    $hour = "";
                                                    $minute = "";
                                                }
                                            }
                                            
                                            echo "<select name=\"".$inputname."_year\"".$str_active." class=\"form-control\">\n";
                                            echo "<option value=\"\">-</option>";
                                                for($i = date("Y") + 4; $i >= date("Y") - 90; $i--){
                                                    $selected = ($i == $year) ? " selected=\"selected\"" : "";
                                                    echo "<option value=\"".$i."\"".$selected.">".$i."</option>\n";
                                                }
                                            echo "</select>&nbsp;/&nbsp;\n";
                                            
                                            echo "<select name=\"".$inputname."_month\"".$str_active." class=\"form-control\">\n";
                                            echo "<option value=\"\">-</option>";
                                                for($i = 1; $i <= 12; $i++){
                                                    $selected = ($i == $month) ? " selected=\"selected\"" : "";
                                                    echo "<option value=\"".$i."\"".$selected.">".$i."</option>\n";
                                                }
                                            echo "</select>&nbsp;/&nbsp;\n";
                                            
                                            echo "<select name=\"".$inputname."_day\"".$str_active." class=\"form-control\">\n";
                                            echo "<option value=\"\">-</option>";
                                                for($i = 1; $i <= 31; $i++){
                                                    $selected = ($i == $day) ? " selected=\"selected\"" : "";
                                                    echo "<option value=\"".$i."\"".$selected.">".$i."</option>\n";
                                                }
                                            echo "</select>\n";
                                            
                                            if($type == "datetime"){
                                                echo "&nbsp;at&nbsp;\n<select name=\"".$inputname."_hour\"".$str_active." id=\"".$inputname."_hour\" class=\"form-control\">\n";
                                                echo "<option value=\"\">-</option>";
                                                    for($i = 0; $i <= 23; $i++){
                                                        $selected = ($i == $hour) ? " selected=\"selected\"" : "";
                                                        echo "<option value=\"".$i."\"".$selected.">".$i."</option>\n";
                                                    }
                                                echo "</select>&nbsp;:&nbsp;\n";
                                                
                                                echo "<select name=\"".$inputname."_minute\"".$str_active." id=\"".$inputname."_minute\" class=\"form-control\">\n";
                                                echo "<option value=\"\">-</option>";
                                                    for($i = 0; $i <= 59; $i++){
                                                        $selected = ($i == $minute) ? " selected=\"selected\"" : "";
                                                        echo "<option value=\"".$i."\"".$selected.">".$i."</option>\n";
                                                    }
                                                echo "</select>\n";
                                            }
                                        break;
                                    }
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
