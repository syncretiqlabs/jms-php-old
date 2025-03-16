<?php
defined('BASEPATH') or exit('No direct script access allowed');
require_once APPPATH . 'controllers/Common.php';

class Contact_edit extends Common
{

    public function __construct()
    {
        parent::__construct();

        // Load Model
        $this->load->model('contact_model');

        // Load base_url
        $this->load->helper('url');
        $this->load->helper(array('form', 'url'));
    }

    public function index($inserted_id = '')
    {
        $type = 'people';
        $task = 'edit';
        if ($this->input->post('button') == 'submit_general') {
            $data = [
                'ContactType' => $this->input->post('contact_type') ? $this->input->post('contact_type') : '',
                'CompanyName' => $this->input->post('company_name') ? $this->input->post('company_name') : null,
                'FirstName' => $this->input->post('first_name') ? $this->input->post('first_name') : null,
                'LastName' => $this->input->post('last_name') ? $this->input->post('last_name') : null,
                'Phone' => $this->input->post('phone') ? $this->input->post('phone') : null,
                'Mobile' => $this->input->post('mobile') ? $this->input->post('mobile') : null,
                'Email' => $this->input->post('email'),
                'Address1' => $this->input->post('address') ? $this->input->post('address') : null,
                'Suburb' => $this->input->post('suburb') ? $this->input->post('suburb') : null,
                'City' => $this->input->post('city') ? $this->input->post('city') : null,
                'ContactCategory' => $this->input->post('contact_category') ? $this->input->post('contact_category') : 'Customer',
                'IsActive' => $this->input->post('contact_status') ? $this->input->post('contact_status') : 1,
            ];
            if ($this->input->post('id') != 'new') {
                $condition = ['Id' => $this->input->post('id')];
                if ($this->contact_model->get_contact($condition)->num_rows() > 0) {
                    $data['ModifiedOn'] = date('Y-m-d H:i:s');
                    $data['ModifiedBy'] = $this->session->userdata('UserId');
                    $this->contact_model->update_contact($data, $condition);
                    $inserted_id = $this->input->post('id');
                }
            } else {
                $data['AddedOn'] = date('Y-m-d H:i:s');
                $data['AddedBy'] = $this->session->userdata('UserId');
                $inserted_id = $this->contact_model->insert_contact($data);
            }
            $task = 'detail';
        }
        if (!empty($inserted_id)) {
            if ($task == "detail") {
                $url = $this->host_url . "/index.php/contact/contact_edit/details/$inserted_id";
				redirect($url);
            } else {
                $condition = ['Id' => $inserted_id];
                $contact = $this->contact_model->get_contact($condition)->row_array();
                if (!empty($contact['CompanyName'])) {
                    $type = 'organization';
                }
                $contact_document = $this->contact_model->get_contact_document(['ContactId' => $inserted_id]);
                if($contact_document->num_rows() > 0) {
                    $contact_documents = $contact_document->result_array();
                    $this->smarty->assign('contact_documents', $contact_documents);
                }
                $this->smarty->assign('contact', $contact);
            }
        }
        $this->smarty->display('contact/contact_edit.tpl');
    }

    public function details($id)
    {
        $contact = [];
        if (!empty($id)) {
            $condition = ['Id' => $id];
            $contact = $this->contact_model->get_contact($condition)->row_array();
            if (!empty($contact['CompanyName'])) {
                $type = 'organization';
            }
            $contact_document = $this->contact_model->get_contact_document(['ContactId' => $id]);
            if($contact_document->num_rows() > 0) {
                $contact_documents = $contact_document->result_array();
                $this->smarty->assign('contact_documents', $contact_documents);
            }
            $this->smarty->assign('contact', $contact);
        }
        $this->smarty->display('contact/contact_details.tpl');
    }
}
