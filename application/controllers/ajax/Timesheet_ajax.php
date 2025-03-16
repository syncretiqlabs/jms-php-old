<?php
defined('BASEPATH') OR exit('No direct script access allowed');
require_once APPPATH . 'controllers/Common.php';

class Timesheet_ajax extends Common {

    public function __construct()
    {
		parent::__construct();
	
        // Load Model
        $this->load->model(['jobs_model']);
		
    }

    public function get_jobs_dispatch()
    {
        $id = $this->input->post('job_id');
        $job_return = [];
        $job = $this->jobs_model->getJobDispatchByJobId($id);
        if ($job->num_rows() > 0) {
            $job_return = $job->result_array();
        }
        echo json_encode($job_return);
    }
}