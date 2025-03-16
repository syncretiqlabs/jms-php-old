<?php
defined('BASEPATH') OR exit('No direct script access allowed');
require_once APPPATH . 'controllers/Common.php';

class User_login extends Common {

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

	public function index()
	{
        if ($this->input->post('submit') == 'submit') {
            $email_address = $this->input->post('email_address');
            $password = md5($this->input->post('password'));
            $user = $this->user_model->get_user(['Email' => $email_address, 'password' => $password, 'Status' => '1']);
            if ($user->num_rows() > 0) {
				$this->session->set_userdata($user->row_array());
				if (!$this->input->post('redirect_url') == '') {
					$redirect_url = $this->input->post('redirect_url');
					$this->my_redirect('/' . $redirect_url);
				} else {
					$this->my_redirect();
				}
                
            } else {
                $this->smarty->assign('error', 'Please enter correct email address and password');
                $this->smarty->display('user/user_login.tpl');
            }
        } else {
            $this->smarty->display('user/user_login.tpl');
        }
    }

    public function logout()
    {
        $this->session->sess_destroy();
        $this->my_redirect('/user/user_login');
    }
}
