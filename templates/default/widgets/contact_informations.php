<?php debug_backtrace() || die ("Шууд хандах боломжгүй"); ?>
<div itemscope itemtype="http://schema.org/Corporation">
    <h3 itemprop="name"><?php echo OWNER; ?></h3>
    <address>
        <p>
            <?php if(ADDRESS != "") : ?><i class="fa fa-map-marker"></i> <span itemprop="address" itemscope itemtype="http://schema.org/PostalAddress"><?php echo nl2br(ADDRESS); ?></span><br><?php endif; ?>
            <?php if(PHONE != "") : ?><i class="fa fa-phone"></i> <span itemprop="telephone" dir="ltr"><?php echo PHONE; ?></span><br><?php endif; ?>
            <?php if(MOBILE != "") : ?><span class="fa fa-mobile"></span> <span itemprop="telephone" dir="ltr"><?php echo MOBILE; ?></span><br><?php endif; ?>
            <?php if(FAX != "") : ?><i class="fa fa-fax"></i> <span itemprop="faxNumber" dir="ltr"><?php echo FAX; ?></span><br><?php endif; ?>
            <?php if(EMAIL != "") : ?><i class="fa fa-envelope"></i> <a itemprop="email" dir="ltr" href="mailto:<?php echo EMAIL; ?>"><?php echo EMAIL; ?></a><?php endif; ?>
        </p>
    </address>
</div>
