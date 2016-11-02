<?php
header("Content-Type:application/xml;charset=UTF-8");

require("../common/lib.php");
require("../common/define.php");

$site_url = str_replace("/feed", "", getUrl());
$xml_permalink = $site_url."feed/";

$dom = new DomDocument("1.0", "UTF-8");

$rss = $dom->createElement("rss");
$version = $dom->createAttribute("version");
$xmlns = $dom->createAttribute("xmlns:atom");
$version->value = "2.0";
$xmlns->value = "http://www.w3.org/2005/Atom";
$rss->appendChild($version);
$rss->appendChild($xmlns);

$channel = $dom->createElement("channel");

$title = $dom->createElement("title", SITE_TITLE);
$link = $dom->createElement("link", $site_url);
$descr = $dom->createElement("description", "");

$atom = $dom->createElement("atom:link");
$href_atom = $dom->createAttribute("href");
$href_atom->value = $xml_permalink;
$rel_atom = $dom->createAttribute("rel");
$rel_atom->value = "self";
$type_atom = $dom->createAttribute("type");
$type_atom->value = "application/rss+xml";
$atom->appendChild($href_atom);
$atom->appendChild($rel_atom);
$atom->appendChild($type_atom);

$channel->appendChild($title);
$channel->appendChild($link);
$channel->appendChild($descr);
$channel->appendChild($atom);
//$channel->appendChild($image);

$article_id = 0;
$result_article_file = $db->prepare("SELECT * FROM pm_article_file WHERE id_item = :article_id AND checked = 1 AND lang = ".DEFAULT_LANG." AND type = 'image' AND file != '' ORDER BY rank LIMIT 1");
$result_article_file->bindParam(":article_id", $article_id);

$result_rss_article = $db->query("SELECT p.alias as page_alias, a.alias as article_alias, p.name as page_name, a.id as article_id, a.title as article_title, a.text as article_text, a.add_date as article_date, id_page FROM pm_page as p, pm_article as a WHERE a.lang = ".LANG_ID." AND p.lang = ".LANG_ID." AND a.checked = 1 AND p.checked = 1 AND a.id_page = p.id ORDER BY a.add_date DESC");
if($result_rss_article !== false){
    foreach($result_rss_article as $i => $row){
        $article_id = $row['article_id'];
        $article_title = $row['article_title'];
        $article_alias = $row['article_alias'];
        $title = htmlspecialchars(strip_tags($article_title." | ".$row['page_name']), ENT_COMPAT, "UTF-8");
        $descr = strtrunc(htmlspecialchars(strip_tags($row['article_text']), ENT_COMPAT, "UTF-8"), 900);
        $pubDate = $row['article_date'];
        $page_id = $row['id_page'];

        $link = $site_url.LANG_ALIAS.$row['page_alias']."/".text_format($article_alias);
        
        if($result_article_file->execute() !== false && $db->last_row_count() == 1){
            $row = $result_article_file->fetch(PDO::FETCH_ASSOC);
            
            $file_id = $row['id'];
            $filename = $row['file'];
            $label = $row['label'];
            
            $realpath = SYSBASE."medias/article/small/".$file_id."/".$filename;
            $thumbpath = $site_url."medias/article/small/".$file_id."/".$filename;
            
            if(is_file($realpath))
                $descr = "
                <![CDATA[
                    <img alt=\"".$label."\" src=\"".$thumbpath."\" height=\"80\" align=\"right\">
                    ".$descr."
                ]]>";
        }
        $descr_node = $dom->createTextNode($descr);
        
        $title = $dom->createElement("title", $title);
        $link = $dom->createElement("link", $link);
        $descr = $dom->createElement("description");
        
        $descr->appendChild($descr_node);
        
        $guid = $dom->createElement("guid", $article_id."-".time());
        $isPermaLink = $dom->createAttribute("isPermaLink");
        $isPermaLink->value = "false";
        $guid->appendChild($isPermaLink);
        $pubDate = $dom->createElement("pubDate", date("r", $pubDate));
        
        $new_item = $dom->createElement("item");
        
        $new_item->appendChild($title);
        $new_item->appendChild($link);
        $new_item->appendChild($descr);
        $new_item->appendChild($guid);
        $new_item->appendChild($pubDate);
        
        $channel->appendChild($new_item);
    }
}

$rss->appendChild($channel);

$dom->appendChild($rss);

echo html_entity_decode($dom->saveXML());
