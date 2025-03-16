<?php
defined('BASEPATH') OR exit('No direct script access allowed');
require_once APPPATH . 'controllers/Common.php';

class Contact extends Common {

    public function __construct()
    {
        parent::__construct();
	
		// Load Model
		$this->load->model('contact_model');
	
		// Load base_url
		$this->load->helper('url');

		//$this->active_controller_name = $this->router->fetch_class();
    }

    public function index($page = 1, $limit = 2)
    {
        $search_term = null;
        $queries = [];
        $category = [];
        $contact_type = [];
        $is_active = [];
        $query_term = '';
        $show_active_contact_only = 0;
        
        $limit=$this->config->item('page_limit');
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
            $show_active_contact_only = 1;
        }

        $this->smarty->assign('query_term', $_SERVER['QUERY_STRING']);

        $search_term = !empty($queries['search_term']) ? $queries['search_term'] : '';
        $this->smarty->assign('search_term', $search_term);

        $category = !empty($queries['category']) ? explode(',', preg_replace('/[\(\)]/', '', $queries['category'])) : [];
        $this->smarty->assign('category', $category);
        

        $contact_type = !empty($queries['contact_type']) ? explode(',', preg_replace('/[\(\)]/', '', $queries['contact_type'])) : [];
        $this->smarty->assign('contact_type', $contact_type);

        $is_active = !empty($queries['is_active']) ? explode(',', preg_replace('/[\(\)]/', '', $queries['is_active'])) : [];
        $this->smarty->assign('is_active', $is_active);

        if ($show_active_contact_only == 1) {
            $is_active = ['1'];
            $this->smarty->assign('is_active', $is_active);
        }

        $condition = [];
        if (!empty($category)) {
            $condition['ContactCategory'] = $category;
        }
        if (!empty($contact_type)) {
            $condition['ContactType'] = $contact_type;
        }
        if (!empty($is_active)) {
            $condition['IsActive'] = $is_active;
        }
        $contacts_list = [];
        $total_records = 0;
        $contacts = $this->contact_model->get_contacts($condition, $limit, $page, $search_term);
        if ($contacts->num_rows() > 0) {
            $contacts_list = $contacts->result_array();
            $total_records = $this->contact_model->get_contact_count($condition, $search_term);
        }

        $this->smarty->assign('contacts', $contacts_list);

        $number_of_pages = ceil($total_records/$limit);
        $url = $this->host_url . '/index.php/contact/contact/index';

        $this->smarty->assign('total_records', $total_records);
        $this->smarty->assign('number_of_pages', $number_of_pages);
        $this->smarty->assign('current_page', $page);
        $this->smarty->assign('limit', $limit);
        $this->smarty->assign('url', $url);

        $this->smarty->display('contact/contact.tpl');
    }

    public function encrypt()
    {
        $post_value = $this->input->get();
        $query = '';
        $url = $this->host_url . '/index.php/contact/contact/index/?';
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

    public function addAjaxContact(){
        $data["CompanyName"]=$_GET["contactcompanyName"];
        $data["Email"] = !empty($_GET["contactemail"]) ? $_GET["contactemail"] : null;
        $data["Address1"]=!empty($_GET["contactaddress1"]) ? $_GET["contactaddress1"] : null;
        $data["Suburb"]=!empty($_GET["contactsuburb"]) ? $_GET["contactsuburb"] : null;
        $data["City"]=!empty($_GET["contactcity"]) ? $_GET["contactcity"] : null;
        $data["Mobile"]=!empty($_GET["contactphone"]) ? $_GET["contactphone"] : null;
        $data["Phone"]=!empty($_GET["contactphone"]) ? $_GET["contactphone"] : null;
        $data["IsActive"]='1';
        $data["AddedOn"]=date("Y-m-d");
        $data["AddedBy"]=$this->session->userdata('UserId');
        $data["ModifiedOn"]=date("Y-m-d");
        $data["ModifiedBy"]=$this->session->userdata('UserId');;
        $data["ContactType"]=$_GET["contacttype"];
        $data["ContactCategory"]=$_GET["contactcategory"];
        $data["FirstName"]=!empty($_GET["contactfirstName"]) ? $_GET["contactfirstName"] : null;
        $data["LastName"]=!empty($_GET["contactlastName"]) ? $_GET["contactlastName"] : null;
        $this->db->insert('Contact', $data);
        $newContact = $this->db->insert_id();
        $this->db->select("*");
        $cnts=$this->db->where('ContactCategory', 'Customer');
        $cnts=$this->db->get('Contact');
        $cnts_res = $cnts->result_array();
        $html='';
        $result = [];
        foreach ($cnts_res as $contactkey => $contactvalue) {
            if($newContact==$contactvalue["Id"]) {
                $selected=" selected= 'selected' ";
                $result['current_contact'] = $contactvalue;
            } else {
                $selected='';
            }
            if($contactvalue["ContactType"]== "Organisation")
                $html.='<option value="'.$contactvalue["Id"].'"'. $selected.'>'.$contactvalue["CompanyName"].'(Organisation)</option>';
            else
                $html.='<option value="'.$contactvalue["Id"].'"'. $selected.'>'.$contactvalue["FirstName"]." ".$contactvalue["LastName"].'(People)</option>';

        }
        $result['html'] = $html;
        echo json_encode($result);
    }

    public function getContact() {
        $contact_id = $_GET['id'];
        $this->db->select("*");
        $cnts=$this->db->where('Id', $contact_id);
        $cnts=$this->db->get('Contact')->row_array();
        echo json_encode($cnts);
    }
}