<?php
define("TITLE_ELEMENT", "404 хуудас олдсонгүй !");
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
                            <h1 class="pull-left"><i class="fa fa-warning"></i> 404 хуудас олдсонгүй !</h1>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12">
                    <h2>Алдаа 404</h2>
                    <p>Энэ хуудас анхнаасаа байгаагүй, хаяг нь солигдсон эсвэл түр зуур хандах боломжгүй байна.</p>
                    
                    Доорх зааврыг дагана уу :
                    <ul>
                        <li>Таны интернэт хөтөчийн хандах хэсэгт буй URL хаяг зөв бичигдсэн эсэхийг шалгана уу.</li>
                        <li>Хэрвээ та энэ хуудасруу сайтын холбоос линкээр дамжиж орсон эсвэл энэ алдаа нь серверийн алдаатай үйлдэл гэж үзэж байвал сайтын администраторт хандаж мэдэгдэнэ үү.</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
