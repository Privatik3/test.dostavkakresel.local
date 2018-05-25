<?php
class ModelExtensionTotalAddictive extends Model {
	public function getTotal($total) {
		if (isset($this->session->data['addictive'])) {
			$this->load->language('extension/total/addictive');

			$this->load->model('checkout/addictive');
			foreach($this->session->data['addictive'] as $addictive){
				
			$id = str_replace('service', '', $addictive);
			$service = $this->model_checkout_addictive->getServices($id);

			if ($service) {
				$discount_total = 0;

				$sub_total = 0;
				$total['totals'][] = array(
					'code'       => 'addictive',
					'title'      => $service['name'],
					'value'      => $service['new_price'],
					'sort_order' => $this->config->get('addictive_sort_order')
				);
			}
			 $total['total'] += $service['new_price'];
			}
		}
	}

	public function confirm($order_info, $order_total) {
		$code = '';

		$start = strpos($order_total['title'], '(') + 1;
		$end = strrpos($order_total['title'], ')');

		if ($start && $end) {
			$code = substr($order_total['title'], $start, $end - $start);
		}

		$this->load->model('checkout/coupon');

		$coupon_info = $this->model_checkout_coupon->getCoupon($code);

		if ($coupon_info) {
			$this->db->query("INSERT INTO `" . DB_PREFIX . "coupon_history` SET coupon_id = '" . (int)$coupon_info['coupon_id'] . "', order_id = '" . (int)$order_info['order_id'] . "', customer_id = '" . (int)$order_info['customer_id'] . "', amount = '" . (float)$order_total['value'] . "', date_added = NOW()");
		}
	}

	public function unconfirm($order_id) {
		$this->db->query("DELETE FROM `" . DB_PREFIX . "coupon_history` WHERE order_id = '" . (int)$order_id . "'");
	}
}