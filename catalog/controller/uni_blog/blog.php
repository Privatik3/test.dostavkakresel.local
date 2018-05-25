<?php
	class ControllerUniBlogBlog extends Controller {
		public function index() {
			$this->load->language('uni_blog/category');
			
			$this->load->model('uni_blog/category');
			
			$this->load->model('uni_blog/article');
			
			$this->load->model('tool/image');
			
			//$this->document->setTitle($category_info['name']);
			//$this->document->setDescription($category_info['meta_description']);
			//$this->document->setKeywords($category_info['meta_keyword']);
				
			//$data['heading_title'] = $category_info['name'];
				
			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/stylesheet/blog.css')) {
				$this->document->addStyle('catalog/view/theme/'.$this->config->get('config_template') . '/stylesheet/blog.css');
			} else {
				$this->document->addStyle('catalog/view/theme/default/stylesheet/blog.css');
			}
				
			//$data['heading_title'] = $category_info['name'];
			
			$data['breadcrumbs'][] = array(
				'text'      => $this->language->get('text_home'),
				'href'      => $this->url->link('common/home'),
			);
				
			$data['breadcrumbs'][] = array(
				'text' => 'Блог',
				'href' => $this->url->link('uni_blog/blog')
			);
			
			$results = $this->model_uni_blog_category->getCategories(0);
			
			if ($results) {
				$data['categories'] = array();

				foreach ($results as $result) {					
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
					
					
					if (( isset($result['short_description']) && $result['short_description']) !='') {
						$description = utf8_substr(strip_tags(html_entity_decode($result['short_description'], ENT_QUOTES, 'UTF-8')), 0, 150) . '..';
					} else {
						$description = utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, 150) . '..';
					}
					
					$data['categories'][] = array(
						'thumb' => $image,
						'description' => $description,
						'name'  => $result['name'],
						'href'  => $this->url->link('uni_blog/category', 'blog_path=' . $result['category_id'])
					);
				}
				
				$data['continue'] = $this->url->link('common/home');
				
				$data['column_left'] = $this->load->controller('common/column_left');
				$data['column_right'] = $this->load->controller('common/column_right');
				$data['content_top'] = $this->load->controller('common/content_top');
				$data['content_bottom'] = $this->load->controller('common/content_bottom');
				$data['footer'] = $this->load->controller('common/footer');
				$data['header'] = $this->load->controller('common/header');
				
				if (VERSION >= 2.2) {
			$this->response->setOutput($this->load->view('uni_blog/review', $data));
		} else {
			$this->response->setOutput($this->load->view('unishop/template/uni_blog/blog.tpl', $data));
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
						'href' => $this->url->link('uni_blog/category', $url)
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
				
				if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/error/not_found.tpl')) {
					$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/error/not_found.tpl', $data));
				} else {
					$this->response->setOutput($this->load->view('default/template/error/not_found.tpl', $data));
				}
		}
	}
}		