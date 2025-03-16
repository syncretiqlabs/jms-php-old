<?php
class Job_model extends CI_Model
{
    public function insert_job($data)
    {
        $this->db->insert('Job', $data);
        return $this->db->insert_id();
    }

    public function insert_user_job($data)
    {
        $this->db->insert('UserJob', $data);
        return $this->db->insert_id();
    }

    public function get_jobs($conditions='', $limit='', $page='', $sortby='AddedOn', $direction='desc')
    {

        $page = $page<=0 ? 1 : $page;

        if($limit!='')
         $offset = $limit*($page-1);

        foreach ($conditions as $key => $value) {
            $this->db->where($key, $value);
        }
        $sort='Job.'.$sortby;
        $this->db->order_by($sort, $direction);


        if($limit!='')
            $this->db->limit($limit, $offset);
        
        return $this->db->get('Job');
    }

    public function get_users_jobs($conditions='', $limit='', $page='', $sortby='JobStartDate', $direction='desc')
    {

        $page = $page<=0 ? 1 : $page;

        if($limit!='')
         $offset = $limit*($page-1);

         $this->db->select("Job.Id as Id,JobResources.Id as JRID,Job.Name as Name,Job.ProjectId as ProjectId,Job.Description as Description,Job.JobStartDate as JobStartDate,Job.JobEndDate as JobEndDate");

        foreach ($conditions as $key => $value) {
            $this->db->where($key, $value);
        }

        $this->db->join('JobResources', 'Job.Id = JobResources.JobId');
        $this->db->order_by('Job.'. $sortby, $direction);


        if($limit!='')
            $this->db->limit($limit, $offset);
        
        return $this->db->get('Job');
    }


    public function getJobsAlongResources($conditions)
    {    

        foreach ($conditions as $key => $value) {
            $this->db->where($key, $value);
        }
        $this->db->select('Job.*,JobResources.ResourceId as ResourceId,JobResources.RoleId as RoleId');
        $this->db->join('JobResources', 'JobResources.JobId = Job.Id');
        return $this->db->get('Job');
    }


    public function getProjectsJobs($job_id = NULL)
    {   $jobs_records=array();
        $options='<option selected="selected" value="">All Jobs</option>
';
        $condition = ['ProjectId' => $job_id];
        $jobs = $this->job_model->get_jobs($condition);
        if ($jobs->num_rows() > 0) {
            $jobs_list = $jobs->result_array();
            $jobs_records = $this->job_model->get_jobs_count($condition);
        }else{
            $jobs_list =$jobs_records=array();
        }
        if(count($jobs_list)>0){
            foreach ($jobs_list as $key => $value) {
                $options.='<option value="'.$value["Id"].'">'.$value["Name"].'</option>';
            }
        }
        //var_dump($options);
        echo  $options;
    }

    public function delete_job($id)
    {
        $deleted = $this->db->delete('Job', ['Id' => $id]);
        $condition = ['JobId' => $id];
        $this->delete_user_job($condition);
        return $this->db->affected_rows();
    }

    public function delete_user_job($condition)
    {
        $this->db->delete('UserJob', $condition);
    }

    public function get_user_job($conditions)
    {
        foreach ($conditions as $key => $value) {
            $this->db->where($key, $value);
        }
        return $this->db->get('UserJob');
    }

    public function get_jobs_count($conditions)
    {
        if (count($conditions) > 0) {
            foreach ($conditions as $key => $value) {
                $this->db->where($key, $value);
            }
        }
        return $this->db->get('Job')->num_rows();
    }

    public function get_resources($conditions)
    {
        if (count($conditions) > 0) {
            foreach ($conditions as $key => $value) {
                $this->db->where($key, $value);
            }
        }
        $this->db->join('User as u', 'u.UserId = J.ResourceId');
        return $this->db->get('JobResources as J');
    }

    public function get_recent_jobs($limit)
    {
        $this->db->select("j.*, p.Name as ProjectName, c.ContactType, c.CompanyName, c.FirstName, c.LastName");

        $this->db->join('Project as p', 'j.ProjectId = p.Id', 'left');
        $this->db->join('Contact as c', 'c.Id = p.ContactId', 'left');
        
        
        $this->db->order_by('j.Id', 'desc');
        return $this->db->get('Job as j', $limit);
    }


    public function getFiles($conditions)
    {
        foreach ($conditions as $key => $value) {
            $this->db->where($key, $value);
        }
        $this->db->order_by('JobFiles.AddedOn', 'desc');
        return $this->db->get('JobFiles');
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
}
?>
