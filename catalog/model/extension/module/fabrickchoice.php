<?php
class ModelExtensionModuleFabrickchoice extends Model {
    public function getDefaultOptionImage($product_id, $product_option_id) {
        $sql = "SELECT o.image FROM " . DB_PREFIX . "option_value o LEFT JOIN " . DB_PREFIX . "product_option_value ov ON(o.option_value_id = ov.option_value_id) WHERE ov.default_select = '1' AND ov.product_id = '" . (int)$product_id . "' AND ov.product_option_id = '" . (int)$product_option_id . "'";
        $query = $this->db->query($sql);
        return $query->row;
    }
	public function getCategory($category_id) {

		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "fc_category_description cd1  LEFT JOIN " . DB_PREFIX . "fc_category c ON (cd1.category_id = c.category_id) WHERE cd1.category_id = '" . (int)$category_id . "' AND cd1.language_id = '" . (int)$this->config->get('config_language_id') . "'");

		return $query->row;
	}

	public function getCategoryPath($category_id) {
		$query = $this->db->query("SELECT category_id, path_id, level FROM " . DB_PREFIX . "fc_category_path WHERE category_id = '" . (int)$category_id . "'");

		return $query->rows;
	}

	public function getCategoriesByParentId($parent_id = 0) {
		$query = $this->db->query("SELECT *, (SELECT COUNT(parent_id) FROM " . DB_PREFIX . "fc_category WHERE parent_id = c.category_id) AS children FROM " . DB_PREFIX . "fc_category c LEFT JOIN " . DB_PREFIX . "fc_category_description cd ON (c.category_id = cd.category_id) WHERE c.status='1' AND c.parent_id = '" . (int)$parent_id . "' AND cd.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY c.sort_order, cd.name");

		return $query->rows;
	}

	public function getCategories($data = array()) {
		$sql = "SELECT cp.category_id AS category_id, GROUP_CONCAT(cd1.name ORDER BY cp.level SEPARATOR '&nbsp;&nbsp;&gt;&nbsp;&nbsp;') AS name, c1.parent_id, c1.sort_order, c1.status,(select count(product_id) as product_count from " . DB_PREFIX . "product_to_category pc where pc.category_id = c1.category_id) as product_count FROM " . DB_PREFIX . "fc_category_path cp LEFT JOIN " . DB_PREFIX . "fc_category c1 ON (cp.category_id = c1.category_id) LEFT JOIN " . DB_PREFIX . "fc_category c2 ON (cp.path_id = c2.category_id) LEFT JOIN " . DB_PREFIX . "fc_category_description cd1 ON (cp.path_id = cd1.category_id) LEFT JOIN " . DB_PREFIX . "fc_category_description cd2 ON (cp.category_id = cd2.category_id) WHERE c1.status='1' AND cd1.language_id = '" . (int)$this->config->get('config_language_id') . "' AND cd2.language_id = '" . (int)$this->config->get('config_language_id') . "'";

		if (!empty($data['filter_name'])) {
			$sql .= " AND cd2.name LIKE '%" . $this->db->escape($data['filter_name']) . "%'";
		}

		$sql .= " GROUP BY cp.category_id";

		$sort_data = array(
			'product_count',
			'name',
			'sort_order'
		);

		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];
		} else {
			$sql .= " ORDER BY sort_order";
		}

		if (isset($data['order']) && ($data['order'] == 'DESC')) {
			$sql .= " DESC";
		} else {
			$sql .= " ASC";
		}

		if (isset($data['start']) || isset($data['limit'])) {
			if ($data['start'] < 0) {
				$data['start'] = 0;
			}

			if ($data['limit'] < 1) {
				$data['limit'] = 20;
			}

			$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
		}

		$query = $this->db->query($sql);

		return $query->rows;
	}

	public function getCategoryDescriptions($category_id) {
		$category_description_data = array();

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "fc_category_description WHERE category_id = '" . (int)$category_id . "'");

		foreach ($query->rows as $result) {
			$category_description_data[$result['language_id']] = array(
				'name'             => $result['name'],
				/* nt */
				'description'	   => $result['description']
				/* nt */
			);
		}

		return $category_description_data;
	}

	public function getTotalCategories() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "fc_category WHERE status='1'");

		return $query->row['total'];
	}

	public function getAllCategories() {

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "fc_category c LEFT JOIN " . DB_PREFIX . "fc_category_description cd ON (c.category_id = cd.category_id) WHERE cd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND c.status='1' ORDER BY c.parent_id, c.sort_order, cd.name");
		$category_data = array();
		foreach ($query->rows as $row) {
			$category_data[$row['parent_id']][$row['category_id']] = $row;
		}

		return $category_data;
	}

	public function getOptionsValues($category_id = false) {

		if ($category_id) {
			$query = $this->db->query(
				"SELECT fvd.option_value_id, ovd.name as 'option_value_name', od.name as 'option_name' 
			FROM (SELECT option_value_id FROM " . DB_PREFIX . "fc_option_value_to_category WHERE category_id = '" . (int)$category_id . "') fvd
			LEFT JOIN " . DB_PREFIX . "option_value_description ovd ON (fvd.option_value_id = ovd.option_value_id AND ovd.language_id = '" . (int)$this->config->get('config_language_id') . "') 
			LEFT JOIN " . DB_PREFIX . "option_value ov ON (fvd.option_value_id = ov.option_value_id) 
			LEFT JOIN " . DB_PREFIX . "option_description od ON (ov.option_id = od.option_id AND od.language_id = '" . (int)$this->config->get('config_language_id') . "') ORDER BY od.name, ov.sort_order ASC"
			);
		} else {
			$query = $this->db->query(
				"SELECT option_value_id FROM " . DB_PREFIX . "fc_option_value_to_category"
			);
		}

		return $query->rows;
	}

	public function getCategoriesByVal($values) {

		$query = $this->db->query(
			"SELECT ovc.option_value_id, ovc.category_id, c.parent_id FROM (SELECT * FROM " . DB_PREFIX . "fc_option_value_to_category WHERE option_value_id in (" . implode(",", $values) .")) ovc
			 LEFT JOIN oc_fc_category_description cd ON (ovc.category_id = cd.category_id AND cd.language_id='" . (int)$this->config->get('config_language_id') . "')
			 LEFT JOIN oc_fc_category c ON (ovc.category_id = c.category_id AND c.status='1')
			 ORDER BY c.parent_id ASC, c.sort_order ASC"
		);

		$val_by_category = array();

		foreach ($query->rows as $row) {
			$val_by_category[$row['category_id']][] = $row['option_value_id'];
		}

		return $val_by_category;
	}

	public function getAllCategoriesForTree() {
		$query = $this->db->query("SELECT category_id, parent_id FROM  " . DB_PREFIX . "fc_category WHERE status='1' ORDER BY sort_order ASC");

		if   ($query->num_rows > 0){
			$cats = array();
			foreach ($query->rows as $cat) {
				$cats_ID[$cat['category_id']][] = $cat;
				$cats[$cat['parent_id']][$cat['category_id']] =  $cat;
			}
		} else $cats = false;

		return $cats;
	}

	public function getOptionFcr($data){

		$query = $this->db->query("SELECT fcr FROM " . DB_PREFIX . "fc_fcr where product_id = '" . (int)$data['product_id'] . "' AND product_option_id = '" . (int)$data['product_option_id'] . "'");

		if (isset($query->row['fcr']))
			return $query->row['fcr'];
		else {
			return 0;
		}
	}

}