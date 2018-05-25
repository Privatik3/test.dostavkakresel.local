<?php

class ControllerExtensionModuleFabrickchoiceCategory extends Controller {
	private $error = array();
	private $category_id = 0;
	private $path = array();

	public function index() {

		$this->load->language('extension/module/fabrickchoice');

		$this->document->setTitle($this->language->get('heading_title_category'));

		$this->load->model('extension/module/fabrickchoice');

		$this->getList();
	}

	public function add() {
		$this->load->language('extension/module/fabrickchoice');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('extension/module/fabrickchoice');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_extension_module_fabrickchoice->addCategory($this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			$this->response->redirect($this->url->link('extension/module/fabrickchoice/category', 'token=' . $this->session->data['token'] . $url, TRUE));
		}

		$this->getForm();
	}

	public function edit() {
		
		$this->load->language('extension/module/fabrickchoice');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('extension/module/fabrickchoice');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_extension_module_fabrickchoice->editCategory($this->request->get['category_id'], $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			$this->response->redirect($this->url->link('extension/module/fabrickchoice/category', 'token=' . $this->session->data['token'] . $url, TRUE));
		}

		$this->getForm();
	}

	public function delete() {
		$this->load->language('catalog/category');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('extension/module/fabrickchoice');

		if (isset($this->request->post['selected']) && $this->validateDelete()) {
			foreach ($this->request->post['selected'] as $category_id) {
				$this->model_extension_module_fabrickchoice->deleteCategory($category_id);
			}

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			$this->response->redirect($this->url->link('extension/module/fabrickchoice/category', 'token=' . $this->session->data['token'] . $url, TRUE));
		}

		$this->getList();
	}

	public function repair() {

		$this->load->language('extension/module/fabrickchoice');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('extension/module/fabrickchoice');

		if ($this->validateRepair()) {
			$this->model_extension_module_fabrickchoice->repairCategories();

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			$this->response->redirect($this->url->link('extension/module/fabrickchoice/category', 'token=' . $this->session->data['token'] . $url, true));
		}

		$this->getList();
	}

	protected function getList() {
		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'name';
		}

		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
		} else {
			$order = 'ASC';
		}

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}

		$url = '';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], TRUE)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('extension/module/fabrickchoice/category', 'token=' . $this->session->data['token'] . $url, TRUE)
		);

		$data['add'] = $this->url->link('extension/module/fabrickchoice/category/add', 'token=' . $this->session->data['token'] . $url, TRUE);
		$data['delete'] = $this->url->link('extension/module/fabrickchoice/category/delete', 'token=' . $this->session->data['token'] . $url, TRUE);

		$data['repair'] = $this->url->link('extension/module/fabrickchoice/category/repair', 'token=' . $this->session->data['token'] . $url, true);

		$data['categories'] = array();

		if (isset($this->request->get['path'])) {
			if ($this->request->get['path'] != '') {
				$this->path = explode('_', $this->request->get['path']);
				$this->category_id = end($this->path);
				$this->session->data['path'] = $this->request->get['path'];
			} else {
				unset($this->session->data['path']);
			}
		} elseif (isset($this->session->data['path'])) {
			$this->path = explode('_', $this->session->data['path']);
			$this->category_id = end($this->path);
		}

		$data['categories'] = $this->getCategories(0);

		$category_total = count($data['categories']);

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_list'] = $this->language->get('text_list');
		$data['text_no_results'] = $this->language->get('text_no_results');
		$data['text_confirm'] = $this->language->get('text_confirm');

		$data['column_name'] = $this->language->get('column_name');
		$data['column_sort_order'] = $this->language->get('column_sort_order');
		$data['column_action'] = $this->language->get('column_action');

		$data['button_add'] = $this->language->get('button_add');
		$data['button_edit'] = $this->language->get('button_edit');
		$data['button_delete'] = $this->language->get('button_delete');
		$data['button_rebuild'] = $this->language->get('button_rebuild');

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];

			unset($this->session->data['success']);
		} else {
			$data['success'] = '';
		}

		if (isset($this->request->post['selected'])) {
			$data['selected'] = (array)$this->request->post['selected'];
		} else {
			$data['selected'] = array();
		}

		$url = '';

		if ($order == 'ASC') {
			$url .= '&order=DESC';
		} else {
			$url .= '&order=ASC';
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		$data['sort_name'] = $this->url->link('extension/module/fabrickchoice/category', 'token=' . $this->session->data['token'] . '&sort=name' . $url, TRUE);
		$data['sort_sort_order'] = $this->url->link('extension/module/fabrickchoice/category', 'token=' . $this->session->data['token'] . '&sort=sort_order' . $url, TRUE);

		$url = '';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		if (isset($this->request->get['path'])) {
			$url .= '&path=' . $this->request->get['path'];
		}

		$pagination = new Pagination();
		$pagination->total = $category_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_limit_admin');
		$pagination->url = $this->url->link('extension/module/fabrickchoice/category', 'token=' . $this->session->data['token'] . $url . '&page={page}', TRUE);

		$data['pagination'] = $pagination->render();

		$data['results'] = sprintf($this->language->get('text_pagination'), ($category_total) ? (($page - 1) * $this->config->get('config_limit_admin')) + 1 : 0, ((($page - 1) * $this->config->get('config_limit_admin')) > ($category_total - $this->config->get('config_limit_admin'))) ? $category_total : ((($page - 1) * $this->config->get('config_limit_admin')) + $this->config->get('config_limit_admin')), $category_total, ceil($category_total / $this->config->get('config_limit_admin')));

		$data['sort'] = $sort;
		$data['order'] = $order;

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('extension/module/fabrickchoice/category_list', $data));
	}

	protected function getForm() {

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_form'] = !isset($this->request->get['category_id']) ? $this->language->get('text_add') : $this->language->get('text_edit');
		$data['text_none'] = $this->language->get('text_none');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');

		$data['entry_name'] = $this->language->get('entry_name');
		$data['entry_parent'] = $this->language->get('entry_parent');
		$data['entry_sort_order'] = $this->language->get('entry_sort_order');
		$data['entry_status'] = $this->language->get('entry_status');
		$data['entry_option'] = $this->language->get('entry_option');
		$data['entry_option_value'] = $this->language->get('entry_option_value');

		$data['help_option_value'] = $this->language->get('help_option_value');

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
			$data['error_name'] = array();
		}

		if (isset($this->error['parent'])) {
			$data['error_parent'] = $this->error['parent'];
		} else {
			$data['error_parent'] = '';
		}

		$url = '';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], TRUE)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('extension/module/fabrickchoice/category', 'token=' . $this->session->data['token'] . $url, TRUE)
		);

		if (!isset($this->request->get['category_id'])) {
			$data['action'] = $this->url->link('extension/module/fabrickchoice/category/add', 'token=' . $this->session->data['token'] . $url, TRUE);
		} else {
			$data['action'] = $this->url->link('extension/module/fabrickchoice/category/edit', 'token=' . $this->session->data['token'] . '&category_id=' . $this->request->get['category_id'] . $url, TRUE);
		}

		$data['cancel'] = $this->url->link('extension/module/fabrickchoice/category', 'token=' . $this->session->data['token'] . $url, TRUE);

		if (isset($this->request->get['category_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$category_info = $this->model_extension_module_fabrickchoice->getCategory($this->request->get['category_id']);
		}

		$data['token'] = $this->session->data['token'];

		$this->load->model('localisation/language');

		$data['languages'] = $this->model_localisation_language->getLanguages();

		$data['lang'] = $this->language->get('lang');

		if (isset($this->request->post['category_description'])) {
			$data['category_description'] = $this->request->post['category_description'];
		} elseif (isset($this->request->get['category_id'])) {
			$data['category_description'] = $this->model_extension_module_fabrickchoice->getCategoryDescriptions($this->request->get['category_id']);
		} else {
			$data['category_description'] = array();
		}

		// Categories
		$categories = $this->model_extension_module_fabrickchoice->getAllCategories();

		$data['categories'] = $this->getAllCategories($categories);

		// Options
		$this->load->model('catalog/option');

		$data['options'] = $this->model_catalog_option->getOptions();

		$allowed_type = [
			'select', 'radio', 'checkbox'
		];

		foreach ($data['options'] as $key => $option) {

			if (!in_array($option['type'], $allowed_type)) {
				unset($data['options'][$key]);
			}

		}
		
		if (isset($this->request->get['category_id'])) {
			$data['options_values'] = $this->model_extension_module_fabrickchoice->getOptionsValues($this->request->get['category_id']);
		} else {
			$data['options_values'] = array();
		}
		
		if (isset($category_info)) {
			unset($data['categories'][$category_info['category_id']]);
		}

		if (isset($this->request->post['parent_id'])) {
			$data['parent_id'] = $this->request->post['parent_id'];
		} elseif (!empty($category_info)) {
			$data['parent_id'] = $category_info['parent_id'];
		} else {
			$data['parent_id'] = 0;
		}

		if (isset($this->request->post['sort_order'])) {
			$data['sort_order'] = $this->request->post['sort_order'];
		} elseif (!empty($category_info)) {
			$data['sort_order'] = $category_info['sort_order'];
		} else {
			$data['sort_order'] = 0;
		}

		if (isset($this->request->post['status'])) {
			$data['status'] = $this->request->post['status'];
		} elseif (!empty($category_info)) {
			$data['status'] = $category_info['status'];
		} else {
			$data['status'] = TRUE;
		}

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('extension/module/fabrickchoice/category_form', $data));
	}

	protected function validateForm() {
		if (!$this->user->hasPermission('modify', 'extension/module/fabrickchoice')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if ($this->error && !isset($this->error['warning'])) {
			$this->error['warning'] = $this->language->get('error_warning');
		}

		return !$this->error;
	}

	protected function validateDelete() {
		if (!$this->user->hasPermission('modify', 'extension/module/fabrickchoice')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		return !$this->error;
	}

	protected function validateRepair() {
		if (!$this->user->hasPermission('modify', 'extension/module/fabrickchoice')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		return !$this->error;
	}

	private function getCategories($parent_id, $parent_path = '', $indent = '') {
		$category_id = array_shift($this->path);

		$output = array();

		static $href_category = NULL;
		static $href_action = NULL;

		if ($href_category === NULL) {
			$href_category = $this->url->link('extension/module/fabrickchoice/category', 'token=' . $this->session->data['token'] . '&path=', 'SSL');
			$href_action = $this->url->link('extension/module/fabrickchoice/category/update', 'token=' . $this->session->data['token'] . '&category_id=', 'SSL');
		}

		$url = '';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		$results = $this->model_extension_module_fabrickchoice->getCategoriesByParentId($parent_id);

		foreach ($results as $result) {
			$path = $parent_path . $result['category_id'];

			$href = ($result['children']) ? $href_category . $path : '';

			$name = $result['name'];

			if ($category_id == $result['category_id']) {
				$name = '<b>' . $name . '</b>';

				$data['breadcrumbs'][] = array(
					'text'      => $result['name'],
					'href'      => $href,
					'separator' => ' :: '
				);

				$href = '';
			}

			$selected = isset($this->request->post['selected']) && in_array($result['category_id'], $this->request->post['selected']);

			$action = array();

			$action[] = array(
				'text' => $this->language->get('text_edit'),
				'href' => $href_action . $result['category_id']
			);

			$output[$result['category_id']] = array(
				'category_id' => $result['category_id'],
				'name'        => $name,
				'sort_order'  => $result['sort_order'],
				'selected'    => $selected,
				'action'      => $action,
				'edit'        => $this->url->link('extension/module/fabrickchoice/category/edit', 'token=' . $this->session->data['token'] . '&category_id=' . $result['category_id'] . $url, 'SSL'),
				'delete'      => $this->url->link('extension/module/fabrickchoice/category/delete', 'token=' . $this->session->data['token'] . '&category_id=' . $result['category_id'] . $url, 'SSL'),
				'href'        => $href,
				'indent'      => $indent
			);

			if ($category_id == $result['category_id']) {
				$output += $this->getCategories($result['category_id'], $path . '_', $indent . str_repeat('&nbsp;', 8));
			}
		}

		return $output;
	}

	private function getAllCategories($categories, $parent_id = 0, $parent_name = '') {
		$output = array();

		if (array_key_exists($parent_id, $categories)) {
			if ($parent_name != '') {
				//$parent_name .= $this->language->get('text_separator');
				$parent_name .= ' &gt; ';
			}

			foreach ($categories[$parent_id] as $category) {
				$output[$category['category_id']] = array(
					'category_id' => $category['category_id'],
					'name'        => $parent_name . $category['name']
				);

				$output += $this->getAllCategories($categories, $category['category_id'], $parent_name . $category['name']);
			}
		}

		uasort($output, array($this, 'sortByName'));

		return $output;
	}

	function sortByName($a, $b) {
		return strcmp($a['name'], $b['name']);
	}

	public function autocomplete() {
		$json = array();

		if (isset($this->request->get['filter_name'])) {
			$this->load->model('extension/module/fabrickchoice');

			$filter_data = array(
				'filter_name' => $this->request->get['filter_name'],
				'sort'        => 'name',
				'order'       => 'ASC',
				'start'       => 0,
				'limit'       => 50
			);

			$results = $this->model_extension_module_fabrickchoice->getCategories($filter_data);

			foreach ($results as $result) {
				$json[] = array(
					'category_id' => $result['category_id'],
					'name'        => strip_tags(html_entity_decode($result['name'], ENT_QUOTES, 'UTF-8'))
				);
			}
		}

		$sort_order = array();

		foreach ($json as $key => $value) {
			$sort_order[$key] = $value['name'];
		}

		array_multisort($sort_order, SORT_ASC, $json);

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	public function getOptionValues() {
		$json = array();
		if (isset($this->request->get['option_id'])) {
			$this->load->model('catalog/option');
			$this->load->model('extension/module/fabrickchoice');

			$option_values = $this->model_catalog_option->getOptionValues($this->request->get['option_id']);


			foreach ($option_values as $option_value) {

				$option_value_data[$option_value['option_value_id']] = array(
					'option_value_id' => $option_value['option_value_id'],
					'name'            => strip_tags(html_entity_decode($option_value['name'], ENT_QUOTES, 'UTF-8')),
				);
			}

			$all_option_values = $this->model_extension_module_fabrickchoice->getOptionsValues();

			foreach ($all_option_values as $value_id){
				if (isset($option_value_data[$value_id['option_value_id']])) {
					unset($option_value_data[$value_id['option_value_id']]);
				}
			}

			$sort_order = array();

			if (isset($option_value_data)) {

				foreach ($option_value_data as $key => $value) {
					$sort_order[$key] = $value['name'];
				}

				array_multisort($sort_order, SORT_ASC, $option_value_data);

				$json = array(
					'option_value' => $option_value_data
				);

			}
		}
		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	public function optionautocomplete() {
		$json = array();

		if (isset($this->request->get['filter_name'])) {
			$this->load->language('catalog/option');

			$this->load->model('catalog/option');

			$this->load->model('tool/image');

			$filter_data = array(
				'filter_name' => $this->request->get['filter_name'],
				'start'       => 0,
				'limit'       => 50
			);

			$options = $this->model_catalog_option->getOptions($filter_data);

			$this->load->model('extension/module/fabrickchoice');

			foreach ($options as $option) {
				$option_value_data = array();

				if ($option['type'] == 'select' || $option['type'] == 'radio' || $option['type'] == 'checkbox' || $option['type'] == 'image') {
					$option_values = $this->model_catalog_option->getOptionValues($option['option_id']);

					foreach ($option_values as $option_value) {
						if (is_file(DIR_IMAGE . $option_value['image'])) {
							$image = $this->model_tool_image->resize($option_value['image'], 50, 50);
						} else {
							$image = $this->model_tool_image->resize('no_image.png', 50, 50);
						}

						$option_value_data[$option_value['option_value_id']] = array(
							'option_value_id' => $option_value['option_value_id'],
							'name'            => strip_tags(html_entity_decode($option_value['name'], ENT_QUOTES, 'UTF-8')),
							'image'           => $image
						);

					}

					$option_value_data = $this->arrageByCategory($option_value_data);

				}

				$type = '';

				if ($option['type'] == 'select' || $option['type'] == 'radio' || $option['type'] == 'checkbox') {
					$type = $this->language->get('text_choose');
				}

				if ($option['type'] == 'text' || $option['type'] == 'textarea') {
					$type = $this->language->get('text_input');
				}

				if ($option['type'] == 'file') {
					$type = $this->language->get('text_file');
				}

				if ($option['type'] == 'date' || $option['type'] == 'datetime' || $option['type'] == 'time') {
					$type = $this->language->get('text_date');
				}

				$json[] = array(
					'option_id'    => $option['option_id'],
					'name'         => strip_tags(html_entity_decode($option['name'], ENT_QUOTES, 'UTF-8')),
					'category'     => $type,
					'type'         => $option['type'],
					'option_value' => $option_value_data
				);
			}
		}

		$sort_order = array();

		foreach ($json as $key => $value) {
			$sort_order[$key] = $value['name'];
		}

		array_multisort($sort_order, SORT_ASC, $json);

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	public function arrageByCategory($option_value){

		$this->load->model('extension/module/fabrickchoice');

		$val_by_cat = $this->model_extension_module_fabrickchoice->getCategoriesByVal(array_keys($option_value));

		$val_tree = array();

		if ($val_by_cat) {
			$all_cats = $this->model_extension_module_fabrickchoice->getAllCategoriesForTree();

			$val_tree = $this->build_tree_category($all_cats, 0, $val_by_cat, $option_value);

			foreach ($val_by_cat as $cat) {
				foreach ($cat as $value) {
					unset($option_value[$value]);
				}
			}
		}

		$option_value = array_merge($val_tree, $option_value);
		
		return $option_value;
	}

	protected function build_tree_category($cats, $parent_id = 0, $val_by_category, &$option_value){
		$this->load->model('extension/module/fabrickchoice');

		$tree = array();
		if(is_array($cats) and isset($cats[$parent_id])){

			foreach($cats[$parent_id] as $cat){
				$tree[] =  [
					'category_id' => $cat['category_id'],
					'name' => $this->model_extension_module_fabrickchoice->getCategoryDescriptions($cat['category_id'])[$this->config->get('config_language_id')]['name'],
					'child' => $this->build_tree_category($cats,$cat['category_id'], $val_by_category, $option_value),
					'option_value' => (isset($val_by_category[$cat['category_id']])) ? $val_by_category[$cat['category_id']] : ''
				];

				end($tree);
				$end_key = key($tree);

				if (!$tree[$end_key]['child']) {
					unset($tree[$end_key]['child']);
				}

				if (!is_array($tree[$end_key]['option_value'])) {
					unset($tree[$end_key]['option_value']);
				} else {
					foreach ($tree[$end_key]['option_value'] as $key => $opt){
						$tree[$end_key]['option_value'][$key] = $option_value[$opt];
					}
				}

				if (!isset($tree[$end_key]['option_value']) && !isset($tree[$end_key]['child'])){
					unset($tree[$end_key]);
				}
			}
		}

		else return null;

		return $tree;
	}
}
