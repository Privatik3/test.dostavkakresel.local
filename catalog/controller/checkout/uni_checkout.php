<?php 
class ControllerCheckoutUniCheckout extends Controller { 	
	public function index() {
	
		if(isset($this->session->data['shipping_address_id']))	{
			unset($this->session->data['shipping_address_id']);
		}
		
		$data = array();
		
		$this->document->addStyle('catalog/view/theme/unishop/stylesheet/checkout.css');
		
		$this->load->language('checkout/cart');
		$this->load->language('checkout/checkout');
		
		$this->document->setTitle($this->language->get('heading_title'));
		
		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('checkout/unicheckout', '', 'SSL')
		);
		
		$data['lang'] = array_merge($data, $this->language->load('unishop/unishop'));
		
		$this->load->model('unishop/setting');
		$settings = $this->model_unishop_setting->getSetting();
		$language_id = $this->config->get('config_language_id');
		
		$data['text_select'] = $this->language->get('text_select');
		
		$data['name_text'] = $settings[$language_id]['checkout_name_text'];
		$data['lastname_text'] = $settings[$language_id]['checkout_lastname_text'];
		$data['email_text'] = $settings[$language_id]['checkout_email_text'];
		$data['phone_text'] = $settings[$language_id]['checkout_phone_text'];
		$data['password_text'] = $settings[$language_id]['checkout_password_text'];
		$data['password_confirm_text'] = $settings[$language_id]['checkout_password_confirm_text'];
		
		$data['products_related_after'] = isset($settings['checkout_related_product_after']) ? $settings['checkout_related_product_after'] : '';
	
		$data['entry_customer_group'] = $this->language->get('entry_customer_group');
		
		$data['button_wishlist'] = $this->language->get('button_wishlist');
		$data['button_compare'] = $this->language->get('button_compare');
		$data['button_continue'] = $this->language->get('button_continue');
		
		$data['column_image'] = $this->language->get('column_image');
      	$data['column_name'] = $this->language->get('column_name');
      	$data['column_model'] = $this->language->get('column_model');
      	$data['column_quantity'] = $this->language->get('column_quantity');
		$data['column_price'] = $this->language->get('column_price');
      	$data['column_total'] = $this->language->get('column_total');
		$data['column_total'] = $this->language->get('column_total');
		$data['text_your_details'] = $this->language->get('text_your_details');

		if (!isset($this->session->data['guest']['customer_group_id'])) {
			$this->session->data['guest']['customer_group_id'] = (int)$this->config->get('config_customer_group_id');
		}
		
		if (!$this->cart->hasProducts() && empty($this->session->data['vouchers'])) {
			$this->response->redirect($this->url->link('checkout/cart'));
		}
		
		if (!$this->cart->hasStock() && (!$this->config->get('config_stock_checkout') || $this->config->get('config_stock_warning'))) {
			$data['error_warning'] = $this->language->get('error_stock');
		}
		
		if ($this->customer->isLogged())	{
			$data['customer_id'] = $this->session->data['customer_id'];
				//cleanup previous incomplete checkout attempts
				unset($this->session->data['shipping_method']);							
				unset($this->session->data['shipping_methods']);
				unset($this->session->data['shipping_address']);
				unset($this->session->data['shipping_address_id']);
				unset($this->session->data['payment_address']);
				unset($this->session->data['payment_address_id']);
				unset($this->session->data['payment_method']);	
				unset($this->session->data['payment_methods']);

				unset($this->session->data['guest']);
				unset($this->session->data['account']);
				unset($this->session->data['shipping_country_id']);
				unset($this->session->data['shipping_zone_id']);
				unset($this->session->data['payment_country_id']);
				unset($this->session->data['payment_zone_id']);

				//if customer account was created by checkout module then delete it
				//$this->deleteCustomer($this->session->data['customer_id']);
				//unset($this->session->data['checkout_customer_id']);
		}

		$data['firstname'] = isset($this->session->data['firstname']) ? $this->session->data['firstname'] : '';
		$data['lastname'] = isset($this->session->data['lastname']) ? $this->session->data['lastname'] : '';
		$data['email'] = isset($this->session->data['email']) ? $this->session->data['email'] : '';
		$data['telephone'] = isset($this->session->data['telephone']) ? $this->session->data['telephone'] : '';
				
		if ($this->customer->isLogged()){
			$this->load->model('account/address');
			$data['firstname'] = $this->customer->getFirstName();
			$data['lastname'] = $this->customer->getLastName();
			$data['email'] = $this->customer->getEmail();
			$data['telephone'] = $this->customer->getTelephone();
		}
		
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
		
		$data['customer_group_id'] = isset($this->session->data['guest']['customer_group_id']) ? $this->session->data['guest']['customer_group_id'] : $this->config->get('config_customer_group_id');
		
		$this->load->model('account/custom_field');
		$data['custom_fields'] = $this->model_account_custom_field->getCustomFields($this->config->get('config_customer_group_id'));
		
		$data['is_logged'] = $this->customer->isLogged() ? true : false;
		$data['is_shipping'] = $this->cart->hasShipping() ? true : false;
		
		$data['address'] = $this->address();
		$data['shipping_method'] = $this->shipping_method();
		$data['payment_method'] = $this->payment_method();
		$data['cart'] = $this->cart();
		
		$data['agree'] = isset($this->session->data['agree']) ? $this->session->data['agree'] : '';
		
		if ($this->config->get('config_checkout_id')) {
			$this->load->model('catalog/information');

			$information_info = $this->model_catalog_information->getInformation($this->config->get('config_checkout_id'));

			if ($information_info) {
				$data['text_agree'] = sprintf($this->language->get('text_agree'), $this->url->link('information/information/agree', 'information_id=' . $this->config->get('config_checkout_id'), 'SSL'), $information_info['title'], $information_info['title']);
			} else {
				$data['text_agree'] = '';
			}
		} else {
			$data['text_agree'] = '';
		}
		
		$data['checkout_guest'] = $this->config->get('config_checkout_guest');
	
		$data['comment'] = isset($this->session->data['comment']) ? $this->session->data['comment'] : '';
		
		$data['show_lastname'] = isset($settings['checkout_lastname']) ? $settings['checkout_lastname'] : '';
		$data['show_email'] = isset($settings['checkout_email']) ? $settings['checkout_email'] : '';
		$data['show_phone'] = isset($settings['checkout_phone']) ? $settings['checkout_phone'] : '';
		$data['checkout_phone_mask'] = isset($settings['checkout_phone_mask']) ? $settings['checkout_phone_mask'] : '';
		$data['show_password_confirm'] = isset($settings['checkout_password_confirm']) ? $settings['checkout_password_confirm'] : '';
		
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');
		
		if (VERSION >= 2.2) {
			$this->response->setOutput($this->load->view('checkout/uni_checkout', $data));
		} else {
			$this->response->setOutput($this->load->view('unishop/template/checkout/uni_checkout.tpl', $data));
		}
  	}
	
	public function validate() {
		$this->load->language('checkout/cart');
		$this->load->language('checkout/checkout');
		
		$this->load->model('unishop/setting');
		$settings = $this->model_unishop_setting->getSetting();
		$language_id = $this->config->get('config_language_id');
		
		$this->load->model('account/custom_field');
		$this->load->model('account/customer');
		$this->load->model('account/customer_group');
		
		$json = array();
		
		if (!$this->cart->getProducts() || !$this->cart->hasStock() && (!$this->config->get('config_stock_checkout') || $this->config->get('config_stock_warning'))) {
			$json['error']['error_warning'] = $this->language->get('error_stock');
		}
		
		//user
		if (isset($this->request->post['firstname']) && ((utf8_strlen(trim($this->request->post['firstname'])) < 1) || (utf8_strlen(trim($this->request->post['firstname'])) > 32))) {
			$json['error']['firstname'] = $this->language->get('error_firstname');
		} else {
			$this->session->data['firstname'] = htmlspecialchars(strip_tags($this->request->post['firstname']));
		}
		
		if(isset($settings['checkout_lastname'])) {
			if (isset($this->request->post['lastname']) && ((utf8_strlen(trim($this->request->post['lastname'])) < 1) || (utf8_strlen(trim($this->request->post['lastname'])) > 32))) {
				$json['error']['lastname'] = $this->language->get('error_lastname');
			} else {
				$this->session->data['lastname'] = htmlspecialchars(strip_tags($this->request->post['lastname']));
			}
		} else {
			$this->session->data['lastname'] = $this->customer->isLogged() ? $this->customer->getLastName() : '';
		}
		
		if(isset($settings['checkout_email'])) {
			if (isset($this->request->post['email']) && ((utf8_strlen($this->request->post['email']) > 96) || !preg_match('/^[^\@]+@.*.[a-z]{2,15}$/i', $this->request->post['email']))) {
				$json['error']['email'] = $this->language->get('error_email');
			} else {
				$this->session->data['email'] = htmlspecialchars(strip_tags($this->request->post['email']));
			}
		} else {
			$this->session->data['email'] = $this->customer->isLogged() ? $this->customer->getEmail() : $settings['checkout_mail_cap'];
		}
		
		if(!$this->customer->isLogged() && isset($this->request->post['register'])) {
			if (isset($this->request->post['email']) && ($this->model_account_customer->getTotalCustomersByEmail($this->request->post['email']))) {
				$json['error']['warning'] = $this->language->get('error_exists');
			}
		}
		
		if(isset($settings['checkout_phone'])) {
			if (isset($this->request->post['telephone']) && ((utf8_strlen($this->request->post['telephone']) < 3) || (utf8_strlen($this->request->post['telephone']) > 32))) {
				$json['error']['telephone'] = $this->language->get('error_telephone');
			} else {
				$this->session->data['telephone'] = htmlspecialchars(strip_tags($this->request->post['telephone']));
			}
		} else {
			$this->session->data['telephone'] = $this->customer->isLogged() ? $this->customer->getTelephone() : '';
		}
		
		if(!$this->customer->isLogged() && isset($this->request->post['register'])) {
			if (isset($this->request->post['register']) && ((utf8_strlen($this->request->post['password']) < 4) || (utf8_strlen($this->request->post['password']) > 20))) {
				$json['error']['password'] = $this->language->get('error_password');
			}
			
			if(isset($settings['checkout_password_confirm'])) {
				if (isset($this->request->post['confirm']) && ($this->request->post['confirm'] != $this->request->post['password'])) {
					$json['error']['confirm'] = $this->language->get('error_confirm');
				}
			}
		}
		
		if($this->customer->isLogged()) {
			$customer_group_id = $this->customer->getGroupId();
		} else {
			if (isset($this->request->post['customer_group_id']) && is_array($this->config->get('config_customer_group_display')) && in_array($this->request->post['customer_group_id'], $this->config->get('config_customer_group_display'))) {
				$customer_group_id = $this->request->post['customer_group_id'];
			} else {
				$customer_group_id = $this->config->get('config_customer_group_id');
			}
		}
		
		$custom_fields = $this->model_account_custom_field->getCustomFields(array('filter_customer_group_id' => $customer_group_id));

		foreach ($custom_fields as $custom_field) {
			if ($custom_field['required'] && empty($this->request->post['custom_field'][$custom_field['location']][$custom_field['custom_field_id']])) {
				$json['error']['custom_field' . $custom_field['custom_field_id']] = sprintf($this->language->get('error_custom_field'), $custom_field['name']);
			}
		}
		
		//shipping address
		if($this->cart->hasShipping()) {
			if (isset($this->request->post['address']) && $this->request->post['address'] == 'existing') {
				$this->load->model('account/address');
						
				if (empty($this->request->post['address_id'])) {
					$json['error']['warning'] = $this->language->get('error_address');
				} elseif (!in_array($this->request->post['address_id'], array_keys($this->model_account_address->getAddresses()))) {
					$json['error']['warning'] = $this->language->get('error_address');
				}
			} else {
				if(isset($settings['checkout_country_zone'])) {
					if (!isset($this->request->post['country_id']) || ($this->request->post['country_id'] == '')) {
						$json['error']['country_id'] = $this->language->get('error_country');
					}
				}
				
				if(isset($settings['checkout_country_zone'])) {				
					if (!isset($this->request->post['zone_id']) || $this->request->post['zone_id'] == '') {
						$json['error']['zone_id'] = $this->language->get('error_zone');
					}
				}
				
				if(isset($settings['checkout_city'])) {
					if (!isset($this->request->post['city']) || ( (utf8_strlen($this->request->post['city']) < 2) || (utf8_strlen($this->request->post['city']) > 32))) {
					$json['error']['city'] = $this->language->get('error_city');
					}
				}
				
				if(isset($settings['checkout_postcode'])) {
					$this->load->model('localisation/country');
					$country_info = isset($this->request->post['country_id']) ? $this->model_localisation_country->getCountry($this->request->post['country_id']) : '';
					if ($country_info && $country_info['postcode_required'] && (utf8_strlen(trim($this->request->post['postcode'])) < 2 || utf8_strlen(trim($this->request->post['postcode'])) > 10)) {
						$json['error']['postcode'] = $this->language->get('error_postcode');
					}
				}
				
				if(isset($settings['checkout_address'])) {
					if (!isset($this->request->post['address_1']) || ( (utf8_strlen(trim($this->request->post['address_1'])) < 3) || (utf8_strlen(trim($this->request->post['address_1'])) > 128))) {
						$json['error']['address_1'] = $this->language->get('error_address_1');
					}
				}
				
				if(isset($settings['checkout_address2'])) {
					if (!isset($this->request->post['address_2']) || ((utf8_strlen(trim($this->request->post['address_2'])) < 3) || (utf8_strlen(trim($this->request->post['address_2'])) > 128))) {
						//$json['error']['address_2'] = $this->language->get('error_address_2');
					}
				}
			}		
		}
		
		//shipping method
		if ($this->cart->hasProducts() && $this->cart->hasShipping()) {
			if (!isset($this->request->post['shipping_method'])) {
				$json['error']['warning'] = $this->language->get('error_shipping');
			} else {
				$shipping = explode('.', $this->request->post['shipping_method']);
				if (!isset($shipping[0]) || !isset($shipping[1])/* || !isset($this->session->data['shipping_methods'][$shipping[0]]['quote'][$shipping[1]])*/) {
					$json['error']['warning'] = $this->language->get('error_shipping');
				}
			}						
		}
		
		//payment method
		if ($this->cart->hasProducts()) {
			if (!isset($this->request->post['payment_method'])) {
				$json['error']['warning'] = $this->language->get('error_payment');
			} elseif (!isset($this->session->data['payment_methods'][$this->request->post['payment_method']])) {
				$json['error']['warning'] = $this->language->get('error_payment');
			}						
		}
		
		if ($this->config->get('config_checkout_id')) {
			$this->load->model('catalog/information');
			$information_info = $this->model_catalog_information->getInformation($this->config->get('config_checkout_id'));
				
			if ($information_info && !isset($this->request->post['agree'])) {
				$json['error']['agree'] = sprintf($this->language->get('error_agree'), $information_info['title']);
			}
		}
		
		//guest
		if (!$json && !$this->customer->isLogged()) {
			if (isset($this->request->post['customer_group_id']) && is_array($this->config->get('config_customer_group_display')) && in_array($this->request->post['customer_group_id'], $this->config->get('config_customer_group_display'))) {
				$customer_group_id = $this->request->post['customer_group_id'];
			} else {
				$customer_group_id = $this->config->get('config_customer_group_id');
			}
		
			$this->session->data['account'] = 'guest';

			$this->session->data['guest']['firstname'] = $this->session->data['firstname'];
			$this->session->data['guest']['lastname'] = $this->session->data['lastname'];
			$this->session->data['guest']['email'] = $this->session->data['email'];
			$this->session->data['guest']['telephone'] = $this->session->data['telephone'];
			$this->session->data['guest']['customer_group_id'] = $customer_group_id;
			$this->session->data['guest']['fax'] = isset($this->request->post['fax']) ? $this->request->post['fax'] : '';

			if (isset($this->request->post['custom_field']['account'])) {
				$this->session->data['guest']['custom_field'] = $this->request->post['custom_field']['account'];
			} else {
				$this->session->data['guest']['custom_field'] = array();
			}
		}
		
		// add new address for registered user
		if (!$json && $this->customer->isLogged() && isset($this->request->post['address']) && $this->request->post['address'] == 'new') {
			$this->load->model('account/address');
			$this->model_account_address->addAddress($this->request->post);
		}
		
		// new_user
		if (!$json && !$this->customer->isLogged() && isset($this->request->post['register'])) {
			$this->load->model('account/customer');
		
			$this->session->data['account'] = 'register';
			$this->session->data['checkout_customer_id'] = true;
			
			$customer_id = $this->model_account_customer->addCustomer($this->request->post);
			$this->customer->login($this->request->post['email'], $this->request->post['password']);

			$customer_info = $this->model_account_customer->getCustomer($customer_id);

			$this->session->data['customer_id'] = $customer_id;
			$this->session->data['customer_group_id'] = $customer_info['customer_group_id'];
			
			$this->load->model('account/activity');
				
			$activity_data = array(
				'customer_id' => $customer_id,
				'name'        => $this->request->post['firstname'].' '.$this->request->post['lastname']
			);
				
			$this->model_account_activity->addActivity('register', $activity_data);
			
			unset($this->session->data['guest']);
		}
		
		$cart = (VERSION >= 2.3) ? new Cart\Cart($this->registry) : new Cart($this->registry);
		
		// checkout		
		if(!$json && $this->cart->hasProducts()) {
			$this->address();
			$json['success'] = $this->confirm();
		}
		
		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));	
	}	

	public function address() {
		$data = array();
		$this->load->language('checkout/cart');
		$this->load->language('checkout/checkout');
		$data['lang'] = array_merge($data, $this->language->load('unishop/unishop'));
		
		$this->load->model('unishop/setting');
		$settings = $this->model_unishop_setting->getSetting();
		$language_id = $this->config->get('config_language_id');
		
		$data['city_text'] = $settings[$language_id]['checkout_city_text'];
		$data['postcode_text'] = $settings[$language_id]['checkout_postcode_text'];
		$data['address_text'] = $settings[$language_id]['checkout_address_text'];
		$data['address2_text'] = $settings[$language_id]['checkout_address2_text'];
		
		$data['text_address_existing'] = $this->language->get('text_address_existing');
		$data['text_address_new'] = $this->language->get('text_address_new');
		$data['text_select'] = $this->language->get('text_select');
		$data['text_none'] = $this->language->get('text_none');
		
		$data['new_address'] = $new_address = isset($this->request->post['address']) && $this->request->post['address'] == 'new' ? true : false;
		
		if(!$this->customer->isLogged() || $new_address) {
			$address['address_1'] = isset($this->request->post['address_1']) ? $this->request->post['address_1'] : '';
			$address['address_2'] = isset($this->request->post['address_2']) ? $this->request->post['address_2'] : '';
			$address['company'] = isset($this->request->post['company']) ? $this->request->post['company'] : '';
			$address['postcode'] = isset($this->request->post['postcode']) ? $this->request->post['postcode'] : '';
			
			if(isset($this->request->post['city'])) {
				$address['city'] = $address['shipping_city'] = $this->request->post['city'];
			} elseif (isset($this->session->data['payment_address']['city'])) {
				$address['city'] = $address['shipping_city'] = $this->session->data['payment_address']['city'];
			} else {
				$address['city'] = $address['shipping_city'] = '';
			}
			
			if(isset($this->request->post['zone_id'])) {
				$address['zone_id'] = $address['zone_country_id'] = $this->request->post['zone_id'];
			} elseif (isset($this->session->data['payment_address']['country_id'])) {
				$address['zone_id'] = $address['zone_country_id'] = $this->session->data['payment_address']['zone_id'];
			} else {
				$address['zone_id'] = $address['zone_country_id'] = $this->config->get('config_zone_id');
			}
			
			if(isset($this->request->post['country_id'])) {
				$address['country_id'] = $address['shipping_country_id'] = $this->request->post['country_id'];
			} elseif (isset($this->session->data['payment_address']['country_id'])) {
				$address['country_id'] = $address['shipping_country_id'] = $this->session->data['payment_address']['country_id'];
			} else {
				$address['country_id'] = $address['shipping_country_id'] = $this->config->get('config_country_id');
			}
//zone		
			$this->load->model('localisation/zone');	
			$zone_info = $this->model_localisation_zone->getZone($address['zone_id']);
			
			$address['zone'] = $zone_info ? $zone_info['name'] : 0;
			$address['zone_code'] = $zone_info ? $zone_info['code'] : '';
//country
			$this->load->model('localisation/country');
			$country_info = $this->model_localisation_country->getCountry($address['country_id']);
			
			$address['country'] = $country_info ? $country_info['name'] : '';
			$address['iso_code_2'] = $country_info ? $country_info['iso_code_2'] : '';
			$address['iso_code_3'] = $country_info ? $country_info['iso_code_3'] : '';
			$address['address_format'] = $country_info ? $country_info['address_format'] : '';
		}
		
		$existing_address = isset($this->request->post['address']) && $this->request->post['address'] == 'existing' ? true : false;
		
		if(($this->customer->isLogged() && !$new_address && !$existing_address) || ($this->customer->isLogged() && $existing_address)) {
			$this->load->model('account/address');	
			$data['address_id'] = $address_id = isset($this->request->post['address_id']) ? $this->request->post['address_id'] : $this->customer->getAddressId();
			$this->session->data['payment_address_id'] = $this->session->data['shipping_address_id'] = $address_id;
			$address = $this->model_account_address->getAddress($address_id);
		}
		
		$this->session->data['shipping_address'] = $this->session->data['payment_address'] = $address;
		
		$this->session->data['ship_meth'] = isset($this->request->post['shipping_method']) ? $this->request->post['shipping_method'] : '';
		$this->session->data['pay_meth'] = isset($this->request->post['payment_method']) ? $this->request->post['payment_method'] : '';
		
		$this->session->data['comment'] = isset($this->request->post['comment']) ? $this->request->post['comment'] : '';
		
		$data['customer_id'] = $this->customer->isLogged() ? $this->customer->getId() : '';
		$data['is_shipping'] = $this->cart->hasShipping() ? true : false;
		
		$data['addresses'] = array();
		$this->load->model('account/address');
		$data['addresses'] = $this->model_account_address->getAddresses();
		
		$this->load->model('localisation/country');
		$data['countries'] = $this->model_localisation_country->getCountries();
		
		$data['city'] = $address['city'];
		$data['postcode'] = $address['postcode'];
		$data['address_1'] = $address['address_1'];
		$data['address_2'] = $address['address_2'];
		
		$data['country'] = $address['country'];
		$data['country_id'] = $address['country_id'];
		$data['zone'] = $address['zone'];
		$data['zone_id'] = $address['zone_id'];
		$data['iso_code_2'] = $address['iso_code_2'];
		$data['iso_code_3'] = $address['iso_code_3'];
		$data['address_format'] = $address['address_format'];
		
		$data['show_country_zone'] = isset($settings['checkout_country_zone']) ? $settings['checkout_country_zone'] : '';
		$data['show_city'] = isset($settings['checkout_city']) ? $settings['checkout_city'] : '';
		$data['show_postcode'] = isset($settings['checkout_postcode']) ? $settings['checkout_postcode'] : '';
		$data['show_address'] = isset($settings['checkout_address']) ? $settings['checkout_address'] : '';
		$data['show_address2'] = isset($settings['checkout_address2']) ? $settings['checkout_address2'] : '';
		
		$result = (VERSION >= 2.2) ? $this->load->view('checkout/uni_address', $data) : $this->load->view('unishop/template/checkout/uni_address.tpl', $data);

		if(isset($this->request->get['render'])) {
			$this->response->setOutput($result);
		} else {
			return $result;
		}
	}

	public function shipping_method() {
		$data = array();
		$data['lang'] = array_merge($data, $this->language->load('unishop/unishop'));
		$this->load->language('checkout/checkout');
		$shipping_address = isset($this->session->data['shipping_address']) ? $this->session->data['shipping_address'] : array('country_id' => $this->config->get('config_country_id'), 'zone_id' => $this->config->get('config_zone_id'), 'firstname' => '', 'lastname' => '', 'company' => '', 'address_1' => '', 'city' => '', 'iso_code2' => '', 'iso_code3' => '');
		
		$method_data = array();

		if ($shipping_address) {
			$this->tax->setShippingAddress($shipping_address['country_id'], $shipping_address['zone_id']);
			
			$this->load->model('extension/extension');
			$results = $this->model_extension_extension->getExtensions('shipping');
			
			foreach ($results as $result) {
				if ($this->config->get($result['code'] . '_status')) {
					if(VERSION >= 2.2) {
						$this->load->model('extension/shipping/' . $result['code']);
						$quote = $this->{'model_extension_shipping_' . $result['code']}->getQuote($shipping_address);
					} else {
						$this->load->model('shipping/' . $result['code']);
						$quote = $this->{'model_shipping_' . $result['code']}->getQuote($shipping_address);
					}
					
					if ($quote) {
						$method_data[$result['code']] = array(
							'title'      => $quote['title'],
							'quote'      => $quote['quote'],
							'sort_order' => $quote['sort_order'],
							'error'      => $quote['error']
						);
					}
				}
			}

			$sort_order = array();

			foreach ($method_data as $key => $value) {
				$sort_order[$key] = $value['sort_order'];
			}

			array_multisort($sort_order, SORT_ASC, $method_data);
		}
		
		$data['shipping_methods'] = $this->session->data['shipping_methods'] = $method_data;
		
		$shipping = explode('.', $this->session->data['ship_meth']);
		
		if(isset($shipping[0]) && isset($shipping[1]) && isset($method_data[$shipping[0]]['quote'][$shipping[1]])) {
			$this->session->data['shipping_method'] = $method_data[$shipping[0]]['quote'][$shipping[1]];
		}
		
		$data['code'] = isset($this->session->data['shipping_method']['code']) ? $this->session->data['shipping_method']['code'] : '';
		
		$data['error_warning'] = (empty($this->session->data['shipping_methods'])) ? sprintf($this->language->get('error_no_shipping'), $this->url->link('information/contact')) : '';

		$result = (VERSION >= 2.2) ? $this->load->view('checkout/uni_shipping', $data) : $this->load->view('unishop/template/checkout/uni_shipping.tpl', $data);
		if($this->cart->hasShipping()) {
			if(isset($this->request->get['render'])) {
				$this->response->setOutput($result);
			} else {
				return $result;
			}
		} else {
			return '';
		}
  	}
  	
  	public function payment_method() {
		$data = array();
		$data['lang'] = array_merge($data, $this->language->load('unishop/unishop'));
		$this->load->language('checkout/checkout');
		$payment_address = isset($this->session->data['payment_address']) ? $this->session->data['payment_address'] : array('country_id' => $this->config->get('config_country_id'), 'zone_id' => $this->config->get('config_zone_id'), 'firstname' => '', 'lastname' => '', 'company' => '', 'address_1' => '', 'city' => '', 'iso_code2' => '', 'iso_code3' => '');
		
		if (!isset($this->session->data['payment_zone_id'])) { 
			$this->session->data['payment_zone_id '] = $payment_address['zone_id'];
		}
		
		$this->tax->setPaymentAddress($payment_address['country_id'], $payment_address['zone_id']);
		
		$method_data = array();

		if ($payment_address) {
			// Totals
			$total_data = array();					
			$total = 0;
			$taxes = $this->cart->getTaxes();
			
			if(VERSION >= 2.2) {
				$total_data = array(
					'totals' => &$totals,
					'taxes'  => &$taxes,
					'total'  => &$total
				);
			}
			
			$this->load->model('extension/extension');
			$results = $this->model_extension_extension->getExtensions('total');
			
			$sort_order = array(); 
			
			foreach ($results as $key => $value) {
				$sort_order[$key] = $this->config->get($value['code'] . '_sort_order');
			}
			
			array_multisort($sort_order, SORT_ASC, $results);
			
			foreach ($results as $result) {
				if ($this->config->get($result['code'] . '_status')) {
					if(VERSION >= 2.2) {
						$this->load->model('extension/total/' . $result['code']);
						$this->{'model_extension_total_' . $result['code']}->getTotal($total_data);
					} else {
						$this->load->model('total/' . $result['code']);
						$this->{'model_total_' . $result['code']}->getTotal($total_data, $total, $taxes);
					}
				}
			}
			
			$this->load->model('extension/extension');
			$results = $this->model_extension_extension->getExtensions('payment');
			
			$recurring = (VERSION >= 2.2) ? $this->cart->hasRecurringProducts() : method_exists($this->cart, 'hasRecurringProducts') && $this->cart->hasRecurringProducts();

			foreach ($results as $result) {
				if ($this->config->get($result['code'] . '_status')) {
					if(VERSION >= 2.2) {
						$this->load->model('extension/payment/' . $result['code']);
						$method = $this->{'model_extension_payment_' . $result['code']}->getMethod($payment_address, $total);

						if ($method) {
							if ($recurring) {
								if (property_exists($this->{'model_extension_payment_' . $result['code']}, 'recurringPayments') && $this->{'model_extension_payment_' . $result['code']}->recurringPayments()) {
									$method_data[$result['code']] = $method;
								}
							} else {
								$method_data[$result['code']] = $method;
							}
						}
					} else {
						$this->load->model('payment/' . $result['code']);
						$method = $this->{'model_payment_' . $result['code']}->getMethod($payment_address, $total); 
					
						if (isset($method['quote'])) {
							foreach ($method['quote'] as $key => $val) {
								$method_data[$val['code']] = $val;
							}
						} elseif ($method) {
							if($recurring > 0){
								if (method_exists($this->{'model_payment_' . $result['code']},'recurringPayments')) {
									if($this->{'model_payment_' . $result['code']}->recurringPayments() == true){
										$method_data[$result['code']] = $method;
									}
								}
							} else {
								$method_data[$result['code']] = $method;
							}
						}
					}
				}
			}

			$sort_order = array(); 
		  
			foreach ($method_data as $key => $value) {
				$sort_order[$key] = $value['sort_order'];
			}
	
			array_multisort($sort_order, SORT_ASC, $method_data);			
		}
		
		$this->session->data['payment_methods'] = $method_data;	
		
		$data['payment_methods'] = $method_data;
		
		if(isset($this->session->data['pay_meth']) && $this->session->data['pay_meth'] != '' && isset($method_data[$this->session->data['pay_meth']])) {
			$this->session->data['payment_method']['code'] = $this->session->data['pay_meth'];
			$this->session->data['payment_method'] = $method_data[$this->session->data['pay_meth']];
		}
		
		$data['code'] = isset($this->session->data['payment_method']['code']) ? $this->session->data['payment_method']['code'] : '';
   
		$data['error_warning'] = empty($this->session->data['payment_methods']) ? sprintf($this->language->get('error_no_payment'), $this->url->link('information/contact')) : '';
		
		$result = (VERSION >= 2.2) ? $this->load->view('checkout/uni_payment', $data) : $this->load->view('unishop/template/checkout/uni_payment.tpl', $data);
		
		if(isset($this->request->get['render'])) {
			$this->response->setOutput($result);
		} else {
			return $result;
		}
  	}
	
	public function cart(){
		$data = array();
		$this->load->language('product/product');
		$this->load->language('checkout/cart');
		$data['lang'] = array_merge($data, $this->language->load('unishop/unishop'));
		
		$this->load->model('unishop/setting');
		$settings = $this->model_unishop_setting->getSetting();
		$language_id = $this->config->get('config_language_id');
        
		if (!isset($this->session->data['vouchers'])) {
			$this->session->data['vouchers'] = array();
		}
			
		$points = $this->customer->getRewardPoints();
		$points_total = 0;
			
		foreach ($this->cart->getProducts() as $product) {
			if ($product['points']) {
				$points_total += $product['points'];
			}
		}		
		$data['text_tax'] = $this->language->get('text_tax');
		$data['text_next_choice'] = $this->language->get('text_next_choice');
     	$data['text_use_coupon'] = $this->language->get('text_use_coupon');
		$data['text_use_voucher'] = $this->language->get('text_use_voucher');
		$data['text_use_reward'] = sprintf($this->language->get('text_use_reward'), $points);
		$data['text_shipping_estimate'] = $this->language->get('text_shipping_estimate');
		$data['text_shipping_detail'] = $this->language->get('text_shipping_detail');
		$data['text_shipping_method'] = $this->language->get('text_shipping_method');
		$data['text_select'] = $this->language->get('text_select');
		$data['text_none'] = $this->language->get('text_none');
		$data['text_until_cancelled'] = $this->language->get('text_until_cancelled');
		$data['text_freq_day'] = $this->language->get('text_freq_day');
		$data['text_freq_week'] = $this->language->get('text_freq_week');
		$data['text_freq_month'] = $this->language->get('text_freq_month');
		$data['text_freq_bi_month'] = $this->language->get('text_freq_bi_month');
		$data['text_freq_year'] = $this->language->get('text_freq_year');

		$data['column_image'] = $this->language->get('column_image');
      	$data['column_name'] = $this->language->get('column_name');
      	$data['column_model'] = $this->language->get('column_model');
      	$data['column_quantity'] = $this->language->get('column_quantity');
		$data['column_price'] = $this->language->get('column_price');
      	$data['column_total'] = $this->language->get('column_total');
			
		$data['entry_coupon'] = $this->language->get('entry_coupon');
		$data['entry_voucher'] = $this->language->get('entry_voucher');
		$data['entry_reward'] = sprintf($this->language->get('entry_reward'), $points_total);
		$data['entry_country'] = $this->language->get('entry_country');
		$data['entry_zone'] = $this->language->get('entry_zone');
		$data['entry_postcode'] = $this->language->get('entry_postcode');
						
		$data['button_update'] = $this->language->get('button_update');
		$data['button_remove'] = $this->language->get('button_remove');
		$data['button_coupon'] = $this->language->get('button_coupon');
		$data['button_voucher'] = $this->language->get('button_voucher');
		$data['button_reward'] = $this->language->get('button_reward');
		$data['button_quote'] = $this->language->get('button_quote');
		$data['button_shipping'] = $this->language->get('button_shipping');			
      	$data['button_shopping'] = $this->language->get('button_shopping');
      	$data['button_checkout'] = $this->language->get('button_checkout');

      	$data['text_trial'] = $this->language->get('text_trial');
      	$data['text_recurring'] = $this->language->get('text_recurring');
      	$data['text_length'] = $this->language->get('text_length');
      	$data['text_recurring_item'] = $this->language->get('text_recurring_item');
      	$data['text_payment_profile'] = $this->language->get('text_payment_profile');
		$data['text_cart'] = $this->language->get('text_cart');
		$data['button_cart'] = $this->language->get('button_cart');
		$data['button_wishlist'] = $this->language->get('button_wishlist');
		$data['button_compare'] = $this->language->get('button_compare');

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} elseif (!$this->cart->hasStock() && (!$this->config->get('config_stock_checkout') || $this->config->get('config_stock_warning'))) {
      		$data['error_warning'] = $this->language->get('error_stock');		
		} else {
			$data['error_warning'] = '';
		}
			
		if ($this->config->get('config_customer_price') && !$this->customer->isLogged()) {
			$data['attention'] = sprintf($this->language->get('text_login'), $this->url->link('account/login'), $this->url->link('account/register'));
		} else {
			$data['attention'] = '';
		}
						
		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];
			unset($this->session->data['success']);
		} else {
			$data['success'] = '';
		}
		
		$currency = (VERSION >= 2.2) ? $this->session->data['currency'] : '';
						
		$data['weight'] = $this->config->get('config_cart_weight') ? $this->weight->format($this->cart->getWeight(), $this->config->get('config_weight_class_id'), $this->language->get('decimal_point'), $this->language->get('thousand_point')) : '';
						 
		$this->load->model('tool/image');

        $data['products'] = array();

        $products = $this->cart->getProducts();
			
        foreach ($products as $product) {
            $product_total = 0;

            foreach ($products as $product_2) {
                if ($product_2['product_id'] == $product['product_id']) {
                    $product_total += $product_2['quantity'];
                }
            }

            if ($product['minimum'] > $product_total) {
                $data['error_warning'] = sprintf($this->language->get('error_minimum'), $product['name'], $product['minimum']);
			}

            if ($product['image']) {
				if(VERSION >= 2.2) {
					$image = $this->model_tool_image->resize($product['image'], $this->config->get($this->config->get('config_theme') . '_image_cart_width'), $this->config->get($this->config->get('config_theme') . '_image_cart_height'));
				} else {
					$image = $this->model_tool_image->resize($product['image'], $this->config->get('config_image_cart_width'), $this->config->get('config_image_cart_height'));
				}
			} else {
                $image = '';
            }

            $option_data = array();

            foreach ($product['option'] as $option) {
                if ($option['type'] != 'file') {
					if (isset($option['option_value']))	{
						$value = $option['option_value'];
					} else if (isset($option['value']))	{
						$value = $option['value'];
					} else {
						$value = '';
					}
                } else {
                    $filename = $this->encryption->decrypt(isset($option['option_value'])?$option['option_value']:isset($option['value'])?$option['value']:'');
					$value = utf8_substr($filename, 0, utf8_strrpos($filename, '.'));
                }

                $option_data[] = array(
                    'name'  => $option['name'],
                    'value' => (utf8_strlen($value) > 20 ? utf8_substr($value, 0, 20) . '..' : $value)
                );
            }

            if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
                $price = $this->currency->format($this->tax->calculate($product['price'], $product['tax_class_id'], $this->config->get('config_tax')), $currency);
            } else {
                $price = false;
            }

			if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
                $total = $this->currency->format($this->tax->calculate($product['price'], $product['tax_class_id'], $this->config->get('config_tax')) * $product['quantity'], $currency);
            } else {
                $total = false;
            }
                
            $profile_description = '';
                
            if (isset($product['recurring']) && $product['recurring']) {
                $frequencies = array(
                    'day' => $this->language->get('text_day'),
                    'week' => $this->language->get('text_week'),
                    'semi_month' => $this->language->get('text_semi_month'),
                    'month' => $this->language->get('text_month'),
                    'year' => $this->language->get('text_year'),
                );

                if (isset($product['recurring_trial']) && $product['recurring_trial']) {
                    $recurring_price = $this->currency->format($this->tax->calculate($product['recurring_trial_price'] * $product['quantity'], $product['tax_class_id'], $this->config->get('config_tax')));
                    $profile_description = sprintf($this->language->get('text_trial_description'), $recurring_price, $product['recurring_trial_cycle'], $frequencies[$product['recurring_trial_frequency']], $product['recurring_trial_duration']) . ' ';
                }

                $recurring_price = $this->currency->format($this->tax->calculate($product['recurring_price'] * $product['quantity'], $product['tax_class_id'], $this->config->get('config_tax')));

                if ($product['recurring_duration']) {
                    $profile_description .= sprintf($this->language->get('text_payment_description'), $recurring_price, $product['recurring_cycle'], $frequencies[$product['recurring_frequency']], $product['recurring_duration']);
                } else {
                    $profile_description .= sprintf($this->language->get('text_payment_until_canceled_description'), $recurring_price, $product['recurring_cycle'], $frequencies[$product['recurring_frequency']], $product['recurring_duration']);
                }
            }

            $data['products'][] = array(
				'cart_id'  			  => $product['cart_id'],
                'product_id'          => $product['product_id'],
                'thumb'               => $image,
                'name'                => $product['name'],
                'model'               => $product['model'],
                'option'              => $option_data,
                'quantity'            => $product['quantity'],
                'stock'               => $product['stock'] ? true : !(!$this->config->get('config_stock_checkout') || $this->config->get('config_stock_warning')),
                'reward'              => ($product['reward'] ? sprintf($this->language->get('text_points'), $product['reward']) : ''),
                'price'               => $price,
                'total'               => $total,
                'href'                => $this->url->link('product/product', 'product_id=' . $product['product_id']),
                'remove'              => $this->url->link('checkout/cart', 'remove=' . $product['product_id']),
                'recurring'           => isset($product['recurring'])?$product['recurring']:'',
                'profile_name'        => isset($product['profile_name'])?$product['profile_name']:'',
                'profile_description' => $profile_description,
            );
		}
			
		$data['related'] = isset($settings['checkout_related_product']) ? $settings['checkout_related_product'] : '';
		$data['checkout_related_text'] = isset($settings[$language_id]['checkout_related_text']) ? $settings[$language_id]['checkout_related_text'] : '';
		$data['show_options'] = isset($settings['show_options']) ? $settings['show_options'] : '';
		$data['show_options_item'] = $settings['show_options_item'];
		$data['show_stock_status'] = isset($settings['show_stock_status']) ? $settings['show_stock_status'] : '';
		$data['wishlist_btn_disabled'] = isset($settings['wishlist_btn_disabled']) ? $settings['wishlist_btn_disabled'] : '';
		$data['compare_btn_disabled'] = isset($settings['compare_btn_disabled']) ? $settings['compare_btn_disabled'] : '';
		$data['products_related'] = $this->products_related();
		$data['products_related_after'] = isset($settings['checkout_related_product_after']) ? $settings['checkout_related_product_after'] : '';

        $data['products_recurring'] = array();
            
		$data['vouchers'] = array();
		if (!empty($this->session->data['vouchers'])) {
			foreach ($this->session->data['vouchers'] as $key => $voucher) {
				$data['vouchers'][] = array(
					'key'         => $key,
					'description' => $voucher['description'],
					'amount'      => $this->currency->format($voucher['amount']),
					'remove'      => $this->url->link('checkout/cart', 'remove=' . $key)   
				);
			}
		}
						 
		$data['coupon_status'] = $this->config->get('coupon_status');
			
		if (isset($this->request->post['coupon'])) {
			$data['coupon'] = $this->request->post['coupon'];			
		} elseif (isset($this->session->data['coupon'])) {
			$data['coupon'] = $this->session->data['coupon'];
		} else {
			$data['coupon'] = '';
		}
			
		$data['voucher_status'] = $this->config->get('voucher_status');
			
		if (isset($this->request->post['voucher'])) {
			$data['voucher'] = $this->request->post['voucher'];				
		} elseif (isset($this->session->data['voucher'])) {
			$data['voucher'] = $this->session->data['voucher'];
		} else {
			$data['voucher'] = '';
		}
			
		$data['reward_status'] = ($points && $points_total && $this->config->get('reward_status'));
			
		if (isset($this->request->post['reward'])) {
			$data['reward'] = $this->request->post['reward'];				
		} elseif (isset($this->session->data['reward'])) {
			$data['reward'] = $this->session->data['reward'];
		} else {
			$data['reward'] = '';
		}							
		
		$this->load->model('extension/extension');
			
		$total_data = array();					
		$total = 0;
		$taxes = $this->cart->getTaxes();
		
		if(VERSION >= 2.2) {
			$totals = array();
		
			$total_data = array(
				'totals' => &$totals,
				'taxes'  => &$taxes,
				'total'  => &$total
			);
		}
			 
		$results = $this->model_extension_extension->getExtensions('total');
			
		$sort_order = array(); 
			
		foreach ($results as $key => $value) {
			$sort_order[$key] = $this->config->get($value['code'].'_sort_order');
		}
			
		array_multisort($sort_order, SORT_ASC, $results);
			
		foreach ($results as $result) {
			if ($this->config->get($result['code'] . '_status')) {
				if(VERSION >= 2.2) {
					$this->load->model('extension/total/' . $result['code']);
					$this->{'model_extension_total_' . $result['code']}->getTotal($total_data);
				} else {
					$this->load->model('total/' . $result['code']);
					$this->{'model_total_' . $result['code']}->getTotal($total_data, $total, $taxes);
				}
			}
		}
			
		$sort_order = array(); 
		
		if(VERSION >= 2.2) {
			foreach ($totals as $key => $value) {
				$sort_order[$key] = $value['sort_order'];
			}
			array_multisort($sort_order, SORT_ASC, $totals);
		} else {
			foreach ($total_data as $key => $value) {
				$sort_order[$key] = $value['sort_order'];
			}
			array_multisort($sort_order, SORT_ASC, $total_data);
		}
		
		$data['totals'] = array();
		
		if(VERSION >= 2.2) {
			foreach ($totals as $total) {
				$data['totals'][] = array(
					'title' => $total['title'],
					'text'  => $this->currency->format($total['value'], $this->session->data['currency'])
				);
			}
		} else {
			foreach ($total_data as $total) {
				$data['totals'][] = array(
					'title' => $total['title'],
					'text'  => $this->currency->format($total['value'], $this->session->data['currency'])
				);
			}
		}
		
		$result = (VERSION >= 2.2) ? $this->load->view('checkout/uni_cart', $data) : $this->load->view('unishop/template/checkout/uni_cart.tpl', $data);
		
		if(isset($this->request->get['render'])) {
			$this->response->setOutput($result);
		} else {
			return $result;
		}
	}
	
	public function cart_edit() {
		$json = array();
		if (!empty($this->request->post['quantity'])) {
			foreach ($this->request->post['quantity'] as $key => $value) {
				$this->cart->update($key, $value);
			}
			unset($this->session->data['shipping_method']);
			unset($this->session->data['shipping_methods']);
			unset($this->session->data['payment_method']);
			unset($this->session->data['payment_methods']);
			unset($this->session->data['reward']);
		}
		
		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
		
	private function confirm() {
		$data['payment'] = '';
		$data['products'] = '';
		$redirect = '';

		$this->load->language('checkout/checkout');
		
		$data['text_cart'] = $this->language->get('text_cart');

		if (!$this->cart->hasShipping()) {
			unset($this->session->data['shipping_address']);
			unset($this->session->data['shipping_method']);
			unset($this->session->data['shipping_methods']);
		}
		
		$currency = (VERSION >= 2.2) ? $this->session->data['currency'] : '';

		$products = $this->cart->getProducts();

		foreach ($products as $product) {
			$product_total = 0;

			foreach ($products as $product_2) {
				if ($product_2['product_id'] == $product['product_id']) {
					$product_total += $product_2['quantity'];
				}
			}

			if ($product['minimum'] > $product_total) {
				$redirect = $this->url->link('checkout/cart');
				break;
			}
		}

		$order_data = array();
		
		$total_data = array();
		$total = 0;
		$taxes = $this->cart->getTaxes();
		
		if(VERSION >= 2.2) {
			$totals = array();
		
			$total_data = array(
				'totals' => &$totals,
				'taxes'  => &$taxes,
				'total'  => &$total
			);
		}

		$this->load->model('extension/extension');

		$sort_order = array();

		$results = $this->model_extension_extension->getExtensions('total');

		foreach ($results as $key => $value) {
			$sort_order[$key] = $this->config->get($value['code'] . '_sort_order');
		}

		array_multisort($sort_order, SORT_ASC, $results);

		foreach ($results as $result) {
			if ($this->config->get($result['code'] . '_status')) {
				if(VERSION >= 2.2) {
					$this->load->model('extension/total/' . $result['code']);
					$this->{'model_extension_total_' . $result['code']}->getTotal($total_data);
				} else {
					$this->load->model('total/' . $result['code']);
					$this->{'model_total_' . $result['code']}->getTotal($total_data, $total, $taxes);
				}
			}
		}

		$sort_order = array(); 

		if(VERSION >= 2.2) {
			foreach ($totals as $key => $value) {
				$sort_order[$key] = $value['sort_order'];
			}
			array_multisort($sort_order, SORT_ASC, $totals);
			$order_data['totals'] = $totals;
		} else {
			foreach ($total_data as $key => $value) {
				$sort_order[$key] = $value['sort_order'];
			}
			array_multisort($sort_order, SORT_ASC, $total_data);
			$order_data['totals'] = $total_data;
		}

		$order_data['invoice_prefix'] = $this->config->get('config_invoice_prefix');
		$order_data['store_id'] = $this->config->get('config_store_id');
		$order_data['store_name'] = $this->config->get('config_name');

		if ($order_data['store_id']) {
			$order_data['store_url'] = $this->config->get('config_url');
		} else {
			$order_data['store_url'] = $this->config->get('config_secure') ? HTTPS_SERVER : HTTP_SERVER;
		}
		
		if ($this->request->server['REQUEST_METHOD'] == 'POST' && $this->request->post != '') {
		
			$order_data['firstname'] = $this->session->data['firstname'];
			$order_data['lastname'] = $this->session->data['lastname'];
			$order_data['email'] = $this->session->data['email'];
			$order_data['telephone'] = $this->session->data['telephone'];
		
			if ($this->customer->isLogged()) {
				$this->load->model('account/customer');
				$customer_info = $this->model_account_customer->getCustomer($this->customer->getId());

				$order_data['customer_id'] = $this->customer->getId();
				$order_data['customer_group_id'] = $customer_info['customer_group_id'];
				$order_data['fax'] = $customer_info['fax'];
				$order_data['custom_field'] = ($customer_info['custom_field'] && $customer_info['custom_field'] != '[]') ? unserialize($customer_info['custom_field']) : array();
			} elseif (isset($this->session->data['guest'])) {
				$order_data['customer_id'] = 0;
				$order_data['customer_group_id'] = isset($this->session->data['guest']['customer_group_id'])?$this->session->data['guest']['customer_group_id']:$this->config->get('config_customer_group_id');
				$order_data['fax'] = isset($this->session->data['guest']['fax']) ? $this->session->data['guest']['fax'] : '';
				$order_data['custom_field'] = isset($this->session->data['guest']['custom_field']) ? $this->session->data['guest']['custom_field'] : array();
			}

			$order_data['payment_firstname'] = $order_data['firstname'];
			$order_data['payment_lastname'] = $order_data['lastname'];
			$order_data['payment_company'] = $this->session->data['payment_address']['company'];
			$order_data['payment_city'] = $this->session->data['payment_address']['city'];
			$order_data['payment_postcode'] = $this->session->data['payment_address']['postcode'];
			$order_data['payment_zone'] = $this->session->data['payment_address']['zone'];
			$order_data['payment_zone_id'] = $this->session->data['payment_address']['zone_id'];
			$order_data['payment_country'] = $this->session->data['payment_address']['country'];
			$order_data['payment_country_id'] = $this->session->data['payment_address']['country_id'];
			$order_data['payment_address_format'] = $this->session->data['payment_address']['address_format'];
			$order_data['payment_custom_field'] = (isset($this->session->data['payment_address']['custom_field']) ? $this->session->data['payment_address']['custom_field'] : array());
			$order_data['payment_address_1'] =  $this->session->data['payment_address']['address_1'];
			$order_data['payment_address_2'] =  $this->session->data['payment_address']['address_2'];

			$order_data['payment_method'] = isset($this->session->data['payment_method']['title']) ? $this->session->data['payment_method']['title'] : '';
			$order_data['payment_code'] = isset($this->session->data['payment_method']['code']) ? $this->session->data['payment_method']['code'] : '';

			if ($this->cart->hasShipping()) {
				$order_data['shipping_firstname'] = $order_data['firstname'];
				$order_data['shipping_lastname'] = $order_data['lastname'];
				$order_data['shipping_company'] = $this->session->data['shipping_address']['company'];
				$order_data['shipping_city'] = $this->session->data['shipping_address']['city'];
				$order_data['shipping_postcode'] = $this->session->data['shipping_address']['postcode'];
				$order_data['shipping_zone'] = $this->session->data['shipping_address']['zone'];
				$order_data['shipping_zone_id'] = $this->session->data['shipping_address']['zone_id'];
				$order_data['shipping_country'] = $this->session->data['shipping_address']['country'];
				$order_data['shipping_country_id'] = $this->session->data['shipping_address']['country_id'];
				$order_data['shipping_address_format'] = $this->session->data['shipping_address']['address_format'];
				$order_data['shipping_custom_field'] = (isset($this->session->data['shipping_address']['custom_field']) ? $this->session->data['shipping_address']['custom_field'] : array());
				$order_data['shipping_address_1'] = $this->session->data['shipping_address']['address_1'];
				$order_data['shipping_address_2'] = $this->session->data['shipping_address']['address_2'];

				$order_data['shipping_method'] = isset($this->session->data['shipping_method']['title']) ? $this->session->data['shipping_method']['title'] : '';
				$order_data['shipping_code'] = isset($this->session->data['shipping_method']['code']) ? $this->session->data['shipping_method']['code'] : '';
			} else {
				$order_data['shipping_firstname'] = '';
				$order_data['shipping_lastname'] = '';
				$order_data['shipping_company'] = '';
				$order_data['shipping_address_1'] = '';
				$order_data['shipping_address_2'] = '';
				$order_data['shipping_city'] = '';
				$order_data['shipping_postcode'] = '';
				$order_data['shipping_zone'] = '';
				$order_data['shipping_zone_id'] = '';
				$order_data['shipping_country'] = '';
				$order_data['shipping_country_id'] = '';
				$order_data['shipping_address_format'] = '';
				$order_data['shipping_custom_field'] = array();
				$order_data['shipping_method'] = '';
				$order_data['shipping_code'] = '';
			}

			$order_data['products'] = array();

			foreach ($this->cart->getProducts() as $product) {
				$option_data = array();

				foreach ($product['option'] as $option) {
					$option_data[] = array(
						'product_option_id'       => $option['product_option_id'],
						'product_option_value_id' => $option['product_option_value_id'],
						'option_id'               => $option['option_id'],
						'option_value_id'         => $option['option_value_id'],
						'name'                    => $option['name'],
						'value'                   => $option['value'],
						'type'                    => $option['type']
					);
				}

				$order_data['products'][] = array(
					'product_id' => $product['product_id'],
					'name'       => $product['name'],
					'model'      => $product['model'],
					'option'     => $option_data,
					'download'   => $product['download'],
					'quantity'   => $product['quantity'],
					'subtract'   => $product['subtract'],
					'price'      => $product['price'],
					'total'      => $product['total'],
					'tax'        => $this->tax->getTax($product['price'], $product['tax_class_id']),
					'reward'     => $product['reward']
				);
			}

			$order_data['vouchers'] = array();

			if (!empty($this->session->data['vouchers'])) {
				foreach ($this->session->data['vouchers'] as $voucher) {
					$order_data['vouchers'][] = array(
						'description'      => $voucher['description'],
						'code'             => substr(md5(mt_rand()), 0, 10),
						'to_name'          => $voucher['to_name'],
						'to_email'         => $voucher['to_email'],
						'from_name'        => $voucher['from_name'],
						'from_email'       => $voucher['from_email'],
						'voucher_theme_id' => $voucher['voucher_theme_id'],
						'message'          => $voucher['message'],
						'amount'           => $voucher['amount']
					);
				}
			}

			$this->session->data['comment'] = (isset($this->request->post['comment'])) ? strip_tags($this->request->post['comment']) : '';
			$order_data['comment'] = $this->session->data['comment'];
				
			$order_data['total'] = $total;

			if (isset($this->request->cookie['tracking'])) {
				$order_data['tracking'] = $this->request->cookie['tracking'];

				$subtotal = $this->cart->getSubTotal();

				$this->load->model('affiliate/affiliate');
				$affiliate_info = $this->model_affiliate_affiliate->getAffiliateByCode($this->request->cookie['tracking']);
				
				if ($affiliate_info) {
					$order_data['affiliate_id'] = $affiliate_info['affiliate_id'];
					$order_data['commission'] = ($subtotal / 100) * $affiliate_info['commission'];
				} else {
					$order_data['affiliate_id'] = 0;
					$order_data['commission'] = 0;
				}

				$this->load->model('checkout/marketing');
				$marketing_info = $this->model_checkout_marketing->getMarketingByCode($this->request->cookie['tracking']);
				
				if ($marketing_info) {
					$order_data['marketing_id'] = $marketing_info['marketing_id'];
				} else {
					$order_data['marketing_id'] = 0;
				}
			} else {
				$order_data['affiliate_id'] = 0;
				$order_data['commission'] = 0;
				$order_data['marketing_id'] = 0;
				$order_data['tracking'] = '';
			}

			$order_data['language_id'] = $this->config->get('config_language_id');
			$order_data['currency_id'] = (VERSION >= 2.2) ? $this->currency->getId($this->session->data['currency']) : $this->currency->getId();
			$order_data['currency_code'] = (VERSION >= 2.2) ? $this->session->data['currency'] : $this->currency->getCode();
			$order_data['currency_value'] = (VERSION >= 2.2) ? $this->currency->getValue($this->session->data['currency']) : $this->currency->getValue($this->currency->getCode());
			$order_data['ip'] = $this->request->server['REMOTE_ADDR'];

			if (!empty($this->request->server['HTTP_X_FORWARDED_FOR'])) {
				$order_data['forwarded_ip'] = $this->request->server['HTTP_X_FORWARDED_FOR'];
			} elseif (!empty($this->request->server['HTTP_CLIENT_IP'])) {
				$order_data['forwarded_ip'] = $this->request->server['HTTP_CLIENT_IP'];
			} else {
				$order_data['forwarded_ip'] = '';
			}

			if (isset($this->request->server['HTTP_USER_AGENT'])) {
				$order_data['user_agent'] = $this->request->server['HTTP_USER_AGENT'];
			} else {
				$order_data['user_agent'] = '';
			}

			if (isset($this->request->server['HTTP_ACCEPT_LANGUAGE'])) {
				$order_data['accept_language'] = $this->request->server['HTTP_ACCEPT_LANGUAGE'];
			} else {
				$order_data['accept_language'] = '';
			}

			$this->load->model('checkout/order');
			$this->session->data['order_id'] = $this->model_checkout_order->addOrder($order_data);

			$data['text_recurring_item'] = $this->language->get('text_recurring_item');
			$data['text_payment_recurring'] = $this->language->get('text_payment_recurring');
		}
			
		$code = explode('.', $this->session->data['payment_method']['code']);
		
		header('Content-Type: text/html; charset=UTF-8');		
		if(VERSION >= 2.2) {
			return $this->load->controller('extension/payment/'.$code[0]);
		} else {
			return $this->load->controller('payment/'.$code[0]);
		}
  	}
	
	public function country() {
		$json = array();
		
		$this->load->model('localisation/country');

    	$country_info = $this->model_localisation_country->getCountry($this->request->get['country_id']);
		
		if ($country_info) {
			$this->load->model('localisation/zone');

			$json = array(
				'country_id'        => $country_info['country_id'],
				'name'              => $country_info['name'],
				'iso_code_2'        => $country_info['iso_code_2'],
				'iso_code_3'        => $country_info['iso_code_3'],
				'address_format'    => $country_info['address_format'],
				'postcode_required' => $country_info['postcode_required'],
				'zone'              => $this->model_localisation_zone->getZonesByCountryId($this->request->get['country_id']),
				'status'            => $country_info['status']		
			);
		}		
		$this->response->setOutput(json_encode($json));
	}
	
	private function products_related() {
		$this->load->model('unishop/setting');
		$settings = $this->model_unishop_setting->getSetting();
		$language_id = $this->config->get('config_language_id');
		
		$this->load->model('catalog/product');
		$this->load->model('tool/image');
		$this->load->model('unishop/related_and_bestseller');
		
		$data['text_select'] = $this->language->get('text_select');
		$data['text_tax'] = $this->language->get('text_tax');
				
		$related = '';
		$data['related'] = '';
		if (isset($settings['checkout_related_product'])) {
			$this->load->model('catalog/product');
			$this->load->model('tool/image');
			$related = $settings['checkout_related_product'];
			$data['related'] = $settings['checkout_related_product'];
			$data['checkout_related_text'] = $settings[$language_id]['checkout_related_text'];					
		}
			
		$related1 = isset($settings['checkout_related_product1']) ? $settings['checkout_related_product1'] : '';
		$related2 = isset($settings['checkout_related_product2']) ? $settings['checkout_related_product2'] : '';		
			
		$results = array();
		$in_cart = array();
		$products = array();
		$products_related = array();
		
		if($this->cart->getProducts()) {
			foreach($this->cart->getProducts() as $result) {			
				if ($related && $related1) {
					$result1 = $this->model_unishop_related_and_bestseller->getRelated($result['product_id']);
					foreach($result1 as $res1) {
						$results[] = $res1;
					}
				} 
				if($related && $related2) {
					$result2 = $this->model_unishop_related_and_bestseller->getRelated2($result['product_id']);
					foreach($result2 as $res2) {
						$results[] = $res2;
					}
				}
				$in_cart[] = $result['product_id'];
			}
			
			$products = array_unique(array_diff($results, $in_cart));
			
			$currency = (VERSION >= 2.2) ? $this->session->data['currency'] : '';
				
			foreach ($products as $product_id) {
				$result = $this->model_catalog_product->getProduct($product_id);

				$image = $result['image'] ? $this->model_tool_image->resize($result['image'], 110, 110) : '';
				$additional_image = '';
				
				if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
					$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')), $currency);
				} else {
					$price = false;
				}
						
				if ((float)$result['special']) {
					$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')), $currency);
				} else {
					$special = false;
				}
					
				if ($this->config->get('config_tax')) {
					$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price'], $currency);
				} else {
					$tax = false;
				}
				
				if ($this->config->get('config_review_status')) {
					$rating = (int)$result['rating'];
				} else {
					$rating = false;
				}
					
				$data['show_description'] = (isset($settings['show_description']) ? $settings['show_description'] : '');
				$data['show_description_alt'] = (isset($settings['show_description_alt']) ? $settings['show_description_alt'] : '');
			
				$data['show_options'] = '';
				$options = array();
				if (isset($settings['show_options'])) {				
					foreach ($this->model_catalog_product->getProductOptions($result['product_id']) as $key => $option) {

						$product_option_value_data = array();

						foreach ($option['product_option_value'] as $option_value) {
							if (!$option_value['subtract'] || ($option_value['quantity'] > 0)) {
								if ((($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) && (float)$option_value['price']) {
									$option_price = $this->currency->format($this->tax->calculate($option_value['price'], $result['tax_class_id'], $this->config->get('config_tax') ? 'P' : false), $currency);
								} else {
									$option_price = false;
								}

								$product_option_value_data[] = array(
									'product_option_value_id' => $option_value['product_option_value_id'],
									'option_value_id'         => $option_value['option_value_id'],
									'name'                    => $option_value['name'],
									'image'                   => $option_value['image'] ? $this->model_tool_image->resize($option_value['image'], 50, 50) : '',
									'small' 				  => $this->model_tool_image->resize($option_value['image'], 110, 110),
									'price'                   => $option_price,
									'price_prefix'            => $option_value['price_prefix']
								);
							}
						}

						if($settings['show_options_item'] > $key) {
							$options[] = array(
								'product_option_id'    => $option['product_option_id'],
								'product_option_value' => $product_option_value_data,
								'option_id'            => $option['option_id'],
								'name'                 => $option['name'],
								'type'                 => $option['type'],
								'value'                => $option['value'],
								'required'             => $option['required']
							);
						}
					}
				}		
			
				$weight = ($result['weight'] > 0) ? $this->weight->format($result['weight'], $result['weight_class_id'], $this->language->get('decimal_point'), $this->language->get('thousand_point')) : '';
						
				$data['show_stock_status'] = isset($settings['show_stock_status']) ? $settings['show_stock_status'] : '';
				$data['wishlist_btn_disabled'] = isset($settings['wishlist_btn_disabled']) ? $settings['wishlist_btn_disabled'] : '';
				$data['compare_btn_disabled'] = isset($settings['compare_btn_disabled']) ? $settings['compare_btn_disabled'] : '';
			
				$stickers = array();
			
				$stickers_data = array(
					'product_id' 	=> $result['product_id'],
					'price'			=> $result['price'],
					'special'		=> $result['special'],
					'tax_class_id'  => $result['tax_class_id'],
					'date_available'=> $result['date_available'],
					'reward'		=> $result['reward'],
					'upc'			=> $result['upc'],
					'ean'			=> $result['ean'],
					'jan'			=> $result['jan'],
					'isbn'			=> $result['isbn'],
					'mpn'			=> $result['mpn'],
				);
			
				$stickers = $this->load->controller('unishop/stickers', $stickers_data);
					
				if($result['quantity'] > 0)	{
					$products_related[] = array(
						'product_id' 				=> $result['product_id'],
						'thumb'   	 				=> $image,
						'name'    					=> $result['name'],
						'description' 				=> utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
						'price'   	 				=> $price,
						'special' 	 				=> $special,
						'tax'        				=> $tax,
						'rating'     				=> $rating,
						'additional_image'			=> $additional_image,
						'weight' 					=> $weight,
						'num_reviews' 				=> $result['reviews'],
						'quantity' 					=> $result['quantity'],
						'minimum' 					=> $result['minimum'],
						'stock_status' 				=> isset($settings['show_stock_status']) ? $result['stock_status'] : '',
						'stock_status_id' 			=> isset($settings['show_stock_status']) ? $result['stock_status_id'] : '',
						'stickers' 					=> $stickers,
						'options'					=> $options,
						'reviews'   				=> sprintf($this->language->get('text_reviews'), (int)$result['reviews']),
						'href'    					=> $this->url->link('product/product', 'product_id=' . $result['product_id']),
						'cart_btn_disabled' 		=> $result['quantity'] <= 0 && isset($settings['cart_btn_disabled']) ? $settings['cart_btn_disabled'] : '',
						'cart_btn_icon_mobile' 		=> $result['quantity'] <= 0 && isset($settings['cart_btn_icon_disabled_mobile']) ? $settings['cart_btn_icon_disabled_mobile'] : '',
						'cart_btn_icon' 			=> $result['quantity'] > 0 ? $settings[$language_id]['cart_btn_icon'] : $settings[$language_id]['cart_btn_icon_disabled'],
						'cart_btn_text' 			=> $result['quantity'] > 0 ? $settings[$language_id]['cart_btn_text'] : $settings[$language_id]['cart_btn_text_disabled'],
					);
				}
			}
		}
				
		return $products_related;
	}
}
