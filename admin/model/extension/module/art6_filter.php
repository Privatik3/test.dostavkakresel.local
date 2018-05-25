<?
class ModelExtensionModuleArt6Filter extends Model {
	public function getTableInfo() {
		$bad = 1;

		$query = $this->db->query("SHOW COLUMNS FROM " . DB_PREFIX . "attribute_description WHERE Field = 'filter'");

		if (!$query->row) $bad = 0;

		$query = $this->db->query("SHOW COLUMNS FROM " . DB_PREFIX . "attribute_description WHERE Field = 'view_filter'");

		if (!$query->row) $bad = 0;

		$installXmlUrl = $_SERVER['DOCUMENT_ROOT'] . "/system/art6_filter.xml";

		if (file_exists($installXmlUrl)) {
			$date_added = date("Y-m-d h:i:s");

			$installXmlContent = file_get_contents($installXmlUrl);

			$query = $this->db->query("SELECT modification_id, xml FROM " . DB_PREFIX . "modification WHERE code = 'art6_filter'");

			if (empty($query->row['xml'])) $bad = 0;
			else $bad = $query->row['modification_id'];
		} else {
			$bad = 0;
		}

		return $bad;
	}

	public function tableUpdate($data, $modification_id) {
		$show_columns = $this->db->query("SHOW COLUMNS FROM " . DB_PREFIX . "attribute WHERE Field = 'filter'");

		if (!$show_columns->row) {
			$query = $this->db->query("ALTER TABLE " . DB_PREFIX . "attribute ADD filter INT(1) NOT NULL DEFAULT '0'");
		}

		$show_columns = $this->db->query("SHOW COLUMNS FROM " . DB_PREFIX . "attribute WHERE Field = 'view_filter'");
		
		if (!$show_columns->row) {
			$query = $this->db->query("ALTER TABLE " . DB_PREFIX . "attribute ADD view_filter VARCHAR(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'C'");
		}

		$installXmlUrl = $_SERVER['DOCUMENT_ROOT'] . "/system/art6_filter.xml";

		if (file_exists($installXmlUrl)) {
			$installXmlContent = file_get_contents($installXmlUrl);

			$query = $this->db->query("INSERT INTO " . DB_PREFIX . "modification SET modification_id = '" . $modification_id . "', name = '" . $this->db->escape($data['text_name']) . "', code = 'art6_filter', author = 'Maxim Mirnov', version = '2.0', link = 'http://art6.ru/', xml = '" . $this->db->escape($installXmlContent) . "', date_added = 'NOW()'");
		} else {
			return $data['error_install_xml'];
		}

		if (!$query) return $data['error_alter_table'];
	}

	public function tableClear() {
		$this->db->query("ALTER TABLE " . DB_PREFIX . "attribute DROP filter");
		$this->db->query("ALTER TABLE " . DB_PREFIX . "attribute DROP view_filter");
		$this->db->query("DELETE FROM " . DB_PREFIX . "modification WHERE code = 'art6_filter'");
	}
}
?>