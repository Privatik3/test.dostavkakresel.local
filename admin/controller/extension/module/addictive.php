<?php
class ControllerExtensionModuleAddictive extends Controller {
	private $error = array();
    
    public function install(){
	 $this->load->model('extension/module/addictive');
	 $this->model_extension_module_addictive->install();
	 $this->index();
    }

    public function uninstall(){
	 $this->load->model('extension/module/addictive');
	 $this->model_extension_module_addictive->uninstall();
    }

	public function index() {
		$this->load->language('extension/module/addictive');

		$this->document->setTitle($this->language->get('heading_title'));
		$this->load->model('extension/module');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {

		if (!isset($this->request->get['module_id'])) {
				$this->model_extension_module->addModule('addictive', $this->request->post);
				} else {

				$this->model_extension_module->editModule($this->request->get['module_id'], $this->request->post);
				$this->load->model('extension/module/addictive');
				$post_category = $this->request->post['category']; // список категорий
				
				$model_data = array();
				
				foreach($post_category as $category_id){
				 // формируем данные в модель
				 if (!isset($this->request->post['service-name-'.$category_id])) continue;
				 $names = $this->request->post['service-name-'.$category_id];
				 $prices = $this->request->post['service-price-'.$category_id];
				 $newprices = $this->request->post['service-newprice-'.$category_id];
				 $desc = $this->request->post['service-description-'.$category_id];
				 $show_description = $this->request->post['service-show-description-'.$category_id];
				 $tooltip = $this->request->post['service-tooltip-'.$category_id];
				 $order = $this->request->post['service-order-'.$category_id];
				 $tooltip_content = $this->request->post['tooltip-content-'.$category_id];
				 
				 $this->model_extension_module_addictive->deleteServices($category_id);				 
				 
				 for($i = 0;$i<count($names); $i++){
					 $model_data[] = array('category_id'=>$category_id, 'name' => $names[$i], 'price'=>$prices[$i], 'new_price'=>$newprices[$i], 'description'=>$desc[$i], 'tooltip'=>$tooltip[$i], 'show_description' => $show_description[$i], 'order' => $order[$i], 'tooltip_content' => $tooltip_content[$i]);
				 } 
				}
				if ($this->model_extension_module_addictive->insertServices($model_data)){
					
				}
			}
			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('extension/extension', 'token=' . $this->session->data['token'], 'SSL'));
		}

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
		$data['default_category'] = $this->language->get('default_category');
		$data['help_category'] = $this->language->get('help_category');

		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}
		
		if (isset($this->error['name'])) {
			$data['error_name'] = $this->error['name'];
		} else {
			$data['error_name'] = '';
		}
		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_module'),
			'href' => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL')
		);

		if (!isset($this->request->get['module_id'])) {
			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('heading_title'),
				'href' => $this->url->link('extension/module/addictive', 'token=' . $this->session->data['token'], 'SSL')
			);
		} else {
			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('heading_title'),
				'href' => $this->url->link('extension/module/addictive', 'token=' . $this->session->data['token'] . '&module_id=' . $this->request->get['module_id'], 'SSL')
			);			
		}

		if (!isset($this->request->get['module_id'])) {
			$data['action'] = $this->url->link('extension/module/addictive', 'token=' . $this->session->data['token'], 'SSL');
		} else {
			$data['action'] = $this->url->link('extension/module/addictive', 'token=' . $this->session->data['token'] . '&module_id=' . $this->request->get['module_id'], 'SSL');
		}
		
		$data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		
		if (isset($this->request->get['module_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$module_info = $this->model_extension_module->getModule($this->request->get['module_id']);
		}
		
		$data['token'] = $this->session->data['token'];

		if (isset($this->request->post['name'])) {
			$data['name'] = $this->request->post['name'];
		} elseif (!empty($module_info)) {
			$data['name'] = $module_info['name'];
		} else {
			$data['name'] = '';
		}

		$this->load->model('catalog/category');
		
		$data['categories'] = array();
		
		if (isset($this->request->post['category'])) {
			$category = $this->request->post['category'];
		} elseif (!empty($module_info)) {
			$category = $module_info['category'];
		} else {
			$category = array();
		}	
		
		foreach ($category as $category_id) {
			$category_info = $this->model_catalog_category->getCategory($category_id);
			
			if ($category_info) {
				$data['categories'][] = array(
					'category_id' => $category_info['category_id'],
					'name'       => $category_info['name']
				);
			}
		}
		
		$this->load->model('extension/module/addictive');
		
		$data['services'] = array();
		$services = $this->model_extension_module_addictive->getServices();
		if ($services){
			foreach($services as $service){
			 	$data['services'][$service['category_id']][] = array('id'=>$service['id'], 
				                            'category_id' => $service['category_id'], 
											'name'=>$service['service_name'], 
											'price'=>$service['service_price'], 
											'new_price' => $service['service_new_price'], 
											'desc' => $service['description'], 
											'show_tooltip' => $service['show_tooltip'],
											'show_description' => $service['show_description'], 
											'order' => $service['_order'], 
											'tooltip_content' => $service['tooltip']
											);
			}
		}
		//print_r($data['services']);
		if (isset($this->request->post['status'])) {
			$data['status'] = $this->request->post['status'];
		} elseif (!empty($module_info)) {
			$data['status'] = $module_info['status'];
		} else {
			$data['status'] = '';
		}

		$this->document->addStyle('view/stylesheet/addictive.css');

		
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('extension/module/addictive', $data));
	}

	protected function validate() {
		if (!$this->user->hasPermission('modify', 'module/addictive')) {
		}
		
		if ((utf8_strlen($this->request->post['name']) < 3) || (utf8_strlen($this->request->post['name']) > 64)) {
			$this->error['name'] = $this->language->get('error_name');
		}
		
		return !$this->error;
	}
	
		public function autocomplete() {
		$json = array();

		if (isset($this->request->get['filter_name']) || isset($this->request->get['filter_model'])) {
			$this->load->model('catalog/category');
			//$this->load->model('catalog/option');

			if (isset($this->request->get['filter_name'])) {
				$filter_name = $this->request->get['filter_name'];
			} else {
				$filter_name = '';
			}

			if (isset($this->request->get['filter_model'])) {
				$filter_model = $this->request->get['filter_model'];
			} else {
				$filter_model = '';
			}

			if (isset($this->request->get['limit'])) {
				$limit = $this->request->get['limit'];
			} else {
				$limit = 5;
			}

			$filter_data = array(
				'filter_name'  => $filter_name,
				'filter_model' => $filter_model,
				'start'        => 0,
				'limit'        => $limit
			);

			$results = $this->model_catalog_category->getCategories($filter_data);

			foreach ($results as $result) {
				
				$json[] = array(
					'category_id' => $result['category_id'],
					'name'       => strip_tags(html_entity_decode($result['name'], ENT_QUOTES, 'UTF-8'))
				);
			}
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
	
	public function getServiceData($category_id){
		$this->load->model('extension/module/addictive');
		$services = $this->model_extension_module_addictive->getService($category_id);
	}
}