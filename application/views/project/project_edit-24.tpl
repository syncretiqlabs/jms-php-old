{include file="../common/head.tpl"}

<section>
    <div class="container">

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
            <a href="{$host_url}/index.php/project/project"><i class="icofont-rounded-left"></i>&nbsp; Back to Project Listing</a>
        </div>
        <div class="boxStyle p-4">
            <div class="row">
                <div class="col-3 leftMenu">
                {if isset($project.Id)}
                    {include file="../common/projectleftmenu.tpl"}                 
                {else}
                <div class="nav flex-column nav-pills" id="v-pills-tab" role="tablist" aria-orientation="vertical">
                    <a class="nav-link  active" id="v-pills-home-tab" data-toggle="pill" href="#v-pills-home" role="tab" aria-controls="v-pills-home" aria-selected="true">Basic Information</a>  
                  </div>       
                {/if}

                </div>
                <div class="col-9 rightContent">
                    <div class="tab-content" id="v-pills-tabContent">
                        <div class="tab-pane fade show active" id="v-pills-home" role="tabpanel"
                            aria-labelledby="v-pills-home-tab">
                            <div class="border-bottom py-2 row">
                                <div class="col-sm-8">
                                    <h4>Basic Information</h4>
                                </div>
                                <div class="col-sm-4 text-right">

                                </div>
                            </div>


                            <form class="mt-2" method="POST">
                                <input type="hidden" name="id" value="{if isset($project.Id)}{$project.Id}{else}new{/if}">
                                <div class="form-group row">
                                    <label for="" class="col-sm-3 col-form-label text-right">Status</label>
                                    <div class="col-sm-9">
                                        <select id="status" class="form-control" name="status">
                                            <option >Select...</option>
                                            <option value="new" {if isset($project.Status) && $project.Status=="new"} selected="selected" {/if} selected='selected' >New</option>
                                            <option value="inprogress"{if isset($project.Status) && $project.Status=="inprogress"} selected="selected" {/if}>Inprogress</option>
                                            <option value="completed"{if isset($project.Status) && $project.Status=="completed"} selected="selected" {/if}>Completed</option>
                                            <option value="approved"{if isset($project.Status) && $project.Status=="approved"} selected="selected" {/if}>Approved</option>                                             
                                        </select>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="" class="col-sm-3 col-form-label text-right">Project Name</label>
                                    <div class="col-sm-9">
                                        <input type="text" class="form-control" id="project_name" name="project_name" value="{if isset($project.Name)}{$project.Name}{/if}" placeholder="Project name">
                                    </div>
                                </div>

                                <div class="form-row">
                                    <div class="col-12">
                                        <div class="form-group row">
                                            <label for="" class="col-3 col-form-label text-right">Project Type</label>
                                            <div class="col-sm-3">
                                                <select name='project_type' class="form-control" id="project_type">
                                                    <option value="oneTime"
                                                        {if isset($project.Type) && $project.Type == 'onetime'}selected{/if}>
                                                        OneTime</option>
                                                    <option value="contract"
                                                        {if isset($project.Type) && $project.Type == 'contract'}selected{/if}>
                                                        Contract</option>
                                                </select>
                                            </div>
                                            <label for="contract_hours"
                                                class="contract_hours col-sm-3 col-form-label text-right"
                                                {if isset($project.Type) && $project.Type == 'onetime'}style="display:none;"
                                                {/if}>Time In
                                                Hours:</label>
                                            <div class="col-sm-3">
                                                <input type="number" class="form-control contract_hours"
                                                    {if isset($project.Type) && $project.Type == 'onetime'}style="display:none;"
                                                    {/if} id="contract_hours" name="contract_hours" placeholder="48" value="{if isset($project.ContractHours)}{$project.ContractHours}{/if}">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="" class="col-sm-3 col-form-label text-right">Customer Name</label>
                                    <div class="col-sm-9">
                                        <select id="customer_id" class="form-control" name="customer_id">
                                            <option selected>Select...</option>
                                            {foreach $contact_list as $value}
                                            <option value="{$value.Id}" {if isset($project.ContactId) && $project.ContactId==$value.Id} selected="selected" {/if}>
                                                    {if $value.ContactType == "Organisation"}
                                                        {$value.CompanyName} (Organisation)
                                                    {else}
                                                        {$value.FirstName} {$value.LastName} (People)
                                                    {/if}
                                                </option>
                                            {/foreach}
                                        </select>
                                    </div>
                                </div>

                                <div class="form-row">
                                    <div class="col-12">
                                        <div class="form-group row">
                                            <label for="" class="col-3 col-form-label text-right">Address</label>
                                            <div class="col-sm-9">
                                        <input type="text" class="form-control" id="address" name="address" value="{if isset($project.Address1)} {$project.Address1} {/if}" placeholder="Line 1">
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-row">
                                    <div class="col-12">
                                        <div class="form-group row">
                                            <label for="" class="col-3 col-form-label text-right"></label>
                                            <div class="col-sm-5">
                                                <input type="text" class="form-control" id="suburb" name="suburb" value="{if isset($project.Suburb)} {$project.Suburb} {/if}" placeholder="Suburb">
                                            </div>
                                            <div class="col-sm-2">
                                                <input type="text" class="form-control" id="city" name="city" value="{if isset($project.City)} {$project.City} {/if}" placeholder="City">
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="" class="col-sm-3 col-form-label text-right">Description</label>
                                    <div class="col-sm-9">
                                        <textarea type="textarea" class="form-control" name="description" placeholder="Description"></textarea>
                                    </div>
                                </div>



                                <div class="form-row">
                                    <div class="col-12">
                                        <div class="form-group row">
                                            <label for="" class="col-3 col-form-label text-right">Order No</label>
                                            <div class="col-sm-3">
                                                <input type="text" class="form-control" id="order_no" name="order_no" placeholder="Order no">
                                            </div>
                                            <label for="" class="col-sm-3 col-form-label text-right">Code /Job
                                                no:</label>
                                            <div class="col-sm-3"> 
                                                <input type="text" class="form-control" id="job_no" name="job_no" placeholder="Job no">
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-sm-3 col-form-label text-right">Date/Time</label>
                                    <div class="col-sm-9">
                                        <input type="text" name="datetimes" class="form-control datetimerange" value="10/24/1984" />
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-sm-3 col-form-label text-right">Notes</label>
                                    <div class="col-sm-9">
                                        <input type="text" class="form-control" placeholder="Notes if required">
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="" class="col-sm-3 col-form-label text-right"></label>
                                    <div class="col-sm-9">
                                        <button type="submit" name="button" value="submit_general" class="btn btn-lg btn-primary">Save</button>
                                        <button type="submit" class="btn btn-lg btn-secondary">Cancel</button>
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
                                                        <label for="inputPassword" class="col-sm-3 col-form-label text-right">Date</label>
                                                        <div class="col-sm-9">
                                                            <input type="datetime-local" class="form-control" id="date" name="job_date" placeholder="Date">
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label for="inputPassword" class="col-sm-3 col-form-label text-right">Job Name</label>
                                                        <div class="col-sm-9">
                                                            <input type="text" class="form-control" id="job_name" name="job_name" placeholder="Job Name">
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label for="inputPassword" class="col-sm-3 col-form-label text-right">Description</label>
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
                                                    <div>
                                                        <a href="#" class="add_user_for_job btn btn-outline-secondary"><i class="icofont-plus-circle"></i> Add Name</a>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary"
                                                            data-dismiss="modal">Close</button>
                                                        <button type="submit" class="btn btn-primary">Save changes</button>
                                                    </div>
                                                </form>
                                            </div>
                                            
                                        </div>
                                    </div>
                                </div>

                            </div>
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
                        </div>
                        <div class="tab-pane fade" id="v-pills-documents" role="tabpanel"
                            aria-labelledby="v-pills-documents-tab">
                            <h2>Documents</h2>
                            <p>Documents</p>
                        </div>
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



{include file="../common/footer.tpl"}
