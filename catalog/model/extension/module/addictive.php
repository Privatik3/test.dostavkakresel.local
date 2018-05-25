<?
class ModelExtensionModuleAddictive extends Model {

	public function getServicesByProduct($product_id){
      $query = $this->db->query('select * from '.DB_PREFIX.'addictive_service where category_id in (select category_id from '.DB_PREFIX.'product_to_category where product_id = '.$product_id.')');
	  return $query->rows;	  
	}
	
	public function getDefaultServices(){
      $query = $this->db->query('select * from '.DB_PREFIX.'addictive_service where category_id = 0 order by _order ASC');
      return $query->rows;	  
	}

}
?>