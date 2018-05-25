<?php
class ControllerCatalogEditProducts extends Controller {

	public function edit() {


		$this->load->model('catalog/product');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') ) {
			//var_dump($this->request->post);exit;
			//$this->model_catalog_product->editProduct($this->request->get['product_id'], $this->request->post);
			$this->db->query("UPDATE " . DB_PREFIX . "product SET   model = '" . $this->db->escape($this->request->post['model']) . "', quantity = '" . (int)$this->request->post['quantity'] . "', stock_status_id = '" . (int)$this->request->post['stock_status_id'] . "', price = '" . (float)$this->request->post['price'] . "',  status = '" . (int)$this->request->post['status'] . "', date_modified = NOW() WHERE product_id = '" . (int)$this->request->get['product_id'] . "'");

			$this->db->query("UPDATE " . DB_PREFIX . "product_description SET   name = '" . $this->db->escape($this->request->post['name']) . "' WHERE product_id = '" . (int)$this->request->get['product_id'] . "'");

			$this->db->query("DELETE FROM " . DB_PREFIX . "product_special WHERE product_id = '" . (int) $this->request->get['product_id'] . "'");
			$special_info=$this->db->query("SELECT date_end,customer_group_id  FROM " . DB_PREFIX . "product_special WHERE product_id = '" . (int) $this->request->get['product_id'] . "' LIMIT 1")->rows;
            if(isset($special_info['date_end']))
                $date_end= $special_info['date_end'];
            else
                $date_end=  '9999-12-12';

            if(isset($customer_group_id['customer_group_id']))
                $customer_group_id= $special_info['customer_group_id'];
            else
                $customer_group_id= 1;


            if (!empty($this->request->post['special_price'])) {

					$this->db->query( "INSERT INTO " . DB_PREFIX . "product_special SET product_id = '" . (int) $this->request->get['product_id'] . "', customer_group_id = '" . (int)$customer_group_id."', priority = 1, price = '" . (float)$this->request->post['special_price'] . "', date_start = NOW(), date_end = '" . $this->db->escape($date_end) . "'");
				}
			$json['error']=0;
			//$this->load->model('localisation/stock_status');

			$json['product'] = $this->model_catalog_product->getProduct($this->request->get['product_id']);
			$json['special_price']=$this->db->query("SELECT price FROM " . DB_PREFIX . "product_special WHERE product_id='".$this->request->get['product_id']."'")->row;

			//$json['stock_statuses'] = $this->model_localisation_stock_status->getStockStatuses();
		}
		else
		{
			$json['error']=1;

		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));



		}




}
