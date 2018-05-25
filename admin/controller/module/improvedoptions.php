<?php

//  Improved options / Расширенные опции
//  Support: support@liveopencart.com / Поддержка: help@liveopencart.ru

class ControllerModuleImprovedOptions extends Controller {
  
  private $error = array(); 
	
	private function getLinks() {
		
		$data = array();
		
		$data['breadcrumbs'] = array();

		if (VERSION >= '2.3.0.0') {
			
			$data['breadcrumbs'][] = array(
					'text'      => $this->language->get('text_home'),
					'href'      => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL'),
					'separator' => false
			);
			$data['breadcrumbs'][] = array(
					'text'      => $this->language->get('text_module'),
					'href'      => $this->url->link('extension/extension', 'token=' . $this->session->data['token'].'&type=module', 'SSL'),
					'separator' => ' :: '
			);
			$data['breadcrumbs'][] = array(
					'text'      => $this->language->get('module_name'),
					'href'      => $this->url->link('extension/module/improvedoptions', 'token=' . $this->session->data['token'], 'SSL'),
					'separator' => ' :: '
			);
			$data['action'] = $this->url->link('extension/module/improvedoptions', 'token=' . $this->session->data['token'], 'SSL');
			$data['cancel'] = $this->url->link('extension/extension', 'token=' . $this->session->data['token'].'&type=module', 'SSL');
			
			$data['redirect'] = $this->url->link('extension/module/improvedoptions', 'token=' . $this->session->data['token'], 'SSL');
			
		} else { // OLDER OC
			
			$data['breadcrumbs'][] = array(
					'text'      => $this->language->get('text_home'),
					'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
					'separator' => false
			);
			$data['breadcrumbs'][] = array(
					'text'      => $this->language->get('text_module'),
					'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
					'separator' => ' :: '
			);
			$data['breadcrumbs'][] = array(
					'text'      => $this->language->get('module_name'),
					//'text'      => $this->language->get('heading_title'),
					'href'      => $this->url->link('module/improvedoptions', 'token=' . $this->session->data['token'], 'SSL'),
					'separator' => ' :: '
			);
			$data['action'] = $this->url->link('module/improvedoptions', 'token=' . $this->session->data['token'], 'SSL');
			$data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
			
			$data['redirect'] = $this->url->link('module/improvedoptions', 'token=' . $this->session->data['token'], 'SSL');
		}
		
		return $data;
	}
	
	public function index() {
  
    $improvedoptions_language = $this->load->language('module/improvedoptions');
		foreach ( $improvedoptions_language as $lang_key => $lang_val ) {
			$data[$lang_key] = $this->language->get($lang_key);
		}
		
		$links = $this->getLinks();
    
    $this->document->setTitle($this->language->get('module_name'));
		
		$this->load->model('setting/setting');
				
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			
			$this->model_setting_setting->editSetting('improvedoptions', $this->request->post);		
					
			$this->session->data['success'] = $this->language->get('text_success');
						
			$this->response->redirect($links['redirect']);
		}
    
    
    
		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');
    
    if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}
		
		if (isset($this->session->data['success'])) {
      $data['success'] = $this->session->data['success'];
      unset($this->session->data['success']);
    }
    
    
    $data['breadcrumbs'] 	= $links['breadcrumbs'];
		$data['action'] 			= $links['action'];
		$data['cancel'] 			= $links['cancel'];
		
		
    
		$this->load->model('module/improvedoptions');
		$data['module_version'] = $this->model_module_improvedoptions->current_version();
		
		$data['config_admin_language'] = $this->config->get('config_admin_language');
    
    
		$data['modules'] = array();
		if (isset($this->request->post['improvedoptions_settings'])) {
			$data['modules'] = $this->request->post['improvedoptions_settings'];
		} elseif ($this->config->get('improvedoptions_settings')) { 
			$data['modules'] = $this->config->get('improvedoptions_settings');
		}	
		
    
    $this->load->model('design/layout');
		
		$data['layouts'] = $this->model_design_layout->getLayouts();
		
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');
				
		$this->response->setOutput($this->load->view('module/improvedoptions.tpl', $data));
    
  
  }
  
  
  
	public function install() {
		
		$this->load->model('module/improvedoptions');
		$this->model_module_improvedoptions->check_fields();
		
	}
	
	private function validate() {
		if (!$this->user->hasPermission('modify', 'module/improvedoptions') && !$this->user->hasPermission('modify', 'extension/module/improvedoptions')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}
  
}