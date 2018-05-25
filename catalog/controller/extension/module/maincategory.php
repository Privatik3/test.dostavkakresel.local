<?php

class Controllerextensionmodulemaincategory extends Controller
{
    public function index()
    {
        $this->document->addStyle('catalog/view/theme/default/stylesheet/maincategory/maincategory.css');
        $this->load->language('module/maincategory'); //подключаем любой языковой файл
        $this->load->model('tool/image');
        $data['heading_title'] = $this->language->get('heading_title'); //объявляем переменную heading_title с данными из языкового файла
        $this->load->model('catalog/category'); //подключаем модель категорий.
        $mainCats = $this->model_catalog_category->getCategories();
        $out = array();

        $picwidth = $this->config->get('maincategory_picwidth');
        $picheight = $this->config->get('maincategory_picheight');

        foreach ($mainCats as $mainCatsItem) {
            if (!empty($mainCatsItem['image'])) $pic = $this->model_tool_image->resize($mainCatsItem['image'], ($picwidth) ? $picwidth : 200, ($picheight) ? $picheight : 200);
            else $pic = $this->model_tool_image->resize('no_image.png', ($picwidth) ? $picwidth : 200, ($picheight) ? $picheight : 200);

            $subCats = $this->model_catalog_category->getCategories($mainCatsItem['category_id']);
            $mainCatsItem = $mainCatsItem + ['img' => $pic];
            $mainCatsItem = $mainCatsItem + ['href' => $this->url->link('product/category', 'path=' . $mainCatsItem['category_id'])];
            foreach ($subCats as $subCatsItem) {
                $subCatsItem = $subCatsItem + ['href' => $this->url->link('product/category', 'path=' . $subCatsItem['category_id'])];
                $mainCatsItem['subcat'][] = $subCatsItem;
            }
            array_push($out, $mainCatsItem);
        }
        $data['category_info'] = $out;
        //стандартная процедура для контроллеров OpenCart, выбираем файл представления модуля для вывода данных
        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/extension/module/maincategory.tpl')) {
            return $this->load->view( $this->config->get('config_template') . '/template/module/extension/maincategory.tpl', $data);
        } else {
            return $this->load->view('extension/module/maincategory.tpl', $data);
        }
    }
}

?>
