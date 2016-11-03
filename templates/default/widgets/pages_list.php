<?php
debug_backtrace() || die ("Direct access not permitted");

/*
if(isset($parents[$page_id])){ ?>
    <ul class="mt0 mb20" id="pages-list">
        <?php
        foreach($parents[$page_id] as $id){ ?>
            <li><a href="<?php echo DOCBASE.$pages[$id]['alias']; ?>"><?php echo $pages[$id]['name']; ?></a></li>
            <?php
        } ?>
    </ul>
    <?php
}*/
if($page['id_parent'] != 0 && $page['id_parent'] != $homepage['id'] && isset($parents[$page['id_parent']])){ ?>
    <ul class="mt20 mb20 page-list page-list-aside">
        <?php
        foreach($parents[$page['id_parent']] as $id){
            if($id != $page_id){ ?>
                <li><a href="<?php echo DOCBASE.LANG_ALIAS.$pages[$id]['alias']; ?>"><?php echo $pages[$id]['name']; ?></a></li>
                <?php
            }else{ ?>
                <li><span><?php echo $pages[$id]['name']; ?></span>
                <?php
            }
        } ?>
    </ul>
    <?php
} ?>
