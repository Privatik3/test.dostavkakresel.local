<?php
class ModelExtensionModuleAddictive extends Model {

	public function uninstall() {
	     if ($this->mysql_table_seek(DB_PREFIX.'addictive_service')>0){	
		 $this->db->query("DROP table `" . DB_PREFIX . "addictive_service`");
		}
	}

	public function install() {
		$query = $this->db->query("CREATE TABLE IF NOT EXISTS `".DB_PREFIX."addictive_service` (
                                  `id` int(11) NOT NULL AUTO_INCREMENT,
                                  `category_id` int(11) NOT NULL,
                                  `service_name` varchar(254) NOT NULL,
                                  `service_price` decimal(10,2) NOT NULL,
                                  `service_new_price` decimal(10,2) NOT NULL,
                                  `description` text NOT NULL,
								  `_order` int(11),
								  `show_description` int(11),
								  `show_tooltip` int(11),
								  `tooltip` varchar(254) NOT NULL,
                                   PRIMARY KEY (`id`)
                                   ) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ; ");
	}
	public function getService($category_id){
      $query = $this->db->query('select * from '.DB_PREFIX.'addictive_service where category_id = '.$category_id);
      return $query->rows;	  
	}
	private function mysql_table_seek($tablename){
     $rslt = $this->db->query("SHOW TABLES FROM `".DB_DATABASE."` LIKE '" . $tablename. "';");
     return count($rslt->rows);
    }
	public function getServices(){
		$query = $this->db->query('select * from `'.DB_PREFIX.'addictive_service` order by _order');
		return $query->rows;
	}
	public function UpdateServices($category_id, $data){
		$this->db->query('delete from '.DB_PREFIX.'addictive_service where category_id = '.$category_id);
		$sql = array();
		foreach($data as $item){
			$this->db->query('insert into '.DB_PREFIX.'addictive_service(category_id, service_name, service_price, service_new_price, description) 
			                  values('.$item['category_id'].', "'.$item['name'].'", '.$item['price'].', '.$item['new_price'].', "'.$item['description'].'")');
		}
	}
	public function insertServices($data){
		foreach($data as $item){
			if ((isset($item['show_description']))&&($item['show_description'] == 'on')) $show_description = 1; else $show_description = 0;
			if ((isset($item['tooltip']))&&($item['tooltip'] == 'on')) $tooltip = 1; else $tooltip = 0;
			$this->db->query('insert into '.DB_PREFIX.'addictive_service(category_id, service_name, service_price, service_new_price, description, show_description, show_tooltip, _order, tooltip) values('.$item['category_id'].', "'.$item['name'].'", '.$item['price'].', '.$item['new_price'].', "'.$item['description'].'", '.$show_description.', '.$tooltip.', '.$item['order'].', "'.$item['tooltip_content'].'")');
		}
	  return true;
	}
	
	public function deleteServices($category_id){
		$this->db->query('delete from '.DB_PREFIX.'addictive_service where category_id = '.$category_id);
	}
	
}
?>