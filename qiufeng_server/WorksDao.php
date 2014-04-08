<?php

include_once ('ProjectBean.php');
class WorksDao 
{
	private static $_sharedWorksDao = null;

	private $con;
	private $isConnect;
	private $worksArray;
	public static function sharedWorksDao() 			//单例失效？  why？ 难道在传送完网页以后 就被销毁了？
	{
		if (self::$_sharedWorksDao == null) {
			self::$_sharedWorksDao = new WorksDao();
		}
		return self::$_sharedWorksDao;
	}
	
	public function _construct() 
	{
	}
	
	private function connectDatabase() 
	{
		if ($this->isConnect == true)  return;
		$this->con = mysql_connect ("127.0.0.1", "tac", "tongjiappleclub" );
		if (! $this->con) {
			die ( 'Could not connect: ' . mysql_error () );
		}
		$this->isConnect = true;
	}
	
	private function closeDatabase() 
	{
		mysql_close ( $this->con );
		$this->isConnect = false;
	}
	
	public function getAllData() 
	{
		if ($this->worksArray!=null)		
		{
			return $this->worksArray;
		}
		$this->worksArray=array();
		
		$this->connectDatabase();
		mysql_select_db ("QiuFeng", $this->con );
		 mysql_query("SET NAMES 'utf8'");
		$result = mysql_query ("select * from Projects",$this->con);
		
		while ( $row = mysql_fetch_array ( $result ) ) 
		{
			$work=new ProjectBean();

			$work->setProjectID($row['id']);

			$work->setName($row['name']);
	
			$work->setDescription($row['description']);
			$work->setIcon($row['iconAddress']);
		
	
			$work->setItunesLink($row['itunes']);
			array_unshift($this->worksArray,$work);
		}	
		$this->closeDatabase();
		return $this->worksArray;
	}
}
?>
