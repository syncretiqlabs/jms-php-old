<?php
class Contact_model extends CI_Model
{
    public function insert_contact($data)
    {
        $this->db->insert('Contact', $data);
        return $this->db->insert_id();
    }

    public function update_contact($data, $condition)
    {
        foreach ($condition as $key => $value) {
            $this->db->where($key, $value);
        }
        $this->db->update('Contact', $data);
    }

    public function get_contact($condition, $search_term = null)
    {
        if (is_array($condition)) {
            foreach ($condition as $key => $value) {
                if (is_array($value)) {
                    $this->db->where_in($key, $value);
                } else {
                    $this->db->where($key, $value);
                }
            }
        } else {
            $this->db->where($condition);
        }

        if (!empty($search_term)) {
            $this->db->group_start();
            $this->db->like('CompanyName', $search_term);
            $this->db->or_like('Email', $search_term);
            $this->db->or_like('FirstName', $search_term);
            $this->db->or_like('LastName', $search_term);
            $this->db->group_end();
        }

        return $this->db->get('Contact');
    }

    public function get_contacts($conditions, $limit, $page, $search_term = null)
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
            $this->db->like('CompanyName', $search_term);
            $this->db->or_like('Email', $search_term);
            $this->db->or_like('FirstName', $search_term);
            $this->db->or_like('LastName', $search_term);
            $this->db->group_end();
        }
        $page = $page<=0 ? 1 : $page;
        $offset = $limit*($page-1);
        $this->db->order_by('Id','desc');
        return $this->db->get('Contact', $limit, $offset);
    }

    public function get_contact_count($conditions, $search_term = null)
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
            $this->db->like('CompanyName', $search_term);
            $this->db->or_like('Email', $search_term);
            $this->db->or_like('FirstName', $search_term);
            $this->db->or_like('LastName', $search_term);
            $this->db->group_end();
        }
        return $this->db->get('Contact')->num_rows();
    }

    public function insert_contact_document($data)
    {
        $this->db->insert('ContactFile', $data);
        return $this->db->insert_id();
    }

    public function get_contact_document($condition)
    {
        foreach ($condition as $key => $value) {
            $this->db->where($key, $value);
        }
        return $this->db->get('ContactFile');
    }

    public function delete_contact_document($condition)
    {
        foreach ($condition as $key => $value) {
            $this->db->where($key, $value);
        }
        $this->db->delete('ContactFile');
    }

    public function get_recent_contacts($limit)
    {
        $this->db->order_by('Id', 'desc');
        return $this->db->get('Contact', $limit);
    }
}