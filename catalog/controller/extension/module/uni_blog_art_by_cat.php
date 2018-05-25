<?php
class ControllerExtensionModuleUniBlogArtByCat extends Controller {
	public function index($setting) {
		$this->load->language('module/blog_art_by_cat');

		$data['heading_title'] = $setting['name'];
		
		$this->load->model('uni_blog/article');
		
		$this->load->model('tool/image');
		
		$this->document->addStyle('catalog/view/theme/unishop/stylesheet/article_by_category.css');
		
		$data['show_viewed'] = $this->config->get('blog_show_viewed');
		$data['show_date_added'] = $this->config->get('blog_show_date_added');
		$data['show_date_modified'] = $this->config->get('blog_show_date_modified');
		$data['show_author'] = $this->config->get('blog_show_author');
		$data['review_status'] = $this->config->get('blog_review_status');
		
		$data['text_review'] = $this->language->get('text_review');
		$data['text_date_added'] = $this->language->get('text_date_added');
		$data['text_viewed'] = $this->language->get('text_viewed');
		$data['text_author'] = $this->language->get('text_author');

		$data['articles'] = array();
		
		//print_r($setting);
		
		if (isset($this->request->get['path'])) {
			$path = '';
			$parts = explode('_', (string)$this->request->get['path']);
			$category_id = (int)array_pop($parts);
		} else {
			$category_id = 0;
		}
		
		if (!isset($setting['category2']) || in_array($category_id, $setting['category2'])) {
			$res = array();
		
			foreach ($setting['category'] as $category_id) {
				$results = $this->model_uni_blog_article->getArticleByCategory($category_id, $setting['limit']);
				
				$category_info = $this->model_uni_blog_article->getCategoryInfo($category_id);
				
				if(isset($setting['category2']) && count($setting['category2']) == 1) {
					$data['category_name'] = $category_info['name'];
					$data['category_href'] = $this->url->link('uni_blog/category', 'blog_path=' . $category_info['category_id']);
				} else {
					$data['category_href'] = '';
				}
				
				foreach ($results as $result) {
					$res[] = $result;
				}
			}
			
			if($res){
				foreach ($res as $key => $value) {
					$sort[$key] = $value['date_added'];
				}
			
				array_multisort($sort, SORT_DESC, $res);
		
				foreach ($res as $result) {
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $setting['width'], $setting['height']);
					} else {
						$image = false;
					}
				
					if ($this->config->get('blog_review_status')) {
						$rating = array();
						$this->load->model('uni_blog/review');
						$reviews = count($this->model_uni_blog_review->getReviewsByArticleId($result['article_id']));
					} else {
						$reviews = '';
					}

					if(($result['login_to_view'] == 1 && $this->customer->isLogged()) || $result['login_to_view'] == 0){
						$link = $this->url->link('uni_blog/article', 'article_id=' . $result['article_id']);
					} else {
						$link = $this->url->link('account/login');
					}
				
					if($result['short_description']) {
						$description = utf8_substr(strip_tags(html_entity_decode($result['short_description'], ENT_QUOTES, 'UTF-8')), 0, 120) . '..';
					} else {
						$description = utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, 120) . '..';
					}

					$data['articles'][] = array(
						'article_id'		=> $result['article_id'],
						'name'    	 		=> $result['name'],
						'thumb'   	 		=> $image,
						'description'		=> $description,
						'author'        	=> $result['author'],
						'reviews'       	=> $reviews,
						'date_added'		=> date($this->language->get('date_format_short'), strtotime($result['date_added'])),
						'viewed'			=> $result['viewed'],
						'href'    	 		=> $link
					);
				}
			}
		}
		
		if (VERSION >= 2.2) {
			return $this->load->view('extension/module/uni_blog_art_by_cat', $data);
		} else {
			return $this->load->view('unishop/template/extension/module/uni_blog_art_by_cat.tpl', $data);
		}
	}
}
?>