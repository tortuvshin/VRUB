<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">

    <title><?php echo SITE_TITLE; ?></title>
    
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    <link rel="icon" type="image/png" href="<?php echo DOCBASE; ?>templates/<?php echo TEMPLATE; ?>/images/favicon.png">
    
    <link rel="stylesheet" href="<?php echo DOCBASE; ?>common/bootstrap/css/bootstrap.min.css">
    <?php
    if(RTL_DIR){ ?>
        <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/bootstrap-rtl/3.2.0-rc2/css/bootstrap-rtl.min.css">
        <?php
    } ?>
    <link rel="stylesheet" href="//fonts.googleapis.com/css?family=Open+Sans:300,400,700">
    
    <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
    <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.6.5/css/bootstrap-select.min.css">
    <link rel="stylesheet" href="<?php echo DOCBASE; ?>common/css/shortcodes.css">
    <link rel="stylesheet" href="<?php echo DOCBASE; ?>templates/<?php echo TEMPLATE; ?>/css/layout.css">
    <link rel="stylesheet" href="<?php echo DOCBASE; ?>templates/<?php echo TEMPLATE; ?>/css/colors.css" id="colors">
    <link rel="stylesheet" href="<?php echo DOCBASE; ?>templates/<?php echo TEMPLATE; ?>/css/custom.css">
    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css">
    
    <!--[if lt IE 9]>
        <script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

    <script src="//code.jquery.com/jquery-1.10.2.min.js"></script>
    <script src="<?php echo DOCBASE; ?>common/js/modernizr-2.6.1.min.js"></script>

    <script>
        Modernizr.load({
            load : [
                '<?php echo DOCBASE; ?>common/bootstrap/js/bootstrap.min.js',
                '<?php echo DOCBASE; ?>js/plugins/respond/respond.min.js',
                '//code.jquery.com/ui/1.11.4/jquery-ui.js',
                '<?php echo DOCBASE; ?>js/plugins/easing/jquery.easing.1.3.min.js',
                '//cdnjs.cloudflare.com/ajax/libs/jquery.imagesloaded/2.1.0/jquery.imagesloaded.min.js',
				'<?php echo DOCBASE; ?>js/plugins/imagefill/js/jquery-imagefill.js',
                '<?php echo DOCBASE; ?>js/plugins/toucheeffect/toucheffects.js',
            ],
            complete : function(){
                Modernizr.load('<?php echo DOCBASE; ?>common/js/custom.js');
                Modernizr.load('<?php echo DOCBASE; ?>js/custom.js');
            }
        });
    </script>
</head>
<body id="page-maintenance" itemscope itemtype="http://schema.org/WebPage"<?php if(RTL_DIR) echo " dir=\"rtl\""; ?>>
<div class="container">
    <div class="row">
        <div class="col-sm-6"></div>
        <div class="col-sm-6">
            <div class="maintenance-msg">
                <?php echo stripslashes(MAINTENANCE_MSG); ?>
            </div>
        </div>
    </div>
</div>
