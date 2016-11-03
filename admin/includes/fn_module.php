<?php
debug_backtrace() || die ("Шууд хандах боломжгүй");
/**
 * Function needed by all modules
 * build modules from config.xml and defines the constants
 */

/***********************************************************************
 * getModules() returns a collection of module objects
 *
 * @param $dir directory of the modules
 * 
 * @return array
 *
 */
function getModules($dir, $modules = array())
{
    global $indexes;
    $realdir = SYSBASE.$dir;

    $rep = opendir($realdir) or die("Хавтсыг нээхэд алдаа гарлаа: ".$realdir);
    
    while($entry = @readdir($rep)){
        
        if(is_dir($realdir."/".$entry) && $entry != "." && $entry != ".." && substr($entry, 0, 1) != ".")
            $modules = getModules($dir."/".$entry, $modules);
        else{
            if(is_file($realdir."/".$entry) && $entry == "config.xml"){
                
                $name = "";
                $title = "";
                
                $dom = new DOMDocument();
                $dom->load($realdir."/config.xml") or die("XML файлыг ачааллах боломжгүй байна");
                $dom->schemaValidate(dirname(__FILE__)."/config.xsd") or die("The XML file does not respect the schema");
                    
                $module = $dom->getElementsByTagName("module")->item(0);
                
                $index = htmlentities($module->getAttribute("index"), ENT_QUOTES, "UTF-8");
                $title = htmlentities($module->getAttribute("title"), ENT_QUOTES, "UTF-8");
                $name = htmlentities($module->getAttribute("name"), ENT_QUOTES, "UTF-8");
                $multi = htmlentities($module->getAttribute("multi"), ENT_QUOTES, "UTF-8");
                $library = htmlentities($module->getAttribute("library"), ENT_QUOTES, "UTF-8");
                $dashboard = htmlentities($module->getAttribute("dashboard"), ENT_QUOTES, "UTF-8");
                $ranking = htmlentities($module->getAttribute("ranking"), ENT_QUOTES, "UTF-8");
                $home = htmlentities($module->getAttribute("home"), ENT_QUOTES, "UTF-8");
                $main = htmlentities($module->getAttribute("main"), ENT_QUOTES, "UTF-8");
                $validation = htmlentities($module->getAttribute("validation"), ENT_QUOTES, "UTF-8");
                $dates = htmlentities($module->getAttribute("dates"), ENT_QUOTES, "UTF-8");
                $release = htmlentities($module->getAttribute("release"), ENT_QUOTES, "UTF-8");
                $icon = htmlentities($module->getAttribute("icon"), ENT_QUOTES, "UTF-8");
                
                $medias = $module->getElementsByTagName("medias")->item(0);
                $max_medias = htmlentities($medias->getAttribute("max"), ENT_QUOTES, "UTF-8");
                $medias_multi = htmlentities($medias->getAttribute("multi"), ENT_QUOTES, "UTF-8");
                $resizing = htmlentities($medias->getAttribute("resizing"), ENT_QUOTES, "UTF-8");
                
                $big = $medias->getElementsByTagName("big")->item(0);
                $max_w_big = htmlentities($big->getAttribute("maxw"), ENT_QUOTES, "UTF-8");
                $max_h_big = htmlentities($big->getAttribute("maxh"), ENT_QUOTES, "UTF-8");
                
                $medium = $medias->getElementsByTagName("medium")->item(0);
                $max_w_medium = htmlentities($medium->getAttribute("maxw"), ENT_QUOTES, "UTF-8");
                $max_h_medium = htmlentities($medium->getAttribute("maxh"), ENT_QUOTES, "UTF-8");
                
                $small = $medias->getElementsByTagName("small")->item(0);
                $max_w_small = htmlentities($small->getAttribute("maxw"), ENT_QUOTES, "UTF-8");
                $max_h_small = htmlentities($small->getAttribute("maxh"), ENT_QUOTES, "UTF-8");
                
                $roles = $module->getElementsByTagName("roles")->item(0);
                $users = $module->getElementsByTagName("user");
                $permissions = array();
                foreach($users as $user){
                    $type = htmlentities($user->getAttribute("type"), ENT_QUOTES, "UTF-8");
                    $permissions[$type] = explode(",", str_replace(" ", "", htmlentities($user->getAttribute("permissions"), ENT_QUOTES, "UTF-8")));
                }
                
                $modules[$index] = new Module($name, $title, DOCBASE.$dir, $multi, $ranking, $home, $main, $validation, $dates, $release, $library, $dashboard, $max_medias, $medias_multi, $resizing, $max_w_big, $max_h_big, $max_w_medium, $max_h_medium, $max_w_small, $max_h_small, $icon, $permissions);
                $indexes[$name] = $index;
            }
        }
    }
    closedir($rep);
    ksort($modules);
    return $modules;
}
$indexes = array();
$modules = getModules(ADMIN_FOLDER."/modules");
$dirname = dirname($_SERVER['SCRIPT_NAME']);
$dirname = substr($dirname, strrpos($dirname, "/")+1);

if(isset($indexes[$dirname])){
    
    $module = $modules[$indexes[$dirname]];
    
    define("MODULE", $module->getName());
    define("MULTILINGUAL", $module->isMultilingual());
    define("TITLE_ELEMENT", $module->getTitle());
    define("RANKING", $module->isRanking());
    define("HOME", $module->isHome());
    define("MAIN", $module->isMain());
    define("VALIDATION", $module->isValidation());
    define("DATES", $module->isDates());
    define("RELEASE", $module->isRelease());
    define("NB_FILES", $module->getMaxMedias());
    define("FILE_MULTI", $module->isMediasMulti());
    define("RESIZING", $module->getResizing());
    define("MAX_W_BIG", $module->getMaxWBig());
    define("MAX_H_BIG", $module->getMaxHBig());
    define("MAX_W_MEDIUM", $module->getMaxWMedium());
    define("MAX_H_MEDIUM", $module->getMaxHMedium());
    define("MAX_W_SMALL", $module->getMaxWSmall());
    define("MAX_H_SMALL", $module->getMaxHSmall());
    define("ICON", $module->getIcon());
    define("DIR", $module->getDir()."/");
    
    $permissions = $module->getPermissions($_SESSION['user']['type']);
}
