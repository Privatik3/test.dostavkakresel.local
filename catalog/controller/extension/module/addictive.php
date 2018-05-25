<?php
class ControllerExtensionModuleAddictive extends Controller {
	private $error = array();
    
  	public function index() {
		$this->load->language('extension/module/addictive');

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_edit'] = $this->language->get('text_edit');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
		
		$data['entry_name'] = $this->language->get('entry_name');
		$data['entry_category'] = $this->language->get('entry_category');
		$data['entry_status'] = $this->language->get('entry_status');
		
		$data['entry_service'] = $this->language->get('entry_service');
		$data['entry_price'] = $this->language->get('entry_price');
		$data['entry_new_price'] = $this->language->get('entry_new_price');
		$data['entry_description'] = $this->language->get('entry_description');
		$data['no_data'] = $this->language->get('no_data');
		
		$data['token'] = $this->session->data['token'];
		$data['categories'] = array();
		
		$this->load->model('extension/module/addictive');
		
		$data['services'] = array();
		
		if (isset($this->session->data['addictive'])){
			$addictive = 	$this->session->data['addictive'];
		}else
			$addictive = '';
		
		// настройки и категории по умолчанию
		$default = $this->config->get('addictive_default');
		
			if ($this->cart->hasProducts()){
			// продукты
			$products = $this->cart->getProducts();
			}else
			$products = array($this->request->get['product_id']);
			
			foreach($products as $product){
				// нашли id продукта
				if ($this->cart->hasProducts()){
				$product_id = $product['product_id'];
				}else
				$product_id = $product;
				// получили доп. услуги по категории этого продукта
				$services = $this->model_extension_module_addictive->getServicesByProduct($product_id);
				//print_R($services);
				if ($services){
				foreach($services as $service){
			 	$selected = 0;
				if (is_array($addictive)){
					if (in_array('service'.$service['id'], $addictive)){
						$selected = 1;
					}					
				}
				$data['services'][] = array('id'=>$service['id'], 
				                            'category_id' => $service['category_id'], 
											'name'=>$service['service_name'], 
											'price'=>$this->currency->format($service['service_price'], $this->session->data['currency']), 
											'new_price' => $this->currency->format($service['service_new_price'], $this->session->data['currency']), 
											'desc' => $service['description'], 
											'selected' => $selected);
			}
				}else{
					if ($default){
						// подгружаем настройки доп. услуг по умолчанию
						$services = $this->model_extension_module_addictive->getDefaultServices();
						if ($services){
						foreach($services as $service){
						$selected = 0;
						if (is_array($addictive)){
					    if (in_array('service'.$service['id'], $addictive)){
						$selected = 1;
					}					
				}
				    $data['services'][] = array('id'=>$service['id'], 
				                            'category_id' => $service['category_id'], 
											'name'=>$service['service_name'], 
											'price'=>$this->currency->format($service['service_price'],$this->session->data['currency']), 
											'new_price' => $this->currency->format($service['service_new_price'],$this->session->data['currency']), 
											'desc' => $service['description'], 
											'selected' => $selected);						
					}
					} else {
						$data['error'] = $this->language->get('error_no_data');
					}					
				 }
				}
		}

		return $this->load->view('extension/module/addictive', $data);
	} 
	
	
public function change(){
	if (isset($this->request->post['services'])) {
			$services = $this->request->post['services'];
			$this->session->data['addictive'] = $services;
		} else {
			unset($this->session->data['addictive']);
		}
	$json = array();
	//$json['redirect'] = $this->url->link('checkout/cart');
	
	$this->response->addHeader('Content-Type: application/json');
	$this->response->setOutput(json_encode($json));
 }
}