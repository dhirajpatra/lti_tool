<?php

include 'tpdatabase.php';
use TpDatabase;

class DbHandler
{
    protected $dbObj = null;
    protected $connection = false;

    public function __construct()
    {
        $dbObj = new TpDatabase();
        $connection = $dbObj->connect;
    }

    public function selectQuery()
    {
        /*
        $query = "SELECT * FROM `tc_user`";
        $cur = @mysqli_query($query, $connection);
        print_r($cur); */
    }

    public function __destruct()
    {
        unset($dbObj);
    }
}
