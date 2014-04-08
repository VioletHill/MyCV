<?php
header("Content-Type: text/json; charset=utf8");
    require_once ('WorksDao.php');				
    $worksArray=WorksDao::sharedWorksDao()->getAllData();
    $jsonArray=array();
    
    echo '[';

    for ($i=0; $i<(count($worksArray)); $i++)
    {
    	$item=$worksArray[$i];
        echo $item->toJson();
        if ($i<count($worksArray)-1)
        {
            echo ',';
        }
    }
    echo ']';
?>

