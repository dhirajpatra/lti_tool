<?php

include('../library/config.php');
class TcDatabase {
	
	private $host = NULL;
	private $username = NULL;
	private $password = NULL;
	private $database = NULL;
	private $tcconnect = NULL;
	
	
	function __construct() {
		$this->host 	= TC_LOCALHOST;
		$this->username = TC_USERNAME;
		$this->password = TC_PASSWORD;
		$this->database = TC_DATABASE;
		$tcconnect = false;
	}
	
	
	public function connect() {
		$tcconnect = new mysqli($this->host, $this->username, $this->password, $this->database);
		if (!$tcconnect) {
			echo "Failed to connect to Database ".mysql_connect_error()." <br/>"; 
			die;
		} 
		return $tcconnect;
	}
	
	
	public function selectquery($tableName = NULL, $fields = array(), $condition = NULL) {
		if(isset($tableName)) {
			$tableExists = $this->TableExists($tableName);
			if($tableExists) {
				if(count($fields) > 0){
					$tblFlds = NULL;
					for($i = 0; $i < count($fields); $i++){
						$tblFlds .= trim($fields[$i]).", ";
					}
				} else {
					$tblFlds = '*';
				}
				
				$tblFlds = rtrim($tblFlds,", ");
				
				if(isset($condition) && is_string($condition)) {
					$condition = trim($condition);
				}else{
					$condition = 1;
				}
				
				$query = "SELECT ".$tblFlds." FROM ".$tableName." WHERE ".$condition;
				$returnData = NULL;
				$tcconnect = $this->connect();
				$data = $tcconnect->query($query);
				$returnData = $data->fetch_assoc();
				mysqli_close($tcconnect);
				return $returnData; 
			}
		} else {
				return false;
		}
	}
	
        
        public function insertDataInToTC($tableName = NULL,$insertArray = array()) {
		
            if ( isset($tableName) && count($insertArray) > 0 ) {
                $tcconnect = $this->connect();
                $tableExists = $this->TableExists($tableName);

                if($tableExists) {
                        $fields = $values = NULL;
                        foreach($insertArray AS $fld=>$val) {
                                        $fields .= "`".$fld."`,";
                                        $values .= ($val)?$val.", ":"'', ";
                        }
                        $fields = rtrim($fields, ",");
                        $values = rtrim($values, ", ");
                        $insertQuery = " INSERT INTO ".$tableName. " (".$fields. ") VALUES (".$values.")";
                        
                        if( $tcconnect->query($insertQuery) ){
                                return $tcconnect->insert_id;
                        } else {
                                return FALSE;
                                //return $tcconnect->error;
                        }
                }
            }
		
	}
        
        public function updateDataInToTC($tableName = NULL, $updateArray = array(), $condition=NULL){
            if ( isset($tableName) && count($updateArray) > 0 ) {
                $tcconnect = $this->connect();
                $tableExists = $this->TableExists($tableName);
                if($tableExists){
                    $updateData =  NULL;
                    if(empty($condition)){
                        $condition = 1;
                    }
                    
                    foreach($updateArray AS $fld=>$val) {
                        $updateData .= "`".$fld."` = '".$val."', ";
                    }
                    $updateData = rtrim($updateData, ", ");
                    $updateQuery = " UPDATE ".$tableName. " SET ".$updateData." WHERE ".$condition;
                    if( $tcconnect->query($updateQuery) ){
                            return true; //$tcconnect->insert_id;
                    } else {
                            return FALSE;
                            //return $tcconnect->error;
                    }
                }
            }
        }

        public function TableExists($table) {
		
		$tcconnect = $this->connect();
		$sql = 'SELECT 1 FROM `'. $table.'` LIMIT 0'; 
		if( $tcconnect->query($sql) ) 
		{
			return TRUE;
		} else {
			return FALSE;
		}
	}
	
	function __destruct() {
		$tcconnect = $this->connect();
		$tcconnect->close();
	} 
	
} 
?>
