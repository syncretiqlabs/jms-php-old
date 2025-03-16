<?php
defined('BASEPATH') OR exit('No direct script access allowed');
require_once APPPATH . 'controllers/Common.php';

class Contact_ajax extends Common {

    public function __construct()
    {
        parent::__construct();

        // Load Model
        $this->load->model('contact_model');

        // Load base_url
        $this->load->helper('url');
        $this->load->helper(array('form', 'url'));
    }

    public function file_upload()
    {
        $contact_id = $this->input->post('id');
        $file_path = './uploads/contact/' . $contact_id;
        $date = date('Y-m-d');
        if (!is_dir($file_path)) {
            mkdir($file_path, 0777, TRUE);
        }
        $config['upload_path']          = $file_path;
        $config['allowed_types']        = 'gif|jpg|png|jpeg|pdf|PDF';
        $config['max_size']             = 1024;

        $this->load->library('upload', $config);

        if (!$this->upload->do_upload('document')) {
            $result = array('error' => $this->upload->display_errors());
        } else {
            $upload_data = $this->upload->data();
            //$result = array('upload_data' => $upload_data);
            $data = [
                'Name' => $upload_data['file_name'],
                'Path' => $file_path . '/' . $upload_data['file_name'],
                'ContactId' => $contact_id,
                'AddedBy' => $this->session->userdata('UserId')
            ];
            $result['inserted_id'] = $this->contact_model->insert_contact_document($data);
            $data['AddedOn'] = date('Y-m-d H:i:s', time());
            $result['data'] = $data;
        }
        echo json_encode($result);
    }

    public function file_delete()
    {
        $id = $this->input->post('id');
        $document = $this->contact_model->get_contact_document(['Id' => $id])->row();
        unlink($document->Path);
        $this->contact_model->delete_contact_document(['Id' => $id]);
        $result['response'] = 'success';
        echo json_encode($result);
    }

    public function add_filter()
    {
        $filter_type = $this->input->post('type');
        $filter_value = $this->input->post('value');
        $this->session->userdata('filters');
    }
}