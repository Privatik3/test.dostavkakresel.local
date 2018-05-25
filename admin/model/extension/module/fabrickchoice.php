<?php
class ModelExtensionModuleFabrickchoice extends Model {
	public function install() {

		$this->db->query("
			CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "fc_category` (
            `category_id` int(11) NOT NULL,
            `parent_id` int(11) NOT NULL DEFAULT '0',
            `sort_order` int(3) NOT NULL DEFAULT '0',
            `status` tinyint(1) NOT NULL,
            `date_added` datetime NOT NULL,
            `date_modified` datetime NOT NULL
			) DEFAULT COLLATE=utf8_general_ci;
		");

		$this->db->query("
			CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "fc_category_description` (
            `category_id` int(11) NOT NULL,
            `language_id` int(11) NOT NULL,
            `name` varchar(255) NOT NULL
			) DEFAULT COLLATE=utf8_general_ci;
		");

		$this->db->query("
			CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "fc_option_value_to_category` (
            `option_value_id` int(11) NOT NULL,
            `category_id` int(11) NOT NULL
			) DEFAULT COLLATE=utf8_general_ci;
		");

		$this->db->query("
			CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "fc_category_path` (
            `category_id` int(11) NOT NULL,
            `path_id` int(11) NOT NULL,
            `level` int(11) NOT NULL
			) DEFAULT COLLATE=utf8_general_ci;
		");

		$this->db->query("
			CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "fc_fcr` (
              `product_id` int(11) NOT NULL,
              `product_option_id` int(11) NOT NULL,
              `fcr` int(1) NOT NULL
			) DEFAULT COLLATE=utf8_general_ci;
		");


		$this->db->query("
			ALTER TABLE `" . DB_PREFIX . "fc_category`
            ADD PRIMARY KEY (`category_id`),
            ADD KEY `parent_id` (`parent_id`);
		");

		$this->db->query("
			ALTER TABLE `" . DB_PREFIX . "fc_category_description`
            ADD PRIMARY KEY (`category_id`,`language_id`),
            ADD KEY `name` (`name`);
		");

		$this->db->query("
			ALTER TABLE `" . DB_PREFIX . "fc_option_value_to_category`
            ADD PRIMARY KEY (`option_value_id`,`category_id`),
            ADD KEY `category_id` (`category_id`);
		");

		$this->db->query("
			ALTER TABLE `" . DB_PREFIX . "fc_category`
            MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT;
		");

		$this->db->query("
			ALTER TABLE `" . DB_PREFIX . "fc_category_path`
            ADD PRIMARY KEY (`category_id`,`path_id`);
		");

		$this->db->query("
			ALTER TABLE `" . DB_PREFIX . "fc_fcr`
            ADD PRIMARY KEY (`product_option_id`,`fcr`);
		");

	}

	public function uninstall() {

		$this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "fc_category`");
		$this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "fc_category_description`");
		$this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "fc_option_value_to_category`");
		$this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "fc_category_path`");
		$this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "fc_fcr`");

	}

	public function addCategory($data) {

		$this->db->query("INSERT INTO " . DB_PREFIX . "fc_category SET parent_id = '" . (int)$data['parent_id'] . "', sort_order = '" . (int)$data['sort_order'] . "', status = '" . (int)$data['status'] . "', date_modified = NOW(), date_added = NOW()");

		$category_id = $this->db->getLastId();

		// MySQL Hierarchical Data Closure Table Pattern
		$level = 0;

		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "fc_category_path` WHERE category_id = '" . (int)$data['parent_id'] . "' ORDER BY `level` ASC");

		foreach ($query->rows as $result) {
			$this->db->query("INSERT INTO `" . DB_PREFIX . "fc_category_path` SET `category_id` = '" . (int)$category_id . "', `path_id` = '" . (int)$result['path_id'] . "', `level` = '" . (int)$level . "'");

			$level++;
		}

		$this->db->query("INSERT INTO `" . DB_PREFIX . "fc_category_path` SET `category_id` = '" . (int)$category_id . "', `path_id` = '" . (int)$category_id . "', `level` = '" . (int)$level . "'");


		foreach ($data['category_description'] as $language_id => $value) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "fc_category_description SET category_id = '" . (int)$category_id . "', language_id = '" . (int)$language_id . "', name = '" . $this->db->escape($value['name']) . "'");
		}

		if (isset($data['category_option_values'])){
			foreach (array_unique($data['category_option_values']) as $option_value){
				$this->db->query("INSERT INTO " . DB_PREFIX . "fc_option_value_to_category SET option_value_id = '" . (int)$option_value . "', category_id = '" . (int)$category_id . "'");
			}
		}

		return $category_id;
	}

	public function editCategory($category_id, $data) {

		$this->db->query("UPDATE " . DB_PREFIX . "fc_category SET parent_id = '" . (int)$data['parent_id'] . "', sort_order = '" . (int)$data['sort_order'] . "', status = '" . (int)$data['status'] . "', date_modified = NOW() WHERE category_id = '" . (int)$category_id . "'");

		$this->db->query("DELETE FROM " . DB_PREFIX . "fc_category_description WHERE category_id = '" . (int)$category_id . "'");

		// MySQL Hierarchical Data Closure Table Pattern
		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "category_path` WHERE path_id = '" . (int)$category_id . "' ORDER BY level ASC");

		if ($query->rows) {
			foreach ($query->rows as $fc_category_path) {
				// Delete the path below the current one
				$this->db->query("DELETE FROM `" . DB_PREFIX . "fc_category_path` WHERE category_id = '" . (int)$fc_category_path['category_id'] . "' AND level < '" . (int)$fc_category_path['level'] . "'");

				$path = array();

				// Get the nodes new parents
				$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "fc_category_path` WHERE category_id = '" . (int)$data['parent_id'] . "' ORDER BY level ASC");

				foreach ($query->rows as $result) {
					$path[] = $result['path_id'];
				}

				// Get whats left of the nodes current path
				$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "fc_category_path` WHERE category_id = '" . (int)$fc_category_path['category_id'] . "' ORDER BY level ASC");

				foreach ($query->rows as $result) {
					$path[] = $result['path_id'];
				}

				// Combine the paths with a new level
				$level = 0;

				foreach ($path as $path_id) {
					$this->db->query("REPLACE INTO `" . DB_PREFIX . "fc_category_path` SET category_id = '" . (int)$fc_category_path['category_id'] . "', `path_id` = '" . (int)$path_id . "', level = '" . (int)$level . "'");

					$level++;
				}
			}
		} else {
			// Delete the path below the current one
			$this->db->query("DELETE FROM `" . DB_PREFIX . "fc_category_path` WHERE category_id = '" . (int)$category_id . "'");

			// Fix for records with no paths
			$level = 0;

			$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "fc_category_path` WHERE category_id = '" . (int)$data['parent_id'] . "' ORDER BY level ASC");

			foreach ($query->rows as $result) {
				$this->db->query("INSERT INTO `" . DB_PREFIX . "fc_category_path` SET category_id = '" . (int)$category_id . "', `path_id` = '" . (int)$result['path_id'] . "', level = '" . (int)$level . "'");

				$level++;
			}

			$this->db->query("REPLACE INTO `" . DB_PREFIX . "fc_category_path` SET category_id = '" . (int)$category_id . "', `path_id` = '" . (int)$category_id . "', level = '" . (int)$level . "'");
		}

		foreach ($data['category_description'] as $language_id => $value) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "fc_category_description SET category_id = '" . (int)$category_id . "', language_id = '" . (int)$language_id . "', name = '" . $this->db->escape($value['name']) . "', description = '" . $this->db->escape($value['description']) . "'");    	/* <= natom */
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "fc_option_value_to_category WHERE category_id = '" . (int)$category_id . "'");

		if (isset($data['category_option_values'])){
			foreach (array_unique($data['category_option_values']) as $option_value){
				$this->db->query("INSERT INTO " . DB_PREFIX . "fc_option_value_to_category SET option_value_id = '" . (int)$option_value . "', category_id = '" . (int)$category_id . "'"); 
			}
		}

	}
	

	public function deleteCategory($category_id) {

		$this->db->query("DELETE FROM " . DB_PREFIX . "fc_category_path WHERE category_id = '" . (int)$category_id . "'");

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "fc_category_path WHERE path_id = '" . (int)$category_id . "'");

		foreach ($query->rows as $result) {
			$this->deleteCategory($result['category_id']);
		}
		
		$this->db->query("DELETE FROM " . DB_PREFIX . "fc_category WHERE category_id = '" . (int)$category_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "fc_category_description WHERE category_id = '" . (int)$category_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "fc_option_value_to_category WHERE category_id = '" . (int)$category_id . "'");

	}

	public function repairCategories($parent_id = 0) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "fc_category WHERE parent_id = '" . (int)$parent_id . "'");

		foreach ($query->rows as $category) {
			// Delete the path below the current one
			$this->db->query("DELETE FROM `" . DB_PREFIX . "fc_category_path` WHERE category_id = '" . (int)$category['category_id'] . "'");

			// Fix for records with no paths
			$level = 0;

			$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "fc_category_path` WHERE category_id = '" . (int)$parent_id . "' ORDER BY level ASC");

			foreach ($query->rows as $result) {
				$this->db->query("INSERT INTO `" . DB_PREFIX . "fc_category_path` SET category_id = '" . (int)$category['category_id'] . "', `path_id` = '" . (int)$result['path_id'] . "', level = '" . (int)$level . "'");

				$level++;
			}

			$this->db->query("REPLACE INTO `" . DB_PREFIX . "fc_category_path` SET category_id = '" . (int)$category['category_id'] . "', `path_id` = '" . (int)$category['category_id'] . "', level = '" . (int)$level . "'");

			$this->repairCategories($category['category_id']);
		}
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
		$query = $this->db->query("SELECT *, (SELECT COUNT(parent_id) FROM " . DB_PREFIX . "fc_category WHERE parent_id = c.category_id) AS children FROM " . DB_PREFIX . "fc_category c LEFT JOIN " . DB_PREFIX . "fc_category_description cd ON (c.category_id = cd.category_id) WHERE c.parent_id = '" . (int)$parent_id . "' AND cd.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY c.sort_order, cd.name");

		return $query->rows;
	}

	public function getCategories($data = array()) {
		$sql = "SELECT cp.category_id AS category_id, GROUP_CONCAT(cd1.name ORDER BY cp.level SEPARATOR '&nbsp;&nbsp;&gt;&nbsp;&nbsp;') AS name, c1.parent_id, c1.sort_order, c1.status,(select count(product_id) as product_count from " . DB_PREFIX . "product_to_category pc where pc.category_id = c1.category_id) as product_count FROM " . DB_PREFIX . "fc_category_path cp LEFT JOIN " . DB_PREFIX . "fc_category c1 ON (cp.category_id = c1.category_id) LEFT JOIN " . DB_PREFIX . "fc_category c2 ON (cp.path_id = c2.category_id) LEFT JOIN " . DB_PREFIX . "fc_category_description cd1 ON (cp.path_id = cd1.category_id) LEFT JOIN " . DB_PREFIX . "fc_category_description cd2 ON (cp.category_id = cd2.category_id) WHERE cd1.language_id = '" . (int)$this->config->get('config_language_id') . "' AND cd2.language_id = '" . (int)$this->config->get('config_language_id') . "'";

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
				/* natom */
				'description'             => $result['description']
				/* natom */
			);
		}

		return $category_description_data;
	}

	public function getTotalCategories() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "fc_category");

		return $query->row['total'];
	}

	public function getAllCategories() {

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "fc_category c LEFT JOIN " . DB_PREFIX . "fc_category_description cd ON (c.category_id = cd.category_id) WHERE cd.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY c.parent_id, c.sort_order, cd.name");
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

	public function getCategoriesByValTable($values) {

		$query = $this->db->query(
			"SELECT ovc.option_value_id, ovc.category_id, c.parent_id FROM (SELECT * FROM " . DB_PREFIX . "fc_option_value_to_category WHERE option_value_id in (" . implode(",", $values) .")) ovc
			 LEFT JOIN oc_fc_category_description cd ON (ovc.category_id = cd.category_id AND cd.language_id='" . (int)$this->config->get('config_language_id') . "')
			 LEFT JOIN oc_fc_category c ON (ovc.category_id = c.category_id AND c.status='1')
			 ORDER BY c.parent_id ASC, c.sort_order ASC"
		);

		$results = array();

		foreach ($query->rows as $row) {
			$results[$row['option_value_id']] = $row['category_id'];
		}

		return $results;
	}

	public function getAllCategoriesForTree() {
		$query = $this->db->query("SELECT category_id, parent_id FROM  " . DB_PREFIX . "fc_category ORDER BY sort_order ASC");

		if   ($query->num_rows > 0){
			$cats = array();
			foreach ($query->rows as $cat) {
				$cats_ID[$cat['category_id']][] = $cat;
				$cats[$cat['parent_id']][$cat['category_id']] =  $cat;
			}
		}

		return $cats;
	}

	public function setFcr($data){
		$this->db->query("DELETE FROM " . DB_PREFIX . "fc_fcr WHERE product_id = '" . (int)$data['product_id'] . "'");

		foreach ($data['option'] as $option) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "fc_fcr SET product_id = '" . (int)$data['product_id'] . "', product_option_id = '" . (int)$option['product_option_id'] . "', fcr = '" . (int)$option['fcr'] . "'");
		}

		return $this->db->getLastId();
	}

	public function getOptionFcr($data){

		$query = $this->db->query("SELECT fcr FROM " . DB_PREFIX . "fc_fcr where product_id = '" . (int)$data['product_id'] . "' AND product_option_id = '" . (int)$data['product_option_id'] . "'");

		if (isset($query->row['fcr']))
			return $query->row['fcr'];
		else {
			return 0;
		}
	}

	public function deleteFcr($product_id){
		$this->db->query("DELETE FROM " . DB_PREFIX . "fc_fcr WHERE product_id = '" . (int)$product_id . "'");
		return $this->db->getLastId();
	}

	public function getLastProduct() {
		$query = $this->db->query("SELECT max(product_id) as max FROM " . DB_PREFIX . "product");

		return $query->row['max'];
	}
}