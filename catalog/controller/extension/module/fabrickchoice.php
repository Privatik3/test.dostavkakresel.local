<?php
class ControllerExtensionModuleFabrickchoice extends Controller {

	public function eventCatalogProductBefore(&$route, &$data, &$output) {

		if (!$this->config->get('fabrickchoice_status')) return;
		if (!$fc_settings = $this->config->get('fabrickchoice_fc_option')) return;
		if (!isset($data['options'])) return;

		foreach ($data['options'] as $key=>$option)
		{
			if (in_array($option['option_id'], $fc_settings)){
				unset($data['options'][$key]);
				$rdata['fc_options'][] = $option;
			}
		}

		if (!isset($rdata['fc_options'])) return;

		$this->load->language('extension/module/fabrickchoice');

		$rdata['product_id'] = $product_id = $data['product_id'];
		$rdata['text_select'] = $this->language->get('text_select');

		$selected_options = array();
		$rdata['selected_options'] = array();
		if (isset($this->request->cookie['fc'])) {
			$cookie = json_decode(html_entity_decode($this->request->cookie['fc']), true);
            
			if (isset($cookie[$data['product_id']])) {
				$string = $cookie[$data['product_id']];
				parse_str($string, $selected_options);
				$selected_options = $selected_options['option'];
                /* PREFIX */
                $prefix = array();
				parse_str($string, $prefix);
				$selected_options['price_prefix'] = $prefix['prefix'];
                /* PRICE_VALUE */
                $price_value = array();
				parse_str($string, $price_value);
				$selected_options['price_value'] = $price_value['price'];
			}
            //die(json_encode($selected_options));
			foreach ($rdata['fc_options'] as $fc_option) {
				if (array_key_exists($fc_option['product_option_id'], $selected_options)) {
					$image = '';
					foreach ($fc_option['product_option_value'] as $value) {
						if ($value['product_option_value_id'] == $selected_options[$fc_option['product_option_id']]) {
							$image = $value['image'];
							if (!$image){
								$image = $this->model_tool_image->resize('no_image.png', $this->config->get('fabrickchoice_image_width'), $this->config->get('fabrickchoice_image_height'));
							}
						} 
					}
					$rdata['selected_options'][$fc_option['product_option_id']] = array(
                        /* HERE SELECTED OPTIONS !!! */
                        'price_value'       => $selected_options['price_value'],
                        'price_prefix'      => $selected_options['price_prefix'],
						'product_option_id' => $fc_option['product_option_id'],
						'product_option_value_id' => $selected_options[$fc_option['product_option_id']],
						'image' => $image
					);
				}
			}
		} else {
            /* DEFAUlT IMAGE */ //die(json_encode($rdata['fc_options']));
            foreach ($rdata['fc_options'] as $key=>$fc_option) {
                    $this->load->model('extension/module/fabrickchoice');
                    $image = $this->model_extension_module_fabrickchoice->getDefaultOptionImage($data['product_id'], $fc_option['product_option_id']);
                    if (!$image){
                        $image = $this->model_tool_image->resize('no_image.png', $this->config->get('fabrickchoice_image_width'), $this->config->get('fabrickchoice_image_height'));
                    } else {
                         $image = $this->model_tool_image->resize($image['image'], $this->config->get('fabrickchoice_image_width'), $this->config->get('fabrickchoice_image_height'));
                    }
                    $rdata['fc_options'][$key]['default_image'] = $image;
                    /* DEFAULT IMAGE */
            }
        }


		$data['fc_options'] = $this->load->view('extension/module/fabrickchoice', $rdata);

	}

	public function eventCatalogProductAfter(&$route, &$data, &$output) {

		if (isset($data['fc_options'])){
			$output = preg_replace('!'. html_entity_decode($this->config->get('fabrickchoice_tag')) .'!sim', $data['fc_options'] . '$0', $output);
		}

	}

	public function getoption() {

		if ($this->request->post['option']){

			$selected_opt = array();
			foreach ($this->request->post['option'] as $key => $opt_val) {
				if ($opt_val) {
					$selected_opt[$key]['product_option_value_id'] = $opt_val;
				}
			}

		};

		$product_id = $this->request->post['fc_product_id'];
		$option_id = $this->request->post['option_id'];

		$this->load->model('catalog/product');
		$this->load->model('extension/module/fabrickchoice');

		$this->load->language('product/product');
		$this->load->language('extension/module/fabrickchoice');

		$options = $this->model_catalog_product->getProductOptions($product_id);
		$product_info = $this->model_catalog_product->getProduct($product_id);

		$fc_option = array();

		$this->load->model('tool/image');

		foreach ($options as $option) {

			if ($option['option_id'] == $option_id) {
				$fc_option = $option;
			}

			if (array_key_exists($option['product_option_id'], $selected_opt)) {
				$product_option_id = $option['product_option_id'];

				foreach ($option['product_option_value'] as $opt_val) {

					if ($opt_val['product_option_value_id'] == $selected_opt[$product_option_id]['product_option_value_id']){


						if (is_file(DIR_IMAGE . $opt_val['image'])) {
							$image = $opt_val['image'];
						} else {
							$image = 'no_image.png';
						}

						if ((($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) && (float)$opt_val['price']) {
							$price = $this->currency->format($this->tax->calculate($opt_val['price'], $product_info['tax_class_id'], $this->config->get('config_tax') ? 'P' : FALSE), $this->session->data['currency']);
						} else {
							$price = FALSE;
						}
						$selected_opt[$product_option_id]['option_name'] = $option['name'];
						$selected_opt[$product_option_id]['option_value_id'] = $opt_val['option_value_id'];
						$selected_opt[$product_option_id]['product_option_value_id'] = $opt_val['product_option_value_id'];
						$selected_opt[$product_option_id]['image'] = $this->model_tool_image->resize($image, $this->config->get('fabrickchoice_image_width'), $this->config->get('fabrickchoice_image_height'));
						$selected_opt[$product_option_id]['thumb'] = $this->model_tool_image->resize($image, $this->config->get('fabrickchoice_thumb_width'), $this->config->get('fabrickchoice_thumb_height'));
						$selected_opt[$product_option_id]['text'] = $opt_val['name'];
						$selected_opt[$product_option_id]['price'] = $price;
                        $selected_opt[$product_option_id]['price_value'] = $opt_val['price'];
                        $selected_opt[$product_option_id]['price_prefix'] = $opt_val['price_prefix'];

					}
				}

			}
		}
		$option_values = array();
		$values = array();

		foreach ($fc_option['product_option_value'] as $value) {

//			if (!$value['subtract'] || ($value['quantity'] > 0)) {
			if (true) {
				if ((($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) && (float)$value['price']) {
					$price = $this->currency->format($this->tax->calculate($value['price'], $product_info['tax_class_id'], $this->config->get('config_tax') ? 'P' : FALSE), $this->session->data['currency']);
				} else {
					$price = FALSE;
				}


				if (is_file(DIR_IMAGE . $value['image'])) {
					$image = $value['image'];
				} else {
					$image = 'no_image.png';
				}

				$option_values[$value['option_value_id']] = array(
					'option_value_id'         => $value['option_value_id'],
					'product_option_value_id' => $value['product_option_value_id'],
//				'option_value_description' => $value['option_value_description'],
					'image'                   => $this->model_tool_image->resize($image, $this->config->get('fabrickchoice_image_width'), $this->config->get('fabrickchoice_image_height')),
					'thumb'                   => $this->model_tool_image->resize($image, $this->config->get('fabrickchoice_thumb_width'), $this->config->get('fabrickchoice_thumb_height')),
//				'sort_order'               => $value['sort_order'],
					'class'                   => '',
					'text'                    => $value['name'],
					/* nt */
                    'price'                   => !empty($price) ? ($value['price_prefix'] != '=') ? $value['price_prefix'] . $price : $price : '',
                    'price_prefix'            => $value['price_prefix'],
                    'price_value'             => $value['price'],
                    'isDefault'               => $value['default_select'] ? true : false,
					'stock'                   => ($value['quantity']) ? $this->language->get('text_stock') : $product_info['stock_status']
                    /* nt */ 
				);

				$values[] = $value['option_value_id'];
			}

		}

		$fcr = $this->model_extension_module_fabrickchoice->getOptionFcr(array('product_id' => $product_id, 'product_option_id' => $fc_option['product_option_id']));

		$fcr_cat_array = array();

		if ($fcr && isset($selected_opt)) {
			$array = array();
			foreach ($selected_opt as $key => $opt){
				if ($key != $fc_option['product_option_id']) {
					$array[] = $opt['option_value_id'];
				}
			}

			if ($array) {
				$fcr_cat = array();
				foreach ($this->model_extension_module_fabrickchoice->getCategoriesByVal($array) as $key => $cat) {

					$fcr_cat[] = $this->model_extension_module_fabrickchoice->getCategory([$cat]);
				}
				foreach ($fcr_cat as $cat) {
						$fcr_cat_array[] = $cat['category_id'];
				}

			}
		}

		$data['option_values'] = array();
		
		$categories = $this->model_extension_module_fabrickchoice->getCategoriesByVal($values);
		$all_cats = $this->model_extension_module_fabrickchoice->getAllCategoriesForTree();

		$tree = $this->build_tree_category($all_cats, 0, $categories, $option_values, '', $fcr_cat_array, $data['option_values']);

		$data['test'] = $tree;
		$data['preloader'] = 'image/preloader.svg';
		$data['preloader_height'] = $this->config->get('fabrickchoice_image_height');
		$data['preloader_width'] = $this->config->get('fabrickchoice_image_width');
        
		if ($tree) {
			$data['button'] = $this->renderButton($tree);
			/* nt */
			$data['descriptions'] = $this->renderDescription($tree);
		/* nt */
//			print_r($tree);
//			print_r($data['descriptions']);

		} else {
			$data['button'] = '';
			$data['option_values'] = $option_values;
		}
		$data['option_name'] = $fc_option['name'];
		$data['options'] = $options;
		$data['option_id'] = $fc_option['product_option_id'];
		$data['selected_opt'] = $selected_opt;

		$data['text_tax'] = $this->language->get('text_tax');
		$data['text_add'] = $this->language->get('text_add');
		$data['text_zoom'] = $this->language->get('text_zoom');
		$data['text_delete'] = $this->language->get('text_delete');
		$data['heading_title'] = $product_info['name'];
		$data['product_id'] = $product_info['product_id'];

		$this->load->model('tool/image');

		if ($product_info['image']) {
			$data['image'] = $this->model_tool_image->resize($product_info['image'], $this->config->get($this->config->get('config_theme') . '_image_thumb_width'), $this->config->get($this->config->get('config_theme') . '_image_thumb_height'));
		} else {
			$data['image'] = '';
		}

		if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
			$data['price'] = $this->currency->format($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')),$this->session->data['currency']);
		} else {
			$data['price'] = false;
		}

		if ((float)$product_info['special']) {
			$data['special'] = $this->currency->format($this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
		} else {
			$data['special'] = false;
		}

		if ($this->config->get('config_tax')) {
			$data['tax'] = $this->currency->format((float)$product_info['special'] ? $product_info['special'] : $product_info['price'], $this->session->data['currency']);
		} else {
			$data['tax'] = false;
		}

		$html = $this->load->view('extension/module/fabrickchoice_popup', $data);

		$json['success'] = true;
		$json['content'] = $html;

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	protected function build_tree_category($cats, $parent_id = 0, $val_by_category, &$option_value, $class = '', $filter_cat = array(), &$option_values){

		$this->load->model('extension/module/fabrickchoice');
		$tree = array();
		if ($parent_id == 0) {
			$class = 'cat_' . $parent_id;
		} else {
			$class .= ' cat_' . $parent_id;
		}

		if(is_array($cats) and isset($cats[$parent_id])){

			foreach($cats[$parent_id] as $cat){
				if ($filter_cat && in_array($cat['category_id'], $filter_cat)) continue;
				$tree[$cat['category_id']] =  [
					'category_id' => $cat['category_id'],
					/* nt */
					'description' => $this->model_extension_module_fabrickchoice->getCategoryDescriptions($cat['category_id'])[$this->config->get('config_language_id')]['description'],
					/* nt */
					'name' => $this->model_extension_module_fabrickchoice->getCategoryDescriptions($cat['category_id'])[$this->config->get('config_language_id')]['name'],
					'child' => $this->build_tree_category($cats, $cat['category_id'], $val_by_category, $option_value, $class, $filter_cat, $option_values),
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
						$option_value[$opt]['class'] = $class . ' cat_' . $cat['category_id'];
						$option_values[] = $option_value[$opt];
					}
				}

				if (!isset($tree[$end_key]['option_value']) && !isset($tree[$end_key]['child'])){
					unset($tree[$end_key]);
				}

			}
		}

		else {
			return null;
		}

// удаляем пустые категории верхнего уровня
		if (@isset(end($tree)['child']) && !isset($tree['option_value'])) {
			$tree = end($tree)['child'];
//			print_r($tree);
		}

		return $tree;
	}
	/* natom */
	protected function renderDescription($tree, $level = 0) {
		$html = '';

		if ($level) {
			//$html .= '<hr><div class="child_'. $level. ' cat_'.$level.'">';
		} else {
			$html .= '<div id="descriptions">';
		}

		$html_child = '';
		 
		foreach ($tree as $cat) {  

//			if($level) {
				if(!empty($cat['description'])) {
					$html .= '<div class="cat_'.$cat['category_id'].' cat_'.$level.'">'. $cat['description'] .'<hr></div>';
				} else {
					$html .= '';
				}
//			}
			if (isset($cat['child'])) {
				$html_child .= $this->renderDescription($cat['child'], $cat['category_id']);
			}
		}

		//$html .= '<div class="grid'.$level.'">';
		$html .= $html_child;
		//$html .= '</div>';

		
		if ($level) {
			//$html .= '</div>';
		} else {
			$html .= '</div>';
		}

		return $html;
	}
	/* natom */
	protected function renderButton($tree, $level = 0) {
		$html = '';

		if ($level) {
			$html .= '<hr><div class="child_'. $level. ' cat_'.$level.'">';
		}

		if (count($tree) > 1) {

			$data_filter = '';
			foreach ($tree as $node){
				$data_filter .= '.cat_'.$node['category_id'].',';
			}
			$data_filter = substr($data_filter, 0, -1);

			$html .= '<button class="all button checked " data-filter="'.$data_filter.'">'. $this->language->get('text_showall') .'</button>';
		}

		$html_child = '';

		foreach ($tree as $cat) {
			$html .= '<button data-filter=".cat_'.$cat['category_id'].'" class="' . ($level ? 'flag' : 'flag') .  ' button btn cat_'.$level.'">'. $cat['name'] .'</button>';
			if (isset($cat['child'])) {
				$html_child .= $this->renderButton($cat['child'], $cat['category_id']);
			}
		}

		$html .= '<div class="grid'.$level.'">';
		$html .= $html_child;
		$html .= '</div>';

		
		if ($level) {
			$html .= '</div>';
		}

		return $html;
	}

	public function eventCatalogSuccessBefore(){
		if (isset($this->session->data['order_id'])) {

			$order_id = $this->session->data['order_id'];
			$this->load->model('account/order');
			$products = $this->model_account_order->getOrderProducts($order_id);

			if ($products) {
				$cookie = json_decode(html_entity_decode($this->request->cookie['fc']), true);
				
				foreach ($products as $product) {
					unset($cookie[$product['product_id']]);
				}

				if ($cookie) {
					setcookie('fc', json_encode($cookie), time() + (3600 * 24 * 7), '/');
				} else {
					setcookie('fc', '', time() - (3600 * 24), '/');
				}

			}
		}
	}

	public function updatePrice(){
		$json = array();
		$options_makeup = 0;

		if (isset($this->request->post['product_id'])) {
			$product_id = (int)$this->request->post['product_id'];
		} else {
			$product_id = 0;
		}

		$this->language->load('product/product');
		$this->load->model('catalog/product');

		$product_info = $this->model_catalog_product->getProduct($product_id);

		// Prepare data
		if ($product_info) {
			if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
				$data['price'] = $product_info['price'];
			} else {
				$data['price'] = false;
			}

			if ((float)$product_info['special']) {
				$data['special'] = $product_info['special'];
			} else {
				$data['special'] = false;
			}
			if (isset($this->request->post['option']) && $this->request->post['option']) {
				foreach ($this->model_catalog_product->getProductOptions($product_id) as $option) {
					foreach ($option['product_option_value'] as $option_value) {
						//If options checkbox
						if(isset($this->request->post['option'][$option['product_option_id']]) && is_array($this->request->post['option'][$option['product_option_id']])) {
							array_filter($this->request->post['option'][$option['product_option_id']]);
							foreach($this->request->post['option'][$option['product_option_id']] as $checked_option) {
								if ($checked_option == $option_value['product_option_value_id']) {
									if (!$option_value['subtract'] || ($option_value['quantity'] > 0)) {
										if ((($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) && (float)$option_value['price']) {
											$price = $option_value['price'];
										} else {
											$price = false;
										}
										if ($price) {
											if ($option_value['price_prefix'] === '+') {
												$options_makeup = $options_makeup + (float)$price;
											} elseif ($option_value['price_prefix'] === '-') {
												$options_makeup = $options_makeup - (float)$price;
											} else {
                                                $options_makeup = (float)$price;
                                            }
										}
									}
								}
							}
						}

						//If options not checkbox
						if (isset($this->request->post['option'][$option['product_option_id']]) && $this->request->post['option'][$option['product_option_id']] == $option_value['product_option_value_id']) {

							if (!$option_value['subtract'] || ($option_value['quantity'] > 0)) {

								if ($this->config->get('fabrickchoice_status') && $this->config->get('fabrickchoice_greates') && in_array($option['option_id'], $this->config->get('fabrickchoice_fc_option'))) {
									if ((($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) && (float)$option_value['price']) {
										if ($option_value['price_prefix'] === '+') {
											$price = $option_value['price'];
										} elseif ($option_value['price_prefix'] === '-') {
											$price = -$option_value['price'];
										} elseif ($option_value['price_prefix'] === '=') {
                                            $price = $option_value['price'];
                                        }
									} else {
										$price = false;
									}
									if ($price) {
										if (!isset($options_fc)) {
											$options_fc = (float)$price;
										} else {
											$options_fc = ($options_fc > $price) ? $options_fc : $price;
										}
									}
								} else {
									if ((($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) && (float)$option_value['price']) {
										$price = $option_value['price'];
									} else {
										$price = false;
									}
									if ($price) {
										if ($option_value['price_prefix'] === '+') {
											$options_makeup = $options_makeup + (float)$price;
										} elseif ($option_value['price_prefix'] === '-')  {
											$options_makeup = $options_makeup - (float)$price;
										} else {
                                            $options_makeup = (float)$price - $data['price'];;
                                        }
									}
								}

							}
						}
					}
					unset($price);
				}
			}
			if (isset($options_fc)) {
				$options_makeup = $options_makeup + $options_fc;die($options_makeup);
				unset($options_fc);
			}
			if ($data['price']) {
				$json['new_price']['price'] = $this->currency->format($this->tax->calculate(($data['price'] + $options_makeup), $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
			} else {
				$json['new_price']['price'] = false;
			}

			if ($data['special']) {
				$json['new_price']['special'] = $this->currency->format($this->tax->calculate(($data['special'] + $options_makeup), $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
			} else {
				$json['new_price']['special'] = false;
			}

			if ($this->config->get('config_tax')) {
				$json['new_price']['tax'] = $this->currency->format(((float)$product_info['special'] ? ($product_info['special'] + $options_makeup) : ($product_info['price'] + $options_makeup)), $this->session->data['currency']);
			} else {
				$json['new_price']['tax'] = false;
			}

			$json['success'] = true;
		} else {
			$json['success'] = false;
		}

		echo json_encode($json);
	}
}