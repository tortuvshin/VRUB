<?php debug_backtrace() || die ("Шууд хандах боломжгүй"); ?>
<header class="page-header">
    <div class="container">
        <div class="row">
              <?php
                if($article_id == 0){
                    $page_title = $page['title'];
                    $page_subtitle = $page['subtitle'];
                    $page_name = $page['name']; ?>
                    
                    <?php
                }else{
                    $page_name = $page_title; ?>
                    
                    <?php
                }
                if($page_subtitle != "") echo "<p>".$page_subtitle."</p>"; ?>
           
            <div class="col-sm-<?php echo (RTL_DIR) ? 12 : 5; ?> hidden-xs">
                <div itemprop="breadcrumb" class="breadcrumb clearfix">
                    
                    <a href="<?php echo DOCBASE.LANG_ALIAS; ?>" title="<?php echo $homepage['title']; ?>"><?php echo $homepage['name']; ?></a>
                    
                    <?php
                    foreach($breadcrumbs as $id_parent){
                        if(isset($pages[$id_parent])){
                            $parent = $pages[$id_parent]; ?>
                            <a href="<?php echo DOCBASE.$parent['alias']; ?>" title="<?php echo $parent['title']; ?>"><?php echo $parent['name']; ?></a>
                            <?php
                        }
                    }
                    if($article_id > 0){ ?>
                        <a href="<?php echo DOCBASE.$page['alias']; ?>" title="<?php echo $page['title']; ?>"><?php echo $page['name']; ?></a>
                        <?php
                    } ?>
                    
                    <span><?php echo $page_name; ?></span>
                </div>
                <?php
                /*
                if($article_id > 0){ ?>
                    <a href="<?php echo DOCBASE.$page['alias']; ?>" class="btn btn-sm btn-primary pull-right" title="<?php echo $page['title']; ?>"><i class="fa fa-angle-double-left"></i><?php echo $texts['BACK']; ?></a>
                    <?php
                }*/ ?>
            </div>
        </div>
    </div>
</header>
