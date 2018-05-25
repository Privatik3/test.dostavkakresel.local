<?php
class ControllerExtensionModuleFabrickchoice extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('extension/module/fabrickchoice');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('setting/setting');
		$this->load->model('catalog/option');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('fabrickchoice', $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true));
		}

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_edit'] = $this->language->get('text_edit');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');

		$data['entry_status'] = $this->language->get('entry_status');
		$data['entry_option_select'] = $this->language->get('entry_option_select');
		$data['entry_tag'] = $this->language->get('entry_tag');
		$data['entry_greates'] = $this->language->get('entry_greates');
		$data['entry_image'] = $this->language->get('entry_image');
		$data['entry_thumb'] = $this->language->get('entry_thumb');
		$data['entry_width'] = $this->language->get('entry_width');
		$data['entry_height'] = $this->language->get('entry_height');

		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->error['image_thumb'])) {
			$data['error_thumb'] = $this->error['image_thumb'];
		} else {
			$data['error_thumb'] = '';
		}

		if (isset($this->error['image_image'])) {
			$data['error_image'] = $this->error['image_image'];
		} else {
			$data['error_image'] = '';
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_extension'),
			'href' => $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('extension/module/fabrickchoice', 'token=' . $this->session->data['token'], true)
		);

		$data['action'] = $this->url->link('extension/module/fabrickchoice', 'token=' . $this->session->data['token'], true);

		$data['cancel'] = $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true);

		if (isset($this->request->post['fabrickchoice_fc_option'])) {
			$fabrickchoice_fc_option = $this->request->post['fabrickchoice_fc_option'];
		} else {
			$fabrickchoice_fc_option = $this->config->get('fabrickchoice_fc_option');
		}

		$data['options'] = $this->model_catalog_option->getOptions();
		$data['fabrickchoice_fc_option'] = array();
		
		if (is_array($data['options']) && $fabrickchoice_fc_option) {
			foreach ($data['options'] as $key => $option) {
				if (in_array($option['option_id'], $fabrickchoice_fc_option)) {
					$data['fabrickchoice_fc_option'][] = array(
						'option_id' => $option['option_id'],
						'name'      => $option['name']
					);
					unset($data['options'][$key]);
				}
			}
		}

		if (isset($this->request->post['fabrickchoice_tag'])) {
			$data['fabrickchoice_tag'] = $this->request->post['fabrickchoice_tag'];
		} elseif ($this->config->get('fabrickchoice_tag')){
			$data['fabrickchoice_tag'] = $this->config->get('fabrickchoice_tag');
		} else {
			$data['fabrickchoice_tag'] = htmlentities('<button type="button" id="button-cart"');
		}

		if (isset($this->request->post['fabrickchoice_greates'])) {
			$data['fabrickchoice_greates'] = $this->request->post['fabrickchoice_greates'];
		} else {
			$data['fabrickchoice_greates'] = $this->config->get('fabrickchoice_greates');
		}

		if (isset($this->request->post['fabrickchoice_image_width'])) {
			$data['fabrickchoice_image_width'] = $this->request->post['fabrickchoice_image_width'];
		} elseif ($this->config->get('fabrickchoice_image_width')) {
			$data['fabrickchoice_image_width'] = $this->config->get('fabrickchoice_image_width');
		} else {
			$data['fabrickchoice_image_width'] = 50;
		}

		if (isset($this->request->post['fabrickchoice_image_height'])) {
			$data['fabrickchoice_image_height'] = $this->request->post['fabrickchoice_image_height'];
		} elseif ($this->config->get('fabrickchoice_image_height')) {
			$data['fabrickchoice_image_height'] = $this->config->get('fabrickchoice_image_height');
		} else {
			$data['fabrickchoice_image_height'] = 50;
		}

		if (isset($this->request->post['fabrickchoice_thumb_width'])) {
			$data['fabrickchoice_thumb_width'] = $this->request->post['fabrickchoice_thumb_width'];
		} elseif ($this->config->get('fabrickchoice_thumb_width')) {
			$data['fabrickchoice_thumb_width'] = $this->config->get('fabrickchoice_thumb_width');
		} else {
			$data['fabrickchoice_thumb_width'] = 500;
		}

		if (isset($this->request->post['fabrickchoice_thumb_height'])) {
			$data['fabrickchoice_thumb_height'] = $this->request->post['fabrickchoice_thumb_height'];
		} elseif ($this->config->get('fabrickchoice_thumb_height')) {
			$data['fabrickchoice_thumb_height'] = $this->config->get('fabrickchoice_thumb_height');
		} else {
			$data['fabrickchoice_thumb_height'] = 50;
		}

		if (isset($this->request->post['fabrickchoice_status'])) {
			$data['fabrickchoice_status'] = $this->request->post['fabrickchoice_status'];
		} else {
			$data['fabrickchoice_status'] = $this->config->get('fabrickchoice_status');
		}

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('extension/module/fabrickchoice', $data));
	}

	protected function validate() {
		if (!$this->user->hasPermission('modify', 'extension/module/fabrickchoice')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (!$this->request->post['fabrickchoice_thumb_width'] || !$this->request->post['fabrickchoice_thumb_height']) {
			$this->error['image_thumb'] = $this->language->get('error_thumb');
		}

		if (!$this->request->post['fabrickchoice_image_width'] || !$this->request->post['fabrickchoice_image_height']) {
			$this->error['image_image'] = $this->language->get('error_image');
		}
		
		return !$this->error;
	}

	public function install() {

		$this->load->model('extension/module/fabrickchoice');
		$this->load->model('setting/setting');
		$this->load->model('extension/extension');
		$this->load->model('extension/event');
		$this->load->model('user/user_group');

		$this->model_user_user_group->addPermission($this->user->getGroupId(), 'access', 'extension/module/fabrickchoice');
		$this->model_user_user_group->addPermission($this->user->getGroupId(), 'modify', 'extension/module/fabrickchoice');
		$this->model_user_user_group->addPermission($this->user->getGroupId(), 'access', 'extension/module/fabrickchoice');
		$this->model_user_user_group->addPermission($this->user->getGroupId(), 'modify', 'extension/module/fabrickchoice');

		$this->model_user_user_group->addPermission($this->user->getGroupId(), 'access', 'extension/module/fabrickchoice/category');
		$this->model_user_user_group->addPermission($this->user->getGroupId(), 'modify', 'extension/module/fabrickchoice/category');
		$this->model_user_user_group->addPermission($this->user->getGroupId(), 'access', 'extension/module/fabrickchoice/category');
		$this->model_user_user_group->addPermission($this->user->getGroupId(), 'modify', 'extension/module/fabrickchoice/category');

		$this->model_extension_module_fabrickchoice->install();
		$this->model_extension_event->addEvent('fabrickchoice_menu', 'admin/view/common/column_left/before', 'extension/module/fabrickchoice/eventMenu');
		$this->model_extension_event->addEvent('fabrickchoice_product', 'admin/view/catalog/product_form/after', 'extension/module/fabrickchoice/eventProductForm');
		$this->model_extension_event->addEvent('fabrickchoice_edit_product', 'admin/model/catalog/product/editProduct/after', 'extension/module/fabrickchoice/eventEditProduct');
		$this->model_extension_event->addEvent('fabrickchoice_add_product', 'admin/model/catalog/product/addProduct/after', 'extension/module/fabrickchoice/eventAddProduct');
		$this->model_extension_event->addEvent('fabrickchoice_copy_product', 'admin/model/catalog/product/copyProduct/after', 'extension/module/fabrickchoice/eventCopyProduct');
		$this->model_extension_event->addEvent('fabrickchoice_delete_product', 'admin/model/catalog/product/deleteProduct/before', 'extension/module/fabrickchoice/eventDeleteProduct');
		$this->model_extension_event->addEvent('fabrickchoice_catalog_before', 'catalog/view/product/product/before', 'extension/module/fabrickchoice/eventCatalogProductBefore');
		$this->model_extension_event->addEvent('fabrickchoice_catalog_after', 'catalog/view/*/product/product/after', 'extension/module/fabrickchoice/eventCatalogProductAfter');
		$this->model_extension_event->addEvent('fabrickchoice_catalog_success', 'catalog/controller/checkout/success/before', 'extension/module/fabrickchoice/eventCatalogSuccessBefore');

	}

	public function uninstall() {
		$this->load->model('extension/module/fabrickchoice');
		$this->load->model('setting/setting');
		$this->load->model('extension/extension');
		$this->load->model('extension/event');

		$this->model_extension_module_fabrickchoice->uninstall();
		$this->model_extension_extension->uninstall('fabrickchoice', $this->request->get['extension']);
		$this->model_setting_setting->deleteSetting($this->request->get['extension']);
		$this->model_extension_event->deleteEvent('fabrickchoice_menu');
		$this->model_extension_event->deleteEvent('fabrickchoice_product');
		$this->model_extension_event->deleteEvent('fabrickchoice_edit_product');
		$this->model_extension_event->deleteEvent('fabrickchoice_add_product');
		$this->model_extension_event->deleteEvent('fabrickchoice_copy_product');
		$this->model_extension_event->deleteEvent('fabrickchoice_delete_product');
		$this->model_extension_event->deleteEvent('fabrickchoice_catalog_before');
		$this->model_extension_event->deleteEvent('fabrickchoice_catalog_after');
		$this->model_extension_event->deleteEvent('fabrickchoice_catalog_success');

	}

	public function eventMenu($route, &$data) {
		
		// Fabrickchoice menu
		$fabrickchoice_menu = array();

		$this->language->load('extension/module/fabrickchoice');

		if ($this->user->hasPermission('access', 'extension/module/fabrickchoice')) {
			$fabrickchoice_menu[] = array(
				'name'	   => $this->language->get('heading_title_category'),
				'href'     => $this->url->link('extension/module/fabrickchoice/category', 'token=' . $this->session->data['token'], true),
				'children' => array()
			);
		}

		foreach ($data['menus'] as $key => $menu){
			if ($menu['id'] == 'menu-catalog') {
				break;
			}
		}

		foreach ($data['menus'][$key]['children'] as $index => $children){
			if ($children['name'] == $this->language->get('text_option')) {
				break;
			}
		}

		array_splice($data['menus'][$key]['children'], $index+1, 0, $fabrickchoice_menu);
	}

	public function eventProductForm(&$route, &$data, &$output) {

		$this->language->load('extension/module/fabrickchoice');
		$this->load->model('extension/module/fabrickchoice');


		$data['entry_fcr'] = $this->language->get('entry_fcr');

		if (isset($this->request->post['product_option'])) {
			foreach ($this->request->post['product_option'] as $key => $option) {
				if (isset($option['fcr'])) {
					$data['product_options'][$key]['fcr'] = $option['fcr'];
				}
			}
		} else {
			if (isset($this->request->get['product_id'])) {
			foreach ($data['product_options'] as $key => $option) {
					$m_data = array(
						'product_id' => $this->request->get['product_id'],
						'product_option_id' => $option['product_option_id']
					);
					$data['product_options'][$key]['fcr'] = $this->model_extension_module_fabrickchoice->getOptionFcr($m_data);

				}
			}
		}

		$this->load->model('catalog/option');
		$option_row = 0;
		foreach ($data['product_options'] as $key => $option) {
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

				$option_value_data = $this->load->controller('extension/module/fabrickchoice/category/arrageByCategory', $option_value_data);

				$words = array(
					'entry_quantity'    => $data['entry_quantity'],
					'text_yes'          => $data['text_yes'],
					'text_no'           => $data['text_no'],
					'entry_price'       => $data['entry_price'],
					'entry_points'      => $data['entry_points'],
					'entry_weight'      => $data['entry_weight'],
				);

				foreach ($data['product_options'][$key]['product_option_value'] as $index=>$value){
					$data['product_options'][$key]['product_option_value'][$value['option_value_id']] = $value;
					unset($data['product_options'][$key]['product_option_value'][$index]);
				}

				$data['product_options'][$key]['view'] = $this->renderOption($option_value_data, $words, $data['product_options'][$key], $option_row);

			}
			$option_row++;
		}

		$data['fabrickchoice_tab']= $this->load->view('extension/module/fabrickchoice/category_options', $data);

//		$match = array();
//		preg_match('!<script type="text/javascript">[^/]+var option_value_row.+?</script>!s', $output, $match);
//		print_r($match);
//		exit();
//		$output = preg_replace('!<script type="text/javascript">(.*?)var option_value_row(.*?)</script>!si', '', $output);
//
//		$output = preg_replace('!<script type="text/javascript">(.*?)catalog/option/autocomplete(.*?)</script>!si', '', $output);

		$output = preg_replace('!<script type="text/javascript">[^/]+var option_value_row.+?</script>!s', '', $output);
		$output = preg_replace('!<script type="text/javascript">[^/]+catalog/option/autocomplete.+?</script>!si', '', $output);
		$output = preg_replace('!<div class="tab-pane" id="tab-option">(.*?)<div class="tab-pane" id="tab-recurring">!si', $data['fabrickchoice_tab'], $output);

	}

	protected function renderOption($option_value_data, $words, $option_product, $option_row){

		$html = '';
		foreach ($option_value_data as $data)
		{
			$data = array_merge($data, $words);
			$data['option_product'] = $option_product;
			$data['option_row'] = $option_row;

				if (isset($data['category_id'])) {
					$html .= $this->load->view('extension/module/fabrickchoice/option_table', $data);
				}

				if (isset($data['child'])) {
						$html .= $this->renderOption($data['child'], $words, $data['option_product'], $data['option_row']);
				}

				if (isset($data['option_value_id'])) {
					$html .= $this->load->view('extension/module/fabrickchoice/option_table', $data);
				}

				if (isset($data['category_id'])) {
					$html .= $this->load->view('extension/module/fabrickchoice/option_table', array('footer' => true));
				}

		}

		return $html;
	}

	public function eventEditProduct($route, &$data) {

		$this->load->model('extension/module/fabrickchoice');
		$this->load->model('catalog/option');

		$product_options = $this->model_catalog_product->getProductOptions($data[0]);

		foreach ($product_options as $key => $option) {
			if ($option['type'] == 'select' || $option['type'] == 'radio' || $option['type'] == 'checkbox' || $option['type'] == 'image') {

				foreach ($data[1]['product_option'] as $key => $opt){

					if ($opt['option_id'] == $option['option_id']) {

						$fcr = $opt['fcr'];
						unset($data[1]['product_option'][$key]);

					}
				}

				$m_data['option'][] = array(
					'product_option_id' => $option['product_option_id'],
					'fcr'               => $fcr
				);

			}
		}

		if (isset($m_data)) {
			$m_data['product_id'] = $data[0];
			$this->model_extension_module_fabrickchoice->setFcr($m_data);
		}

	}

	public function eventAddProduct($route, &$data) {

		$this->load->model('extension/module/fabrickchoice');
		$this->load->model('catalog/option');

		$product_id = $this->model_extension_module_fabrickchoice->getLastProduct();
		$product_options = $this->model_catalog_product->getProductOptions($product_id);

		foreach ($product_options as $key => $option) {
			if ($option['type'] == 'select' || $option['type'] == 'radio' || $option['type'] == 'checkbox' || $option['type'] == 'image') {

				foreach ($data[0]['product_option'] as $key => $opt){

					if ($opt['option_id'] == $option['option_id']) {

						$fcr = $opt['fcr'];
						unset($data[0]['product_option'][$key]);

					}
				}

				$m_data['option'][] = array(
					'product_option_id' => $option['product_option_id'],
					'fcr'               => $fcr
				);
				
			}
		}

		if (isset($m_data)) {
			$m_data['product_id'] = $product_id;
			$this->model_extension_module_fabrickchoice->setFcr($m_data);
		}
	}

	public function eventCopyProduct($route, &$data) {

		$this->load->model('extension/module/fabrickchoice');
		$this->load->model('catalog/option');

		$product_id = $this->model_extension_module_fabrickchoice->getLastProduct();

		$product_options = $this->model_catalog_product->getProductOptions($product_id);
		$copy_product_options = $this->model_catalog_product->getProductOptions($data[0]);

		foreach ($copy_product_options as $key => $option) {
			if ($option['type'] == 'select' || $option['type'] == 'radio' || $option['type'] == 'checkbox' || $option['type'] == 'image') {

				$c_data = array(
					'product_id' => $data[0],
					'product_option_id' => $option['product_option_id']
				);

				$fcr = $this->model_extension_module_fabrickchoice->getOptionFcr($c_data);;

				$m_data['option'][] = array(
					'product_option_id' => $product_options[$key]['product_option_id'],
					'fcr'               => $fcr
				);
			}
		}

		if (isset($m_data)) {
			$m_data['product_id'] = $product_id;
			$this->model_extension_module_fabrickchoice->setFcr($m_data);
		}
	}

	public function eventDeleteProduct($route, &$data) {

		$this->load->model('extension/module/fabrickchoice');
		$this->load->model('catalog/option');

		foreach ($data as $product_id) {
				$this->model_extension_module_fabrickchoice->deleteFcr($product_id);
		}
	}

}