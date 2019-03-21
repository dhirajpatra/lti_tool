<?php

include $_SERVER['DOCUMENT_ROOT'].'/lti_v2/library/config.php';

class TpDatabase
{
    // Variable Declaration
    private $host = null;
    private $username = null;
    private $password = null;
    private $database = null;
    private $tpconn = null;

    public function __construct()
    {
        $this->host = TP_LOCALHOST;
        $this->username = TP_USERNAME;
        $this->password = TP_PASSWORD;
        $this->database = TP_DATABASE;
    }

    //---------------------------------

    /**
     * @functionality - DB Connection.
     *
     * @return \mysqli connection id
     */
    public function tpconnect()
    { 
        $tpconn = new mysqli($this->host, $this->username, $this->password, $this->database);
        if (!$tpconn) {
            echo 'Failed to connect to Database '.mysql_connect_error().' <br/>';
            die;
        }

        return $tpconn;
    }

    //---------------------------------

    /**
     * @Functionality :: Prevent XSS attack
     *
     * @param - Input (array) $data - Input array that needs to be filtered, output (array) $data Filtered array
     *
     * @copyright (c) 2016, Impelsys India Pvt. Ltd.
     * @author Srinivasu M <srinivasu.m@impelsys.com>
     *
     * Ref : https://gist.github.com/mbijon/1098477
     */
    public function preventXssArray($data = array())
    {
        $cleanedDataArray = array();
        foreach ($data as $key => $val) {
            $cleanedDataArray[$key] = $this->cleanXssInject($val);
        }

        return $cleanedDataArray;
    }

    //---------------------------------

    /**
     * @Functionality :: Prevent XSS attack
     *
     * @param - Input (array) $data - Input array that needs to be filtered, output (array) $data Filtered array
     *
     * @copyright (c) 2016, Impelsys India Pvt. Ltd.
     * @author Srinivasu M <srinivasu.m@impelsys.com>
     *
     * Ref : https://gist.github.com/mbijon/1098477
     */
    public function cleanXssInject($data)
    {
        // Fix &entity\n;
        $data = str_replace(array('&amp;', '&lt;', '&gt;'), array('&amp;amp;', '&amp;lt;', '&amp;gt;'), $data);
        $data = preg_replace('/(&#*\w+)[\x00-\x20]+;/u', '$1;', $data);
        $data = preg_replace('/(&#x*[0-9A-F]+);*/iu', '$1;', $data);
        $data = html_entity_decode($data, ENT_COMPAT, 'UTF-8');

        // Remove any attribute starting with "on" or xmlns
        $data = preg_replace('#(<[^>]+?[\x00-\x20"\'])(?:on|xmlns)[^>]*+>#iu', '$1>', $data);

        // Remove javascript: and vbscript: protocols
        $data = preg_replace('#([a-z]*)[\x00-\x20]*=[\x00-\x20]*([`\'"]*)[\x00-\x20]*j[\x00-\x20]*a[\x00-\x20]*v[\x00-\x20]*a[\x00-\x20]*s[\x00-\x20]*c[\x00-\x20]*r[\x00-\x20]*i[\x00-\x20]*p[\x00-\x20]*t[\x00-\x20]*:#iu', '$1=$2nojavascript...', $data);
        $data = preg_replace('#([a-z]*)[\x00-\x20]*=([\'"]*)[\x00-\x20]*v[\x00-\x20]*b[\x00-\x20]*s[\x00-\x20]*c[\x00-\x20]*r[\x00-\x20]*i[\x00-\x20]*p[\x00-\x20]*t[\x00-\x20]*:#iu', '$1=$2novbscript...', $data);
        $data = preg_replace('#([a-z]*)[\x00-\x20]*=([\'"]*)[\x00-\x20]*-moz-binding[\x00-\x20]*:#u', '$1=$2nomozbinding...', $data);

        // Only works in IE: <span style="width: expression(alert('Ping!'));"></span>
        $data = preg_replace('#(<[^>]+?)style[\x00-\x20]*=[\x00-\x20]*[`\'"]*.*?expression[\x00-\x20]*\([^>]*+>#i', '$1>', $data);
        $data = preg_replace('#(<[^>]+?)style[\x00-\x20]*=[\x00-\x20]*[`\'"]*.*?behaviour[\x00-\x20]*\([^>]*+>#i', '$1>', $data);
        $data = preg_replace('#(<[^>]+?)style[\x00-\x20]*=[\x00-\x20]*[`\'"]*.*?s[\x00-\x20]*c[\x00-\x20]*r[\x00-\x20]*i[\x00-\x20]*p[\x00-\x20]*t[\x00-\x20]*:*[^>]*+>#iu', '$1>', $data);

        // Remove namespaced elements (we do not need them)
        $data = preg_replace('#</*\w+:\w[^>]*+>#i', '', $data);
        do {
            // Remove really unwanted tags
            $old_data = $data;
            $data = preg_replace('#</*(?:applet|b(?:ase|gsound|link)|embed|frame(?:set)?|i(?:frame|layer)|l(?:ayer|ink)|meta|object|s(?:cript|tyle)|title|xml)[^>]*+>#i', '', $data);
        } while ($old_data !== $data);

        return strip_tags($data);
    }

    public function select($tableName = null, $fields = array(), $condition = null)
    {
        if (isset($tableName)) {
            $tableExists = $this->TableExists($tableName);
            if ($tableExists) {
                if (count($fields) > 0) {
                    $tblFlds = null;
                    for ($i = 0; $i < count($fields); ++$i) {
                        $tblFlds .= trim($fields[$i]).', ';
                    }
                } else {
                    $tblFlds = '*';
                }

                $tblFlds = rtrim($tblFlds, ', ');

                if (isset($condition) && is_string($condition)) {
                    $condition = trim($condition);
                } else {
                    $condition = 1;
                }

                $query = 'SELECT '.$tblFlds.' FROM '.$tableName.' WHERE '.$condition;

                $returnData = null;
                $this->tpconn = $this->tpconnect();
                $result = $this->tpconn->query($query);

                while ($row = $result->fetch_assoc()) {
                    $returnData[] = $row;
                }
                mysqli_close($this->tpconn);

                return $returnData;
            }
        } else {
            return false;
        }
    }

    public function Testselect($tableName = null, $fields = array(), $condition = null)
    {
        if (isset($tableName)) {
            $tableExists = $this->TableExists($tableName);
            if ($tableExists) {
                if (count($fields) > 0) {
                    $tblFlds = null;
                    for ($i = 0; $i < count($fields); ++$i) {
                        $tblFlds .= trim($fields[$i]).', ';
                    }
                } else {
                    $tblFlds = '*';
                }

                $tblFlds = rtrim($tblFlds, ', ');

                if (isset($condition) && is_string($condition)) {
                    $condition = trim($condition);
                } else {
                    $condition = 1;
                }

                $query = 'SELECT '.$tblFlds.' FROM '.$tableName.' WHERE '.$condition;

                return $query;
            }
        } else {
            return false;
        }
    }

    public function insertDataInToTP($tableName = null, $insertArray = array())
    {
        if (isset($tableName) && count($insertArray) > 0) {
            $this->tpconn = $this->tpconnect();
            $tableExists = $this->TableExists($tableName);

            if ($tableExists) {
                $fields = $values = null;
                foreach ($insertArray as $fld => $val) {
                    $fields .= '`'.$fld.'`,';
                    $values .= ($val) ? "'".$val."', " : "'', ";
                }
                $fields = rtrim($fields, ',');
                $values = rtrim($values, ', ');
                $insertQuery = ' INSERT INTO '.$tableName.' ('.$fields.') VALUES ('.$values.')';
                //echo $insertQuery; exit;
                if ($this->tpconn->query($insertQuery)) {
                    $insert_id = $this->tpconn->insert_id;
                    mysqli_close($this->tpconn);

                    return $insert_id;
                } else {
                    return false;
                }
            }
        }
    }

    public function updateData($tableName, $updateData, $updateCondition)
    {
        if (isset($tableName) && count($updateData) > 0 && isset($updateCondition)) {
            $this->tpconn = $this->tpconnect();
            $tableExists = $this->TableExists($tableName);
            $updateData = $this->preventXssArray($updateData);
            if ($tableExists) {
                $flds = $vals = null;
                $updateQry = '';
                $updateFlds = null;
                foreach ($updateData as $updateKey => $updateVal) {
                    $updateFlds .= '`'.$updateKey."` = '".$updateVal."', ";
                }

                $updateFlds = rtrim($updateFlds, ', ');
                $updateQry = 'UPDATE '.$tableName.' SET '.$updateFlds.' WHERE '.$updateCondition;

                if ($this->tpconn->query($updateQry)) {
                    mysqli_close($this->tpconn);

                    return true;
                } else {
                    return false;
                }
            }
        }

        return false;
    }

    public function deleteData($tableName = null, $delCondition = null)
    {
        if ($tableName) {
            $this->tpconn = $this->tpconnect();
            $tableExists = $this->TableExists($tableName);
            if ($tableExists) {
                $delConditionValue = 1;
                if ($delCondition) {
                    $delConditionValue = trim($delCondition);
                }
                $deleteQry = 'DELETE FROM '.$tableName.' WHERE '.$delConditionValue;
                if ($this->tpconn->query($deleteQry)) {
                    mysqli_close($this->tpconn);

                    return true;
                } else {
                    return false;
                }
            }
        }

        return false;
    }

    public function TableExists($tableName = null)
    {
        $this->tpconn = $this->tpconnect();
        $sql = 'SELECT 1 FROM `'.$tableName.'` LIMIT 0';
        if ($this->tpconn->query($sql)) {
            return true;
        } else {
            return false;
        }
    }

    public function __destruct()
    {
        $tpconn = $this->tpconnect();
        $tpconn->close();
    }
}
