<?php
class ModelCatalogUnit extends Model {
	public function getUnitName($product_unit_id) {
		$query = $this->db->query("SELECT u1c.name FROM `" . DB_PREFIX . "product_unit` pu LEFT JOIN `" . DB_PREFIX . "unit_to_1c` u1c ON (pu.unit_id = u1c.unit_id) WHERE pu.product_unit_id = " . (int)$product_unit_id);
		if ($query->num_rows) {
			return $query->row['name'];
		}
		return "<unit not found>";
	}

	public function getProductUnits($product_id) {
		$units = array();
		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "product_unit` pu LEFT JOIN `" . DB_PREFIX . "unit_to_1c` u1c ON (pu.unit_id = u1c.unit_id) WHERE pu.product_id = " . $product_id);
		if ($query->num_rows) {
			foreach ($query->rows as $row) {
				$unit_name = $row['ratio'] == 1 ? $row['name'] : "";
				$units[$row['product_unit_id']] = array(
					'name'					=> $row['name'],
					'ratio'					=> $row['ratio'],
					'product_feature_id'	=> $row['product_feature_id']
			  	);
			}
		}

		return $units;
	}

	public function getProductUnit($product_unit_id) {
		$query = $this->db->query("SELECT `p`.`ratio`,`u`.`name`,`u`.`code`,`u`.`full_name` FROM `" . DB_PREFIX . "product_unit` `p` LEFT JOIN `" . DB_PREFIX . "unit_to_1c` `u` ON (`p`.`unit_id` = `u`.`unit_id`) WHERE `p`.`product_unit_id` = " . (int)$product_unit_id);
		if ($query->num_rows) {
			return $query->row;
		}

		return false;
	}
}