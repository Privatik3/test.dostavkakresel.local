<?php

//  Improved options / Расширенные опции
//  Support: support@liveopencart.com / Поддержка: help@liveopencart.ru

class ModelModuleImprovedOptions extends Model {

	public function installed() {
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "extension WHERE `type` = 'module' AND `code` = 'improvedoptions'");
		return $query->num_rows;
	
	}
	
	public function current_version() {
		
		return '2.0.9';
		
	}

  public function check_fields() {
    
    $query = $this->db->query("SHOW COLUMNS FROM `" . DB_PREFIX . "product_option_value` WHERE field='description' ");
		if (!$query->num_rows) {
			$this->db->query("ALTER TABLE `".DB_PREFIX."product_option_value` ADD COLUMN `description` text NOT NULL " );
		}
    
    $query = $this->db->query("SHOW COLUMNS FROM `" . DB_PREFIX . "product_option_value` WHERE field='sku' ");
		if (!$query->num_rows) {
			$this->db->query("ALTER TABLE `".DB_PREFIX."product_option_value` ADD COLUMN `sku` varchar(64) NOT NULL " );
		}
		
		$query = $this->db->query("SHOW COLUMNS FROM `" . DB_PREFIX . "product_option_value` WHERE field='upc' ");
		if (!$query->num_rows) {
			$this->db->query("ALTER TABLE `".DB_PREFIX."product_option_value` ADD COLUMN `upc` varchar(12) NOT NULL " );
		}
		
		$query = $this->db->query("SHOW COLUMNS FROM `" . DB_PREFIX . "product_option_value` WHERE field='model' ");
		if (!$query->num_rows) {
			$this->db->query("ALTER TABLE `".DB_PREFIX."product_option_value` ADD COLUMN `model` varchar(64) NOT NULL " );
		}
		
		$query = $this->db->query("SHOW COLUMNS FROM `" . DB_PREFIX . "product_option_value` WHERE field='reward' ");
		if (!$query->num_rows) {
			$this->db->query("ALTER TABLE `".DB_PREFIX."product_option_value` ADD COLUMN `reward` int(8) NOT NULL " );
		}
		
		$query = $this->db->query("SHOW COLUMNS FROM `" . DB_PREFIX . "product_option_value` WHERE field='reward_prefix' ");
		if (!$query->num_rows) {
			$this->db->query("ALTER TABLE `".DB_PREFIX."product_option_value` ADD COLUMN `reward_prefix` varchar(1) NOT NULL " );
		}
		
		$query = $this->db->query("SHOW COLUMNS FROM `" . DB_PREFIX . "product_option_value` WHERE field='default_select' ");
		if (!$query->num_rows) {
			$this->db->query("ALTER TABLE `".DB_PREFIX."product_option_value` ADD COLUMN `default_select` tinyint(1) NOT NULL " );
		}
		
		$query = $this->db->query("SHOW COLUMNS FROM `" . DB_PREFIX . "order_product` WHERE field='sku' ");
		if (!$query->num_rows) {
			$this->db->query("ALTER TABLE `".DB_PREFIX."order_product` ADD COLUMN `sku` varchar(64) NOT NULL " );
		}
		
		$query = $this->db->query("SHOW COLUMNS FROM `" . DB_PREFIX . "order_product` WHERE field='upc' ");
		if (!$query->num_rows) {
			$this->db->query("ALTER TABLE `".DB_PREFIX."order_product` ADD COLUMN `upc` varchar(12) NOT NULL " );
		}
		
		$query = $this->db->query("SHOW COLUMNS FROM `" . DB_PREFIX . "order_product` WHERE field='model' ");
		if (!$query->num_rows) {
			$this->db->query("ALTER TABLE `".DB_PREFIX."order_product` ADD COLUMN `model` varchar(64) NOT NULL " );
		}
		
  }
	
	 public function getSettings() {
		
		$std_settings = array('sku_for_options', 'upc_for_options', 'model_for_options', 'reward_for_options', 'description_for_options', 'auto_selection', 'step_by_step');
		
		$settings = $this->config->get('improvedoptions_settings');
		
		foreach ($std_settings as $setting_name) {
			
			if (!isset($settings[$setting_name])) {
				$settings[$setting_name] = false;
			}
			
		}
		
		$settings['installed'] = $this->installed();
		if (!$settings['installed']) {
			foreach ($settings as $setting_name => &$setting) {
				if ($setting_name != 'installed') {
					$setting = false;
				}
			}
			unset($setting);
		}
		
		return $settings;
		
	}
	
	public function additional_columns_count() {
		
		$cnt = 0;
		
		$module_settings = $this->config->get('improvedoptions_settings');
		if ($module_settings && is_array($module_settings) ) {
			
			if (isset($module_settings['sku_for_options']) && $module_settings['sku_for_options']) {
				$cnt++;
			}
			if (isset($module_settings['upc_for_options']) && $module_settings['upc_for_options']) {
				$cnt++;
			}
			if (isset($module_settings['model_for_options']) && $module_settings['model_for_options']) {
				$cnt++;
			}
			if (isset($module_settings['reward_for_options']) && $module_settings['reward_for_options']) {
				$cnt++;
			}
			if (isset($module_settings['description_for_options']) && $module_settings['description_for_options']) {
				$cnt++;
			}
			if (isset($module_settings['auto_selection']) && $module_settings['auto_selection'] > 1) {
				$cnt++;
			}
			
		}
		
		
		return $cnt;
		
	}
	
	
  
  public function save_fields($product_option_value_id, $product_option_value) {
    //die('tmp: ' . $product_option_value_id);
    if ( isset($product_option_value['sku']) || isset($product_option_value['model']) || isset($product_option_value['upc'])
		|| isset($product_option_value['reward']) || isset($product_option_value['reward_prefix'])
		|| isset($product_option_value['default_select']) || isset($product_option_value['description']) ) {
    
      $this->check_fields();
			
			$set_arr = array();
			if (isset($product_option_value['sku'])) {
				$set_arr[] = "sku = '" . $this->db->escape((string)$product_option_value['sku'])."'";
			}
			if (isset($product_option_value['upc'])) {
				$set_arr[] = "upc = '" . $this->db->escape((string)$product_option_value['upc'])."'";
			}
			if (isset($product_option_value['model'])) {
				$set_arr[] = "model = '" . $this->db->escape((string)$product_option_value['model'])."'";
			}
			if (isset($product_option_value['reward'])) {
				$set_arr[] = "reward = '" . (int)$product_option_value['reward']."'";
			}
			if (isset($product_option_value['reward_prefix'])) {
				$set_arr[] = "reward_prefix = '" . $this->db->escape((string)$product_option_value['reward_prefix'])."'";
			}
			if (isset($product_option_value['description'])) {
				$set_arr[] = "description = '" . $this->db->escape((string)$product_option_value['description'])."'";
			}
			$set_arr[] = "default_select = " . (isset($product_option_value['default_select'])?(int)$product_option_value['default_select']:0) ." ";
      
      $this->db->query("UPDATE " . DB_PREFIX . "product_option_value
                        SET " .implode(",", $set_arr) ."
                        WHERE product_option_value_id = ".(int)$product_option_value_id."
                      ");
			
			$this->reinsert_product_option_value($product_option_value_id);
			
    }
  }
  
	
	private function reinsert_product_option_value($product_option_value_id) {
        
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_option_value WHERE product_option_value_id = ".(int)$product_option_value_id." ");
		if ( $query->num_rows ) {
			
			$sql_set = "";
			foreach ($query->row as $key => $value) {
				$sql_set .= ", `".$key."` = '".$this->db->escape($value)."' ";
			}
			$sql_set = substr($sql_set, 1);
			$this->db->query("DELETE FROM ".DB_PREFIX."product_option_value WHERE product_option_value_id = ".$product_option_value_id." ");
			$this->db->query("INSERT INTO ".DB_PREFIX."product_option_value SET ".$sql_set);
		}
	
	}

}
