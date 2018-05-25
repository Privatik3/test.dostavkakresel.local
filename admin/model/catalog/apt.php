<?php
class ModelCatalogApt extends Model {
	public function addTab($data) {
		//$product_id = $this->db->getLastId();
		$q = $this->db->query("select product_id from " . DB_PREFIX . "product order by product_id desc limit 1");
		$product_data = $q->row;
		$product_id = $product_data['product_id'];
		### Additional product tabs -start ###
		if (isset($data['product_apt_name'])) {
			$this->db->query("DELETE FROM " . DB_PREFIX . "product_apt WHERE product_id = '" . (int)$product_id . "'");
			foreach($data['product_apt_name'] as $key => $value)
			{
				$q =$this->db->query("SELECT language_id FROM " . DB_PREFIX . "language WHERE code = '" . $key . "'");
				$language_data = $q->row;
				$language_id = $language_data['language_id'];
				
				$j=0;
				
				for($i=0;$i<count($data['product_apt_name'][$key]);$i++)
				{
					$j++;
					if(!isset($data['tab_sort_order']))
					{
						$sort_order=$j;
					}
					else
					{
						$sort_order=$data['tab_sort_order'][$key][$i];
					}
								
					$this->db->query("INSERT INTO " . DB_PREFIX . "product_apt (`product_id`,`language_id`,`tab_title`,`tab_desc`,`sort_order`) VALUES('" . $product_id ."','".$language_id."','".$this->db->escape($data['product_apt_name'][$key][$i])."','".$this->db->escape($data['product_apt_desc'][$key][$i])."','".$sort_order."')");
					
				}
				
			}
		}
		
		### Additional product tabs -end ###
		
	}
	public function editTab($product_id, $data) {
		### Additional product tabs -start ###
		if (isset($data['product_apt_name'])) {
			$this->db->query("DELETE FROM " . DB_PREFIX . "product_apt WHERE product_id = '" . (int)$product_id . "'");
			
			foreach($data['product_apt_name'] as $key => $value)
			{
				$q =$this->db->query("SELECT language_id FROM " . DB_PREFIX . "language WHERE code = '" . $key . "'");
				$language_data = $q->row;
				$language_id = $language_data['language_id'];
				
				$j=0;
				
				for($i=0;$i<count($data['product_apt_name'][$key]);$i++)
				{
					$j++;
					if(!isset($data['tab_sort_order']))
					{
						$sort_order=$j;
					}
					else
					{
						$sort_order=$data['tab_sort_order'][$key][$i];
					}
					
					$this->db->query("INSERT INTO " . DB_PREFIX . "product_apt (`product_id`,`language_id`,`tab_title`,`tab_desc`,`sort_order`) VALUES('" . $product_id ."','".$language_id."','".$this->db->escape($data['product_apt_name'][$key][$i])."','".$this->db->escape($data['product_apt_desc'][$key][$i])."','".$sort_order."')");
					
				}
				
			}
		}
		else
		{
			$this->db->query("DELETE FROM " . DB_PREFIX . "product_apt WHERE product_id = '" . (int)$product_id . "'");
		}
		### Additional product tabs -end ###
		
	}
	
	public function getTabData($product_id) {
		//$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_apt WHERE product_id = '" . (int)$product_id . "' AND language_id = '" . (int)$this->config->get('config_language_id') . "' ");
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_apt WHERE product_id = '" . (int)$product_id . "'");		
		return $query->rows;
	}
	
	public function getLangCode($language_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "language WHERE language_id = '" . (int)$language_id . "'");
				
		return $query->rows;
	}
	public function getProductTabName($product_id) {
		$product_description_tab_data = array();
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_apt WHERE product_id = '" . (int)$product_id . "'");
		
		foreach ($query->rows as $result) {
			$product_description_tab_data[$result['language_id']] = array(
				'tab_title'             => $result['tab_title']
			);
		}
		
		return $product_description_tab_data;
	}
	public function getProductTabDescriptions($product_id) {
		$product_description_tab_data = array();
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_apt WHERE product_id = '" . (int)$product_id . "'");
		
		foreach ($query->rows as $result) {
			$product_description_tab_data[$result['language_id']] = array(
				'tab_desc'      => $result['tab_desc']
			);
		}
		
		return $product_description_tab_data;
	}
	public function getProductTabSortOrder($product_id) {
		$product_description_tab_data = array();
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_apt WHERE product_id = '" . (int)$product_id . "'");
		
		foreach ($query->rows as $result) {
			$product_description_tab_data[$result['language_id']] = array(
				'sort_order'      => $result['sort_order']
			);
		}
		
		return $product_description_tab_data;
	}
	
}
?>