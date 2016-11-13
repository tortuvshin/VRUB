
<?php
function subMenu($subpages)
{
    global $parents;
    global $pages; ?>
    <ul class="subMenu">
        <?php
        foreach($subpages as $id_subpage){
            $subpage = $pages[$id_subpage]; ?>
            <li>
                <?php
                $nb_subpages = (isset($parents[$id_subpage])) ? count($parents[$id_subpage]) : 0; ?>
                <a class="<?php if($nb_subpages > 0) echo " hasSubMenu"; ?>" href="<?php echo DOCBASE.$subpage['alias']; ?>" title="<?php echo $subpage['title']; ?>"><?php echo $subpage['name']; ?></a>
                <?php if($nb_subpages > 0) subMenu($parents[$id_subpage]); ?>
            </li>
            <?php
        } ?>
    </ul>
    <?php
}
$nb_pages = count($pages);
foreach($pages as $page_id_nav => $page_nav){
    if($page_nav['checked'] == 1){
        $id_parent = $page_nav['id_parent'];
        if($page_nav['main'] == 1 && ($id_parent == 0 || $id_parent == $homepage['id'])){ ?>
        
            <li class="primary nav-<?php echo $page_nav['id']; ?>">
                <?php
                if($page_nav['home'] == 1){ ?>
                    <a class="firstLevel<?php if($ishome) echo " active"; ?>" href="<?php echo DOCBASE.LANG_ALIAS; ?>" title="<?php echo $page_nav['title']; ?>"><?php echo $page_nav['name']; ?></a>
                    <?php
                }else{
                    $nb_subpages = (isset($parents[$page_id_nav])) ? count($parents[$page_id_nav]) : 0; ?>
                    <a class="dropdown-toggle disabled firstLevel<?php if($nb_subpages > 0 && $page_nav['system'] != 1) echo " hasSubMenu"; if($page_nav['id'] == $page_id) echo " active"; ?>" href="<?php echo DOCBASE.$page_nav['alias']; ?>" title="<?php echo $page_nav['title']; ?>"><?php echo $page_nav['name']; ?></a>
                    <?php if($nb_subpages > 0 && $page_nav['system'] != 1) subMenu($parents[$page_id_nav]);
                } ?>
            </li>

            <li class="primary nav-2">
                
            </li>
            <?php
        }
    }
} ?> 