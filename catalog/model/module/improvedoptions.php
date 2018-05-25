<?php
//  Improved options / Расширенные опции
//  Support: support@liveopencart.com / Поддержка: help@liveopencart.ru

class ModelModuleImprovedOptions extends Model {

  public function getThemeName() {
    if ( VERSION >= '2.2.0.0' ) {
      if ($this->config->get('config_theme') == 'theme_default') {
        return $this->config->get('theme_default_directory');
      } else {
        return substr($this->config->get('config_theme'), 0, 6) == 'theme_' ? substr($this->config->get('config_theme'), 6) : $this->config->get('config_theme') ;
      }
    } else {  
      return $this->config->get('config_template');
    }
  }

  public function installed() {
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "extension WHERE `type` = 'module' AND `code` = 'improvedoptions'");
		return $query->num_rows;
    
  }

  private function arrayDeleteEmpty($arr) {
    
    $new_arr = array();
    foreach ($arr as $key => $val) {
      if ($val) {
        $new_arr[$key] = $val;
      }
    }
    
    return $new_arr;
  }

  
  private function getProductReward($product_id) {
    $query = $this->db->query(" SELECT points
                                FROM " . DB_PREFIX . "product_reward pr
                                WHERE pr.product_id = '".(int)$product_id."'
                                  AND customer_group_id = '".(int)$this->config->get('config_customer_group_id')."'");
    if ( $query->num_rows ) {
      return $query->row['points'];
    } else {
      return 0;
    }
  }
	
	public function getReward($product_id, $options) {
		
		$value = 0;
		
		if (!$product_id) return "-";
		
		$value = $value + $this->getProductReward($product_id);
		
		if (!$this->installed()) return $value;
		
		$settings = $this->getSettings();
		
		if ($settings['reward_for_options']) {
			
			$values_data = $this->getOptionsValuesData($product_id, $options);
		
			if (!$values_data) return $value;
			
			foreach ($values_data as $row) {
				if ($row['reward']!=0) {
					
					if ($row['reward_prefix'] == '=') {
						$value = $row['reward'];
					} elseif ($row['reward_prefix'] == '+') {
						$value+= $row['reward'];
					} elseif ($row['reward_prefix'] == '-') {
						$value-= $row['reward'];
					}	
					
				}
			}
			
		}
		
		
		return $value;
		
	}
	
	public function getAllProductOptionsValuesData($product_id) {
		
		$query = $this->db->query(" SELECT POV.*
																FROM `" . DB_PREFIX . "product_option_value` POV
																		,`" . DB_PREFIX . "option` O
																		,`" . DB_PREFIX . "option_value` OV
																WHERE POV.product_id=".(int)$product_id."
																	AND POV.option_id = O.option_id
																	AND POV.option_value_id = OV.option_value_id
																ORDER BY O.sort_order ASC, O.option_id ASC, OV.sort_order ASC, OV.option_value_id ASC
																");
		$fields_to_return = array('sku', 'model', 'upc', 'reward_prefix', 'reward', 'product_option_value_id');
		$results = array();
		foreach ( $query->rows as $row ) {
			$result = array();
			foreach ( $fields_to_return as $field_to_return ) {
				$result[$field_to_return] = isset($row[$field_to_return]) ? $row[$field_to_return] : '' ;
			}
			$results[] = $result;
		}
		
		return $query->rows;
	}
	
	private function getOptionsValuesData($product_id, $options) {
		
		$options = $this->arrayDeleteEmpty($options);
			
		$product_options_ids = array();
		foreach ($options as $product_option_id => $option_value) {
			$product_options_ids[] = (int)$product_option_id;
		}
		
		if (count($product_options_ids) == 0) return false;
		
		// get compatible options
		$query = $this->db->query(" SELECT PO.product_option_id
																FROM `" . DB_PREFIX . "product_option` PO
																		,`" . DB_PREFIX . "option` O
																WHERE PO.product_option_id IN (". implode(",",$product_options_ids) .")
																	AND PO.option_id = O.option_id
																	AND O.type IN ('select','radio','image', 'checkbox', 'block', 'color', 'multiple')
																");
		
		if (!$query->num_rows) return false;
		
		// only compatible options
		$selected_values = array();
		foreach ($query->rows as $row) {
			if ( isset($options[$row['product_option_id']]) && $options[$row['product_option_id']] ) {
				
				if ($options[$row['product_option_id']]) {
					if (is_array($options[$row['product_option_id']])) {
						
						foreach ($options[$row['product_option_id']] as $product_option_value_id) {
							if ($product_option_value_id) {
								$selected_values[] = (int)$product_option_value_id;
							}
						}
						
					} else {
						$selected_values[] = (int)$options[$row['product_option_id']]; //product_option_value_id
					}
				}
			}
		}
		
		
		if (count($selected_values) == 0) return false;
		
		$query = $this->db->query(" SELECT POV.*
																	FROM `" . DB_PREFIX . "product_option_value` POV
																			,`" . DB_PREFIX . "option` O
																			,`" . DB_PREFIX . "option_value` OV
																	WHERE POV.product_id=".(int)$product_id."
																		AND POV.option_id = O.option_id
																		AND POV.option_value_id = OV.option_value_id
																		AND POV.product_option_value_id IN (". implode(",",$selected_values) .")
																	ORDER BY O.sort_order ASC, O.option_id ASC, OV.sort_order ASC, OV.option_value_id ASC
																	");
		
		return $query->rows;
		
	}
  
	public function ro_installed() {
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "extension WHERE `type` = 'module' AND `code` = 'related_options'");
		return $query->num_rows;
	
	}
	
  public function getSKU($product_id, $options, $field_name='sku') {
    
    $value = "";
    
    if (!$product_id) return "-";
		
		
    
    $query = $this->db->query(" SELECT P.".$field_name." FROM `" . DB_PREFIX . "product` P WHERE product_id=".(int)$product_id." ");
    if (!$query->num_rows) {
			if (isset($this->session->data['oe']['custom_product'])) { // compatibility with Order Entry system
				foreach ($this->session->data['oe']['custom_product'] as $cart_id => $value) {
					if ($value['product_id'] == $product_id) {
						return $value[$field_name];
					}
				}
			} else {
				return "-";
			}
		}
    
    $value = $query->row[$field_name];
		
		if ($this->ro_installed()) {
			
			$ro_options = array();
			foreach ($options as $product_option_id => $product_option_values) {
				if ($product_option_values) {
					if (is_array($product_option_values)) {
						$ro_options[$product_option_id] = $product_option_values[0];
					} else {
						$ro_options[$product_option_id] = $product_option_values;
					}
				}
			}
			
			$ro_settings = $this->config->get('related_options');
			if ( ($field_name == 'model' || $field_name == 'sku' || $field_name == 'upc')
			&& ( !empty($ro_settings['spec_model']) || !empty($ro_settings['spec_sku']) || !empty($ro_settings['spec_upc']) ) ) {
        if ( !$this->model_module_related_options ) {
          $this->load->model('module/related_options');
        }
				
				if ( method_exists( 'ModelModuleRelatedOptions', 'get_related_options_set_by_poids' ) ) { // related options
					$product_ro = $this->model_module_related_options->get_related_options_set_by_poids($product_id, $ro_options);
					
					if ($product_ro) {
						
						if ($field_name == 'model' && isset($ro_settings['spec_model']) && $ro_settings['spec_model'] && $product_ro['model']) {
							$value = $product_ro['model'];
						}
						if ($field_name == 'sku' && isset($ro_settings['spec_sku']) && $ro_settings['spec_sku'] && $product_ro['sku']) {
							$value = $product_ro['sku'];
						}
						if ($field_name == 'upc' && isset($ro_settings['spec_upc']) && $ro_settings['spec_upc'] && $product_ro['upc']) {
							$value = $product_ro['upc'];
						}
					}
				} else if ( method_exists( 'ModelModuleRelatedOptions', 'get_related_options_model_sku' ) ) { // Related Options PRO
					
					$ro_model = '';
					$ro_sku = '';
					$ro_upc = '';
					$current_model = isset($query->row['model']) ? $query->row['model'] : '' ;
					$current_sku = isset($query->row['sku']) ? $query->row['sku'] : '';
					$current_upc = isset($query->row['upc']) ? $query->row['upc'] : '';
					$ro_values = $this->model_module_related_options->get_related_options_model_sku($product_id, $ro_options, $current_model, $current_sku);
					
					if ( !empty($ro_settings['spec_'.$field_name]) && !empty($ro_values[$field_name]) ) {
						$value = $ro_values[$field_name];
					}
					
				}
			}
		}
		
    
    if (!$this->installed()) return $value;
		
		$settings = $this->getSettings();
    $current_setting = $settings[$field_name.'_for_options'];
		
		if (!$current_setting) return $value;
    
    $values_data = $this->getOptionsValuesData($product_id, $options);
    
		if (!$values_data) return $value;
			
		if ($current_setting == 1) {
			
			foreach ($values_data as $row) {
				if ( trim($row[$field_name]) != '' ) {
					return $row[$field_name];
				}
			}
			
		} elseif ($current_setting == 2) {	
			
			foreach ($values_data as $row) {
				if ( trim($row[$field_name]) != '' ) {
					$value .= $row[$field_name];
				}
			}
		}	
			
		return $value;
		
  }
  

  public function getSettings() {
		
		$std_settings = array('model_for_options', 'sku_for_options', 'upc_for_options', 'reward_for_options', 'description_for_options', 'auto_selection', 'step_by_step');
		
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
	
	public function getAdditionalFieldForCart($product, $field_name='sku', $default_value='') {
		
		// compatibility with Order Entry system
		if ( isset($product['cart_id']) && isset($this->session->data['oe']['custom_product'][$product['cart_id']]) && isset($product[$field_name]) ) { 
			return $product[$field_name];
		}
		
		$product_id = isset($product['product_id']) ? $product['product_id'] : 0;
		$options = isset($product['option']) ? $product['option'] : array();
		
		if ( !$default_value && isset($product[$field_name]) ) {
			$default_value = $product[$field_name];
		}
		
		return $this->getSKU_ForCart($product_id, $options, $field_name, $default_value);
	}

  private function getSKU_ForCart($product_id, $cart_options, $field_name='sku', $default_value='') {
    
		$settings = $this->getSettings();
		
		// sku or model
		if ( !$settings[$field_name.'_for_options'] ) {
			return $default_value;
		}
		
    $options = array();
    if ($cart_options && is_array($cart_options) )  {
      foreach ($cart_options as $cart_option) {
        if ( !empty($cart_option['product_option_value_id']) ) {
          if ( !isset($options[$cart_option['product_option_id']]) ) {
            $options[$cart_option['product_option_id']] = array();
          }
          $options[$cart_option['product_option_id']][] = $cart_option['product_option_value_id'];
        }
      }
    }
    
    return $this->getSKU($product_id, $options, $field_name);
    
  }

  
  public function saveSKU_ForOrder($product_id, $cart_options, $order_product_id, $field_name='sku') {
    
    if ($this->installed()) {
			
			$settings = $this->getSettings();
			
			if ($settings[$field_name.'_for_options']) {
			
				$field_value = $this->getSKU_ForCart($product_id, $cart_options, $field_name);
			
				$this->db->query("UPDATE `" . DB_PREFIX . "order_product` SET `".$field_name."` = '".$this->db->escape($field_value)."' WHERE order_product_id=".(int)$order_product_id." ");
				
			}
    
    }
    
  }
  

	public function getProductDefaultOptions($product_id) {
		
		$options = array();// product_option_id => product_option_value_id
		
		if ($this->installed()) {
		
			$settings = $this->getSettings();
			
			if (!empty($settings['auto_selection'])) {
				
				if (!$this->model_catalog_product) {
					$this->load->model('catalog/product');
				}
				
				$product_options = $this->model_catalog_product->getProductOptions($product_id);
				
				foreach ($product_options as $product_option) {
					
					if ($product_option['product_option_value']) {
					
						$product_option_id = $product_option['product_option_id'];
						
						if ($settings['auto_selection'] == 2 || $settings['auto_selection'] == 3) {
							
							// get defaults
							foreach ($product_option['product_option_value'] as $product_option_value) {
								if (!empty($product_option_value['default_select'])) {
									if ($product_option['type'] == 'checkbox') {
										if (empty($options[$product_option_id])) {
											$options[$product_option_id] = array();
										}
										$options[$product_option_id][] = $product_option_value['product_option_value_id']; 
									} else {
										$options[$product_option_id] = $product_option_value['product_option_value_id'];
										break;
									}
								}
							}
						}
						if ($settings['auto_selection'] == 1 || $settings['auto_selection'] == 2 && empty($options[$product_option_id])) {
							// get first values
							$options[$product_option_id] = $product_option['product_option_value'][0]['product_option_value_id'];
						}
					}
				}
			}
		}
		return $options;
	}
	
	
}