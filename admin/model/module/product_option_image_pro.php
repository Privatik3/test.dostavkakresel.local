<?php
//  Product Option Image PRO / Изображения опций PRO
//  Support: support@liveopencart.com / Поддержка: help@liveopencart.ru

class ModelModuleProductOptionImagePro extends Model {
  
  
  public function deleteAllImages() {
    $this->db->query("DELETE FROM ".DB_PREFIX."poip_option_image ");
  }
  
  // << reading calculated settings
  public function getOptionSettings($product_option_id) {
    
    if (!$this->installed()) return array();
    
    $query = $this->db->query(" SELECT PMOS.*, PS.product_option_id
                                FROM ".DB_PREFIX."poip_main_option_settings PMOS, ".DB_PREFIX."product_option PS
                                WHERE PS.product_option_id = ".(int)$product_option_id."
                                  AND PS.option_id = PMOS.option_id
                                ");
    
    if ($query->num_rows) {
      return $query->row;
    }
    
    return array();
    
  }
  
  public function current_version() {
    return '2.2.0';
  }
  
  public function getOptionsForImages($product_id) {
    
    if ( !$this->installed() ) return;
    
    $query = $this->db->query(" SELECT POIP.*, PO.option_id, POV.option_value_id
                                FROM  ".DB_PREFIX."poip_option_image POIP
                                    , ".DB_PREFIX."product_option PO
                                    , ".DB_PREFIX."product_option_value POV
                                WHERE POIP.product_id = ".(int)$product_id."
                                  AND POIP.product_option_id = PO.product_option_id
                                  AND POIP.product_option_value_id = POV.product_option_value_id
                                ORDER BY sort_order ");
    
    $images = array();
    foreach ($query->rows as $row) {
      
      if ( !isset($images[$row['image']]) ) {
        $images[$row['image']] = array();
      }
      if ( !isset($images[$row['image']][$row['option_id']]) ) {
        $images[$row['image']][$row['option_id']] = array();
      }
      
      if ( !in_array($row['option_value_id'], $images[$row['image']][$row['option_id']]) ) {
        $images[$row['image']][$row['option_id']][] = $row['option_value_id'];
      }
      
    }
    
    return $images;
    
  }
  // new
  public function saveOptionsForImages($product_id, $product_images) {
    
    if (!$this->installed()) return;
    $poip_global_settings = $this->getGlobalSettings();
    if ($poip_global_settings['options_images_edit'] != 1) return;
    
    $this->deleteProductOptionValueImages($product_id);
    
    $query = $this->db->query(" SELECT PO.product_option_id, PO.option_id, POV.product_option_value_id, POV.option_value_id
                                FROM  ".DB_PREFIX."product_option PO
                                    , ".DB_PREFIX."product_option_value POV
                                WHERE PO.product_id = ".(int)$product_id."
                                  AND POV.product_option_id = PO.product_option_id
                                ");
    $product_options = array();
    foreach ($query->rows as $row) {
      if ( !isset($product_options[$row['option_id']]) ) {
        $product_options[$row['option_id']] = array();
        $product_options[$row['option_id']]['values'] = array();
      }
      
      $product_options[$row['option_id']]['product_option_id'] = $row['product_option_id'];
      $product_options[$row['option_id']]['values'][$row['option_value_id']] = $row['product_option_value_id'];
      
    }
    
    
    
    foreach ($product_images as $product_image) {
      
      if ( isset($product_image['poip']) && $product_image['poip'] ) {
        
        foreach ($product_image['poip'] as $option_id => $option_values) {
          
          foreach ($option_values as $option_value_id) {
            
            if ( !empty( $product_options[$option_id]['values'][$option_value_id] ) ) {
            
              $product_option_id = $product_options[$option_id]['product_option_id'];
              $product_option_value_id = $product_options[$option_id]['values'][$option_value_id];
              
              $this->saveProductOptionValueImages($product_id, $product_option_id, $product_option_value_id, array( array('image'=>$product_image['image'], 'srt'=>(int)$product_image['sort_order']) ));
              
            }
          }
          
        }
        
      }
      
    }
  
  }
  
  // new
  public function getGlobalSettings() {
    $poip_settings = $this->config->get('poip_module');
    $settings_names = $this->getSettingsNames(false);
    foreach ($settings_names as $setting_name) {
      if ( !isset($poip_settings[$setting_name]) ) {
        $poip_settings[$setting_name] = 0;
      }
    }
    return $poip_settings;
  }
  
  
  // exact (determined) option settings
  public function getProductOptionSettings($product_option_id) {
    
    $option_settings = array();
    if (!$this->installed()) return $option_settings;
    
    $poip_settings = $this->config->get('poip_module');
    $poip_option_settings = $this->getOptionSettings($product_option_id);
    
    $query = $this->db->query("SELECT * FROM ".DB_PREFIX."poip_option_settings WHERE product_option_id = ".(int)$product_option_id." ");
    
    $settings_names = $this->getSettingsNames();
    
    foreach ($settings_names as $setting_name) {
      if ($query->row && isset($query->row[$setting_name]) && $query->row[$setting_name] != 0) {
        $option_settings[$setting_name] = $query->row[$setting_name]-1;
        
      } elseif (isset($poip_option_settings[$setting_name]) && $poip_option_settings[$setting_name] != 0) {
        $option_settings[$setting_name] = $poip_option_settings[$setting_name]-1;
        
      } elseif (isset($poip_settings[$setting_name])) {
        $option_settings[$setting_name] = $poip_settings[$setting_name];
        
      } else {  
        $option_settings[$setting_name] = false;
      }
    }
    
    return $option_settings;
    
  }
  
  // all product settings together (for all options)
  public function getProductSettings($product_id) {
    $query = $this->db->query("SELECT product_option_id FROM ".DB_PREFIX."product_option WHERE product_id = ".(int)$product_id."  ");
    $poip_settings = array();
    foreach ($query->rows as $row) {
      $poip_settings[$row['product_option_id']] = $this->getProductOptionSettings($row['product_option_id']);
    }
    return $poip_settings;
  }
  // >> reading calculated settings
  
  // for export
  public function getAllImages() {
    $query = $this->db->query(" SELECT POIP.product_id, POV.option_value_id, POIP.image
                                FROM ".DB_PREFIX."poip_option_image POIP, ".DB_PREFIX."product_option_value POV
                                WHERE POIP.product_option_value_id = POV.product_option_value_id
                                ");
    return $query->rows;
  }
  
  public function getProductOrderImage($product_id, $option_data, $image) {
    
    if (!$this->installed()) {
      return $image;
    }
    
    $selected_product_option = array();
    $selected_product_option_value = array();
    foreach ($option_data as $option_value_data) {
      if (!in_array($option_value_data['product_option_id'], $selected_product_option)) $selected_product_option[] = $option_value_data['product_option_id'];
      if (!in_array($option_value_data['product_option_value_id'], $selected_product_option_value)) $selected_product_option_value[] = $option_value_data['product_option_value_id'];
    }
    
    
    $product_images = $this->getProductOptionImages($product_id);
    if ( count($product_images) > 0 ) {
      
      $product_settings = $this->getProductSettings($product_id);
      
      $cart_options = array();
      $filter_options = array();
      foreach ($product_images as $product_option_id => $product_option_images ) {
        
        if ( in_array($product_option_id, $selected_product_option) ) { // значение опции выбрано
          
          $images_count = 0;
          
          foreach ($product_option_images as $product_option_value => $product_option_value_images) {
            $images_count = $images_count + count($product_option_value_images);
          }
          
          if ($images_count > 0) {
            if (isset($product_settings[$product_option_id]['img_cart']) && $product_settings[$product_option_id]['img_cart']) {
              $cart_options[] = $product_option_id;
              if ($product_settings[$product_option_id]['img_limit']) $filter_options[] = $product_option_id;
            }
          }
        }
      }
      
      if (count($filter_options)>0) {
        
        $images = false;
        foreach ($product_images as $product_option_id => $product_option_images) {
          if (in_array($product_option_id, $filter_options)) {
            $current_images = array();
            foreach ($product_images[$product_option_id] as $product_option_value_id => $product_option_value_images) {
              if ( in_array($product_option_value_id, $selected_product_option_value) ) { // это выбранное значение опции
                foreach ($product_option_value_images as $image_info) {
                  if (!in_array($image_info['image'], $current_images)) {
                    $current_images[] = $image_info['image'];
                  }
                }
              } 
            }
            
            if (count($current_images) > 0) {
              if ($images === false) {
                $images = $current_images;
              } else {
                $images = array_values(array_intersect($images, $current_images));
              }
            }
            
          }
        }
        
        if ($images && count($images)>0) {
          $image = $images[0];
        }
        
      } elseif (count($cart_options)>0) { // first image of first option
        $product_option_id = $cart_options[0];
        foreach ($product_images[$product_option_id] as $product_option_value_id => $product_option_value_images) {
          if ( in_array($product_option_value_id, $selected_product_option_value) ) { // selected value
            foreach ($product_option_value_images as $image_info) {
              $image = $image_info['image'];
            }
          }
        }
      }
      
    }
    
    return $image;
    
  }
  
  public function add_product_option_value_image($product_id, $option_value_id, $image) {
    
    $query = $this->db->query("SELECT * FROM ".DB_PREFIX."product_option_value WHERE product_id = ".(int)$product_id." AND option_value_id = ".(int)$option_value_id." ");
    if ($query->num_rows) {
      
      $query_i = $this->db->query("SELECT * FROM ".DB_PREFIX."poip_option_image
                                    WHERE product_id = ".(int)$product_id."
                                    AND product_option_id = ".(int)$query->row['product_option_id']."
                                    AND product_option_value_id = ".(int)$query->row['product_option_value_id']."
                                    AND image = '".$this->db->escape((string)$image)."'
                                    ");
      if (!$query_i->num_rows) {
      
        $query_p = $this->db->query("SELECT sort_order FROM ".DB_PREFIX."poip_option_image WHERE product_id = ".(int)$product_id." ORDER BY sort_order DESC LIMIT 1 ");
        if ($query_p->num_rows) {
          $sort_order = 1+$query_p->row['sort_order'];
        } else {
          $sort_order = 1;
        }
        
        $this->db->query("INSERT INTO ".DB_PREFIX."poip_option_image
                              SET product_id = ".(int)$product_id."
                                , product_option_id = ".(int)$query->row['product_option_id']."
                                , product_option_value_id = ".(int)$query->row['product_option_value_id']."
                                , image = '".$this->db->escape((string)$image)."'
                                , sort_order = ".$sort_order."
                                ");
        
        return true;
        
      }
      
    }
    
    return false;
    
  }
  
  // thumbs to array of images
  public function addThumbsIfNeeded($images) {
    
    if (!$this->installed()) return $images;
    
		if (!$this->model_tool_image) {
			$this->load->model('tool/image');
		}
		
    foreach ($images as &$image) {
      if (!isset($image['thumb'])) {
        $image['thumb'] = $this->model_tool_image->resize($image['image'], 100, 100);
      }
    }
    unset($image);
    
    return $images;
  }
  
  public function getProductOptionImages($product_id) {
    
    $images = array();
    
    if (!$this->installed()) return $images;
    
    if (!$this->model_tool_image) {
			$this->load->model('tool/image');
		}
    
    $query = $this->db->query("SELECT * FROM ".DB_PREFIX."poip_option_image WHERE product_id = ".(int)$product_id." ORDER BY sort_order ");
    foreach ($query->rows as $row) {
      if (!isset($images[$row['product_option_id']])) {
        $images[$row['product_option_id']] = array();
      }
      if (!isset($images[$row['product_option_id']][$row['product_option_value_id']])) {
        $images[$row['product_option_id']][$row['product_option_value_id']] = array();
      }
      $images[$row['product_option_id']][$row['product_option_value_id']][] = array(  'image'=>$row['image']
                                                                                    , 'srt'=>$row['sort_order']
                                                                                    , 'thumb'=>$this->model_tool_image->resize($row['image'], 100, 100)
                                                                                    );
    }
    
    return $images;
    
  }
  
  public function getSettingsNames($for_product=true) {
    $settings = array();
    
    if (!$for_product) {
      $settings[] = "options_images_edit";
      $settings[] = "img_hover";
      $settings[] = "img_main_to_additional";
      $settings[] = "img_gal";
    }
    
    
    $settings[] = "img_change";
    
    $settings[] = "img_use";
    $settings[] = "img_limit";
    
    $settings[] = "img_option";
    $settings[] = "img_category";
    $settings[] = "img_first";
    $settings[] = "dependent_thumbnails";
    $settings[] = "img_cart";
    $settings[] = "img_radio_checkbox";
    
    
    
    
    return $settings;
  }
  
 // new
  public function getSettingsValues() {
  
    $settings_values = array();
  
    $settings_names = $this->getSettingsNames();
    foreach ($settings_names as $setting_name ) {
      for ($i=0;$i<10;$i++) {
        $value_key = 'entry_'.$setting_name.'_v'.$i;
        if ( $this->language->get($value_key) != $value_key ) {
          $settings_values[] = $value_key;
        }
      }
    }
    
    return $settings_values;
    
    //return array('img_use_v0', 'img_use_v1', 'img_use_v2', 'img_first_v0', 'img_first_v1', 'img_first_v2');
    
  }
  
  public function saveProductOptionValueImages($product_id, $product_option_id, $product_option_value_id, $images) {
    
    if (!$this->installed()) return;
    
    if (is_array($images)) {
      foreach ($images as $image) {
        if (is_array($image) && isset($image['image']) && $image['image']) {
          $this->db->query("INSERT INTO ".DB_PREFIX."poip_option_image
                            SET product_id = ".(int)$product_id."
                              , product_option_id = ".(int)$product_option_id."
                              , product_option_value_id = ".(int)$product_option_value_id."
                              , image = '".$this->db->escape((string)$image['image'])."'
                              , sort_order = ".(isset($image['srt']) ? (int)$image['srt'] : 0)."
                              ");
        }
      }
    }
    
  }
  
  public function deleteProductOptionValueImages($product_id) {
    
    if (!$this->installed()) return;
    
    $this->db->query("DELETE FROM ".DB_PREFIX."poip_option_image WHERE product_id = ".(int)$product_id." ");
    
  }
  
  // Real
  public function getRealOptionSettings($option_id) {
    
    $settings = array();
    
    if (!$this->installed()) return $settings;
    
    if (!$option_id) return $settings;
    
    $settings_names = $this->getSettingsNames();
    
    $query = $this->db->query("SELECT * FROM ".DB_PREFIX."poip_main_option_settings WHERE option_id = ".(int)$option_id." ");
    if ($query->num_rows) {
      $row = $query->row;
      foreach ($settings_names as $setting_name) {
        $settings[$setting_name] = isset($row[$setting_name]) ? $row[$setting_name] : 0;
      }
      
    }
    
    return $settings;
  }
  
  public function getRealProductSettings($product_id) {
    
    $settings = array();
    
    if (!$this->installed()) return $settings;
    
    if (!$product_id) return $settings;
    
    $settings_names = $this->getSettingsNames();
    
    $query = $this->db->query("SELECT * FROM ".DB_PREFIX."poip_option_settings WHERE product_id = ".(int)$product_id." ");
    foreach ($query->rows as $row) {
      $settings[$row['product_option_id']] = array();
      foreach ($settings_names as $setting_name) {
        $settings[$row['product_option_id']][$setting_name] = isset($row[$setting_name]) ? $row[$setting_name] : 0;
      }
      
    }
    
    return $settings;
  }
  
  public function deleteRealProductSettings($product_id) {
    
    if (!$this->installed()) return;
    $this->db->query("DELETE FROM ".DB_PREFIX."poip_option_settings WHERE product_id = ".(int)$product_id." ");
    
  }
  
  public function deleteRealOptionSettings($option_id) {
    
    if (!$this->installed()) return;
    $this->db->query("DELETE FROM ".DB_PREFIX."poip_main_option_settings WHERE option_id = ".(int)$option_id." ");
    
  }
  
  public function setRealOptionSettings($option_id, $settings) {
    
    if (!$this->installed()) return;
    
    $this->check_new_settings_fields();
    
    $this->model_module_product_option_image_pro->deleteRealOptionSettings($option_id);
    
    $sql = "";
    $settings_names = $this->getSettingsNames();
    foreach ($settings_names as $setting_name) {
      $sql .= ", ".$setting_name." = ".(isset($settings[$setting_name]) ? (int)$settings[$setting_name] : 0)." ";
    }
    
    $this->db->query("INSERT INTO ".DB_PREFIX."poip_main_option_settings
                        SET option_id = ".(int)$option_id."
                          ".$sql."
                          ");
    
  }
  
  public function setRealProductSettings($product_id, $product_option_id, $settings) {
    
    if (!$this->installed()) return;
    
    $this->check_new_settings_fields();
		
    $this->db->query("DELETE FROM ".DB_PREFIX."poip_option_settings WHERE product_option_id = ".(int)$product_option_id." ");
    
    $sql = "";
    $settings_names = $this->getSettingsNames();
    foreach ($settings_names as $setting_name) {
      $sql .= ", ".$setting_name." = ".(isset($settings[$setting_name]) ? (int)$settings[$setting_name] : 0)." ";
    }
    
    $this->db->query("INSERT INTO ".DB_PREFIX."poip_option_settings
                        SET product_id = ".(int)$product_id."
                          , product_option_id = ".(int)$product_option_id."
                          ".$sql."
                          ");
    
  }
  
  
  private function check_new_settings_fields() {
    
    $query = $this->db->query("SHOW COLUMNS FROM `" . DB_PREFIX . "poip_option_settings` WHERE field='img_radio_checkbox' ");
		if (!$query->num_rows) {
			$this->db->query("ALTER TABLE `".DB_PREFIX."poip_option_settings` ADD COLUMN `img_radio_checkbox` tinyint(1) NOT NULL " );
		}
    
    $query = $this->db->query("SHOW COLUMNS FROM `" . DB_PREFIX . "poip_main_option_settings` WHERE field='img_radio_checkbox' ");
		if (!$query->num_rows) {
			$this->db->query("ALTER TABLE `".DB_PREFIX."poip_main_option_settings` ADD COLUMN `img_radio_checkbox` tinyint(1) NOT NULL " );
		}
    
    $query = $this->db->query("SHOW COLUMNS FROM `" . DB_PREFIX . "poip_option_settings` WHERE field='dependent_thumbnails' ");
		if (!$query->num_rows) {
			$this->db->query("ALTER TABLE `".DB_PREFIX."poip_option_settings` ADD COLUMN `dependent_thumbnails` tinyint(1) NOT NULL " );
		}
    
    $query = $this->db->query("SHOW COLUMNS FROM `" . DB_PREFIX . "poip_main_option_settings` WHERE field='dependent_thumbnails' ");
		if (!$query->num_rows) {
			$this->db->query("ALTER TABLE `".DB_PREFIX."poip_main_option_settings` ADD COLUMN `dependent_thumbnails` tinyint(1) NOT NULL " );
		}
    
  }
  
  
  public function installed() {
    
    $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "extension WHERE `type` = 'module' AND `code` = 'product_option_image_pro'");
    
    // not working in mijoshop
    //$query = $this->db->query('SHOW TABLES LIKE `' . DB_PREFIX . 'poip_option_image`');
    return $query->num_rows; 
  }
  
  public function install() {
    
    $this->uninstall();
    
    $this->db->query(
        'CREATE TABLE IF NOT EXISTS
          `' . DB_PREFIX . 'poip_option_image` (
            `product_id` int(11) NOT NULL,
            `product_option_id` int(11) NOT NULL,
            `product_option_value_id` int(11) NOT NULL,
            `image` varchar(255) NOT NULL,
            `sort_order` int(11) NOT NULL,
            KEY (`product_id`),
            KEY (`product_option_id`),
            KEY (`product_option_value_id`),
            FOREIGN KEY (product_id) REFERENCES `'. DB_PREFIX .'product`(product_id) ON DELETE CASCADE,
            FOREIGN KEY (product_option_id) REFERENCES `'. DB_PREFIX .'product_option`(product_option_id) ON DELETE CASCADE,
            FOREIGN KEY (product_option_value_id) REFERENCES `'. DB_PREFIX .'product_option_value`(product_option_value_id) ON DELETE CASCADE
          ) ENGINE=MyISAM DEFAULT CHARSET=utf8'
    );
    
    $this->db->query(
        'CREATE TABLE IF NOT EXISTS
          `' . DB_PREFIX . 'poip_option_settings` (
            `product_id` int(11) NOT NULL,
            `product_option_id` int(11) NOT NULL,
            `img_change` tinyint(1) NOT NULL,
            `img_hover` tinyint(1) NOT NULL,
            `img_use` tinyint(1) NOT NULL,
            `img_limit` tinyint(1) NOT NULL,
            `img_gal` tinyint(1) NOT NULL,
            `img_option` tinyint(1) NOT NULL,
            `img_category` tinyint(1) NOT NULL,
            `img_first` tinyint(1) NOT NULL,
            `img_from_option` tinyint(1) NOT NULL,
            `img_sort` tinyint(1) NOT NULL,
            `img_select` tinyint(1) NOT NULL,
						`img_cart` tinyint(1) NOT NULL,
            `img_radio_checkbox` tinyint(1) NOT NULL,
            `dependent_thumbnails` tinyint(1) NOT NULL,
            KEY (`product_id`),
            KEY (`product_option_id`),
            FOREIGN KEY (product_id) REFERENCES `'. DB_PREFIX .'product`(product_id) ON DELETE CASCADE,
            FOREIGN KEY (product_option_id) REFERENCES `'. DB_PREFIX .'product_option`(product_option_id) ON DELETE CASCADE
          ) ENGINE=MyISAM DEFAULT CHARSET=utf8'
    );
    
    $this->db->query(
        'CREATE TABLE IF NOT EXISTS
          `' . DB_PREFIX . 'poip_main_option_settings` (
            `option_id` int(11) NOT NULL,
            `img_change` tinyint(1) NOT NULL,
            `img_hover` tinyint(1) NOT NULL,
            `img_use` tinyint(1) NOT NULL,
            `img_limit` tinyint(1) NOT NULL,
            `img_gal` tinyint(1) NOT NULL,
            `img_option` tinyint(1) NOT NULL,
            `img_category` tinyint(1) NOT NULL,
            `img_first` tinyint(1) NOT NULL,
            `img_from_option` tinyint(1) NOT NULL,
            `img_sort` tinyint(1) NOT NULL,
            `img_select` tinyint(1) NOT NULL,
						`img_cart` tinyint(1) NOT NULL,
            `img_radio_checkbox` tinyint(1) NOT NULL,
            `dependent_thumbnails` tinyint(1) NOT NULL,
            KEY (`option_id`),
            FOREIGN KEY (`option_id`) REFERENCES `'. DB_PREFIX .'option`(`option_id`) ON DELETE CASCADE
          ) ENGINE=MyISAM DEFAULT CHARSET=utf8'
    );
    
    
    $this->load->model('setting/setting');
		$msettings = array('poip_module'=>array('img_change'=>1,'img_hover'=>1,'img_main_to_additional'=>1,'img_hover'=>1,'img_use'=>1,'img_limit'=>1,'img_gal'=>1,'img_cart'=>1));
		$this->model_setting_setting->editSetting('poip_module', $msettings);
    
  }
  
  public function uninstall() {
    
    $this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "poip_option_image`;");
    $this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "poip_main_option_settings`;");
    $this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "poip_option_settings`;");
    
  }
  
}
