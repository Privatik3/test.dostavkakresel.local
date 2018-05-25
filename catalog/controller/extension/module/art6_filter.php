<?
class ControllerExtensionModuleArt6Filter extends Controller {
	public function index() {
		if (isset($this->request->get['path'])) {
			$parts = explode('_', (string)$this->request->get['path']);
		} else {
			$parts = array();
		}

		$category_id = end($parts);

		$this->load->model('catalog/category');

		$category_info = $this->model_catalog_category->getCategory($category_id);

		if ($category_info) {
			$this->load->language('extension/module/art6_filter');
			
			$data['heading_title'] = $this->language->get('heading_title');
			$data['button_filter'] = $this->language->get('button_filter');
			$data['button_clear'] = $this->language->get('button_clear');
			
			$this->document->addStyle('catalog/view/theme/default/stylesheet/art6.filter.css');
			$this->document->addScript('catalog/view/javascript/art6.filter.js');

			$url = '';

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$data['clear'] = str_replace('&amp;', '&', $this->url->link('product/category', 'path=' . $this->request->get['path'] . $url));

			if (isset($this->request->get['set_filter'])) {
				$url .= '&set_filter=' . $this->request->get['set_filter'];

				foreach ($this->request->get as $key => $value) {
					$arKey = explode("_", $key);

					if ($arKey[0] == "arFilter") {
						$url .= '&' . $key . '=' . $this->request->get[$key];
					}
				}
			}

			$data['action'] = str_replace('&amp;', '&', $this->url->link('product/category/filter', 'path=' . $this->request->get['path'] . $url));

			$this->load->model('catalog/product');
			
			$results = $this->model_catalog_product->getProducts(array('filter_category_id' => $category_id));

			if (empty($results)) {
				$data['arFilters'] = "";

				return $this->load->view('extension/module/art6_filter', $data);
			}

			$this->load->model('extension/module/art6_filter');

			$attribute_groups = array();
			$prices = array();
			$arFilter = array();
			$arAttributes = array();
			$arOptions = array();

			foreach ($results as $result) {
				$arAttribute = $this->model_extension_module_art6_filter->getFilterAttributes($result['product_id']);
				$arOption = $this->model_extension_module_art6_filter->getFilterOptions($result['product_id']);
				
				$prices[] = (int)($result['special'] ? $result['special'] : $result['price']);
				
				if ($arAttribute)
					foreach ($arAttribute as $attribute)
						$arAttributes[] = $attribute;

				if ($arOption)
					foreach ($arOption as $ptions)
						$arOptions[] = $ptions;
			}
			
			if (count($prices) > 2) {
				$arFilter[] = array(
					'attribute_group_id'	=> "999",
					'attribute_id'			=> "999",
					'name'					=> $this->language->get('text_price'),
					'text'					=> $prices,
					'view'					=> "S"
				);
			}
			if($arAttributes) {
				$bad = 1;
				foreach($arAttributes as $attribute) {
					$attr_id = $attribute['attribute_id'];
					$attr_text = $attribute['text'];
					$bad_group = 0;
					foreach($arFilter as $key => $filter) {
						if ($attr_id == $filter['attribute_id']) {
							$bad_group = 1;
							foreach($attr_text as $num => $text) {
								$bad_text = 0;
								foreach($filter['text'] as $key_val => $val) {
									if (mb_strtolower($text) == mb_strtolower($val)) {
										if (!empty($attribute['color'][0])) $arFilter[$key]['color'][$key_val] = $attribute['color'][0];
										$bad_text = 1;
									}
								}
								if($bad_text) continue;
								$arFilter[$key]['text'][] = $attribute['text'][$num];
								$arFilter[$key]['color'][] = $attribute['color'][0];
							}
							if ($attribute['view'] != "Col") sort($arFilter[$key]['text']);
						}
					}
					if (!$bad_group) $arFilter[] = $attribute;
				}
			}
			if($arOptions) {
				$bad = 1;
				foreach($arOptions as $option) {
					$opt_gr_id = $option['option_group_id'];
					$opt_value = $option['option_value'];
					$bad_group = 0;
					foreach($arFilter as $key => $filter) {
						if (isset($filter['option_group_id']) && $opt_gr_id == $filter['option_group_id']) {
							$bad_group = 1;
							foreach($opt_value as $value) {
								$bad_text = 0;
								$opt_id = $value['option_id'];
								$text = $value['text'];
								if(!$bad_text) $arFilter[$key]['text'][$opt_id] = $text;
							}
							asort($arFilter[$key]['text']);
						}
					}
					if (!$bad_group) {
						unset($option["option_value"]);
						$arFilter[] = $option;
					}
				}
			}
			
			foreach ($arFilter as $num => $filter) {
				if (isset($filter['attribute_id'])) {
					if ($filter['view'] != "S")
						foreach ($filter['text'] as $key => $text) {
							if (isset($this->request->get['arFilter_C_' . $filter['attribute_id'] .'_'. $key]))
								$arFilter[$num]['active'][$key] = " art6-filter__form-box__params-item--active";
							else $arFilter[$num]['active'][$key] = "";
						}
					else {
						$slider = $this->sliderGenerate($filter['text']);
					
						if (!$slider && $filter['view'] == "S") {
							$arFilter[$num]['view'] = "C";
							foreach ($filter['text'] as $key => $text) {
								if (isset($this->request->get['arFilter_C_' . $filter['attribute_id'] .'_'. $key]))
									$arFilter[$num]['active'][$key] = " art6-filter__form-box__params-item--active";
								else $arFilter[$num]['active'][$key] = "";
							}
						}
						$arFilter[$num]['text'] = (!$slider ? $filter['text'] : $slider);
					}
				} elseif(isset($filter['option_group_id'])) {
					foreach ($filter['text'] as $key => $text) {
						if (isset($this->request->get['arFilter_O_' . $filter['option_group_id'] .'_'. $key]))
							$arFilter[$num]['active'][$key] = " art6-filter__form-box__params-item--active";
						else $arFilter[$num]['active'][$key] = "";
					}
				}
			}
			
			$data['arFilters'] = $arFilter;

			return $this->load->view('extension/module/art6_filter', $data);
		}	
	}

	protected function sliderGenerate ($arNums) {
		$bad = 0;
		foreach ($arNums as $num) {
			$num_result = preg_replace("/\s/", "", $num);
			$num_result = preg_replace("/\./", "", $num_result);
			$num_result = preg_replace("/\,/", "", $num_result);
			$num_type = (preg_match("/\D/", $num_result) ? 0 : 1);
			if (!$num_type) {
				$bad = 1;
				break;
			}
		}
		if ($bad) return;
		
		sort($arNums);

		$nums_round = array(
			$arNums[0],
			$arNums[0] + ($arNums[count($arNums) - 1] - $arNums[0]) / 4,
			$arNums[0] + (($arNums[count($arNums) - 1] - $arNums[0]) / 4) * 2,
			$arNums[0] + (($arNums[count($arNums) - 1] - $arNums[0]) / 4) * 3,
			$arNums[0] + (($arNums[count($arNums) - 1] - $arNums[0]) / 4) * 4
		);

		$arSlider = array(
			'min'	=> $arNums[0],
			'max'	=> $arNums[count($arNums) - 1],
			'round'	=> $nums_round
		);

		return $arSlider;
	}
}
?>