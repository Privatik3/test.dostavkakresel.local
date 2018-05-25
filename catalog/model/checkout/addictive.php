<?php
class ModelCheckoutAddictive extends Model {
	
	public function getServices($code) {
		$status = true;

		$service_query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "addictive_service` WHERE id = '" . $code. "'");
		if ($service_query->num_rows) {

		if ($status){
			return array(
				'service_id'    => $service_query->row['id'],
				'name'          => $service_query->row['service_name'],
				'price'         => $service_query->row['service_price'],
				'new_price'     => $service_query->row['service_new_price']);
		} 
	}
}

}