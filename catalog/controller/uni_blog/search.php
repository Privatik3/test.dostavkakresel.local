<?php
class ControllerUniBlogSearch extends Controller {
	public function index() {
		$this->load->language('uni_blog/search');
		$this->load->language('uni_blog/category');

		$this->load->model('uni_blog/category');
		$this->load->model('uni_blog/article');

		$this->load->model('tool/image');

		if (isset($this->request->get['blog_search'])) {
			$blog_search = $this->request->get['blog_search'];
		} else {
			$blog_search = '';
		}

		if (isset($this->request->get['tag'])) {
			$tag = $this->request->get['tag'];
		} elseif (isset($this->request->get['blog_search'])) {
			$tag = $this->request->get['blog_search'];
		} else {
			$tag = '';
		}

		if (isset($this->request->get['description'])) {
			$description = $this->request->get['description'];
		} else {
			$description = '';
		}

		if (isset($this->request->get['category_id'])) {
			$category_id = $this->request->get['category_id'];
		} else {
			$category_id = 0;
		}

		if (isset($this->request->get['sub_category'])) {
			$sub_category = $this->request->get['sub_category'];
		} else {
			$sub_category = '';
		}

		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'p.sort_order';
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

		if (isset($this->request->get['limit'])) {
			$limit = $this->request->get['limit'];
		} else {
			$limit = $this->config->get('blog_catalog_limit');
		}

		if (isset($this->request->get['blog_search'])) {
			$this->document->setTitle($this->language->get('heading_title') .  ' - ' . $this->request->get['blog_search']);
		} elseif (isset($this->request->get['tag'])) {
			$this->document->setTitle($this->language->get('heading_title') .  ' - ' . $this->language->get('heading_tag') . $this->request->get['tag']);
		} else {
			$this->document->setTitle($this->language->get('heading_title'));
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);

		$url = '';

		if (isset($this->request->get['blog_search'])) {
			$url .= '&search=' . urlencode(html_entity_decode($this->request->get['blog_search'], ENT_QUOTES, 'UTF-8'));
		}

		if (isset($this->request->get['tag'])) {
			$url .= '&tag=' . urlencode(html_entity_decode($this->request->get['tag'], ENT_QUOTES, 'UTF-8'));
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
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('uni_blog/search', $url)
		);

		if (isset($this->request->get['blog_search'])) {
			$data['heading_title'] = $this->language->get('heading_title') .  ' - ' . $this->request->get['blog_search'];
		} else {
			$data['heading_title'] = $this->language->get('heading_title');
		}

		$data['text_empty'] = $this->language->get('text_empty');
		$data['text_search'] = $this->language->get('text_search');
		$data['text_keyword'] = $this->language->get('text_keyword');
		$data['text_category'] = $this->language->get('text_category');
		$data['text_sub_category'] = $this->language->get('text_sub_category');
		$data['text_sort'] = $this->language->get('text_sort');
		$data['text_limit'] = $this->language->get('text_limit');
		$data['text_product_search'] = $this->language->get('text_product_search');
		$data['text_more'] = $this->language->get('text_more');
		
		$data['text_review'] = $this->language->get('text_review');
		$data['text_date_added'] = $this->language->get('text_date_added');
		$data['text_viewed'] = $this->language->get('text_viewed');
		$data['text_author'] = $this->language->get('text_author');

		$data['entry_search'] = $this->language->get('entry_search');
		$data['entry_description'] = $this->language->get('entry_description');

		$data['button_search'] = $this->language->get('button_search');
		$data['button_list'] = $this->language->get('button_list');
		$data['button_grid'] = $this->language->get('button_grid');

		$data['link_to_product_search'] = $this->url->link('product/search', $url);
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/stylesheet/blog.css')) {
			$this->document->addStyle('catalog/view/theme/'.$this->config->get('config_template') . '/stylesheet/blog.css');
		} else {
			$this->document->addStyle('catalog/view/theme/default/stylesheet/blog.css');
		}

		$this->load->model('uni_blog/category');

		// 3 Level Category Search
		$data['categories'] = array();

		$categories_1 = $this->model_uni_blog_category->getCategories(0);

		foreach ($categories_1 as $category_1) {
			$level_2_data = array();

			$categories_2 = $this->model_uni_blog_category->getCategories($category_1['category_id']);

			foreach ($categories_2 as $category_2) {
				$level_3_data = array();

				$categories_3 = $this->model_uni_blog_category->getCategories($category_2['category_id']);

				foreach ($categories_3 as $category_3) {
					$level_3_data[] = array(
						'category_id' => $category_3['category_id'],
						'name'        => $category_3['name'],
					);
				}

				$level_2_data[] = array(
					'category_id' => $category_2['category_id'],
					'name'        => $category_2['name'],
					'children'    => $level_3_data
				);
			}

			$data['categories'][] = array(
				'category_id' => $category_1['category_id'],
				'name'        => $category_1['name'],
				'children'    => $level_2_data
			);
		}
		
		$data['show_viewed'] = $this->config->get('blog_show_viewed');
		$data['show_date_added'] = $this->config->get('blog_show_date_added');
		$data['show_date_modified'] = $this->config->get('blog_show_date_modified');
		$data['show_author'] = $this->config->get('blog_show_author');
		$data['review_status'] = $this->config->get('blog_review_status');

		$data['articles'] = array();

		if (isset($this->request->get['blog_search']) || isset($this->request->get['tag'])) {
			$filter_data = array(
				'filter_name'         => $blog_search,
				'filter_tag'          => $tag,
				'filter_description'  => $description,
				'filter_category_id'  => $category_id,
				'filter_sub_category' => $sub_category,
				'sort'                => $sort,
				'order'               => $order,
				'start'               => ($page - 1) * $limit,
				'limit'               => $limit
			);

			$article_total = $this->model_uni_blog_article->getTotalArticles($filter_data);

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
					'article_id'  => $result['article_id'],
					'thumb'       => $image,
					'name'        => $result['name'],
					'description' => $description,
					'rating'      => $result['rating'],
					'author'        => $result['author'],
					'reviews'       => $result['reviews'],
					'date_added'	=> date($this->language->get('date_format_short'), strtotime($result['date_added'])),
					'viewed'		=> $result['viewed'],
					'href'        => $this->url->link('uni_blog/article', 'article_id=' . $result['article_id'] . $url)
				);
			}

			$url = '';

			if (isset($this->request->get['blog_search'])) {
				$url .= '&blog_search=' . urlencode(html_entity_decode($this->request->get['blog_search'], ENT_QUOTES, 'UTF-8'));
			}

			if (isset($this->request->get['tag'])) {
				$url .= '&tag=' . urlencode(html_entity_decode($this->request->get['tag'], ENT_QUOTES, 'UTF-8'));
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

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$data['sorts'] = array();

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_default'),
				'value' => 'p.sort_order-ASC',
				'href'  => $this->url->link('uni_blog/search', 'sort=p.sort_order&order=ASC' . $url)
			);

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_name_asc'),
				'value' => 'pd.name-ASC',
				'href'  => $this->url->link('uni_blog/search', 'sort=pd.name&order=ASC' . $url)
			);

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_name_desc'),
				'value' => 'pd.name-DESC',
				'href'  => $this->url->link('uni_blog/search', 'sort=pd.name&order=DESC' . $url)
			);

			if ($this->config->get('config_review_status')) {
				$data['sorts'][] = array(
					'text'  => $this->language->get('text_rating_desc'),
					'value' => 'rating-DESC',
					'href'  => $this->url->link('product/search', 'sort=rating&order=DESC' . $url)
				);

				$data['sorts'][] = array(
					'text'  => $this->language->get('text_rating_asc'),
					'value' => 'rating-ASC',
					'href'  => $this->url->link('product/search', 'sort=rating&order=ASC' . $url)
				);
			}

			$url = '';

			if (isset($this->request->get['blog_search'])) {
				$url .= '&blog_search=' . urlencode(html_entity_decode($this->request->get['blog_search'], ENT_QUOTES, 'UTF-8'));
			}

			if (isset($this->request->get['tag'])) {
				$url .= '&tag=' . urlencode(html_entity_decode($this->request->get['tag'], ENT_QUOTES, 'UTF-8'));
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

			$data['limits'] = array();

			$limits = array_unique(array($this->config->get('blog_catalog_limit'), 25, 50, 75, 100));

			sort($limits);

			foreach($limits as $value) {
				$data['limits'][] = array(
					'text'  => $value,
					'value' => $value,
					'href'  => $this->url->link('uni_blog/search', $url . '&limit=' . $value)
				);
			}

			$url = '';

			if (isset($this->request->get['blog_search'])) {
				$url .= '&blog_search=' . urlencode(html_entity_decode($this->request->get['blog_search'], ENT_QUOTES, 'UTF-8'));
			}

			if (isset($this->request->get['tag'])) {
				$url .= '&tag=' . urlencode(html_entity_decode($this->request->get['tag'], ENT_QUOTES, 'UTF-8'));
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

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$pagination = new Pagination();
			$pagination->total = $article_total;
			$pagination->page = $page;
			$pagination->limit = $limit;
			$pagination->url = $this->url->link('uni_blog/search', $url . '&page={page}');

			$data['pagination'] = $pagination->render();

			$data['results'] = sprintf($this->language->get('text_pagination'), ($article_total) ? (($page - 1) * $limit) + 1 : 0, ((($page - 1) * $limit) > ($article_total - $limit)) ? $article_total : ((($page - 1) * $limit) + $limit), $article_total, ceil($article_total / $limit));
		}

		$data['blog_search'] = $blog_search;
		$data['description'] = $description;
		$data['category_id'] = $category_id;
		$data['sub_category'] = $sub_category;

		$data['sort'] = $sort;
		$data['order'] = $order;
		$data['limit'] = $limit;

		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');
		
		if (VERSION >= 2.2) {
			$this->response->setOutput($this->load->view('uni_blog/search', $data));
			} else {
			$this->response->setOutput($this->load->view('unishop/template/uni_blog/search.tpl', $data));
		}
		
	}
}