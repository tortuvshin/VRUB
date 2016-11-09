<?php
$msg_error = "";
$msg_success = "";
$field_notice = array();

if(isset($_POST['send'])){
    
    $captcha = strtoupper($_POST['captcha']);
    require(SYSBASE."includes/securimage/securimage.php");
    $img = new Securimage();
    $valid = $img->check($captcha);

    if($valid === false) $field_notice['captcha'] = $texts['INVALID_CAPTCHA_CODE'];
    
    $name = html_entity_decode($_POST['name'], ENT_QUOTES, "UTF-8");
    $address = html_entity_decode($_POST['address'], ENT_QUOTES, "UTF-8");
    $phone = html_entity_decode($_POST['phone'], ENT_QUOTES, "UTF-8");
    $email = $_POST['email'];
    $msg = html_entity_decode($_POST['msg'], ENT_QUOTES, "UTF-8");
    $subject = html_entity_decode($_POST['subject'], ENT_QUOTES, "UTF-8");
    
    if($name == "") $field_notice['name'] = $texts['REQUIRED_FIELD'];
    if($msg == "") $field_notice['msg'] = $texts['REQUIRED_FIELD'];
    if($subject == "") $field_notice['subject'] = $texts['REQUIRED_FIELD'];
    
    if($email == "" || !preg_match("/^[\w.-]+@[\w.-]+\.[a-zA-Z]{2,6}$/i", $email)) $field_notice['email'] = $texts['INVALID_EMAIL'];
    
    if(count($field_notice) == 0){

        $data = array();
        $data['id'] = "";
        $data['name'] = $name;
        $data['address'] = $address;
        $data['phone'] = $phone;
        $data['email'] = $email;
        $data['subject'] = $subject;
        $data['msg'] = $msg;
        $data['add_date'] = time();
        $data['edit_date'] = null;

        $result_message = db_prepareInsert($db, "pm_message", $data);
        $result_message->execute();
    
        $mailContent = "<b>Нэр:</b> ".$name."<br> \n\n";
        if($address != "") $mailContent .= "<b>Хаяг:</b> ".$address."<br> \n\n";
        if($phone != "") $mailContent .= "<b>Утас:</b> ".$phone."<br> \n\n";
        $mailContent .= "<b>И-мэйл:</b> ".$email."<br> \n\n";
        $mailContent .= "<b>Зурвас:</b><br>".$msg." \n\n";
        
        if(!sendMail(EMAIL, OWNER, $subject, $mailContent, $email, $name))
            $msg_error .= $texts['MAIL_DELIVERY_FAILURE'];
        else
            $msg_success .= $texts['MAIL_DELIVERY_SUCCESS'];
    }else
        $msg_error .= $texts['FORM_ERRORS'];
    
}else{
    $name = "";
    $address = "";
    $phone = "";
    $email = "";
    $subject = "";
    $msg = "";
}
require(getFromTemplate("common/header.php", false)); ?>

<script>
    var locations = [
        <?php
        $result_location = $db->query("SELECT * FROM pm_location WHERE checked = 1 AND pages REGEXP '(^|,)".$page_id."(,|$)'");
        if($result_location !== false){
            $nb_locations = $db->last_row_count();
            foreach($result_location as $i => $row){
                $location_name = $row['name'];
                $location_address = $row['address'];
                $location_lat = $row['lat'];
                $location_lng = $row['lng'];

                echo "['".addslashes($location_name)."', '".addslashes($location_address)."', '".$location_lat."', '".$location_lng."']";
                if($i+1 < $nb_locations) echo ",\n";
            }
        } ?>
    ];
</script>

<section id="page">
    
    <?php include(getFromTemplate("common/page_header.php", false)); ?>
    
    <div id="content" class="clearfix">
        <div id="mapWrapper" data-marker="<?php echo getFromTemplate("images/marker.png"); ?>" data-api_key="<?php echo GMAPS_API_KEY; ?>"></div>
        <div class="container pt30 pb15">
            
            <?php
            if($page['text'] != ""){ ?>
                <div class="clearfix mb20"><?php echo $page['text']; ?></div>
                <?php
            } ?>

            <div class="alert alert-success" style="display:none;"></div>
            <div class="alert alert-danger" style="display:none;"></div>
            
            <div class="row">
                <form method="post" action="<?php echo DOCBASE.$page['alias']; ?>" role="form">
                    <div class="col-sm-4">
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
                                <input type="text" class="form-control" name="email" value="<?php echo $email; ?>" placeholder="<?php echo $texts['EMAIL']; ?> *">
                            </div>
                            <div class="field-notice" rel="email"></div>
                        </div>
                        <div class="form-group">
                            <div class="input-group">
                                <div class="input-group-addon"><i class="fa fa-home"></i></div>
                                <textarea class="form-control" name="address" placeholder="<?php echo $texts['ADDRESS'].", ".$texts['POSTCODE'].", ".$texts['CITY']; ?>"><?php echo htmlentities($address, ENT_QUOTES, "UTF-8"); ?></textarea>
                            </div>
                            <div class="field-notice" rel="address"></div>
                        </div>
                        <div class="form-group">
                            <div class="input-group">
                                <div class="input-group-addon"><i class="fa fa-phone"></i></div>
                                <input type="text" class="form-control" name="phone" value="<?php echo htmlentities($phone, ENT_QUOTES, "UTF-8"); ?>" placeholder="<?php echo $texts['PHONE']; ?>">
                            </div>
                            <div class="field-notice" rel="phone"></div>
                        </div>
                    </div>
                    <div class="col-sm-5">
                        <div class="form-group">
                            <div class="input-group">
                                <div class="input-group-addon"><i class="fa fa-question"></i></div>
                                <input type="text" class="form-control" name="subject" value="<?php echo htmlentities($subject, ENT_QUOTES, "UTF-8"); ?>" placeholder="<?php echo $texts['SUBJECT']; ?> *">
                            </div>
                            <div class="field-notice" rel="subject"></div>
                        </div>
                        <div class="form-group">
                            <div class="input-group">
                                <div class="input-group-addon"><i class="fa fa-quote-left"></i></div>
                                <textarea class="form-control" name="msg" placeholder="<?php echo $texts['MESSAGE']; ?> *" rows="4"><?php echo htmlentities($msg, ENT_QUOTES, "UTF-8"); ?></textarea>
                            </div>
                            <div class="field-notice" rel="msg"></div>
                        </div>    
                        <div class="form-group form-inline">
                            <div class="input-group mb5">
                                <div class="input-group-addon"><i class="fa fa-lock"></i></div>
                                <input type="text" class="form-control" name="captcha" id="captcha" value="" placeholder="<?php echo $texts['COPY_CODE']; ?> *">
                            </div>
                            <img id="captcha_image" alt="" src="<?php echo DOCBASE; ?>includes/securimage/securimage_show.php?sid=<?php echo md5(uniqid(time())); ?>" style="vertical-align:middle;">
                            <a href="#" onclick="document.getElementById('captcha_image').src = '<?php echo DOCBASE; ?>includes/securimage/securimage_show.php?sid=' + Math.random(); return false">
                                <i class="fa fa-refresh"></i>
                            </a>
                            <div class="field-notice" rel="captcha"></div>
                        </div>    
                        <div class="form-group row">
                            <span class="col-sm-12"><button type="submit" class="btn btn-primary" name="send"><i class="fa fa-send"></i> <?php echo $texts['SEND']; ?></button> <i> * <?php echo $texts['REQUIRED_FIELD']; ?></i></span>
                        </div>
                    </div>
                </form>
                <div class="col-sm-3">
                    <div class="hotBox" itemscope itemtype="http://schema.org/Corporation">
                        <h2 itemprop="name"><?php echo OWNER; ?></h2>
                        <address>
                            <p>
                                <?php if(ADDRESS != "") : ?><span class="fa fa-map-marker"></span> <span itemprop="address" itemtype="http://schema.org/PostalAddress"><?php echo nl2br(ADDRESS); ?></span><br><?php endif; ?>
                                <?php if(PHONE != "") : ?><span class="fa fa-phone"></span> <span itemprop="telephone" dir="ltr"><?php echo PHONE; ?></span><br><?php endif; ?>
                                <?php if(FAX != "") : ?><span class="fa fa-fax"></span> <span itemprop="faxNumber" dir="ltr"><?php echo FAX; ?></span><br><?php endif; ?>
                                <?php if(EMAIL != "") : ?><span class="fa fa-envelope"></span> <a itemprop="email" dir="ltr" href="mailto:<?php echo EMAIL; ?>"><?php echo EMAIL; ?></a><?php endif; ?>
                            </p>
                        </address>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
