<section   style="">
<style>
.parallax {
    background-image: url("./medias/slide/big/6.jpg");
    min-height: 300px;
    background-attachment: fixed;
    background-position: center;
    background-repeat: no-repeat;
    background-size: cover;
}
.parallax2 {
    height:auto;
    font-size:36px;
    min-height: 300px;
    background: rgba(56, 80, 126, 0.65);
    position: absolute;
    text-align: center;
    padding: 50px 30px 50px 80px;
    color: #fff;
}
</style>
<div  class="parallax2">
    <h1 > Мод захиалга</h1> 

                        <h5>  Тара код бол 1294 модноос бүтэх байнгын арчилгаатай 500 жилийн настай цэцэрлэгт хүрээлэн юм. Энэхүү цэцэрлэгт хүрээлэн нь энэ орчлонд морилон ирэгсэдийг даатгадаг Дарь-Эхийн түлхүүр хэмээх домогт дүрсний дагуу голоор нь яваад гарч ирэхэд 2.4км зам туулахаар бүтээгдсэн.
Та хүссэн модоо сонгон авч ивээн тэтгэх боломжтой бөгөөд таны нэр модны дэргэдэх пайз дээр 500 жилийн турш байрших болно..</h5>
                                                      <a href="<?php echo DOCBASE.LANG_ALIAS; ?>sale/">  <span class="btn btn-primary">Дэлгэрэнгүй</span>      </a>                           
</div>
<div class="parallax"></div>
</section>

<?php debug_backtrace() || die ("Шууд хандах боломжгүй"); ?>

<footer>
    <section id="mainFooter">
        <div class="container" id="footer">
            <div class="row">

                <div class="widget-footer">
                    
                    <div id="widget-1" class="widget">
                            <div class="widget-title">Бидний тухай</div>
                            <div class="widget-content">
                                    <p style="text-align: justify;">Тара код бол 1294 модноос бүтэх байнгын арчилгаатай 500 жилийн настай цэцэрлэгт хүрээлэн юм. Энэхүү цэцэрлэгт хүрээлэн нь энэ орчлонд морилон ирэгсэдийг даатгадаг Дарь-Эхийн түлхүүр хэмээх домогт дүрсний дагуу голоор нь яваад гарч ирэхэд 2.4км зам туулахаар бүтээгдсэн.
Та хүссэн модоо сонгон авч ивээн тэтгэх боломжтой бөгөөд таны нэр модны дэргэдэх пайз дээр 500 жилийн турш байрших болно..&nbsp;</p>
                            </div>
                    </div>
                    <div class="widget"> 
                    <div class="widget-title">Twitter</div>
                        <div class="widget-content">
                              <a class="twitter-timeline"
                              href="https://twitter.com/BrownBuildings"
                              data-width="100%"
                              data-height="250"
                              data-chrome="nofooter noborders">
                            Tweets by @Tara Code
                            </a>     
                        </div>
                      
                    </div>
                      
                    <div class="widget"> 
                    <div class="widget-title">Facebook</div>
                        <div class="widget-content">
                                
                        
                        <div class="fb-page" 
                                data-href="https://www.facebook.com/Taracode-1678800019078314/?fref=ts" 
                                data-tabs="timeline" 
                                data-height="250px" 
                                data-small-header="true" 
                                data-adapt-container-width="true" 
                                data-hide-cover="false" 
                                data-show-facepile="true">
                                <blockquote cite="https://www.facebook.com/Taracode-1678800019078314/" 
                                class="fb-xfbml-parse-ignore">
                                <a href="https://www.facebook.com/Taracode-1678800019078314/?fref=ts">Taracode.mn</a>
                                </blockquote>

                                
                        </div>   
                        </div>
                      
                    </div>
                </div>
                
            </div>
        </div>
    </section>
    <div id="footerRights">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <p>
                        &copy; <?php echo date("Y"); ?>
                        <?php echo OWNER." ".$texts['ALL_RIGHTS_RESERVED']; ?>
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
