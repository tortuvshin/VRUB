<?php debug_backtrace() || die ("Шууд хандах боломжгүй"); ?>
<!DOCTYPE html>

<html>
<head>
    <meta charset="UTF-8">

    <title><?php echo $title_tag; ?></title>
    
    <?php
    if(isset($article)) $meta_descr = strtrunc(strip_tags($article['text']), 155);
    elseif($page['descr'] != "") $meta_descr = $page['descr'];
    else $meta_descr = strtrunc(strip_tags($page['text']), 155); ?>

    <meta name="description" content="<?php echo $meta_descr; ?>">
    
    <!-- Schema.org markup for Google+ -->
    <meta itemprop="name" content="<?php echo $title_tag; ?>">
    <meta itemprop="description" content="<?php echo $meta_descr; ?>">
    <?php
    if(isset($page_img)){ ?>
        <meta itemprop="image" content="<?php echo $page_img; ?>">
        <?php
    } ?>
    
    <!-- Open Graph data -->
    <meta property="og:title" content="<?php echo $title_tag; ?>">
    <meta property="og:type" content="article">
    <meta property="og:url" content="<?php echo getUrl(); ?>">
    <?php
    if(isset($page_img)){ ?>
        <meta property="og:image" content="<?php echo $page_img; ?>">
        <?php
    } ?>
    <meta property="og:description" content="<?php echo $meta_descr; ?>">
    <meta property="og:site_name" content="<?php echo SITE_TITLE; ?>">
    <?php
    if(isset($publish_date) && isset($edit_date)){ ?>
        <meta property="article:published_time" content="<?php echo date("c", $publish_date); ?>">
        <meta property="article:modified_time" content="<?php echo date("c", $edit_date); ?>">
        <?php
    } ?>
    <?php
    if($article_id > 0){ ?>
        <meta property="article:section" content="<?php echo $page['title']; ?>">
        <?php
    } ?>
    <?php
    if(isset($article_tags) && $article_tags != ""){ ?>
        <meta property="article:tag" content="<?php echo $article_tags; ?>">
        <?php
    } ?>
    <meta property="article:author" content="<?php echo OWNER; ?>">

    <!-- Twitter Card data -->
    <meta name="twitter:card" content="summary_large_image">
    <meta name="twitter:site" content="@publisher_handle">
    <meta name="twitter:title" content="<?php echo $title_tag; ?>">
    <meta name="twitter:description" content="<?php echo $meta_descr; ?>">
    <meta name="twitter:creator" content="@author_handle">
    <?php
    if(isset($page_img)){ ?>
        <meta name="twitter:image:src" content="<?php echo $page_img; ?>">
        <?php
    } ?>
    
    <meta name="robots" content="<?php if($page['robots'] != "") echo $page['robots']; else echo "index, follow"; ?>">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    <link rel="icon" type="image/png" href="<?php echo DOCBASE; ?>templates/<?php echo TEMPLATE; ?>/images/favicon.png">
    
    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
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
    <link rel="stylesheet" href="<?php echo getFromTemplate("css/layout.css"); ?>">
    <link rel="stylesheet" href="<?php echo getFromTemplate("css/colors.css"); ?>" id="colors">
    <link rel="stylesheet" href="<?php echo getFromTemplate("css/main.css"); ?>">
    <link rel="stylesheet" href="<?php echo getFromTemplate("css/custom.css"); ?>">
    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto">
    <link rel="stylesheet" href="<?php echo getFromTemplate("css/mod.css"); ?>">

    <!--[if lt IE 9]>
        <script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

    <script src="//code.jquery.com/jquery-1.10.2.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.6.5/js/bootstrap-select.min.js"></script>
    <script src="<?php echo DOCBASE; ?>common/js/modernizr-2.6.1.min.js"></script>

    <script>
        Modernizr.load({
            load : [
                '//maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js',
                '<?php echo DOCBASE; ?>js/plugins/respond/respond.min.js',
                '//code.jquery.com/ui/1.11.4/jquery-ui.js',
                '<?php echo DOCBASE; ?>js/plugins/jquery-cookie/jquery-cookie.js',
                '<?php echo DOCBASE; ?>js/plugins/strftime/strftime.min.js',
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
        
        <?php echo stripslashes(ANALYTICS_CODE); ?>
         
    </script>
</head>
<body id="page-<?php echo $page_id; ?>" itemscope itemtype="http://schema.org/WebPage"<?php if(RTL_DIR) echo " dir=\"rtl\""; ?>>
<?php
if(ENABLE_COOKIES_NOTICE == 1 && !isset($_COOKIE['cookies_enabled'])){ ?>
    <div id="cookies-notice">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12">
                    <?php echo $texts['COOKIES_NOTICE']; ?>
                    <button class="btn btn-success btn-xs">Тийм</button>
                </div>
            </div>
        </div>
    </div>
    <?php
} ?>
<div id="fb-root"></div>
<script>(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1&version=v2.8&appId=304265309959276";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));

window.twttr = (function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0],
    t = window.twttr || {};
  if (d.getElementById(id)) return t;
  js = d.createElement(s);
  js.id = id;
  js.src = "https://platform.twitter.com/widgets.js";
  fjs.parentNode.insertBefore(js, fjs);

  t._e = [];
  t.ready = function(f) {
    t._e.push(f);
  };

  return t;
}(document, "script", "twitter-wjs"));

</script>

<header class="navbar-fixed-top" role="banner">
    <div id="mainHeader">
        <div class="container-fluid">
            <div id="mainMenu" class="collapse navbar-collapse">
                <ul class="nav navbar-nav">
                    <li class="primary nav-1">
                        <a class="dropdown-toggle disabled firstLevel" href="<?php echo DOCBASE.LANG_ALIAS; ?>" title="Нүүр">Нүүр</a>
                    </li>

                    <li class="primary nav-2">
                        <a class="dropdown-toggle disabled firstLevel" href="<?php echo DOCBASE.LANG_ALIAS; ?>about-us" title="Бидний тухай">Бидний тухай</a>
                    </li>
                    <li class="primary nav-3">
                        <a class="dropdown-toggle disabled firstLevel" href="<?php echo DOCBASE.LANG_ALIAS; ?>a/hotel" title="Зочид буудал">Зочид буудал</a>
                    </li>
                    <li class="primary nav-4">
                        <a class="dropdown-toggle disabled firstLevel" href="<?php echo DOCBASE.LANG_ALIAS; ?>a/camp" title="Амралтын газар">Амралтын газар</a>
                    </li>
                    <li class="primary nav-5">
                        <a class="dropdown-toggle disabled firstLevel" href="<?php echo DOCBASE.LANG_ALIAS; ?>activities" title="Event">Event</a>
                    </li>
                    <li class="primary nav-6">
                        <a class="dropdown-toggle disabled firstLevel" href="<?php echo DOCBASE.LANG_ALIAS; ?>sale" title="Мод захиалах">Мод захиалах</a>
                    </li>
                    <li class="primary nav-7">
                        <a class="dropdown-toggle disabled firstLevel" href="<?php echo DOCBASE.LANG_ALIAS; ?>contact" title="Холбоо барих">Холбоо барих</a>
                    </li>

                    <li class="primary">
                        <?php
                        if(isset($_SESSION['user'])){ ?>
                            <form method="post" action="<?php echo DOCBASE.$page['alias']; ?>" class="ajax-form">
                                <div class="dropdown">
                                    <a class="firstLevel dropdown-toggle" data-toggle="dropdown" href="#">
                                        <i class="fa fa-user"></i>
                                        <span class="hidden-sm hidden-md">
                                            <?php
                                            if($_SESSION['user']['login'] != "") echo $_SESSION['user']['login'];
                                            else echo $_SESSION['user']['email']; ?>
                                        </span>
                                        <span class="fa fa-caret-down"></span>
                                    </a>
                                    <ul class="dropdown-menu dropdown-menu-right" role="menu" id="user-menu">
                                        <?php
                                        if($_SESSION['user']['type'] == "registered"){ ?>
                                            <li><a href="<?php echo DOCBASE.$sys_pages['account']['alias']; ?>"><i class="fa fa-user"></i> <?php echo $sys_pages['account']['name']; ?></a></li>
                                            <?php
                                        } ?>
                                        <li><a href="#" class="sendAjaxForm" data-action="<?php echo DOCBASE; ?>templates/<?php echo TEMPLATE; ?>/common/register/logout.php" data-refresh="true"><i class="fa fa-power-off"></i> <?php echo $texts['LOG_OUT']; ?></a></li>
                                    </ul>
                                </div>
                            </form>
                            <?php
                        }else{ ?>
                            <a class="popup-modal firstLevel" href="#user-popup">
                                <i class="fa fa-power-off"></i>
                            </a>
                            <?php
                        } ?>
                    </li>
                    <?php
                    if(LANG_ENABLED){
                        if(count($langs) > 0){ ?>
                            <li class="primary">
                                <div class="dropdown">
                                    <a class="firstLevel dropdown-toggle" data-toggle="dropdown" href="#">
                                        <img src="<?php echo $langs[LANG_TAG]['file']; ?>" alt="<?php echo $langs[LANG_TAG]['title']; ?>"><span class="hidden-sm hidden-md"> <?php echo $langs[LANG_TAG]['title']; ?></span> <span class="caret"></span>
                                    </a>
                                    <ul class="dropdown-menu dropdown-menu-right" role="menu" id="lang-menu">
                                        <?php
                                        foreach($langs as $row){
                                            $title_lang = $row['title']; ?>
                                            <li>
                                                <a href="<?php echo DOCBASE.$row['tag']; ?>">
                                                    <img src="<?php echo $row['file']; ?>" alt="<?php echo $title_lang; ?>"> <?php echo $title_lang; ?>
                                                </a>
                                            </li>
                                            <?php
                                        } ?>
                                    </ul>
                                </div>
                            </li>
                            <?php
                        }
                    }
                    if(CURRENCY_ENABLED){
                        if(count($currencies) > 0){ ?>
                            <li class="primary">
                                <div class="dropdown">
                                    <a class="firstLevel dropdown-toggle" data-toggle="dropdown" href="#">
                                        <span><?php echo CURRENCY_CODE; ?></span><span class="hidden-sm hidden-md"> <?php echo CURRENCY_SIGN; ?></span> <span class="caret"></span>
                                    </a>
                                    <ul class="dropdown-menu dropdown-menu-right" role="menu" id="currency-menu">
                                        <?php
                                        foreach($currencies as $row){ ?>
                                            <li>
                                                <a href="<?php echo getUrl(); ?>" data-action="<?php echo getFromTemplate("common/change_currency.php?curr=".$row['id']); ?>" class="ajax-link">
                                                    <?php echo $row['code']." ".$row['sign']; ?>
                                                </a>
                                            </li>
                                            <?php
                                        } ?>
                                    </ul>
                                </div>
                            </li>
                            <?php
                        }
                    } ?>
                    <li class="primary">
                        <div class="dropdown">
                            <a class="firstLevel dropdown-toggle" data-toggle="dropdown" href="#">
                                <i class="fa fa-search"></i> <span class="caret"></span>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-right" role="menu" id="currency-menu">
                                <li>
                                    <?php $csrf_token = get_token("search"); ?>

                                    <form method="post" action="<?php echo DOCBASE.$sys_pages['search']['alias']; ?>" role="form" class="form-inline">
                                        <input type="hidden" name="csrf_token" value="<?php echo $csrf_token; ?>">
                                        <div class="input-group" id="searchWrapper">
                                            <input type="text" class="form-control" name="global-search" placeholder="<?php echo $texts['SEARCH']; ?>">
                                            <span class="input-group-btn">
                                                <button type="submit" class="btn btn-primary" name="send"><i class="fa fa-search"></i></button>
                                            </span>
                                        </div>
                                    </form>
                                </li>
                            </ul>
                        </div>
                    </li>
                </ul>
                <div id="user-popup" class="white-popup-block mfp-hide">
                    <div class="fluid-container">
                        <div class="row">
                            <div class="col-xs-12 mb20 text-center">
                                <a class="btn fblogin" href="#"><i class="fa fa-facebook"></i> <?php echo $texts['LOG_IN_WITH_FACEBOOK']; ?></a>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12 mb20 text-center">
                                - <?php echo $texts['OR']; ?> -
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="login-form">
                                    <form method="post" action="<?php echo DOCBASE.$page['alias']; ?>" class="ajax-form">
                                        <div class="alert alert-success" style="display:none;"></div>
                                        <div class="alert alert-danger" style="display:none;"></div>
                                        <div class="form-group">
                                            <div class="input-group">
                                                <div class="input-group-addon"><i class="fa fa-user"></i></div>
                                                <input type="text" class="form-control" name="user" value="" placeholder="<?php echo $texts['USERNAME']." ".strtolower($texts['OR'])." ".$texts['EMAIL']; ?> *">
                                            </div>
                                            <div class="field-notice" rel="user"></div>
                                        </div>
                                        <div class="form-group">
                                            <div class="input-group">
                                                <div class="input-group-addon"><i class="fa fa-lock"></i></div>
                                                <input type="password" class="form-control" name="password" value="" placeholder="<?php echo $texts['PASSWORD']; ?> *">
                                            </div>
                                            <div class="field-notice" rel="pass"></div>
                                        </div>
                                        <div class="row mb10">
                                            <div class="col-sm-7 text-left">
                                                <a class="open-pass-form" href="#"><?php echo $texts['FORGOTTEN_PASSWORD']; ?></a><br>
                                                <a class="open-signup-form" href="#"><?php echo $texts['I_SIGN_UP']; ?></a>
                                            </div>
                                            <div class="col-sm-5 text-right">
                                                <a href="#" class="btn btn-default sendAjaxForm" data-action="<?php echo DOCBASE; ?>templates/<?php echo TEMPLATE; ?>/common/register/login.php" data-refresh="true"><i class="fa fa-power-off"></i> <?php echo $texts['LOG_IN']; ?></a>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                                <div class="signup-form">
                                    <form method="post" action="<?php echo DOCBASE.$page['alias']; ?>" class="ajax-form">
                                        <div class="alert alert-success" style="display:none;"></div>
                                        <div class="alert alert-danger" style="display:none;"></div>
                                        <div class="form-group">
                                            <div class="input-group">
                                                <div class="input-group-addon"><i class="fa fa-user"></i></div>
                                                <input type="text" class="form-control" name="name" value="" placeholder="<?php echo $texts['FULLNAME']; ?> *">
                                            </div>
                                            <div class="field-notice" rel="name"></div>
                                        </div>
                                        <div class="form-group">
                                            <div class="input-group">
                                                <div class="input-group-addon"><i class="fa fa-user"></i></div>
                                                <input type="text" class="form-control" name="username" value="" placeholder="<?php echo $texts['USERNAME']; ?> *">
                                            </div>
                                            <div class="field-notice" rel="username"></div>
                                        </div>
                                        <div class="form-group">
                                            <div class="input-group">
                                                <div class="input-group-addon"><i class="fa fa-envelope"></i></div>
                                                <input type="text" class="form-control" name="email" value="" placeholder="<?php echo $texts['EMAIL']; ?> *">
                                            </div>
                                            <div class="field-notice" rel="email"></div>
                                        </div>
                                        <div class="form-group">
                                            <div class="input-group">
                                                <div class="input-group-addon"><i class="fa fa-lock"></i></div>
                                                <input type="password" class="form-control" name="password" value="" placeholder="<?php echo $texts['PASSWORD']; ?> *">
                                            </div>
                                            <div class="field-notice" rel="password"></div>
                                        </div>
                                        <div class="row mb10">
                                            <div class="col-sm-7 text-left">
                                                <a class="open-login-form" href="#"><?php echo $texts['ALREADY_HAVE_ACCOUNT']; ?></a>
                                            </div>
                                            <div class="col-sm-5 text-right">
                                                <a href="#" class="btn btn-default sendAjaxForm" data-action="<?php echo DOCBASE; ?>templates/<?php echo TEMPLATE; ?>/common/register/signup.php" data-refresh="false"><i class="fa fa-power-off"></i> <?php echo $texts['SIGN_UP']; ?></a>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                                <div class="pass-form">
                                    <form method="post" action="<?php echo DOCBASE.$page['alias']; ?>" class="ajax-form">
                                        <div class="alert alert-success" style="display:none;"></div>
                                        <div class="alert alert-danger" style="display:none;"></div>
                                        <p><?php echo $texts['NEW_PASSWORD_NOTICE']; ?></p>
                                            
                                        <div class="form-group">
                                            <div class="input-group">
                                                <div class="input-group-addon"><i class="fa fa-envelope"></i></div>
                                                <input type="text" class="form-control" name="email" value="" placeholder="<?php echo $texts['EMAIL']; ?> *">
                                            </div>
                                            <div class="field-notice" rel="email"></div>
                                        </div>
                                        <div class="row mb10">
                                            <div class="col-sm-7 text-left">
                                                <a class="open-login-form" href="#"><?php echo $texts['LOG_IN']; ?></a><br>
                                                <a class="open-signup-form" href="#"><?php echo $texts['I_SIGN_UP']; ?></a>
                                            </div>
                                            <div class="col-sm-5 text-right">
                                                <a href="#" class="btn btn-default sendAjaxForm" data-action="<?php echo DOCBASE; ?>templates/<?php echo TEMPLATE; ?>/common/register/reset.php" data-refresh="false"><i class="fa fa-power-off"></i> <?php echo $texts['NEW_PASSWORD']; ?></a>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="navbar navbar-default">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                        <span class="sr-only">Цэс</span>
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
