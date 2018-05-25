<?php
class ControllerExtensionModuleArt6Filter extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('extension/module/art6_filter');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('art6_filter', $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('extension/extension', 'token=' . $this->session->data['token'], 'SSL'));
		}

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_edit'] = $this->language->get('text_edit');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');

		$data['entry_status'] = $this->language->get('entry_status');
		$data['entry_update_table'] = $this->language->get('entry_update_table');

		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');
		$data['button_update_table'] = $this->language->get('button_update_table');

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_module'),
			'href' => $this->url->link('extension/extension', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('extension/module/art6_filter', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['action'] = $this->url->link('extension/module/art6_filter', 'token=' . $this->session->data['token'], 'SSL');
		$data['update'] = str_replace('&amp;', '&', $this->url->link('extension/module/art6_filter/update', 'token=' . $this->session->data['token'], 'SSL'));
		$data['cancel'] = $this->url->link('extension/extension', 'token=' . $this->session->data['token'], 'SSL');

		$this->load->model('extension/module/art6_filter');

		$data['text_update_table'] = $this->language->get('text_update_table');
		$data['text_clear_table'] = $this->language->get('text_clear_table');

		$data['modification_id'] = $this->model_extension_module_art6_filter->getTableInfo();

		if ($data['modification_id']) {
			$data['update'] = str_replace('&amp;', '&', $this->url->link('extension/module/art6_filter/clear', 'token=' . $this->session->data['token'], 'SSL'));
		}

		if (isset($this->request->post['art6_filter_status'])) {
			$status = $this->request->post['art6_filter_status'];

			// Сделать обновление и удаление таблиц без кнопки "Обновить"

			$data['art6_filter_status'] = $status;
		} else {
			$data['art6_filter_status'] = $this->config->get('art6_filter_status');
		}

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('extension/module/art6_filter', $data));
	}

	public function update() {
		$json = array();
		
		$this->load->language('extension/module/art6_filter');
		$this->load->model('extension/module/art6_filter');
		
		$text['text_name'] = $this->language->get('text_name');

		$text['error_install_xml'] = $this->language->get('error_install_xml');
		$text['error_alter_table'] = $this->language->get('error_alter_table');

		$modification_id = $this->request->post['modification_id'];

		$update = $this->model_extension_module_art6_filter->tableUpdate($text, $modification_id);

		if ($update) {
			$json['error'] = $update;
		} else {
			$json['result'] = $this->language->get('success_update');
			$json['modification'] = $data['update'] = $this->url->link('extension/modification', 'token=' . $this->session->data['token'], 'SSL');
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	public function clear() {
		$json = array();
		
		$this->load->language('extension/module/art6_filter');
		$this->load->model('extension/module/art6_filter');

		$this->model_extension_module_art6_filter->tableClear();

		$json['result'] = $this->language->get('success_clear');

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	protected function validate() {
		if (!$this->user->hasPermission('modify', 'extension/module/art6_filter')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		return !$this->error;
	}
}