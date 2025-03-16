<?php
defined('BASEPATH') OR exit('No direct script access allowed');
require_once APPPATH . 'controllers/Common.php';

class User extends Common {

	/**
	 * Index Page for this controller.
	 *
	 * Maps to the following URL
	 * 		http://example.com/index.php/welcome
	 *	- or -
	 * 		http://example.com/index.php/welcome/index
	 *	- or -
	 * Since this controller is set as the default controller in
	 * config/routes.php, it's displayed at http://example.com/
	 *
	 * So any other public methods not prefixed with an underscore will
	 * map to /index.php/welcome/<method_name>
	 * @see https://codeigniter.com/user_guide/general/urls.html
	 */

	public function __construct(){
		parent::__construct();
	
		// Load Model
		$this->load->model('user_model');
	
		// Load base_url
		$this->load->helper('url');

		//$this->active_controller_name = $this->router->fetch_class();
	}

	

	public function index($page = 1, $limit = 20)
	{
		$condition = [];
        $show_active_user_only = 0;
		if (!empty($_SERVER['QUERY_STRING'])) {
            parse_str($this->encrypt->decode($_SERVER['QUERY_STRING']), $queries);
            //print_r($queries);
            $query_term = '?';
            if (!empty($queries)) {
                foreach ($queries as $name => $value) {
                    $query_term .= "$name=$value";
                }
            }
        } else {
            $query_term = '?is_active=1';
            $show_active_user_only = 1;
        }

        $this->smarty->assign('query_term', $_SERVER['QUERY_STRING']);

        $search_term = !empty($queries['search_term']) ? $queries['search_term'] : '';
        $this->smarty->assign('search_term', $search_term);

        $user_type = !empty($queries['user_type']) ? explode(',', preg_replace('/[\(\)]/', '', $queries['user_type'])) : [];
        $this->smarty->assign('user_type', $user_type);
        

        $user_role = !empty($queries['user_role']) ? explode(',', preg_replace('/[\(\)]/', '', $queries['user_role'])) : [];
        $this->smarty->assign('user_role', $user_role);

        $is_active = !empty($queries['is_active']) ? explode(',', preg_replace('/[\(\)]/', '', $queries['is_active'])) : [];
        $this->smarty->assign('is_active', $is_active);

        if ($show_active_user_only == 1) {
            $is_active = ['1'];
            $this->smarty->assign('is_active', $is_active);
        }

        $condition = [];
        if (!empty($user_type)) {
            $condition['UserType'] = $user_type;
        }
        if (!empty($user_role)) {
            $condition['UserRole'] = $user_role;
        }
        if (!empty($is_active)) {
			$condition['Status'] = $is_active;
		}

        $users_list = [];
        $total_records = 0;
        $users = $this->user_model->get_users($condition, $limit, $page, $search_term);
        if ($users->num_rows() > 0) {
            $users_list = $users->result_array();
            $total_records = $this->user_model->get_user_count($condition, $search_term);
        }
        $this->smarty->assign('users', $users_list);

        $number_of_pages = ceil($total_records/$limit);
        $url = $this->host_url . '/index.php/user/user/index';

        $this->smarty->assign('total_records', $total_records);
        $this->smarty->assign('number_of_pages', $number_of_pages);
        $this->smarty->assign('current_page', $page);
        $this->smarty->assign('limit', $limit);
        $this->smarty->assign('url', $url);

        $this->smarty->display('user/user.tpl');
	}

	public function encrypt()
    {
        $post_value = $this->input->get();
        $query = '';
        $url = $this->host_url . '/index.php/user/user/index/?';
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
                        if ($i==0) {
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
}
