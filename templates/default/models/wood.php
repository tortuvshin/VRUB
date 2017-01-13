<?php

$stylesheets[] = array("file" => DOCBASE."js/plugins/isotope/css/style.css", "media" => "all");
$javascripts[] = DOCBASE."js/plugins/isotope/jquery.isotope.min.js";
$javascripts[] = DOCBASE."js/plugins/isotope/jquery.isotope.sloppy-masonry.min.js";

$stylesheets[] = array("file" => DOCBASE."js/plugins/lazyloader/lazyloader.css", "media" => "all");
$javascripts[] = DOCBASE."js/plugins/lazyloader/lazyloader.js";

$stylesheets[] = array("file" => DOCBASE."js/plugins/star-rating/css/star-rating.min.css", "media" => "all");
$javascripts[] = DOCBASE."js/plugins/star-rating/js/star-rating.min.js";

$msg_error = "";
$msg_success = "";
$field_notice = array();

if(isset($_POST['save'])){
    
    $code = $_POST['code'];
    $name = $_POST['name'];
    $age = $_POST['age'];
    $owner = $_POST['owner'];
    $state = $_POST['state'];
    $email = $_POST['email'];
    $description = $_POST['description'];
    
    if($code == "") $field_notice['code'] = $texts['REQUIRED_FIELD'];
    if($name == "") $field_notice['name'] = $texts['REQUIRED_FIELD'];
    if($age == "") $field_notice['age'] = $texts['REQUIRED_FIELD'];
    if($owner == "") $field_notice['owner'] = $texts['REQUIRED_FIELD'];
    if($email == "") $field_notice['email'] = $texts['REQUIRED_FIELD'];
    if($description == "") $field_notice['description'] = $texts['REQUIRED_FIELD'];
    
    if(count($field_notice) == 0){
        $data = array();
        $data['code'] = $code;
        $data['name'] = $name;
        $data['age'] = $age;
        $data['status'] = $state;
        $data['owner'] = $owner;
        $data['email'] = $email;
        $data['description'] = $description;
    
        $result_tree = db_prepareInsert($db, "pm_wd", $data);
        if($result_tree->execute() !== false){
            
            
            $msg_success .= $texts['ACCOUNT_EDIT_SUCCESS'];
        }else
            $msg_error .= $texts['ACCOUNT_EDIT_FAILURE'];
    }else
        $msg_error .= $texts['FORM_ERRORS'];
    
}

require(getFromTemplate("common/header.php", false));

          
?>


<section id="page">
    
    <?php include(getFromTemplate("common/page_header.php", false)); ?>
  
    <section>
            <style>
            .parallaxWood2 {
                  font-size:20px;
                  min-height: 200px;
                  text-align: center;
                  padding: 80px 30px 0px 80px;
                  color: black;
                  width: 80%;
                  margin-left: 10%;                  
                  font-family: 'Roboto', sans-serif;
                  text-align: justify;
                  }
            .parallaxWood2 h1{
                  padding-bottom: 2%;
                  font-size: 30px; 
                  text-align: center;                  
                  font-family: 'Roboto', sans-serif;
                  padding-bottom: 2%;
            }
            </style>
            <div  class="parallaxWood2"> 
            <h1>Тара код цэцэрлэгт хүрээлэн</h1>
                                    <p>Тара код бол 1294 модноос бүтэх байнгын арчилгаатай 500 жилийн настай цэцэрлэгт хүрээлэн юм. Энэхүү цэцэрлэгт хүрээлэн нь энэ орчлонд морилон ирэгсэдийг даатгадаг Дарь-Эхийн түлхүүр хэмээх домогт дүрсний дагуу голоор нь яваад гарч ирэхэд 2.4км зам туулахаар бүтээгдсэн.
Та хүссэн модоо сонгон авч ивээн тэтгэх боломжтой бөгөөд таны нэр модны дэргэдэх пайз дээр 500 жилийн турш байрших болно.
                                    <p>                           
            </div>
      </section>
    <div id="content" class="pt30 pb20">
        <div class="container" itemprop="text">
        
          <div id="background">
            <div id="treeState">
                  <table class="tg">
                    <tr>
                      <th class="tg-031e"></th>
                      <th class="tg-031e">Голт бор<br> </th>
                      <th class="tg-yw4l"> Нарс</th>
                    </tr>
                    <tr>
                      <td class="tg-031e">Зарагдаагүй</td>
                      <td class="tg-031e"><img src="<?php echo DOCBASE; ?>templates/<?php echo TEMPLATE; ?>/images/goltBor.png"></td>
                      <td class="tg-yw4l"><img src="<?php echo DOCBASE; ?>templates/<?php echo TEMPLATE; ?>/images/nars.png"></td>
                    </tr>
                    <tr>
                      <td class="tg-yw4l">Зарагдсан</td>
                      <td class="tg-yw4l"><img src="<?php echo DOCBASE; ?>templates/<?php echo TEMPLATE; ?>/images/soldGoltBor.png"></td>
                      <td class="tg-yw4l"><img src="<?php echo DOCBASE; ?>templates/<?php echo TEMPLATE; ?>/images/soldNars.png"></td>
                    </tr>
                  </table>
                  
            </div>

             <?php
                $result_tree = $db->query("SELECT * FROM pm_tree",PDO::FETCH_ASSOC);
                if($result_tree !== false && $db->last_row_count() > 0){
                    foreach($result_tree as $i => $row){
                        $tree_id     = $row['id'];
                        $tree_code   = $row['code'];
                        $tree_name   = $row['name'];
                        $tree_age    = $row['age'];
                        $tree_status = $row['status'];
                        $tree_owner   = $row['owner'];
                        $tree_description   = $row['description'];

                        if ($tree_name == "Нарс") {
                            $imgsrc = DOCBASE."templates/default/images/nars.png";

                            if ($tree_status == "зарагдсан") {
                                $imgsrc = DOCBASE."templates/default/images/soldNars.png";
                            }   
                        } else if ($tree_name == "Голт бор") {
                            $imgsrc = DOCBASE."templates/default/images/goltBor.png";

                            if ($tree_status == "зарагдсан") {
                                $imgsrc = DOCBASE."templates/default/images/soldGoltBor.png";
                            }
                        }
           
                        echo "<div id='$tree_code' class='tree' data-code='$tree_code' data-name='$tree_name' data-age='$tree_age' data-status='$tree_status' data-owner='$tree_owner' data-description='$tree_description'>
                            <img src='$imgsrc'>
                        </div>";

                        ?>
                 
                    <?php }
                } ?>
        </div>
    </div>
</section>


<div class="modal fade" id="myModal" role="dialog">
  <div class="modal-dialog">
      <!-- Modal content-->
      <div class="modal-content">
          
          
          <form class="form-horizontal company" action="<?php echo DOCBASE.$page['alias']; ?>" method="POST" role="form" id="comp">
                          
            <div class="modal-body">
              
              <div class="treeImage">
                   <img id="treePic">
                    <p class="name-or-age">
                      <a class="img-age"></a>
                      <a> настай</a>
                      <a class="img-name"></a>
                    </p>
                   </img>
                   
              </div>
              <div class="treeInfo">
                <input type="hidden" class="form-control tree-code" id="code" name="code" value="" placeholder="Модны код"  >
                <input type="hidden" class="form-control tree-name" id="name" name="name" value="" placeholder="Модны нэр"  >  
                <input type="hidden" class="form-control tree-age" id="age" name="age" value="" placeholder="Нас" >
                <input type="hidden" class="form-control tree-state" id="state" name="state" value="" placeholder="Төлөв" >        
                  <div class="form-group">
                    <label  class="col-sm-12 control-label" style="margin-bottom: 20px">
                      <h4>Мод ивээн тэтгэх заавар</h4>
                      <p>Хүлээн авагч:  Khard LLC<p>
                      <p>Дансны дугаар: 457052038<p>
                      <p>Swift code: TDBMMNUB<p>
                      <p>100$ шилжүүлж гүйлгээний утга дээр <label class="billing-code"></label> энэхүү кодыг бичнэ үү.<p>
                      <p>Trade Development bank of Mongolia<p>
                    </label>
                  </div>
                <div class="form-group">
                    <label  class="col-sm-4 control-label">Овог нэр:</label>
                    <div class="col-sm-7">
                        <input type="text" class="form-control  tree-owner" id="owner" name="owner" placeholder="Овог нэр оруулна уу" value="" >
                    </div>
                </div>
                <div class="form-group">
                    <label  class="col-sm-4 control-label">Мэйл хаяг:</label>
                    <div class="col-sm-7">
                        <input type="text" class="form-control  tree-email" id="owner" name="email" placeholder="Мэйл хаягаа оруулна уу" value="" >
                    </div>
                </div>
                <div class="form-group">
                    <label  class="col-sm-4 control-label">Пайз дээр байрших үг:</label>
                    <div class="col-sm-7">
                        <input type="text" class="form-control  tree-description" id="description" name="description" placeholder="Пайз дээр байрших үг оруулна уу" value="" >     
                    </div>
                </div> 
                <div class="form-group">
                  <button type="submit" class="treeBooking btn btn-default" name="save" id="order">Захиалах</button>
                  <button class="btn btn-default" data-dismiss="modal">Гарах</button>
                </div>
              </div>
            </div>
            
          </form>
      </div>
  </div>
</div>
<script>

$("document").ready(function(){
       
      
      $('.tree').click(function() {
            var code = $(this).data("code");
            var name = $(this).data("name");
            var age = $(this).data( "age");
            var state = $(this).data( "status");
            var owner = $(this).data( "owner");
            if(name=="Голт бор") {                
                 $('#treePic').attr('src', '<?php echo DOCBASE; ?>templates/<?php echo TEMPLATE; ?>/images/goltborlarge.jpg');
            } 
            if(name=="Нарс") {                
                 $('#treePic').attr('src', '<?php echo DOCBASE; ?>templates/<?php echo TEMPLATE; ?>/images/treeLarge.jpg');
            }


            $("#myModal").modal('show');     
            $(".tree-code").val(code);          
            $(".billing-code").html(code);
            $(".tree-name").val(name);
            $(".tree-age").val(age);
            $(".tree-state").val(state);
            $(".tree-owner").val(owner);
            $(".img-name").html(name);
            $(".img-age").html(age);
            
      });
      $('.tree').mouseover(function(){
            $(this).addClass('tree-Hover');
            var state = $(this).data("status");
            $(this).append("<span  class='tree-Popup'>"+state+"</span>");
      })
      $('.tree').mouseout(function(){
            $(this).removeClass('tree-Hover');
            $(".tree-Popup").remove();
      })
})

</script>
