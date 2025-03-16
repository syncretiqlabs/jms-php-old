<?php
defined('BASEPATH') OR exit('No direct script access allowed');

abstract class Common extends CI_Controller {

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

	protected $active_controller_name = null;
	protected $host_url = null;
	protected $abc = null;
	protected $logged_in_user = null;

	public function __construct(){
		parent::__construct();
		// check if user is logged in
		//if(!$this->session->userdata('is_logged_in')){
		  // user is not logged in then redirect user to any page you want
		//}
		$this->load->helper('url');

		$this->active_controller_name = $this->router->fetch_class();
		$this->abc = isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] === 'on' ? "https" : "http";
		$site = ENVIRONMENT !== 'development' ? '' : '/jms';
		$site = '';
		$this->host_url = $this->abc .'://' . $_SERVER['HTTP_HOST'] . $site;
		$this->smarty->assign('host_url', $this->host_url);
		$this->smarty->assign('active_controller', $this->active_controller_name);
		$this->smarty->assign('login_url', $this->host_url . '/index.php/user/user_login/logout');
		
		$this->smarty->assign('user');
		$redirect_url = '';
		if (strpos($_SERVER['REQUEST_URI'], 'redirect_url') !== false) {
			$redirect_url = $this->input->get('redirect_url');
			$this->smarty->assign('redirect_url', str_replace($this->host_url . '/index.php/', '', $redirect_url));
		}
		if ($this->active_controller_name != 'reset_password') {
			if ($this->session->userdata('UserId') == '' && $this->active_controller_name != 'user_login') {
				$actual_link = (isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] === 'on' ? "https" : "http") . "://$_SERVER[HTTP_HOST]$_SERVER[REQUEST_URI]";
				if (!empty($_SERVER['REQUEST_URI']) && ($_SERVER['REQUEST_URI'] != '/') && ($_SERVER['REQUEST_URI'] != '/index.php') && ($_SERVER['REQUEST_URI'] != '/index.php/dashboard')){
					$this->my_redirect('/user/user_login', $actual_link);
				} else {
					$this->my_redirect('/user/user_login');
				}
			} else {
				$this->load->model('user_model');
				$this->logged_in_user = $this->user_model->get_user(['UserId' => $this->session->userdata('UserId')])->row_array();
				$this->smarty->assign('logged_in_user', $this->logged_in_user);
			}
		}
		$this->smarty->assign('username', $this->session->userdata('UserName'));
		$this->smarty->assign('userid', $this->session->userdata('UserId'));
	}

	public function my_redirect($link = '', $redirect_url = '')
	{
		$url = $this->host_url . '/index.php';
		if (!empty($link)) {
			$url .= $link;
			if (!empty($redirect_url)) {
				$url .= '?redirect_url=' . $redirect_url;
			}
		}
		redirect($url);
	}

	//Include PHP Mailer -> https://github.com/PHPMailer/PHPMailer
// /require_once(APPPATH.'libraries/phpmailer/PHPMailerAutoload.php');

//Send email with Amazon SNS
function sendMail($data = null){
	//$this->load->library('phpmaile_lib');
	$mail = $this->phpmailer_lib->load();
	if (!empty($data)){
		$from_email = $data["from_email"];
		$from_name = $data["from_name"];
		$to_email = $data["to_email"];
		$to_name = $data["to_name"];
		$subject = $data["subject"];
		$body = $data ["body"];

		$attachmentIncluded = !empty($data["attachmentIncluded"]) ? $data["attachmentIncluded"] : null;

		//Create a new PHPMailer instance
		//Tell PHPMailer to use SMTP
		$mail->isSMTP();
		//You can set your region according to your account. Ex:eu-east-1
		$mail->Host = 'email-smtp.eu-west-1.amazonaws.com';
		$mail->Port = 587;
		//Set the encryption system to use - ssl (deprecated) or tls
		$mail->SMTPSecure = 'tls';
		//Whether to use SMTP authentication
		$mail->SMTPAuth = true;
		//Username to use for SMTP authentication - use full email address for gmail
		$mail->Username = 'smtp_user_name';
		//Password to use for SMTP authentication
		$mail->Password = 'smtp_password';
		//Set who the message is to be sent from
		$mail->setFrom($from_email, $from_name);
		//Set who the message is to be sent to
		$mail->addAddress($to_email, $to_name);
		//Set the subject line
		$mail->Subject = $subject;
		$mail->Body = $body;
		$mail->IsHTML(true);

		if($attachmentIncluded) {
			$attachment = $data["attachment"];
			$mail->addAttachment($attachment);
		}

		//send the message, check for errors
		if (!$mail->send()) {
			return $mail->ErrorInfo;
		}else {
			return true;
		}
	}
}
}
