<?php
class User_model extends CI_Model
{
    public function insert_user($data) {
        $this->db->insert('User', $data);
        return $this->db->insert_id();
    }

    public function update_user($data, $condition)
    {
        foreach ($condition as $key => $value) {
            $this->db->where($key, $value);
        }
        $this->db->update('User', $data);
    }

    public function get_user($condition, $order_by = 'UserId', $order = 'desc' ) {
        if (is_array($condition)) {
            foreach ($condition as $key => $value) {
                $this->db->where($key, $value);
            }
        } else {
            $this->db->where($condition);
        }
        $this->db->order_by($order_by, $order);
        return $this->db->get('User');
    }

    public function get_active_users($conditions) {
        $this->db->select("*");
        if (count($conditions) > 0) {
            foreach ($conditions as $key => $value) {
                $this->db->where($key, $value);
            }
        }
        $this->db->order_by('UserId', 'asc');
        return $this->db->get('User');
    }

    public function get_users($conditions, $limit, $page, $search_term = null)
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
        if (!empty($search_term)) {
            $this->db->group_start();
            $this->db->like('UserName', $search_term);
            $this->db->or_like('Email', $search_term);
            $this->db->or_like('FirstName', $search_term);
            $this->db->or_like('LastName', $search_term);
            $this->db->group_end();
        }
        $offset = $limit*($page-1);
        $offset = $offset < 0 ? 0 : $offset;
        $this->db->order_by('UserId', 'asc');
        return $this->db->get('User', $limit, $offset);
    }

    public function get_user_count($conditions, $search_term = null)
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
            $this->db->like('UserName', $search_term);
            $this->db->or_like('Email', $search_term);
            $this->db->or_like('FirstName', $search_term);
            $this->db->or_like('LastName', $search_term);
            $this->db->group_end();
        }
        return $this->db->get('User')->num_rows();
    }

    public function insert_user_document($data)
    {
        $this->db->insert('UserFile', $data);
        return $this->db->insert_id();
    }

    public function get_user_document($condition)
    {
        foreach ($condition as $key => $value) {
            $this->db->where($key, $value);
        }
        return $this->db->get('UserFile');
    }

    public function delete_user_document($condition)
    {
        foreach ($condition as $key => $value) {
            $this->db->where($key, $value);
        }
        $this->db->delete('UserFile');
    }
}
