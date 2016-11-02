<?php
/**
 * Empty the tmp/ folder in the media directory of a module
 */
session_start();
if(!isset($_SESSION['user'])) exit();

if(isset($_POST['dir']) && isset($_POST['token']) && $_POST['token'] != ""){
    
    $dirname = "../../".rtrim($_POST['dir'], "/")."/".$_POST['token'];
    
    if(is_dir($dirname)){
    
        if(!is_writable($dirname))
            throw new Exception("You do not have renaming permissions!");

        $iterator = new RecursiveIteratorIterator(
            new RecursiveDirectoryIterator($dirname),
            RecursiveIteratorIterator::CHILD_FIRST
        );
        while($iterator->valid()){
            if(!$iterator->isDot()){
                if($iterator->isLink() && false === (boolean) $followLinks) $iterator->next();
                if($iterator->isFile()) unlink($iterator->getPathname());
                else if ($iterator->isDir()) rmdir($iterator->getPathname());
            }
            $iterator->next();
        }
        rmdir($dirname);
        unset($iterator);
    }
}
