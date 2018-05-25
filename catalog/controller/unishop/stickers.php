<?php 
class ControllerUniShopStickers extends Controller {

	public function index($result) {		
		if($result) {
			$stickers = array();
			$this->load->model('unishop/setting');
			$settings = $this->model_unishop_setting->getSetting();
			$language_id = $this->config->get('config_language_id');
			
			if ($result['reward'] && isset($settings['sticker_reward'])) {
				$stickers[] = array(
					'name' => 'reward',
					'text' => $settings[$language_id]['sticker_reward_text'],
					'text_after' => $settings[$language_id]['sticker_reward_text_after'],
					'value' => $result['reward'],
					'length' => strlen($settings[$language_id]['sticker_reward_text']) + strlen($settings[$language_id]['sticker_reward_text_after'])
				);
			}
			
			if ($result['special'] && $result['special'] > 0 && isset($settings['sticker_special'])) {
				$currency = (VERSION >= 2.2) ? $this->session->data['currency'] : '';
				$percent = round((($result['special'] - $result['price'])/$result['price'])*100, 0) . '%';
				$value = $this->currency->format($this->tax->calculate($result['price'] - $result['special'], $result['tax_class_id'], $this->config->get('config_tax')), $currency);

				$stickers[] = array(
					'name' => 'special',
					'text' => $settings[$language_id]['sticker_special_text'],
					'text_after' => '',
					'value' => isset($settings['sticker_special_percent']) ? $percent : $value,
					'length' => strlen($settings[$language_id]['sticker_special_text']) + strlen(isset($settings['sticker_special_percent']) ? $percent : $value),
				);
			}
			
			$this->load->model('unishop/related_and_bestseller');
			$bestseller = $this->model_unishop_related_and_bestseller->getBestSellerProducts($result['product_id']);
				
			if ($bestseller && isset($settings['sticker_bestseller'])) {
				$stickers[] = array(
					'name' => 'bestseller',
					'text' => $settings[$language_id]['sticker_bestseller_text'],
					'text_after' => '',
					'value' => '',
					'length' => strlen($settings[$language_id]['sticker_bestseller_text'])
				);
			}
				
			$timestamp = time();
			$date_time_array = getdate($timestamp);
			$hours = $date_time_array['hours'];
			$minutes = $date_time_array['minutes'];
			$seconds = $date_time_array['seconds'];
			$month = $date_time_array['mon'];
			$day = $date_time_array['mday'];
			$year = $date_time_array['year'];
			$timestamp = mktime($hours,$minutes,$seconds,$month,$day - $settings['sticker_new_date'],$year);
			$date_now = strftime('%Y-%m-%d',$timestamp);
			$date = $result['date_available'];
				
			if ($date > $date_now && isset($settings['sticker_new'])) {
				$stickers[] = array(
					'name' => 'new',
					'text' => $settings[$language_id]['sticker_new_text'],
					'text_after' => '',
					'value' => '',
					'length' => strlen($settings[$language_id]['sticker_new_text'])
				);		
			}
			
			if (isset($settings['upc_as_sticker']) && $result['upc']) {
				$stickers[] = array(
					'name' => 'upc',
					'text' => $result['upc'],
					'text_after' => '',
					'value' => '',
					'length' => strlen($result['upc'])
				);
			}
			
			if (isset($settings['ean_as_sticker']) && $result['ean']) {
				$stickers[] = array(
					'name' => 'ean',
					'text' => $result['ean'],
					'text_after' => '',
					'value' => '',
					'length' => strlen($result['ean'])
				);
			}
			
			if (isset($settings['jan_as_sticker']) && $result['jan']) {
				$stickers[] = array(
					'name' => 'jan',
					'text' => $result['jan'],
					'text_after' => '',
					'value' => '',
					'length' => strlen($result['jan'])
				);
			}
			
			if (isset($settings['isbn_as_sticker']) && $result['isbn']) {
				$stickers[] = array(
					'name' => 'isbn',
					'text' => $result['isbn'],
					'text_after' => '',
					'value' => '',
					'length' => strlen($result['isbn'])
				);
			}
			
			if (isset($settings['mpn_as_sticker']) && $result['mpn']) {
				$stickers[] = array(
					'name' => 'mpn',
					'text' => $result['mpn'],
					'text_after' => '',
					'value' => '',
					'length' => strlen($result['mpn'])
				);
			}
			
			if(count($stickers) > 1) { 
				usort($stickers, function($x,$y) {
					if ($x['length'] == $y['length']) {
						return 0;
					} else {
						if ($x['length'] > $y['length']) {
							return -1;
						} else {
							return 1;
						}
					}
				}); 
			}
		
			return $stickers;	
		} else {
			$this->response->redirect($this->url->link('error/not_found'));
		}
	}
}
?>