<?php
class timesheet_model extends CI_Model
{
    public function get_timesheets($conditions = [], $limit = '', $page = '', $sortby = 'TimeSheet.Date', $direction = 'desc')
    {
        if (count($conditions) > 0) {
            foreach ($conditions as $key => $value) {
                $this->db->where($key, $value);
            }
        }
        $page = $page <= 0 ? 1 : $page;

        if ($limit != '') {
            $offset = $limit * ($page - 1);
        }

        $this->db->select('TimeSheet.*,Jobs.Id as JobId, UserJobDispatch.DispatchedDate as DispatchedDate,User.FirstName as FirstName,User.LastName as LastName,Jobs.Name as JobName,Jobs.BillingType as BillingType,Contact.CompanyName as OrganisationName,Contact.ContactType as ContactType,Contact.FirstName as ContactFirstName,Contact.LastName as ContactLastName, JobDispatchFiles.Name as Filename, JobDispatch.DispatchOpen as DispatchOpen');
        $this->db->from('TimeSheet');
        $this->db->join('UserJobDispatch', 'UserJobDispatch.Id = TimeSheet.UserJobDispatchId', 'LEFT');
        $this->db->join('User', 'User.UserId = TimeSheet.UserId', 'LEFT');
        $this->db->join('JobDispatch', 'TimeSheet.DispatchId = JobDispatch.Id');
        $this->db->join('Jobs', 'Jobs.Id = TimeSheet.JobId');
        $this->db->join('Contact','Jobs.ContactId = Contact.Id', 'LEFT');
        $this->db->join('JobDispatchFiles','JobDispatchFiles.DispatchId = JobDispatch.Id', 'LEFT');
        $this->db->order_by($sortby . " " . $direction);

        if ($limit != '')
            $this->db->limit($limit, $offset);


        $query = $this->db->get();
        return $query;
    }

    public function getDispatchedTimesheets($conditions = [], $limit = '', $page = '', $sortby = 'TimeSheet.Date', $direction = 'desc')
    {
        if (count($conditions) > 0) {
            foreach ($conditions as $key => $value) {
                $this->db->where($key, $value);
            }
        }
        $page = $page <= 0 ? 1 : $page;

        if ($limit != '') {
            $offset = $limit * ($page - 1);
        }

        $this->db->select('TimeSheet.*,UserJobDispatch.DispatchedDate as DispatchedDate,User.FirstName as FirstName,User.LastName as LastName,Jobs.Name as JobName');
        $this->db->from('TimeSheet');
       // $this->db->join('UserJobDispatch', 'UserJobDispatch.Id = TimeSheet.DispatchId');
         $this->db->join('UserJobDispatch', 'UserJobDispatch.Id = TimeSheet.UserJobDispatchId');
        $this->db->join('User', 'User.UserId = UserJobDispatch.ResourceId');
        $this->db->join('JobDispatch', 'UserJobDispatch.JobDispatchId = JobDispatch.Id');
        $this->db->join('Jobs', 'Jobs.Id = UserJobDispatch.JobId');

        $this->db->order_by($sortby . " " . $direction);
        if ($limit != '') {
            $this->db->limit($limit, $offset);
        }
        $query = $this->db->get();
        return $query;
    }

    public function get_timesheet_count($conditions = [])
    {
        if (count($conditions) > 0) {
            foreach ($conditions as $key => $value) {
                $this->db->where($key, $value);
            }
        }
        //  return $this->db->get('Contact', $limit, $offset);
        $this->db->select('TimeSheet.*,User.FirstName as FirstName,JobDispatch.DispatchedDate as DispatchedDate,User.LastName as LastName,Jobs.Name as JobName');
        $this->db->from('TimeSheet');
        $this->db->join('UserJobDispatch', 'UserJobDispatch.Id = TimeSheet.UserJobDispatchId', 'LEFT');
        $this->db->join('User', 'User.UserId = TimeSheet.UserId', 'LEFT');
        $this->db->join('JobDispatch', 'TimeSheet.DispatchId = JobDispatch.Id');
        $this->db->join('Jobs', 'Jobs.Id = TimeSheet.JobId');

        $this->db->order_by('TimeSheet.Date desc');
        $query = $this->db->get()->num_rows();
        return $query;
    }
}
