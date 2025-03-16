{include file="../common/head.tpl"}

<section>
    <div class="container">

         {$fN_sess}

        <h1 class="mb-1 pb-1">Project-{$project.Name}</h1>
        <div class="mb-2">
            <a href="{$host_url}/index.php/project/project"><i class="icofont-rounded-left"></i>&nbsp; Back to listing</a>
        </div>
        <div class="boxStyle p-4">
            <div class="row">
                <div class="col-3 leftMenu">
                    {include file="../common/projectleftmenu.tpl"}

                </div>
                <div class="col-9 rightContent">
                    <div class="tab-content" id="v-pills-tabContent">
                        <div class="tab-pane fade show " id="v-pills-home" role="tabpanel"
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
                                        <select id="customer_id" class="form-control" name="customer_id">
                                            <option selected>Select...</option>
                                            <option value="{$value.Id}" {if isset($project.Statusv) && ($project.ContactId == $value.Id)}selected{/if}>
                                                    {if isset($value.ContactId)}{$value.CompanyName}{elseif isset($value.FirstName)}{$value.FirstName} {$value.LastName}{/if}
                                            </option>
                                        </select>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="" class="col-sm-3 col-form-label text-right">Project Name</label>
                                    <div class="col-sm-9">
                                        <input type="text" class="form-control" id="project_name" name="project_name" value="{if isset($project.Name)}{$project.Name}{/if}" placeholder="Project name">
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="" class="col-sm-3 col-form-label text-right">Customer Name</label>
                                    <div class="col-sm-9">
                                        <select id="customer_id" class="form-control" name="customer_id">
                                            <option selected>Select...</option>
                                            {foreach from=$contact_list key=key item=value}
                                            <option value="{$value.Id}" {if isset($project.ContactId) && ($project.ContactId == $value.Id)}selected{/if}>
                                                    {if isset($value.ContactId)}{$value.CompanyName}{elseif isset($value.FirstName)}{$value.FirstName} {$value.LastName}{/if}
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
                                        <input type="text" class="form-control" id="address" name="address" value="{if isset($project)} {$project.Address1} {/if}" placeholder="Line 1">
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-row">
                                    <div class="col-12">
                                        <div class="form-group row">
                                            <label for="" class="col-3 col-form-label text-right"></label>
                                            <div class="col-sm-5">
                                                <input type="text" class="form-control" id="suburb" name="suburb" value="{if isset($project)} {$project.Suburb} {/if}" placeholder="Suburb">
                                            </div>
                                            <div class="col-sm-2">
                                                <input type="text" class="form-control" id="city" name="city" value="{if isset($project)} {$project.City} {/if}" placeholder="City">
                                            </div>
                                            <div class="col-sm-2">
                                                <input type="text" class="form-control" id="postcode" name="postcode" value="{if isset($project)} {$project.PostCode} {/if}" placeholder="Postcode">
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

                        <div class=" " id="v-pills-jobs active" role="tabpanel" aria-labelledby="v-pills-jobs-tab">
                            <div class="border-bottom py-2 row">
                                <div class="col-sm-8">
                                    <h4>Jobs</h4>
                                </div>
                                <div class="col-sm-4 text-right">
                                    <a class="btn btn-sm btn-primary" href="{$host_url}/index.php/job/add/{$project.Id}" ><i class="icofont-plus-circle"></i>&nbsp; Add Job</a>
                                </div>

                                

                            </div>
                            <h6 class="mt-2">Project: {if isset($project)} {$project.Name}{$project.Address1}{$project.Suburb}{$project.City}-{$project.PostCode}{/if}</h6>
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
                                        {foreach $jobs as $value}
                                        <tr>
                                            <td>{$value.JobStartDate}</td>
                                            <td>{$value.Name}</td>
                                            <td>{$value.Description}</td>
                                            <td><a href="{$host_url}/index.php/project-id/{$value.ProjectId}/view-job-detail/{$value.Id}" class="btn btn-sm" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="View"><i class="active icofont-eye-alt"></i></a>
                                                <a href="{$host_url}/index.php/project-id/{$value.ProjectId}/edit/{$value.Id}" class="btn btn-sm" 
                                                    title="Edit" data-id="{$value.Id}" ><i class="active icofont-ui-edit"></i></a>
                                                <a href="{$host_url}/index.php/project-id/{$value.ProjectId}/delete/{$value.Id}" class="delete_job btn btn-sm" data-id="{$value.Id}"><i class="active icofont-ui-delete"></i></a>
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
                        <div class="tab-pane fade" id="v-pills-timesheet" role="tabpanel"
                            aria-labelledby="v-pills-timesheet-tab">
                            <h2>Timesheet</h2>
                            <p>Timesheet</p>
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
