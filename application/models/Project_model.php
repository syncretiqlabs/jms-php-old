<?php
class project_model extends CI_Model
{
    public function insert_project($data)
    {
        $this->db->insert('Project', $data);
        return $this->db->insert_id();
    }

    public function insert_project_job($data)
    {
        $this->db->insert('ProjectJob', $data);
        return $this->db->insert_id();
    }

    public function update_project($data, $condition)
    {
        foreach ($condition as $key => $value) {
            $this->db->where($key, $value);
        }
        $this->db->update('Project', $data);
    }

    public function update_contact_project($data, $condition)
    {
        foreach ($condition as $key => $value) {
            $this->db->where($key, $value);
        }
        $this->db->update('ContactProject', $data);
    }

    public function get_project($condition)
    {
        if (is_array($condition)) {
            foreach ($condition as $key => $value) {
                $this->db->where($key, $value);
            }
        } else {
            $this->db->where($condition);
        }

        $this->db->order_by('StartDate', 'desc');
        
        return $this->db->get('Project');
    }

    public function get_projects($conditions, $limit, $page, $search_term = null)
    {
        $this->db->select("p.*, c.Id as ContactId, c.CompanyName, c.FirstName, c.LastName");
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
            $this->db->like('p.Name', $search_term);
            $this->db->or_like('p.Description', $search_term);
            $this->db->or_like('c.CompanyName', $search_term);
            $this->db->or_like('c.Email', $search_term);
            $this->db->or_like('c.FirstName', $search_term);
            $this->db->or_like('c.LastName', $search_term);
            $this->db->group_end();
        }
         if($limit!=''){
        $offset = $limit*($page-1);
       
        $offset = $offset < 0 ? 0 : $offset;}
        $this->db->join('Contact as c', 'c.Id = p.ContactId', 'left');
        //$this->db->order_by('p.Id', 'asc');
        $this->db->order_by('p.StartDate', 'desc');

        if($limit!='')
            $this->db->limit($limit, $offset);
        return $this->db->get('Project as p');
    }

    public function get_project_count($conditions, $search_term = null)
    {
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
                $this->db->like('p.Name', $search_term);
                $this->db->or_like('p.Description', $search_term);
                $this->db->or_like('c.CompanyName', $search_term);
                $this->db->or_like('c.Email', $search_term);
                $this->db->or_like('c.FirstName', $search_term);
                $this->db->or_like('c.LastName', $search_term);
            $this->db->group_end();
        }
        $this->db->join('Contact as c', 'c.Id = p.ContactId', 'left');
        return $this->db->get('Project as p')->num_rows();
    }

    public function get_contact_project($condition)
    {
        foreach ($condition as $key => $value) {
            $this->db->where($key, $value);
        }
        return $this->db->get('ContactProject');
    }

    public function insert_project_document($data)
    {
        $this->db->insert('projectFile', $data);
        return $this->db->insert_id();
    }

    public function get_project_document($condition)
    {
        foreach ($condition as $key => $value) {
            $this->db->where($key, $value);
        }
        return $this->db->get('projectFile');
    }

    public function get_recent_projects($limit, $type = 'onetime')
    {
        $this->db->select("p.*, c.Id as ContactId, c.ContactType, c.CompanyName, c.FirstName, c.LastName, , sum(ts.TotalTime) as TimeSpent");
        $this->db->where('p.Type', $type);
        $this->db->join('Contact as c', 'c.Id = p.ContactId', 'left');
        $this->db->join('TimeSheet as ts', 'ts.ProjectId = p.Id', 'left');
        $this->db->group_by('p.Id');
        $this->db->order_by('p.Id', 'desc');
        return $this->db->get('Project as p', $limit);
    }

}