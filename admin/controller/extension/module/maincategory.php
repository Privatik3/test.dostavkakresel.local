<?php

class Controllerextensionmodulemaincategory extends Controller
{
    private $error = array();

    public function index()
    {
        $this->load->language('module/maincategory');
        $this->document->setTitle($this->language->get('heading_title'));

        $this->load->model('setting/setting');

        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
            $this->model_setting_setting->editSetting('maincategory', $this->request->post);

            $this->session->data['success'] = $this->language->get('text_success');

            $this->response->redirect($this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true));
        }


        $data['button_save'] = $this->language->get('button_save');
        $data['button_cancel'] = $this->language->get('button_cancel');

        $data['heading_title'] = $this->language->get('heading_title');
        $data['text_edit'] = $this->language->get('text_edit');
        $data['text_enabled'] = $this->language->get('text_enabled');
        $data['text_disabled'] = $this->language->get('text_disabled');
        $data['entry_status'] = $this->language->get('entry_status');

        $data['entry_picwidth'] = $this->language->get('entry_picwidth');
        $data['entry_picheight'] = $this->language->get('entry_picheight');

        // если метод validate вернул warning, передадим его представлению
        if (isset($this->error['warning'])) {
            $data['error_warning'] = $this->error['warning'];
        } else {
            $data['error_warning'] = '';
        }

        // далее идет формирование массива breadcrumbs (хлебные крошки)
        $data['breadcrumbs'] = array();
        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
        );
        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_module'),
            'href' => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL')
        );
        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('heading_title'),
            'href' => $this->url->link('module/category', 'token=' . $this->session->data['token'], 'SSL')
        );

        //ссылки для формы и кнопки "cancel"
        $data['action'] = $this->url->link('extension/module/maincategory', 'token=' . $this->session->data['token'], 'SSL');
        $data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

        //переменная с статусом модуля
        if (isset($this->request->post['maincategory_status'])) {
            $data['maincategory_status'] = $this->request->post['maincategory_status'];
        } else {
            $data['maincategory_status'] = $this->config->get('maincategory_status');
        }

        if (isset($this->request->post['maincategory_picheight'])) {
            $data['maincategory_picheight'] = $this->request->post['maincategory_picheight'];
        } else {
            $data['maincategory_picheight'] = $this->config->get('maincategory_picheight');
        }

        if (isset($this->request->post['maincategory_picwidth'])) {
            $data['maincategory_picwidth'] = $this->request->post['maincategory_picwidth'];
        } else {
            $data['maincategory_picwidth'] = $this->config->get('maincategory_picwidth');
        }


        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer'] = $this->load->controller('common/footer');

        $this->response->setOutput($this->load->view('module/maincategory.tpl', $data));
    }

    protected function validate()
    {
        if (!$this->user->hasPermission('modify', 'extension/module/category')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }
        return !$this->error;
    }
}