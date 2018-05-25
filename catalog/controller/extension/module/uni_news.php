<?php
class ControllerExtensionModuleUniNews extends Controller {
	private $_name = 'news';

	public function index($setting) {

		$this->language->load('extension/module/uni_news');
		$language_id = $this->config->get('config_language_id');
		
		$data['heading_title'] = $setting['uni_news_module'][$language_id]['title'] ? $setting['uni_news_module'][$language_id]['title'] : $this->language->get('heading_title');

		$data['text_more'] = $this->language->get('text_more');
		$data['text_posted'] = $this->language->get('text_posted');

		$data['buttonlist'] = $this->language->get('buttonlist');

		$this->load->model('information/uni_news');
		$this->load->model('tool/image');

		$data['news_count'] = $this->model_information_uni_news->getTotalNews();

		$data['news_limit'] = isset($setting['news_module']['limit']) ? $setting['news_module']['limit'] : 4;

		if ($data['news_count'] > $data['news_limit']) {
			$data['showbutton'] = true;
		} else {
			$data['showbutton'] = false;
		}

		$data['newslist'] = $this->url->link('information/news');
		
		$data['show_headline'] = isset($setting['news_module']['heading']) ? $setting['news_module']['heading'] : $this->language->get('heading_title');

		$data['news'] = array();

		$results = $this->model_information_uni_news->getNewsShort($setting['uni_news_module']['limit']);

		foreach ($results as $result) {
			if ($result['image']) {
				$image = $this->model_tool_image->resize($result['image'], isset($setting['uni_news_module']['thumb_width']) ? $setting['uni_news_module']['thumb_width'] : 320, isset($setting['uni_news_module']['thumb_height']) ? $setting['uni_news_module']['thumb_height'] : 240);
			} else {
				$image = false;
			}

			$description = utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, isset($setting['news_module']['numchars']) ? $setting['news_module']['numchars'] : 100) . '..';

			$data['news'][] = array(
				'title'        	=> $result['title'],
				'image'			=> $image,
				'description'	=> $description,
				'href'         	=> $this->url->link('information/uni_news', 'news_id=' . $result['news_id']),
				'posted'   		=> date($this->language->get('date_format_short'), strtotime($result['date_added'])),
				'posted2'   	=> $result['date_added']
			);
		}

		if (VERSION >= 2.3) {
			return $this->load->view('extension/module/uni_news', $data);
		} else {
			return $this->load->view('unishop/template/extension/module/uni_news.tpl', $data);
		}
	}
}
?>