<?php
defined('BASEPATH') OR exit('No direct script access allowed');
require_once APPPATH . 'controllers/Common.php';

class Dashboard extends Common
{

    public function __construct()
    {
		parent::__construct();	
		// Load base_url
		$this->load->helper('url');
		$this->load->model(['contact_model', 'jobs_model']);
    }

	public function index()
	{
		if (in_array($this->logged_in_user['UserRole'],['superadmin','admin'])) {
			$contact = $this->contact_model->get_recent_contacts(5)->result_array();
			if (count($contact) > 0) {
				$this->smarty->assign('contacts', $contact);
			}
            
            $todays_job_dispatch = $this->jobs_model->get_todays_job_dispatch(100);
			if($todays_job_dispatch->num_rows() > 0) {
				$this->smarty->assign('todays_job_dispatch', $todays_job_dispatch->result_array());
				//echo $this->db->last_query();
			}
			
			$upcoming_job_dispatch = $this->jobs_model->get_upcoming_job_dispatch(5);
			if($upcoming_job_dispatch->num_rows() > 0) {
				$this->smarty->assign('upcoming_job_dispatch', $upcoming_job_dispatch->result_array());
			}

			$recent_job_dispatch = $this->jobs_model->get_recent_job_dispatch(5);
			if (count($recent_job_dispatch) > 0) {
				$this->smarty->assign('recent_job_dispatch', $recent_job_dispatch);
			}

			/*$recent_jobs = $this->jobs_model->get_recent_jobs(5)->result_array();
			if (count($recent_jobs) > 0) {
				$this->smarty->assign('recent_jobs', $recent_jobs);
			}*/

			$recent_contract_jobs = $this->jobs_model->get_recent_contract_jobs(5);
			if (count($recent_contract_jobs) > 0) {
				$this->smarty->assign('recent_contract_jobs', $recent_contract_jobs);
			}

		} else {
			$user_jobs = $this->jobs_model->get_upcoming_job_dispatch(5, $this->session->userdata('UserId'));
			if($user_jobs->num_rows() > 0) {
				$this->smarty->assign('upcoming_user_job_dispatch', $user_jobs->result_array());
			}

			$user_jobs = $this->jobs_model->get_recent_job_dispatch(5);

		}
		$this->smarty->display('dashboard.tpl');
    }

	public function getJobsAjax($month) {
		$data = [];
		$this->db->select('jd.Id as id, jd.DispatchName as name, j.Description as description, jd.DispatchedDate as date, j.JobType as type, count(ujd.Id) as resourcecount');
		if (!in_array($this->logged_in_user['UserRole'],['superadmin','admin'])) {
			$this->db->where('ujd.ResourceId', $this->session->userdata('UserId'));
		}
		$this->db->join('Jobs as j', 'jd.JobId=j.Id', 'left');
		$this->db->like("jd.DispatchedDate", "-$month-");
		$this->db->where("jd.IsDeleted", '0');
		$this->db->join('UserJobDispatch as ujd', 'ujd.JobDispatchId=jd.Id', 'left');
		$this->db->group_by('jd.Id');
		$job_dispatch = $this->db->get("JobDispatch as jd")->result_array();

		foreach ($job_dispatch as $k => $val) {
			/*$id = $val['id'];
			$name = $val['name'];
			$job_dispatch[$k]['name'] = '<a href="' . $this->host_url . '/index.php/jobs/jobDispatchDetail/' . $id . '">'.$name.'</a>';*/
			$job_dispatch[$k]['type'] = $val['resourcecount'] == 0 ? 'resource_not_assigned' : 'resource_assigned';
		}
		$data = json_encode($job_dispatch);
		echo $data;
	}
	
	
	public function getDashboardReportingDataAjax($duration)
	{
		$condition = array();
		$current_date = date('Y-m-d');
		
		if($duration == "7_days")
		{
			$condition = array (
							'jd.DispatchedDate >=' =>  date('Y-m-d', strtotime('-7 day', strtotime($current_date))),
							'jd.DispatchedDate <' => $current_date
							);
			
		}elseif($duration == "30_days")
		{
			$condition = array (
							'jd.DispatchedDate >=' =>  date('Y-m-d', strtotime('-30 day', strtotime($current_date))),
							'jd.DispatchedDate <' => $current_date
							);
							
		}elseif($duration == "last_month")
		{
			$condition = array (
							'jd.DispatchedDate >=' =>  date('Y-m-d', strtotime('first day of last month')),
							'jd.DispatchedDate <' => date('Y-m-d', strtotime('last day of last month'))
							);
		}
		elseif($duration == "this_month")
		{
			$condition = array (
							'jd.DispatchedDate >=' =>  date('Y-m-d', strtotime('first day of this month')),
							'jd.DispatchedDate <' => $current_date
							);
		}elseif($duration == "upcoming_week")
		{
		    $condition = array (
							'jd.DispatchedDate >=' =>  $current_date,
							'jd.DispatchedDate <' => date('Y-m-d', strtotime('+7 day', strtotime($current_date)))
							);
			
		}elseif($duration == "upcoming_month")
		{
		    $condition = array (
							'jd.DispatchedDate >=' =>  $current_date,
							'jd.DispatchedDate <' => date('Y-m-d', strtotime('+30 day', strtotime($current_date)))
							);
			
		}
		
		$this->db->select('jd.Id, jd.DispatchOpen as jd_status, sum(ts.TotalTime) as total_time, j.JobType as job_type');
		$this->db->join('Jobs as j', 'j.Id=jd.JobId');
		$this->db->join('UserJobDispatch as ujd', 'ujd.JobDispatchId=jd.Id', 'left');
		$this->db->join('TimeSheet as ts', 'ts.UserJobDispatchId=ujd.Id', 'left');
		$this->db->where($condition);
		$this->db->where('IsDeleted','0');
		$this->db->group_by('jd.Id');
		$job_dispatch = $this->db->get("JobDispatch as jd")->result_array();
		
		$total_jobs = count($job_dispatch);

		$total_time = 0;
		$total_contract_time = 0;
		foreach ($job_dispatch as $val) {
			$total_time +=$val['total_time'];
			if ($val['job_type'] == 'Contract') {
				$total_contract_time += $val['total_time'];
			}
		}

		$data = [
			'total_jobs' => $total_jobs,
			'total_time' => $total_time,
			'total_contract_time' => $total_contract_time
		];

		$data = json_encode($data);
		echo $data;
	}

}