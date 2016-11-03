<?php
debug_backtrace() || die ("Direct access not permitted");

if($page['text2'] != ""){ ?>
    <div class="hotBox">
        <?php echo $page['text2']; ?>
    </div>
    <?php
} ?>
