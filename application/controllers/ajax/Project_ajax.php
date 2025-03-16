<?php
defined('BASEPATH') OR exit('No direct script access allowed');
require_once APPPATH . 'controllers/Common.php';

class Project_ajax extends Common {

    public function __construct()
    {
		parent::__construct();
	
        // Load Model
        $this->load->model(['job_model']);
		
    }

    public function add_jobs()
    {
        try
        {
            $data = [
                'Name' => $this->input->post('job_name'),
                'Description' => $this->input->post('job_description'),
                'JobDateTime' => $this->input->post('job_date'),
                'ProjectId' => $this->input->post('project_id'),
                'AddedOn' => date('Y/m/i h:i:s'),
                'AddedBy' => $this->session->userdata('UserId')
            ];
            $job_id = $this->job_model->insert_job($data);
            if (!$job_id) {
                throw new Exception('Job insertion failed');
            }
            $data['JobId'] = $job_id;

            $users = $this->input->post('user_assigned');
            
            foreach ($users as $user) {
                $user_job_id = '';
                $job_user = [
                    'JobId' => $job_id,
                    'UserId' => $user,
                    'AddedBy' => $this->session->userdata('UserId')
                ];
                $job_user['Id'] = $user_job_id = $this->job_model->insert_user_job($job_user);
                if (!$user_job_id) {
                    throw new Exception('UserJob insertion failed');
                }
                $assigned_user[] = $job_user;
            }
            $data['assigned_user'] = $assigned_user;
        } catch (Exception $e) {
            $data = [
                'error' => 1,
                'error_message' => $e->getMessage()
            ];
        }
        echo json_encode($data);
    }

    public function delete_jobs()
    {
        $job_id = $this->input->post('id');
        $data['result'] = $this->job_model->delete_job($job_id);
        echo json_encode($data);
    }

    public function get_jobs()
    {
        $id = $this->input->post('job_id');
        $job = $this->job_model->get_jobs(['Id' => $id]);
        if ($job->num_rows() > 0) {
            $job = $job->row_array();
            $user_job = $this->job_model->get_user_job(['JobId' => $id]);
            if ($user_job->num_rows() > 0) {
                $job['resources'] = $user_job->result_array();
            } else {
                $job['resources'] = [];
            }
        }
        echo json_encode($job);
    }

    public function get_customer() {
        $this->load->model('contact_model');
        $condition = ['ContactCategory' => 'Customer'];
        $contact_list = $this->contact_model->get_contact($condition, $this->input->post('searchTerm'))->result();
        foreach ($contact_list as $key =>  $value) {
            if ($value->ContactType == "People") {
                $response[$value->Id] = $value->FirstName . ' ' . $value->LastName;
            } else {
                $response[$value->Id] = $value->CompanyName;
            }
        }
        echo json_encode($response);
        //$this->smarty->assign('contact_list', $contact_list);
    }
}