<?php
class ModelUniShopSetting extends Model {	
	public function getSetting() {
		$data = $this->cache->get('unishop.set.'.(int)$this->config->get('config_store_id'));
		
		if (!$data) {
			$data = array();
			
			$query = $this->db->query("SELECT data FROM ".DB_PREFIX."uni_setting");
			
			if($query->rows) {
				$data = json_decode($query->row['data'], true);
				$data = $data[$this->config->get('config_store_id')];
				$this->cache->set('unishop.set.'.(int)$this->config->get('config_store_id'), $data);
			}
		}
		
		return $data;
	}
}
?>