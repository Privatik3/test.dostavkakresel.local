<?php
/**
* @version     1.6.0
* @module      WebRotate 360 Product Viewer for OpenCart
* @author      WebRotate 360 LLC
* @copyright   Copyright (C) 2016 WebRotate 360 LLC. All rights reserved.
* @license     GNU General Public License version 2 or later (http://www.gnu.org/copyleft/gpl.html).
*/

class ControllerExtensionModuleWebrotate360 extends Controller
{
	public function index()
    {
        $this->language->load('module/webrotate360');
	    $this->load->model('setting/setting');
				
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate())
        {
            $settingsToSave = array();
            $submitProducts = null;

            foreach($this->request->post as $key => $value)
            {
                if ($key != "submitProducts")
                    $settingsToSave[$key] = $value;
                else
                    $submitProducts = $value;
            }

            $this->model_setting_setting->editSetting('webrotate360', $settingsToSave);
            
            if ($submitProducts != null && strlen($submitProducts) > 0)
            {
                $submitProducts = str_replace('&quot;', '"', $submitProducts);
                $submitProducts = json_decode($submitProducts, true);
                if ($submitProducts != null)
                {
                    foreach($submitProducts as &$product)
                    {
                        if ($product['wr360_enabled'] == 'Yes')
                        {
                            $product['wr360_enabled'] = '1';
                        }
                        else
                        {
                            $product['wr360_enabled'] = '0';
                        }
                    }

			        $this->load->model('catalog/webrotate360');
                    $this->model_catalog_webrotate360->saveProducts($submitProducts);
                }
            }

			$this->session->data['success'] = $this->language->get('text_success');
			$this->response->redirect($this->url->link('extension/module/webrotate360', 'token=' . $this->session->data['token'], 'SSL'));
		}
				
		$data['heading_title'] = $this->language->get('heading_title');
		$data['text_enabled']  = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
		$data['button_save']   = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');
		
 		if (isset($this->error['warning']))
        {
			$data['error_warning'] = $this->error['warning'];
		}
        else
        {
			$data['error_warning'] = '';
		}
		
		if (isset($this->error['image']))
        {
			$data['error_image'] = $this->error['image'];
		}
        else
        {
			$data['error_image'] = array();
		}
				
  		$data['breadcrumbs'] = array();

   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_module'),
			'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('extension/module/webrotate360', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
		$data['action'] = $this->url->link('extension/module/webrotate360', 'token=' . $this->session->data['token'], 'SSL');
		$data['cancel'] = $this->url->link('extension/module/webrotate360', 'token=' . $this->session->data['token'], 'SSL');
		$data['token']  = $this->session->data['token'];

		$this->loadSetting($data, 'webrotate360_status');
        $this->loadSetting($data, 'webrotate360_configFileURL');
        $this->loadSetting($data, 'webrotate360_graphicsPath', 'html/img/basic');
        $this->loadSetting($data, 'webrotate360_divID', '#wr360embed');
        $this->loadSetting($data, 'webrotate360_viewerWidth', '100%');
        $this->loadSetting($data, 'webrotate360_viewerHeight', '400px');
        $this->loadSetting($data, 'webrotate360_skinCSS', 'basic.css');
        $this->loadSetting($data, 'webrotate360_baseWidth');
        $this->loadSetting($data, 'webrotate360_licensePath');
        $this->loadSetting($data, 'webrotate360_prettyPhotoSkin');
        $this->loadSetting($data, 'webrotate360_viewerInPopup');
        $this->loadSetting($data, 'webrotate360_minHeight');
        $this->loadSetting($data, 'webrotate360_useAnalytics');
        $this->loadSetting($data, 'webrotate360_apiCallback');

        $this->load->model('catalog/webrotate360');
        $this->model_catalog_webrotate360->ensureTableExists();
        $this->template = 'extension/module/webrotate360.tpl';
		
  	    $data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('extension/module/webrotate360.tpl', $data));
	}
    
    private function loadSetting(&$data, $name, $defaultIfConfigEmpty = null)
    {
        if (isset($this->request->post[$name]))
        {
            $data[$name] = $this->request->post[$name];
        }
        else
        {
            $data[$name] = $this->config->get($name);
            
            if (!isset($data[$name]) && $defaultIfConfigEmpty)
            {
                $data[$name] = $defaultIfConfigEmpty;
            }
        }
    }
	
	protected function validate()
    {
		if (!$this->user->hasPermission('modify', 'extension/module/webrotate360'))
        {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		if (!$this->error)
        {
			return true;
		}
        else
        {
			return false;
		}	
	}
    
    public function getproducts()
    {
        $this->load->model('catalog/webrotate360');
        $products = $this->model_catalog_webrotate360->getProducts();

        foreach($products as &$product)
        {
            if ($product['wr360_enabled'] == null || $product['wr360_enabled'] == '0')
                $product['wr360_enabled'] = "No";
            else
                $product['wr360_enabled'] = "Yes";
            
            if ($product['root_path'] == null)
                $product['root_path'] = "";
            
            if ($product['config_file_url'] == null)
                $product['config_file_url'] = "";
        }

        $resp = json_encode($products);
        $this->response->setOutput($resp);
    }
}
