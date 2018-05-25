<?php
class ControllerExtensionFeedOdmproUpdateCSVLink extends Controller {
    
        private $path_oc_version = 'extension/module';
        private $anyxml = FALSE;
        private $anyxls = FALSE;
        private $path_oc_version_feed = 'extension/feed';
    
        public function __construct($registry) {
            $this->registry = $registry;
            $this->getLincenceStatus();
            $this->getAnyXMLStatus();
            $this->getAnyXLStatus();
        }
        
        public function getLincenceStatus() {
            $this->load->model('tool/csv_ocext_dmpro');
            
            $lic = $this->model_tool_csv_ocext_dmpro->getLincenceStatus();
                
            if(!$lic){
                exit("licence key error, pls, send request to support");
            }
        }
        
        public function getAnyXMLStatus() {
            
            $this->load->model('tool/csv_ocext_dmpro');
            
            $this->model_tool_csv_ocext_dmpro->model('tool/csv_ocext_dmpro');
                
            $this->anyxml = $this->ocext_model_tool_csv_ocext_dmpro->getAnyXMLStatus();
            
        }
        
        public function getAnyXLStatus() {
            
            $this->load->model('tool/csv_ocext_dmpro');
            
            $this->model_tool_csv_ocext_dmpro->model('tool/csv_ocext_dmpro');
                
            $this->anyxls = $this->ocext_model_tool_csv_ocext_dmpro->getAnyXLStatus();
            
        }
        
        public function getAnyXLSResult($odmpro_tamplate_data){
            
            $this->load->model('tool/csv_ocext_dmpro');
            
            $this->model_tool_csv_ocext_dmpro->model('tool/csv_ocext_dmpro');

            $result = $this->ocext_model_tool_csv_ocext_dmpro->getAnyXLSResult($odmpro_tamplate_data);

            return $result;

        }

        public function getAnyXMLResult($odmpro_tamplate_data){

            $this->load->model('tool/csv_ocext_dmpro');
            
            $this->model_tool_csv_ocext_dmpro->model('tool/csv_ocext_dmpro');

            $result = $this->ocext_model_tool_csv_ocext_dmpro->getAnyXMLResult($odmpro_tamplate_data);

            return $result;

        }
        
        public function getAnyCSVSincSupplierResult($odmpro_tamplate_data,$status_continuation=0){

            $this->load->model('tool/csv_ocext_dmpro');
            
            $this->model_tool_csv_ocext_dmpro->model('tool/csv_ocext_dmpro');

            $result = $this->ocext_model_tool_csv_ocext_dmpro->getAnyCSVSincSupplierResult($odmpro_tamplate_data,$status_continuation);

            return $result;

        }
    
        public function index() {
            
            $this->load->language($this->path_oc_version.'/csv_ocext_dmpro');
            
            $this->load->model('tool/csv_ocext_dmpro');
            
            $this->model_tool_csv_ocext_dmpro->model('tool/csv_ocext_dmpro');
            
            $config_odmpro_tamplate_data = $this->ocext_model_tool_csv_ocext_dmpro->getSetting('odmpro','odmpro_tamplate_data');
                
            $odmpro_update_csv_link = $this->ocext_model_tool_csv_ocext_dmpro->getSetting('odmpro_update_csv_link','odmpro_update_csv_link');
            
            $token = '';
            
            $json['errors'] = array();
            
            if(isset($this->request->get['token'])){
                
                $token = trim($this->request->get['token']);
                
            }else{
                
                exit($this->language->get('error_no_token'));
                
            }
            
            if($odmpro_update_csv_link && $config_odmpro_tamplate_data){
                
                $update_settings = $odmpro_update_csv_link;
                
                $update_setting = array();
                
                foreach ($update_settings as $setting) {
                    
                    if($setting['token']==$token){

                        $update_setting = $setting;
                        
                        if(!$update_setting['status']){
                            
                            exit($this->language->get('error_status'));
                            
                        }
                        
                        $tamplates_data = $config_odmpro_tamplate_data;
                        
                        $odmpro_tamplate_data = array();
                        
                        if(isset($tamplates_data[$update_setting['tamplate_data_id']])){
                            
                            $odmpro_tamplate_data = $tamplates_data[$update_setting['tamplate_data_id']];
                            
                        }
                        
                        $odmpro_tamplate_data['file_upload_this']='';
                        
                        if(isset($this->request->get['file_upload_this'])){

                            $odmpro_tamplate_data['file_upload_this'] = $this->request->get['file_upload_this'];

                        }
                        
                        if(!$odmpro_tamplate_data['file_upload_this'] && $odmpro_tamplate_data && !isset($this->request->get['start']) && $this->anyxml && isset($odmpro_tamplate_data['anyxml_xml_upload']) && $odmpro_tamplate_data['anyxml_xml_upload']){
                            
                            $any_XML_result = $this->getAnyXMLResult($odmpro_tamplate_data);

                            if(isset($any_XML_result['error']) && $any_XML_result['error']){

                                $json['errors'][] = $any_XML_result['error'];

                            }else{

                                $odmpro_tamplate_data['file_url'] = '';

                                $odmpro_tamplate_data['file_upload'] = $any_XML_result['file_upload'];

                                $odmpro_tamplate_data['new_file_upload'] = '';
                                
                                $odmpro_tamplate_data['file_upload_this'] = $any_XML_result['file_upload'];

                            }
                            
                        }
                        
                        if(!$odmpro_tamplate_data['file_upload_this'] && $odmpro_tamplate_data && !isset($this->request->get['start']) && $this->anyxls && isset($odmpro_tamplate_data['anyxls_xls_upload']) && $odmpro_tamplate_data['anyxls_xls_upload']){
                            
                            $any_XLS_result = $this->getAnyXLSResult($odmpro_tamplate_data);

                            if(isset($any_XLS_result['error']) && $any_XLS_result['error']){

                                $json['errors'][] = $any_XLS_result['error'];

                            }else{

                                $odmpro_tamplate_data['file_url'] = '';

                                $odmpro_tamplate_data['file_upload'] = $any_XLS_result['file_upload'];

                                $odmpro_tamplate_data['new_file_upload'] = '';
                                
                                $odmpro_tamplate_data['file_upload_this'] = $any_XLS_result['file_upload'];

                            }
                            
                        }
                        
                        if(!$odmpro_tamplate_data['file_upload_this'] && isset($odmpro_tamplate_data['anycsv_sinch_supplier_setting_id']) && $odmpro_tamplate_data['anycsv_sinch_supplier_setting_id']){
                    
                            $any_CSV_Sinc_Supplier_result = $this->getAnyCSVSincSupplierResult($odmpro_tamplate_data);

                            if(isset($any_CSV_Sinc_Supplier_result['file_upload']) && $any_CSV_Sinc_Supplier_result['file_upload']){

                                $odmpro_tamplate_data['file_url'] = '';
                                
                                $odmpro_tamplate_data['file_upload'] = $any_CSV_Sinc_Supplier_result['file_upload'];
                                
                                $odmpro_tamplate_data['file_upload_this'] = $any_CSV_Sinc_Supplier_result['file_upload'];

                                $odmpro_tamplate_data['new_file_upload'] = '';

                            }elseif(isset($any_CSV_Sinc_Supplier_result['error']) && $any_CSV_Sinc_Supplier_result['error']){

                                $json['errors'][] = $any_CSV_Sinc_Supplier_result['error'];

                            }

                        }
                        
                        if($json['errors']){
                            
                            echo json_encode($json);
                            
                            exit();
                            
                        }
                        
                        if($odmpro_tamplate_data){
                            
                            $this->request->post['odmpro_tamplate_data'] = $odmpro_tamplate_data;
                            
                            if(!isset($this->request->get['start'])){

                                $this->request->get['start'] = $odmpro_tamplate_data['start'];
                                
                                $this->request->get['first_row'] = 1;
                                

                            }else{
                                
                                $this->request->get['first_row'] = 0;
                                
                            }
                            
                            if(!isset($this->request->get['num_process'])){

                                $this->request->get['num_process'] = time();

                            }
                            
                            $this->request->post['type_process'] = 'write file';
                            
                            if(isset($this->request->get['export']) && $this->request->get['export']){
                                
                                $this->startExport();
                                
                            }else{
                                
                                $this->startImport();
                                
                            }
                            
                        }else{
                            
                            exit($this->language->get('error_template_data'));
                            
                        }
                        
                    }
                    
                }
                
                if(!$update_setting){
                    
                    exit($this->language->get('error_no_token'));
                    
                }
                
            }else{
                
                exit($this->language->get('error_no_odmpro_update_csv_link'));
                
            }
            
        }
        
        private function checkCURL(){
            
            if(function_exists('curl_version')){
                
                return TRUE;
                
            }else{
                
                return FALSE;
                
            }
        }
        
        public function startImport() {
            
            $format_data = $this->request->post['odmpro_tamplate_data']['format_data'];
            
            $odmpro_tamplate_data = $this->request->post['odmpro_tamplate_data'];
            
            $type_process = $this->request->post['type_process'];
            
            $type_change = $odmpro_tamplate_data['type_change'];
            
            $this->load->model('tool/csv_ocext_dmpro');
                
            $this->load->language($this->path_oc_version.'/csv_ocext_dmpro');
            
            $start = $this->request->get['start'];
            
            $limit = $this->request->post['odmpro_tamplate_data']['limit'];
            
            if($limit < 300){
                
                $limit = 300;
                
            }
            
            $num_process = $this->request->get['num_process'];
            
            $log_data = array(
                'start' => $start,
                'limit' => $limit,
                'num_process'   => $num_process,
                'type_process'  => $type_process,
                'format_data'   => $format_data
            );
            
            $json['error'] = '';
            
            if(!isset($odmpro_tamplate_data['type_data'])){
                
                $json['error'] .= $this->language->get('import_error_no_type_data');
                
                $log_data['__line__'] = __LINE__;
                
                $log_error = $this->ocext_model_tool_csv_ocext_dmpro = writeLog('preparation_'.$type_process,array('error'=>$this->language->get('import_error_no_type_data')),$odmpro_tamplate_data,$log_data);
                
                if($log_error){
                    
                    $json['error'] .= $log_error;
                    
                }
                
                echo json_encode($json);
                
                return;
                
            }
            
            /*
             * проверяем есть ли колонки файла для импорта
             */
            $type_data_columns = FALSE;
            
            foreach ($odmpro_tamplate_data['type_data'] as $field => $type_data) {
                
                if($type_data){
                    
                    $type_data_columns = TRUE;
                    
                }
                
            }
            
            if(!$type_data_columns){
                
                $json['error'] .= $this->language->get('import_error_no_type_data');
                
                $log_data['__line__'] = __LINE__;
                
                $log_error = $this->ocext_model_tool_csv_ocext_dmpro->writeLog('preparation_'.$type_process,array('error'=>$this->language->get('import_error_no_type_data')),$odmpro_tamplate_data,$log_data);
                
                if($log_error){
                    
                    $json['error'] .= $log_error;
                    
                }
                
                echo json_encode($json);
                
                return;
                
            }
            
            if(!$type_change){
                
                $json['error'] .= $this->language->get('entry_type_change_error');
                
                $log_data['__line__'] = __LINE__;
                
                $log_error = $this->ocext_model_tool_csv_ocext_dmpro->writeLog('preparation_'.$type_process,array('error'=>$this->language->get('entry_type_change_error')),$odmpro_tamplate_data,$log_data);
                
                if($log_error){
                    
                    $json['error'] .= $log_error;
                    
                }
                
                echo json_encode($json);
                
                return;
                
            }
            
            
            /*
             * Данные разбираем с учетом принадложености к основному типу: товары, к товарам, категории к категориям и т.п.
             */
            $type_data_columns_by_type_data = array();
            
            foreach ($odmpro_tamplate_data['type_data'] as $field => $type_data) {
                
                if($type_data && $field && isset($odmpro_tamplate_data['type_data_column'][$field]) && $odmpro_tamplate_data['type_data_column'][$field]['db_table___db_column']){
                    
                    $type_data_columns_by_type_data[$type_data]['column_settings'][$field] = $odmpro_tamplate_data['type_data_column'][$field];
                    
                    $type_data_columns_by_type_data[$type_data]['general_settings'] = array();
                    
                    if(isset($odmpro_tamplate_data['type_data_general_settings'][$type_data]) && $odmpro_tamplate_data['type_data_general_settings'][$type_data]){
                        
                        $type_data_columns_by_type_data[$type_data]['general_settings'] = $odmpro_tamplate_data['type_data_general_settings'][$type_data];
                        
                    }
                    
                }
                
            }
            
            
            if(!$type_data_columns_by_type_data){
                
                $json['error'] .= $this->language->get('import_error_no_type_data');
                
                $log_data['__line__'] = __LINE__;
                
                $log_error = $this->ocext_model_tool_csv_ocext_dmpro->writeLog('preparation_'.$type_process,array('error'=>$this->language->get('import_error_no_type_data')),$odmpro_tamplate_data,$log_data);
                
                if($log_error){
                    
                    $json['error'] .= $log_error;
                    
                }
                
                echo json_encode($json);
                
                return;
                
            }
            
            /*
             * Проходим по всем типам, проверяем настройки по каждому типу на основные ошибки, без которых невозможен обмен данными
             */
            
            foreach ($type_data_columns_by_type_data as $type_data => $settings) {
                
                if($type_change=='update_data' || $type_change=='only_update_data' || $type_change=='only_new_data'){
                    
                    $identificator = FALSE;
                    
                    foreach ($settings['column_settings'] as $field => $setting) {
                        
                        $db_column_or_advanced_column_name_parts = explode('___', $setting['db_table___db_column']);
                        
                        $db_column_or_advanced_column_name = $db_column_or_advanced_column_name_parts[1];
                        
                        if($db_column_or_advanced_column_name=='identificator'){
                            
                            $identificator = TRUE;
                            
                            /*
                             * Идентификаторов может быть несколько, например, ошибочно или для поиска хотя бы одного
                             */
                            
                            $type_data_columns_by_type_data[$type_data]['identificator'][$field] = array(
                                'field'=>$field,
                                'additinal_settings'=>$setting['additinal_settings'],
                                'identificator_type'=>$setting['additinal_settings']['identificator_type'],
                            );
                            
                        }
                        
                    }
                    
                    if(!$identificator){
                
                        $json['error'] .= sprintf($this->language->get('import_error_no_identificator'),$type_data,$type_data); 

                        $log_data['__line__'] = __LINE__; 

                        $log_error = $this->ocext_model_tool_csv_ocext_dmpro->writeLog('preparation_'.$type_process,array('error'=>sprintf($this->language->get('import_error_no_identificator'),$type_data,$type_data)),$odmpro_tamplate_data,$log_data);

                        if($log_error){

                            $json['error'] .= $log_error;

                        }

                        echo json_encode($json);

                        return;

                    }
                    
                }
                
                foreach ($settings['column_settings'] as $field => $setting) {
                        
                    $db_column_or_advanced_column_name_parts = explode('___', $setting['db_table___db_column']);

                    $db_column_or_advanced_column_name = $db_column_or_advanced_column_name_parts[1];

                    if($db_column_or_advanced_column_name=='image_advanced' && isset($setting['additinal_settings']['image_upload']) && $setting['additinal_settings']['image_upload']){
                        
                        $check_curl = $this->checkCURL();
                
                        if(!$check_curl){

                            $json['error'] .= '<p>'.$this->language->get('entry_curl_exits').'</p>'; 
                            
                            $log_data['__line__'] = __LINE__; 

                            $log_error = $this->ocext_model_tool_csv_ocext_dmpro->writeLog('preparation_'.$type_process,array('error'=>$this->language->get('entry_curl_exits')),$odmpro_tamplate_data,$log_data);

                            if($log_error){

                                $json['error'] .= $log_error;

                            }

                            echo json_encode($json);

                            return;

                        }

                    }

                }
                
            }
            
            if (!$odmpro_tamplate_data['csv_enclosure']) {
                
                $json['error'] .= '<p>'.$this->language->get('import_error_no_csv_enclosure').'</p>'; 
                
                $log_data['__line__'] = __LINE__; 

                $log_error = $this->ocext_model_tool_csv_ocext_dmpro->writeLog('preparation_'.$type_process,array('error'=>$this->language->get('import_error_no_csv_enclosure')),$odmpro_tamplate_data,$log_data);

                if($log_error){

                    $json['error'] .= $log_error;

                }

                echo json_encode($json);

                return;
                
            }
            
            if (!$odmpro_tamplate_data['language_id']) {
                
                $json['error'] .= '<p>'.$this->language->get('import_error_no_language_id').'</p>'; 
                
                $log_data['__line__'] = __LINE__; 

                $log_error = $this->ocext_model_tool_csv_ocext_dmpro->writeLog('preparation_'.$type_process,array('error'=>$this->language->get('import_error_no_language_id')),$odmpro_tamplate_data,$log_data);

                if($log_error){

                    $json['error'] .= $log_error;

                }

                echo json_encode($json);

                return;
                
            }
            
            if (!$odmpro_tamplate_data['csv_delimiter']) {
                
                $json['error'] .= '<p>'.$this->language->get('import_error_no_csv_delimiter').'</p>'; 
                
                $log_data['__line__'] = __LINE__; 

                $log_error = $this->ocext_model_tool_csv_ocext_dmpro->writeLog('preparation_'.$type_process,array('error'=>$this->language->get('import_error_no_csv_delimiter')),$odmpro_tamplate_data,$log_data);

                if($log_error){

                    $json['error'] .= $log_error;

                }

                echo json_encode($json);

                return;
                
            }
            
            if (!isset($odmpro_tamplate_data['store_id'])) {
                
                $json['error'] .= '<p>'.$this->language->get('import_error_no_store_id').'</p>'; 
                
                $log_data['__line__'] = __LINE__; 

                $log_error = $this->ocext_model_tool_csv_ocext_dmpro->writeLog('preparation_'.$type_process,array('error'=>$this->language->get('import_error_no_store_id')),$odmpro_tamplate_data,$log_data);

                if($log_error){

                    $json['error'] .= $log_error;

                }

                echo json_encode($json);

                return;
                
            } 
            
            $file = '';
            
            //$this->request->get['file_upload_this']
            
            if(isset($odmpro_tamplate_data['file_upload_this']) && $odmpro_tamplate_data['file_upload_this']){
                
                $file = $this->ocext_model_tool_csv_ocext_dmpro->getFileByFileName($odmpro_tamplate_data['file_upload_this']);
                
            }elseif(isset($odmpro_tamplate_data['new_file_upload']) && $odmpro_tamplate_data['new_file_upload']){
                
                $file = $this->ocext_model_tool_csv_ocext_dmpro->getFileByFileName($odmpro_tamplate_data['new_file_upload']);
                
            }elseif($odmpro_tamplate_data['file_url'] && $odmpro_tamplate_data['file_url']){
                
                $file = $this->ocext_model_tool_csv_ocext_dmpro->getFileByURL($odmpro_tamplate_data['file_url']);
                
            }elseif($odmpro_tamplate_data['file_upload']){
                
                $file = $this->ocext_model_tool_csv_ocext_dmpro->getFileByFileName($odmpro_tamplate_data['file_upload']);
                
            }
            
            if(!$file){
                
                $json['error'] .= '<p>'.$this->language->get('entry_file_exits').'</p>'; 
                
                $log_data['__line__'] = __LINE__; 

                $log_error = $this->ocext_model_tool_csv_ocext_dmpro->writeLog('preparation_'.$type_process,array('error'=>$this->language->get('entry_file_exits')),$odmpro_tamplate_data,$log_data);

                if($log_error){

                    $json['error'] .= $log_error;

                }

                echo json_encode($json);

                return;
                
            }
            
            
            $json['success'] = '';
            
            $import_result['count_rows'] = 0;
            
            if(!$json['error']){
                
                /*
                 * +1 сдвигаемся с заголовков полей
                 */
                $import_result = $this->ocext_model_tool_csv_ocext_dmpro->getCsvRows($file,$start,$limit,$odmpro_tamplate_data);
                
                $this->ocext_model_tool_csv_ocext_dmpro->importCSV($odmpro_tamplate_data,$type_data_columns_by_type_data,$import_result,$log_data);
                
            }
            
            $json['total'] = $import_result['count_rows'];
            
            if(!$json['error'] && (($start+$limit)>$import_result['count_rows'] && $import_result['count_rows']>0)){
                
                $json['success'] = $this->language->get('write_success_accomplished');
                
                $log_data['__line__'] = __LINE__; 

                $log_error = $this->ocext_model_tool_csv_ocext_dmpro->writeLog(''.$type_process,array('success'=>$this->language->get('write_success_accomplished')),$odmpro_tamplate_data,$log_data);
                
            } 
            
            elseif (!$json['error'] && $import_result['count_rows']>0 && ($start+$limit)<=$import_result['count_rows']) {
                
                $this->response->redirect($this->url->link($this->path_oc_version_feed.'/odmpro_update_csv_link', 'start='.($start+$limit).'&num_process='.$num_process.'&token=' . $this->request->get['token'].'&file_upload_this='.$odmpro_tamplate_data['file_upload_this']));
                
            }
            
            if($json['error']){
                echo $json['error'];
            }elseif ($json['success']) {
                echo $json['success'];
            }
            
            exit();
            
        }
        
        
        public function startExport() {
            
            $format_data = $this->request->post['odmpro_tamplate_data']['format_data'];
            
            $odmpro_tamplate_data = $this->request->post['odmpro_tamplate_data'];
            
            $type_process = $this->request->post['type_process'];
            
            $this->load->model('tool/csv_ocext_dmpro');
                
            $this->load->language($this->path_oc_version.'/csv_ocext_dmpro');
            
            $start = (int)$this->request->get['start'];
            
            $limit = (int)$this->request->post['odmpro_tamplate_data']['limit'];
            
            if($limit < 200){
                
                $limit = 200;
                
            }
            
            $num_process = $this->request->get['num_process'];
            
            $log_data = array(
                'start' => $start,
                'limit' => $limit,
                'num_process'   => $num_process,
                'type_process'  => $type_process,
                'format_data'   => $format_data,
                'file_url'   => '',
                'file_upload'   => $odmpro_tamplate_data['export_file_name'],
            );
            
            $json['error'] = '';
            
            if(!isset($odmpro_tamplate_data['type_data'])){
                
                $json['error'] .= $this->language->get($type_process.'_error_no_type_data');
                
                $log_data['__line__'] = __LINE__;
                
                $log_error = $this->ocext_model_tool_csv_ocext_dmpro->writeLog('preparation_'.$type_process,array('error'=>$this->language->get($type_process.'_error_no_type_data')),$odmpro_tamplate_data,$log_data);
                
                if($log_error){
                    
                    $json['error'] .= $log_error;
                    
                }
                
                echo json_encode($json);
                
                return;
                
            }
            
            $type_data_columns = FALSE;
            
            foreach ($odmpro_tamplate_data['type_data'] as $field => $type_data) {
                
                if($type_data){
                    
                    $type_data_columns = TRUE;
                    
                }
                
            }
            
            if(!$type_data_columns){
                
                $json['error'] .= $this->language->get($type_process.'_error_no_type_data');
                
                $log_data['__line__'] = __LINE__;
                
                $log_error = $this->ocext_model_tool_csv_ocext_dmpro->writeLog('preparation_'.$type_process,array('error'=>$this->language->get($type_process.'_error_no_type_data')),$odmpro_tamplate_data,$log_data);
                
                if($log_error){
                    
                    $json['error'] .= $log_error;
                    
                }
                
                echo json_encode($json);
                
                return;
                
            }
            
            $type_data_columns_by_type_data = array();
            
            foreach ($odmpro_tamplate_data['type_data'] as $field => $type_data) {
                
                if($type_data && $field && isset($odmpro_tamplate_data['type_data_column'][$field]) && $odmpro_tamplate_data['type_data_column'][$field]['db_table___db_column']){
                    
                    $type_data_columns_by_type_data[$type_data]['column_settings'][$field] = $odmpro_tamplate_data['type_data_column'][$field];
                    
                    $type_data_columns_by_type_data[$type_data]['general_settings'] = array();
                    
                    if(isset($odmpro_tamplate_data['type_data_general_settings'][$type_data]) && $odmpro_tamplate_data['type_data_general_settings'][$type_data]){
                        
                        $type_data_columns_by_type_data[$type_data]['general_settings'] = $odmpro_tamplate_data['type_data_general_settings'][$type_data];
                        
                    }
                    
                }
                
            }
            
            if(!$type_data_columns_by_type_data){
                
                $json['error'] .= $this->language->get($type_process.'_error_no_type_data');
                
                $log_data['__line__'] = __LINE__;
                
                $log_error = $this->ocext_model_tool_csv_ocext_dmpro->writeLog('preparation_'.$type_process,array('error'=>$this->language->get($type_process.'_error_no_type_data')),$odmpro_tamplate_data,$log_data);
                
                if($log_error){
                    
                    $json['error'] .= $log_error;
                    
                }
                
                echo json_encode($json);
                
                return;
                
            }else{
                
                foreach ($type_data_columns_by_type_data as $type_data => $settings) {
                    
                    foreach ($settings['column_settings'] as $field => $setting) {
                        
                        $db_column_or_advanced_column_name_parts = explode('___', $setting['db_table___db_column']);
                        
                        $db_column_or_advanced_column_name = $db_column_or_advanced_column_name_parts[1];
                        
                        if($db_column_or_advanced_column_name=='identificator'){
                            
                            $type_data_columns_by_type_data[$type_data]['identificator'][$field] = array(
                                'field'=>$field,
                                'additinal_settings'=>$setting['additinal_settings'],
                                'identificator_type'=>$setting['additinal_settings']['identificator_type'],
                            );
                            
                        }
                        
                    }
                    
                }
                
            }
            
            /*
            
            $json['success'] = "Экспорт в данной версии будет доступен в обновлении от 15.01.2017 г.";

            echo json_encode($json);
            
            exit();
            
             * 
             */
            
            if (!$odmpro_tamplate_data['csv_enclosure']) {
                
                $json['error'] .= '<p>'.$this->language->get('import_error_no_csv_enclosure').'</p>'; 
                
                $log_data['__line__'] = __LINE__; 

                $log_error = $this->ocext_model_tool_csv_ocext_dmpro->writeLog('preparation_'.$type_process,array('error'=>$this->language->get('import_error_no_csv_enclosure')),$odmpro_tamplate_data,$log_data);

                if($log_error){

                    $json['error'] .= $log_error;

                }

                echo json_encode($json);

                return;
                
            }
            
            if (!$odmpro_tamplate_data['language_id']) {
                
                $json['error'] .= '<p>'.$this->language->get('import_error_no_language_id').'</p>'; 
                
                $log_data['__line__'] = __LINE__; 

                $log_error = $this->ocext_model_tool_csv_ocext_dmpro->writeLog('preparation_'.$type_process,array('error'=>$this->language->get('import_error_no_language_id')),$odmpro_tamplate_data,$log_data);

                if($log_error){

                    $json['error'] .= $log_error;

                }

                echo json_encode($json);

                return;
                
            }
            
            if (!$odmpro_tamplate_data['csv_delimiter']) {
                
                $json['error'] .= '<p>'.$this->language->get('import_error_no_csv_delimiter').'</p>'; 
                
                $log_data['__line__'] = __LINE__; 

                $log_error = $this->ocext_model_tool_csv_ocext_dmpro->writeLog('preparation_'.$type_process,array('error'=>$this->language->get('import_error_no_csv_delimiter')),$odmpro_tamplate_data,$log_data);

                if($log_error){

                    $json['error'] .= $log_error;

                }

                echo json_encode($json);

                return;
                
            }
            
            if (!isset($odmpro_tamplate_data['store_id'])) {
                
                $json['error'] .= '<p>'.$this->language->get('import_error_no_store_id').'</p>'; 
                
                $log_data['__line__'] = __LINE__; 

                $log_error = $this->ocext_model_tool_csv_ocext_dmpro->writeLog('preparation_'.$type_process,array('error'=>$this->language->get('import_error_no_store_id')),$odmpro_tamplate_data,$log_data);

                if($log_error){

                    $json['error'] .= $log_error;

                }

                echo json_encode($json);

                return;
                
            } 
            
            $file = FALSE;
            
            if($odmpro_tamplate_data['export_file_name'] && $odmpro_tamplate_data['export_file_name']){
                
                $file = trim($odmpro_tamplate_data['export_file_name']);
                
            }
            
            if(!$file){
                
                $json['error'] .= '<p>'.$this->language->get('entry_file_exits_export').'</p>'; 
                
                $log_data['__line__'] = __LINE__; 

                $log_error = $this->ocext_model_tool_csv_ocext_dmpro->writeLog('preparation_'.$type_process,array('error'=>$this->language->get('entry_file_exits_export')),$odmpro_tamplate_data,$log_data);

                if($log_error){

                    $json['error'] .= $log_error;

                }

                echo json_encode($json);

                return;
                
            }
            
            $json['success'] = '';
            
            $result['count_rows'] = 0;
            
            if($format_data=='csv' && !$json['error']){
                
                $result = $this->ocext_model_tool_csv_ocext_dmpro->exportCSV($odmpro_tamplate_data,$type_data_columns_by_type_data,$log_data);
                
            }
            
            $json['total'] = $result['count_rows'];
            
            if(($start+$limit)>$result['count_rows'] && $result['count_rows']>0){
                
                $json['success'] = $this->language->get('import_success_accomplished');
                
                $log_data['__line__'] = __LINE__; 

                $log_error = $this->ocext_model_tool_csv_ocext_dmpro->writeLog($type_process,array('success'=>$this->language->get('import_success_accomplished')),$odmpro_tamplate_data,$log_data);
                
            }elseif(!$result['count_rows']){
                
                $json['error'] = $this->language->get('export_empty_data');
                
                $log_data['__line__'] = __LINE__; 

                $log_error = $this->ocext_model_tool_csv_ocext_dmpro->writeLog($type_process,array('error'=>$this->language->get('export_empty_data')),$odmpro_tamplate_data,$log_data);
                
            }
            
            if(!$json['error'] && (($start+$limit)>$result['count_rows'] && $result['count_rows']>0)){
                
                $json['success'] = $this->language->get('write_success_accomplished');
                
                $log_data['__line__'] = __LINE__; 

                $log_error = $this->ocext_model_tool_csv_ocext_dmpro->writeLog(''.$type_process,array('success'=>$this->language->get('write_success_accomplished')),$odmpro_tamplate_data,$log_data);
                
            } 
            
            elseif (!$json['error'] && $result['count_rows']>0 && ($start+$limit)<=$result['count_rows']) {
                
                $this->response->redirect($this->url->link($this->path_oc_version_feed.'/odmpro_update_csv_link', 'start='.($start+$limit).'&export=1&num_process='.$num_process.'&token=' . $this->request->get['token']));
                
            }
            
            if($json['error']){
                echo $json['error'];
            }elseif ($json['success']) {
                echo $json['success'];
            }
            
            exit();
        }
        
        
        public function startImport______last() {
            
            
            $this->load->language($this->path_oc_version.'/csv_ocext_dmpro');
            
            if(!isset($this->request->get['token'])){
                
                exit($this->language->get('error_no_token'));
                
            }
            
            
            $format_data = $this->request->post['odmpro_tamplate_data']['format_data'];
            
            $odmpro_tamplate_data = $this->request->post['odmpro_tamplate_data'];
            
            $import_data_types = array();
            
            $attribute_or_filter = '';
            
            if($format_data=='csv'){
                
                $this->load->model('tool/csv_ocext_dmpro');
                
                $this->load->language($this->path_oc_version.'/csv_ocext_dmpro');
                
            }
            
            foreach ($odmpro_tamplate_data['type_data'] as $field => $type_data) {
                
                $field = trim($field);
                
                if($type_data && $field){
                    
                    $import_data_types[$field]['type_data'] = $type_data;
                    
                    if($type_data=='attribute' || $type_data=='filter'){
                        
                        $attribute_or_filter = $type_data;
                        
                    }
                    
                    if(isset($odmpro_tamplate_data['type_data_column'][$field]) && $odmpro_tamplate_data['type_data_column'][$field]){
                        
                        $type_data_column = $odmpro_tamplate_data['type_data_column'][$field];
                        
                        $import_data_types[$field]['type_data_column'] = $type_data_column;
                        
                        if(isset($odmpro_tamplate_data['type_data_column_image'][$field][$type_data_column]) && $odmpro_tamplate_data['type_data_column_image'][$field][$type_data_column]){
                            
                            $import_data_types[$field]['type_data_column_image_upload'] = 1;
                            
                        }else{
                            
                            $import_data_types[$field]['type_data_column_image_upload'] = 0;
                            
                        }
                        
                        if(isset($odmpro_tamplate_data['type_data_column_price_rate'][$field][$type_data_column]) && $odmpro_tamplate_data['type_data_column_price_rate'][$field][$type_data_column]){
                            
                            $price_rate = $this->getFloat($odmpro_tamplate_data['type_data_column_price_rate'][$field][$type_data_column]);
                            
                            $import_data_types[$field]['type_data_column_price_rate'] = $price_rate;
                            
                        }else{
                            
                            $import_data_types[$field]['type_data_column_price_rate'] = 0;
                            
                        }
                        
                        if(isset($odmpro_tamplate_data['type_data_column_price_delta'][$field][$type_data_column]) && $odmpro_tamplate_data['type_data_column_price_delta'][$field][$type_data_column]){
                            
                            $price_delta = $this->getFloat($odmpro_tamplate_data['type_data_column_price_delta'][$field][$type_data_column]);
                            
                            $import_data_types[$field]['type_data_column_price_delta'] = $price_delta;
                            
                        }else{
                            
                            $import_data_types[$field]['type_data_column_price_delta'] = 0;
                            
                        }
                        
                        if(isset($odmpro_tamplate_data['type_data_column_price_around'][$field][$type_data_column]) && $odmpro_tamplate_data['type_data_column_price_around'][$field][$type_data_column]){
                            
                            $import_data_types[$field]['type_data_column_price_around'] = 1;
                            
                        }else{
                            
                            $import_data_types[$field]['type_data_column_price_around'] = 0;
                            
                        }
                        
                        if(isset($odmpro_tamplate_data['type_data_column_quantity_request'][$field][$type_data_column]) && $odmpro_tamplate_data['type_data_column_quantity_request'][$field][$type_data_column]){
                            
                            $import_data_types[$field]['type_data_column_quantity_request'] = $odmpro_tamplate_data['type_data_column_quantity_request'][$field][$type_data_column];
                            
                        }else{
                            
                            $import_data_types[$field]['type_data_column_quantity_request'] = 0;
                            
                        }
                        
                        if(isset($odmpro_tamplate_data['type_data_column_quantity_update'][$field][$type_data_column]) && $odmpro_tamplate_data['type_data_column_quantity_update'][$field][$type_data_column]){
                            
                            $import_data_types[$field]['type_data_column_quantity_update'] = (int)$odmpro_tamplate_data['type_data_column_quantity_update'][$field][$type_data_column];
                            
                        }else{
                            
                            $import_data_types[$field]['type_data_column_quantity_update'] = 0;
                            
                        }
                        
                        if(isset($odmpro_tamplate_data['type_data_column_request'][$field][$type_data_column]) && $odmpro_tamplate_data['type_data_column_request'][$field][$type_data_column]){
                            
                            $import_data_types[$field]['type_data_column_request'] = 1;
                            
                        }else{
                            
                            $import_data_types[$field]['type_data_column_request'] = 0;
                            
                        }
                        
                        if(isset($odmpro_tamplate_data['type_data_column_delimiter'][$field][$type_data_column]) && $odmpro_tamplate_data['type_data_column_delimiter'][$field][$type_data_column]){
                            
                            $import_data_types[$field]['type_data_column_delimiter'] = trim($odmpro_tamplate_data['type_data_column_delimiter'][$field][$type_data_column]);
                            
                        }else{
                            
                            $import_data_types[$field]['type_data_column_delimiter'] = '';
                            
                        }
                        /*
                        if(isset($odmpro_tamplate_data['type_data_column_attribute_values_delimiter'][$field][$type_data_column]) && $odmpro_tamplate_data['type_data_column_attribute_values_delimiter'][$field][$type_data_column]){
                            
                            $import_data_types[$field]['type_data_column_attribute_values_delimiter'] = trim($odmpro_tamplate_data['type_data_column_attribute_values_delimiter'][$field][$type_data_column]);
                            
                        }else{
                            
                            $import_data_types[$field]['type_data_column_attribute_values_delimiter'] = '';
                            
                        }
                         * 
                         */
                        
                        $import_data_types[$field]['type_data_column_group_identificator'] = array();
                        
                        if(isset($odmpro_tamplate_data['type_data_column_group_identificator']) && $odmpro_tamplate_data['type_data_column_group_identificator']){
                            
                            foreach ($odmpro_tamplate_data['type_data_column_group_identificator'] as $type_identificator => $identificator) {
                                
                                if(isset($identificator[$field][$type_data_column]) && $identificator[$field][$type_data_column]){
                                    
                                    $type_identificator_parts = explode('_', $type_identificator);
                                    
                                    if(end($type_identificator_parts)=='field'){
                                        
                                        $type_identificator = 'field';
                                        
                                    }
                                    
                                    $import_data_types[$field]['type_data_column_group_identificator']['type_group_identificator'] = $type_identificator;
                                    
                                    $import_data_types[$field]['type_data_column_group_identificator']['value_group_identificator'] = $identificator[$field][$type_data_column];
                                    
                                }
                                
                            }
                            
                        }
                        
                        $column = explode('___', $type_data_column);
                        
                        $import_data_types[$field]['column'] = $column[1];
                        
                        $check_column = $this->ocext_model_tool_csv_ocext_dmpro->getColumnIntoAbstractField($column[1],$column[0]);
                        
                        $table_descriptiom = '';
                        
                        //для имен нужно создать таблицу _description
                        if($check_column=='name' && ($column[0]=='attribute' || $column[0]=='filter')){
                            
                            $table_descriptiom = '_description';
                            
                        }
                        
                        $import_data_types[$field]['table_to_db'] = $column[0].$table_descriptiom;
                        
                        $identificator = array();
                        
                        if(isset($odmpro_tamplate_data['type_data_column_identificator'])){
                            
                            $identificator = $odmpro_tamplate_data['type_data_column_identificator'];
                            
                        }
                        
                        if(isset($identificator[$field][$type_data_column]) && $identificator[$field][$type_data_column]){
                            
                            $import_data_types[$field]['identificator'][$type_data] = $identificator[$field][$type_data_column];
                            
                        }else{
                            $import_data_types[$field]['identificator'][$type_data] = 0;
                        }
                        
                        $import_data_types[$field]['type_change'] = $odmpro_tamplate_data['type_change'];
                        
                    }else{
                        unset($import_data_types[$field]);
                    }
                }
            }
            
            $json['error'] = '';
            
            // проверка наличие поля с идентификатором, если данные идут для обновления
            if( ($odmpro_tamplate_data['type_change']=='only_update_data' || $odmpro_tamplate_data['type_change']=='update_data' || $odmpro_tamplate_data['type_change']=='only_new_data') ){
                
                $identificators = array();
                
                $types_data = array();
                
                foreach ($import_data_types as $field => $ipmort) {
                    
                    if($ipmort['identificator'][ $ipmort['type_data'] ] && $ipmort['identificator'][ $ipmort['type_data'] ]){
                        
                        if(!isset($identificator[ $ipmort['type_data']  ])){
                            
                            $identificators[ $ipmort['type_data']  ] = TRUE;
                            
                        }
                        
                    }
                    
                    $types_data[ $ipmort['type_data'] ] = $ipmort['type_data'];
                    
                }
                
                foreach ($types_data as $type_data) {
                    
                    if(!isset($identificators[ $type_data ])){
                        
                        $json['error'] .= '<p>'.sprintf($this->language->get('entry_identificator_empty'),'<b>'.$this->language->get('text_type_data_'.$type_data).'</b>',$this->language->get('entry_type_change_new_data')).'</p>'; 
                        
                    }
                }
                
            }
            
            // проверка обязательных полей при добавлении данных, для определенного типа данных
            if( $odmpro_tamplate_data['type_change']=='new_data' ){
                
                $types_data = array();
                
                foreach ($import_data_types as $field => $ipmort) {
                    
                    //собираю все типы данных, чтобы потом проверить для всех ли есть $required_fields 
                    $types_data[$ipmort['type_data']] = $ipmort['type_data'];
                    
                    if($ipmort['type_data']=='category'){
                        
                        //создаю, если еще нет
                        if(!isset($required_fields)){
                            
                            $required_fields[$ipmort['type_data']] = FALSE;
                            
                        }
                        //для этого типа обязательные название или путь с названием
                        if($ipmort['column']=='name' || $ipmort['column']=='category_whis_path'){
                            
                            $required_fields[$ipmort['type_data']] = TRUE;
                            
                        }
                        
                    }
                    
                }
                
                foreach ($types_data as $type_data) {
                    
                    if(isset($required_fields[$type_data]) && !$required_fields[$type_data]){
                        
                        $json['error'] .= '<p>'.$this->language->get('entry_'.$type_data.'_required_empty').'</p>'; 
                        
                    }
                }
                
            }
            
            //проверка импорта фильтров и атрибутов на наличие связанной группы
            if($attribute_or_filter){
                
                $error = '<p>'.sprintf($this->language->get('entry_attribute_or_filter_group_empty'),'<b>'.$this->language->get('text_type_data_'.$attribute_or_filter).'</b>').'</p>'; 
                
                foreach ($import_data_types as $field => $ipmort) {
                    
                    if(isset($ipmort['type_data_column_group_identificator']) && $ipmort['type_data_column_group_identificator']){
                        
                        $error = ""; 
                        
                    }
                    
                }
                
                $json['error'] .= $error;
                
            }
            
            //проверка curl, если где-то требуется загрузка картинок
            $check_curl = FALSE;
            
            foreach ($import_data_types as $field => $ipmort) {
                
                if($ipmort['type_data_column_image_upload']){
                    
                    $check_curl = TRUE;
                    
                }
                
            }
            
            if($check_curl){
                
                $check_curl = $this->checkCURL();
                
                if(!$check_curl){
                    
                    $json['error'] .= '<p>'.$this->language->get('entry_curl_exits').'</p>'; 
                    
                }
                
            }
            
            //подымаем файл
            if($odmpro_tamplate_data['file_url']){
                
                $file = $this->ocext_model_tool_csv_ocext_dmpro->getFileByURL($odmpro_tamplate_data['file_url']);
                
            }else{
                
                $file = $this->ocext_model_tool_csv_ocext_dmpro->getFileByFileName($odmpro_tamplate_data['file_upload']);
                
            }
            
            if(!$file){
                
                $json['error'] .= '<p>'.$this->language->get('entry_file_exits').'</p>'; 
                
            }
            
            $start = $this->request->get['start'];
            
            $limit = $this->request->post['odmpro_tamplate_data']['limit'];
            
            $json['success'] = '';
            
            $import_result['count_rows'] = 0;
            
            if($format_data=='csv' && !$json['error']){
                
                //+1 сдвигаемся с заголовков полей
                $import_result = $this->ocext_model_tool_csv_ocext_dmpro->getCsvRows($file,$start+1,$limit,$odmpro_tamplate_data);
                
                $log = $this->ocext_model_tool_csv_ocext_dmpro->importCSV($odmpro_tamplate_data,$import_data_types,$import_result);
                
            }
            
            $json['total'] = $import_result['count_rows'];
            
            if(!$json['error'] && (($start+$limit)>$import_result['count_rows'] && $import_result['count_rows']>0)){
                
                $json['success'] = $this->language->get('import_success_accomplished');
                
            }  elseif (!$json['error'] && $import_result['count_rows']>0 && ($start+$limit)<=$import_result['count_rows']) {
                
                $this->response->redirect($this->url->link($this->path_oc_version_feed.'/odmpro_update_csv_link', 'start='.($start+$limit).'&token=' . $this->request->get['token']));
                
            }
            
            if($json['error']){
                echo $json['error'];
            }elseif ($json['success']) {
                echo $json['success'];
            }
            exit();
        }
        
        
        private function getFloat($string){
            
            $find = array('-',',',' ');
            
            $replace = array('.','.','');
            
            $result = (float)str_replace($find, $replace, $string);
            
            return $result;
        }
        
        public function getAttributeOrFilterGroups($language_id,$type_data_column) {
            
            $this->load->language($this->path_oc_version.'/csv_ocext_dmpro');
            
            if(!isset($this->request->get['token'])){
                
                exit($this->language->get('error_no_token'));
                
            }
            
            if($type_data_column=='attribute_name'){
                
                $table = 'attribute_group_description';
                
            }
            
            if($type_data_column=='filter_name'){
                
                $table = 'filter_group_description';
                
            }
            
            if(!$language_id){
                
                $language_id = (int)$this->config->get('config_language_id');
                
            }
            
            $sql = "SELECT * FROM " . DB_PREFIX . $table." WHERE language_id = '" . $language_id . "' ";

            $query = $this->db->query($sql);

            return $query->rows;
	}
        
        public function getAttributes($data = array('start'=>0,'limit'=>10000)) {
            
            $this->load->language($this->path_oc_version.'/csv_ocext_dmpro');
            
            if(!isset($this->request->get['token'])){
                
                exit($this->language->get('error_no_token'));
                
            }
            
		$sql = "SELECT *, (SELECT agd.name FROM " . DB_PREFIX . "attribute_group_description agd WHERE agd.attribute_group_id = a.attribute_group_id AND agd.language_id = '" . (int)$this->config->get('config_language_id') . "') AS attribute_group_name FROM " . DB_PREFIX . "attribute a LEFT JOIN " . DB_PREFIX . "attribute_description ad ON (a.attribute_id = ad.attribute_id) WHERE ad.language_id = '" . (int)$this->config->get('config_language_id') . "'";
                
                $sql .= " ORDER BY attribute_group_name, ad.name";
                
		$sql .= " ASC";
                
                $sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
                
		$query = $this->db->query($sql);
                
                $result = array();
                
                if($query->rows){
                    
                    foreach ($query->rows as $value) {
                        
                        $result[$value['attribute_group_id'].'_'.$value['attribute_id']] = $value;
                        
                    }
                }
                
                ksort($result);
                
		return $result;
	}
        
        protected function curl_get_contents($url) {
            
            $this->load->language($this->path_oc_version.'/csv_ocext_dmpro');
            
            if(!isset($this->request->get['token'])){
                
                exit($this->language->get('error_no_token'));
                
            }
            
            if(function_exists('curl_version')){
                $ch = curl_init();
                curl_setopt($ch, CURLOPT_URL, $url);
                curl_setopt($ch, CURLOPT_HEADER, 0);
                curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
                curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 10);
                $output = curl_exec($ch);
                curl_close($ch);
                return $output;
            }else{
                $output['ru'] = 'Проверка версии недоступна. Включите php расширение - CURL на Вашем хостинге';
                $output['en'] = 'You can not check the version. Enable php extension - CURL on your hosting';
                $language_code = $this->config->get( 'config_admin_language' );
                if(isset($output[$language_code])){
                    return $output[$language_code];
                }else{
                    return $output['en'];
                }
            }
	}
        
        public function model($model, $data = array()) {
            
                $dir = dirname(__DIR__).'/';

                $file = $dir . $model . '.php';

                $class = 'Model' . preg_replace('/[^a-zA-Z0-9]/', '', $model);

                if (file_exists($file)) {
                        include_once($file);

                        $this->registry->set('ocext_model_' . str_replace('/', '_', $model), new $class($this->registry));
                } else {
                        trigger_error('Error: Could not load model ' . $file . '!');
                        exit();
                }

        }
        
        
}
?>