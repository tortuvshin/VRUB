<?php require(getFromTemplate("common/header.php", false)); ?>

<section id="page">
    
    <?php include(getFromTemplate("common/page_header.php", false)); ?>
    
    <div id="content" class="pt30 pb30">
        <div class="container">
            
            <?php
            echo $page['text'];
            
            $result_article = $db->prepare("SELECT * FROM pm_article WHERE id_page = :id_page AND checked = 1 AND lang = ".LANG_ID." ORDER BY rank");
            
            function articlesPage($id_page){
                global $db;
                global $result_article;
                global $pages;
                $result_article->bindValue(":id_page", $id_page);
                if($result_article->execute() !== false){
                    if($db->last_row_count() > 0){ ?>
                        <ul>
                            <?php
                            foreach($result_article as $row){ ?>
                                <li>
                                    <a href="<?php echo DOCBASE.$pages[$id_page]['alias']."/".text_format($row['alias']); ?>"><?php echo $row['title']; ?></a>
                                </li>
                                <?php
                            } ?>
                        </ul>
                        <?php
                    }
                }
            }
            
            function subPages($subpages){
                global $parents;
                global $pages; ?>
                <ul>
                    <?php
                    foreach($subpages as $id_subpage){
                        $subpage = $pages[$id_subpage];
                        
                        $title_subpage = $subpage['title'];
                        $name_subpage = $subpage['name'];
                        $alias_subpage = $subpage['alias'];
                        
                        if($subpage['system'] != 1){ ?>

                            <li>
                                <?php
                                $nb_subpages = (isset($parents[$id_subpage])) ? count($parents[$id_subpage]) : 0; ?>
                                <a href="<?php echo DOCBASE.$subpage['alias']; ?>" title="<?php echo $subpage['title']; ?>"><?php echo $subpage['name']; ?></a>
                                <?php
                                articlesPage($id_subpage);
                                if($nb_subpages > 0) subPages($parents[$id_subpage]); ?>
                            </li>
                            <?php
                        }
                    } ?>
                </ul>
                <?php
            }
            foreach($pages as $page_id_nav => $page_nav){
                $id_parent = $page_nav['id_parent'];
                if(($id_parent == 0 || $id_parent == $homepage['id']) && ($page_nav['main'] == 1 || $page_nav['footer'] == 1)){
                    if($page_nav['home'] == 1){ ?>
                        <a href="<?php echo DOCBASE.LANG_ALIAS; ?>" title="<?php echo $page_nav['title']; ?>"><h3><?php echo $page_nav['name']; ?></h3></a>
                        <?php
                    }else{
                        $nb_subpages = (isset($parents[$page_id_nav])) ? count($parents[$page_id_nav]) : 0; ?>
                        <a href="<?php echo DOCBASE.$page_nav['alias']; ?>" title="<?php echo $page_nav['title']; ?>"><h3><?php echo $page_nav['name']; ?></h3></a>
                        <?php
                        articlesPage($page_id_nav);
                        if($nb_subpages > 0) subPages($parents[$page_id_nav]);
                    }
                }
            } ?>
        </div>
    </div>
</section>
