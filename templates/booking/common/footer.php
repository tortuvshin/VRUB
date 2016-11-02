<footer>
    <section id="mainFooter">
        <div class="container" id="footer">
            <div class="row">
                <?php displayWidgets("footer", $page_id); ?>
            </div>
        </div>
    </section>
    <div id="footerRights">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <p>
                        &copy; <?php echo date("Y"); ?>
                        <?php echo OWNER." ".$texts['ALL_RIGHTS_RESERVED']; ?> - S H A R E D    O N    C`O`D`E`L`I`S`T`.`C`C`
                    </p>
                </div>
                <div class="col-md-6">
                    <p class="text-right">
                        <a href="<?php echo DOCBASE; ?>feed/" target="_blank" class="tips" title="<?php echo $texts['RSS_FEED']; ?>"><i class="fa fa-rss"></i></a>
                        <?php
                        foreach($pages as $page_id_nav => $page_nav){
                            $id_parent = $page_nav['id_parent'];
                            if($page_nav['footer'] == 1){ ?>
                                <a href="<?php echo DOCBASE.$page_nav['alias']; ?>" title="<?php echo $page_nav['title']; ?>"><?php echo $page_nav['name']; ?></a>
                                &nbsp;&nbsp;
                                <?php
                            }
                        } ?>
                    </p>
                </div>
            </div>
        </div>
    </div>
</footer>
<a href="#" id="toTop"><i class="fa-angle-up"></i></a>
</body>
</html>
<?php
$_SESSION['msg_error'] = "";
$_SESSION['msg_success'] = "";
$_SESSION['msg_notice'] = ""; ?>
