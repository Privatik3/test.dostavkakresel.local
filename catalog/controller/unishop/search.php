<?php
class ControllerUniShopSearch extends Controller {
	public function index() {
		$this->load->model('catalog/product');
		$this->load->model('tool/image');
		
		$this->load->model('unishop/setting');
		$settings = $this->model_unishop_setting->getSetting();
		$language_id = $this->config->get('config_language_id');
		
		$data['show_search'] = isset($settings['show_search']) ? $settings['show_search'] : '';
		
		$json = array();
		
		$search = isset($this->request->get['filter_name']) ? $this->request->get['filter_name'] : '';
		$category_id = isset($this->request->get['category_id']) ? $this->request->get['category_id'] : '';
		
		$search_description = isset($settings['search_description']) ? $settings['search_description'] : '';
		$search_sort = isset($settings['search_sort']) ? $settings['search_sort'] : '';
		$search_order = isset($settings['search_order']) ? $settings['search_order'] : '';
		
		$currency = (VERSION >= 2.2) ? $this->session->data['currency'] : '';

		if ($search) {
			$filter_data = array(
				'filter_name'         => $search,
				'filter_tag'          => $search,
				'filter_description'  => $search_description,
				'filter_category_id'  => $category_id,
				'filter_sub_category' => 1,
				'sort'                => $search_sort,
				'order'               => $search_order,
				'start'               => 0,
				'limit'               => $settings['search_limit']
			);
				
			$results = $this->model_catalog_product->getProducts($filter_data);
			$results_total = $this->model_catalog_product->getTotalProducts($filter_data);

			foreach ($results as $result) {
				if ($result['image']) {
					$image = $this->model_tool_image->resize($result['image'], $settings['search_image_w'], $settings['search_image_h']);
				} else {
					$image = $this->model_tool_image->resize('placeholder.png', $settings['search_image_w'], $settings['search_image_h']);
				}

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
					
				$json['products'][] = array(
					'product_id'  	=> $result['product_id'],
					'image'      	=> $image,
					'name' 			=> utf8_substr(strip_tags(html_entity_decode($result['name'], ENT_QUOTES, 'UTF-8')), 0, $settings['search_name_length']) . '..',
					'description' 	=> utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $settings['search_description_length']) . '..',
					'rating'		=> $rating,
					'price'      	=> $price,
					'special'     	=> $special,
					'url'       	=> $this->url->link('product/product', 'product_id=' . $result['product_id'])
				);
			}
			
			$json['products_total'] = $results_total;
		}
		
		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
}
