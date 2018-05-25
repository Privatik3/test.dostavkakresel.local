<?php
class ControllerExtensionModuleUniHomeBanner extends Controller {
	public function index() {
		$data = array();
		
		$this->load->model('unishop/setting');
		$settings = $this->model_unishop_setting->getSetting();
		$lang_id = $this->config->get('config_language_id');
		
		$data['home_banners'] = array();
		
		if($settings[$lang_id]['home_banners']) {
			foreach($settings[$lang_id]['home_banners'] as $homebanner) {
				if($homebanner['text']) {
					$data['home_banners'][] = array(
						'icon' 			=> $homebanner['icon'],
						'text' 			=> html_entity_decode($homebanner['text'], ENT_QUOTES, 'UTF-8'),
						'text1' 		=> html_entity_decode($homebanner['text1'], ENT_QUOTES, 'UTF-8'),
						'link' 			=> $homebanner['link'],
						'link_popup' 	=> isset($homebanner['link_popup']) ? true : false,
					);
				}
			}
		}
		
		if (VERSION >= 2.2) {
			return $this->load->view('extension/module/uni_homebanner', $data);
		} else {	
			return $this->load->view('unishop/template/extension/module/uni_homebanner.tpl', $data);
		}
	}
}
