<?php
class ControllerExtensionModuleUniReviews extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('extension/module/uni_reviews');

		$this->document->setTitle(strip_tags($this->language->get('heading_title')));
		
		$this->document->addStyle('view/stylesheet/unishop.css');

		$this->load->model('extension/module');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			if (!isset($this->request->get['module_id'])) {
				$this->model_extension_module->addModule('uni_reviews', $this->request->post);
			} else {
				$this->model_extension_module->editModule($this->request->get['module_id'], $this->request->post);
			}
			
			$this->cache->delete('product');

			$this->session->data['success'] = $this->language->get('text_success');

			if (VERSION >= 2.2) {
				$this->response->redirect($this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true));
			} else {
				$this->response->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
			}
		}

        $this->load->model('localisation/language');
        $data['languages'] = $this->model_localisation_language->getLanguages();

        $data['heading_title'] = $this->language->get('heading_title');
		
		$data['text_edit'] = $this->language->get('text_edit');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');

        $data['text_order_last'] = $this->language->get('text_order_last');
        $data['text_order_random'] = $this->language->get('text_order_random');

        $data['text_horizontal'] = $this->language->get('text_horizontal');
        $data['text_vertical'] = $this->language->get('text_vertical');
        $data['text_slider'] = $this->language->get('text_slider');
        
        $data['text_yes'] = $this->language->get('text_yes');
        $data['text_no'] = $this->language->get('text_no');

		$data['entry_name'] = $this->language->get('entry_name');
        $data['entry_order_type'] = $this->language->get('entry_order_type');
        $data['entry_layout'] = $this->language->get('entry_layout');
        $data['entry_header'] = $this->language->get('entry_header');
		$data['entry_limit'] = $this->language->get('entry_limit');
        $data['entry_text_limit'] = $this->language->get('entry_text_limit');
		$data['entry_width'] = $this->language->get('entry_width');
		$data['entry_height'] = $this->language->get('entry_height');
        $data['entry_category_sensitive'] = $this->language->get('entry_category_sensitive');
        $data['entry_show_all_button'] = $this->language->get('entry_show_all_button');
		$data['entry_show_all_button_link'] = $this->language->get('entry_show_all_button_link');
		$data['entry_status'] = $this->language->get('entry_status');

		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');

		$data['error_warning'] = isset($this->error['warning']) ? $this->error['warning'] : '';
		$data['error_name'] = isset($this->error['name']) ? $this->error['name'] : '';
        $data['error_header'] = isset($this->error['module_header']) ? $this->error['module_header'] : '';
		$data['error_order_type'] = isset($this->error['order_type']) ? $this->error['order_type'] : '';
        $data['error_layout'] = isset($this->error['layout']) ? $this->error['layout'] : '';
        $data['error_width'] = isset($this->error['width']) ? $this->error['width'] : '';
		$data['error_height'] = isset($this->error['height']) ? $this->error['height'] : '';

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
		);

		if(VERSION >= 2.2) {
			$data['breadcrumbs'][] = array(
				'text'      => $this->language->get('text_module'),
				'href'      => $this->url->link('extension/extension', 'token='.$this->session->data['token'].'&type=module', true)
			);
		} else {
			$data['breadcrumbs'][] = array(
				'text'      => $this->language->get('text_module'),
				'href'      => $this->url->link('extension/module', 'token='.$this->session->data['token'], 'SSL')
			);
		}

		if (!isset($this->request->get['module_id'])) {
			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('heading_title'),
				'href' => $this->url->link('extension/module/uni_reviews', 'token=' . $this->session->data['token'], 'SSL')
			);
		} else {
			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('heading_title'),
				'href' => $this->url->link('extension/module/uni_reviews', 'token=' . $this->session->data['token'] . '&module_id=' . $this->request->get['module_id'], 'SSL')
			);			
		}

		if (!isset($this->request->get['module_id'])) {
			$data['action'] = $this->url->link('extension/module/uni_reviews', 'token=' . $this->session->data['token'], 'SSL');
		} else {
			$data['action'] = $this->url->link('extension/module/uni_reviews', 'token=' . $this->session->data['token'] . '&module_id=' . $this->request->get['module_id'], 'SSL');
		}
		
		if(VERSION >= 2.2) {
			$data['cancel'] = $this->url->link('extension/extension', 'token='.$this->session->data['token'].'&type=module', true);
		} else {
			$data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		}
		
		if (isset($this->request->get['module_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$module_info = $this->model_extension_module->getModule($this->request->get['module_id']);
		}
		
		$data['uni_reviews'] = array();
		
		if (isset($this->request->post['uni_reviews'])) {
			$data['uni_reviews'] = $this->request->post['uni_reviews'];
		} elseif (!empty($module_info)) {
			$data['uni_reviews'] = $module_info['uni_reviews'];
		}
		
		if (isset($this->request->post['name'])) {
			$data['name'] = $this->request->post['name'];
		} elseif (!empty($module_info)) {
			$data['name'] = $module_info['name'];
		} else {
			$data['name'] = '';
		}

        if (isset($this->request->post['status'])) {
			$data['status'] = $this->request->post['status'];
		} elseif (!empty($module_info)) {
			$data['status'] = $module_info['status'];
		} else {
			$data['status'] = '';
		}

        $data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		if (VERSION >= 2.2) {
			$this->response->setOutput($this->load->view('extension/module/uni_reviews', $data));
		} else {
			$this->response->setOutput($this->load->view('extension/module/uni_reviews.tpl', $data));
		}
		
		$query_name = $this->db->query("SELECT query FROM `" . DB_PREFIX . "url_alias` WHERE `keyword` LIKE 'reviews' LIMIT 1");
		if ($query_name->num_rows == 0) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "url_alias SET query = 'product/uni_reviews', keyword = 'reviews'");
		} else {
			$this->db->query("DELETE FROM " . DB_PREFIX . "url_alias WHERE keyword = 'reviews'");
			$this->db->query("INSERT INTO " . DB_PREFIX . "url_alias SET query = 'product/uni_reviews', keyword = 'reviews'");
		}
	}

	protected function validate() {
		if (!$this->user->hasPermission('modify', 'extension/module/uni_reviews')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		if ((utf8_strlen($this->request->post['name']) < 3) || (utf8_strlen($this->request->post['name']) > 64)) {
			$this->error['name'] = $this->language->get('error_name');
		}

		return !$this->error;
	}
}