<?php
defined('BASEPATH') or exit('No direct script access allowed');
require_once APPPATH . 'controllers/Common.php';

class Jobs extends Common
{

    public function __construct()
    {
        parent::__construct();
        // Load base_url
        $this->load->helper('url');
        $this->load->model(['contact_model', 'project_model', 'timesheet_model', 'user_model', 'jobs_model']);
    }
    //$projectID,$page='1',$sortby='date',$direction='desc'
    public function index($page = 1, $sortby = '', $direction = 'desc')
    {
        //var_dump($page,$sortby,$direction);
        $condition = [];
        $project_type = [];
        $project_status = [];
        $queries = [];
        $query_term = '';
        $limit = $this->config->item('page_limit');
        $search_term = $query_term = '';

        if (!empty($_SERVER['QUERY_STRING'])) {
            parse_str($this->encrypt->decode($_SERVER['QUERY_STRING']), $queries);
            $query_term = '?';
            if (!empty($queries)) {
                foreach ($queries as $name => $value) {
                    $query_term .= "$name=$value";
                }
            }
        }
        $this->smarty->assign('query_term', $_SERVER['QUERY_STRING']);

        $search_term = !empty($queries['search_term']) ? $queries['search_term'] : '';
        $this->smarty->assign('search_term', $search_term);

        $project_type = !empty($queries['project_type']) ? explode(',', preg_replace('/[\(\)]/', '', $queries['project_type'])) : [];
        $this->smarty->assign('project_type', $project_type);

        $job_occurence = !empty($queries['job_occurence']) ? explode(',', preg_replace('/[\(\)]/', '', $queries['job_occurence'])) : [];
        $this->smarty->assign('job_occurence', $job_occurence);

        $project_status = !empty($queries['project_status']) ? explode(',', preg_replace('/[\(\)]/', '', $queries['project_status'])) : [];
        $this->smarty->assign('project_status', $project_status);

        $condition = [];
        if (!empty($project_type)) {
            $condition['JobType'] = $project_type;
        }

        if (!empty($job_occurence)) {
            $condition['IsRecurring'] = $job_occurence;
        }

        if (!empty($project_status)) {
            $condition['Status'] = $project_status;
        }

        if ($this->session->userdata('UserRole') != 'admin' && $this->session->userdata('UserRole') != 'superadmin') {
        }
        //$this->smarty->assign('query_term', $_SERVER['QUERY_STRING']);
        /* nwe start*/
        //name customer startdate enddate
        $jobs_list = [];
        $total_records = 0;
        if ($direction != 'asc') $direction = 'desc';
        // var_dump($sortby);
        if ($sortby == 'name')
            $sorter = 'j.Name';
        elseif ($sortby == 'customer')
            $sorter = 'c.FirstName';
        elseif ($sortby == 'startdate')
            $sorter = 'j.StartDate';
        elseif ($sortby == 'enddate')
            $sorter = 'j.EndDate';
        else
            $sorter = 'j.Id';
        if ($this->session->userdata('UserRole') != 'admin' && $this->session->userdata('UserRole') != 'superadmin') {
            $jobs = $this->jobs_model->getUserJobs($condition, $limit, $page, $sorter, $direction, $search_term);
            if ($jobs->num_rows() > 0) {
                $jobs_list = $jobs->result_array();
                //echo $this->db->last_query();
                $total_records = $this->jobs_model->getUserJobsCount($condition, $search_term);
            }
        } else {
            $jobs = $this->jobs_model->getJobs($condition, $limit, $page, $sorter, $direction, $search_term);
            //echo $this->db->last_query();
            if ($jobs->num_rows() > 0) {
                //var_dump($condition);
                $jobs_list = $jobs->result_array();
                $total_records = $this->jobs_model->getJobsCount($condition, $search_term);
            }
        }
        $this->smarty->assign('jobs', $jobs_list);



        $number_of_pages = ceil($total_records / $limit);
        $url = $this->host_url . '/index.php/jobs';

        $this->smarty->assign('sortby', $sortby);
        $this->smarty->assign('direction', $direction);
        $this->smarty->assign('total_records', $total_records);
        $this->smarty->assign('number_of_pages', $number_of_pages);
        $this->smarty->assign('current_page', $page);
        $this->smarty->assign('limit', $limit);
        $this->smarty->assign('url', $url);

        $fN_sess = '';
        $fN_sess = $this->session->userdata('response');


        $this->smarty->assign('fN_sess', $fN_sess);

        $this->smarty->display('jobs/jobs_list.tpl');
    }

    public function myjobs ($page = 1, $sortby = '', $direction = 'desc') {
        $condition = ['jd.DispatchOpen'=>'open'];
        $project_type = [];
        $project_status = [];
        $queries = [];
        $query_term = '';
        $limit = $this->config->item('page_limit');
        $search_term = $query_term = '';
        if (!empty($_SERVER['QUERY_STRING'])) {
            parse_str($this->encrypt->decode($_SERVER['QUERY_STRING']), $queries);
            $query_term = '?';
            if (!empty($queries)) {
                foreach ($queries as $name => $value) {
                    $query_term .= "$name=$value";
                }
            }
        }
        $this->smarty->assign('query_term', $_SERVER['QUERY_STRING']);

        $search_term = !empty($queries['search_term']) ? $queries['search_term'] : '';
        $this->smarty->assign('search_term', $search_term);
        $jobs_list = [];
        $total_records = 0;
        if ($direction != 'asc') $direction = 'desc';
        // var_dump($sortby);
        if ($sortby == 'name')
            $sorter = 'j.Name';
        elseif ($sortby == 'dispatchname')
            $sorter = 'jd.DispatchName';
        elseif ($sortby == 'customer')
            $sorter = 'c.FirstName';
        elseif ($sortby == 'dispatchdate')
            $sorter = 'jd.DispatchedDate';
        else
            $sorter = 'jd.Id';

        $jobs = $this->jobs_model->getUserDispatchedJobs($condition, $limit, $page, $sorter, $direction, $search_term);
        if ($jobs->num_rows() > 0) {
            $jobs_list = $jobs->result_array();

            //echo $this->db->last_query();
            //var_dump($jobs_list);
            $total_records = $this->jobs_model->getUserDispatchedJobsCount($condition, $search_term);
        }

        $this->smarty->assign('jobs', $jobs_list);

        $number_of_pages = round($total_records / $limit);
        $url = $this->host_url . '/index.php/jobs';

        $this->smarty->assign('sortby', $sortby);
        $this->smarty->assign('direction', $direction);
        $this->smarty->assign('total_records', $total_records);
        $this->smarty->assign('number_of_pages', $number_of_pages);
        $this->smarty->assign('current_page', $page);
        $this->smarty->assign('limit', $limit);
        $this->smarty->assign('url', $url)  ;
        $this->smarty->display('jobs/myjobs_list.tpl');
    }

    public function encrypt()
    {
        $post_value = $this->input->get();
        $query = '';
        if ($this->session->userdata('UserRole') != 'admin' && $this->session->userdata('UserRole') != 'superadmin') {
            $url = $this->host_url . '/index.php/jobs/myjobs/?';
        } else {
            $url = $this->host_url . '/index.php/jobs/index/?';
        }
        
        if (!empty($post_value)) {
            $count = 0;
            foreach ($post_value as $key => $value) {
                if ($count > 0) {
                    $query .= '&';
                }
                if (is_array($value)) {
                    $v = '(';
                    $i = 0;
                    foreach ($value as $val) {
                        if ($i == 0) {
                            $v .= $val;
                        } else {
                            $v .= ',' . $val;
                        }
                        $i++;
                    }
                    $v .= ')';
                    $query .= "$key=$v";
                } else {
                    $query .= "$key=$value";
                }
                $count++;
            }
        }
        $encrypted = !empty($query) ? $this->encrypt->encode($query) : '';
        $url .= $encrypted;
        redirect($url);
    }

    public function add()
    {

        $condition = [];
        $contact = [];
        if (isset($_GET["cid"]) && $_GET["cid"] > 0) {
            $conditionContact = $contact = [];
            $conditionContact = ['Id' => $_GET["cid"]];
            $contactList = $this->contact_model->get_contact($conditionContact);
            $contactRes = $contactList->result_array();
            $contact = $contactRes[0];
        }
        $this->smarty->assign('contactDetail', $contact);
        $this->smarty->assign('currentmenu', 'basic');  //for highlighting left menu
        $this->get_employee();

        $condition = [];
        $condition = ["Status" => "1"];
        $users = $this->user_model->get_user($condition);
        if ($users->num_rows() > 0) {
            $users_list = $users->result_array();
            $user_records = $this->user_model->get_user_count($condition);
        } else {
            $user_records = $users_list = 0;
        }
        $condition = [];
        $condition = ['ContactCategory' => 'Customer', 'IsActive' => '1'];
        $contact_list = $this->contact_model->get_contact($condition)->result_array();
        $this->smarty->assign('contact_list', $contact_list);
        $this->smarty->assign('users_list', $users_list);
        $this->smarty->assign('user_records', $user_records);
        $this->smarty->assign('today_date', date("Y-m-d"));
        $fN_sess = '';
        $fN_sess = $this->session->userdata('response');


        $this->smarty->assign('fN_sess', $fN_sess);
        $this->smarty->display('jobs/jobs_add.tpl');

        //die("asf");
    }



    public function insertJob()
    {

        //setup reoccurence
        if ($this->input->post('isRecurring') == "Yes") {
            $datesSelecteds = $this->input->post('hidDates');
            $datess = explode(",", $datesSelecteds);
            $jobStartDate = reset($datess);
            $jobEndDate = end($datess);
        } else {
            $jobStartDate = $this->input->post('startdate') ? $this->input->post('startdate') : null;
            $jobEndDate = $this->input->post('enddate') ? $this->input->post('enddate') : null;
        }
        //var_dump($this->input->post('project_type'),$jobStartDate,$jobEndDate,$datess,$this->input->post('hidDates'));die();
        $param = [];
        if ($this->input->post('hidOccurenceType') == "daily") {
            $param["occurence"] = "daily";
            $param["interval"] = $this->input->post('dailyInterval');
            $param["start"] = $this->input->post('dailyStart');
            $param["endType"] = $this->input->post('dailyEndType');
            $param["dailyDays"] = $this->input->post('dailyDays');
            if ($this->input->post('dailyEndType') == "on") {
                $param["end"] = $this->input->post('dailyEnd');
            }
            if ($this->input->post('dailyEndType') == "after") {
                $param["after"] = $this->input->post('dailyAfter');
            }
        } else if ($this->input->post('hidOccurenceType') == "weekly") {
            $param["occurence"] = "weekly";

            $param["inputDays"] = $this->input->post('inputDays');
            $param["days"] = $this->input->post('weeklyDays');
            $param["start"] = $this->input->post('weeklyStart');
            $param["endType"] = $this->input->post('weeklyEndType');

            if ($this->input->post('weeklyEndType') == "on") {
                $param["end"] = $this->input->post('weeklyEnd');
            }
            if ($this->input->post('weeklyEndType') == "after") {
                $param["after"] = $this->input->post('weeklyAfter');
            }
        } else if ($this->input->post('hidOccurenceType') == "monthly") {
            // var_dump($_POST);die();
            $param["occurence"] = "monthly";
            $param["onDay"] = $this->input->post('inputDays');
            $param["startDate"] = $this->input->post('monthlyStartDate');
            $param["monthlyDay"] = $this->input->post('monthlyDay');
            $param["monthlyInterval"] = $this->input->post('monthlyInterval');
            $param["monthlyEndType"] = $this->input->post('monthlyEndType');
            $param["monthlyAfter"] = $this->input->post('monthlyAfter');
        }

        //reoccurence end
        $user_id = $this->session->userdata('UserId');
        $date = date('Y/m/i h:i:s');
        $project = [];
        $data = [
            'Status' => $this->input->post('status') ? $this->input->post('status') : 'Active',
            'Name' => $this->input->post('project_name') ? $this->input->post('project_name') : null,
            'ContactId' => $this->input->post('customer_id') ? $this->input->post('customer_id') : null,
            'Address1' => $this->input->post('address') ? $this->input->post('address') : null,
            'Suburb' => $this->input->post('suburb') ? $this->input->post('suburb') : null,
            'City' => $this->input->post('city') ? $this->input->post('city') : null,
            'PostCode' => $this->input->post('postcode') ? $this->input->post('postcode') : null,
            'Description' => $this->input->post('description') ? $this->input->post('description') : null,
            'JobType' => $this->input->post('project_type') == 'Contract' ? 'Contract' : 'Non-Contract',
            'AgreedFrequency' => $this->input->post('agreed_frequency'),
            'FrequencyHours' => $this->input->post('frequency_hours') ? $this->input->post('frequency_hours') : '',
            'ContractHours' => $this->input->post('contract_hours') ? $this->input->post('contract_hours') : '',
            'IsRecurring' => $this->input->post('isRecurring') == 'Yes' ? 'Yes' : 'No',
            'OrderId' => $this->input->post('order_no') ? $this->input->post('order_no') : null,
            'JobCode' => $this->input->post('job_no') ? $this->input->post('job_no') : null,
            'StartDate' => $jobStartDate,
            'EndDate' =>  $jobEndDate,
            'Notes' => $this->input->post('notes') ? $this->input->post('notes') : null,
            'ContactId' => $this->input->post('customer_id') ? $this->input->post('customer_id') : null,
            'JobStatus' => $this->input->post('job_status') ? $this->input->post('job_status') : null,
            'BillingType' => $this->input->post('selBilling') ? $this->input->post('selBilling') : null,
            'Configurations' => json_encode($param)
        ];
        //
        $data['AddedOn'] = date('Y-m-d H:i:s');
        $data['AddedBy'] = $this->session->userdata('UserId');
        $data['ModifiedOn'] = date('Y-m-d H:i:s');
        $data['ModifiedBy'] = $this->session->userdata('UserId'); {
            $inserted_id = $this->jobs_model->insertJob($data);
        }

        //  var_dump($data);



        // add job resources

        $jobStartDate = $this->input->post('startdate');
        $jobEndDate = $this->input->post('enddate');



        if ($this->input->post('isRecurring') == "Yes") {
            $datesSelected = $this->input->post('hidDates');
            $dates = explode(",", $datesSelected);
        } else
            $dates = $this->dateRange($jobStartDate, $jobEndDate);




        foreach ($this->input->post('hidResourceCount') as $key => $value) {
            $roles[] = $this->input->post("options_" . $value);
            $resourcesVal[] = $this->input->post("selResouces_" . $value);
        }
        foreach ($dates as $dt) { {
                # code...
                {
                    $resources["JobId"] = $inserted_id;
                    $resources["DispatchName"] = $this->input->post('project_name') . "-" . $dt;
                    $resources["BillingType"] = $this->input->post('selBilling') ? $this->input->post('selBilling') : null;
                    // $resources["ResourceId"]=$resourcesvalue;                
                    //$resources["RoleId"]=$roles[$resourcekey];
                    $resources['AddedOn'] = date('Y-m-d H:i:s');
                    $resources['AddedBy'] = $this->session->userdata('UserId');
                    $resources['ModifiedOn'] = date('Y-m-d H:i:s');
                    $resources['ModifiedBy'] = $this->session->userdata('UserId');
                    $resources["DispatchedDate"] = $dt;
                    $this->db->insert('JobDispatch', $resources);
                    $newJDid = $this->db->insert_id();
                    foreach ($resourcesVal as $resourcekey => $resourcesvalue) {
                        $userJobDispatch["JobDispatchId"] = $newJDid;
                        $userJobDispatch["ResourceId"] = $resourcesvalue;
                        $userJobDispatch["RoleId"] = $roles[$resourcekey];
                        $userJobDispatch["DispatchedDate"] = $dt;
                        $userJobDispatch["JobId"] = $inserted_id;
                        $userJobDispatch['AddedOn'] = date('Y-m-d H:i:s');
                        $userJobDispatch['AddedBy'] = $this->session->userdata('UserId');
                        $userJobDispatch['ModifiedOn'] = date('Y-m-d H:i:s');
                        $userJobDispatch['ModifiedBy'] = $this->session->userdata('UserId');
                        $newUserJobDispatch = $this->db->insert('UserJobDispatch', $userJobDispatch);
                    }
                }
            }
        }
        $this->session->set_flashdata('response', "Job Inserted Successfully");

        // var_dump($roles);
        //redirect($this->host_url . "/index.php/jobs");
        redirect($this->host_url."/index.php/jobs/edit/$inserted_id");
    }

    public function dateRange($from, $to)
    {
        return array_map(function ($arg) {
            return date('Y-m-d', $arg);
        }, range(strtotime($from), strtotime($to), 86400));
    }

    public function jobDetail($id = "")
    {
        $condition = ['j.Id' => $id];
        //job lists
        if ($this->session->userdata('UserRole') != 'admin' && $this->session->userdata('UserRole') != 'superadmin') {
            $jobs = $this->jobs_model->getUserJobs($condition);
        } else
            $jobs = $this->jobs_model->getJobs($condition);
        $job = $jobs->result_array();

        //if user tries to access by changing id in url
        if ($this->session->userdata('UserRole') != 'admin' && $this->session->userdata('UserRole') != 'superadmin'  && count($job) <= 0) {
            $this->session->set_flashdata('response', "You Cannot Access it.");

            redirect($this->host_url . "/index.php/jobs");
        }
        $full_address = $job[0]['Address1'] . $job[0]['Suburb'] . $job[0]['City'];
        $full_address = urlencode($full_address);
        $this->smarty->assign('full_address', $full_address);
        $this->smarty->assign('job', $job[0]);

        //logged timesheets
        $condition = $currtimesheet = [];
        /* $condition = ['TimeSheet.JobId' => $id];
        $currtimesheet_list = $this->timesheet_model->get_timesheets($condition);

        $currtimesheet_res = $currtimesheet_list->result_array();
        foreach ($currtimesheet_res as $currtimesheetkey => $currtimesheetvalue) {
            $currtimesheet[]=$currtimesheetvalue;
        }*/

        //allocated resources
        $condition = $currjobresouces = $currjobresoucesId = [];
        $condition = ['J.Id' => $id, 'jr.IsAdhoc' => 0, 'jr.DispatchOpen' => 'open'];
        $currjobresouces_list = $this->jobs_model->getResources($condition, '', '');
        // echo $this->db->last_query();
        $currjobresouces_res = $currjobresouces_list->result_array();
        foreach ($currjobresouces_res as $currjobresoucekey => $currjobresoucevalue) {
            $currjobresouces[] = $currjobresoucevalue;
            $currjobresoucesId[] = $currjobresoucevalue["ResourceId"];
        }
        //var_dump($currjobresouces,$currjobresoucesId);

        //uploaded files
        $condition = [];
        $condition = ['JobId' => $id];
        $files = $this->jobs_model->getFiles($condition);
        if ($files->num_rows() > 0) {
            $files_list = $files->result_array();
            $files_records = $this->jobs_model->getFilesCount($condition);
        } else {
            $files_records = $files_list = 0;
        }
        //var_dump($files_list,$files_records);
        $this->smarty->assign('currtimesheets', $currtimesheet);

        $this->smarty->assign('files_list', $files_list);
        $this->smarty->assign('files_records', $files_records);


        $this->smarty->assign('currjobresouces', $currjobresouces);
        $this->smarty->assign('currjobresoucesId', $currjobresoucesId);
        $fN_sess = '';
        $fN_sess = $this->session->userdata('response');

        $this->smarty->assign('currentmenu', 'basic'); //for highlighting left menu
        $this->smarty->assign('fN_sess', $fN_sess);
        $this->smarty->display('jobs/job_view.tpl');
    }



    public function edit($id = "")
    {

        $condition = ['j.Id' => $id];
        $jobs = $this->jobs_model->getJobs($condition);

        $job = $jobs->result_array();
        if (isset($job[0]["Configurations"]) && $job[0]["Configurations"] != "")
            $configurations = json_decode($job[0]["Configurations"]);
        else
            $configurations[] = "";

        if (!empty($configurations) && $configurations->occurence == "weekly") {
            $selectedDays = explode(",", $configurations->days);
        } else {
            $selectedDays = array();
        }
        //var_dump($configurations,$selectedDays);
        //if user tries to access by changing id in url
        if ($this->session->userdata('UserRole') != 'admin' && $this->session->userdata('UserRole') != 'superadmin') {
            $this->session->set_flashdata('response', "You Cannot Access it.");

            redirect($this->host_url . "/index.php/jobs");
        }

        $contact = [];
        if (isset($_GET["cid"]) && $_GET["cid"] > 0) {
            $conditionContact = $contact = [];
            $conditionContact = ['Id' => $_GET["cid"]];
            $contactList = $this->contact_model->get_contact($conditionContact);
            $contactRes = $contactList->result_array();
            $contact = $contactRes[0];
        }

        $this->smarty->assign('job', $job[0]);
        $this->smarty->assign('contactDetail', $contact);
        $this->smarty->assign('currentmenu', 'basic');  //for highlighting left menu
        $this->get_employee();
        $condition = ['ContactCategory' => 'Customer', 'IsActive' => '1'];
        $contact_list = $this->contact_model->get_contact($condition)->result_array();

        $resourceHtml = $options = '';
        $i = 1;


        $condition = [];
        $condition = ["Status" => "1"];
        $users = $this->user_model->get_user($condition);
        if ($users->num_rows() > 0) {
            $users_list = $users->result_array();
            $user_records = $this->user_model->get_user_count($condition);
        } else {
            $user_records = $users_list = 0;
        }

        $condition = $currjobresouces = [];

        $currjobresouces['resourceId'][] = $currjobresouces['roleId'][] = '';

        $condition = ['J.Id' => $id, 'jr.IsAdhoc' => 0, 'jr.DispatchOpen' => 'open'];
        $currjobresouces_list = $this->jobs_model->getResources($condition, '', '');
        // echo $this->db->last_query();
        $currjobresouces_res = $currjobresouces_list->result_array();
        if (count($currjobresouces_res) > 0) {
            $currjobresouces = [];
            foreach ($currjobresouces_res as $currjobresoucekey => $currjobresoucevalue) {
                $currjobresouces['resourceId'][] = $currjobresoucevalue['ResourceId'];
                $currjobresouces['roleId'][] = $currjobresoucevalue['RoleId'];
            }
        }
        //generate html to displa in detail page
        foreach ($currjobresouces['resourceId'] as $keyjobresouces => $valuejobresouces) {
            $options = $rdEmployee = $rdSupervisor = '';
            foreach ($users_list as $value) {
                if ($value["UserId"] == $valuejobresouces) {
                    $sel = ' selected="selected" ';
                } else $sel = '';
                $options .= '<option value="' . $value["UserId"] . '" ' . $sel . ' >' . $value["FirstName"] . ' ' . $value["LastName"] . '</option> ';
            }
            //var_dump($currjobresouces['roleId'][$keyjobresouces]);
            if ($currjobresouces['roleId'][$keyjobresouces] == "Employee") {
                $rdEmployee = " checked='checked' ";
            } else $rdSupervisor = " checked='checked' ";
            $resourceHtml .= '<div class="element" id="div_' . $i . '"><div class="form-group row"><div class="col-sm-4"><select class="form-control" id="selResouces_' . $i . '" name="selResouces_' . $i . '"><option selected="selected" value="">Select Resources</option>' . $options . '  </select></div><div class="col-sm-4"><div class="btn-group btn-group-toggle" data-toggle="buttons"><label class="btn btn-sm btn-tertiary active"><input type="radio" name="options_' . $i . '" id="option_row1a"  value="Employee"' . $rdEmployee . '> Employee</label><label class="btn btn-sm btn-tertiary"><input type="radio" name="options_' . $i . '" id="option_row1b" value="Supervisor" ' . $rdSupervisor . '> Supervisor</label></div></div><div class="col-sm-4"><a href="javascript:void(0);" class="remove btn btn-sm" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Delete" id="remove_' . $i . '" ><i class="active icofont-ui-delete"></i> Delete</a><input type="hidden" value="' . $i . '" id="hidResourceCount" name="hidResourceCount[]"></div> </div> </div>';
            $i++;
        }
        $this->smarty->assign('currentmenu', 'basic'); //for highlighting left menu
        $this->smarty->assign('configurations', $configurations);
        $this->smarty->assign('resourceHtml', $resourceHtml);
        $this->smarty->assign('contact_list', $contact_list);
        $this->smarty->assign('selectedDays', $selectedDays);
        $this->smarty->display('jobs/jobs_edit.tpl');

        //die("asf");
    }



    public function editJob($id = "")
    {
        if ($this->input->post('isRecurring') == "Yes") {
            $datesSelecteds = $this->input->post('hidDates');
            $datess = explode(",", $datesSelecteds);
            $jobStartDate = reset($datess);
            $jobEndDate = end($datess);
        } else {
            $jobStartDate = $this->input->post('startdate') ? $this->input->post('startdate') : null;
            $jobEndDate = $this->input->post('enddate') ? $this->input->post('enddate') : null;
        }
        $param = [];
        if ($this->input->post('hidOccurenceType') == "daily") {
            $param["occurence"] = "daily";
            $param["interval"] = $this->input->post('dailyInterval');
            $param["start"] = $this->input->post('dailyStart');
            $param["endType"] = $this->input->post('dailyEndType');
            $param["dailyDays"] = $this->input->post('dailyDays');
            if ($this->input->post('dailyEndType') == "on") {
                $param["end"] = $this->input->post('dailyEnd');
            }
            if ($this->input->post('dailyEndType') == "after") {
                $param["after"] = $this->input->post('dailyAfter');
            }
        } else if ($this->input->post('hidOccurenceType') == "weekly") {
            $param["occurence"] = "weekly";
            $param["days"] = $this->input->post('weeklyDays');
            $param["start"] = $this->input->post('weeklyStart');
            $param["endType"] = $this->input->post('weeklyEndType');

            if ($this->input->post('weeklyEndType') == "on") {
                $param["end"] = $this->input->post('weeklyEndType');
            }
            if ($this->input->post('weeklyEndType') == "after") {
                $param["after"] = $this->input->post('weeklyAfter');
            }
        } else if ($this->input->post('hidOccurenceType') == "monthly") {
        }

        //if user tries to access by changing id in url
        if ($this->session->userdata('UserRole') != 'admin' && $this->session->userdata('UserRole') != 'superadmin') {
            $this->session->set_flashdata('response', "You Cannot Access it.");

            redirect($this->host_url . "/index.php/jobs");
        }
        $user_id = $this->session->userdata('UserId');
        $date = date('Y/m/i h:i:s');
        $project = [];
        $data = [
            'Status' => $this->input->post('status') ? $this->input->post('status') : 'Active',
            'Name' => $this->input->post('project_name') ? $this->input->post('project_name') : null,
            'ContactId' => $this->input->post('customer_id') ? $this->input->post('customer_id') : null,
            'Address1' => $this->input->post('address') ? $this->input->post('address') : null,
            'Suburb' => $this->input->post('suburb') ? $this->input->post('suburb') : null,
            'City' => $this->input->post('city') ? $this->input->post('city') : null,
            'PostCode' => $this->input->post('postcode') ? $this->input->post('postcode') : null,
            'Description' => $this->input->post('description') ? $this->input->post('description') : null,
            'JobType' => $this->input->post('project_type') ? $this->input->post('project_type') : 'Non-Contract',
            'AgreedFrequency' => $this->input->post('agreed_frequency'),
            'FrequencyHours' => $this->input->post('frequency_hours') ? $this->input->post('frequency_hours') : '',
            'ContractHours' => $this->input->post('contract_hours') ? $this->input->post('contract_hours') : '',
            'OrderId' => $this->input->post('order_no') ? $this->input->post('order_no') : null,
            'JobCode' => $this->input->post('job_no') ? $this->input->post('job_no') : null,
            'StartDate' => $this->input->post('startdate') ? $this->input->post('startdate') : null,
            'EndDate' => $this->input->post('enddate') ? $this->input->post('enddate') : null,
            'Notes' => $this->input->post('notes') ? $this->input->post('notes') : null,
            'ContactId' => $this->input->post('customer_id') ? $this->input->post('customer_id') : null,
            'JobStatus' => $this->input->post('job_status') ? $this->input->post('job_status') : null,
            'BillingType' => $this->input->post('selBilling') ? $this->input->post('selBilling') : null,
            'Configurations' => json_encode($param)
        ];

        $data['ModifiedOn'] = date('Y-m-d H:i:s');
        $data['ModifiedBy'] = $this->session->userdata('UserId');

        if ($this->input->post('isRecurring') == "Yes") {
            $datesSelected = $this->input->post('hidDates');
            $dates = explode(",", $datesSelected);
        } else
            $dates = $this->dateRange($jobStartDate, $jobEndDate);
        $condition = ['Id' => $id];
        $inserted_id = $id;
        $this->jobs_model->updateJob($data, $condition);


        // delete and add job resources
        $this->db->select('Id');
        $this->db->from('JobDispatch');
        $this->db->where('JobId', $id);
        $this->db->where('IsAdhoc', 0);
        $jd_id = $this->db->get_compiled_select();

        $this->db->where("JobDispatchId in ($jd_id)", NULL, FALSE);
        $this->db->where('DispatchedDate > ', date("Y-m-d"));
        $this->db->where('TimeLogged <> 1');
        $this->db->where('JobId', $id);

        $this->db->delete('UserJobDispatch');

        $jobStartDate = $this->input->post('startdate');
        $jobEndDate = $this->input->post('enddate');

        foreach ($this->input->post('hidResourceCount') as $key => $value) {
            $roles[] = $this->input->post("options_" . $value);
            $resourcesVal[] = $this->input->post("selResouces_" . $value);
        }

        $dataDispatch["DispatchOpen"]="closed";
        $this->db->where('JobId', $id);
        $this->db->where('IsAdhoc', 0);
        $this->db->where('IsDeleted', '0');
        $this->db->where('Timelogged', '0');
        $this->db->where('DispatchOpen', 'open');
        $this->db->where('DispatchedDate > ', date("Y-m-d"));
        $this->db->delete('JobDispatch');
        foreach ($dates as $dt)
        {
            $sql = "select * from JobDispatch jd where jd.JobId = $id and jd.IsDeleted='1' and jd.DispatchOpen='open' and jd.DispatchedDate='$dt'";
            $test = $this->db->query($sql);
            if (strtotime($dt) > strtotime(date("Y-m-d")) && (($test->num_rows() <= 0) || count($test->result_array()) <= 0)) {
                $sechcondition["DispatchedDate"] = $dt;
                $sechcondition["jr.JobId"] = $id;
                {
                    $resources["JobId"] = $id;
                    $resources["DispatchName"] = $this->input->post('project_name') . "-" . $dt;
                    $resources["BillingType"] = $this->input->post('selBilling') ? $this->input->post('selBilling') : null;
                    $resources['AddedOn'] = date('Y-m-d H:i:s');
                    $resources['AddedBy'] = $this->session->userdata('UserId');
                    $resources['ModifiedOn'] = date('Y-m-d H:i:s');
                    $resources['ModifiedBy'] = $this->session->userdata('UserId');
                    $resources["DispatchedDate"] = $dt;
                    $resources["DispatchOpen"] ="open";
                    $this->db->insert('JobDispatch', $resources);
                    $newJDid = $this->db->insert_id();
                }
                foreach ($resourcesVal as $resourcekey => $resourcesvalue) {
                    $userJobDispatch["JobDispatchId"] = $newJDid;
                    $userJobDispatch["ResourceId"] = $resourcesvalue;
                    $userJobDispatch["RoleId"] = $roles[$resourcekey];
                    $userJobDispatch["DispatchedDate"] = $dt;
                    $userJobDispatch["JobId"] = $inserted_id;
                    $userJobDispatch['AddedOn'] = date('Y-m-d H:i:s');
                    $userJobDispatch['AddedBy'] = $this->session->userdata('UserId');
                    $userJobDispatch['ModifiedOn'] = date('Y-m-d H:i:s');
                    $userJobDispatch['ModifiedBy'] = $this->session->userdata('UserId');
                    $newUserJobDispatch = $this->db->insert('UserJobDispatch', $userJobDispatch);
                    
                }
            }
        }

        $this->session->set_flashdata('response', "Job Updated Successfully");
        redirect($this->host_url."/index.php/jobs");
    }



    function deleteJob($jobId = "")
    {


        $this->db->where('Id', $jobId);
        $res = $this->db->delete('Jobs');
        $this->db->where('JobId', $jobId);
        $res1 = $this->db->delete('JobDispatch');
        $this->db->where('JobId', $jobId);
        $res1 = $this->db->delete('UserJobDispatch');
        $this->session->set_flashdata('response', "Job Deleted Successfully");

        redirect($this->host_url . "/index.php/jobs/1/name/desc");
    }

    private function get_employee()
    {
        $user_list = [];
        $users = $this->user_model->get_user(['UserRole' => 'employee']);
        if ($users->num_rows() > 0) {
            $user_list = $users->result_array();
        }
        $this->smarty->assign('users', $user_list);
    }

    public function addJobDocuments()
    {
        $file_path = './uploads/jobs/';
        $date = date('Y-m-d');
        if (!is_dir($file_path)) {
            mkdir($file_path, 0777, TRUE);
        }
        $config['upload_path']          = $file_path;
        $config['allowed_types']        = 'gif|jpg|png|jpeg';
        $config['max_size']             = 1024;
        $preName = $this->session->userdata('FirstName') . "_" . $this->session->userdata('LastName');
        $preName = preg_replace('/\s+/', '_', $preName);
        $config['file_name']             = strtolower($preName . "_" . time() . "_" . $_FILES["flJob"]['name']);
        $config['file_ext_tolower']      = true;


        $this->load->library('upload', $config);

        if (!$this->upload->do_upload('flJob')) {
            $upload_data = array('error' => $this->upload->display_errors());

            $this->session->set_flashdata('response', $upload_data["error"]);

            redirect($this->host_url . "/index.php/jobs/jobDetail/" . $this->input->post('hidJid'));
        } else {
            $upload_data = $this->upload->data();
            $data = [
                'Name' => strtolower($upload_data['file_name']),
                'ResourceId' => $this->session->userdata('UserId'),
                'JobId' =>  $this->input->post('hidJid'),
                'ProjectId' =>  $this->input->post('hidPid'),
                'AddedBy' => $this->session->userdata('UserId'),
                'AddedOn' => date('Y/m/d h:i:s'),
                'ModifiedBy' => $this->session->userdata('UserId'),
                'ModifiedOn' => date('Y/m/d h:i:s')
            ];

            $this->db->insert('JobFiles', $data);
            $this->session->set_flashdata('response', "File Uploaded Successfully.");
            // if($this->session->userdata('UserRole')=='member')
            //http://localhost/index.php/user-view-job-detail/91      
            redirect($this->host_url . "/index.php/jobs/jobDetail/" . $this->input->post('hidJid'));

            // else
            //redirect($this->host_url."/index.php/jobs");
        }
    }




    public function addDispatchDocuments()
    {
        $file_path = './uploads/jobs/';
        $date = date('Y-m-d');
        if (!is_dir($file_path)) {
            mkdir($file_path, 0777, TRUE);
        }
        $config['upload_path']          = $file_path;
        $config['allowed_types']        = 'gif|jpg|png|jpeg';
        $config['max_size']             = 1024;
        $preName = $this->session->userdata('FirstName') . "_" . $this->session->userdata('LastName');
        $preName = preg_replace('/\s+/', '_', $preName);
        $config['file_name']             = strtolower($preName . "_" . time() . "_" . $_FILES["flJob"]['name']);
        $config['file_ext_tolower']      = true;


        $this->load->library('upload', $config);

        if (!$this->upload->do_upload('flJob')) {
            $upload_data = array('error' => $this->upload->display_errors());

            $this->session->set_flashdata('response', $upload_data["error"]);

            redirect($this->host_url . "/index.php/jobs/jobDetail/" . $this->input->post('hidJid'));
        } else {
            $upload_data = $this->upload->data();
            $data = [
                'Name' => strtolower($upload_data['file_name']),
                'ResourceId' => $this->session->userdata('UserId'),
                'DispatchId' =>  $this->input->post('hidJrid'),
                'AddedBy' => $this->session->userdata('UserId'),
                'AddedOn' => date('Y/m/d h:i:s'),
                'ModifiedBy' => $this->session->userdata('UserId'),
                'ModifiedOn' => date('Y/m/d h:i:s')
            ];

            $this->db->insert('JobDispatchFiles', $data);
            $this->session->set_flashdata('response', "File Uploaded Successfully.");
            // if($this->session->userdata('UserRole')=='member')
            //http://localhost/index.php/user-view-job-detail/91      
            redirect($this->host_url . "/index.php/jobs/jobDispatchDetail/" . $this->input->post('hidJrid'));

            // else
            //redirect($this->host_url."/index.php/jobs");
        }
    }

    function deleteJobResource($userId = "", $jobId = "")
    {

        //if user tries to access by changing id in url
        if ($this->session->userdata('UserRole') != 'admin' && $this->session->userdata('UserRole') != 'superadmin') {
            $this->session->set_flashdata('response', "You Cannot Access it.");

            redirect($this->host_url . "/index.php/jobs");
        }
        $this->db->where('DispatchedDate >= ', date("Y-m-d"));
        $this->db->where('TimeLogged <> 1 ');
        $this->db->where('JobId', $jobId);
        $this->db->where('ResourceId', $userId);
        $res1 = $this->db->delete('UserJobDispatch');
        //var_dump($res,$res1);
        $this->session->set_flashdata('response', "Job Resource Deleted Successfully");
        //die("asf");

        redirect($this->host_url . "/index.php/jobs/jobDetail/" . $jobId);
    }

    public function dispatchedJobs($jobId = '', $page = 1, $sortby = 'date', $direction = 'desc', $deleted = '0')
    {

        //var_dump($page,$sortby,$direction);
        $condition = [];
        $project_type = [];
        $project_status = [];
        $queries = [];
        $query_term = '';
        $limit = $this->config->item('page_limit');
        $search_term = $query_term = '';
        if (isset($_GET["search_term"])) {
            $search_term = !empty($_GET['search_term']) ? $_GET['search_term'] : '';
        }
        if (isset($_GET["project_type"]) && count($_GET["project_type"]) > 0) {
            $or = "";
            foreach ($queries as $name => $value) {
                $query_term .= "$name=$value";
            }
        }

        if (!empty($_GET['project_type'])) {
            $project_type = $_GET["project_type"];
            $condition['JobType'] = $project_type;
        }

        if (!empty($_GET['project_status'])) {
            $project_status = $_GET['project_status'];
            $condition['Status'] = $project_status;
        }

        if (!empty($_SERVER['QUERY_STRING'])) {
            parse_str($this->encrypt->decode($_SERVER['QUERY_STRING']), $queries);
            $query_term = '?';
            if (!empty($queries)) {
                foreach ($queries as $name => $value) {
                    $query_term .= "$name=$value";
                }
            }
        }
        if ($this->session->userdata('UserRole') != 'admin' && $this->session->userdata('UserRole') != 'superadmin') {
        }
        $this->smarty->assign('query_term', $_SERVER['QUERY_STRING']);
        $this->smarty->assign('search_term', $search_term);
        $this->smarty->assign('project_type', $project_type);
        $this->smarty->assign('project_status', $project_status);


        $condition['JobId'] = $jobId;
        $condition['DispatchOpen'] ="open";
        $condition['IsDeleted'] = $deleted;

        /* nwe start*/
        //name customer startdate enddate
        $jobs_list = [];
        $total_records = 0;
        if ($direction != 'asc') { 
            $direction = 'desc';
        } else {
            $direction = 'asc';
        }

        if ($sortby == 'date') {
            $sorter = 'jd.DispatchedDate';
        } elseif ($sortby == 'name') {
            $sorter = 'jd.DispatchedDate';
        }

        $job = $this->jobs_model->getJobs(['j.Id' => $jobId])->row_array();
        $this->smarty->assign('job_details', $job);
        if ($this->session->userdata('UserRole') != 'admin' && $this->session->userdata('UserRole') != 'superadmin') {
            $jobs = $this->jobs_model->getUserDispatchedJobs($condition, $limit, $page, $sorter, $direction, $search_term);
            
            if ($jobs->num_rows() > 0) {
                $jobs_list = $jobs->result_array();
                $total_records = $this->jobs_model->getUserDispatchedJobsCount($condition, $search_term);
            }
        } else {
            $jobs = $this->jobs_model->getDispatchedJobs($condition, $limit, $page, $sorter, $direction, $search_term);
            if ($jobs->num_rows() > 0) {
                $jobs_list = $jobs->result_array();
                $total_records = $this->jobs_model->getDispatchedJobsCount($condition, $search_term);
            }
        }
        $this->smarty->assign('jobs', $jobs_list);



        $number_of_pages = round($total_records / $limit);
        $url = $this->host_url . '/index.php/jobs/dispatched';

        $this->smarty->assign('currentjob', $jobId);
        $this->smarty->assign('sortby', $sortby);
        $this->smarty->assign('direction', $direction);
        $this->smarty->assign('total_records', $total_records);
        $this->smarty->assign('number_of_pages', $number_of_pages);
        $this->smarty->assign('current_page', $page);
        $this->smarty->assign('limit', $limit);
        $this->smarty->assign('url', $url);

        $fN_sess = '';
        $fN_sess = $this->session->userdata('response');


        $this->smarty->assign('fN_sess', $fN_sess);

        $condition = ["Status" => "1"];
        $users = $this->user_model->get_user($condition);
        if ($users->num_rows() > 0) {
            $users_list = $users->result_array();
            $user_records = $this->user_model->get_user_count($condition);
        } else {
            $user_records = $users_list = 0;
        }
        $this->smarty->assign('users_list', $users_list);

        $this->smarty->display('jobs/jobs_dispatched_list.tpl');


        //die("asf");
    }

    public function jobDispatchDetail($id = "")
    {
        //var_dump($id);
        $currjobresoucesIds = [];
        $currjobresoucesDates = [];
        $condition = ['jd.Id' => $id];
        $jrId = $id;
        //job lists
        if ($this->session->userdata('UserRole') != 'admin' && $this->session->userdata('UserRole') != 'superadmin') {
            $jobs = $this->jobs_model->getUserDispatchedJobs($condition);
        } else
            $jobs = $this->jobs_model->getDispatchedJobs($condition);

        $job = $jobs->result_array();

        //if user tries to access by changing id in url
        if ($this->session->userdata('UserRole') != 'admin' && $this->session->userdata('UserRole') != 'superadmin'  && count($job) <= 0) {
            $this->session->set_flashdata('response', "You Cannot Access it.");

            redirect($this->host_url . "/index.php/jobs");
        }

        $this->smarty->assign('job', $job[0]);
        $id = $job[0]["Id"];
        $condition = $currtimesheet = [];
        $condition = ['TimeSheet.DispatchId' => $id];
        $currtimesheet_list = $this->timesheet_model->getDispatchedTimesheets($condition);
        $currtimesheet_res = $currtimesheet_list->result_array();
        foreach ($currtimesheet_res as $currtimesheetkey => $currtimesheetvalue) {
            $currtimesheet[] = $currtimesheetvalue;
        }

        $condition = $currjobresouces = $currjobresoucesId = [];
        $condition = ['jr.Id' => $jrId];
        $currjobresouces_list = $this->jobs_model->getResources($condition, '', '');
        $currjobresouces_res = $currjobresouces_list->result_array();
        foreach ($currjobresouces_res as $currjobresoucekey => $currjobresoucevalue) {
            $currjobresouces[] = $currjobresoucevalue;
            $currjobresoucesId[] = $currjobresoucevalue["ResourceId"];
        }
        $condition = [];
        $condition = ['J.JobDispatchId' => $jrId];
        $currjobresouces_lists = $this->jobs_model->getResourcesDates($condition, '', '');
        $currjobresouces_ress = $currjobresouces_lists->result_array();
        foreach ($currjobresouces_ress as $currjobresoucekeys => $currjobresoucevalues) {

            $currjobresoucesIds[$currjobresoucevalues["ResourceId"]][] = $currjobresoucevalues["Id"];
            $currjobresoucesDates[$currjobresoucevalues["ResourceId"]][] = $currjobresoucevalues["DispatchedDate"];
        }

        $condition = [];
        $condition = ['DispatchId' => $jrId];
        $files = $this->jobs_model->getDispatchFiles($condition);
        if ($files->num_rows() > 0) {
            $files_list = $files->result_array();
            $files_records = $this->jobs_model->getDispatchFilesCount($condition);
        } else {
            $files_records = $files_list = 0;
        }

        $condition = [];
        $condition = ["Status" => "1"];
        $users = $this->user_model->get_user($condition);
        if ($users->num_rows() > 0) {
            $users_list = $users->result_array();
        } else {
            $user_records = $users_list = 0;
        }
        $this->smarty->assign('users', $users_list);
        $condition = [];

        $this->smarty->assign('currtimesheets', $currtimesheet);

        $this->smarty->assign('files_list', $files_list);
        $this->smarty->assign('files_records', $files_records);


        $this->smarty->assign('currjobresouces', $currjobresouces);
        $this->smarty->assign('currjobresoucesId', $currjobresoucesId);
        $this->smarty->assign('currjobresoucesIds', $currjobresoucesIds);

        $this->smarty->assign('currjobresoucesDate', $currjobresoucesDates);
        $fN_sess = '';
        $fN_sess = $this->session->userdata('response');

        $this->smarty->assign('currentjob', $jrId);
        $this->smarty->assign('jobId', $id);
        $this->smarty->assign('currentmenu', 'basic'); //for highlighting left menu
        $this->smarty->assign('fN_sess', $fN_sess);
        $this->smarty->display('jobs/job_dispatched_view.tpl');
    }

    public function addAdhocJobDispatch()
    {
        /*$job_id = $_GET['jobid'];
        $date = $_GET['date'];
        $resources = [];
        $sql = "select distinct ResourceId, FirstName, LastName from UserJobDispatch ujd join User u on u.UserId=ujd.ResourceId where JobId = $job_id";
        $resource = $this->db->query($sql);
        if ($resource->num_rows > 0) {
            $resources = $resource->result();
        }

        $data = [
            'JobId' => $job_id,
            'DispatchedDate' => $date,
            'DispatchOpen' => 'open', 
            'IsAdhoc' => 1
        ];*/

        $job_id = $this->input->post('JobId');
        $job_name = $this->input->post('JobName');
        $date = $this->input->post('date');

        //$jd = $this->jobs_model->getAllDispatchedJobs(['jr.JobId' => $job_id, 'jr.DispatchedDate' => $date]);
        $sql = "select * from JobDispatch jd where jd.JobId=$job_id and jd.DispatchedDate='$date' and jd.IsDeleted=0";
        $jd = $this->db->query($sql);

        if ($jd->num_rows > 0 || count($jd->result_array()) > 0) {
            $this->session->set_flashdata('response', "Job dispatch not added. Duplicate job dispatch.");
        } else {
            for ($i = 1; $i <= $this->input->post('resource_count'); $i++) {
                $roles[] = $this->input->post("options_" . $i);
                $resourcesVal[] = $this->input->post("selResouces_" . $i);
            }
    
            $resources["JobId"] = $job_id;
            $resources["DispatchName"] = $job_name . "-" . $date;
            $resources["BillingType"] = $this->input->post('selBilling') ? $this->input->post('selBilling') : null;
            // $resources["ResourceId"]=$resourcesvalue;                
            //$resources["RoleId"]=$roles[$resourcekey];
            $resources['AddedOn'] = date('Y-m-d H:i:s');
            $resources['AddedBy'] = $this->session->userdata('UserId');
            $resources['ModifiedOn'] = date('Y-m-d H:i:s');
            $resources['ModifiedBy'] = $this->session->userdata('UserId');
            $resources["DispatchedDate"] = $date;
            $resources["IsAdhoc"] = 1;
            $this->db->insert('JobDispatch', $resources);
            $newJDid = $this->db->insert_id();
            foreach ($resourcesVal as $resourcekey => $resourcesvalue) {
                $userJobDispatch["JobDispatchId"] = $newJDid;
                $userJobDispatch["ResourceId"] = $resourcesvalue;
                $userJobDispatch["RoleId"] = $roles[$resourcekey];
                $userJobDispatch["DispatchedDate"] = $date;
                $userJobDispatch["JobId"] = $job_id;
                $userJobDispatch['AddedOn'] = date('Y-m-d H:i:s');
                $userJobDispatch['AddedBy'] = $this->session->userdata('UserId');
                $userJobDispatch['ModifiedOn'] = date('Y-m-d H:i:s');
                $userJobDispatch['ModifiedBy'] = $this->session->userdata('UserId');
                $newUserJobDispatch = $this->db->insert('UserJobDispatch', $userJobDispatch);
            }
            $this->session->set_flashdata('response', "Adhoc Job Dispatch added Successfully");
        }

        redirect($this->host_url . "/index.php/jobs/dispatched/" . $job_id . "/1/date/desc");
    }


    public function deleteJobDocuments($fid = "")
    {

        $condition = ['Id' => $fid];
        $currFiles = $this->jobs_model->getFiles($condition);
        $currFile = $currFiles->result_array();
        // echo"./uploads/jobs/".$currFile[0]["Name"]; die();
        $did = $currFile[0]["JobId"];
        unlink("./uploads/jobs/" . $currFile[0]["Name"]);
        $this->db->where('Id', $fid);
        $this->db->delete('JobFiles');
        $this->session->set_flashdata('response', "File Deleted Successfully");
        redirect($this->host_url . "/index.php/jobs/jobDetail/" . $did);
    }

    public function deleteJobDispatchDocuments($fid = "")
    {

        $condition = ['Id' => $fid];
        $currFiles = $this->jobs_model->getDispatchFiles($condition);
        $currFile = $currFiles->result_array();
        // echo"./uploads/jobs/".$currFile[0]["Name"]; die();
        $did = $currFile[0]["DispatchId"];
        unlink("./uploads/jobs/" . $currFile[0]["Name"]);
        $this->db->where('Id', $fid);
        $this->db->delete('JobDispatchFiles');
        $this->session->set_flashdata('response', "File Deleted Successfully");
        redirect($this->host_url . "/index.php/jobs/jobDispatchDetail/" . $did);
    }


    public function jobDispatchDateDelete($dateid = "", $currentjob = "", $current_page = "")
    {
        $this->db->where('Id', $dateid);
        $this->db->update('JobDispatch',['IsDeleted' => '1']);
        $this->db->where('DispatchedDate >= ', date("Y-m-d"));
        $this->db->where('TimeLogged <> 1');
        $this->db->where('JobDispatchId', $dateid);
        // $this->db->delete('JobDispatch');
        $this->db->delete('UserJobDispatch');

        $this->session->set_flashdata('response', "Dispatched Job Deleted Successfully");
        redirect($this->host_url . "/index.php/jobs/dispatched/{$currentjob}/{$current_page}/date/desc");
    }
    public function deleteDispatchedDateResource($dateid = "", $currentjob = "", $current_page = "")
    {
        $this->db->where('Id', $dateid);
        $this->db->where('ResourceId', $dateid);
        $this->db->delete('JobDispatch');
        $this->session->set_flashdata('response', "Dispatched Job Resource Deleted Successfully");
        redirect($this->host_url . "/index.php/jobs/dispatched/{$currentjob}/{$current_page}/date/desc");
    }


    public function swapDispatchResourceAjax($newid = "", $oldid = "", $newrole = "")
    {
        $data["ResourceId"] = $newid;
        $data["RoleId"] = $newrole;
        $this->db->where("Id", $oldid);
        $this->db->update('UserJobDispatch', $data);
        // echo $this->db->last_query();die();
        /* $this->db->where('Id', $dateid);
        $this->db->where('ResourceId', $dateid);
        $this->db->delete('JobDispatch');
        $this->session->set_flashdata('response',"Dispatched Job Resource Deleted Successfully");
        redirect($this->host_url."/index.php/jobs/dispatched/{$currentjob}/{$current_page}/date/desc");*/
    }



    public function jobDispatchedDateEdit($id = "")
    {

        $condition = ['j.Id' => $id];
        $jobs = $this->jobs_model->getJobs($condition);

        $job = $jobs->result_array();
        //if user tries to access by changing id in url
        if ($this->session->userdata('UserRole') != 'admin' && $this->session->userdata('UserRole') != 'superadmin') {
            $this->session->set_flashdata('response', "You Cannot Access it.");

            redirect($this->host_url . "/index.php/jobs");
        }

        $contact = [];
        if (isset($_GET["cid"]) && $_GET["cid"] > 0) {
            $conditionContact = $contact = [];
            $conditionContact = ['Id' => $_GET["cid"]];
            $contactList = $this->contact_model->get_contact($conditionContact);
            $contactRes = $contactList->result_array();
            $contact = $contactRes[0];
        }

        $this->smarty->assign('job', $job[0]);
        $this->smarty->assign('contactDetail', $contact);
        $this->smarty->assign('currentmenu', 'basic');  //for highlighting left menu
        $this->get_employee();
        $condition = ['ContactCategory' => 'Customer'];
        $contact_list = $this->contact_model->get_contact($condition)->result_array();

        $resourceHtml = $options = '';
        $i = 1;


        $condition = [];
        $condition = ["Status" => "1"];
        $users = $this->user_model->get_user($condition);
        if ($users->num_rows() > 0) {
            $users_list = $users->result_array();
            $user_records = $this->user_model->get_user_count($condition);
        } else {
            $user_records = $users_list = 0;
        }

        $condition = $currjobresouces = [];

        $currjobresouces['resourceId'][] = $currjobresouces['roleId'][] = '';

        $condition = ['JobId' => $id];
        $currjobresouces_list = $this->jobs_model->getResources($condition, '', '');
        // echo $this->db->last_query();
        $currjobresouces_res = $currjobresouces_list->result_array();
        if (count($currjobresouces_res) > 0) {
            $currjobresouces = [];
            foreach ($currjobresouces_res as $currjobresoucekey => $currjobresoucevalue) {
                $currjobresouces['resourceId'][] = $currjobresoucevalue['ResourceId'];
                $currjobresouces['roleId'][] = $currjobresoucevalue['RoleId'];
            }
        }
        //generate html to displa in detail page
        foreach ($currjobresouces['resourceId'] as $keyjobresouces => $valuejobresouces) {
            $options = $rdEmployee = $rdSupervisor = '';
            foreach ($users_list as $value) {
                if ($value["UserId"] == $valuejobresouces) {
                    $sel = ' selected="selected" ';
                } else $sel = '';
                $options .= '<option value="' . $value["UserId"] . '" ' . $sel . ' >' . $value["FirstName"] . ' ' . $value["LastName"] . '</option> ';
            }
            //var_dump($currjobresouces['roleId'][$keyjobresouces]);
            if ($currjobresouces['roleId'][$keyjobresouces] == "employee") {
                $rdEmployee = " checked='checked' ";
            } else $rdSupervisor = " checked='checked' ";
            $resourceHtml .= '<div class="element" id="div_' . $i . '"><div class="form-group row"><div class="col-sm-4"><select class="form-control" id="selResouces_' . $i . '" name="selResouces_' . $i . '"><option selected="selected" value="">Select Resources</option>' . $options . '  </select></div><div class="col-sm-4"><div class="btn-group btn-group-toggle" data-toggle="buttons"><label class="btn btn-sm btn-tertiary active"><input type="radio" name="options_' . $i . '" id="option_row1a"  value="employee"' . $rdEmployee . '> Employee</label><label class="btn btn-sm btn-tertiary"><input type="radio" name="options_' . $i . '" id="option_row1b" value="supervisor" ' . $rdSupervisor . '> Supervisor</label></div></div><div class="col-sm-4"><a href="javascript:void(0);" class="remove btn btn-sm" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Delete" id="remove_' . $i . '" ><i class="active icofont-ui-delete"></i> Delete</a><input type="hidden" value="' . $i . '" id="hidResourceCount" name="hidResourceCount[]"></div> </div> </div>';
            $i++;
        }
        $this->smarty->assign('currentmenu', 'basic'); //for highlighting left menu
        $this->smarty->assign('resourceHtml', $resourceHtml);
        $this->smarty->assign('contact_list', $contact_list);

        $this->smarty->display('jobs/jobs_edit.tpl');

        //die("asf");
    }
}
