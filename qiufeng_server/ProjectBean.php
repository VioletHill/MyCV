<?php
class ProjectBean {
	private $projectID;
	private $name;
	private $icon;
	private $description;
	private $itunesLink;
	
	public function _construct()
	{
	}
	
	/**
	 * @return the $itunsLink
	 */
	public function getItunesLink() {
		return $this->itunesLink;
	}

	/**
	 * @param field_type $itunsLink
	 */
	public function setItunesLink($itunesLink) {
		$this->itunesLink = $itunesLink;
	}


	/**
	 *
	 * @return the $workID
	 */
	public function getProjectID() {
		return $this->projectID;
	}
	
	/**
	 *
	 * @return the $name
	 */
	public function getName() {
		return $this->name;
	}
	
	/**
	 *
	 * @return the $icon
	 */
	public function getIcon() {
		return $this->icon;
	}
	
	/**
	 *
	 * @return the $Description
	 */
	public function getDescription() {
		return $this->description;
	}
	
	/**
	 *
	 * @param field_type $workID        	
	 */
	public function setProjectID($projectID) {
		$this->projectID = $projectID;
	}
	
	/**
	 *
	 * @param field_type $name        	
	 */
	public function setName($name) {
		$this->name = $name;
	}
	
	/**
	 *
	 * @param field_type $icon        	
	 */
	public function setIcon($icon) {
		$this->icon = $icon;
	}
	
	/**
	 *
	 * @param field_type $Description        	
	 */
	public function setDescription($description) {
		$this->description = $description;
	}
	
	public function toJson(){
		return urldecode (json_encode( array("projectID"=>$this->projectID,"name"=>urlencode($this->name),"iconAddress"=>urlencode($this->icon),"description"=>urlencode($this->description),"itunesLink"=>urlencode($this->itunesLink)  ) ) );
	}
}


?>