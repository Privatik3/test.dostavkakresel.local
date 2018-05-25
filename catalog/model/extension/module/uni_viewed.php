<?php
class ModelExtensionModuleUniViewed extends Model {	
	public function getViewed($product_id) {
		$product_data = $this->cache->get('unishop.viewed.'.(int)$product_id);
		
		if(!$product_data) {
			$product_data = $this->model_catalog_product->getProduct((int)$product_id);
			$this->cache->set('unishop.viewed.'.(int)$product_id, $product_data);
		}

		return $product_data;
	}
}
?>