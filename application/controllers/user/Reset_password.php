<?php
defined('BASEPATH') OR exit('No direct script access allowed');
require_once APPPATH . 'controllers/Common.php';

class Reset_password extends Common {
    
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
        if ($this->input->post('submit') == 'generate_link') {
            $email = $this->input->post('email_address');
            $user = $this->user_model->get_user(['Email' => $email]);
            
            if ($user->num_rows() > 0) {
                $reset_key = $this->getGUID();
                $user = $user->row();
                $this->user_model->update_user(['ResetKey' => $reset_key], ['Email' => $email]);
                $reset_key_encrypted = md5($reset_key);
                $query_string = $this->encrypt->encode("email=$email&reset_key=$reset_key_encrypted");
                $url = $this->host_url . '/index.php/user/reset_password/set_new_password?' . $query_string;
                $this->load->library('email');
                $this->email->from('jms@syncretiq.com', 'JMS');
                $this->email->to($email, $user->UserName);
                $this->email->subject('Password reset request');
                $this->email->message($url);
                if ($this->email->send()) {
                    $this->smarty->assign('email_sent', 'success');
                    $this->smarty->assign('message', "Email sent successfully to $email. Please check your email address for the password reset link.");
                } else {
                    $this->smarty->assign('email_sent', 'Error');
                    $this->smarty->assign('message', 'Issue sending email. Please contact the developers');
                }
            } else {
                $this->smarty->assign('email_sent', 'Error');
                $this->smarty->assign('message', 'Email address does not exist in our database. Please check the email address and try again.');
            }
        }
        $this->smarty->display('user/reset_password.tpl');
    }

    public function set_new_password() {
        if ($this->input->post('submit') == 'generate_link') {
            $password = $this->input->post('password');
            $confirm_password = $this->input->post('confirm_password');
            if ($password == $confirm_password) {
                $user = $this->user_model->get_user(['UserId' => $this->input->post('user_id')]);
                if ($user->num_rows() > 0) {
                    $this->user_model->update_user(['Password' => md5($password), 'ResetKey' => ''], ['UserId' => $this->input->post('user_id')]);
                    $this->my_redirect('/user/user_login');
                }
            }
        }
        if (!empty($_SERVER['QUERY_STRING'])) {
            parse_str($this->encrypt->decode($_SERVER['QUERY_STRING']), $queries);
        }
        $user = $this->user_model->get_user(['Email' => $queries['email']]);
        if ($user->num_rows() > 0) {
            $user = $user->row();
            $this->smarty->assign('template', 'new_password_form');
            if (md5($user->ResetKey) == $queries['reset_key']) {
                $this->smarty->assign('user_id', $user->UserId);
            } else {
                $this->smarty->assign('template_error', 'Sorry the link might be expired. Please reset it again.');
            }
            $this->smarty->display('user/reset_password.tpl');
        }
    }

    private function getGUID(){
        if (function_exists('com_create_guid')){
            return com_create_guid();
        }
        else {
            mt_srand((double)microtime()*10000);//optional for php 4.2.0 and up.
            $charid = strtoupper(md5(uniqid(rand(), true)));
            $hyphen = chr(45);// "-"
            $uuid = chr(123)// "{"
                .substr($charid, 0, 8).$hyphen
                .substr($charid, 8, 4).$hyphen
                .substr($charid,12, 4).$hyphen
                .substr($charid,16, 4).$hyphen
                .substr($charid,20,12)
                .chr(125);// "}"
            return $uuid;
        }
    }

}