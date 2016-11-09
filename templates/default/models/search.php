<?php
$msg_error = "";
$msg_success = "";
$field_notice = array();
$referer = (checkReferer()) ? $_SERVER['HTTP_REFERER'] : "";
$search_limit = 10;
$max_search = 100;
$results = array();
$search_offset = (isset($_GET['search_offset']) && is_numeric($_GET['search_offset'])) ? $_GET['search_offset'] : 0;
if(!isset($_SESSION['search_count'])) $_SESSION['search_count'] = 0;
if(!isset($_SESSION['search_time'])) $_SESSION['search_time'] = time();
if(!isset($_SESSION['search_results'])) $_SESSION['search_results'] = array();
if(!isset($_SESSION['q_search'])) $_SESSION['q_search'] = "";

$start_time = microtime(true);

if(isset($_POST['global-search']) && check_token($referer, "search", "post")){
    
    $_SESSION['search_count']++;
    if($_SESSION['search_count'] <= ((((time()-$_SESSION['search_time'])/60)+1)*$search_limit)){
        $_SESSION['q_search'] = $_POST['global-search'];

        $s_query_page = db_getSearchRequest($db, "pm_page", array("name", "title_tag", "title", "subtitle", "intro", "text", "text2"), $_SESSION['q_search'], $max_search, 0, "checked = 1 AND lang = ".LANG_ID);
        if($s_query_page !== false){
            $s_result_page = $db->query($s_query_page);
            if($s_result_page !== false){
                $results_tmp = $s_result_page->fetchAll();
                if(!empty($results_tmp))
                    foreach($results_tmp as $i => $result) $results[$i.'_page'] = $result;
            }
        }
        $s_query_article = db_getSearchRequest($db, "pm_article", array("title", "subtitle", "text"), $_SESSION['q_search'], $max_search, 0, "checked = 1 AND lang = ".LANG_ID);
        if($s_query_article !== false){
            $s_result_article = $db->query($s_query_article);
            if($s_result_article !== false){
                $results_tmp = $s_result_article->fetchAll();
                if(!empty($results_tmp))
                    foreach($results_tmp as $i => $result) $results[$i.'_article'] = $result;
            }
        }
        if(!empty($results)){
            asort($results);
            $_SESSION['search_results'] = $results;
        }else{
            unset($_SESSION['search_results']);
            $msg_error .= $texts['NO_SEARCH_RESULT']."<br>";
        }
    }else{
        unset($_SESSION['search_results']);
        $msg_error .= $texts['SEARCH_EXCEEDED']."<br>";
    }
}
require(getFromTemplate("common/header.php", false)); ?>

<section id="page">
    
    <?php include(getFromTemplate("common/page_header.php", false)); ?>
    
    <div id="content" class="pt30 pb30">
        
        <div class="container" itemprop="text">
            
            <?php
            if($page['text'] != ""){ ?>
                <div class="clearfix mb20"><?php echo $page['text']; ?></div>
                <?php
            } ?>

            <div class="alert alert-success" style="display:none;"></div>
            <div class="alert alert-danger" style="display:none;"></div>
            
            <?php
            if(isset($_SESSION['search_results']) && !empty($_SESSION['search_results'])){
                $length = count($_SESSION['search_results']);
                
                $results = array();
                $max = (($search_offset + $search_limit) >= $length) ? $length : $search_offset + $search_limit;
                    
                $i = $search_offset;
                foreach($_SESSION['search_results'] as $key => $row){

                    if($i > $max) break;

                    if(strpos($key, "page") !== false){
                    
                        $s_page_id = $row['id'];
                        $s_page_name = $row['name'];
                        $s_page_title_tag = $row['title_tag'];
                        $s_page_title = $row['title'];
                        $s_page_subtitle = $row['subtitle'];
                        $s_page_intro = $row['intro'];
                        $s_page_text = $row['text'];
                        $s_page_text2 = $row['text2'];
                        $s_page_home = $row['home'];
                        
                        $s_page_alias = DOCBASE.$pages[$s_page_id]['alias'];

                        $title_origin = $s_page_name;
                        if($s_page_title_tag != $s_page_name) $title_origin .= " | ".$s_page_title_tag;
                        $title = wrapSentence($title_origin, $_SESSION['q_search']);
                        $result_title = ($title !== false && $title !== "") ? $title : strtrunc($title_origin, 80, false);
                        
                        $descr_origin = $s_page_title;
                        if($s_page_subtitle != "") $descr_origin .= "... ".$s_page_subtitle;
                        if($s_page_intro != "") $descr_origin .= "... ".$s_page_intro;
                        if($s_page_text != "") $descr_origin .= "... ".$s_page_text;
                        if($s_page_text2 != "") $descr_origin .= "... ".$s_page_text2;
                        $descr = wrapSentence($descr_origin, $_SESSION['q_search']);
                        $result_descr = ($descr !== false && $descr !== "") ? $descr : strtrunc($descr_origin, 160, false);

                        $res = "
                        <p>
                            <a href=\"".$s_page_alias."\" title=\"".$s_page_title."\">".$result_title."</a><br>";
                            if($result_descr != "") $res .= $result_descr."<br>";
                            $res .= "<small>http://www.".$_SERVER['HTTP_HOST'].$s_page_alias."</small>
                        </p>";
                        
                        $results[] = $res;
                    }
                    if(strpos($key, "article") !== false){
                    
                        $s_article_id = $row['id'];
                        $s_article_title = $row['title'];
                        $s_article_alias = $row['alias'];
                        $s_article_subtitle = $row['subtitle'];
                        $s_article_text = $row['text'];
                        $s_article_page = $row['id_page'];
                        
                        $s_article_alias = DOCBASE.$pages[$s_article_page]['alias']."/".text_format($s_article_alias);

                        $title_origin = $s_article_title;
                        $title = wrapSentence($title_origin, $_SESSION['q_search']);
                        $result_title = ($title !== false && $title !== "") ? $title : strtrunc($title_origin, 80, false);
                        
                        $descr_origin = $s_article_subtitle;
                        if($s_article_text != "") $descr_origin .= "... ".$s_article_text;
                        $descr = wrapSentence($descr_origin, $_SESSION['q_search']);
                        $result_descr = ($descr !== false && $descr !== "") ? $descr : strtrunc($descr_origin, 160, false);
                        
                        $res = "
                        <p>
                            <a href=\"".$s_article_alias."\" title=\"".$s_article_title."\">".$result_title."</a><br>";
                            if($result_descr != "") $res .= $result_descr."<br>";
                            $res .= "<small>http://www.".$_SERVER['HTTP_HOST'].$s_article_alias."</small>
                        </p>";
                        
                        $results[] = $res;
                    }
                    $i++;
                }
                $time_left = round(microtime(true)-$start_time, 2); ?>
                
                <h2>Үр дүн <?php echo ($search_offset+1)." - ".$max." ".$texts['FOR_A_TOTAL_OF']." ".$length; ?> (<?php echo $time_left." ".$texts['SECONDS']; ?>)</h2>
                <?php echo implode($results); ?>
                <?php
                if($search_limit > 0){
                    $count = ceil($length/$search_limit);
                    if($count > 1){ ?>
                        <ul class="pagination">
                            <?php
                            for($i = 1; $i <= $count; $i++){
                                $offset2 = ($i-1)*$search_limit;
                                if($offset2 == $search_offset)
                                    echo "<li class=\"active\"><a href=\"#\">".$i."</a></li>";
                                else
                                    echo "<li><a href=\"?search_offset=".$offset2."\">".$i."</a></li>";
                            } ?>
                        </ul>
                        <?php
                    }
                }
            } ?>
        </div>
    </div>
</section>
