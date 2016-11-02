<?php
/**
 * Script called (Ajax) to upload media files using Uplaodifive plugin
 */
session_start();
if(!isset($_SESSION['user'])) exit();

if(isset($_POST['uniqid']) && isset($_POST['timestamp']) && isset($_POST['dir']) && isset($_POST['root_bo']) && isset($_POST['lang']) && isset($_POST['exts'])){

    $verifyToken = md5("sessid_".$_POST['uniqid'].$_POST['timestamp']);
                
    if(!empty($_FILES) && $_POST['token'] == $verifyToken){
        
        $dir = $_POST['dir'];
        $path = "../../../../medias/".$dir."/tmp";
        $root_bo = $_POST['root_bo'];
        $lang = $_POST['lang'];
        
        $uniqid = uniqid();
        
        // upload folder for a session
        if(!is_dir($path."/".$verifyToken)) mkdir($path."/".$verifyToken, 0777);
        chmod($path."/".$verifyToken, 0777);
        if(!is_dir($path."/".$verifyToken."/".$lang)) mkdir($path."/".$verifyToken."/".$lang, 0777);
        chmod($path."/".$verifyToken."/".$lang, 0777);
        if(!is_dir($path."/".$verifyToken."/".$lang."/".$uniqid)) mkdir($path."/".$verifyToken."/".$lang."/".$uniqid, 0777);
        chmod($path."/".$verifyToken."/".$lang."/".$uniqid, 0777);

        $tempFile = $_FILES['Filedata']['tmp_name'];
        
        $ext = mb_strtolower(strrchr($_FILES['Filedata']['name'], "."), "UTF-8");
        $filename = str_replace($ext, "", mb_strtolower($_FILES['Filedata']['name'], "UTF-8"));
        
        $patern_from = "ÀÁÂÃÄÅàáâãäåÒÓÔÕÖØòóôõöøÈÉÊËèéêëÇçÌÍÎÏìíîïÙÚÛÜùúûüýÿÑñ";
        $patern_to = "aaaaaaaaaaaaooooooooooooeeeeeeeecciiiiiiiiuuuuuuuuyynn";
        
        $filename = utf8_decode($filename);
        $patern_from = utf8_decode($patern_from);
        $patern_to = utf8_decode($patern_to);
        
        $filename = strtr($filename, $patern_from, $patern_to);
        $filename = preg_replace("/([^a-z0-9]+)/i", "-", $filename);
        $filename = preg_replace("/-[-]+/", "-", $filename);
        $filename = trim($filename, "-");
        $filename = strtolower($filename);
        $filename = utf8_encode($filename).$ext;
            
        $targetFile = $path."/".$verifyToken."/".$lang."/".$uniqid."/".$filename;
        
        // file type checking
        $fileTypes = unserialize(stripslashes($_POST['exts'])); // files extensions
        $fileParts = pathinfo($_FILES['Filedata']['name']);
        
        if(in_array(mb_strtolower($fileParts['extension'], "UTF-8"), $fileTypes)){
                        
            move_uploaded_file($tempFile, $targetFile);
            
            $dim = @getimagesize($targetFile);
            if(is_array($dim)){
                $w = $dim[0];
                $h = $dim[1];
            }else{
                $w = 0;
                $h = 0;
            }
            
            $bytes = floatval(filesize($targetFile));
            
            $arBytes = array(
                0 => array(
                    "UNIT" => "To",
                    "VALUE" => pow(1024, 4)
                ),
                1 => array(
                    "UNIT" => "Go",
                    "VALUE" => pow(1024, 3)
                ),
                2 => array(
                    "UNIT" => "Mo",
                    "VALUE" => pow(1024, 2)
                ),
                3 => array(
                    "UNIT" => "Ko",
                    "VALUE" => 1024
                ),
                4 => array(
                    "UNIT" => "octets",
                    "VALUE" => 1
                ),
            );
            $result = "";
            foreach($arBytes as $arItem){
                if($bytes >= $arItem['VALUE']){
                    $result = $bytes / $arItem['VALUE'];
                    $result = str_replace(".", "," , strval(round($result, 2)))." ".$arItem['UNIT'];
                    break;
                }
            }
            
            echo $root_bo."../".str_replace("../", "", $targetFile)."|".$result."|".$w."|".$h;    
        }
    }
}
