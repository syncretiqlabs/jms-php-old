<?php
defined('BASEPATH') OR exit('No direct script access allowed');

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

class PHPMailer_lib
{
    public function construct() {
        //parent::__construct();
        log_message('Debug', 'PHPMaile class is not loaded.');
    }

    public function load() {
        require_once APPPATH . 'third_party/PHPMailer/Exception.php';
        require_once APPPATH . 'third_party/PHPMailer/PHPMailer.php';
        require_once APPPATH . 'third_party/PHPMailer/SMTP.php';
        $mail = new PHPMailer;
        return $mail;
    }
} 