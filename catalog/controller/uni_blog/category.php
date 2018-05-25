<?php class ControllerUniBlogCategory extends Controller {
	public function index() {
		$data['route'] = isset($this->request->get['route']) ? $this->request->get['route'] : ''; 
		$data['menu_schema'] = isset($settings['menu_schema']) ? $settings['menu_schema'] : array();
	
		$this->load->language('uni_blog/category');
		
		$this->load->model('uni_blog/category');
		$this->load->model('uni_blog/article');
		$this->load->model('tool/image');
			
		if (isset($this->request->get['filter'])) {
			$filter = $this->request->get['filter'];
		} else {
			$filter = '';
		}
			
		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'p.date_added';
		}
			
		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
		} else {
			$order = 'DESC';
		}
			
		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}
			
		if (isset($this->request->get['limit'])) {
			$limit = $this->request->get['limit'];
		} else {
			$limit = $this->config->get('blog_catalog_limit');
		}
			
		$data['breadcrumbs'] = array();
			
		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);
			
		if (isset($this->request->get['blog_path'])) {
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
				
			$path = '';
				
			$parts = explode('_', (string)$this->request->get['blog_path']);
				
			$category_id = (int)array_pop($parts);
				
			foreach ($parts as $path_id) {
				if (!$path) {
					$path = (int)$path_id;
				} else {
					$path .= '_' . (int)$path_id;
				}
					
				$category_info = $this->model_uni_blog_category->getCategory($path_id);
					
				if ($category_info) {
					$data['breadcrumbs'][] = array(
						'text' => $category_info['name'],
						'href' => $this->url->link('uni_blog/category', 'blog_path=' . $path . $url)
					);
				}
			}
		} else {
			$category_id = 0;
		}
			
		$category_info = $this->model_uni_blog_category->getCategory($category_id);	
			
		if ($category_info) {
				
			if ($category_info['meta_title']) {
				$this->document->setTitle($category_info['meta_title']);
			} else {
				$this->document->setTitle($category_info['name']);
			}
				
			$this->document->setDescription($category_info['meta_description']);
			$this->document->setKeywords($category_info['meta_keyword']);
				
			$data['heading_title'] = $category_info['meta_h1'] ? $category_info['meta_h1'] : $category_info['name'];
				
			$this->document->addStyle('catalog/view/theme/unishop/stylesheet/blog.css');
				
			$data['text_refine'] = $this->language->get('text_refine');
			$data['text_empty'] = $this->language->get('text_empty');
			$data['text_compare'] = sprintf($this->language->get('text_compare'), (isset($this->session->data['compare']) ? count($this->session->data['compare']) : 0));
			$data['text_sort'] = $this->language->get('text_sort');
			$data['text_limit'] = $this->language->get('text_limit');
			$data['text_more'] = $this->language->get('text_more');
				
			$data['text_review'] = $this->language->get('text_review');
			$data['text_date_added'] = $this->language->get('text_date_added');
			$data['text_viewed'] = $this->language->get('text_viewed');
			$data['text_author'] = $this->language->get('text_author');
				
			$data['button_continue'] = $this->language->get('button_continue');
			$data['button_list'] = $this->language->get('button_list');
			$data['button_grid'] = $this->language->get('button_grid');
				
			$data['breadcrumbs'][] = array(
				'text' => $category_info['name'],
				'href' => $this->url->link('uni_blog/category', 'blog_path=' . $this->request->get['blog_path'])
			);
				
			$data['thumb'] = $category_info['image'] ? $this->model_tool_image->resize($category_info['image'], $this->config->get('blog_image_category_width'), $this->config->get('blog_image_category_height')) : '';
			$data['description'] = html_entity_decode($category_info['description'], ENT_QUOTES, 'UTF-8');
			$data['short_description'] = html_entity_decode($category_info['short_description'], ENT_QUOTES, 'UTF-8');
				
			$url = '';
				
			if (isset($this->request->get['filter'])) {
				$url .= '&filter=' . $this->request->get['filter'];
			}
				
			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}
				
			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}
				
			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}
				
			$data['categories'] = array();
				
			$results = $this->model_uni_blog_category->getCategories($category_id);
				
			$i=1;
				
			foreach ($results as $result) {
				$filter_data = array(
					'filter_category_id'  => $result['category_id'],
					'filter_sub_category' => true
				);
					
				if ($result['image']) {
					$image = $this->model_tool_image->resize($result['image'], $this->config->get('blog_image_category_width'), $this->config->get('blog_image_category_height'));
				} else {
					$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('blog_image_category_width'), $this->config->get('blog_image_category_height'));
				}
					
				if (( isset($result['short_description']) && $result['short_description']) !='') {
					$description = utf8_substr(strip_tags(html_entity_decode($result['short_description'], ENT_QUOTES, 'UTF-8')), 0, 150) . '..';
				} else {
					$description = utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, 150) . '..';
				}
					
				$data['categories'][] = array(
					'thumb' => $image,
					'description' => $description,
					'name'  => $result['name'] . ($this->config->get('config_article_count') ? ' (' . $this->model_uni_blog_article->getTotalArticles($filter_data) . ')' : ''),
					'href'  => $this->url->link('uni_blog/category', 'blog_path=' . $this->request->get['blog_path'] . '_' . $result['category_id'] . $url)
				);
			}		

			$data['show_viewed'] = $this->config->get('blog_show_viewed');
			$data['show_date_added'] = $this->config->get('blog_show_date_added');
			$data['show_date_modified'] = $this->config->get('blog_show_date_modified');
			$data['show_author'] = $this->config->get('blog_show_author');
			$data['review_status'] = $this->config->get('blog_review_status');
				
			$data['articles'] = array();
				
			$filter_data = array(
				'filter_category_id' => $category_id,
				'filter_filter'      => $filter,
				'sort'               => 'p.date_added',
				'order'              => 'DESC',
				'start'              => ($page - 1) * $limit,
				'limit'              => $limit
			);
				
			$article_total = $this->model_uni_blog_article->getTotalArticlesByCategory($category_id);
				
			$results = $this->model_uni_blog_article->getArticles($filter_data);
				
			foreach ($results as $result) {
				if ($result['image']) {
					$image = $this->model_tool_image->resize($result['image'], $this->config->get('blog_image_article_width'), $this->config->get('blog_image_article_height'));
				} else {
					$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('blog_image_article_width'), $this->config->get('blog_image_article_height'));
				}
					
				if ($this->config->get('blog_review_status')) {
					$rating = (int)$result['rating'];
				} else {
					$rating = false;
				}
					
				if($result['short_description']) {
					$description = strip_tags(html_entity_decode($result['short_description'], ENT_QUOTES, 'UTF-8'));
				} else {
					$description = utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, 280) . '..';
				}
					
				$data['articles'][] = array(
					'article_id'  	=> $result['article_id'],
					'thumb'       	=> $image,
					'name'        	=> $result['name'],
					'description' 	=> $description,
					'rating'      	=> $result['rating'],
					'author'        => $result['author'],
					'reviews'       => $result['reviews'],
					'date_added'	=> date($this->language->get('date_format_short'), strtotime($result['date_added'])),
					'viewed'		=> $result['viewed'],
					'href'        	=> $this->url->link('uni_blog/article', 'blog_path=' . $this->request->get['blog_path'] . '&article_id=' . $result['article_id'] . $url)
				);
			}
				
			$url = '';
				
			if (isset($this->request->get['filter'])) {
				$url .= '&filter=' . $this->request->get['filter'];
			}
				
			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}
				
			$data['sorts'] = array();
				
			$url = '';
				
			if (isset($this->request->get['filter'])) {
				$url .= '&filter=' . $this->request->get['filter'];
			}
				
			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}
				
			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}
				
			$data['limits'] = array();
				
			$limits = array_unique(array($this->config->get('blog_catalog_limit'), 5, 15, 25, 50));
				
			sort($limits);
				
			foreach($limits as $value) {
				$data['limits'][] = array(
					'text'  => $value,
					'value' => $value,
					'href'  => $this->url->link('uni_blog/category', 'blog_path=' . $this->request->get['blog_path'] . $url . '&limit=' . $value)
				);
			}
				
			$url = '';
				
			if (isset($this->request->get['filter'])) {
				$url .= '&filter=' . $this->request->get['filter'];
			}
				
			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}
				
			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}
				
			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}
				
			$pagination = new Pagination();
			$pagination->total = $article_total;
			$pagination->page = $page;
			$pagination->limit = $limit;
			$pagination->url = $this->url->link('uni_blog/category', 'blog_path=' . $this->request->get['blog_path'] . $url . '&page={page}');
				
			$data['pagination'] = $pagination->render();
				
			$data['results'] = sprintf($this->language->get('text_pagination'), ($article_total) ? (($page - 1) * $limit) + 1 : 0, ((($page - 1) * $limit) > ($article_total - $limit)) ? $article_total : ((($page - 1) * $limit) + $limit), $article_total, ceil($article_total / $limit));
				
			$data['sort'] = $sort;
			$data['order'] = $order;
			$data['limit'] = $limit;
				
			$data['continue'] = $this->url->link('common/home');
				
			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');
				
			if (VERSION >= 2.2) {
				$this->response->setOutput($this->load->view('uni_blog/category', $data));
			} else {
				$this->response->setOutput($this->load->view('unishop/template/uni_blog/category.tpl', $data));
			}
		} else {
			$url = '';
				
			if (isset($this->request->get['blog_path'])) {
				$url .= '&blog_path=' . $this->request->get['blog_path'];
			}
				
			if (isset($this->request->get['filter'])) {
				$url .= '&filter=' . $this->request->get['filter'];
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
				'text' => $this->language->get('text_error'),
				'href' => $this->url->link('blog/category', $url)
			);
				
			$this->document->setTitle($this->language->get('text_error'));
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
}		