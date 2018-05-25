<?php 
class ControllerUnishopLoginRegister extends Controller {
	public function index() {
		
		$data = array();
		
		$data['lang'] = array_merge($data, $this->language->load('unishop/unishop'));
		$this->language->load('unishop/unishop');
		
		$data['login_link'] = $this->url->link('account/account', '', 'SSL');
		$data['register_link'] = $this->url->link('account/register', '', 'SSL');
		
		$this->load->model('unishop/setting');
		$settings = $this->model_unishop_setting->getSetting();
		$language_id = $this->config->get('config_language_id');
		
		$data['show_login'] = isset($settings['show_login']) ? $settings['show_login'] : '';
		$data['login_mail_text'] = $settings[$language_id]['login_mail_text'];
		$data['login_password_text'] = $settings[$language_id]['login_password_text'];
		$data['show_login_forgotten'] = isset($settings['show_login_forgotten']) ? $settings['show_login_forgotten'] : '';
		$data['show_login_register'] = isset($settings['show_login_register']) ? $settings['show_login_register'] : '';
		$data['show_register'] = isset($settings['show_register']) ? $settings['show_register'] : '';
		$data['show_name'] = isset($settings['show_name']) ? $settings['show_name'] : '';
		$data['register_name_text'] = $settings[$language_id]['register_name_text'];
		$data['show_lastname'] = isset($settings['show_lastname']) ? $settings['show_lastname'] : '';
		$data['register_lastname_text'] = $settings[$language_id]['register_lastname_text'];
		$data['show_phone'] = isset($settings['show_phone']) ? $settings['show_phone'] : '';
		$data['register_phone_text'] = $settings[$language_id]['register_phone_text'];
		$data['register_phone_mask'] = $settings['register_phone_mask'];
		$data['register_mail_text'] = $settings[$language_id]['register_mail_text'];
		$data['register_password_text'] = $settings[$language_id]['register_password_text'];
		
		$data['show_register_confirm'] = isset($settings['show_register_confirm']) ? $settings['show_register_confirm'] : '';
		$data['show_register_login'] = isset($settings['show_register_login']) ? $settings['show_register_login'] : '';
		
		$data['register_link'] = $this->url->link('account/register', '', true);
		
		$data['logged'] = $this->customer->isLogged();
		
		$this->load->model('account/customer_group');
		$data['customer_groups'] = array();
		if (is_array($this->config->get('config_customer_group_display'))) {
			$customer_groups = $this->model_account_customer_group->getCustomerGroups();
			
			foreach ($customer_groups as $customer_group) {
				if (in_array($customer_group['customer_group_id'], $this->config->get('config_customer_group_display'))) {
					$data['customer_groups'][] = $customer_group;
				}
			}
		}
		
		if (isset($this->request->post['customer_group_id'])) {
			$data['customer_group_id'] = $this->request->post['customer_group_id'];
		} else {
			$data['customer_group_id'] = $this->config->get('config_customer_group_id');
		}
		
		if ($this->config->get('config_account_id')) {
			$this->load->model('catalog/information');
			
			$information_info = $this->model_catalog_information->getInformation($this->config->get('config_account_id'));
			
			$data['text_confirm'] = $information_info ? $information_info['title'] : '';
			$data['link_confirm'] = $information_info ? $this->url->link('information/information', 'information_id=' . $this->config->get('config_account_id'), 'SSL') : '';
		}
		
		if (VERSION >= 2.2) {
			$this->response->setOutput($this->load->view('unishop/login_register', $data));
		} else {
			$this->response->setOutput($this->load->view('unishop/template/unishop/login_register.tpl', $data));
		}
	}
	
	public function login() {
		$this->load->model('account/customer');
		$this->language->load('unishop/unishop');
		
		$json = array();
		
		$mail = isset($this->request->post['email']) ? htmlspecialchars(strip_tags($this->request->post['email'])) : '';
		$password = isset($this->request->post['password']) ? htmlspecialchars(strip_tags($this->request->post['password'])) : '';
	
		if (!$this->customer->login($mail, $password)) {
			$json['error'] = $this->language->get('error_popup_login');
		} else {
			$json['redirect'] = $this->url->link('account/account', '', 'SSL');
		}
		
		if (!$json) {
			unset($this->session->data['guest']);
			unset($this->session->data['shipping_country_id']);	
			unset($this->session->data['shipping_zone_id']);	
			unset($this->session->data['shipping_postcode']);
			unset($this->session->data['payment_country_id']);	
			unset($this->session->data['payment_zone_id']);	
		}
		
		$this->response->setOutput(json_encode($json));	
	}
	
	public function register() {
		$this->language->load('account/register');
		$this->load->language('unishop/unishop');
		
		$this->load->model('account/customer');
		
		$this->load->model('unishop/setting');
		$settings = $this->model_unishop_setting->getSetting();
		$language_id = $this->config->get('config_language_id');
		
		$json = array();
						
		if (isset($settings['show_name']) && isset($this->request->post['firstname'])) {
			if ((utf8_strlen($this->request->post['firstname']) < 3) || (utf8_strlen($this->request->post['firstname']) > 32)) {
				$json['error']['firstname'] = $this->language->get('error_firstname');
			}
		}
			
		if (isset($settings['show_lastname']) && isset($this->request->post['lastname'])) {
			if ((utf8_strlen($this->request->post['lastname']) < 3) || (utf8_strlen($this->request->post['lastname']) > 32)) {
				$json['error']['lastname'] = $this->language->get('error_lastname');
			}
		}
		
		if (isset($settings['show_phone']) && isset($this->request->post['telephone'])) {
			if ((utf8_strlen($this->request->post['telephone']) < 3) || (utf8_strlen($this->request->post['telephone']) > 32)) {
				$json['error']['phone'] = $this->language->get('error_telephone');
			}
		}
			
		$mail = isset($this->request->post['email']) ? htmlspecialchars(strip_tags($this->request->post['email'])) : '';

		if ((utf8_strlen($mail) > 96) || !preg_match('/^[^\@]+@.*.[a-z]{2,15}$/i', $mail)) {
			$json['error']['email'] = $this->language->get('error_email');
		}
	
		if ($this->model_account_customer->getTotalCustomersByEmail($mail)) {
			$json['error']['warning'] = $this->language->get('error_exists');
		}
			
		$this->load->model('account/customer_group');
			
		if (isset($this->request->post['customer_group_id']) && is_array($this->config->get('config_customer_group_display')) && in_array($this->request->post['customer_group_id'], $this->config->get('config_customer_group_display'))) {
			$customer_group_id = $this->request->post['customer_group_id'];
		} else {
			$customer_group_id = $this->config->get('config_customer_group_id');
		}
			
		$password = isset($this->request->post['password']) ? htmlspecialchars(strip_tags($this->request->post['password'])) : '';
	
		if ((utf8_strlen($password) < 4) || (utf8_strlen($password) > 20)) {
			$json['error']['password'] = $this->language->get('error_password');
		}
			
		if(isset($settings['show_register_confirm'])) {
			if ($this->config->get('config_account_id')) {
				$this->load->model('catalog/information');
				
				$information_info = $this->model_catalog_information->getInformation($this->config->get('config_account_id'));
					
				if ($information_info && !isset($this->request->post['confirm'])) {
						$json['error']['warning'] = sprintf($this->language->get('error_agree'), $information_info['title']);
				}
			}
		}
		
		if (!$json) {
			$data['firstname'] = isset($this->request->post['firstname']) ? $this->request->post['firstname'] : '';
			$data['lastname'] = isset($this->request->post['lastname']) ? $this->request->post['lastname'] : '';
			$data['email'] = isset($this->request->post['email']) ? $this->request->post['email'] : '';
			$data['telephone'] = isset($this->request->post['telephone']) ? $this->request->post['telephone'] : '';
			$data['password'] = isset($this->request->post['password']) ? $this->request->post['password'] : '';
			$data['customer_group_id'] = isset($this->request->post['customer_group_id']) ? $this->request->post['customer_group_id'] : $this->config->get('config_customer_group_id');
			$data['fax'] = '';
			$data['company'] = '';
			$data['address_1'] = '';
			$data['address_2'] = '';
			$data['postcode'] = '';
			$data['city'] = '';
			$data['country_id'] = $this->config->get('config_country_id') ? $this->config->get('config_country_id') : 0;
			$data['zone_id'] = $this->config->get('config_zone_id') ? $this->config->get('config_zone_id') : 0;	
		
			$customer_id = $this->model_account_customer->addCustomer($data);
		
			$this->load->model('account/activity');

			$activity_data = array(
				'customer_id' => $customer_id,
				'name'        => $data['firstname'] . ' ' . $data['lastname']
			);

			$this->model_account_activity->addActivity('register', $activity_data);
		
			$this->session->data['account'] = 'register';
							  	  
			if ($this->customer->login($this->request->post['email'], $this->request->post['password'])) {
				$json['redirect'] = $this->url->link('account/account', '', 'SSL');
			}
			
			$this->load->model('account/customer_group');
			$customer_group_info = $this->model_account_customer_group->getCustomerGroup($customer_group_id);
			
			if ($customer_group_info['approval']) {
				$json['appruv'] = $this->language->get('text_appruv');
			}
			
			unset($this->session->data['guest']);
			unset($this->session->data['shipping_method']);
			unset($this->session->data['shipping_methods']);
			unset($this->session->data['payment_method']);	
			unset($this->session->data['payment_methods']);
		}	
		
		$this->response->setOutput(json_encode($json));	
	}
}
?>