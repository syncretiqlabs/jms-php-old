<?php
defined('BASEPATH') OR exit('No direct script access allowed');
require_once APPPATH . 'controllers/Common.php';

class User_ajax extends Common {

    public function __construct()
    {
		parent::__construct();
	
		// Load Model
		
    }

    public function get_user()
    {
        $this->load->model('user_model');
        $key = $this->input->post('type');
        $value = $this->input->post('value');
        $user = $this->user_model->get_user([$key => $value]);
        $result['result'] = $user->num_rows();
        echo json_encode($result);
    }

    public function get_user_by_email()
    {
        $this->load->model('user_model');
        $email = $this->input->post('email');
        $user = $this->user_model->get_user(['Email' => $email]);
        $result['result'] = $user->num_rows();
        echo json_encode($result);
    }

    public function logout()
    {
        if ($this->session->sess_destroy()) {
            echo json_encode(['logout' => 1]);
        } else {
            echo json_encode(['logout' => 0]);
        }
    }

    public function file_upload()
    {
        $user_id = $this->input->post('id');
        $file_path = './uploads/user/' . $user_id;
        $date = date('Y-m-d');
        if (!is_dir($file_path)) {
            mkdir($file_path, 0777, TRUE);
        }
        $config['upload_path']          = $file_path;
        $config['allowed_types']        = 'gif|jpg|png|jpeg';
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
                'UserId' => $user_id,
                'AddedBy' => $this->session->userdata('UserId')
            ];
            $result['inserted_id'] = $this->user_model->insert_user_document($data);
            $data['AddedOn'] = date('Y-m-d H:i:s', time());
            $result['data'] = $data;
        }
        echo json_encode($result);
    }

    public function file_delete()
    {
        $id = $this->input->post('id');
        $document = $this->user_model->get_user_document(['Id' => $id])->row();
        $url = $this->host_url . $document->Path;
        echo $url;

        //$url = 'http://jms.syncretiq.com/uploads/user/5//Screen_Shot_2020-12-17_at_12_53_46_AM.png';
        unlink($url);
        $this->user_model->delete_user_document(['Id' => $id]);
    }
}