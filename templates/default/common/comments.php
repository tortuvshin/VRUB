<?php
debug_backtrace() || die ("Шууд хандах боломжгүй");

if($allow_comment == 1 && $result_comment !== false && $item_id > 0 && isset($item_type)){ ?>
    
    <!-- Comments -->
    <h3 class="mb10"><?php echo $texts['LET_US_KNOW']; ?></h3>
    
    <div class="row">
        <form method="post" action="<?php echo DOCBASE.$page_alias; ?>" role="form">
        
            <input type="hidden" name="item_type" value="<?php echo $item_type; ?>">
            <input type="hidden" name="item_id" value="<?php echo $item_id; ?>">
            <div class="col-sm-6">
                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon"><i class="fa fa-quote-left"></i></div>
                        <textarea class="form-control" name="msg" placeholder="<?php echo $texts['COMMENT']; ?> *" rows="9"><?php echo htmlentities($msg, ENT_QUOTES, "UTF-8"); ?></textarea>
                    </div>
                    <div class="field-notice" rel="msg"></div>
                </div>
            </div>
            <div class="col-sm-6">
                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon"><i class="fa fa-user"></i></div>
                        <input type="text" class="form-control" name="name" value="<?php echo htmlentities($name, ENT_QUOTES, "UTF-8"); ?>" placeholder="<?php echo $texts['LASTNAME']." ".$texts['FIRSTNAME']; ?> *">
                    </div>
                    <div class="field-notice" rel="name"></div>
                </div>
                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon"><i class="fa fa-envelope"></i></div>
                        <input type="text" class="form-control" name="email" value="<?php echo htmlentities($email, ENT_QUOTES, "UTF-8"); ?>" placeholder="<?php echo $texts['EMAIL']; ?> *">
                    </div>
                    <div class="field-notice" rel="email"></div>
                </div>
                <div class="form-group form-inline mb0">
                    <div class="input-group mb5">
                        <div class="input-group-addon"><i class="fa fa-lock"></i></div>
                        <input type="text" class="form-control" name="captcha" id="captcha" value="" placeholder="<?php echo $texts['COPY_CODE']; ?> *">
                    </div>
                    <div class="input-group mb5">
                        <img id="captcha_image" alt="" src="<?php echo DOCBASE; ?>includes/securimage/securimage_show.php?sid=<?php echo md5(uniqid(time())); ?>" style="vertical-align:middle;">
                        <a href="#" onclick="document.getElementById('captcha_image').src = '<?php echo DOCBASE; ?>includes/securimage/securimage_show.php?sid=' + Math.random(); return false">
                            <i class="fa fa-refresh"></i>
                        </a>
                    </div>
                    <div class="field-notice" rel="captcha"></div>
                </div>
                <?php
                if($allow_rating == 1){ ?>
                    <div class="form-group form-inline">
                        <label for="rating">Үнэлгээ</label>
                        <div class="input-group mb5">
                            <input type="hidden" name="rating" class="rating" value="<?php echo $rating; ?>" data-rtl="<?php echo (RTL_DIR) ? true : false; ?>" min="1" max="5" data-step="1" data-size="xs">
                        </div>
                    </div>
                    <?php
                } ?>
                <div class="form-group row">
                    <span class="col-sm-12"><button type="submit" class="btn btn-primary" name="send_comment"><i class="fa fa-send"></i> <?php echo $texts['SEND']; ?></button> <i> * <?php echo $texts['REQUIRED_FIELD']; ?></i></span>
                </div>
            </div>
        </form>
    </div>
    <section class="clearfix">
        <h3 class="commentNumbers">
            <?php
            echo $texts['COMMENTS']." ";
            if(RTL_DIR) echo "&rlm;";
            echo "(".$nb_comments.")"; ?>
        </h3>
        <?php
        foreach($result_comment as $i => $row){ ?>
            <div class="media row">
                <div class="col-sm-1 col-xs-2">
                    <img src="http://www.gravatar.com/avatar/00000000000000000000000000000000?d=mm&amp;s=50" alt="" class="img-responsive">
                </div>
                <div class="media-body col-sm-8 col-xs-7">
                    <div class="clearfix">
                        <h4 class="media-heading"><?php echo $row['name']; ?></h4>
                        <div class="commentInfo"> <span><?php echo (!RTL_DIR) ? strftime(DATE_FORMAT, $row['add_date']) : strftime("%F", $row['add_date']); ?></span></div>
                        <?php echo nl2br($row['msg']); ?>
                    </div>
                </div>
                <div class="col-sm-3">
                    <?php
                    if($allow_rating == 1 && $row['rating'] > 0 && $row['rating'] <= 5){ ?>
                        <input type="hidden" class="rating" value="<?php echo $row['rating']; ?>" data-rtl="<?php echo (RTL_DIR) ? true : false; ?>" data-size="xs" readonly="true">
                        <?php
                    } ?>
                </div>
            </div>
            <?php
        } ?>
    </section>
    <?php
} ?>
