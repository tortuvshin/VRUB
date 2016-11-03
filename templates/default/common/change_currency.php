<?php
define("SYSBASE",realpath(__DIR__."/../../../")."/");
require_once(SYSBASE."common/lib.php");
require_once(SYSBASE."common/define.php");
    
if(isset($db) && $db !== false){

    if(isset($_GET['curr']) && is_numeric($_GET['curr']) > 0){

        $curr_id = $_GET['curr'];
        $rate = "";

        $result_currency = $db->query("SELECT * FROM pm_currency WHERE id = ".$curr_id);
        if($result_currency !== false && $db->last_row_count() == 1){
            $row = $result_currency->fetch();
            $code = $row['code'];
            $sign = $row['sign'];

            if(($handle = fopen("http://download.finance.yahoo.com/d/quotes.csv?s=".DEFAULT_CURRENCY_CODE.$code."=X&f=sl1d1t1ba&e=.csv", "r")) !== false){
                if(($data = fgetcsv($handle)) !== false){
                    var_dump($data); 
                    $rate = (float)$data[1];
                }
            }
            if(is_numeric($rate)){
                $_SESSION['currency']['rate'] = $rate;
                $_SESSION['currency']['code'] = $code;
                $_SESSION['currency']['sign'] = $sign;
            }
        }
    }
}
