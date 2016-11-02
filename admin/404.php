<?php
define("TITLE_ELEMENT", "404 page not found !");
require_once("../common/lib.php");
require_once("../common/define.php");
if(!isset($_SESSION['user'])){
    header("Location: login.php");
    exit();
}
require_once("includes/fn_module.php"); ?>
<!DOCTYPE html>
<head>
    <?php include("includes/inc_header_common.php"); ?>
</head>
<body>
    <div id="wrapper">
        <?php include(SYSBASE."admin/includes/inc_top.php"); ?>
        <div id="page-wrapper">
            <div class="page-header">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-md-12 clearfix">
                            <h1 class="pull-left"><i class="fa fa-warning"></i> 404 page not found !</h1>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12">
                    <h2>Error 404</h2>
                    <p>The wanted URL was not found on this server.<br>
                    The page you wish to display does not exist, or is temporarily unavailable.</p>
                    Thank you for trying the following actions :
                    <ul>
                        <li>Be sure the URL in the address bar of your browser is correctly spelt and formated.</li>
                        <li>If you reached this page by clicking a link or if you think that it is about an error of the server, contact the administrator to alert him.</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
