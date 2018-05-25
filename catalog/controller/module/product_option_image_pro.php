<?php
//  Product Option Image PRO / Изображения опций PRO
//  Support: support@liveopencart.com / Поддержка: help@liveopencart.ru

class ControllerModuleProductOptionImagePro extends Model {

	public function get_products_list_images() {
		
		$json = array('products'=>array());
		
		if (isset($this->request->post['products_ids']) && is_array($this->request->post['products_ids'])) {
			
			$products_ids = $this->request->post['products_ids'];
		
			if (!$this->model_module_product_option_image_pro) {
				$this->load->model('module/product_option_image_pro');
			}
			
			foreach ($products_ids as $product_id) {
				$product_id = (int)$product_id;
				if ($product_id) {
					$json['products'][$product_id] = $this->model_module_product_option_image_pro->getCategoryImages($product_id, false, false);
				}
			}
		
		}
		
		$this->response->addHeader('Content-Type: application/json');

		$this->response->setOutput(json_encode($json));
		
	}

}