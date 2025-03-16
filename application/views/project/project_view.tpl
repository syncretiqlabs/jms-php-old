{include file="../common/head.tpl"}

<section>
    <div class="container">
{if (isset($fN_sess) && $fN_sess!="")}
         <div class="alert alert-primary alert-dismissible fade show" role="alert">
  <strong>{$fN_sess}</strong></div>
  <script>
  $(document).ready(function() {
          $(".alert-primary").slideUp(3000);
  });
</script>
{/if}
        <!--<div class="searchBar">
            <div class="input-group mb-3 input-group-lg">
                <input type="text" class="form-control" placeholder="Search Customer / Project"
                    aria-label="Recipient's username" aria-describedby="button-addon2">
                <div class="input-group-append mr-3">
                    <button class="btn btn-secondary" type="button" id="button-addon2"><i
                            class="icofont-search-2"></i></button>
                </div>
                <a class="btn btn-md btn-primary mr-1 p-3"><i class="icofont-plus-circle"></i> Add Projects</a>
            </div>
        </div>-->
        {if isset($project.Name)}
        <h1 class="mb-1 pb-1">Project- {$project.Name}</h1>
        {/if}
        <div class="mb-2">
        {if isset($logged_in_user.UserRole) && $logged_in_user.UserRole != 'member'}
            <a href="{$host_url}/index.php/project/project"><i class="icofont-rounded-left"></i>&nbsp; Back to Project Listing</a>
        {/if}
        </div>
        <div class="boxStyle p-4">
            <div class="row">
                <div class="col-3 leftMenu">
                {include file="../common/projectleftmenu.tpl"}

                </div>
                <div class="col-9 rightContent">
                    <div class="tab-content" id="v-pills-tabContent">
                        <div class="tab-pane fade show active" id="v-pills-home" role="tabpanel"
                            aria-labelledby="v-pills-home-tab">
                            <div class="border-bottom py-2 row">
                                <div class="col-sm-8">
                                    <h4>Basic Information</h4>
                                </div>
                                {if isset($logged_in_user.UserRole) && $logged_in_user.UserRole != 'member'}
                                <div class="col-sm-4 text-right">
                                    <a href="{$host_url}/index.php/project/project_detail/editProject/{$project.Id}"><i class="icofont-ui-edit"></i>&nbsp; Edit Project</a>&nbsp;&nbsp;
                                </div>
                                {/if}
                            </div>


                                <input type="hidden" name="id" value="{if isset($project.Id)}{$project.Id}{else}new{/if}">
                                <div class="form-group row" style="padding-top:10px">
                                    <label for="" class="col-sm-3  text-right">Status-</label>
                                    <div class="col-sm-9">
                                    {if isset($project.Status) && $project.Status=="new"}
                                    New
                                    {elseif isset($project.Status) && $project.Status=="inprogress"}
                                    Inprogress
                                    {elseif isset($project.Status) && $project.Status=="completed"}
                                    Completed
                                    {elseif isset($project.Status) && $project.Status=="approved"}
                                    Approved
                                    {/if} 
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="" class="col-sm-3  text-right">Project Name-</label>
                                    <div class="col-sm-9">
                                        {if isset($project.Name)}{$project.Name}{/if}
                                    </div>
                                </div>

                                <div class="form-row">
                                    <div class="col-12">
                                        <div class="form-group row">
                                            <label for="" class="col-3  text-right">Project Type-</label>
                                            <div class="col-sm-3">
                                            {if isset($project.Type) && $project.Type == 'onetime'}OneTime{/if}

                                            {if isset($project.Type) && $project.Type == 'contract'}Contract{/if}
                                                
                                            </div>
                                            {if isset($project.Type) && $project.Type == 'contract'}
                                            <label for="contract_hours"
                                                class="contract_hours col-sm-3  text-right"  >Time In                                             Hours-</label>
                                            <div class="col-sm-3">
                                                {$project.ContractHours}
                                            </div>
                                            {/if}
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="" class="col-sm-3  text-right">Customer Name-</label>
                                    <div class="col-sm-9">
                                     
                                    </div>
                                </div> 

                                <div class="form-row">
                                    <div class="col-12">
                                        <div class="form-group row">
                                            <label for="" class="col-3  text-right">Address-</label>
                                            <div class="col-sm-5">
                                                {if isset($project.Address1)} {$project.Address1} {/if}
                                            </div> 
                                        </div>
                                    </div>
                                </div>

                                <div class="form-row">
                                    <div class="col-12">
                                        <div class="form-group row">
                                            <label for="" class="col-3  text-right">Suburb-</label>
                                            <div class="col-sm-5">
                                                {if isset($project.Suburb)} {$project.Suburb} {/if}
                                            </div>
                                            <div class="col-sm-2">
                                                City-{if isset($project.City)} {$project.City} {/if}
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="" class="col-sm-3  text-right">Description-</label>
                                    <div class="col-sm-9">
                                        {if isset($project.Description)} {$project.Description} {/if}
                                    </div>
                                </div>



                                <div class="form-row">
                                    <div class="col-12">
                                        <div class="form-group row">
                                            <label for="" class="col-3  text-right">Order No-</label>
                                            <div class="col-sm-3">
                                                {if isset($project.OrderId)} {$project.OrderId} {/if}
                                            </div>
                                            <label for="" class="col-sm-3  text-right">Code /Job
                                                no-</label>
                                            <div class="col-sm-3"> 
                                                {if isset($project.JobId)}{$project.JobId}{/if}
                                            </div>
                                        </div>
                                    </div>
                                </div>
 



                                <div class="form-group row">
                                    <label class="col-sm-3  text-right">Start Date-</label>
                                    <div class="col-sm-9">
                                        {if isset($project.StartDate)}{$project.StartDate}{/if}
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-sm-3  text-right">End Date-</label>
                                    <div class="col-sm-9">
                                    {if isset($project.EndDate)}{$project.EndDate}{/if}
                                    </div>
                                </div>

 

                                <div class="form-group row">
                                    <label class="col-sm-3  text-right">Notes-</label>
                                    <div class="col-sm-9">
                                    {if isset($project.Notes)}{$project.Notes}{/if}
                                    </div>
                                </div>

                                 
                            </form>


                        </div>

                        <div class="tab-pane" id="v-pills-jobs" role="tabpanel" aria-labelledby="v-pills-jobs-tab">
                            <div class="border-bottom py-2 row">
                                <div class="col-sm-8">
                                    <h4>Jobs</h4>
                                </div>
                                <div class="col-sm-4 text-right">
                                                <a class="btn btn-sm btn-primary" href="{$host_url}/index.php/job/add/{if isset($project.Id)}{$project.Id}{/if}" ><i class="icofont-plus-circle"></i>&nbsp; Add Job</a>
                                </div>

                                <!-- Modal -->
                                <div class="modal fade" id="jobModal" tabindex="-1" aria-labelledby="exampleModalLabel"
                                    aria-hidden="true">
                                    <div class="modal-dialog modal-lg">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="exampleModalLabel">Job Details</h5>
                                                <button type="button" class="close" data-dismiss="modal"
                                                    aria-label="Close">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                            <div class="modal-body">
                                            <span class='loader' style="display: none;"><img src='loader.gif'></span>
                                                <form class="form_add-job" method="post">
                                                    <input type="hidden" name="project_id" value="{if isset($project.Id)}{$project.Id}{else}new{/if}">
                                                    <div class="form-group row">
                                                        <label for="inputPassword" class="col-sm-3  text-right">Date</label>
                                                        <div class="col-sm-9">
                                                            <input type="datetime-local" class="form-control" id="date" name="job_date" placeholder="Date">
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label for="inputPassword" class="col-sm-3  text-right">Job Name</label>
                                                        <div class="col-sm-9">
                                                            <input type="text" class="form-control" id="job_name" name="job_name" placeholder="Job Name">
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label for="inputPassword" class="col-sm-3  text-right">Description</label>
                                                        <div class="col-sm-9">
                                                            <textarea class="form-control" id="job_desc" name="job_description" rows="3" placeholder="Description"></textarea>
                                                        </div>
                                                    </div>
                                                    <hr>
                                                    <div class="">
                                                        <h5>Resources:</h5>
                                                    </div>
                                                    <div class="assign_user">
                                                        {if isset($users)}
                                                            <div class="user form-group row">
                                                                <div class="col-sm-6">
                                                                    <select class="resource form-control" name="user_assigned[]">
                                                                        {foreach from=$users key=key item=user}
                                                                            <option value="{$user.UserId}">{$user.UserName}</option>
                                                                        {/foreach}
                                                                    </select>
                                                                </div>

                                                                <div class="col-sm-4">
                                                                    <div class="btn-group btn-group-toggle"
                                                                        data-toggle="buttons">
                                                                        <label class="btn btn-sm btn-tertiary active"><input type="radio" name="user_type" id="option1"checked>Employee</label>
                                                                        <label class="btn btn-sm btn-tertiary"><input type="radio" name="user_type" id="option2">Supervisor</label>
                                                                    </div>
                                                                </div>
                                                                <div class="col-sm-2">
                                                                    <a href="#" class="delete_user btn btn-sm" data-toggle="tooltip" data-placement="bottom" title="Delete"><i class="active icofont-ui-delete"></i> Delete</a>
                                                                </div>
                                                            </div>
                                                        {/if}
                                                    </div>
                                                    
                                            </div>
                                            
                                        </div>
                                    </div>
                                </div>

                            </div>
                            {$logged_in_user.UserRole}
                            {if isset($logged_in_user.UserRole) && $logged_in_user.UserRole != 'member'}
                            <h6 class="mt-2">Project: {if isset($project.Name)} {$project.Name}{$project.Address1}{$project.Suburb}{$project.City}-{/if}</h6>
                            <table class="table table-hover table-responsive-sm" id="jobList">
                                <thead class="thead-dark">
                                    <tr>
                                        <th scope="col">Date</th>
                                        <th scope="col">Job Name <a href="#" class="caret"><i
                                                    class="icofont-caret-down"></i></a></th>
                                        <th scope="col">Description</th>
                                        <th scope="col">Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {if isset($jobs)}
                                        {foreach from=$jobs key=key item=value}
                                        <tr>
                                            <td>{$value.JobStartDate}</td>
                                            <td>{$value.Name}</td>
                                            <td>{$value.Description}</td>
                                            <td><a href="{$host_url}/index.php/project-id/{$value.ProjectId}/view-job-detail/{$value.Id}" class="btn btn-sm" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="View"><i class="active icofont-eye-alt"></i></a>
                                                <a href="#" class="btn btn-sm" data-toggle="modal" data-placement="bottom"
                                                    title="Edit" data-id="{$value.Id}" data-target="#jobModal"><i class="active icofont-ui-edit"></i></a>
                                                <a href="#" class="delete_job btn btn-sm" data-id="{$value.Id}"><i class="active icofont-ui-delete"></i></a>
                                            </td>
                                        </tr>
                                        {/foreach}
                                    {else}
                                        <tr>
                                            <td>No job created yet</td>
                                        </tr>
                                    {/if}
                                </tbody>
                            </table>
                            {/if}
                        </div>
                        {if isset($logged_in_user.UserRole) && $logged_in_user.UserRole != 'member'}
                        <div class="tab-pane fade" id="v-pills-documents" role="tabpanel"
                            aria-labelledby="v-pills-documents-tab">
                            <h2>Documents</h2>
                            <p>Documents</p>
                        </div>
                        {/if}
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<script type="text/x-jquery-tmpl" id="tmpl_add_job">
    <tr>
        {literal}<td>${JobDateTime}</td>{/literal}
        {literal}<td>${Name}</td>{/literal}
        {literal}<td>${Description}</td>{/literal}
        <td>
            <a href="#" class="btn btn-sm" data-toggle="tooltip" data-placement="bottom" title="Edit"><i class="active icofont-ui-edit"></i></a>
            <a href="#" class="btn btn-sm" data-toggle="tooltip" data-placement="bottom" title="Delete"><i class="active icofont-ui-delete"></i></a>
        </td>
    </tr>
</script>
<script>
{if isset($contactDetail["Address1"]) && $contactDetail["Address1"]!=''}
function setProjectAddress(){
    $("#address").val('{$contactDetail["Address1"]}');
    $("#suburb").val('{$contactDetail["Suburb"]}');
    $("#city").val('{$contactDetail["City"]}');
    $("#sameAsContact").html('<a href="javascript:void(0);" onclick="javascript:setAddressFunction();">(Clear)</a>')

}

function setAddressFunction(){
    $("#address").val('');
    $("#suburb").val('');
    $("#city").val('');
    $("#sameAsContact").html('<a href="javascript:void(0);" onclick="javascript:setProjectAddress();">(Same As Contact)</a>');
    
}
{/if} 
</script>


{include file="../common/footer.tpl"}
