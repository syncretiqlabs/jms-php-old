<?php
defined('BASEPATH') OR exit('No direct script access allowed');

/*
| -------------------------------------------------------------------------
| URI ROUTING
| -------------------------------------------------------------------------
| This file lets you re-map URI requests to specific controller functions.
|
| Typically there is a one-to-one relationship between a URL string
| and its corresponding controller class/method. The segments in a
| URL normally follow this pattern:
|
|	example.com/class/method/id/
|
| In some instances, however, you may want to remap this relationship
| so that a different class/function is called than the one
| corresponding to the URL.
|
| Please see the user guide for complete details:
|
|	https://codeigniter.com/user_guide/general/routing.html
|
| -------------------------------------------------------------------------
| RESERVED ROUTES
| -------------------------------------------------------------------------
|
| There are three reserved routes:
|
|	$route['default_controller'] = 'welcome';
|
| This route indicates which controller class should be loaded if the
| URI contains no data. In the above example, the "welcome" class
| would be loaded.
|
|	$route['404_override'] = 'errors/page_missing';
|
| This route will tell the Router which controller/method to use if those
| provided in the URL cannot be matched to a valid route.
|
|	$route['translate_uri_dashes'] = FALSE;
|
| This is not exactly a route, but allows you to automatically route
| controller and method names that contain dashes. '-' isn't a valid
| class or method name character, so it requires translation.
| When you set this option to TRUE, it will replace ALL dashes in the
| controller and method URI segments.
|
| Examples:	my-controller/index	-> my_controller/index
|		my-controller/my-method	-> my_controller/my_method
*/
$route['default_controller'] = 'dashboard/index';
$route['404_override'] = '';
$route['translate_uri_dashes'] = FALSE;
$route['form'] = 'ajax/contact_ajax/file_upload';
$route['upload'] = 'ajax/contact_ajax';

$route['timesheet/index/(:num)'] = 'timesheet/index/$1';
$route['timesheet/index/(:num)/emp/(:num)/project/(:num)/start/(:num)/end/(:num)/(:any)/(:any)'] = 'timesheet/index/$1/$2/$3/$4/$5/$6/$7/$8';
$route['timesheet/export/(:num)/emp/(:num)/project/(:num)/start/(:num)/end/(:num)/(:any)/(:any)'] = 'timesheet/export/$1/$2/$3/$4/$5/$6/$7/$8';
$route['timesheet/add'] = 'timesheet/add';
$route['timesheet/createTimesheet'] = 'timesheet/createTimesheet';
$route['timesheet/get_jobs/(:num)'] = 'timesheet/getJobs/$1';
$route['timesheet/edit/(:num)'] = 'timesheet/edit/$1';
$route['timesheet/update/(:num)'] = 'timesheet/update/$1';


$route['project/joblist/(:any)/(:any)/(:any)/(:any)'] = 'job/getJobList/$1/$2/$3/$4';

$route['job/add/(:num)'] = 'job/add/$1';
$route['job/addDocuments'] = 'job/addJobDocuments';
$route['job/insertJob/(:num)'] = 'job/insertJob/$1';

$route['editTimesheetAjax/(:any)/(:any)/(:any)/(:any)/(:any)/(:any)/(:any)/(:any)/(:any)'] = 'timesheet/updateTimesheetAjax/$1/$2/$3/$4/$5/$6/$7/$8/$9';
$route['deleteJobTimesheet/(:num)/(:num)/(:num)'] = 'job/deleteJobTimesheet/$1/$2/$3';
$route['saveTimesheetAjax/(:any)/(:any)/(:any)/(:any)/(:any)/(:any)/(:any)/(:any)/(:any)/(:any)'] = 'timesheet/saveTimesheetAjax/$1/$2/$3/$4/$5/$6/$7/$8/$9/$10';
$route['deleteJobResource/(:num)/(:num)/(:num)'] = 'job/deleteJobResource/$1/$2/$3';


$route['project-id/(:num)/view-job-detail/(:num)'] = 'job/viewJobDetail/$1/$2';
$route['project-id/(:num)/edit/(:num)'] = 'job/editJob/$1/$2';
$route['project-id/(:num)/delete/(:num)'] = 'job/deleteJob/$1/$2';
$route['project-id/(:num)/delete/(:num)/(:num)'] = 'job/deleteJobDocuments/$1/$2/$3';
$route['projectInfoAjax/(:num)'] = 'job/getprojectInfoAjax/$1';
$route['project-id/(:num)/jobedit/(:num)'] = 'job/update/$1/$2';
$route['job/updateStatus'] = 'job/updateStatusCron';



$route['project/documents/(:num)'] = 'document/index/$1';


$route['project/project_detail/(:num)'] = 'project/project_detail/$1';


$route['user/jobs/1'] = 'job/getUserJobs/$1';

$route['user-view-job-detail/(:num)'] = 'job/userViewJobDetail/$1';

$route['project-id/(:num)/view-job-detail/(:num)'] = 'job/viewJobDetail/$1/$2';





//$route['jobs/(:num)/(:any)/(:any)'] = 'jobs/index/$1/$2/$3';
$route['jobs/add'] = 'jobs/add';
$route['jobs/insertJob'] = 'jobs/insertJob';
$route['jobs/jobDetail/(:num)'] = 'jobs/jobDetail/$1';
$route['jobs/edit/(:num)'] = 'jobs/edit/$1';
$route['jobs/editJob/(:num)'] = 'jobs/editJob/$1';
$route['jobs/addDocuments'] = 'jobs/addJobDocuments';
$route['jobs/delete/(:num)'] = 'jobs/deleteJob/$1';
$route['jobs/deleteJobResource/(:num)/(:num)'] = 'jobs/deleteJobResource/$1/$2';


$route['jobs/dispatched/(:any)/(:any)/(:any)/(:any)'] = 'jobs/dispatchedJobs/$1/$2/$3/$4';
$route['jobs/jobDispatchedDetail/(:num)'] = 'jobs/jobDispatchedDetail/$1';
$route['jobs/saveDispatchTimesheetAjax/(:any)/(:any)/(:any)/(:any)/(:any)/(:any)/(:any)/(:any)/(:any)/(:any)'] = 'timesheet/saveDispatchTimesheetAjax/$1/$2/$3/$4/$5/$6/$7/$8/$9/$10';
$route['jobs/editDispatchTimesheetAjax/(:any)/(:any)/(:any)/(:any)/(:any)/(:any)/(:any)/(:any)'] = 'timesheet/editDispatchTimesheetAjax/$1/$2/$3/$4/$5/$6/$7/$8';
$route['jobs/addDispatchDocuments'] = 'jobs/addDispatchDocuments';
$route['jobs/jobDispatchedDateEdit/(:num)'] = 'jobs/jobDispatchedDateEdit/$1';

$route['jobs/deleteFiles/(:num)'] = 'jobs/deleteJobDocuments/$1';
$route['jobs/jobDispatchDelete/(:num)'] = 'jobs/deleteJobDispatchDocuments/$1';

$route['jobs/jobDispatchDateDelete/(:num)'] = 'jobs/jobDispatchDateDelete/$1/$2/$3';
$route['jobs/deleteDispatchedDateResource/(:num)/(:num)/(:num)'] = 'jobs/deleteDispatchedDateResource/$1/$2/$3';
$route['jobs/swapDispatchResourceAjax/(:num)/(:num)/(:any)'] = 'jobs/swapDispatchResourceAjax/$1/$2/$3';

$route['deleteJobDispatchTimesheet/(:num)/(:num)'] = 'timesheet/deleteJobDispatchTimesheet/$1/$2';

$route['timesheet/get_jobs/(:num)/(:num)'] = 'timesheet/getJobs/$1/$2';




//$route['user/getActiveUsers'] = 'job/getActiveUsersOptions';

///

