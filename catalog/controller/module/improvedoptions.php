<?php

//  Improved options / Расширенные опции
//  Support: support@liveopencart.com / Поддержка: help@liveopencart.ru

class ControllerModuleImprovedOptions extends Controller {


	
	public function get_sku_model() {
		
		if (isset($this->request->get['product_id'])) {
			$product_id = (int)$this->request->get['product_id'];
		} else {
			exit;
		}
		
		if (isset($this->request->post['option_oc'])) {
			$options = $this->request->post['option_oc'];
		} elseif (isset($this->request->post['option'])) {
			$options = $this->request->post['option'];
		} else {
			$options = array();
		}
		
		$this->load->model('module/improvedoptions');
		
		$product_sku = $this->model_module_improvedoptions->getSKU($product_id, $options );
		$product_model = $this->model_module_improvedoptions->getSKU($product_id, $options, 'model' );
		$product_upc = $this->model_module_improvedoptions->getSKU($product_id, $options, 'upc' );
		$product_reward = $this->model_module_improvedoptions->getReward($product_id, $options );
		
		$sku_data = array('sku'=>$product_sku, 'upc'=>$product_upc, 'model'=>$product_model, 'reward'=>$product_reward);
		
		if (isset($this->request->get['rnd'])) {
			$sku_data['rnd'] = $this->request->get['rnd'];
		}
			
		echo json_encode($sku_data);
		exit;
		
	}
	
	
}
