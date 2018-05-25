<?php  
class ControllerUnishopQuickOrder extends Controller {
	public function index() {
		$this->load->model('catalog/product');
		
		$product_id = isset($this->request->get['id']) ? (int)$this->request->get['id'] : '';
		$product_info = $this->model_catalog_product->getProduct($product_id);
		
		$this->load->language('product/product');
		
		$data = array();
		$data['lang'] = array_merge($data, $this->language->load('unishop/unishop'));
		
		$this->language->load('unishop/unishop');
		
		$data['text_select'] = $this->language->get('text_select');
		$data['text_manufacturer'] = $this->language->get('text_manufacturer');
		$data['text_model'] = $this->language->get('text_model');
		$data['text_reward'] = $this->language->get('text_reward');
		$data['text_points'] = $this->language->get('text_points');
		$data['text_stock'] = $this->language->get('text_stock');
		$data['text_discount'] = $this->language->get('text_discount');
		$data['text_tax'] = $this->language->get('text_tax');
		$data['text_option'] = $this->language->get('text_option');
		$data['text_minimum'] = sprintf($this->language->get('text_minimum'), $product_info['minimum']);
		$data['text_write'] = $this->language->get('text_write');
		$data['text_login'] = sprintf($this->language->get('text_login'), $this->url->link('account/login', '', 'SSL'), $this->url->link('account/register', '', 'SSL'));
		$data['text_note'] = $this->language->get('text_note');
		$data['text_tags'] = $this->language->get('text_tags');
		$data['text_related'] = $this->language->get('text_related');
		$data['text_payment_recurring'] = $this->language->get('text_payment_recurring');
		$data['text_loading'] = $this->language->get('text_loading');
		$data['entry_qty'] = $this->language->get('entry_qty');
		
		$data['button_cart'] = $this->language->get('button_cart');
		
		$this->load->model('unishop/setting');
		$settings = $this->model_unishop_setting->getSetting();
		$language_id = $this->config->get('config_language_id');
		
		$this->load->model('account/address');
		$data['firstname'] = $this->customer->getFirstName();
		$data['lastname'] = $this->customer->getLastName();
		$data['email'] = $this->customer->getEmail();
		$data['telephone'] = $this->customer->getTelephone();
		$address = $this->model_account_address->getAddress($this->customer->getAddressId());
		$data['address'] = isset($address['address_1']) ? $address['address_1'] : '';
		
		$data['change_opt_img_q'] = isset($settings['change_opt_img_q']) ? $settings['change_opt_img_q'] : '';
		
		$data['show_attr'] = isset($settings['quick_order_attr']) ? $settings['quick_order_attr'] : '';
		$data['show_attr_group'] = $settings['quick_order_attr_group'];
		$data['show_attr_item'] = $settings['quick_order_attr_item'];
		
		$data['description_on'] = isset($settings['quick_order_description']) ? $settings['quick_order_description'] : '';
		$data['show_quick_order_form'] = isset($settings['show_quick_order_form']) ? $settings['show_quick_order_form'] : '';
		$data['phone_mask'] = isset($settings['quick_order_phone_mask']) ? $settings['quick_order_phone_mask'] : '';
		$data['name_text'] = isset($settings[$language_id]['quick_order_name_text']) ? $settings[$language_id]['quick_order_name_text'] : '';
		$data['phone_text'] = isset($settings[$language_id]['quick_order_phone_text']) ? $settings[$language_id]['quick_order_phone_text'] : '';
		
		$data['mail'] = isset($settings['quick_order_mail']) ? $settings['quick_order_mail'] : '';
		$data['mail_text'] = $settings[$language_id]['quick_order_mail_text'];

		$data['delivery'] = isset($settings['quick_order_delivery']) ? $settings['quick_order_delivery'] : '';
		$data['delivery_text'] = $settings[$language_id]['quick_order_delivery_text'];

		$data['comment'] = isset($settings['quick_order_comment']) ? $settings['quick_order_comment'] : '';
		$data['comment_text'] = $settings[$language_id]['quick_order_comment_text'];
		
		$this->load->model('tool/image');

		if ($product_info['image']) {
			$data['thumb'] = $this->model_tool_image->resize($product_info['image'], 480, 440);
			$data['small'] = $this->model_tool_image->resize($product_info['image'], 50, 50);
		} else {
			$data['thumb'] = $this->model_tool_image->resize('no_image.jpg', 480, 440);
			$data['small'] = $this->model_tool_image->resize('no_image.jpg', 50, 50);
		}
		
		$data['images'] = array();
			
		$results = $this->model_catalog_product->getProductImages($product_id);
			
		foreach ($results as $result) {
			$data['images'][] = array(
				'thumb' => $this->model_tool_image->resize($result['image'], 480, 440),
				'small' => $this->model_tool_image->resize($result['image'],50, 50)
			);
		}
		
		$currency = (VERSION >= 2.2) ? $this->session->data['currency'] : '';
		
		if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
			$data['price'] = $this->currency->format($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')), $currency);
		} else {
			$data['price'] = false;
		}
						
		if ((float)$product_info['special']) {
			$data['special'] = $this->currency->format($this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax')), $currency);
		} else {
			$data['special'] = false;
		}
			
		if ($product_info['quantity'] <= 0) {
			$data['stock'] = $product_info['stock_status'];
		} elseif ($this->config->get('config_stock_display')) {
			$data['stock'] = $product_info['quantity'];
		} else {
			$data['stock'] = $this->language->get('text_instock');
		}
		
		$data['reward'] = $product_info['reward'];
		$data['points'] = $product_info['points'];
		$data['quantity'] = $product_info['quantity'];
			
		$discounts = $this->model_catalog_product->getProductDiscounts($product_id);
		
		$data['price_value'] = $product_info['price']*$this->currency->getValue($currency);
        $data['special_value'] = $product_info['special']*$this->currency->getValue($currency);
        $data['tax_value'] = (float)$product_info['special'] ? $product_info['special'] : $product_info['price'];

        $data['dicounts_unf'] = $discounts;

        $data['tax_class_id'] = $product_info['tax_class_id'];
        $data['tax_rates'] = $this->tax->getRates(0, $product_info['tax_class_id']);
			
		$data['options'] = array();

			foreach ($this->model_catalog_product->getProductOptions($product_id) as $option) {
				$product_option_value_data = array();

				foreach ($option['product_option_value'] as $option_value) {
					if (!$option_value['subtract'] || ($option_value['quantity'] > 0)) {
						if ((($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) && (float)$option_value['price']) {
							$price = $this->currency->format($this->tax->calculate($option_value['price'], $product_info['tax_class_id'], $this->config->get('config_tax') ? 'P' : false), $currency);
						} else {
							$price = false;
						}

						$product_option_value_data[] = array(
							'product_option_value_id' => $option_value['product_option_value_id'],
							'price_value'             => $option_value['price'],
							'weight'                  => $option_value['weight'],
							'weight_prefix'           => $option_value['weight_prefix'],
							'option_value_id'         => $option_value['option_value_id'],
							'name'                    => $option_value['name'],
							'image'                   => $option_value['image'] ? $this->model_tool_image->resize($option_value['image'], 50, 50) : '',
							'small'                   => $this->model_tool_image->resize($option_value['image'], 480, 440),
							'price'                   => $price,
							'price_prefix'            => $option_value['price_prefix']
						);
					}
				}

				$data['options'][] = array(
					'product_option_id'    => $option['product_option_id'],
					'product_option_value' => $product_option_value_data,
					'option_id'            => $option['option_id'],
					'name'                 => $option['name'],
					'type'                 => $option['type'],
					'value'                => $option['value'],
					'required'             => $option['required']
				);
			}
		
		$data['attribute_groups'] = $this->model_catalog_product->getProductAttributes($product_info['product_id']);
		$data['weight_value'] = $product_info['weight'];
		$data['weight_unit'] = $this->weight->getUnit($product_info['weight_class_id']);

		$data['product_id'] = $product_id;
		$data['name'] = $product_info['name'];
		$data['href'] = $this->url->link('product/product&product_id=' . $product_id);
		$data['model'] = $product_info['model'];
		$data['minimum'] = $product_info['minimum'];
		$data['manufacturer'] = $product_info['manufacturer'];
		$data['manufacturers'] = $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $product_info['manufacturer_id']);
		$data['description'] = utf8_substr(strip_tags(html_entity_decode($product_info['description'], ENT_QUOTES, 'UTF-8')), 0, $settings['quick_order_description_item']);
		
		$data['cart_btn_icon'] = $product_info['quantity'] > 0 ? $settings[$language_id]['cart_btn_icon'] : $settings[$language_id]['cart_btn_icon_disabled'];
		$data['cart_btn_text'] = $product_info['quantity'] > 0 ? $settings[$language_id]['cart_btn_text'] : $settings[$language_id]['cart_btn_text_disabled'];
		
		$data['stickers'] = array();
			
		$stickers_data = array(
			'product_id' 	=> $product_info['product_id'],
			'price'			=> $product_info['price'],
			'special'		=> $product_info['special'],
			'tax_class_id'  => $product_info['tax_class_id'],
			'date_available'=> $product_info['date_available'],
			'reward'		=> $product_info['reward'],
			'upc'			=> $product_info['upc'],
			'ean'			=> $product_info['ean'],
			'jan'			=> $product_info['jan'],
			'isbn'			=> $product_info['isbn'],
			'mpn'			=> $product_info['mpn'],
		);
			
		$data['stickers'] = $this->load->controller('unishop/stickers', $stickers_data);
		
		$this->cart->clear();
		
		if (VERSION >= 2.2) {
			$this->response->setOutput($this->load->view('unishop/quick_order', $data));
		} else {
			$this->response->setOutput($this->load->view('unishop/template/unishop/quick_order.tpl', $data));
		}
	}
	
	public function add_order() {
		if($this->cart->getProducts()) {
			$this->load->language('unishop/unishop');
			
			$this->load->model('unishop/setting');
			$settings = $this->model_unishop_setting->getSetting();
			$language_id = $this->config->get('config_language_id');
		
			$data = array();

			$data['totals'] = array();
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
						$this->{'model_total_' . $result['code']}->getTotal($data['totals'], $total, $taxes);
					}
				}
			}

			$sort_order = array(); 

			if(VERSION >= 2.2) {
				foreach ($totals as $key => $value) {
					$sort_order[$key] = $value['sort_order'];
				}
				array_multisort($sort_order, SORT_ASC, $totals);
				$data['totals'] = $totals;
			} else {
				foreach ($data['totals'] as $key => $value) {
					$sort_order[$key] = $value['sort_order'];
				}
				array_multisort($sort_order, SORT_ASC, $data['totals']);
			}
	
			$this->language->load('checkout/checkout');
			
			$data['invoice_prefix'] = $this->config->get('config_invoice_prefix');
			$data['store_id'] = $this->config->get('config_store_id');
			$data['store_name'] = $this->config->get('config_name');
			
			if ($data['store_id']) {
				$data['store_url'] = $this->config->get('config_url');		
			} else {
				$data['store_url'] = HTTPS_SERVER;	
			}
			
			if ($this->customer->isLogged()) {
				$this->load->model('account/address');
				$this->load->model('localisation/country');
				$this->load->model('account/customer');
				$this->load->model('account/customer_group');
		
				$data['customer_id'] = $this->customer->getId();
				$data['customer_group_id'] = $this->customer->getGroupId();
				$data['firstname'] = $this->customer->getFirstName();
				$data['lastname'] = $this->customer->getLastName();
				$data['email'] = $this->customer->getEmail();
				$data['telephone'] = $this->customer->getTelephone();
				$data['fax'] = '';
			
				if (isset($this->request->post['customer_delivery']) && $this->request->post['customer_delivery'] != '') {
					$data['payment_address_1'] = $this->request->post['customer_delivery'];
					$data['shipping_address_1'] = $this->request->post['customer_delivery'];
				} else {
					$data['payment_address_1'] = '';
					$data['shipping_address_1'] = '';
				}
			
				//$payment_address = $this->model_account_address->getAddress($this->session->data['payment_address_id']);
				echo $payment_address = '';
			} else {
				$data['customer_id'] = 0;
				$data['customer_group_id'] = '';
				$data['firstname'] = isset($this->request->post['customer_name']) && $this->request->post['customer_name'] != '' ? $this->request->post['customer_name'] : '';
				$data['lastname'] = '';
				$data['email'] = isset($this->request->post['customer_mail']) && $this->request->post['customer_mail'] != '' ? $this->request->post['customer_mail'] : $settings['quick_order_mail_cap'];
				$data['telephone'] = isset($this->request->post['customer_phone']) && $this->request->post['customer_phone'] != '' ? $this->request->post['customer_phone'] : '';
				$data['fax'] = '';
				if (isset($this->request->post['customer_delivery']) && $this->request->post['customer_delivery'] != '') {
					$data['payment_address_1'] = $this->request->post['customer_delivery'];
					$data['shipping_address_1'] = $this->request->post['customer_delivery'];
				} else {
					$data['payment_address_1'] = '';
					$data['shipping_address_1'] = '';
				}
			}
			
			$data['payment_firstname'] = $data['firstname'];
			$data['payment_lastname'] = '';	
			$data['payment_company'] = '';	
			$data['payment_company_id'] = '';	
			$data['payment_tax_id'] = '';	
			$data['payment_address_2'] = '';
			$data['payment_city'] = '';
			$data['payment_postcode'] = '';
			$data['payment_zone'] = '';
			$data['payment_zone_id'] = '';
			$data['payment_country'] = '';
			$data['payment_country_id'] = $this->config->get('config_country_id');
			$data['payment_address_format'] = '';
			$data['payment_method'] = 'Быстрый заказ';
			$data['payment_code'] = 'cod';
						
			$data['shipping_firstname'] = '';
			$data['shipping_lastname'] = '';	
			$data['shipping_company'] = '';	
			$data['shipping_address_2'] = '';
			$data['shipping_city'] = '';
			$data['shipping_postcode'] = '';
			$data['shipping_zone'] = '';
			$data['shipping_zone_id'] = '';
			$data['shipping_country'] = '';
			$data['shipping_country_id'] = $this->config->get('config_country_id');
			$data['shipping_address_format'] = '';
			$data['shipping_method'] = 'Быстрый заказ';
			$data['shipping_code'] = 'flat';
			
			$data['custom_field'] = array();
			$data['payment_custom_field'] = array();
			$data['shipping_custom_field'] = array();
			
			$product_data = array();
		
			foreach ($this->cart->getProducts() as $product) {
				$option_data = array();
	
				foreach ($product['option'] as $option) {
					if ($option['type'] != 'file') {
						$value = $option['value'];	
					} else {
						$value = $this->encryption->decrypt($option['option_value']);
					}	
					
					$option_data[] = array(
						'product_option_id'       => $option['product_option_id'],
						'product_option_value_id' => $option['product_option_value_id'],
						'option_id'               => $option['option_id'],
						'option_value_id'         => $option['option_value_id'],								   
						'name'                    => $option['name'],
						'value'                   => $value,
						'type'                    => $option['type']
					);					
				}
	 
				$product_data[] = array(
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
			
			// Gift Voucher
			$voucher_data = array();
			
			if (!empty($this->session->data['vouchers'])) {
				foreach ($this->session->data['vouchers'] as $voucher) {
					$voucher_data[] = array(
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
						
			$data['products'] = $product_data;
			$data['vouchers'] = $voucher_data;
			
			if (isset($this->request->post['customer_comment'])) {
				$data['comment'] = $this->request->post['customer_comment'];
			} else {
				$data['comment'] ='';
			}
			$data['total'] = $total;
			
			if (isset($this->request->post['affiliate_id'])) {
				$subtotal = $this->cart->getSubTotal();
				$this->load->model('affiliate/affiliate');

				$affiliate_info = $this->model_affiliate_affiliate->getAffiliate($this->request->post['affiliate_id']);

				if ($affiliate_info) {
					$data['affiliate_id'] = $affiliate_info['affiliate_id'];
					$data['commission'] = ($subtotal / 100) * $affiliate_info['commission'];
				} else {
					$data['affiliate_id'] = 0;
					$data['commission'] = 0;
				}

				$data['marketing_id'] = 0;
				$data['tracking'] = '';
			} else {
				$data['affiliate_id'] = '';
				$data['commission'] = '';
				$data['marketing_id'] = '';
				$data['tracking'] = '';
			}
			
			$currency = (VERSION >= 2.2) ? $this->session->data['currency'] : '';
			
			$data['language_id'] = $this->config->get('config_language_id');
			$data['currency_id'] = (VERSION >= 2.2) ? $this->currency->getId($this->session->data['currency']) : $this->currency->getId();
			$data['currency_code'] = (VERSION >= 2.2) ? $this->session->data['currency'] : $this->currency->getCode();
			$data['currency_value'] = (VERSION >= 2.2) ? $this->currency->getValue($this->session->data['currency']) : $this->currency->getValue($this->currency->getCode());
			$data['ip'] = $this->request->server['REMOTE_ADDR'];
			
			if (!empty($this->request->server['HTTP_X_FORWARDED_FOR'])) {
				$data['forwarded_ip'] = $this->request->server['HTTP_X_FORWARDED_FOR'];	
			} elseif(!empty($this->request->server['HTTP_CLIENT_IP'])) {
				$data['forwarded_ip'] = $this->request->server['HTTP_CLIENT_IP'];	
			} else {
				$data['forwarded_ip'] = '';
			}
			
			$data['user_agent'] = isset($this->request->server['HTTP_USER_AGENT']) ? $this->request->server['HTTP_USER_AGENT'] : '';	
			$data['accept_language'] = isset($this->request->server['HTTP_ACCEPT_LANGUAGE']) ? $this->request->server['HTTP_ACCEPT_LANGUAGE'] : '';	
			
			$this->load->model('checkout/order');
			
			$json = array();
		
			if($data['firstname'] && $data['telephone'] && $data['products']) {
			
				$order_status_id = isset($this->request->post['order_status_id']) ? $this->request->post['order_status_id'] : $this->config->get('config_order_status_id');

				$this->session->data['order_id'] = $order_id = $this->model_checkout_order->addOrder($data);
				$this->model_checkout_order->addOrderHistory($order_id, $order_status_id);
				$this->cart->clear();
				$json['success'] = $this->language->get('text_quick_order_success');
			} else {
				$this->cart->clear();
				$json['error'] = $this->language->get('text_quick_order_error');
			}
		
			$this->response->setOutput(json_encode($json));
		} else {
			$this->response->redirect($this->url->link('error/not_found', '', 'SSL'));
		}
	}
}
?>