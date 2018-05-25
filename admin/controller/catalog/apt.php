<?php 
class ControllerCatalogApt extends Controller {
	private $error = array(); 
	public function index() {
		$this->load->language('catalog/apt');
		$this->load->model('catalog/apt');
		$data['tab_apt'] = $this->language->get('tab_apt');
		$data['button_add_apt'] = $this->language->get('button_add_apt');
		$data['button_remove'] = $this->language->get('button_remove');
		$data['apt_row'] = 0;
		$data['entry_apt'] = $this->language->get('entry_apt');
		$data['entry_title'] = $this->language->get('entry_title');
		$data['entry_text'] = $this->language->get('entry_text');
		$data['entry_remove'] = $this->language->get('entry_remove');
		$data['sort_order'] = $this->language->get('sort_order');
		$product_apts = array();
		$data['product_apt_names'] = array();
		$data['tab_sort_order'] = array();
		$product_info = "";
		if (isset($this->request->get['product_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$product_info = $this->model_catalog_product->getProduct($this->request->get['product_id']);
			$product_tab_info = $this->model_catalog_apt->getTabData($this->request->get['product_id']);
		}
		if (isset($this->request->post['product_apt_name'])) {
			$data['product_apt_name'] = $this->request->post['product_apt_name'];
		} elseif (isset($this->request->get['product_id'])) {
			$data['product_apt_name'] = $this->model_catalog_apt->getProductTabName($this->request->get['product_id']);
		} else {
			$data['product_apt_name'] = array();
		}
		
		if (isset($this->request->post['product_apt_desc'])) {
			$data['product_apt_desc'] = $this->request->post['product_apt_desc'];
		} elseif (isset($this->request->get['product_id'])) {
			$data['product_apt_desc'] = $this->model_catalog_apt->getProductTabDescriptions($this->request->get['product_id']);
		} else {
			$data['product_apt_desc'] = array();
		}
		
		if (isset($this->request->post['tab_sort_order'])) {
			$data['tab_sort_order'] = $this->request->post['tab_sort_order'];
		} elseif (isset($this->request->get['product_id'])) {
			$data['tab_sort_order'] = $this->model_catalog_apt->getProductTabSortOrder($this->request->get['product_id']);
		} else {
			$data['tab_sort_order'] = array();
		}
		if(isset($product_tab_info)){
				$product_apt_names=array();
				$product_apt_descs=array();
				$tab_sort_order=array();
				$lang_arr=array();
				for($i=0;$i<count($product_tab_info);$i++)
				{
					$language_info = $this->model_catalog_apt->getLangCode($product_tab_info[$i]['language_id']);
					$language_code=$language_info[0]['code'];
					if(count($lang_arr)>0)
					{
						
						if(in_array($language_code,$lang_arr))
						{
							$total=count($product_apt_names[$language_code]);
							$product_apt_names[$language_code][$total]=$product_tab_info[$i]['tab_title'];
							$product_apt_descs[$language_code][$total]=$product_tab_info[$i]['tab_desc'];
							$tab_sort_order[$language_code][$total]=$product_tab_info[$i]['sort_order'];
						}
						else
						{
							$lang_arr[]=$language_code;
							$product_apt_names[$language_code]=array();
							$product_apt_descs[$language_code]=array();
							$tab_sort_order[$language_code]=array();
							$product_apt_names[$language_code][0]=$product_tab_info[$i]['tab_title'];
							$product_apt_descs[$language_code][0]=$product_tab_info[$i]['tab_desc'];
							$tab_sort_order[$language_code][0]=$product_tab_info[$i]['sort_order'];
						}
						
					}
					else
					{
						$product_apt_names[$language_code]=array();
						$product_apt_descs[$language_code]=array();
						$tab_sort_order[$language_code]=array();
						$product_apt_names[$language_code][0]=$product_tab_info[$i]['tab_title'];
						$product_apt_descs[$language_code][0]=$product_tab_info[$i]['tab_desc'];
						$tab_sort_order[$language_code][0]=$product_tab_info[$i]['sort_order'];
						$lang_arr[]=$language_code;
					}
				}
				
				$data['product_apt_names'] = $product_apt_names;
				$data['product_apt_descs'] = $product_apt_descs;
				$data['tab_sort_order'] = $tab_sort_order;
			
		}
		
		$data['token'] = $this->session->data['token'];
		
		$this->load->model('localisation/language');
		$data['languages'] = $this->model_localisation_language->getLanguages();
				
		 return $this->load->view('catalog/apt.tpl', $data);		
		
	}
	public function gettab() {
		$this->load->language('catalog/apt');
		$data['tab_apt'] = $this->language->get('tab_apt');
		$data['button_add_apt'] = $this->language->get('button_add_apt');
		$data['token'] = $this->session->data['token'];
		$data['sort_order'] = $this->language->get('sort_order');
		
		return $this->load->view('catalog/gettab.tpl', $data);

	}
}
?>