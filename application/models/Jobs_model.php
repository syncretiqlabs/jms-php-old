<?php
class jobs_model extends CI_Model
{
   
     public function insertJob($data)
    {
        $this->db->insert('Jobs', $data);
        return $this->db->insert_id();
    }

    public function updateJob($data, $condition)
    {
        foreach ($condition as $key => $value) {
            $this->db->where($key, $value);
        }
        $this->db->update('Jobs', $data);
    }

    public function updateJobsDispatch($data, $condition)
    {
        foreach ($condition as $key => $value) {
            $this->db->where($key, $value);
        }
        $this->db->update('JobDispatch', $data);
        //echo $this->db->last_query();
    }

    public function getResources($conditions)
    {
        $this->db->select("J.*, u.FirstName as FirstName, u.LastName as LastName, J.Id as JobId, Ud.Id as UDJId,Ud.ResourceId as ResourceId,Ud.RoleId as RoleId");

        if (count($conditions) > 0) {
            foreach ($conditions as $key => $value) {
                $this->db->where($key, $value);
            }
        }
        $this->db->join('JobDispatch as jr', 'jr.Id = Ud.JobDispatchId', 'left');
        $this->db->join('Jobs as J', 'J.Id = jr.JobId', 'left');
        $this->db->join('User as u', 'u.UserId = Ud.ResourceId');
        $this->db->group_by("Ud.ResourceId"); 
        return $this->db->get('UserJobDispatch as Ud');
    }



    public function getResourcesDates($conditions)
    {
        //$this->db->select("j.*, u.FirstName, u.LastName");

        if (count($conditions) > 0) {
            foreach ($conditions as $key => $value) {
                $this->db->where($key, $value);
            }
        }
        $this->db->join('User as u', 'u.UserId = J.ResourceId');
        return $this->db->get('UserJobDispatch as J');
    }

    

    public function getJobs($conditions=[], $limit='', $page='', $sortby='AddedOn', $direction='desc',$search_term="")
    {

        $this->db->select("j.*, c.Id as ContactId, c.ContactType as ContactType, c.CompanyName, c.FirstName, c.LastName");
        if (count($conditions) > 0) {
            foreach ($conditions as $key => $value) {
                if (is_array($value)) {
                    $this->db->where_in($key, $value);
                } else {
                    $this->db->where($key, $value);
                }
            }
        }

        if (!empty($search_term)) {
            $this->db->group_start();
            $this->db->like('j.Name', $search_term);
            $this->db->or_like('j.Description', $search_term);
            $this->db->or_like('c.CompanyName', $search_term);
            $this->db->or_like('c.Email', $search_term);
            $this->db->or_like('c.FirstName', $search_term);
            $this->db->or_like('c.LastName', $search_term);
            $this->db->group_end();
        }
         if($limit!=''){
        $offset = $limit*($page-1);
       
        $offset = $offset < 0 ? 0 : $offset;}
        $this->db->join('Contact as c', 'c.Id = j.ContactId', 'left');
        //$this->db->order_by('p.Id', 'asc');
        $this->db->order_by($sortby, $direction);

        if($limit!='')
            $this->db->limit($limit, $offset);
        return $this->db->get('Jobs as j');
    }



    public function getJobsCount($conditions,$search_term="")
    {   
        $this->db->select("j.*, c.Id as ContactId, c.CompanyName, c.FirstName, c.LastName");
        if (count($conditions) > 0) {
            foreach ($conditions as $key => $value) {
                if (is_array($value)) {
                    $this->db->where_in($key, $value);
                } else {
                    $this->db->where($key, $value);
                }
            }
        }
        if (!empty($search_term)) {
            $this->db->group_start();
                $this->db->like('j.Name', $search_term);
                $this->db->or_like('j.Description', $search_term);
                $this->db->or_like('c.CompanyName', $search_term);
                $this->db->or_like('c.Email', $search_term);
                $this->db->or_like('c.FirstName', $search_term);
                $this->db->or_like('c.LastName', $search_term);
            $this->db->group_end();
        }
        $this->db->join('Contact as c', 'c.Id = j.ContactId', 'left');
        return $this->db->get('Jobs as j')->num_rows();
    }
    


    public function getUserJobs($conditions=[], $limit='', $page='', $sortby='AddedOn', $direction='desc',$search_term="")
    {

        $this->db->select("j.*, c.Id as ContactId, c.CompanyName, c.FirstName, c.LastName");
        $this->db->join('Contact as c', 'c.Id = j.ContactId', 'left');
        $this->db->join('JobDispatch as jr', 'jr.JobId = j.Id', 'left');
        $this->db->join('UserJobDispatch as ujr', 'ujr.JobId = j.Id', 'left');
        if (count($conditions) > 0) {
            foreach ($conditions as $key => $value) {
                if (is_array($value)) {
                    $this->db->where_in($key, $value);
                } else {
                    $this->db->where($key, $value);
                }
            }
        }

        if (!empty($search_term)) {
            $this->db->group_start();
            $this->db->like('j.Name', $search_term);
            $this->db->or_like('j.Description', $search_term);
            $this->db->or_like('c.CompanyName', $search_term);
            $this->db->or_like('c.Email', $search_term);
            $this->db->or_like('c.FirstName', $search_term);
            $this->db->or_like('c.LastName', $search_term);
            $this->db->group_end();
        }
         if($limit!=''){
        $offset = $limit*($page-1);
       
        $offset = $offset < 0 ? 0 : $offset;}

        $this->db->where("ujr.ResourceId",$this->session->userdata('UserId'));
        //$this->db->order_by('p.Id', 'asc');
        $this->db->order_by($sortby, $direction);

        if($limit!='')
            $this->db->limit($limit, $offset);
        
        $this->db->group_by("jr.JobId"); 
        return $this->db->get('Jobs as j');
    }



    public function getUserJobsCount($conditions,$search_term="")
    {   
        $this->db->select("j.*, c.Id as ContactId, c.CompanyName, c.FirstName, c.LastName, c.ContactType");
        if (count($conditions) > 0) {
            foreach ($conditions as $key => $value) {
                if (is_array($value)) {
                    $this->db->where_in($key, $value);
                } else {
                    $this->db->where($key, $value);
                }
            }
        }
        if (!empty($search_term)) {
            $this->db->group_start();
                $this->db->like('j.Name', $search_term);
                $this->db->or_like('j.Description', $search_term);
                $this->db->or_like('c.CompanyName', $search_term);
                $this->db->or_like('c.Email', $search_term);
                $this->db->or_like('c.FirstName', $search_term);
                $this->db->or_like('c.LastName', $search_term);
            $this->db->group_end();
        }
        $this->db->where("ujr.ResourceId",$this->session->userdata('UserId'));
        $this->db->join('Contact as c', 'c.Id = j.ContactId', 'left');
        $this->db->join('JobDispatch as jr', 'jr.JobId = j.Id', 'left');
        $this->db->join('UserJobDispatch as ujr', 'ujr.JobId = j.Id', 'left');
        return $this->db->get('Jobs as j')->num_rows();
    }

    public function getFiles($conditions)
    {
        foreach ($conditions as $key => $value) {
            $this->db->where($key, $value);
        }
        $this->db->order_by('JobFiles.AddedOn', 'desc');
        return $this->db->get('JobFiles');
    }

 

    

    public function getDispatchFiles($conditions)
    {
        foreach ($conditions as $key => $value) {
            $this->db->where($key, $value);
        }
        $this->db->order_by('AddedOn', 'desc');
        return $this->db->get('JobDispatchFiles');
    }

    public function getDispatchFilesCount($conditions)
    {
        if (count($conditions) > 0) {
            foreach ($conditions as $key => $value) {
                $this->db->where($key, $value);
            }
        }
        return $this->db->get('JobDispatchFiles')->num_rows();
    }



    public function getFilesCount($conditions)
    {
        if (count($conditions) > 0) {
            foreach ($conditions as $key => $value) {
                $this->db->where($key, $value);
            }
        }
        return $this->db->get('JobFiles')->num_rows();
    }



    public function getDispatchedJobs($conditions = [], $limit = '', $page = '', //$sortby = 'AddedOn', $direction = 'desc',$search_term = "")
    $sortby = '', $direction = '',$search_term = "")
    {
        $this->db->select("jd.*, j.Id as JId, j.Name, j.ContactId, j.JobCode, j.OrderId, j.Description, j.Address1, j.Suburb, j.City, j.PostCode, j.JobType, j.IsRecurring, j.StartDate, j.EndDate, j.Status, j.JobStatus, j.Configurations, j.Notes, j.AddedOn, j.AddedBy,  j.ContractHours,  j.ModifiedOn, j.ModifiedBy, j.BillingType, c.CompanyName,  c.FirstName, c.LastName");
        if (count($conditions) > 0) {
            foreach ($conditions as $key => $value) {
                if (is_array($value)) {
                    $this->db->where_in($key, $value);
                } else {
                    $this->db->where($key, $value);
                }
            }
        }

        if ($limit!='') {
            $offset = $limit*($page-1);
            $offset = $offset < 0 ? 0 : $offset;
        } 

        if ($limit!=''){
            $this->db->limit($limit, $offset);
        }
            
        $this->db->join('Jobs as j', 'jd.JobId = j.Id', 'left');
        $this->db->join('Contact as c', 'c.Id = j.ContactId', 'left');
        $this->db->order_by($sortby, $direction);
        return $this->db->get('JobDispatch as jd');
    }

    public function getDispatchedJobsResources($conditions='', $limit='', $page='', $sortby='AddedOn', $direction='desc',$search_term="")
    {

        $this->db->select("*");
        if (count($conditions) > 0) {
            foreach ($conditions as $key => $value) {
                if (is_array($value)) {
                    $this->db->where_in($key, $value);
                } else {
                    $this->db->where($key, $value);
                }
            }
        }

        if (!empty($search_term)) {/*
            $this->db->group_start();
            $this->db->like('j.Name', $search_term);
            $this->db->or_like('j.Description', $search_term);
            $this->db->or_like('c.CompanyName', $search_term);
            $this->db->or_like('c.Email', $search_term);
            $this->db->or_like('c.FirstName', $search_term);
            $this->db->or_like('c.LastName', $search_term);
            $this->db->group_end();
        */}
         if($limit!=''){
        $offset = $limit*($page-1);
       
        $offset = $offset < 0 ? 0 : $offset;} 

         

        if($limit!='')
            $this->db->limit($limit, $offset);
        //$this->db->group_by("jr.DispatchedDate"); 
        return $this->db->get('JobDispatch');
    }




    public function getDispatchedJobsCount($conditions,$search_term="")
    {   
        $this->db->select("j.*, jr.Id as JrId,jr.DispatchedDate");
        if (count($conditions) > 0) {
            foreach ($conditions as $key => $value) {
                if (is_array($value)) {
                    $this->db->where_in($key, $value);
                } else {
                    $this->db->where($key, $value);
                }
            }
        }
        if (!empty($search_term)) {/*
            $this->db->group_start();
                $this->db->like('j.Name', $search_term);
                $this->db->or_like('j.Description', $search_term);
                $this->db->or_like('c.CompanyName', $search_term);
                $this->db->or_like('c.Email', $search_term);
                $this->db->or_like('c.FirstName', $search_term);
                $this->db->or_like('c.LastName', $search_term);
            $this->db->group_end();
        */}
        $this->db->join('JobDispatch as jr', 'jr.JobId = j.Id', 'left');

        //$this->db->group_by("jr.JobId"); 
       // $this->db->group_by("jr.DispatchedDate"); 
        return $this->db->get('Jobs as j')->num_rows();
    }



    public function getAllDispatchedJobsCount($conditions,$search_term="")
    {   
        $this->db->select("j.*, jr.Id as JrId,jr.DispatchedDate,ujd.ResourceId");
        if (count($conditions) > 0) {
            foreach ($conditions as $key => $value) {
                if (is_array($value)) {
                    $this->db->where_in($key, $value);
                } else {
                    $this->db->where($key, $value);
                }
            }
        }
        if (!empty($search_term)) {/*
            $this->db->group_start();
                $this->db->like('j.Name', $search_term);
                $this->db->or_like('j.Description', $search_term);
                $this->db->or_like('c.CompanyName', $search_term);
                $this->db->or_like('c.Email', $search_term);
                $this->db->or_like('c.FirstName', $search_term);
                $this->db->or_like('c.LastName', $search_term);
            $this->db->group_end();
        */}
        $this->db->join('JobDispatch as jr', 'jr.JobId = j.Id', 'left');
        $this->db->join('UserJobDispatch as ujd', 'jr.Id = ujd.JobDispatchId', 'left');
        return $this->db->get('Jobs as j')->num_rows();
    }

    public function getJobDispatchByJobId ($job_id) {
        $this->db->where('JobId', $job_id);
        $this->db->order_by('DispatchedDate', 'asc');
        return $this->db->get('JobDispatch');
    }

    public function getAllDispatchedJobs($conditions=[], $limit='', $page='', $sortby='AddedOn', $direction='desc',$search_term="")
    {

        $this->db->select("j.*, jr.Id as JrId,jr.DispatchedDate,ujd.ResourceId, c.Id as ContactId, c.CompanyName, c.FirstName, c.LastName");
        if (count($conditions) > 0) {
            foreach ($conditions as $key => $value) {
                if (is_array($value)) {
                    $this->db->where_in($key, $value);
                } else {
                    $this->db->where($key, $value);
                }
            }
        }

        if (!empty($search_term)) {/*
            $this->db->group_start();
            $this->db->like('j.Name', $search_term);
            $this->db->or_like('j.Description', $search_term);
            $this->db->or_like('c.CompanyName', $search_term);
            $this->db->or_like('c.Email', $search_term);
            $this->db->or_like('c.FirstName', $search_term);
            $this->db->or_like('c.LastName', $search_term);
            $this->db->group_end();
        */}
         if($limit!=''){
        $offset = $limit*($page-1);
       
        $offset = $offset < 0 ? 0 : $offset;}
        $this->db->join('JobDispatch as jr', 'jr.JobId = j.Id', 'left');
        $this->db->join('Contact as c', 'c.Id = j.ContactId', 'left');
        $this->db->join('UserJobDispatch as ujd', 'jr.Id = ujd.JobDispatchId', 'left');

        //$this->db->order_by('p.Id', 'asc');
        $this->db->order_by($sortby, $direction);

        if($limit!='')
            $this->db->limit($limit, $offset);
        return $this->db->get('Jobs as j');
    }


    public function chkTimeLogged($conditions,$search_term="")
    {   
        $this->db->select("j.*, jr.Id as JrId,jr.DispatchedDate");
        if (count($conditions) > 0) {
            foreach ($conditions as $key => $value) {
                if (is_array($value)) {
                    $this->db->where_in($key, $value);
                } else {
                    $this->db->where($key, $value);
                }
            }
        }
        if (!empty($search_term)) {/*
            $this->db->group_start();
                $this->db->like('j.Name', $search_term);
                $this->db->or_like('j.Description', $search_term);
                $this->db->or_like('c.CompanyName', $search_term);
                $this->db->or_like('c.Email', $search_term);
                $this->db->or_like('c.FirstName', $search_term);
                $this->db->or_like('c.LastName', $search_term);
            $this->db->group_end();
        */}
        $this->db->join('JobDispatch as jr', 'jr.JobId = j.Id', 'left');

        $this->db->group_by("jr.JobId"); 
        return $this->db->get('Jobs as j')->num_rows();
    }

    public function getUserDispatchedJobs($conditions=[], $limit='', $page='', $sortby='AddedOn', $direction='desc',$search_term="")
    {

        $this->db->select("j.*, jd.Id as JdId, `jd`.`DispatchName` as `DispatchName`,jd.DispatchedDate, jd.DispatchOpen as DispatchOpen, c.Id as ContactId, c.CompanyName, c.FirstName, c.LastName, t.TotalTime");
        if (count($conditions) > 0) {
            foreach ($conditions as $key => $value) {
                if (is_array($value)) {
                    $this->db->where_in($key, $value);
                } else {
                    $this->db->where($key, $value);
                }
            }
        }

        if (!empty($search_term)) {/*
            $this->db->group_start();
            $this->db->like('j.Name', $search_term);
            $this->db->or_like('j.Description', $search_term);
            $this->db->or_like('c.CompanyName', $search_term);
            $this->db->or_like('c.Email', $search_term);
            $this->db->or_like('c.FirstName', $search_term);
            $this->db->or_like('c.LastName', $search_term);
            $this->db->group_end();
        */}
         if($limit!=''){
        $offset = $limit*($page-1);
       
        $offset = $offset < 0 ? 0 : $offset;}
        $this->db->join('JobDispatch as jd', 'jd.JobId = j.Id', 'left');
        $this->db->join('UserJobDispatch as ujd', 'ujd.JobDispatchId = jd.Id', 'left');
        $this->db->join('Contact as c', 'c.Id = j.ContactId', 'left');
        $this->db->join('TimeSheet as t', 'ujd.Id = t.UserJobDispatchId', 'left');
        $this->db->where("ujd.ResourceId",$this->session->userdata('UserId'));
        //$this->db->order_by('p.Id', 'asc');
        $this->db->order_by($sortby, $direction);

        if($limit!='')
            $this->db->limit($limit, $offset);
        $this->db->group_by("jd.Id"); 
        return $this->db->get('Jobs as j');
    }

    public function getUserDispatchedJobsCount($conditions,$search_term="")
    {   
        $this->db->select("j.*, jd.Id as JdId,jd.DispatchedDate");
        if (count($conditions) > 0) {
            foreach ($conditions as $key => $value) {
                if (is_array($value)) {
                    $this->db->where_in($key, $value);
                } else {
                    $this->db->where($key, $value);
                }
            }
        }
        if (!empty($search_term)) {/*
            $this->db->group_start();
                $this->db->like('j.Name', $search_term);
                $this->db->or_like('j.Description', $search_term);
                $this->db->or_like('c.CompanyName', $search_term);
                $this->db->or_like('c.Email', $search_term);
                $this->db->or_like('c.FirstName', $search_term);
                $this->db->or_like('c.LastName', $search_term);
            $this->db->group_end();
        */}
        $this->db->join('JobDispatch as jd', 'jd.JobId = j.Id', 'left');
        $this->db->join('UserJobDispatch as ujd', 'ujd.JobDispatchId = jd.Id', 'left');
        $this->db->join('Contact as c', 'c.Id = j.ContactId', 'left');
        $this->db->where("ujd.ResourceId",$this->session->userdata('UserId'));

        $this->db->group_by("jd.Id"); 
        return $this->db->get('Jobs as j')->num_rows();
    }

    public function get_recent_contract_jobs($limit)
    {
        $this->db->select("j.*, c.Id as ContactId, c.ContactType, c.CompanyName, c.FirstName, c.LastName, , sum(ts.TotalTime) as TimeSpent");
        $this->db->join('Contact as c', 'c.Id = j.ContactId', 'left');
        $this->db->join('TimeSheet as ts', 'ts.JobId = j.Id', 'left');
        $this->db->where('j.JobType', 'Contract');
        $this->db->group_by('j.Id');
        $this->db->order_by('j.Id', 'desc');
        $jobs = $this->db->get('Jobs as j', $limit)->result_array();
        foreach ($jobs as $key => $value) {
            $jobs[$key]['TimeRemaining'] = $value['ContractHours'] - $value['TimeSpent'];
        }
        return $jobs;
    }

    public function get_recent_jobs($limit)
    {
        $this->db->select("j.*, c.Id as ContactId, c.ContactType, c.CompanyName, c.FirstName, c.LastName");
        $this->db->join('Contact as c', 'c.Id = j.ContactId', 'left');
        $this->db->group_by('j.Id');
        $this->db->order_by('j.Id', 'desc');
        return $this->db->get('Jobs as j', $limit);
    }
    
    public function get_todays_job_dispatch($limit, $user_id = null)
    {
        $cur_date = date('Y-m-d');
        $this->db->select("jd.*, c.Id as ContactId, c.ContactType, c.CompanyName, c.FirstName, c.LastName");
        $this->db->join('Jobs as j', 'j.Id = jd.JobId', 'left');
        $this->db->join('Contact as c', 'c.Id = j.ContactId', 'left');
        $this->db->join('UserJobDispatch as ujd', 'ujd.JobDispatchId=jd.Id');
        $this->db->where('jd.DispatchedDate', $cur_date);
        $this->db->where('jd.DispatchOpen','open');
        if (!empty($user_id)) {
            $this->db->where('ujd.ResourceId', $user_id);
        }
        $this->db->group_by('jd.Id');
        $this->db->order_by('jd.DispatchedDate', 'asc');
        return $this->db->get('JobDispatch as jd', $limit);
    }

    public function get_upcoming_job_dispatch($limit, $user_id = null)
    {
        $cur_date = date('Y-m-d');
        $this->db->select("jd.*, c.Id as ContactId, c.ContactType, c.CompanyName, c.FirstName, c.LastName");
        $this->db->join('Jobs as j', 'j.Id = jd.JobId', 'left');
        $this->db->join('Contact as c', 'c.Id = j.ContactId', 'left');
        $this->db->join('UserJobDispatch as ujd', 'ujd.JobDispatchId=jd.Id');
        $this->db->where('jd.DispatchedDate>=', $cur_date);
        if (!empty($user_id)) {
            $this->db->where('ujd.ResourceId', $user_id);
        }
        $this->db->group_by('jd.Id');
        $this->db->order_by('jd.DispatchedDate', 'asc');
        return $this->db->get('JobDispatch as jd', $limit);
    }

    public function get_recent_job_dispatch($limit, $user_id = null)
    {
        $cur_date = date('Y-m-d');
        $job_dispatch_array=[];

        $this->db->select('jd.Id');
        $this->db->join('UserJobDispatch as ujd', 'ujd.JobDispatchId=jd.Id');
        $this->db->where('jd.DispatchedDate<=', $cur_date);
        if (!empty($user_id)) {
            $this->db->where('ujd.ResourceId', $user_id);
        }
        $this->db->order_by('jd.DispatchedDate', 'desc');
        $this->db->group_by('jd.Id');
        $jd = $this->db->get('JobDispatch as jd', $limit)->result_array();

        foreach ($jd as $j) {
            $job_dispatch_array[] = $j['Id'];
        }

        $this->db->select("`jd`.`Id` as JobDispatchId, `jd`.`DispatchName`, `jd`.DispatchedDate, `ujd`.`Id` as UserResourceId, `t`.*");
        $this->db->join('UserJobDispatch as ujd', 'ujd.JobDispatchId=jd.Id', 'left');
        $this->db->join('TimeSheet as t', 't.UserJobDispatchId=ujd.Id', 'left');
        $this->db->where_in('jd.Id', $job_dispatch_array);
        $this->db->order_by('jd.DispatchedDate', 'asc');
        $job_d = $this->db->get('JobDispatch as jd')->result_array();

        $dispatch_job = [];
        foreach ($job_d as $job_dis) {
            
            if (!array_key_exists($job_dis['JobDispatchId'], $dispatch_job)) {
                $dispatch_job[$job_dis['JobDispatchId']] = [
                    'Id' => $job_dis['JobDispatchId'],
                    'Name' => $job_dis['DispatchName'],
                    'DispatchedDate' => $job_dis['DispatchedDate'],
                    'TotalTIme' => $job_dis['TotalTime']
                ];
                $dispatch_job[$job_dis['JobDispatchId']]['TimeSheetEntry'][] = $job_dis['Id'];

            } else {
                $dispatch_job[$job_dis['JobDispatchId']]['TimeSheetEntry'][] = $job_dis['Id'];
                $dispatch_job[$job_dis['JobDispatchId']]['TotalTIme'] += $job_dis['TotalTime'];
            }
        }
        foreach ($dispatch_job as $k => $v) {
            $val = 'Complete';
            foreach($v['TimeSheetEntry'] as $value) {
                if (empty($value)) {
                    $val = 'Incomplete';
                    break;
                }
            }
            $dispatch_job[$k]['Result'] = $val;
        }
        return $dispatch_job;
    }
}