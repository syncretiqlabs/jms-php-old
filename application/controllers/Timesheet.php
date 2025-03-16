<?php
defined('BASEPATH') or exit('No direct script access allowed');
require_once APPPATH . 'controllers/Common.php';

class Timesheet extends Common
{

    public function __construct()
    {

        parent::__construct();
        //var_dump($this->session->userdata('UserType'));
        /*  if($this->session->userdata('UserRole')!='admin'){
            $this->my_redirect('/user/user_login');
        }*/

        // Load Model
        $this->load->model(['project_model', 'job_model', 'timesheet_model', 'user_model', 'jobs_model']);

        // Load base_url
        $this->load->helper('url');
    }

    public function index($page = 1, $curremp = 0, $currproject = 0, $currstart = '0', $currend = '0', $sortby = 'date', $direction = 'desc')
    {
        $condition = [];
        $projects_list = [];
        $total_records = 0;
        $limit = $this->config->item('page_limit');
        if ($direction != 'asc') $direction = 'desc';
        if ($sortby == 'date')
            $sorter = 'JobDispatch.DispatchedDate';
        elseif ($sortby == 'employee')
            $sorter = 'User.FirstName';
        elseif ($sortby == 'job')
            $sorter = 'Jobs.Name';
        elseif ($sortby == 'comment')
            $sorter = 'TimeSheet.Notes';
        elseif ($sortby == 'duration')
            $sorter = 'TimeSheet.TotalTime';
        else
            $sorter = 'JobDispatch.DispatchedDate';

        $users = $this->user_model->get_user($condition,'UserName', 'ASC');
        if ($users->num_rows() > 0) {
            $users_list = $users->result_array();
            $user_records = $this->user_model->get_user_count($condition);
        } else {
            $user_records = $users_list = 0;
        }
        $this->smarty->assign('users_list', $users_list);
        $this->smarty->assign('user_records', $user_records);

        /*for user view*/
        if ($this->session->userdata('UserRole') == 'member') {
            $curremp = $this->session->userdata('UserId');
        }
        /* for user view*/
        //var_dump($page, $curremp , $currproject, $currstart , $currend ,$sortby,$direction);
        if (isset($curremp) && $curremp > 0) {
            $condition['TimeSheet.UserId'] =  $curremp;
        }

        if (isset($currproject) && $currproject > 0) {
            $condition['Jobs.ID'] = $currproject;
        }
        if (isset($currstart) && $currstart > 0) {
            $condition['JobDispatch.DispatchedDate >='] =  date("Y-m-d", strtotime($currstart));
        }
        if (isset($currend) && $currend > 0) {
            $condition['JobDispatch.DispatchedDate <='] =  date("Y-m-d", strtotime($currend));
        }

        $timesheets = $this->timesheet_model->get_timesheets($condition, $limit, $page, $sorter, $direction);
        //echo $this->db->last_query();
        if ($timesheets->num_rows() > 0) {
            $timesheets_list = $timesheets->result_array();
            $timesheet_records = $this->timesheet_model->get_timesheet_count($condition);
        } else {
            $timesheet_records = $timesheets_list = 0;
        }
        $this->smarty->assign('timesheet_records', $timesheet_records);
        $this->smarty->assign('timesheets', $timesheets_list);

        $condition = [];

        $projects = $this->jobs_model->getJobs($condition, '', '');

        if ($projects->num_rows() > 0) {
            $projects_list = $projects->result_array();
            $total_records = $this->jobs_model->getJobsCount($condition);
        } else {
            $total_records = $projects_list = '';
        }
        $this->smarty->assign('total_records', $timesheet_records);
        $this->smarty->assign('jobs_list', $projects_list);

        /*$condition = [];
        $jobs = $this->job_model->get_jobs($condition, '', '');
        if ($jobs->num_rows() > 0) {
            $jobs_list = $jobs->result_array();
            $jobs_records = $this->job_model->get_jobs_count($condition);
        }else{
            $jobs_list =$jobs_records='';
        }
        $this->smarty->assign('jobs_records', $jobs_records);
        $this->smarty->assign('jobs_list', $jobs_list);*/


        $this->smarty->assign('sortby', $sortby);
        $this->smarty->assign('direction', $direction);

        $number_of_pages = round($timesheet_records / $limit);
        $url = $this->host_url . '/index.php/timesheet';
        $this->smarty->assign('number_of_pages', $number_of_pages);
        $this->smarty->assign('current_page', $page);
        $this->smarty->assign('limit', $limit);
        $this->smarty->assign('url', $url);
        ////emp/5/project//start//end/
        $this->smarty->assign('curremp', $curremp);
        $this->smarty->assign('currproject', $currproject);
        if ($currstart != 0)
            $this->smarty->assign('currstart', date("Y-m-d", strtotime($currstart)));
        else
            $this->smarty->assign('currstart', $currstart);

        if ($currend != 0)
            $this->smarty->assign('currend', date("Y-m-d", strtotime($currend)));
        else
            $this->smarty->assign('currend', $currend);
        $this->smarty->assign('currendpar', preg_replace('/-+/', '', $currend));
        $this->smarty->assign('currstartpar', preg_replace('/-+/', '', $currstart));

        $fN_sess = '';
        $fN_sess = $this->session->userdata('response');
        $this->smarty->assign('fN_sess', $fN_sess);
        $this->smarty->assign('preDate', 0);


        $this->smarty->display('timesheet/timesheet.tpl');
    }



    public function add($page = 1, $limit = 2)
    {
        $condition = [];
        $projects_list = [];
        $total_records = 0;
        $limit = $this->config->item('page_limit');
        $baseurl = $this->config->item('baseurl');

        $users = $this->user_model->get_user($condition,'UserName', 'ASC');
        if ($users->num_rows() > 0) {
            $users_list = $users->result_array();
            $user_records = $this->user_model->get_user_count($condition);
        } else {
            $user_records = $users_list = 0;
        }
        $this->smarty->assign('users_list', $users_list);
        $this->smarty->assign('user_records', $user_records);
        /*$projects = $this->project_model->get_projects($condition, $limit, $page);

        if ($projects->num_rows() > 0) {
            $projects_list = $projects->result_array();
            $total_records = $this->project_model->get_project_count($condition);
        }else{
            $total_records =$projects_list='';
        }
        $this->smarty->assign('total_records', $total_records);
        $this->smarty->assign('projects_list', $projects_list);*/
        
        $condition = [];
         /*for user view*/
        $curremp = '';
        if ($this->session->userdata('UserRole') == 'member') {
            $curremp = $this->session->userdata('UserId');
            $this->smarty->assign('curremp', $curremp);
            $jobs = $this->jobs_model->getUserJobs($condition);
            $jobs_records = $this->jobs_model->getUserJobsCount($condition);
        } else {
            $jobs = $this->jobs_model->getJobs($condition);
            $jobs_records = $this->jobs_model->getJobsCount($condition);
        }

        //echo $this->db->last_query();
        if ($jobs->num_rows() > 0) {
            $jobs_list = $jobs->result_array();
        } else {
            $jobs_list = [];
            $jobs_records = '';
        }

        /* for user view*/
        $this->smarty->assign('jobs_records', $jobs_records);
        $this->smarty->assign('jobs_list', $jobs_list);
        $number_of_pages = round($total_records / $limit);
        $url = $this->host_url . '/index.php/timesheet/timesheet/index';
        $this->smarty->assign('number_of_pages', $number_of_pages);
        $this->smarty->assign('current_page', $page);
        $this->smarty->assign('limit', $limit);
        $this->smarty->assign('url', $url);
        $this->smarty->assign('baseurl', $baseurl);


        $this->smarty->display('timesheet/add.tpl');
    }
   
    public function export($page = 1, $curremp = 0, $currproject = 0, $currstart = '', $currend = '')
    { 
        //var_dump($page ,$curremp, $currproject, ($currstart) , $currend );die();
        $condition = [];
        $projects_list = [];
        $total_records = 0;
        $limit = ''; //$this->config->item('page_limit');

        $users = $this->user_model->get_user($condition, 'UserName', 'ASC');
        if ($users->num_rows() > 0) {
            $users_list = $users->result_array();
            $user_records = $this->user_model->get_user_count($condition);
        } else {
            $user_records = $users_list = 0;
        }
        $this->smarty->assign('users_list', $users_list);
        $this->smarty->assign('user_records', $user_records);

        if (isset($curremp) && $curremp > 0) {
            $condition['TimeSheet.UserId'] =  $curremp;
        }

        if (isset($currproject) && $currproject > 0) {
            $condition['TimeSheet.JobID'] = $currproject;
        }
        if (isset($currstart) && $currstart > 0) {
            $condition['JobDispatch.DispatchedDate >='] =  date("Y-m-d", strtotime($currstart));
        }
        if (isset($currend) && $currend > 0) {
            $condition['JobDispatch.DispatchedDate <='] =  date("Y-m-d", strtotime($currend));
        }
        //print_r($condition);
        $timesheets = $this->timesheet_model->get_timesheets($condition, $limit, $page);
        //echo $this->db->last_query(); //die();

        if ($timesheets->num_rows() > 0) {
            $timesheets_list = $timesheets->result_array();
            //var_dump( $timesheets_list );
            $timesheet_records = $this->timesheet_model->get_timesheet_count($condition);
        } else {
            $timesheets_list = [];
            $timesheet_records = 0;
        }
        $this->smarty->assign('timesheet_records', $timesheet_records);
        $this->smarty->assign('timesheets', $timesheets_list);

        $condition = [];
        $projects = $this->jobs_model->getJobs($condition, '', '');
        //$projects = $this->project_model->get_projects($condition, $limit, $page);
        if ($projects->num_rows() > 0) {
            $projects_list = $projects->result_array();
            $total_records = $this->jobs_model->getJobsCount($condition);
            //$total_records = $this->project_model->get_project_count($condition);
        } else {
            $total_records = $projects_list = '';
        }
        $this->smarty->assign('total_records', $timesheet_records);
        $this->smarty->assign('projects_list', $projects_list);

        /*
        $condition = [];
        $jobs = $this->job_model->get_jobs($condition, $limit, $page);
        if ($jobs->num_rows() > 0) {
            $jobs_list = $jobs->result_array();
            $jobs_records = $this->job_model->get_jobs_count($condition);
        } else {
            $jobs_list = $jobs_records = '';
        }
        $this->smarty->assign('jobs_records', $jobs_records);
        $this->smarty->assign('jobs_list', $jobs_list);
        */

        $url = $this->host_url . '/index.php/timesheet/index';
        $this->smarty->assign('current_page', $page);
        $this->smarty->assign('limit', $limit);
        $this->smarty->assign('url', $url);
        ////emp/5/project//start//end/
        $this->smarty->assign('curremp', $curremp);
        $this->smarty->assign('currproject', $currproject);
        if ($currstart != 0)
            $this->smarty->assign('currstart', date("Y-m-d", strtotime($currstart)));
        else

        if ($currend != 0)
            $this->smarty->assign('currend', date("Y-m-d", strtotime($currend)));
        else
            $this->smarty->assign('currend', $currend);
        $fN_sess = '';
        $fN_sess = $this->session->userdata('response');
        $this->smarty->assign('fN_sess', $fN_sess);
        $this->smarty->assign('preDate', 0);


        $datass = 'SN,Date,Job,Customer Name,Employee Name,Start Time,Finish Time, Break, Duration, Employee Note,Job Invoice Type, Documents, Is Adhoc, Job Sheet No.,JS Signed?,Hours on Job-Sheet,Variance,Hours to Pay, Notes'. "\n";
        foreach ($timesheets_list as $timesheet) 
        {
            $ContactName = $timesheet["ContactType"]=="Organisation" ? $timesheet["OrganisationName"] : $timesheet["ContactFirstName"]." ".$timesheet["ContactLastName"];
            $FileURL = $timesheet["Filename"] ? $this->host_url.$timesheet["Filename"] : "";
            
            $datass.= "" . "," . $timesheet["DispatchedDate"] . "," . $this->escapeCsvCharacters($timesheet["JobName"]) . "," . $this->escapeCsvCharacters($ContactName) . "," . $this->escapeCsvCharacters($timesheet["FirstName"]) . " " . $this->escapeCsvCharacters($timesheet["LastName"]) . "," . $timesheet["StartTime"] . "," . $timesheet["FinishTime"] . "," . $timesheet["Break"] . "," . $timesheet["TotalTime"] . ",". $this->escapeCsvCharacters($timesheet["Notes"]) . "," .$timesheet["BillingType"] . "," . $FileURL . "," . "" . "," . "" . "," . "" . "," . "" . "," . "" . "," . "" . "," . "" ."\n";
        }


        header('Content-Type: application/csv');
        header('Content-Disposition: attachment; filename="' . $this->session->userdata('FirstName') . $this->session->userdata('LastName') . 'Export-Timesheet-' . date('YmdHis') . '.csv"');
        echo $datass;
        exit();
    }

    public function getJobs($user_id = NULL, $job_id = NULL, $ret = '', $dispatchId = '')
    {
        $jobs_records = array();
        $options = '<option selected="selected" value="">All Job Dispatch</option>';
        $condition['ujd.ResourceId'] =  $user_id;
        $condition['jr.JobId'] = $job_id;
        if ($this->session->userdata('UserRole') == 'member') {
            $condition['jr.DispatchOpen'] = 'open';
        }
        $jobs = $this->jobs_model->getAllDispatchedJobs($condition);
        //echo $this->db->last_query();
        if ($jobs->num_rows() > 0) {
            $jobs_lista = $jobs->result_array();
            $jobs_records = $this->jobs_model->getAllDispatchedJobsCount($condition);
        } else {
            $jobs_lista = $jobs_records = array();
        }
        if (count($jobs_lista) > 0) {
            foreach ($jobs_lista as $key => $value) {
                if ($dispatchId == $value["JrId"])
                    $selected = ' selected="selected" ';
                else
                    $selected = '';
                $options .= '<option value="' . $value["JrId"] . '"' . $selected . '>' . $value["DispatchedDate"] . '</option>';
            }
        }
        //var_dump($options);
        if ($ret == 1)
            return $options;
        else
        echo  $options;
    }


    function createTimesheet()
    {
        $resource = $this->input->post('Userlist') ? $this->input->post('Userlist') : '';
        $job = $this->input->post('Jobslist') ? $this->input->post('Jobslist') : '';
        $job_dispatch = $this->input->post('JobsDispatchlist') ? $this->input->post('JobsDispatchlist') : '';

        $this->db->select('Id');
        $this->db->where('JobId', $job);
        $this->db->where('JobDispatchId', $job_dispatch);
        $this->db->where('ResourceId', $resource);
        $user_job_dispatch = $this->db->get('UserJobDispatch')->row();


        $data['UserId'] = $this->input->post('Userlist') ? $this->input->post('Userlist') : '';
        // $data['ProjectId'] = $this->input->post('Projectlist') ? $this->input->post('Projectlist') : '';
        $data['JobId'] = $this->input->post('Jobslist') ? $this->input->post('Jobslist') : '';
        $data['UserJobDispatchId'] = $user_job_dispatch->Id;
        $data['Date'] = $this->input->post('txtDate') ? $this->input->post('txtDate') : '';
        $data['StartTime'] = $this->input->post('txtStartTime') ? $this->input->post('txtStartTime') : '';
        $data['FinishTime'] = $this->input->post('txtEndTime') ? $this->input->post('txtEndTime') : '';
        $data['Break'] = $this->input->post('txtBreakHr') ? $this->input->post('txtBreakHr') : '';
        $data['BreakMin'] = $this->input->post('txtBreak') ? $this->input->post('txtBreak') : '';
        $totalTime = $this->input->post('txtDuration') ? $this->input->post('txtDuration') : '';
        if (!is_numeric($totalTime)) {
            list($hours, $minutes) = explode(":", $totalTime);
            // Convert the time to a decimal value
            $totalTime = $hours + ($minutes / 60);
        }
        $data['TotalTime'] = $totalTime;
        
        $data['Notes'] = $this->input->post('txtNotes') ? $this->input->post('txtNotes') : '';
        $data['AddedOn'] = date('Y-m-d H:i:s');
        $data['AddedBy'] = $this->session->userdata('UserId');
        $data['ModifiedOn'] = date('Y-m-d H:i:s');
        $data['ModifiedBy'] = $this->session->userdata('UserId');

        $data['DispatchId'] =  $this->input->post('JobsDispatchlist') ? $this->input->post('JobsDispatchlist') : '';
        $insertid = $this->db->insert('TimeSheet', $data);
        $datas['TimeLogged'] = 1;
//print_r($data);
        $conditions = ['Id' => $data['DispatchId']];
        $this->jobs_model->updateJobsDispatch($datas, $conditions);

        $this->session->set_flashdata('response', "Data Inserted Successfully");

        redirect($this->host_url . "/index.php/timesheet/index");
    }

    function edit($timsheet_id = "")
    {
        //var_dump($timsheet_id);
        $condition = [];
        $projects_list = [];
        $total_records = 0;
        $page = 0;
        $limit = $this->config->item('page_limit');
        $baseurl = $this->config->item('baseurl');


        if (isset($timsheet_id) && $timsheet_id > 0) {
            $condition['TimeSheet.Id'] = $timsheet_id;
        }

        $currtimesheet = $this->timesheet_model->get_timesheets($condition, $limit, $page);
        $currtimesheet_list = $currtimesheet->result_array();

        $currtimesheet_list[0]["Date"] = date("Y-m-d", strtotime($currtimesheet_list[0]["Date"]));
        $condition = [];

        $condition = ['jd.Id' => $currtimesheet_list[0]['DispatchId'], 'jd.IsDeleted' => 0];
        $currjobs = $this->jobs_model->getDispatchedJobs($condition);
        $currjobs_list = $currjobs->result_array();

        $condition = [];
        $users = $this->user_model->get_user($condition, 'UserName', 'ASC');
        if ($users->num_rows() > 0) {
            $users_list = $users->result_array();
            $user_records = $this->user_model->get_user_count($condition);
        } else {
            $user_records = $users_list = 0;
        }
        $this->smarty->assign('users_list', $users_list);
        $this->smarty->assign('user_records', $user_records);

        $this->smarty->assign('total_records', $total_records);
        $this->smarty->assign('projects_list', $projects_list);
        $condition = array();
        $jobs = $this->jobs_model->getJobs($condition, $limit, $page);
        if ($jobs->num_rows() > 0) {
            $jobs_list = $jobs->result_array();
            $jobs_records = $this->jobs_model->getJobsCount($condition);
        } else {
            $jobs_list = $jobs_records = '';
        }

        /*for user view*/
        $curremp = '';
        if ($this->session->userdata('UserRole') == 'member') {
            $curremp = $this->session->userdata('UserId');

            $this->smarty->assign('curremp', $curremp);
        }
        /* for user view*/ {
            $condition = [];
            $condition = ['jr.Id' => $currtimesheet_list[0]['DispatchId']];
            //$user_id = NULL,$job_id = NULL, $ret=''
            $currJDList = $this->getJobs($currtimesheet_list[0]['UserId'], $currtimesheet_list[0]['JobId'], 1, $currtimesheet_list[0]['DispatchId']);
        }
        $this->smarty->assign('jobs_records', $jobs_records);
        $this->smarty->assign('currJDList', $currJDList);
        $this->smarty->assign('jobs_list', $jobs_list);
        $number_of_pages = round($total_records / $limit);
        $url = $this->host_url . '/index.php/timesheet/timesheet/index';
        $this->smarty->assign('number_of_pages', $number_of_pages);
        $this->smarty->assign('current_page', $page);
        $this->smarty->assign('limit', $limit);
        $this->smarty->assign('url', $url);
        $this->smarty->assign('baseurl', $baseurl);
        $this->smarty->assign('currtimesheet_list', $currtimesheet_list);
        $this->smarty->assign('currjobs_list', $currjobs_list);
        $this->smarty->display('timesheet/edit.tpl');
    }

    function delete($timsheet_id = "")
    {
        $condition["TimeSheet.Id"] = $timsheet_id;
        $tSheet = $this->timesheet_model->get_timesheets($condition);
        $tSheet_list = $tSheet->result_array();
        $timeSheet = $tSheet_list[0];
        //var_dump();
        if (isset($timeSheet) && ($timeSheet["UserId"] == $this->session->userdata('UserId') || $this->session->userdata('UserRole') == 'admin' || $this->session->userdata('UserRole') == 'superadmin')) {

            $this->db->where('Id', $timsheet_id);
            $this->db->delete('TimeSheet');

            //echo $this->db->last_query();die();
            $this->session->set_flashdata('response', "Data Deleted Successfully");

            redirect($this->host_url . "/index.php/timesheet/index");
        } else {
            $this->session->set_flashdata('response', "Your Last Action Failed");
            redirect($this->host_url . "/index.php/timesheet/index");
        }
    }

    function update($timesheetId = "")
    {
        $condition["TimeSheet.Id"] = $timesheetId;
        $tSheet = $this->timesheet_model->get_timesheets($condition);
        $tSheet_list = $tSheet->result_array();
        $timeSheet = $tSheet_list[0];
        //var_dump();
        if (isset($timeSheet) && ($timeSheet["UserId"] == $this->session->userdata('UserId') || $this->session->userdata('UserRole') == 'admin' || $this->session->userdata('UserRole') == 'superadmin')) {



            $data['UserId'] = $this->input->post('Userlist') ? $this->input->post('Userlist') : '';
            //  $data['ProjectId'] = $this->input->post('Projectlist') ? $this->input->post('Projectlist') : '';
            $data['JobId'] = $this->input->post('Jobslist') ? $this->input->post('Jobslist') : '';
            $data['Date'] = $this->input->post('txtDate') ? $this->input->post('txtDate') : '';
            $data['StartTime'] = $this->input->post('txtStartTime') ? $this->input->post('txtStartTime') : '';
            $data['FinishTime'] = $this->input->post('txtEndTime') ? $this->input->post('txtEndTime') : '';
            $data['Break'] = $this->input->post('txtBreakHr') ? $this->input->post('txtBreakHr') : '';
            $data['BreakMin'] = $this->input->post('txtBreak') ? $this->input->post('txtBreak') : '';
            $data['TotalTime'] = $this->input->post('txtDuration') ? $this->input->post('txtDuration') : '';
            $data['Notes'] = $this->input->post('txtNotes') ? $this->input->post('txtNotes') : '';

            $data['DispatchId'] =  $this->input->post('JobsDispatchlist') ? $this->input->post('JobsDispatchlist') : '';
            $data['ModifiedOn'] = date('Y-m-d H:i:s');
            $data['ModifiedBy'] = $this->session->userdata('UserId');
            //$this->db->insert('TimeSheet', $data);
            $this->db->where('Id', $timesheetId);
            $this->db->update('TimeSheet', $data);
            //echo $this->db->last_query();die();

            $this->session->set_flashdata('response', "Data Updated Successfully");

            redirect($this->host_url . "/index.php/timesheet/index");
        } else {
            $this->session->set_flashdata('response', "Your Last Action Failed");
            redirect($this->host_url . "/index.php/timesheet/index");
        }
    }



    function updateTimesheetAjax($startTime = "", $endTime = "", $breakHr = "", $breakMin = "", $duration = "", $desc = "", $projecId = "", $jobId = "", $timesheetId = '')
    {
        $condition["TimeSheet.Id"] = $timesheetId;
        $tSheet = $this->timesheet_model->get_timesheets($condition);
        $tSheet_list = $tSheet->result_array();
        $timeSheet = $tSheet_list[0];
        //var_dump();
        if (isset($timeSheet) && ($timeSheet["UserId"] == $this->session->userdata('UserId') || $this->session->userdata('UserRole') == 'admin' || $this->session->userdata('UserRole') == 'superadmin')) {
            $data['StartTime'] = $startTime;
            $data['FinishTime'] = $endTime;
            $data['Break'] = $breakHr;
            $data['BreakMin'] = $breakMin;
            $data['TotalTime'] = $duration;
            $data['Notes'] = $desc == "undefined" ? '' : rawurldecode($desc);
            $data['ModifiedOn'] = date('Y-m-d H:i:s');
            $data['ModifiedBy'] = $this->session->userdata('UserId');
            //$this->db->insert('TimeSheet', $data);
            $this->db->where('Id', $timesheetId);
            $this->db->update('TimeSheet', $data);
            //echo $this->db->last_query();die();

            $this->session->set_flashdata('response', "Data Updated Successfully");
            die("sucess");
        } else {
            $this->session->set_flashdata('response', "Your Last Action Failed");
            die("exit");
        }
    }

    function saveTimesheetAjax($startTime = "", $endTime = "", $breakHr = "", $breakMin = "", $duration = "", $desc = "", $projecId = "", $jobId = "", $resourceId = "", $date = "")
    {
        /// url: "{$host_url}/index.php/editTimesheetAjax/"+now+"/"+then+"/"+breakhr+"/"+breakmins+"/"+duration+"/"+job_desc+"/"+{$projecId}+"/"+{$currjobs_list.Id},
        $now = time(); // or your date as well
        $your_date = strtotime(date("Y-m-d", strtotime($date)));
        $datediff = $now - $your_date;

        $daydiff = round($datediff / (60 * 60 * 24));
        if ($this->session->userdata('UserRole') == 'member' && $daydiff > 0) {
            echo "Sorry cannot log old dates.";
            die();
        }
        $data['UserId'] = $resourceId;
        $data['JobId'] = $jobId;
        $data['Date'] = date("Y-m-d", strtotime($date));
        $data['StartTime'] = $startTime;
        $data['FinishTime'] = $endTime;
        $data['Break'] = $breakHr;
        $data['BreakMin'] = $breakMin;
        $data['TotalTime'] = $duration;
        $data['Notes'] = $desc == "undefined" ? '' : rawurldecode($desc);
        $data['AddedOn'] = date('Y-m-d H:i:s');
        $data['AddedBy'] = $this->session->userdata('UserId');
        $data['ModifiedOn'] = date('Y-m-d H:i:s');
        $data['ModifiedBy'] = $this->session->userdata('UserId');

        $this->db->insert('TimeSheet', $data);


        $this->session->set_flashdata('response', "Data Instered Successfully");
    }

    function saveDispatchTimesheetAjax($startTime = "", $endTime = "", $breakHr = "", $breakMin = "", $duration = "", $desc = "", $date = "", $resourceId = "", $jobId = "", $mainJobId = "")
    {
        /// url: "{$host_url}/index.php/editTimesheetAjax/"+now+"/"+then+"/"+breakhr+"/"+breakmins+"/"+duration+"/"+job_desc+"/"+{$projecId}+"/"+{$currjobs_list.Id},
        $now = time(); // or your date as well
        $condition = [];
       // $condition = ['JobDispatch.Id' => $date];
         $condition=['jd.Id'=>$date, 'jd.IsDeleted' => 0]; 

        $jobsss = $this->jobs_model->getDispatchedJobs($condition);
        // echo $this->db->last_query();
        $tSheet_list = $jobsss->result_array();
        $timeSheet = $tSheet_list[0];

        $condition = [];
        $your_date = strtotime(date("Y-m-d", strtotime($timeSheet["DispatchedDate"])));
        $datediff = $now - $your_date;

        $daydiff = round($datediff / (60 * 60 * 24));
        if ($this->session->userdata('UserRole') == 'member' && $daydiff > 0) {
            echo "Sorry cannot log old dates.";
            die();
        }
        $data['UserId'] = $resourceId;
        //$data['ProjectId'] = $projecId;
        $data['UserJobDispatchId'] = $jobId;
        $data['JobId'] = $mainJobId;
        $data['DispatchId'] = $date;
        //$data['Date']=date("Y-m-d",strtotime($date));
        $data['StartTime'] = $startTime;
        $data['FinishTime'] = $endTime;
        $data['Break'] = $breakHr;
        $data['BreakMin'] = $breakMin;
        $data['TotalTime'] = $duration;
        $data['Notes'] = $desc == "undefined" ? '' : rawurldecode($desc);
        $data['AddedOn'] = date('Y-m-d H:i:s');
        $data['AddedBy'] = $this->session->userdata('UserId');
        $data['ModifiedOn'] = date('Y-m-d H:i:s');
        $data['ModifiedBy'] = $this->session->userdata('UserId');

        $inserted_id = $this->db->insert('TimeSheet', $data);
        $datas['TimeLogged'] = 1;
        $condition = [];
        $conditions = ['Id' => $date];
        $this->jobs_model->updateJobsDispatch($datas, $conditions);

        $this->session->set_flashdata('response', "Timesheet Instered Successfully");
    }

    function editDispatchTimesheetAjax($startTime = "", $endTime = "", $breakHr = "", $breakMin = "", $duration = "", $desc = "", $jobId = "", $timesheetId = '')
    {
        /*$condition["TimeSheet.Id"]=$timesheetId;
        $tSheet=$this->timesheet_model->get_timesheets($condition);
        $tSheet_list = $tSheet->result_array();*/
        $this->db->where("TimeSheet.Id", $timesheetId);
        $tSheet_list =  $this->db->get('TimeSheet');
        $tSheet = $tSheet_list->result_array();
        $timeSheet = $tSheet[0];
        // $timeSheet=$tSheet_list[0];
        if (isset($timeSheet) && ($timeSheet["UserId"] == $this->session->userdata('UserId') || $this->session->userdata('UserRole') == 'admin' || $this->session->userdata('UserRole') == 'superadmin')) {
            $data['StartTime'] = $startTime;
            $data['FinishTime'] = $endTime;
            $data['Break'] = $breakHr;
            $data['BreakMin'] = $breakMin;
            $data['TotalTime'] = $duration;
            $data['Notes'] = $desc == "undefined" ? '' : rawurldecode($desc);
            $data['ModifiedOn'] = date('Y-m-d H:i:s');
            $data['ModifiedBy'] = $this->session->userdata('UserId');
            //$this->db->insert('TimeSheet', $data);
            $this->db->where('Id', $timesheetId);
            $this->db->update('TimeSheet', $data);
            //echo $this->db->last_query();die();

            $this->session->set_flashdata('response', "Timesheet Updated Successfully");
            die("sucess");
        } else {
            $this->session->set_flashdata('response', "Your Last Action Failed");
            die("exit");
        }
    }

    function deleteJobDispatchTimesheet($timesheedId = "", $jobId = "")
    {
        /* $condition["TimeSheet.Id"]=$timesheedId;
        $tSheet=$this->timesheet_model->get_timesheets($condition);
        $tSheet_list = $tSheet->result_array();
        $timeSheet=$tSheet_list[0];*/

        $this->db->where("TimeSheet.Id", $timesheedId);
        $tSheet_list =  $this->db->get('TimeSheet');
        $tSheet = $tSheet_list->result_array();
        $timeSheet = $tSheet[0];
        $dispatchId = $timeSheet["UserJobDispatchId"];

        //var_dump($timeSheet,$dispatchId);die();
        if (isset($timeSheet) && ($timeSheet["UserId"] == $this->session->userdata('UserId') || $this->session->userdata('UserRole') == 'admin' || $this->session->userdata('UserRole') == 'superadmin')) {

            $this->db->where('Id', $timesheedId);
            $this->db->delete('TimeSheet');
            //echo $this->db->last_query();

            $dataUserDispatch['TimeLogged'] = 0;
            //$this->db->insert('TimeSheet', $data);
            $this->db->where('Id', $dispatchId);
            $this->db->update('UserJobDispatch', $dataUserDispatch);

            //  echo $this->db->last_query();die();
            $this->session->set_flashdata('response', "Data Deleted Successfully");

            redirect($this->host_url . "/index.php/jobs/jobDispatchDetail/" . $jobId);
        } else {
            $this->session->set_flashdata('response', "Your Last Action Failed");
            redirect($this->host_url . "/index.php/jobs/jobDispatchDetail/" . $jobId);
        }
    }
    
    function escapeCsvCharacters($string) 
    {
        $escapedString = str_replace(['"', "\n", "\r"], ['""', '\\n', '\\r'], $string);
        if (strpos($string, ',') !== false) {
            $escapedString = '"' . $escapedString . '"';
        }
        return $escapedString;
    }
}
