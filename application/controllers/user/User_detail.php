<?php
defined('BASEPATH') OR exit('No direct script access allowed');
require_once APPPATH . 'controllers/Common.php';

class User_detail extends Common {
    
    /**
	 * Index Page for this controller.
	 *
	 * Maps to the following URL
	 * 		http://example.com/index.php/welcome
	 *	- or -
	 * 		http://example.com/index.php/welcome/index
	 *	- or -
	 * Since this controller is set as the default controller in
	 * config/routes.php, it's displayed at http://example.com/
	 *
	 * So any other public methods not prefixed with an underscore will
	 * map to /index.php/welcome/<method_name>
	 * @see https://codeigniter.com/user_guide/general/urls.html
	 */

	public function __construct(){
		parent::__construct();
	
		// Load Model
		$this->load->model('user_model');
	
		// Load base_url
		$this->load->helper('url');

		//$this->active_controller_name = $this->router->fetch_class();
	}

    
    public function index($id = null)
	{
        $inserted_id = $id;
		$user = [];
		$task = 'edit';
		if ($this->input->post('button') == 'submit') {
				$data = [
					'UserName' => $this->input->post('user_name'),
					'FirstName' => $this->input->post('first_name') ? $this->input->post('first_name') : null,
					'LastName' => $this->input->post('last_name') ? $this->input->post('last_name') : null,
					'UserType' => $this->input->post('employee_type'),
					'UserRole' => $this->input->post('employee_role'),
					'Phone' => $this->input->post('phone') ? $this->input->post('phone') : null,
					'Mobile' => $this->input->post('mobile') ? $this->input->post('mobile') : null,
					'Email' => $this->input->post('email'),
					'Address' => $this->input->post('address') ? $this->input->post('address') : null,
					'Suburb' => $this->input->post('suburb') ? $this->input->post('suburb') : null,
					'City' => $this->input->post('city') ? $this->input->post('city') : null,
					'DOB' => $this->input->post('dob') ? $this->input->post('dob') : null,
					'Status' => $this->input->post('status') ? $this->input->post('status') : '0'
				];
				if ($this->input->post('password') != '') {
					$data['Password'] = md5($this->input->post('password'));
				}

				if ($this->input->post('id') != 'new') {
					$condition = ['UserId' => $this->input->post('id')];
					if ($this->user_model->get_user($condition)->num_rows() > 0) {
						$this->user_model->update_user($data, $condition);
						$inserted_id = $this->input->post('id');
					}
				} else {
					$inserted_id = $this->user_model->insert_user($data);
				}
				$task = 'detail';
		} 
        
		if (empty($inserted_id)) {
            $this->smarty->assign('user', $user);
			$this->smarty->display('user/user_signup.tpl');
		} else {
			if ($task == 'detail') {
				$url = $this->host_url . "/index.php/user/user_detail/details/$inserted_id";
				redirect($url);
			} else {
				$condition = ['UserId' => $inserted_id];
				$user = $this->user_model->get_user($condition)->row_array();
				$user_document = $this->user_model->get_user_document(['UserId' => $inserted_id]);
				if($user_document->num_rows() > 0) {
					$user_documents = $user_document->result_array();
					$this->smarty->assign('user_documents', $user_documents);
				}
				$this->smarty->assign('user_detail', $user);
				$this->smarty->display('user/user_signup.tpl');
			}
		}
	}

	public function save_password() {
		$password = md5($this->input->post('password'));
		$id = $this->input->post('id');
		$condition = ['UserId' => $this->input->post('id')];
		$data = [
			'Password' => $password
		];
		if ($this->user_model->get_user($condition)->num_rows() > 0) {
			$this->user_model->update_user($data, $condition);
		}
		$url = $this->host_url . "/index.php/user/user_detail/details/$id";

		redirect($url);
	}

	public function details($id)
    {
        $contact = [];
        $type = '';
        if (!empty($id)) {
            $condition = ['UserId' => $id];
            $user = $this->user_model->get_user($condition)->row_array();
            $user_document = $this->user_model->get_user_document(['UserId' => $id]);
            if($user_document->num_rows() > 0) {
                $user_documents = $user_document->result_array();
                $this->smarty->assign('user_documents', $user_documents);
            }
            $this->smarty->assign('user', $user);
        }
        $this->smarty->assign('type', $type);
        $this->smarty->display('user/user_details.tpl');
    }
}