<?php

$stylesheets[] = array("file" => DOCBASE."js/plugins/isotope/css/style.css", "media" => "all");
$javascripts[] = DOCBASE."js/plugins/isotope/jquery.isotope.min.js";
$javascripts[] = DOCBASE."js/plugins/isotope/jquery.isotope.sloppy-masonry.min.js";

$stylesheets[] = array("file" => DOCBASE."js/plugins/lazyloader/lazyloader.css", "media" => "all");
$javascripts[] = DOCBASE."js/plugins/lazyloader/lazyloader.js";

$stylesheets[] = array("file" => DOCBASE."js/plugins/star-rating/css/star-rating.min.css", "media" => "all");
$javascripts[] = DOCBASE."js/plugins/star-rating/js/star-rating.min.js";


require(getFromTemplate("common/header.php", false)); ?>

<style>
    .group{
    }

    .box {
        width: 25px;
        height: 25px;
        float: left;
        margin: 1px;
        border-radius: 50%;
        background-color: #38507e;
    }

    .left-top {
        width: 214px;
        height: 214px;
        margin: 1px;
        background-color: #38507e;
        left: 0;
        top: 0;
        float: left;
    }
    .left-bottom {
        width: 214px;
        height: 214px;
        margin: 1px;
        background-color: #38507e;
        left: 0;
        bottom: 0;
        float: left;
    }
    .right-top {
        width: 220px;
        height: 214px;
        margin: 1px;
        background-color: #38507e;
        right: 0;
        top: 0;
        float: right;
    }
    .right-bottom {
        width: 214px;
        height: 214px;
        margin: 1px;
        background-color: #38507e;
        right: 0;
        bottom: 0;
        float: right;
    }
</style>

<section id="page">
    
    <?php include(getFromTemplate("common/page_header.php", false)); ?>
    
    <div id="content" class="pt30 pb20">
        <div class="container" itemprop="text">
            <div class="left-top"></div>
            <div class="right-top"></div>
           <?php
                $count = 1;
                for($i=1; $i<= 1998; $i++){
                    if($count == 1){
                        echo "<div class='group'>";
                    }
                    $count++;
                        echo "<div class='box wood'></div>";
                    if($count == 49){
                        $count=1; 
                        echo "</div>";
                    }
                }
            ?>
            <div class="right-bottom"></div>
        </div>
    </div>
</section>
