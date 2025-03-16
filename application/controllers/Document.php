<?php
defined('BASEPATH') OR exit('No direct script access allowed');
require_once APPPATH . 'controllers/Common.php';

class Document extends Common
{

    public function __construct()
    {
		parent::__construct();	
		// Load base_url
		$this->load->helper('url');
		$this->load->model(['contact_model', 'project_model', 'job_model']);
    }

    public function index()
    {
    	die("here");
    }
}