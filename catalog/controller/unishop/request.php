<?php  
class ControllerUnishopRequest extends Controller {
	public function index() {
	
		$data = array();
		$data['lang'] = array_merge($data, $this->language->load('unishop/unishop'));
		$this->language->load('unishop/request');
	
		$this->load->model('unishop/setting');
		$uniset = $this->model_unishop_setting->getSetting();
		$lang_id = $this->config->get('config_language_id');
		
		$settings = $this->config->get('uni_request') ? $this->config->get('uni_request') : array();
		
		$data['name_text'] = $uniset[$lang_id]['callback_name_text'];
		$data['phone_text'] = $uniset[$lang_id]['callback_phone_text'];
		$data['mail_text'] = $uniset[$lang_id]['callback_mail_text'];
		$data['comment_text'] = $uniset[$lang_id]['callback_comment_text'];
		
		$data['reason'] = isset($this->request->get['reason']) && $this->request->get['reason'] != '' ? htmlspecialchars(strip_tags($this->request->get['reason'])) : '';
		
		if ($settings) {
			switch ($data['reason']) {
				case $settings['heading_notify'][$lang_id]:
					$data['show_phone'] = isset($settings['notify_phone']) ? true : false;
					$data['show_email'] = isset($settings['notify_email']) ? true : false;
					$data['show_comment'] = false;
					break;
				case $settings['heading_question'][$lang_id]:
					$data['show_phone'] = isset($settings['question_phone']) ? true : false;
					$data['show_email'] = isset($settings['question_email']) ? true : false;
					$data['show_comment'] = true;
					break;
				default:
					$data['show_phone'] = true;
					$data['show_email'] = true;
					$data['show_comment'] = true;
					break;
			}
		} else {
			$data['show_phone'] = true;
			$data['show_email'] = true;
			$data['show_comment'] = true;
		}
		
		$data['product_id'] = isset($this->request->get['id']) && $this->request->get['id'] != '' ? (int)$this->request->get['id'] : '';
		$data['phone_mask'] = isset($uniset['callback_phone_mask']) ? $uniset['callback_phone_mask'] : '';
		
		$data['show_reason1'] = isset($uniset['show_reason1']) ? $uniset['show_reason1'] : '';
		$data['text_reason1'] = $uniset[$lang_id]['text_reason1'];
		$data['show_reason2'] = isset($uniset['show_reason2']) ? $uniset['show_reason2'] : '';
		$data['text_reason2'] = $uniset[$lang_id]['text_reason2'];
		$data['show_reason3'] = isset($uniset['show_reason3']) ? $uniset['show_reason3'] : '';
		$data['text_reason3'] = $uniset[$lang_id]['text_reason3'];
		
		if (VERSION >= 2.2) {
			$this->response->setOutput($this->load->view('unishop/request_form', $data));
		} else {	
			$this->response->setOutput($this->load->view('unishop/template/unishop/request_form.tpl', $data));
		}
  	}
	
	public function requests() {
		$data = array();
		
		$settings = $this->config->get('uni_request') ? $this->config->get('uni_request') : array();
		
		if($settings && isset($settings['question_list'])) { 
			$this->load->model('unishop/request');
		
			$data['lang'] = array_merge($data, $this->language->load('unishop/request'));
			$this->language->load('product/product');
			$this->language->load('product/review');
		
			$lang_id = $this->config->get(' config_language_id');
		
			$data['text_note'] = $this->language->get('text_note');
			$data['text_loading'] = $this->language->get('text_loading');
			$data['type'] = $settings['heading_question'][$lang_id];
			$data['show_phone'] = isset($settings['question_phone']) ? true : false;
			$data['show_email'] = isset($settings['question_email']) ? true : false;
			$data['show_email_required'] = isset($settings['question_email_required']) ? true : false;
			$data['show_captcha'] = isset($settings['question_captcha']) ? true : false;
		
			$this->customer->isLogged();
		
			if (isset($this->request->get['page'])) {
				$page = $this->request->get['page'];
			} else {
				$page = 1;
			}
		
			if (isset($this->request->get['limit'])) {
				$limit = (int)$this->request->get['limit'];
			} else {
				$limit = 5;
			}
	
			$data['requests'] = array();
		
			$product_id = isset($this->request->get['p_id']) ? (int)$this->request->get['p_id'] : 0;
		
			$data['request_guest'] = 1;
			$data['product_id'] = $product_id;
	
			$filter_data = array(
				'product_id' 	=> $product_id,
				'start' 		=> ($page - 1) * $limit,
				'limit'         => $limit,
			);
	
			$results = $this->model_unishop_request->getRequests($filter_data);
		
			$data['requests_total'] = $results_total = $this->model_unishop_request->getTotalRequests($filter_data);
		
			foreach ($results as $result) {
				$data['requests'][] = array(
					'name' 			=> $result['name'],
					'date_added' 	=> date($this->language->get('date_format_short'), strtotime($result['date_added'])),
					'comment' 		=> $result['comment'],
					'admin_comment' => $result['admin_comment'],
				);
			}
		
			$pagination = new Pagination();
			$pagination->total = $results_total;
			$pagination->page = $page;
			$pagination->limit = 5;
			$pagination->url = $this->url->link('unishop/request/requests', 'p_id=' . $product_id . '&page={page}');

			$data['pagination'] = $pagination->render();

			$data['results'] = sprintf($this->language->get('text_pagination'), ($results_total) ? (($page - 1) * 5) + 1 : 0, ((($page - 1) * 5) > ($results_total - 5)) ? $results_total : ((($page - 1) * 5) + 5), $results_total, ceil($results_total / 5));
		
			if ($this->config->get($this->config->get('config_captcha') . '_status')) {
				$data['captcha'] = $this->load->controller((VERSION >= 2.2) ? 'extension/captcha/' . $this->config->get('config_captcha') : 'captcha/' . $this->config->get('config_captcha'));
			} else {
				$data['captcha'] = '';
			}
		
			if (VERSION >= 2.2) {
				$this->response->setOutput($this->load->view('unishop/request_list', $data));
			} else {
				$this->response->setOutput($this->load->view('unishop/template/unishop/request_list.tpl', $data));
			}
		} else {
			$this->language->load('unishop/request');
			
			$this->document->setTitle($this->language->get('text_error'));
			
	     	$data['breadcrumbs'][] = array(
	        	'href'      => $this->url->link('information/news'),
	        	'text'      => $this->language->get('text_error'),
	        	'separator' => $this->language->get('text_separator')
	     	);
		
			$data['heading_title'] = $this->language->get('text_error');
			$data['text_error'] = $this->language->get('text_error');
			$data['button_continue'] = $this->language->get('button_continue');
			$data['continue'] = $this->url->link('common/home');
			
			$this->response->addHeader($this->request->server['SERVER_PROTOCOL'] . ' 404 Not Found');
				
			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');
				
			if (VERSION >= 2.2) {
				$this->response->setOutput($this->load->view('error/not_found', $data));
			} else {
				$this->response->setOutput($this->load->view('unishop/template/error/not_found.tpl', $data));
			}
		}
	}
	
	public function mail() {
		$this->language->load('unishop/request');
		$this->load->model('extension/extension');
		
		$lang_id = $this->config->get('config_language_id');
		$settings = $this->config->get('uni_request') ? $this->config->get('uni_request') : array();
		
		$data['show_phone'] = isset($settings['question_phone']) ? true : false;
		$data['show_email'] = isset($settings['question_email']) ? true : false;
		$data['show_captcha'] = isset($settings['question_captcha']) ? true : false;
		
		$type = isset($this->request->post['type']) ? htmlspecialchars(strip_tags($this->request->post['type'])) : '';
		$type = isset($this->request->post['customer_reason']) ? htmlspecialchars(strip_tags($this->request->post['customer_reason'])) : $type;
		
		$product_id = '';
		if (isset($this->request->post['product_id'])) {
			$product_id = (int)$this->request->post['product_id'];
			$this->load->model('catalog/product');
			$product_info = $this->model_catalog_product->getProduct($product_id);
		}
		
		$customer_name = isset($this->request->post['customer_name']) ? htmlspecialchars(strip_tags($this->request->post['customer_name'])) : '';
		$customer_phone = isset($this->request->post['customer_phone']) ? htmlspecialchars(strip_tags($this->request->post['customer_phone'])) : '';
		$customer_mail = isset($this->request->post['customer_mail']) ? htmlspecialchars(strip_tags($this->request->post['customer_mail'])) : '';
		$customer_comment = isset($this->request->post['customer_comment']) ? htmlspecialchars(strip_tags($this->request->post['customer_comment'])) : '';
		$product_id = isset($this->request->post['product_id']) ? (int)$this->request->post['product_id'] : '';
		
		$json = array();
		$json['error'] = array();
		
		if (utf8_strlen($customer_name) < 3 || utf8_strlen($customer_name) > 45) {
			$json['error']['name'] = $this->language->get('text_error_name');
		}
		
		if (isset($this->request->post['customer_phone']) && (utf8_strlen($customer_phone) < 3 || utf8_strlen($customer_phone) > 25)) {
			$json['error']['phone'] = $this->language->get('text_error_phone');
		}

		$mail_error = false;
		
		if ($customer_mail && $this->config->get('config_mail_regexp')) {
			$mail_error = !preg_match($this->config->get('config_mail_regexp'), $this->request->post['customer_mail']) ? true : false;
		}
		
		if (isset($this->request->post['customer_mail']) && ((utf8_strlen($customer_mail) < 3 || utf8_strlen($customer_mail) > 45) || !preg_match('/^[^\@]+@.*.[a-z]{2,15}$/i', $customer_mail) || $mail_error)) {
			$json['error']['mail'] = $this->language->get('text_error_mail');
		}
		
		$notify_email_required = isset($settings['notify_email_required']) ? true : false;
		$heading_notify = isset($settings['heading_notify'][$lang_id]) ? $settings['heading_notify'][$lang_id] : '';
		$question_email_required = isset($settings['question_email_required']) ? true : false;
		$heading_question = isset($settings['heading_question'][$lang_id]) ? $settings['heading_question'][$lang_id] : '';
		
		if((!$notify_email_required && $heading_notify == $type) || (!$question_email_required && $heading_question == $type)) {
			unset($json['error']['mail']);
		}
		
		if (isset($this->request->post['customer_comment']) && (utf8_strlen($customer_comment) < 10 || utf8_strlen($customer_comment) > 500)) {
			$json['error']['comment'] = $this->language->get('text_error_comment');
		}
		
		if (isset($this->request->post['captcha']) && $this->config->get($this->config->get('config_captcha') . '_status')) {
			$captcha = $this->load->controller((VERSION >= 2.2) ? 'extension/captcha/' . $this->config->get('config_captcha') . '/validate' : 'captcha/' . $this->config->get('config_captcha') . '/validate');

			if ($captcha) {
				$json['error']['captcha'] = $captcha;
			}
		}
		
		if(!$json['error']) {
			$text = '';
			$text .= $product_id ? $this->language->get('text_product').$product_info['name'].'<br />' : '';
			$text .= $this->language->get('text_name').$customer_name.'<br />';
			$text .= $this->language->get('text_phone').$customer_phone.'<br />';
			$text .= $this->language->get('text_mail').$customer_mail.'<br />';
			$text .= $this->language->get('text_comment').$customer_comment.'<br />';
		
			$subject = $type && $product_id ? sprintf($this->language->get('text_reason'), $type, $product_info['name']) : sprintf($this->language->get('text_reason2'), $type);
		
			$mail = new Mail(); 
			$mail->protocol = $this->config->get('config_mail_protocol');
			$mail->parameter = $this->config->get('config_mail_parameter');
		
			$mail->smtp_hostname = $this->config->get('config_mail_smtp_hostname');
			$mail->smtp_username = $this->config->get('config_mail_smtp_username');
			$mail->smtp_password = html_entity_decode($this->config->get('config_mail_smtp_password'), ENT_QUOTES, 'UTF-8');
			$mail->smtp_port = $this->config->get('config_mail_smtp_port');
			$mail->smtp_timeout = $this->config->get('config_mail_smtp_timeout');
		
			$mail->setTo($this->config->get('config_email'));
			$mail->setFrom($this->config->get('config_email'));
			$mail->setSender($this->config->get('config_name'));
			$mail->setSubject(html_entity_decode($subject, ENT_QUOTES, 'UTF-8'));
			$mail->setHtml(html_entity_decode($text, ENT_QUOTES, 'UTF-8'));
		
			$mail->send();
			
			$emails = (VERSION >= 2.2) ? explode(',', $this->config->get('config_mail_alert_email')) : explode(',', $this->config->get('config_mail_alert'));
			foreach ($emails as $email) {
				if ($email && preg_match('/^[^\@]+@.*.[a-z]{2,15}$/i', $email)) {
					$mail->setTo($email);
					$mail->send();
				}
			}
			
			$request_data = array();
			
			$request_data = array(
				'type' 			=> $type,
				'name'			=> $customer_name,
				'phone'			=> $customer_phone,
				'mail'			=> $customer_mail,
				'product_id'	=> $product_id,
				'comment'		=> $customer_comment,
				'status'		=> '1',
			); 
			
			if (file_exists(DIR_APPLICATION.'model/unishop/request.php')) {
				$this->load->model('unishop/request');
				$this->model_unishop_request->addRequest($request_data);
			}
			
			if ($this->config->get('config_sms_alert') && $customer_phone) {
				$options = array(
					'to'       => $this->config->get('config_sms_to'),
					'copy'     => $this->config->get('config_sms_copy'),
					'from'     => $this->config->get('config_sms_from'),
					'username' => $this->config->get('config_sms_gate_username'),
					'password' => $this->config->get('config_sms_gate_password'),
					'message'  => $type."/n".$customer_name."/n".$customer_phone
				);

				$sms = new Sms($this->config->get('config_sms_gatename'), $options);
				$sms->send();
			}
				
			$json['success'] = (isset($settings['heading_question'][$lang_id]) && $settings['heading_question'][$lang_id] == $type) ? $this->language->get('text_success2') : $this->language->get('text_success');
		}
		
		$this->response->setOutput(json_encode($json));
	}
}
?>