<?php
class ModelInformationUniNews extends Model {

	public function addNews($data) {
		$this->db->query("INSERT INTO ".DB_PREFIX."uni_news SET status = '".(int)$data['status']."', date_added = '".$this->db->escape($data['date_added'])."'");

		$news_id = $this->db->getLastId();

		if (isset($data['image'])) {
			$this->db->query("UPDATE ".DB_PREFIX."uni_news SET image = '".$this->db->escape($data['image'])."' WHERE news_id = '".(int)$news_id."'");
		}

		foreach ($data['news_description'] as $language_id => $value) {
			$this->db->query("INSERT INTO ".DB_PREFIX."uni_news_description SET news_id = '".(int)$news_id."', language_id = '".(int)$language_id."', title = '".$this->db->escape($value['title'])."', meta_description = '".$this->db->escape($value['meta_description'])."', description = '".$this->db->escape($value['description'])."'");
		}

		if (isset($data['news_store'])) {
			foreach ($data['news_store'] as $store_id) {
				$this->db->query("INSERT INTO ".DB_PREFIX."uni_news_to_store SET news_id = '".(int)$news_id."', store_id = '".(int)$store_id."'");
			}
		}

		if ($data['keyword']) {
			$this->db->query("INSERT INTO ".DB_PREFIX."url_alias SET query = 'news_id=".(int)$news_id."', keyword = '".$this->db->escape($data['keyword'])."'");
		}

		$this->cache->delete('news');
	}

	public function editNews($news_id, $data) {
		$this->db->query("UPDATE ".DB_PREFIX."uni_news SET status = '".(int)$data['status']."' WHERE news_id = '".(int)$news_id."'");
		$this->db->query("UPDATE ".DB_PREFIX."uni_news SET date_added = '".$this->db->escape($data['date_added'])."' WHERE news_id = '".(int)$news_id."'");

		if (isset($data['image'])) {
			$this->db->query("UPDATE ".DB_PREFIX."uni_news SET image = '".$this->db->escape($data['image'])."' WHERE news_id = '".(int)$news_id."'");
		}

		$this->db->query("DELETE FROM ".DB_PREFIX."uni_news_description WHERE news_id = '".(int)$news_id."'");

		foreach ($data['news_description'] as $language_id => $value) {
			$this->db->query("INSERT INTO ".DB_PREFIX."uni_news_description SET news_id = '".(int)$news_id."', language_id = '".(int)$language_id."', title = '".$this->db->escape($value['title'])."', meta_description = '".$this->db->escape($value['meta_description'])."', description = '".$this->db->escape($value['description'])."'");
		}

		$this->db->query("DELETE FROM ".DB_PREFIX."uni_news_to_store WHERE news_id = '".(int)$news_id."'");

		if (isset($data['news_store'])) {
			foreach ($data['news_store'] as $store_id) {
				$this->db->query("INSERT INTO ".DB_PREFIX."uni_news_to_store SET news_id = '".(int)$news_id."', store_id = '".(int)$store_id."'");
			}
		}

		$this->db->query("DELETE FROM ".DB_PREFIX."url_alias WHERE query = 'news_id=".(int)$news_id."'");

		if ($data['keyword']) {
			$this->db->query("INSERT INTO ".DB_PREFIX."url_alias SET query = 'news_id=".(int)$news_id."', keyword = '".$this->db->escape($data['keyword'])."'");
		}

		$this->cache->delete('news');
	}

	public function deleteNews($news_id) {
		$this->db->query("DELETE FROM ".DB_PREFIX."uni_news WHERE news_id = '".(int)$news_id."'");
		$this->db->query("DELETE FROM ".DB_PREFIX."uni_news_description WHERE news_id = '".(int)$news_id."'");
		$this->db->query("DELETE FROM ".DB_PREFIX."uni_news_to_store WHERE news_id = '".(int)$news_id."'");
		$this->db->query("DELETE FROM ".DB_PREFIX."url_alias WHERE query = 'news_id=".(int)$news_id."'");

		$this->cache->delete('news');
	}

	public function resetViews($news_id) {
		$this->db->query("UPDATE ".DB_PREFIX."uni_news SET viewed = '0' WHERE news_id = '".(int)$news_id."'");

		$this->cache->delete('news');
	}

	public function getNewsStory($news_id) {
		$query = $this->db->query("SELECT DISTINCT *, (SELECT keyword FROM ".DB_PREFIX."url_alias WHERE query = 'news_id=".(int)$news_id."') AS keyword FROM ".DB_PREFIX."uni_news n LEFT JOIN ".DB_PREFIX."uni_news_description nd ON (n.news_id = nd.news_id) WHERE n.news_id = '".(int)$news_id."' AND nd.language_id = '".(int)$this->config->get('config_language_id')."'");

		return $query->row;
	}

	public function getNews($data = array()) {
		if ($data) {
			$sql = "SELECT * FROM ".DB_PREFIX."uni_news n LEFT JOIN ".DB_PREFIX."uni_news_description nd ON (n.news_id = nd.news_id) WHERE nd.language_id = '".(int)$this->config->get('config_language_id')."'";

			$sort_data = array(
				'nd.title',
				'n.date_added',
				'n.viewed',
				'n.status'
			);

			if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
				$sql .= " ORDER BY ".$data['sort'];
			} else {
				$sql .= " ORDER BY nd.title";
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

				$sql .= " LIMIT ".(int)$data['start'].",".(int)$data['limit'];
			}

			$query = $this->db->query($sql);

			return $query->rows;

		} else {
			$news_data = $this->cache->get('news.'.(int)$this->config->get('config_language_id'));

			if (!$news_data) {
				$query = $this->db->query("SELECT * FROM ".DB_PREFIX."uni_news n LEFT JOIN ".DB_PREFIX."uni_news_description nd ON (n.news_id = nd.news_id) WHERE nd.language_id = '".(int)$this->config->get('config_language_id')."' ORDER BY nd.title");

				$news_data = $query->rows;

				$this->cache->set('news.'.(int)$this->config->get('config_language_id'), $news_data);
			}

			return $news_data;
		}
	}

	public function getNewsDescriptions($news_id) {
		$news_description_data = array();

		$query = $this->db->query("SELECT * FROM ".DB_PREFIX."uni_news_description WHERE news_id = '".(int)$news_id."'");

		foreach ($query->rows as $result) {
			$news_description_data[$result['language_id']] = array(
				'title'            	=> $result['title'],
				'meta_description' 	=> $result['meta_description'],
				'description'      	=> $result['description']
			);
		}

		return $news_description_data;
	}

	public function getNewsStores($news_id) {
		$newspage_store_data = array();

		$query = $this->db->query("SELECT * FROM ".DB_PREFIX."uni_news_to_store WHERE news_id = '".(int)$news_id."'");

		foreach ($query->rows as $result) {
			$newspage_store_data[] = $result['store_id'];
		}

		return $newspage_store_data;
	}

	public function getTotalNews() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM ".DB_PREFIX."uni_news");

		return $query->row['total'];
	}

	public function checkNews() { 
		$table = $this->db->query("show tables FROM `".DB_DATABASE."` LIKE '".DB_PREFIX."news'");
		$table1 = $this->db->query("show tables FROM `".DB_DATABASE."` LIKE '".DB_PREFIX."uni_news'");
		
		if($table->num_rows && !$table1->num_rows) {
			$this->db->query("RENAME TABLE `".DB_PREFIX."news` TO ".DB_PREFIX."uni_news");
			$this->db->query("RENAME TABLE `".DB_PREFIX."news_description` TO ".DB_PREFIX."uni_news_description");
			$this->db->query("RENAME TABLE `".DB_PREFIX."news_to_store` TO ".DB_PREFIX."uni_news_to_store");
		}
		
		$this->db->query("CREATE TABLE IF NOT EXISTS `".DB_PREFIX."uni_news` (`news_id` int(11) NOT NULL AUTO_INCREMENT, `image` varchar(255) DEFAULT NULL, `date_added` date NOT NULL, `viewed` int(11) NOT NULL DEFAULT '0', `status` tinyint(1) NOT NULL, PRIMARY KEY (`news_id`)) ENGINE=MYISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci");
		$this->db->query("CREATE TABLE IF NOT EXISTS `".DB_PREFIX."uni_news_description` (`news_id` int(11) NOT NULL, `language_id` int(11) NOT NULL, `title` varchar(255) NOT NULL, `meta_description` VARCHAR(255) NOT NULL, `description` text CHARACTER SET utf8 NOT NULL, `keyword` varchar(255) NOT NULL,  PRIMARY KEY (`news_id`,`language_id`)) ENGINE=MYISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci");
		$this->db->query("CREATE TABLE IF NOT EXISTS `".DB_PREFIX."uni_news_to_store` (`news_id` int(11) NOT NULL, `store_id` int(11) NOT NULL, PRIMARY KEY (`news_id`,`store_id`)) ENGINE=MYISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci");
		
		$this->db->query("ALTER TABLE `".DB_PREFIX."product` CHANGE `upc` `upc` varchar(255) COLLATE 'utf8_general_ci' NOT NULL");
		$this->db->query("ALTER TABLE `".DB_PREFIX."product` CHANGE `ean` `ean` varchar(255) COLLATE 'utf8_general_ci' NOT NULL");
		$this->db->query("ALTER TABLE `".DB_PREFIX."product` CHANGE `jan` `jan` varchar(255) COLLATE 'utf8_general_ci' NOT NULL");
		$this->db->query("ALTER TABLE `".DB_PREFIX."product` CHANGE `isbn` `isbn` varchar(255) COLLATE 'utf8_general_ci' NOT NULL");
		$this->db->query("ALTER TABLE `".DB_PREFIX."product` CHANGE `mpn` `mpn` varchar(255) COLLATE 'utf8_general_ci' NOT NULL");
		
		$query = $this->db->query("SELECT layout_id FROM `".DB_PREFIX."layout` WHERE `name` LIKE 'News' LIMIT 1");
		if ($query->num_rows == 0) {
			$this->db->query("INSERT INTO `".DB_PREFIX."layout` SET `name`= 'News'");
		}
		
		$query = $this->db->query("SELECT query FROM `".DB_PREFIX."url_alias` WHERE `keyword` LIKE 'news' LIMIT 1");
		if ($query->num_rows == 0) {
			$this->db->query("INSERT INTO ".DB_PREFIX."url_alias SET query = 'information/uni_news', keyword = 'news'");
		} else {
			$this->db->query("DELETE FROM ".DB_PREFIX."url_alias WHERE keyword = 'news'");
			$this->db->query("INSERT INTO ".DB_PREFIX."url_alias SET query = 'information/uni_news', keyword = 'news'");
		}

		$stores = array(0);

		$sql = "SELECT store_id FROM `".DB_PREFIX."store`";

		$query_store = $this->db->query($sql);

		foreach ($query_store->rows as $store) {
			$stores[] = $store['store_id'];
		}

		$newRoutes = array('information/uni_news');

		foreach ($newRoutes as $newRoute) {
			foreach ($stores as $store_id) {
				$sql = "SELECT layout_id FROM `".DB_PREFIX."layout_route` WHERE `store_id`= '".(int)$store_id."' AND `route` LIKE '".$newRoute."' LIMIT 1";

				$query = $this->db->query($sql);

				if ($query->num_rows == 0) {
					$this->db->query("INSERT INTO `".DB_PREFIX."layout_route` SET `layout_id`= (SELECT layout_id FROM `".DB_PREFIX."layout` WHERE `name` LIKE 'News' LIMIT 1), `store_id`='".(int)$store_id."', `route`='".$newRoute."'");
				}
			}
		}
	}
}
?>