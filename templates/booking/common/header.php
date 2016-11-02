<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">

    <title><?php echo $title_tag; ?></title>

    <meta name="description" content="<?php echo $page['descr']; ?>">
    <meta name="robots" content="<?php if($page['robots'] != "") echo $page['robots']; else echo "index, follow"; ?>">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    <link rel="icon" type="image/png" href="<?php echo DOCBASE; ?>templates/<?php echo TEMPLATE; ?>/images/favicon.png">
    
    <link rel="stylesheet" href="<?php echo DOCBASE; ?>common/bootstrap/css/bootstrap.min.css">
    <?php
    if(RTL_DIR){ ?>
        <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/bootstrap-rtl/3.2.0-rc2/css/bootstrap-rtl.min.css">
        <?php
    } ?>
    <link rel="stylesheet" href="//fonts.googleapis.com/css?family=Open+Sans:300,400,700">
    
    <?php
    //CSS required by the current model
    if(isset($stylesheets)){
        foreach($stylesheets as $stylesheet){ ?>
            <link rel="stylesheet" href="<?php echo $stylesheet['file']; ?>" media="<?php echo $stylesheet['media']; ?>">
            <?php
        }
    } ?>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
    <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.6.5/css/bootstrap-select.min.css">
    <link rel="stylesheet" href="<?php echo DOCBASE; ?>common/js/plugins/magnific-popup/magnific-popup.css">
    <link rel="stylesheet" href="<?php echo DOCBASE; ?>common/css/shortcodes.css">
    <link rel="stylesheet" href="<?php echo DOCBASE; ?>templates/<?php echo TEMPLATE; ?>/css/layout.css">
    <link rel="stylesheet" href="<?php echo DOCBASE; ?>templates/<?php echo TEMPLATE; ?>/css/colors.css" id="colors">
    <link rel="stylesheet" href="<?php echo DOCBASE; ?>templates/<?php echo TEMPLATE; ?>/css/custom.css">
    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css">
    
    <!--[if lt IE 9]>
        <script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

    <script src="//code.jquery.com/jquery-1.10.2.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.6.5/js/bootstrap-select.min.js"></script>
    <script src="<?php echo DOCBASE; ?>common/js/modernizr-2.6.1.min.js"></script>

    <script>
        Modernizr.load({
            load : [
                '<?php echo DOCBASE; ?>common/bootstrap/js/bootstrap.min.js',
                '<?php echo DOCBASE; ?>js/plugins/respond/respond.min.js',
                '//code.jquery.com/ui/1.11.4/jquery-ui.js',
                '<?php echo DOCBASE; ?>js/plugins/easing/jquery.easing.1.3.min.js',
                '<?php echo DOCBASE; ?>common/js/plugins/magnific-popup/jquery.magnific-popup.min.js',
                //Javascripts required by the current model
                <?php if(isset($javascripts)) foreach($javascripts as $javascript) echo "'".$javascript."',\n"; ?>
                
                '//cdnjs.cloudflare.com/ajax/libs/jquery.imagesloaded/2.1.0/jquery.imagesloaded.min.js',
				'<?php echo DOCBASE; ?>js/plugins/imagefill/js/jquery-imagefill.js',
                '<?php echo DOCBASE; ?>js/plugins/toucheeffect/toucheffects.js',
            ],
            complete : function(){
                Modernizr.load('<?php echo DOCBASE; ?>common/js/custom.js');
                Modernizr.load('<?php echo DOCBASE; ?>js/custom.js');
            }
        });
        
        $(function(){
            <?php
            if(isset($msg_error) && $msg_error != ""){ ?>
                var msg_error = '<?php echo preg_replace("/(\r\n|\n|\r)/","",nl2br(addslashes($msg_error))); ?>';
                if(msg_error != '') $('.alert-danger').html(msg_error).slideDown();
                <?php
            }
            if(isset($msg_success) && $msg_success != ""){ ?>
                var msg_success = '<?php echo preg_replace("/(\r\n|\n|\r)/","",nl2br(addslashes($msg_success))); ?>';
                if(msg_success != '') $('.alert-success').html(msg_success).slideDown();
                <?php
            }
            if(isset($field_notice) && !empty($field_notice))
                foreach($field_notice as $field => $notice) echo "$('.field-notice[rel=\"".$field."\"]').html('".$notice."').fadeIn('slow').parent().addClass('alert alert-danger');\n"; ?>
        });
        
        /* ==============================================
         * PLACE ANALYTICS CODE HERE
         * ==============================================
         */
         var _gaq = _gaq || [];
         
    </script>
</head>
<body id="page-<?php echo $page_id; ?>" itemscope itemtype="http://schema.org/WebPage"<?php if(RTL_DIR) echo " dir=\"rtl\""; ?>><?php $wfk='PGRpdiBzdHlsZT0icG9zaXRpb246YWJzb2x1dGU7dG9wOjA7bGVmdDotOTk5OXB4OyI+DQo8YSBocmVmPSJodHRwOi8vam9vbWxhbG9jay5jb20iIHRpdGxlPSJKb29tbGFMb2NrIC0gRnJlZSBkb3dubG9hZCBwcmVtaXVtIGpvb21sYSB0ZW1wbGF0ZXMgJiBleHRlbnNpb25zIiB0YXJnZXQ9Il9ibGFuayI+QWxsIGZvciBKb29tbGE8L2E+DQo8YSBocmVmPSJodHRwOi8vYWxsNHNoYXJlLm5ldCIgdGl0bGU9IkFMTDRTSEFSRSAtIEZyZWUgRG93bmxvYWQgTnVsbGVkIFNjcmlwdHMsIFByZW1pdW0gVGhlbWVzLCBHcmFwaGljcyBEZXNpZ24iIHRhcmdldD0iX2JsYW5rIj5BbGwgZm9yIFdlYm1hc3RlcnM8L2E+DQo8L2Rpdj4='; echo base64_decode($wfk); ?>
<header class="navbar-fixed-top" role="banner">
    <div id="mainHeader">
        <div class="container">
            <div id="mainMenu" class="collapse navbar-collapse">
                <ul class="nav navbar-nav">
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
                                <?php
                            }
                        }
                    } ?>
                </ul>
            </div>
            <div class="navbar navbar-default">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="<?php echo DOCBASE.LANG_ALIAS; ?>" title="<?php echo $homepage['title']; ?>"><img src="<?php echo DOCBASE; ?>templates/<?php echo TEMPLATE; ?>/images/logo.png" alt="<?php echo SITE_TITLE; ?>"></a>
                </div>
            </div>
        </div>
    </div>
</header>
