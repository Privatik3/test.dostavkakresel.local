<?
class ModelExtensionModuleArt6Filter extends Model {
	public function getFilterAttributes($product_id) {
		$product_attribute_data = array();
		$product_attribute_group_query = $this->db->query("SELECT ag.attribute_group_id, agd.name FROM " . DB_PREFIX . "product_attribute pa LEFT JOIN " . DB_PREFIX . "attribute a ON (pa.attribute_id = a.attribute_id) LEFT JOIN " . DB_PREFIX . "attribute_group ag ON (a.attribute_group_id = ag.attribute_group_id) LEFT JOIN " . DB_PREFIX . "attribute_group_description agd ON (ag.attribute_group_id = agd.attribute_group_id) WHERE pa.product_id = '" . (int)$product_id . "' AND agd.language_id = '" . (int)$this->config->get('config_language_id') . "' GROUP BY ag.attribute_group_id ORDER BY ag.sort_order, agd.name");
		$i = 0;
		foreach ($product_attribute_group_query->rows as $product_attribute_group) {
			$product_attribute_query = $this->db->query("SELECT a.attribute_id, a.open_filter, a.view_filter, ad.name, pa.color, pa.text FROM " . DB_PREFIX . "product_attribute pa LEFT JOIN " . DB_PREFIX . "attribute a ON (pa.attribute_id = a.attribute_id AND a.filter = 1) LEFT JOIN " . DB_PREFIX . "attribute_description ad ON (a.attribute_id = ad.attribute_id) WHERE pa.product_id = '" . (int)$product_id . "' AND a.attribute_group_id = '" . (int)$product_attribute_group['attribute_group_id'] . "' AND ad.language_id = '" . (int)$this->config->get('config_language_id') . "' AND pa.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY a.sort_order, pa.text, ad.name");
			foreach ($product_attribute_query->rows as $product_attribute) {
				$product_attribute_data[$i] = array(
					'attribute_group_id' => $product_attribute_group['attribute_group_id'],
					'attribute_id'		 => $product_attribute['attribute_id'],
					'name'				 => $product_attribute['name'],
					'open_filter'		 => $product_attribute['open_filter'],
					'view'				 => $product_attribute['view_filter'],
					'text'				 => explode(":", $product_attribute['text']),
					'color'				 => array($product_attribute['color'])
				);
				$i++;
			}
		}
		return $product_attribute_data;
	}

	public function getFilterOptions($product_id) {
		$product_option_data = array();
		$product_option_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_option po LEFT JOIN `" . DB_PREFIX . "option` o ON (po.option_id = o.option_id AND o.filter = 1) LEFT JOIN " . DB_PREFIX . "option_description od ON (o.option_id = od.option_id) WHERE po.product_id = '" . (int)$product_id . "' AND od.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY o.sort_order");
		foreach ($product_option_query->rows as $product_option) {
			$product_option_value_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_option_value pov LEFT JOIN " . DB_PREFIX . "option_value ov ON (pov.option_value_id = ov.option_value_id) LEFT JOIN " . DB_PREFIX . "option_value_description ovd ON (ov.option_value_id = ovd.option_value_id) WHERE pov.product_id = '" . (int)$product_id . "' AND pov.product_option_id = '" . (int)$product_option['product_option_id'] . "' AND ovd.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY ov.sort_order");
			if ($product_option_value_query->num_rows > 0) {
				foreach ($product_option_value_query->rows as $product_option_value) {
					$product_option_data[] = array(
						'option_group_id'	=> $product_option['option_id'],
						'name'				=> $product_option['name'],
						'view'				=> $product_option['type'],
						'option_value'		=> array(
							array(
								'option_id'			=> $product_option_value['option_value_id'],
								'text'				=> $product_option_value['name']
							)
						)
					);
				}
			}
		}
		return $product_option_data;
	}
}
?>