<?php debug_backtrace() || die ("Direct access not permitted"); ?>
<div class="form-group">
    <label class="sr-only" for="from"></label>
    <div class="input-group">
        <div class="input-group-addon"><i class="fa fa-calendar"></i> <?php echo $texts['CHECK_IN']; ?></div>
        <input type="text" class="form-control" id="from_picker" name="from_date" value="<?php echo $from_date; ?>">
    </div>
</div>
<div class="form-group">
    <div class="input-group">
        <div class="input-group-addon"><i class="fa fa-calendar"></i> <?php echo $texts['CHECK_OUT']; ?></div>
        <input type="text" class="form-control" id="to_picker" name="to_date" value="<?php echo $to_date; ?>">
    </div>
</div>
<div class="form-group">
    <div class="input-group">
        <div class="input-group-addon"><i class="fa fa-tags"></i> <?php echo $texts['ROOM']; ?></div>
        <select class="form-control" name="room_id">
            <?php
            $result_room = $db->query("SELECT * FROM pm_room WHERE checked = 1 AND lang = ".LANG_ID);
            if($result_room !== false){
                foreach($result_room as $i => $row){ ?>
                    <option value="<?php echo $row['id']; ?>"><?php echo $row['title']; ?></option>
                    <?php
                }
            } ?>
        </select>
    </div>
</div>
<div class="form-group">
    <div class="input-group">
        <div class="input-group-addon"><i class="fa fa-male"></i> <?php echo $texts['ADULTS']; ?></div>
        <select name="num_adults" class="form-control">
            <?php
            for($i = 1; $i <= $max_adults; $i++){
                $select = ($num_adults == $i) ? " selected=\"selected\"" : "";
                echo "<option value=\"".$i."\"".$select.">".$i."</option>";
            } ?>
        </select>
    </div>
</div>
<div class="form-group">
    <div class="input-group">
        <div class="input-group-addon"><i class="fa fa-male"></i> <?php echo $texts['CHILDREN']; ?></div>
        <select name="num_children" class="form-control">
            <?php
            for($i = 0; $i <= $max_children; $i++){
                $select = ($num_children == $i) ? " selected=\"selected\"" : "";
                echo "<option value=\"".$i."\"".$select.">".$i."</option>";
            } ?>
        </select>
    </div>
</div>
<div class="form-group">
    <button class="btn btn-primary" type="submit" name="check_availabilities"><i class="fa fa-search"></i> <?php echo $texts['CHECK']; ?></button>
</div>
