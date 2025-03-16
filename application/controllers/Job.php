<?php
defined('BASEPATH') OR exit('No direct script access allowed');
require_once APPPATH . 'controllers/Common.php';

class Job extends Common {

    public function __construct()
    { 
        parent::__construct();
	
		// Load Model
		$this->load->model(['project_model','job_model','timesheet_model','user_model']);
	
		// Load base_url
		$this->load->helper('url');

    }
    public function getJobList($projectID,$page='1',$sortby='date',$direction='desc'){

        $currjobs=[];
        $limit=$this->config->item('page_limit');

        if($direction!='asc')$direction='desc';
        if($sortby=='date')
            $sorter='AddedOn';
        elseif( $sortby=='job')
            $sorter='Name';
        else
            $sorter='AddedOn';
        //var_dump($sorter);

         if($this->session->userdata('UserRole')=='admin'){
            $condition = ['ProjectId' => $projectID];
            $job_records_list = $this->job_model->get_jobs($condition,'', '', $sorter, $direction);
            //echo $this->db->last_query();
            $job_records = $job_records_list->num_rows(); 

            $currjobs_ = $this->job_model->get_jobs($condition, $limit, $page, $sorter, $direction);
            $currjobs_list = $currjobs_->result_array();
            $condition = ['Id' => $projectID];
            $project = $this->project_model->get_project($condition)->row_array();
        }else{
            $condition['Job.ProjectId'] =  $projectID;            
            $condition['JobResources.ResourceId'] =  $this->session->userdata('UserId');
            $job_records_list = $this->job_model->get_users_jobs($condition);            
//echo $this->db->last_query();
            $job_records = $job_records_list->num_rows(); 

            $currjobs_ = $this->job_model->get_users_jobs($condition, $limit, $page);
            //echo $this->db->last_query();
            $currjobs_list = $currjobs_->result_array();
           // var_dump($currjobs_list);
            $condition=array();
            $condition = ['Id' => $projectID];
            $project = $this->project_model->get_project($condition)->row_array();
        }

        //echo $this->db->last_query();
        foreach ($currjobs_list as $currjobskey => $currjobsvalue) {
            $currjobs[]=$currjobsvalue;
        }


         if(count($currjobs) >0){
        }elseif($this->session->userdata('UserRole')=='member'){


        $this->smarty->assign('fN_sess', "You are not allowed.");
        redirect($this->host_url."/index.php/project/project");
        }
        

        $this->smarty->assign('sortby', $sortby);
        $this->smarty->assign('direction', $direction);

        $this->smarty->assign('jobs', $currjobs);
        $this->smarty->assign('total_records', $job_records);
        $this->smarty->assign('limit', $limit);
        $url = $this->host_url . '/index.php/project/joblist/'.$projectID.'date/asc';
        $this->smarty->assign('url', $url);

        $this->smarty->assign('project', $project); 
      //  var_dump($currjobs);
        $this->smarty->assign('projectId', $projectID);   
        $fN_sess ='';
        $fN_sess = $this->session->userdata('response');

        $this->smarty->assign('currentmenu', 'jobs'); //for highlighting left menu
        $this->smarty->assign('current_page', $page);
        $number_of_pages = round($job_records/$limit);
        $this->smarty->assign('number_of_pages', $number_of_pages);
        $this->smarty->assign('fN_sess', $fN_sess);
        $this->smarty->display('job/job_list.tpl');
    }


    public function viewJobDetail($projectID ='',$jobID =''){

        $condition =$currtimesheet= [];
        $projects_list = [];
        $currjobs_list= $currjobs_lists =[];
        $total_records = 0;
        $page = 0;
         $limit=$this->config->item('page_limit');

    
        $condition =$currjobresoucesId= [];
        $currjobresouces['resourceId'][]=$currjobresouces['roleId'][]='';


        $condition = ['Id' => $jobID];
        $currjobs = $this->job_model->get_jobs($condition);
        //echo $this->db->last_query();
        $currjobs_lists = $currjobs->result_array();
       // var_dump($currjobs_lists);
        $condition =$currjobresouces= [];
        $condition = ['p.Id' => $projectID];
        $currproject = $this->project_model->get_projects($condition, '', '');
        $currproject_list = $currproject->result_array();

        $condition =$currjobresouces= [];
        $condition = ['J.JobId' => $jobID];
        $currjobresouces_list = $this->job_model->get_resources($condition, '', '');
        // echo $this->db->last_query();
        $currjobresouces_res = $currjobresouces_list->result_array();
        foreach ($currjobresouces_res as $currjobresoucekey => $currjobresoucevalue) {
            $currjobresouces[]=$currjobresoucevalue;
             $currjobresoucesId[]=$currjobresoucevalue["ResourceId"];
        }
        if(isset($currjobs_lists[0]))
            $currjobs_list=$currjobs_lists[0];
        //var_dump(in_array($this->session->userdata('UserId'),$currjobresoucesId),$this->session->userdata('UserRole'));
        if(isset($currjobs) && count($currjobs_lists) >0 && (in_array($this->session->userdata('UserId'),$currjobresoucesId) || $this->session->userdata('UserRole')=='admin' || $this->session->userdata('UserRole')=='superadmin')){
        }else{


        $this->smarty->assign('fN_sess', "You are not allowed.");
        redirect($this->host_url."/index.php/project/joblist/".$projectID."/1");
        }
 
        

        $condition = ['TimeSheet.JobId' => $jobID];
        $currtimesheet_list = $this->timesheet_model->get_timesheets($condition);


        $currtimesheet_res = $currtimesheet_list->result_array();
        foreach ($currtimesheet_res as $currtimesheetkey => $currtimesheetvalue) {
            $currtimesheet[]=$currtimesheetvalue;
        }


        $condition = [];
        $users = $this->user_model->get_user($condition);
        if ($users->num_rows() > 0) {
            $users_list = $users->result_array();
            $user_records = $this->user_model->get_user_count($condition);
        }else{
            $user_records =$users_list=0;
        }
        $condition = [];
        $users = $this->user_model->get_user($condition);
        if ($users->num_rows() > 0) {
            $users_list = $users->result_array();
            $user_records = $this->user_model->get_user_count($condition);
        }else{
            $user_records =$users_list=0;
        }
        
        $condition = ['JobId' => $jobID];
        $files = $this->job_model->getFiles($condition);
        if ($files->num_rows() > 0) {
            $files_list = $files->result_array();
            $files_records = $this->job_model->getFilesCount($condition);
        }else{
            $files_records =$files_list=0;
        }
        //var_dump($files_list,$files_records);
        $this->smarty->assign('files_list', $files_list);
        $this->smarty->assign('files_records', $files_records);


        $this->smarty->assign('users_list', $users_list);
        $this->smarty->assign('user_records', $user_records);
        
        $condition = [];
        $projects = $this->project_model->get_projects($condition, $limit, $page);

        if ($projects->num_rows() > 0) {
            $projects_list = $projects->result_array();
            $total_records = $this->project_model->get_project_count($condition);
        }else{
            $total_records =$projects_list='';
        }
        $this->smarty->assign('total_records', $total_records);
        $this->smarty->assign('projects_list', $projects_list);
        $jobs = $this->job_model->get_jobs($condition, $limit, $page);
        if ($jobs->num_rows() > 0) {
            $jobs_list = $jobs->result_array();
            $jobs_records = $this->job_model->get_jobs_count($condition);
        }else{
            $jobs_list =$jobs_records='';
        }
         $condition = [];
        $condition = ['Id' => $projectID];
            $project = $this->project_model->get_project($condition)->row_array();
        $this->smarty->assign('project', $project); 
         $baseurl=$this->config->item('baseurl');
        $this->smarty->assign('baseurl', $baseurl);

        $this->smarty->assign('jobs_records', $jobs_records);
        $this->smarty->assign('jobs_list', $jobs_list);
        $number_of_pages = round($total_records/$limit);
        $url = $this->host_url . '/index.php/job/';


        $fN_sess ='';
        $fN_sess = $this->session->userdata('response');
        $this->smarty->assign('fN_sess', $fN_sess);
        
        $this->smarty->assign('currentmenu', 'jobs'); //for highlighting left menu
        $this->smarty->assign('number_of_pages', $number_of_pages);
        $this->smarty->assign('current_page', $page);
        $this->smarty->assign('limit', $limit);
        $this->smarty->assign('url', $url);
        $this->smarty->assign('projectID', $projectID); 
         $this->smarty->assign('projecId', $projectID);
        $this->smarty->assign('currproject_list', $currproject_list[0]); 
        $this->smarty->assign('currjobs_list', $currjobs_list);    
        $this->smarty->assign('currjobresouces', $currjobresouces);   
        $this->smarty->assign('currtimesheets', $currtimesheet);   
//var_dump($currtimesheet);
        $fN_sess ='';
        $fN_sess = $this->session->userdata('response');
        $this->smarty->assign('fN_sess', $fN_sess);
        $this->smarty->display('job/view-detail.tpl');
    }

    public function deleteJobTimesheet($timesheetId="",$projectId="",$jobId=""){
        $this->db->where('Id', $timesheetId);
        $this->db->delete('TimeSheet');
        $this->session->set_flashdata('response',"Timesheet Deleted Successfully");
        //echo $this->db->last_query();
        redirect($this->host_url."/index.php/project-id/".$projectId."/view-job-detail/".$jobId."");
    }

    public function deleteJobResource($resourceId="",$projectId="",$jobId=""){
        $this->db->where('ResourceId', $resourceId);
        $this->db->where('JobId', $jobId);
        
        $this->db->delete('JobResources');
        $this->session->set_flashdata('response',"Resource Deleted Successfully");
       // echo $this->db->last_query();die();
        redirect($this->host_url."/index.php/project-id/".$projectId."/view-job-detail/".$jobId."");
    }

    public function index($page = 1, $curremp = 0, $currproject = 0, $currstart = '', $currend = '')
    {
    $fN_sess ='';
        $fN_sess = $this->session->userdata('response');
        $this->smarty->assign('fN_sess', $fN_sess);
         }



    public function add($projectId='')
    {    $condition = [];
        $limit=$this->config->item('page_limit');

        $users = $this->user_model->get_user($condition);
        if ($users->num_rows() > 0) {
            $users_list = $users->result_array();
            $user_records = $this->user_model->get_user_count($condition);
        }else{
            $user_records =$users_list=0;
        }

        $condition = ['p.Id' => $projectId];
        $currproject = $this->project_model->get_projects($condition, '', '');
        $currproject_list = $currproject->result_array();$condition=array();
            $condition = ['Id' => $projectId];
            $project = $this->project_model->get_project($condition)->row_array();
        $this->smarty->assign('project', $project); 
        $this->smarty->assign('currentmenu', 'jobs'); //for highlighting left menu
        
        $this->smarty->assign('user_records', $user_records);
        $this->smarty->assign('users_list', $users_list);
        $this->smarty->assign('projecId', $projectId);
        $this->smarty->assign('currproject_list', $currproject_list[0]);
        $this->smarty->display('job/add.tpl');
     }    
                    

    function insertJob($projectId=""){
        $data['Name'] = $this->input->post('jobName') ? $this->input->post('jobName') : '';
        $data['ProjectId'] = $projectId;
        $data['Description'] = $this->input->post('txtDescription') ? $this->input->post('txtDescription') : '';
        $data['JobStartDate'] = $this->input->post('startDate') ? $this->input->post('startDate') : '';
        $data['JobEndDate'] = $this->input->post('endDate') ? $this->input->post('endDate') : '';    
        $data['Status'] = $this->input->post('status') ? $this->input->post('status') : '0';

        $data['Address'] = $this->input->post('address') ? $this->input->post('address') : '';   
        $data['Suburb'] = $this->input->post('suburb') ? $this->input->post('suburb') : '';      
        $data['City'] = $this->input->post('city') ? $this->input->post('city') : '';      
             
        $data['AddedOn'] = date('Y-m-d H:i:s');
        $data['AddedBy'] = $this->session->userdata('UserId');
        $data['ModifiedOn'] = date('Y-m-d H:i:s');
        $data['ModifiedBy'] = $this->session->userdata('UserId');
        
        $this->db->insert('Job', $data);
        $lastJobId= $this->db->insert_id();
        
        foreach ($this->input->post('hidResourceCount') as $key => $value) {
           // var_dump($key);
           // var_dump($value);
            $roles[]=$this->input->post("options_".$value);
            $resourcesVal[]=$this->input->post("selResouces_".$value);
        }
       // var_dump($resources);

    // var_dump($resourcesVal);die();
        foreach ($resourcesVal as $resourcekey => $resourcesvalue) 
        {
            # code...
            if($resourcesvalue!=""){
                $resources["JobId"]=$lastJobId;
                $resources["ResourceId"]=$resourcesvalue;                
                $resources["RoleId"]=$roles[$resourcekey];
                $resources['AddedOn'] = date('Y-m-d H:i:s');
                $resources['AddedBy'] = $this->session->userdata('UserId');
                $resources['ModifiedOn'] = date('Y-m-d H:i:s');
                $resources['ModifiedBy'] = $this->session->userdata('UserId');
               // var_dump($resources);
                $this->db->insert('JobResources', $resources);
            }
        }
        $this->session->set_flashdata('response',"Job Inserted Successfully");

        redirect($this->host_url."/index.php/project/joblist/".$projectId."/1/date/asc");

    }

    function editJob($projectId="",$jobID=''){
        //var_dump($projectId);
        $condition = [];
        $limit=$this->config->item('page_limit');

        $condition =$currjobresouces= [];

        $currjobresouces['resourceId'][]=$currjobresouces['roleId'][]='';
        $condition = ['Id' => $jobID];
        $currjobs = $this->job_model->get_jobs($condition);
        $currjob = $currjobs->result_array();
        $condition = ['JobId' => $jobID];
        $currjobresouces_list = $this->job_model->get_resources($condition, '', '');
       // echo $this->db->last_query();
        $currjobresouces_res = $currjobresouces_list->result_array();
        if(count($currjobresouces_res)>0){
            $currjobresouces=[];
            foreach ($currjobresouces_res as $currjobresoucekey => $currjobresoucevalue) {
                $currjobresouces['resourceId'][]=$currjobresoucevalue['ResourceId'];
                $currjobresouces['roleId'][]=$currjobresoucevalue['RoleId'];
            }
        }

        if(isset($currjob) && (in_array($this->session->userdata('UserId'),$currjobresouces['resourceId']) || $this->session->userdata('UserRole')=='admin' || $this->session->userdata('UserRole')=='superadmin')){
        }else{


        $this->smarty->assign('fN_sess', "You are not allowed.");
        redirect($this->host_url."/index.php/project/joblist/".$projectId."/1/date/asc");
        }


        $condition = [];
        $users = $this->user_model->get_user($condition);
        if ($users->num_rows() > 0) {
            $users_list = $users->result_array();
            $user_records = $this->user_model->get_user_count($condition);
        }else{
            $user_records =$users_list=0;
        }
        $resourceHtml=$options='';
        $i=1;
         
        foreach ($currjobresouces['resourceId'] as $keyjobresouces => $valuejobresouces) {
            $options=$rdEmployee=$rdSupervisor='';
            foreach ($users_list as $value){
            if($value["UserId"]==$valuejobresouces){
                $sel=' selected="selected" ';
            }else $sel='';
            $options.='<option value="'.$value["UserId"].'" '.$sel.' >'.$value["FirstName"].' '.$value["LastName"].'</option> ';
            }
            //var_dump($currjobresouces['roleId'][$keyjobresouces]);
            if($currjobresouces['roleId'][$keyjobresouces]=="employee"){
                $rdEmployee=" checked='checked' ";
            }else $rdSupervisor=" checked='checked' ";
            $resourceHtml.='<div class="element" id="div_' .$i. '"><div class="form-group row"><div class="col-sm-4"><select class="form-control" id="selResouces_' .$i. '" name="selResouces_' .$i. '"><option selected="selected" value="">Select Resources</option>'.$options.'  </select></div><div class="col-sm-4"><div class="btn-group btn-group-toggle" data-toggle="buttons"><label class="btn btn-sm btn-tertiary active"><input type="radio" name="options_' .$i. '" id="option_row1a"  value="employee"'.$rdEmployee.'> Employee</label><label class="btn btn-sm btn-tertiary"><input type="radio" name="options_' .$i. '" id="option_row1b" value="supervisor" '.$rdSupervisor.'> Supervisor</label></div></div><div class="col-sm-4"><a href="javascript:void(0);" class="remove btn btn-sm" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Delete" id="remove_' .$i. '" ><i class="active icofont-ui-delete"></i> Delete</a><input type="hidden" value="' .$i. '" id="hidResourceCount" name="hidResourceCount[]"></div> </div> </div>';
             $i++; 
        }

        //var_dump($resourceHtml);die();
        $condition = ['p.Id' => $projectId];
        $currproject = $this->project_model->get_projects($condition, '', '');
        $currproject_list = $currproject->result_array();
        $condition=array();
            $condition = ['Id' => $projectId];
            $project = $this->project_model->get_project($condition)->row_array();
        $this->smarty->assign('currentmenu', 'jobs'); //for highlighting left menu
        $this->smarty->assign('project', $project); 
        $this->smarty->assign('currproject_list', $currproject_list[0]);
        $this->smarty->assign('user_records', $user_records);
        $this->smarty->assign('users_list', $users_list);
        $this->smarty->assign('projecId', $projectId);
        $this->smarty->assign('projectId', $projectId);
        $this->smarty->assign('currJob', $currjob[0]);
        $this->smarty->assign('currjobresouces', $currjobresouces);
        $this->smarty->assign('resourceHtml', $resourceHtml);
        $this->smarty->display('job/edit.tpl');
      }

      function deleteJob($projectId="",$jobId=""){


        $this->db->where('Id', $jobId);
        $res=$this->db->delete('Job');
        $this->db->where('JobId', $jobId);
        $res1=$this->db->delete('JobResources');
        //var_dump($res,$res1);
        $this->session->set_flashdata('response',"Job Deleted Successfully");        
        //die("asf");

        redirect($this->host_url."/index.php/project/joblist/".$projectId."/1/date/asc");
      }

      function update($projectId="",$jobId=""){
     //   var_dump($_POST);

        $this->db->where('JobId', $jobId);
        $this->db->delete('JobResources');

        $data['Name'] = $this->input->post('jobName') ? $this->input->post('jobName') : '';
        $data['ProjectId'] = $projectId;
        $data['Description'] = $this->input->post('txtDescription') ? $this->input->post('txtDescription') : '';
        $data['JobStartDate'] = $this->input->post('startDate') ? $this->input->post('startDate') : '';
        $data['JobEndDate'] = $this->input->post('endDate') ? date("Y-m-d",strtotime($this->input->post('endDate'))) : '';        
        $data['Status'] = $this->input->post('status') ? $this->input->post('status') : '0'; 
        $data['Address'] = $this->input->post('address') ? $this->input->post('address') : '';   
        $data['Suburb'] = $this->input->post('suburb') ? $this->input->post('suburb') : '';      
        $data['City'] = $this->input->post('city') ? $this->input->post('city') : '';      
             
        
        $data['AddedOn'] = date('Y-m-d H:i:s');
        $data['AddedBy'] = $this->session->userdata('UserId');
        $data['ModifiedOn'] = date('Y-m-d H:i:s');
        $data['ModifiedBy'] = $this->session->userdata('UserId');
        
        
        $this->db->where('Id', $jobId);
        $this->db->update('Job', $data);

        foreach ($this->input->post('hidResourceCount') as $key => $value) {
           // var_dump($key);
           // var_dump($value);
            $roles[]=$this->input->post("options_".$value);
            $resourcesVal[]=$this->input->post("selResouces_".$value);
        }
       // var_dump($resourcesVal);
       // var_dump($resourcesVal);

       // var_dump($roles);
        foreach ($resourcesVal as $resourcekey => $resourcesvalue) 
        {
            # code...
            if($resourcesvalue!=""){
                $resources["JobId"]=$jobId;
                $resources["ResourceId"]=$resourcesvalue;                
                $resources["RoleId"]=$roles[$resourcekey];
                $resources['AddedOn'] = date('Y-m-d H:i:s');
                $resources['AddedBy'] = $this->session->userdata('UserId');
                $resources['ModifiedOn'] = date('Y-m-d H:i:s');
                $resources['ModifiedBy'] = $this->session->userdata('UserId');
                $this->db->insert('JobResources', $resources);
            }
        }
        $this->session->set_flashdata('response',"Job Updated Successfully");

        redirect($this->host_url."/index.php/project/joblist/".$projectId."/1/date/asc");

    
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
        $preName=$this->session->userdata('FirstName')."_".$this->session->userdata('LastName');
        $preName = preg_replace('/\s+/', '_', $preName);
        $config['file_name']             = strtolower($preName."_".time()."_".$_FILES["flJob"]['name']);
        $config['file_ext_tolower']      = true;
            

        $this->load->library('upload', $config);

        if (!$this->upload->do_upload('flJob')) {
            $upload_data = array('error' => $this->upload->display_errors());

        $this->session->set_flashdata('response',$upload_data["error"]);

        redirect($this->host_url."/index.php/project-id/".$this->input->post('hidPid')."/view-job-detail/".$this->input->post('hidJid'));
        } else {
            $upload_data = $this->upload->data();
            $data = [
                'Name' => strtolower($upload_data['file_name']),
                'ResourceId'=>$this->session->userdata('UserId'),
                'JobId' =>  $this->input->post('hidJid') ,
                'ProjectId' =>  $this->input->post('hidPid') ,
                'AddedBy' => $this->session->userdata('UserId'),
                'AddedOn' => date('Y/m/d h:i:s'),
                'ModifiedBy' => $this->session->userdata('UserId'),
                'ModifiedOn' => date('Y/m/d h:i:s')
            ];

            $this->db->insert('JobFiles', $data);
            $this->session->set_flashdata('response',"File Uploaded Successfully.");
             if($this->session->userdata('UserRole')=='member')
          //http://localhost/index.php/user-view-job-detail/91      
        redirect($this->host_url."/index.php/user-view-job-detail/".$this->input->post('hidJid'));

                else
        redirect($this->host_url."/index.php/project-id/".$this->input->post('hidPid')."/view-job-detail/".$this->input->post('hidJid'));
        }

         
    }

     public function deleteJobDocuments($pid="",$jid="",$fid=""){
        
        $condition = ['Id' => $fid];
        $currFiles = $this->job_model->getFiles($condition);
        $currFile = $currFiles->result_array();
       // echo"./uploads/jobs/".$currFile[0]["Name"]; die();
        unlink("./uploads/jobs/".$currFile[0]["Name"]); 
        $this->db->where('Id', $fid);
        $this->db->delete('JobFiles');
        $this->session->set_flashdata('response',"File Deleted Successfully");
        redirect($this->host_url."/index.php/project-id/".$pid."/view-job-detail/".$jid."");
     } 


    public function getprojectInfoAjax($id="")
    {
        $condition =$currjobresouces= [];

        $condition = ['Id' => $id];
        $currProjectRes = $this->project_model->get_project($condition);
        //echo $this->db->last_query();
        $currProject = $currProjectRes->result_array();
        $ret["Address"]=isset($currProject[0]["Address1"])?$currProject[0]["Address1"]:'';
        $ret["Suburb"]=isset($currProject[0]["Suburb"])?$currProject[0]["Suburb"]:'';
        $ret["City"]=isset($currProject[0]["City"])?$currProject[0]["City"]:'';
        echo json_encode( $ret);
       // var_dump($currProject);
    }



    public function updateStatusCron($id="")
    {
        $this->db->where('JobEndDate < ', date("Y-m-d"));
        $currResult=$this->db->get('Job');
        $currRows= $currResult->result_array();
        if($currResult->num_rows()>0){
            foreach ($currRows as $key => $value) {
                $data['Status'] =0;        
                $this->db->where('Id', $value["Id"]);
                $this->db->update('Job', $data);
            }

        } 

       die("Completed");
    }

    public function getUserJobs($page='1'){
        $sortby="JobStartDate";
        $direction="desc";

        $currjobs=[];
        $limit=$this->config->item('page_limit');

        if($direction!='asc')$direction='desc';
        if($sortby=='date')
            $sorter='AddedOn';
        elseif( $sortby=='job')
            $sorter='Name';
        else
            $sorter='AddedOn';
        //var_dump($sorter);

         {
            $condition['JobResources.ResourceId'] =  $this->session->userdata('UserId');
            $job_records_list = $this->job_model->get_users_jobs($condition, $limit, $page,$sortby,$direction);            
//echo $this->db->last_query();
            $job_records = $job_records_list->num_rows(); 

            $currjobs_ = $this->job_model->get_users_jobs($condition, $limit, $page,$sortby,$direction);
            //echo $this->db->last_query();
            $currjobs_list = $currjobs_->result_array();
           // var_dump($currjobs_list);
            $condition=array();
        }

        //echo $this->db->last_query();
        foreach ($currjobs_list as $currjobskey => $currjobsvalue) {
            $currjobs[]=$currjobsvalue;
        }


         if(count($currjobs) >0){
        }elseif($this->session->userdata('UserRole')=='member'){


        $this->smarty->assign('fN_sess', "You are not allowed.");
        redirect($this->host_url."/index.php/project/project");
        }
        

        $this->smarty->assign('sortby', $sortby);
        $this->smarty->assign('direction', $direction);

        $this->smarty->assign('jobs', $currjobs);
        $this->smarty->assign('total_records', $job_records);
        $this->smarty->assign('limit', $limit);
        $url = $this->host_url . '/index.php/user/jobs/'.$page.'date/asc';
        $this->smarty->assign('url', $url);

      //  var_dump($currjobs);
        $fN_sess ='';
        $fN_sess = $this->session->userdata('response');

        $this->smarty->assign('currentmenu', 'jobs'); //for highlighting left menu
        $this->smarty->assign('current_page', $page);
        $number_of_pages = round($job_records/$limit);
        $this->smarty->assign('number_of_pages', $number_of_pages);
        $this->smarty->assign('fN_sess', $fN_sess);
        $this->smarty->display('job/user_job_list.tpl');
    }

     public function userViewJobDetail($jobID =''){

        $condition =$currtimesheet= [];
        $projects_list = [];
        $currjobs_list= $currjobs_lists =[];
        $total_records = 0;
        $page = 0;
         $limit=$this->config->item('page_limit');

    
        $condition =$currjobresoucesId= [];
        $currjobresouces['resourceId'][]=$currjobresouces['roleId'][]='';


        $condition = ['Id' => $jobID];
        $currjobs = $this->job_model->get_jobs($condition);
        //echo $this->db->last_query();
        $currjobs_lists = $currjobs->result_array();
       // var_dump($currjobs_lists);
        $condition =$currjobresouces= [];
        //var_dump($currjobs_lists[0]);
        $projectID=$currjobs_lists[0]["ProjectId"];
        $condition = ['p.Id' => $projectID];
        $currproject = $this->project_model->get_projects($condition, '', '');
        $currproject_list = $currproject->result_array();

        $condition =$currjobresouces= [];
        $condition = ['J.JobId' => $jobID];
        $currjobresouces_list = $this->job_model->get_resources($condition, '', '');
        // echo $this->db->last_query();
        $currjobresouces_res = $currjobresouces_list->result_array();
        foreach ($currjobresouces_res as $currjobresoucekey => $currjobresoucevalue) {
            $currjobresouces[]=$currjobresoucevalue;
             $currjobresoucesId[]=$currjobresoucevalue["ResourceId"];
        }
        if(isset($currjobs_lists[0]))
            $currjobs_list=$currjobs_lists[0];
        //var_dump(in_array($this->session->userdata('UserId'),$currjobresoucesId),$this->session->userdata('UserRole'));
        if(isset($currjobs) && count($currjobs_lists) >0 && (in_array($this->session->userdata('UserId'),$currjobresoucesId) || $this->session->userdata('UserRole')=='admin' || $this->session->userdata('UserRole')=='superadmin')){
        }else{


        $this->smarty->assign('fN_sess', "You are not allowed.");
        redirect($this->host_url."/index.php/project/joblist/".$projectID."/1");
        }
 
        

        $condition = ['TimeSheet.JobId' => $jobID];
        $currtimesheet_list = $this->timesheet_model->get_timesheets($condition);


        $currtimesheet_res = $currtimesheet_list->result_array();
        foreach ($currtimesheet_res as $currtimesheetkey => $currtimesheetvalue) {
            $currtimesheet[]=$currtimesheetvalue;
        }


        $condition = [];
        $users = $this->user_model->get_user($condition);
        if ($users->num_rows() > 0) {
            $users_list = $users->result_array();
            $user_records = $this->user_model->get_user_count($condition);
        }else{
            $user_records =$users_list=0;
        }
        $condition = [];
        $users = $this->user_model->get_user($condition);
        if ($users->num_rows() > 0) {
            $users_list = $users->result_array();
            $user_records = $this->user_model->get_user_count($condition);
        }else{
            $user_records =$users_list=0;
        }
        
        $condition = ['JobId' => $jobID];
        $files = $this->job_model->getFiles($condition);
        if ($files->num_rows() > 0) {
            $files_list = $files->result_array();
            $files_records = $this->job_model->getFilesCount($condition);
        }else{
            $files_records =$files_list=0;
        }
        //var_dump($files_list,$files_records);
        $this->smarty->assign('files_list', $files_list);
        $this->smarty->assign('files_records', $files_records);


        $this->smarty->assign('users_list', $users_list);
        $this->smarty->assign('user_records', $user_records);
        
        $condition = [];
        $projects = $this->project_model->get_projects($condition, $limit, $page);

        if ($projects->num_rows() > 0) {
            $projects_list = $projects->result_array();
            $total_records = $this->project_model->get_project_count($condition);
        }else{
            $total_records =$projects_list='';
        }
        $this->smarty->assign('total_records', $total_records);
        $this->smarty->assign('projects_list', $projects_list);
        $jobs = $this->job_model->get_jobs($condition, $limit, $page);
        if ($jobs->num_rows() > 0) {
            $jobs_list = $jobs->result_array();
            $jobs_records = $this->job_model->get_jobs_count($condition);
        }else{
            $jobs_list =$jobs_records='';
        }
         $condition = [];
        $condition = ['Id' => $projectID];
            $project = $this->project_model->get_project($condition)->row_array();
        $this->smarty->assign('project', $project); 
         $baseurl=$this->config->item('baseurl');
        $this->smarty->assign('baseurl', $baseurl);

        $this->smarty->assign('jobs_records', $jobs_records);
        $this->smarty->assign('jobs_list', $jobs_list);
        $number_of_pages = round($total_records/$limit);
        $url = $this->host_url . '/index.php/job/';


        $fN_sess ='';
        $fN_sess = $this->session->userdata('response');
        $this->smarty->assign('fN_sess', $fN_sess);
        
        $this->smarty->assign('currentmenu', 'basic'); //for highlighting left menu
        $this->smarty->assign('number_of_pages', $number_of_pages);
        $this->smarty->assign('current_page', $page);
        $this->smarty->assign('limit', $limit);
        $this->smarty->assign('url', $url);
        $this->smarty->assign('projectID', $projectID); 
         $this->smarty->assign('projecId', $projectID);
        $this->smarty->assign('currproject_list', $currproject_list[0]); 
        $this->smarty->assign('currjobs_list', $currjobs_list);    
        $this->smarty->assign('currjobresouces', $currjobresouces);   
        $this->smarty->assign('currtimesheets', $currtimesheet);   
//var_dump($currtimesheet);
        $fN_sess ='';
        $fN_sess = $this->session->userdata('response');
        $this->smarty->assign('fN_sess', $fN_sess);
        $this->smarty->display('job/user-view-detail.tpl');
    }
}
