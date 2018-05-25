<?php
class ControllerUniBlogArticle extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('uni_blog/article');
		$this->load->language('product/product');

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home'),
		);
		
		$data['route'] = isset($this->request->get['route']) ? $this->request->get['route'] : ''; 
		$data['menu_schema'] = isset($settings['menu_schema']) ? $settings['menu_schema'] : array();

		$this->load->model('uni_blog/category');

		if (isset($this->request->get['blog_path'])) {
			$path = '';

			$parts = explode('_', (string)$this->request->get['blog_path']);

			$category_id = (int)array_pop($parts);

			foreach ($parts as $path_id) {
				if (!$path) {
					$path = $path_id;
				} else {
					$path .= '_' . $path_id;
				}

				$category_info = $this->model_uni_blog_category->getCategory($path_id);

				if ($category_info) {
					$data['breadcrumbs'][] = array(
						'text'      => $category_info['name'],
						'href'      => $this->url->link('uni_blog/category', 'blog_path=' . $path),
						'separator' => $this->language->get('text_separator')
					);
				}
			}
			
			$category_info = $this->model_uni_blog_category->getCategory($category_id);

			if ($category_info) {
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

				if (isset($this->request->get['limit'])) {
					$url .= '&limit=' . $this->request->get['limit'];
				}

				$data['breadcrumbs'][] = array(
					'text'      => $category_info['name'],
					'href'      => $this->url->link('uni_blog/category', 'blog_path=' . $this->request->get['blog_path'].$url),
					'separator' => $this->language->get('text_separator')
				);
			}
		}		

		if (isset($this->request->get['search']) || isset($this->request->get['tag'])) {
			$url = '';

			if (isset($this->request->get['search'])) {
				$url .= '&search=' . $this->request->get['search'];
			}

			if (isset($this->request->get['tag'])) {
				$url .= '&tag=' . $this->request->get['tag'];
			}

			if (isset($this->request->get['description'])) {
				$url .= '&description=' . $this->request->get['description'];
			}

			if (isset($this->request->get['category_id'])) {
				$url .= '&category_id=' . $this->request->get['category_id'];
			}

			if (isset($this->request->get['sub_category'])) {
				$url .= '&sub_category=' . $this->request->get['sub_category'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$data['breadcrumbs'][] = array(
				'text'      => $this->language->get('text_search'),
				'href'      => $this->url->link('uni_blog/search', $url),
				'separator' => $this->language->get('text_separator')
			);
		}

		$article_id = isset($this->request->get['article_id']) ? (int)$this->request->get['article_id'] : 0;

		$this->load->model('uni_blog/article');

		$article_info = $this->model_uni_blog_article->getArticle($article_id);

		if ($article_info) {
			$url = '';

			if (isset($this->request->get['blog_path'])) {
				$url .= '&blog_path=' . $this->request->get['blog_path'];
			}

			if (isset($this->request->get['filter'])) {
				$url .= '&filter=' . $this->request->get['filter'];
			}

			if (isset($this->request->get['manufacturer_id'])) {
				$url .= '&manufacturer_id=' . $this->request->get['manufacturer_id'];
			}

			if (isset($this->request->get['search'])) {
				$url .= '&search=' . $this->request->get['search'];
			}

			if (isset($this->request->get['tag'])) {
				$url .= '&tag=' . $this->request->get['tag'];
			}

			if (isset($this->request->get['description'])) {
				$url .= '&description=' . $this->request->get['description'];
			}

			if (isset($this->request->get['category_id'])) {
				$url .= '&category_id=' . $this->request->get['category_id'];
			}

			if (isset($this->request->get['sub_category'])) {
				$url .= '&sub_category=' . $this->request->get['sub_category'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$data['breadcrumbs'][] = array(
				'text'      => $article_info['name'],
				'href'      => $this->url->link('uni_blog/article', $url . '&article_id=' . $this->request->get['article_id']),
				'separator' => $this->language->get('text_separator')
			);			

			
			if ($article_info['meta_title']) {
				$this->document->setTitle($article_info['meta_title']);
			} else {
				$this->document->setTitle($article_info['name']);
			}
			
			$this->document->setDescription($article_info['meta_description']);
			$this->document->setKeywords($article_info['meta_keyword']);
			$this->document->addLink($this->url->link('uni_blog/article', 'article_id=' . $this->request->get['article_id']), 'canonical');
			$this->document->addScript('catalog/view/javascript/jquery/magnific/jquery.magnific-popup.min.js');
			$this->document->addStyle('catalog/view/javascript/jquery/magnific/magnific-popup.css');
			
			$this->document->addStyle('catalog/view/theme/unishop/stylesheet/blog.css');

			$data['heading_title'] = $article_info['meta_h1'] ? $article_info['meta_h1'] : $article_info['name'];

			$data['text_related'] = $this->language->get('text_related');
			$data['text_review'] = $this->language->get('text_review');
			$data['text_on'] = $this->language->get('text_on');
			$data['text_write'] = $this->language->get('text_write');
			$data['text_write_send'] = $this->language->get('text_write_send');
			$data['text_note'] = $this->language->get('text_note');
			$data['text_wait'] = $this->language->get('text_wait');
			$data['text_share'] = $this->language->get('text_share');
			$data['text_tags'] = $this->language->get('text_tags');
			$data['text_tax'] = $this->language->get('text_tax');
			$data['text_date_added'] = $this->language->get('text_date_added');
			$data['text_date_modified'] = $this->language->get('text_date_modified');
			$data['text_viewed'] = $this->language->get('text_viewed');
			$data['text_author'] = $this->language->get('text_author');
			$data['text_loading'] = $this->language->get('text_loading');
			$data['text_login'] = sprintf($this->language->get('text_login'), $this->url->link('account/login', '', 'SSL'), $this->url->link('account/register', '', 'SSL'));

			$data['entry_name'] = $this->language->get('entry_name');
			$data['entry_review'] = $this->language->get('entry_review');
			$data['entry_rating'] = $this->language->get('entry_rating');
			$data['entry_good'] = $this->language->get('entry_good');
			$data['entry_bad'] = $this->language->get('entry_bad');
			$data['entry_captcha'] = $this->language->get('entry_captcha');

			$data['button_continue'] = $this->language->get('button_continue');

			$this->load->model('catalog/review');

			$data['tab_description'] = $this->language->get('tab_description');
			$data['tab_review'] = sprintf($this->language->get('tab_review'), $article_info['reviews']);
			$data['tab_related'] = $this->language->get('tab_related');

			$data['article_id'] = $this->request->get['article_id'];
			
			$this->load->model('tool/image');

			$data['thumb'] = $article_info['image'] ? $this->model_tool_image->resize($article_info['image'], $this->config->get('blog_image_thumb_width'), $this->config->get('blog_image_thumb_height')) : '';
			$data['popup'] = $article_info['image'] ? HTTPS_SERVER.'image/'.$article_info['image'] : '';

			$data['review_guest'] = $this->config->get('config_review_guest') || $this->customer->isLogged() ? true : false;

			if ($this->config->get('config_google_captcha_status')) {
				$this->document->addScript('https://www.google.com/recaptcha/api.js');
				$data['site_key'] = $this->config->get('config_google_captcha_public');
			} else {
				$data['site_key'] = '';
			}

			$data['review_status'] = $this->config->get('blog_review_status');
			$data['reviews'] = $article_info['reviews'];
			$data['rating'] = (int)$article_info['rating'];
			$data['description'] = html_entity_decode($article_info['description'], ENT_QUOTES, 'UTF-8');
			$data['short_description'] = html_entity_decode($article_info['short_description'], ENT_QUOTES, 'UTF-8');
			$data['date_added'] = date($this->language->get('date_format_short'), strtotime($article_info['date_added']));
			$data['date_added2'] = date('Y-m-d', strtotime($article_info['date_added']));
			$data['date_modified'] = date($this->language->get('date_format_short'), strtotime($article_info['date_modified']));
			$data['viewed'] = $article_info['viewed'];	
			$data['author'] = $article_info['author'];				

			$data['show_viewed'] = $this->config->get('blog_show_viewed');
			$data['show_date_added'] = $this->config->get('blog_show_date_added');
			$data['show_author'] = $this->config->get('blog_show_author');
			
			if ($this->config->get($this->config->get('config_captcha') . '_status') && in_array('review', (array)$this->config->get('config_captcha_page'))) {
				$data['captcha'] = $this->load->controller('captcha/' . $this->config->get('config_captcha'));
			} else {
				$data['captcha'] = '';
			}

			$data['articles'] = array();
			$results = $this->model_uni_blog_article->getArticleRelated($this->request->get['article_id']);
			
			if ($results) {
				foreach ($results as $result) {
					if ($this->config->get('config_review_status')) {
						$rating = (int)$result['rating'];
					} else {
						$rating = false;
					}
					
					if($result['short_description']) {
						$description = utf8_substr(strip_tags(html_entity_decode($result['short_description'], ENT_QUOTES, 'UTF-8')), 0, 120) . '..';
					} else {
						$description = utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, 120) . '..';
					}

					$data['articles'][] = array(
						'article_id' 		=> $result['article_id'],
						'thumb'   	 		=> $this->model_tool_image->resize($result['image'], $this->config->get('blog_image_related_width'), $this->config->get('blog_image_related_height')),
						'name'    			 => $result['name'],
						'short_description' => $description,
						'rating'    		 => $rating,
						'reviews'   		 => sprintf($this->language->get('text_reviews'), (int)$result['reviews']),
						'href'    			 => $this->url->link('uni_blog/article', 'article_id=' . $result['article_id'])
					);
				}
			}
			
			$this->language->load('product/product');
			$data['button_cart'] = $this->language->get('button_cart');
			$data['button_wishlist'] = $this->language->get('button_wishlist');
			$data['button_compare'] = $this->language->get('button_compare');
			$data['button_cart_disabled'] = $this->language->get('button_cart_disabled');
			
			$data['module_id'] = rand();
			$data['text_select'] = $this->language->get('text_select');
		
			$this->load->model('unishop/setting');
			$settings = $this->model_unishop_setting->getSetting();
			$language_id = $this->config->get('config_language_id');
		
			$data['show_quick_order'] = (isset($settings['show_quick_order']) ? $settings['show_quick_order'] : '');
			$data['show_quick_order_text'] = isset($settings['show_quick_order_text']) ? $settings['show_quick_order_text'] : '';			
			$data['quick_order_icon'] = (isset($settings['show_quick_order']) ? html_entity_decode($settings[$language_id]['quick_order_icon'], ENT_QUOTES, 'UTF-8') : '');	
			$data['quick_order_title'] = (isset($settings['show_quick_order']) ? $settings[$language_id]['quick_order_title'] : '');
			$data['show_quick_order_quantity'] = isset($settings['show_quick_order_quantity']) ? $settings['show_quick_order_quantity'] : '';
			
			$currency = (VERSION >= 2.2) ? $this->session->data['currency'] : '';
			
			$data['products'] = array();
			
			$this->load->model('catalog/product');
			$results = $this->model_uni_blog_article->getProductsRelated($this->request->get['article_id']);
			
			if ($results) {
				$data['title_related'] = $this->language->get('title_related');
			
				foreach ($results as $result) {
					if (VERSION >= 2.2) {
						if ($result['image']) {
							$image = $this->model_tool_image->resize($result['image'], $this->config->get($this->config->get('config_theme') . '_image_related_width'), $this->config->get($this->config->get('config_theme') . '_image_related_height'));
						} else {
							$image = $this->model_tool_image->resize('placeholder.png', $this->config->get($this->config->get('config_theme') . '_image_related_width'), $this->config->get($this->config->get('config_theme') . '_image_related_height'));
						}
					} else {
						if ($result['image']) {
							$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_related_width'), $this->config->get('config_image_related_height'));
						} else {
							$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_related_width'), $this->config->get('config_image_related_height'));
						}
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
				
					if ($this->config->get('config_review_status')) {
						$rating = (int)$result['rating'];
					} else {
						$rating = false;
					}
			
					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price'], $currency);
					} else {
						$tax = false;
					}
			
					$data['show_description'] = '';
					if (isset($settings['show_description'])) {
						$data['show_description'] = $settings['show_description'];
					}
			
					$data['show_description_alt'] = '';
					if (isset($settings['show_description_alt'])) {
						$data['show_description_alt'] = $settings['show_description_alt'];
					}
					
					$data['show_rating'] = '';
					if (isset($settings['show_rating'])) {
						$data['show_rating'] = $settings['show_rating'];
					}
			
					$data['show_rating_count'] = '';
					if (isset($settings['show_rating_count'])) {
						$data['show_rating_count'] = $settings['show_rating_count'];
					}
			
					$data['show_attr_group'] = $settings['show_attr_group'];
					$data['show_attr_item'] = $settings['show_attr_item'];
			
					$data['show_attr'] = '';
					$attribute_groups = '';
					if (isset($settings['show_attr'])) {
						$data['show_attr'] = $settings['show_attr'];
						$attribute_groups = $this->model_catalog_product->getProductAttributes($result['product_id']);
					}
			
					$data['show_attr_name'] = '';
					if (isset($settings['show_attr_name'])) {
						$data['show_attr_name'] = $settings['show_attr_name'];
					}
			
					$data['option_image_checkbox'] = '';
					if (isset($settings['option_image_checkbox'])) {
						$data['option_image_checkbox'] = $settings['option_image_checkbox'];
					}
			
					$data['show_options'] = '';
					$options = array();
					if (isset($settings['show_options'])) {
						$data['show_options'] = $settings['show_options'];
						$data['show_options_item'] = $settings['show_options_item'];

					foreach ($this->model_catalog_product->getProductOptions($result['product_id']) as $option) {
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
									'image'                   => $this->model_tool_image->resize($option_value['image'], 50, 50),
									'price'                   => $option_price,
									'price_prefix'            => $option_value['price_prefix']
								);
							}
						}
						if(isset($settings['show_options_req'])) {
							if($option['required']) {
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
						} else {
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
			
					$additional_image = '';
			
					if(isset($settings['show_additional_image'])) {
						$results_img = $this->model_catalog_product->getProductImages($result['product_id']);
						foreach ($results_img as $key => $result_img) {
							if ($key < 1) {
								if (VERSION >= 2.2) {
									$additional_image = $this->model_tool_image->resize($result_img['image'], $this->config->get($this->config->get('config_theme') . '_image_product_width'), $this->config->get($this->config->get('config_theme') . '_image_product_height'));
								} else {
									$additional_image = $this->model_tool_image->resize($result_img['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
								}
							}
						}
					}
			
					$weight = $result['weight'] > 0 ? $this->weight->format($result['weight'], $result['weight_class_id'], $this->language->get('decimal_point'), $this->language->get('thousand_point')) : '';
					
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
			
					$cart_btn_class = $result['quantity'] <= 0 ? ' disabled' : '';
					$cart_btn_class .= $result['quantity'] <= 0 && isset($settings['cart_btn_disabled']) ? ' disabled2' : '';
							
					$data['products'][] = array(
						'product_id' 				=> $result['product_id'],
						'thumb'   	 				=> $image,
						'additional_image'			=> $additional_image,
						'name'    					=> $result['name'],
						'description' 				=> utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
						'weight'					=> $weight,
						'tax'         				=> $tax,
						'quantity' 					=> $result['quantity'],
						'minimum' 					=> $result['minimum'],
						'stock_status' 				=> isset($settings['show_stock_status']) ? $result['stock_status'] : '',
						'stock_status_id' 			=> isset($settings['show_stock_status']) ? $result['stock_status_id'] : '',
						'num_reviews' 				=> $result['reviews'] ? $result['reviews'] : '',
						'stickers'					=> $stickers,
						'price_value' 				=> $this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax'))*$this->currency->getValue($currency),
						'special_value' 			=> $this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax'))*$this->currency->getValue($currency),
						'attribute_groups' 			=> $attribute_groups,
						'options'					=> $options,
						'weight_value'				=> $result['weight'],
						'weight_unit' 				=> $this->weight->getUnit($result['weight_class_id']),
						'cart_btn_disabled' 		=> $result['quantity'] <= 0 && isset($settings['cart_btn_disabled']) ? $settings['cart_btn_disabled'] : '',
						'cart_btn_icon_mobile' 		=> $result['quantity'] <= 0 && isset($settings['cart_btn_icon_disabled_mobile']) ? $settings['cart_btn_icon_disabled_mobile'] : '',
						'cart_btn_icon' 			=> $result['quantity'] > 0 ? $settings[$language_id]['cart_btn_icon'] : $settings[$language_id]['cart_btn_icon_disabled'],
						'cart_btn_text' 			=> $result['quantity'] > 0 ? $settings[$language_id]['cart_btn_text'] : $settings[$language_id]['cart_btn_text_disabled'],
						'cart_btn_class' 			=> $cart_btn_class,
						'price'   	 				=> $price,
						'special' 	 				=> $special,
						'rating'     				=> $rating,
						'reviews'    				=> sprintf($this->language->get('text_reviews'), (int)$result['reviews']),
						'href'    	 				=> $this->url->link('product/product', 'product_id=' . $result['product_id']),
					);
				}
			}

			$data['tags'] = array();

			if ($article_info['tag']) {
				$tags = explode(',', $article_info['tag']);

				foreach ($tags as $tag) {
					$data['tags'][] = array(
						'tag'  => trim($tag),
						'href' => $this->url->link('uni_blog/search', 'tag=' . trim($tag))
					);
				}
			}

			$this->model_uni_blog_article->updateViewed($this->request->get['article_id']);

			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');
			
			if (VERSION >= 2.2) {
				$this->response->setOutput($this->load->view('uni_blog/article', $data));
			} else {
				$this->response->setOutput($this->load->view('unishop/template/uni_blog/article.tpl', $data));
			}
		} else {
			$url = '';

			if (isset($this->request->get['blog_path'])) {
				$url .= '&blog_path=' . $this->request->get['blog_path'];
			}

			if (isset($this->request->get['filter'])) {
				$url .= '&filter=' . $this->request->get['filter'];
			}

			if (isset($this->request->get['manufacturer_id'])) {
				$url .= '&manufacturer_id=' . $this->request->get['manufacturer_id'];
			}

			if (isset($this->request->get['search'])) {
				$url .= '&search=' . $this->request->get['search'];
			}

			if (isset($this->request->get['tag'])) {
				$url .= '&tag=' . $this->request->get['tag'];
			}

			if (isset($this->request->get['description'])) {
				$url .= '&description=' . $this->request->get['description'];
			}

			if (isset($this->request->get['category_id'])) {
				$url .= '&category_id=' . $this->request->get['category_id'];
			}

			if (isset($this->request->get['sub_category'])) {
				$url .= '&sub_category=' . $this->request->get['sub_category'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$data['breadcrumbs'][] = array(
				'text'      => $this->language->get('text_error'),
				'href'      => $this->url->link('uni_blog/article', $url . '&article_id=' . $article_id),
			);

			$this->document->setTitle($this->language->get('text_error'));

			$data['heading_title'] = $this->language->get('text_error');

			$data['text_error'] = $this->language->get('text_error');

			$data['button_continue'] = $this->language->get('button_continue');

			$data['continue'] = $this->url->link('common/home');

			$this->response->addHeader($this->request->server['SERVER_PROTOCOL'] . '/1.1 404 Not Found');

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

	public function review() {
		$this->load->language('uni_blog/article');

		$this->load->model('uni_blog/review');

		$data['text_no_reviews'] = $this->language->get('text_no_reviews');
		$data['text_admin_reply'] = $this->language->get('text_admin_reply');

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}
		
		$article_id = isset($this->request->get['article_id']) ? $this->request->get['article_id'] : $this->request->get['art_id'];

		$data['reviews'] = array();

		$review_total = $this->model_uni_blog_review->getTotalReviewsByArticleId($article_id);

		$results = $this->model_uni_blog_review->getReviewsByArticleId($article_id, ($page - 1) * 5, 5);

		foreach ($results as $result) {
			$data['reviews'][] = array(
				'author'    	 => $result['author'],
				'text'       	=> nl2br($result['text']),
				'admin_reply'	=> nl2br($result['admin_reply']),
				'rating'     	=> (int)$result['rating'],
				'date_added' 	=> date($this->language->get('date_format_short'), strtotime($result['date_added']))
			);
		}

		$pagination = new Pagination();
		$pagination->total = $review_total;
		$pagination->page = $page;
		$pagination->limit = 5;
		$pagination->url = $this->url->link('uni_blog/article/review', 'art_id=' . $article_id . '&page={page}');

		$data['pagination'] = $pagination->render();

		$data['results'] = sprintf($this->language->get('text_pagination'), ($review_total) ? (($page - 1) * 5) + 1 : 0, ((($page - 1) * 5) > ($review_total - 5)) ? $review_total : ((($page - 1) * 5) + 5), $review_total, ceil($review_total / 5));
		
		if (VERSION >= 2.2) {
			$this->response->setOutput($this->load->view('uni_blog/review', $data));
		} else {
			$this->response->setOutput($this->load->view('unishop/template/uni_blog/review.tpl', $data));
		}
	}

	public function write() {
		$this->load->language('uni_blog/article');

		$json = array();

		if ($this->request->server['REQUEST_METHOD'] == 'POST') {
			if ((utf8_strlen($this->request->post['name']) < 3) || (utf8_strlen($this->request->post['name']) > 25)) {
				$json['error'] = $this->language->get('error_name');
			}

			if ((utf8_strlen($this->request->post['text']) < 25) || (utf8_strlen($this->request->post['text']) > 1000)) {
				$json['error'] = $this->language->get('error_text');
			}

			if (empty($this->request->post['rating']) || $this->request->post['rating'] < 0 || $this->request->post['rating'] > 5) {
				$json['error'] = $this->language->get('error_rating');
			}

			if ($this->config->get($this->config->get('config_captcha') . '_status') && in_array('review', (array)$this->config->get('config_captcha_page'))) {
				$captcha = $this->load->controller('captcha/' . $this->config->get('config_captcha') . '/validate');

				if ($captcha) {
					$json['error'] = $captcha;
				}
			}

			if (!isset($json['error'])) {
				$this->load->model('uni_blog/review');

				$this->model_uni_blog_review->addReview($this->request->get['article_id'], $this->request->post);

				$json['success'] = $this->language->get('text_success');
			}
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
}
?>