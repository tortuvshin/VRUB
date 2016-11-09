<?php debug_backtrace() || die ("Шууд хандах боломжгүй"); ?>
<div id="searchWrapper" class="pull-left">
    <?php $csrf_token = get_token("search"); ?>

    <form method="post" action="<?php echo DOCBASE.$sys_pages['search']['alias']; ?>" role="form" class="form-inline">
        <input type="text" class="form-control" name="global-search" placeholder="<?php echo $texts['SEARCH']; ?>">
        <input type="hidden" name="csrf_token" value="<?php echo $csrf_token; ?>">
        <button type="submit" class="btn btn-primary" name="send"><i class="fa fa-search"></i></button>
    </form>
</div>
<?php
if(LANG_ENABLED){
    if(count($langs) > 0){ ?>
        <div class="dropup">
            <button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown">
                <img src="<?php echo $langs[LANG_TAG]['file']; ?>" alt="<?php echo $langs[LANG_TAG]['title']; ?>"> <?php echo $langs[LANG_TAG]['title']; ?> <span class="caret"></span>
            </button>
            <ul class="dropdown-menu" role="menu" aria-labelledby="lang-btn" id="lang-menu">
                <?php
                foreach($langs as $row){
                    $title_lang = $row['title']; ?>
                    <li><a href="<?php echo DOCBASE.$row['tag']; ?>"><img src="<?php echo $row['file']; ?>" alt="<?php echo $title_lang; ?>"> <?php echo $title_lang; ?></a></li>
                    <?php
                } ?>
            </ul>
        </div>
        <?php
    }
}
if(CURRENCY_ENABLED){
    if(count($currencies) > 0){ ?>
        <div class="dropup">
            <button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown">
                <?php echo CURRENCY_CODE." ".CURRENCY_SIGN; ?> <span class="caret"></span>
            </button>
            <ul class="dropdown-menu" role="menu" aria-labelledby="lang-btn" id="lang-menu">
                <?php
                foreach($currencies as $row){ ?>
                    <li><a href="<?php echo getUrl(); ?>" data-action="<?php echo getFromTemplate("common/change_currency.php?curr=".$row['id']); ?>" class="ajax-link"><?php echo $row['code']." ".$row['sign']; ?></a></li>
                    <?php
                } ?>
            </ul>
        </div>
        <?php
    }
} ?>
