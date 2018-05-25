<?php
class ControllerProductUniReviews extends Controller {
    public function index() {
        $this->language->load('product/uni_reviews');

        $this->load->model('catalog/product');
        $this->load->model('extension/module/uni_reviews');
        $this->load->model('tool/image');
		
		$this->load->model('unishop/setting');
		$settings = $this->model_unishop_setting->getSetting();
		$language_id = $this->config->get('config_language_id');
			
		$data['route'] = isset($this->request->get['route']) ? $this->request->get['route'] : ''; 
		$data['menu_schema'] = isset($settings['menu_schema']) ? $settings['menu_schema'] : array();

        if (isset($this->request->get['page'])) {
            $page = $this->request->get['page'];
        } else {
            $page = 1;
        }

        $limit = $this->config->get('config_product_limit') ? $this->config->get('config_product_limit') : 10;

        $this->document->setTitle($this->language->get('heading_title'));

        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
            'text'      => $this->language->get('text_home'),
            'href'      => $this->url->link('common/home'),
            'separator' => false
        );

        $url = '';

        if (isset($this->request->get['page'])) {
            $url .= '&page=' . $this->request->get['page'];
        }

        if (isset($this->request->get['limit'])) {
            $url .= '&limit=' . $this->request->get['limit'];
        }

        $data['breadcrumbs'][] = array(
            'text'      => $this->language->get('heading_title'),
            'href'      => $this->url->link('product/uni_reviews', $url),
            'separator' => $this->language->get('text_separator')
        );

        $data['heading_title'] = $this->language->get('heading_title');

        $data['text_empty'] = $this->language->get('text_empty');

        $data['reviews'] = array();

        $reviews_total = $this->model_extension_module_uni_reviews->getTotalReviews();

        $results = $this->model_extension_module_uni_reviews->getAllReviews(($page - 1) * $limit, $limit, $page);

        foreach ($results as $result) {
            if ($this->config->get('config_review_status')) {
                $rating = $result['rating'];
            } else {
                $rating = false;
            }

            if ($result['product_id']) {
                $product = $this->model_catalog_product->getProduct($result['product_id']);
				
                if ($product['image']) {
					$image = $this->model_tool_image->resize($product['image'], (VERSION >= 2.2) ? $this->config->get($this->config->get('config_theme') . '_image_product_width') : $this->config->get('config_image_product_width'), (VERSION >= 2.2) ? $this->config->get($this->config->get('config_theme') . '_image_product_height') : $this->config->get('config_image_product_height'));
                } else {
					$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
				}

				$data['reviews'][] = array(
					'review_id'   => $result['review_id'],
					'rating'      => $rating,
					'description' => $result['text'],
					'date_added'  => date($this->language->get('date_format_short'), strtotime($result['date_added'])),
					'author'      => $result['author'],
					'product_id'  => $product['product_id'],
					'prod_thumb'  => $image,
					'prod_name'   => $product['name'],
					'prod_model'  => $product['model'],
					'prod_href'   => $this->url->link('product/product', 'product_id=' . $product['product_id']),
				);
			}
        }

        $pagination = new Pagination();
        $pagination->total = $reviews_total;
        $pagination->page = $page;
        $pagination->limit = $limit;
        $pagination->url = $this->url->link('product/uni_reviews', '&page={page}');

        $data['pagination'] = $pagination->render();

        $data['results'] = sprintf($this->language->get('text_pagination'), ($reviews_total) ? (($page - 1) * $limit) + 1 : 0, ((($page - 1) * $limit) > ($reviews_total - $limit)) ? $reviews_total : ((($page - 1) * $limit) + $limit), $reviews_total, ceil($reviews_total / $limit));

        $data['column_left'] = $this->load->controller('common/column_left');
        $data['column_right'] = $this->load->controller('common/column_right');
        $data['content_top'] = $this->load->controller('common/content_top');
        $data['content_bottom'] = $this->load->controller('common/content_bottom');
        $data['footer'] = $this->load->controller('common/footer');
        $data['header'] = $this->load->controller('common/header');

		if (VERSION >= 2.2) {
			$this->response->setOutput($this->load->view('/product/uni_reviews', $data));
		} else {
			$this->response->setOutput($this->load->view('unishop/template/product/uni_reviews.tpl', $data));
		}
    }
}