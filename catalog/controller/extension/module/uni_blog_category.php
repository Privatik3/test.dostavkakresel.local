<?php
class ControllerExtensionModuleUniBlogCategory extends Controller {
	public function index() {
		$this->load->language('module/uni_blog_category');

		$data['heading_title'] = $this->language->get('heading_title');

		if (isset($this->request->get['blog_path'])) {
			$parts = explode('_', (string)$this->request->get['blog_path']);
		} else {
			$parts = array();
		}

		if (isset($parts[0])) {
			$data['category_id'] = $parts[0];
		} else {
			$data['category_id'] = 0;
		}

		if (isset($parts[1])) {
			$data['child_id'] = $parts[1];
		} else {
			$data['child_id'] = 0;
		}

		$this->load->model('uni_blog/category');

		$this->load->model('uni_blog/article');

		$data['categories'] = array();

		$categories = $this->model_uni_blog_category->getCategories(0);

		foreach ($categories as $category) {
			$children_data = array();

			if ($category['category_id'] == $data['category_id']) {
				$children = $this->model_uni_blog_category->getCategories($category['category_id']);

				foreach($children as $child) {					

					$children_data[] = array(
						'category_id' => $child['category_id'],
						'name' => $child['name'],
						'href' => $this->url->link('uni_blog/category', 'blog_path=' . $category['category_id'] . '_' . $child['category_id'])
					);
				}
			}

			$filter_data = array(
				'filter_category_id'  => $category['category_id'],
				'filter_sub_category' => true
			);

			$data['categories'][] = array(
				'category_id' => $category['category_id'],
				'name'        => $category['name'],
				'children'    => $children_data,
				'href'        => $this->url->link('uni_blog/category', 'blog_path=' . $category['category_id'])
			);
		}

		if (VERSION >= 2.2) {
			return $this->load->view('extension/module/blog_category', $data);
		} else {
			return $this->load->view('unishop/template/extension/module/blog_category.tpl', $data);
		}
	}
}