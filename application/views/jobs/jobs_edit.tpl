{include file="../common/head.tpl"}

<section>
    <div class="container">
        {if (isset($fN_sess) && $fN_sess!="")}
            <div class="alert alert-primary alert-dismissible fade show" role="alert">
                <strong>{$fN_sess}</strong>
            </div>
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
        {if isset($job.Name)}
            <h1 class="mb-1 pb-1"><a href="{$host_url}/index.php/jobs">Jobs</a> | {$job.Name}</h1>
        {/if}
        <div class="boxStyle p-4">
            <div class="row">
                <div class="col-12 col-md-3 leftMenu">
                    {include file="../common/projectleftmenu.tpl"}
                    <hr>
                </div>
                <div class="col-12 col-md-9 rightContent">
                    <div class="tab-content" id="v-pills-tabContent">
                        <div class="tab-pane fade show active" id="v-pills-home" role="tabpanel"
                            aria-labelledby="v-pills-home-tab">
                            <div class="border-bottom py-2 row">
                                <div class="col-sm-8">
                                    <h4>Basic Information</h4>
                                </div>
                                <div class="col-sm-4 ">

                                </div>
                            </div>


                            <form class="mt-2" method="POST"
                                action="{$host_url}/index.php/jobs/editJob/{if isset($job.Id)}{$job.Id}{else}new{/if}">
                                <input type="hidden" name="id" value="{if isset($job.Id)}{$job.Id}{else}new{/if}">
                                <div class="form-group row">
                                    <label for="" class="col-sm-3 col-form-label ">Status</label>
                                    <div class="col-sm-9">
                                        <select id="status" class="form-control" name="status">
                                            <option selected>Select...</option>
                                            <option value="new" {if isset($job.Status) && $job.Status=="new"}
                                                selected="selected" {/if}
                                                {if isset($contactDetail.Id) && $contactDetail.Id!=''}
                                                selected="selected" {/if} selected>New</option>
                                            <option value="inprogress"
                                                {if isset($job.Status) && $job.Status=="inprogress"} selected="selected"
                                                {/if}>Inprogress</option>
                                            <option value="completed"
                                                {if isset($job.Status) && $job.Status=="completed"} selected="selected"
                                                {/if}>Completed</option>
                                            <option value="cancelled"
                                                {if isset($project.Status) && $project.Status=="cancelled"} selected="selected" 
                                                {/if}>Cancelled</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="" class="col-sm-3 col-form-label ">Jobs Name</label>
                                    <div class="col-sm-9">
                                        <input type="text" class="form-control" id="project_name" name="project_name"
                                            value="{if isset($job.Name)}{$job.Name}{/if}" placeholder="Jobs name">
                                    </div>
                                </div>

                                <!--<div class="form-row">
                                    <div class="col-12">
                                        <div class="form-group row">
                                            <label for="" class="col-3 col-form-label ">Jobs Type</label>
                                            <div class="col-sm-3">
                                                <select name='project_type' class="form-control" id="project_type">
                                                    <option value="Non-Contract"
                                                        {if isset($job.JobType) && $job.JobType == 'Non-Contract'}selected{/if}>
                                                        Non-Contract</option>
                                                    <option value="Contract"
                                                        {if isset($job.JobType) && $job.JobType == 'Contract'}selected{/if}>
                                                        Contract</option>

                                                </select>
                                            </div>
                                            <label for="contract_hours"
                                                class="contract_hours col-sm-3 col-form-label "
                                                {if isset($job.JobType) && $job.JobType == 'Non-Contract'}style="display:none;"
                                                {else if isset($job.JobType) && $job.JobType == 'Contract'} style=""
                                                {else} style="display:none;" 
                                                {/if}>Time In
                                                Hours:</label>
                                            <div class="col-sm-3">
                                                <input type="number" class="form-control contract_hours"
                                                    {if isset($job.JobType) && $job.JobType == 'Non-Contract'}style="display:none;"
                                                    {else if isset($job.JobType) && $job.JobType== 'Contract'} style=""
                                                    {else} style="display:none;" 
                                                    {/if} id="contract_hours"
                                                    name="contract_hours" placeholder="48"
                                                    value="{if isset($job.ContractHours)}{$job.ContractHours}{/if}">
                                            </div>

                                        </div>
                                    </div>
                                </div>-->

                                <div class="form-row">
                                    <div class="col-12">
                                        <div class="form-group row">
                                            <label for="" class="col-12 col-md-3 col-form-label ">Jobs Type</label>
                                            <div class="col-sm-3">
                                                <select name='project_type' class="form-control" id="project_type"
                                                    onchange="showHideContract(this.value);">
                                                    <option value="Non-Contract"
                                                        {if isset($job.JobType) && $job.JobType == 'Non-Contract'}selected{/if}>
                                                        Non-Contract</option>
                                                    <option value="Contract"
                                                        {if isset($job.JobType) && $job.JobType == 'Contract'}selected{/if}>
                                                        Contract</option>

                                                </select>
                                            </div>
                                                <label for="agreed_frequency" class="agreed_frequency col-sm-3 col-form-label "
                                                    style={if !isset($job.JobType) || (isset($job.JobType) && $job.JobType == 'Non-Contract')}'display: none;' {else} '' {/if}>Agreed Hours</label>
                                                <div class="col-sm-3" id="agreed_frequency"
                                                    style={if !isset($job.JobType) || (isset($job.JobType) && $job.JobType == 'Non-Contract')}'display: none;' {else} '' {/if}>
                                                    <select class="form-control" name="agreed_frequency" onchange="showHideHour(this.value);">
                                                        <option value="" {if !isset($job.AgreedFrequency) || (isset($job.AgreedFrequency) && $job.AgreedFrequency == '')}selected{/if}>not applicable</option>
                                                        <option value="weekly" {if isset($job.AgreedFrequency) && $job.AgreedFrequency == 'weekly'}selected{/if}>weekly</option>
                                                        <option value="fortnightly" {if isset($job.AgreedFrequency) && $job.AgreedFrequency == 'fortnightly'}selected{/if}>fortnightly</option>
                                                        <option value="monthly" {if isset($job.AgreedFrequency) && $job.AgreedFrequency == 'monthly'}selected{/if}>monthly</option>
                                                    </select>
                                                </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="time_selection form-row" {if isset($job.JobType) && $job.JobType == 'Contract' && $job.AgreedFrequency != ''}style="" {else}style="display: none;"{/if}>
                                    <div class="col-12">
                                        <div class="form-group row">
                                            <label for="frequency_hours" class="frequency_hours col-sm-3 col-form-label ">Frequency Hours:</label>
                                            <div class="col-sm-3" id="contractHoursDiv">
                                                <input type="number" class="form-control frequency_hours" id="frequency_hours" name="frequency_hours" placeholder="48"
                                                    value="{if isset($job.FrequencyHours)}{$job.FrequencyHours}{/if}">
                                            </div>

                                            <label for="contract_hours" class="contract_hours col-sm-3 col-form-label " >Time In Hours:</label>
                                            <div class="col-sm-3" id="contractHoursDiv">
                                                <input type="number" class="form-control contract_hours" id="contract_hours" name="contract_hours" placeholder="48"
                                                    value="{if isset($job.ContractHours)}{$job.ContractHours}{/if}">
                                            </div>
                                        </div>
                                    </div>
                                </div>



                                <div class="form-row">
                                    <div class="col-12">
                                        <div class="form-group row">
                                            <label for="" class="col-12 col-md-3 col-form-label ">Is Recurring</label>
                                            <div class="col-sm-3">
                                                <select name='isRecurring' class="form-control" id="isRecurring"
                                                    onchange="javascript:showProjectBlock(this.value)">
                                                    <option value="Yes"
                                                        {if isset($job.IsRecurring) && $job.IsRecurring == 'Yes'}
                                                        selected="selected" {/if}>Yes</option>
                                                    <option value="No"
                                                        {if isset($job.IsRecurring) && $job.IsRecurring == 'No'}
                                                        selected="selected" {/if}>No</option>

                                                </select>
                                            </div>
                                            <div class="col-sm-3" id="hidView">
                                                {if isset($job.IsRecurring) && $job.IsRecurring == 'Yes'}<a
                                                        href="javascript:void(0);"
                                                        onclick="$('#jobModal').modal('show');">View Repeat Settings</a>
                                                {/if}</div>

                                        </div>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-sm-3 col-form-label ">Start Date</label>
                                    <div class="col-sm-9">
                                        <input type="date" name="startdate" {if isset($job.StartDate)}
                                            value="{$job.StartDate|date_format:"%Y-%m-%d"}" {/if}
                                            class="form-control" />
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-sm-3 col-form-label ">End Date</label>
                                    <div class="col-sm-9">
                                        <input type="date" name="enddate" {if isset($job.EndDate)}
                                            value="{$job.EndDate|date_format:"%Y-%m-%d"}" {/if} class="form-control" />
                                    </div>
                                </div>


                                <div class="form-group row">
                                    <label for="" class="col-sm-3 col-form-label ">Customer Name</label>
                                    <div class="col-sm-9">
                                        <select id="customer_id" class="form-control" name="customer_id">
                                            <option selected>Select...</option>
                                            {foreach $contact_list as $value}
                                                <option value="{$value.Id}"
                                                    {if isset($job.ContactId) && $job.ContactId==$value.Id}
                                                    selected="selected" {/if}
                                                    {if isset($contactDetail.Id) && $contactDetail.Id==$value.Id}
                                                    selected="selected" {/if}>
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
                                            <label for=""
                                                class="col-3 col-form-label ">Address{if isset($contactDetail["Address1"]) && $contactDetail["Address1"]!=''}<span
                                                        id="sameAsContact"><a href="javascript:void(0);"
                                                            onclick="javascript:setProjectAddress();">(Same As
                                                        Contact)</a>{/if}</label>
                                            <div class="col-sm-9">
                                                <input type="text" class="form-control" id="address" name="address"
                                                    value="{if isset($job.Address1)} {$job.Address1} {/if}"
                                                    placeholder="Line 1">
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-row">
                                    <div class="col-12">
                                        <div class="form-group row">
                                            <label for="" class="col-sm-3 col-form-label "></label>
                                            <div class="col-sm-5 pb-1 pb-md-0 ">
                                                <input type="text" class="form-control" id="suburb" name="suburb"
                                                    value="{if isset($job.Suburb)} {$job.Suburb} {/if}"
                                                    placeholder="Suburb">
                                            </div>
                                            <div class="col-sm-4">
                                                <input type="text" class="form-control" id="city" name="city"
                                                    value="{if isset($job.City)} {$job.City} {/if}" placeholder="City">
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="" class="col-sm-3 col-form-label ">Description</label>
                                    <div class="col-sm-9">
                                        <textarea type="textarea" class="form-control" name="description"
                                            placeholder="Description">{if isset($job.Description)}{$job.Description}{/if}</textarea>
                                    </div>
                                </div>



                                <div class="form-row">
                                    <div class="col-12">
                                        <div class="form-group row">
                                            <label for="" class="col-12 col-md-3 col-form-label ">Order No</label>
                                            <div class="col-sm-3">
                                                <input type="text" class="form-control" id="order_no" name="order_no"
                                                    {if isset($job.OrderId)} value="{$job.OrderId}" {/if}
                                                    placeholder="Order no">
                                            </div>
                                            <label for="" class="col-sm-3 col-form-label ">Code /Job
                                                no:</label>
                                            <div class="col-sm-3">
                                                <input type="text" class="form-control" id="job_no" name="job_no"
                                                    {if isset($job.JobCode)} value="{$job.JobCode}" {/if}
                                                    placeholder="Job no">
                                            </div>
                                        </div>
                                    </div>
                                </div>








                                <div class="form-group row">
                                    <label class="col-sm-3 col-form-label ">Notes</label>
                                    <div class="col-sm-9">
                                        <input type="text" class="form-control" placeholder="Notes if required"
                                            name="notes" {if isset($job.Notes)} value="{$job.Notes}" {/if}>
                                    </div>
                                </div>


                                <div class="form-group row">
                                    <label class="col-sm-3 col-form-label ">Billing Type</label>
                                    <div class="col-sm-9">
                                        <select name="selBilling" id="selBilling" class="form-control">
                                            <option value="Weekly"
                                                {if isset($job.BillingType) && $job.BillingType=="Weekly"}
                                                selected="selected" {/if}>Weekly</option>
                                            <option value="BiWeekly"
                                                {if isset($job.BillingType) && $job.BillingType=="BiWeekly"}
                                                selected="selected" {/if}>BiWeekly</option>
                                            <option value="Monthly"
                                                {if isset($job.BillingType) && $job.BillingType=="Monthly"}
                                                selected="selected" {/if}>Monthly</option>
                                        </select>
                                    </div>
                                </div>



                                <div class="form-group row">
                                    <label for="inputPassword" class="col-sm-3 col-form-label ">Job
                                        Status</label>
                                    <div class="col-sm-9">
                                        <div class="btn-group btn-group-toggle" data-toggle="buttons">
                                            <label class="btn btn-sm btn-tertiary ">
                                                <input type="radio" name="job_status" id="option_status" value="Open"
                                                    {if $job.JobStatus == "Open"} checked="checked" {/if}> Open
                                            </label>
                                            <label class="btn btn-sm btn-tertiary ">
                                                <input type="radio" name="job_status" id="option_status_no"
                                                    value="Close" {if $job.JobStatus == "Close"} checked="checked"
                                                    {/if}> Close
                                            </label>
                                        </div>
                                    </div>
                                </div>

                                <hr>

                                <div class="">
                                    <h5>Resources:</h5>
                                </div>

                                <div class="containerDiv">


                                    {$resourceHtml}

                                    <div>
                                        <button type="button" class="btn btn-outline-secondary addDiv">
                                        <i class="icofont-plus-circle"></i>Add Name</button>
                                    </div>

                                </div>


                                <hr>



                                <input type="hidden" value="" id="hidDates" name="hidDates">
                                <input type="hidden" value="" id="hidOccurenceType" name="hidOccurenceType">

                                <input type="hidden" value="" id="dailyInterval" name="dailyInterval">
                                <input type="hidden" value="" id="dailyStart" name="dailyStart">
                                <input type="hidden" value="" id="dailyDays" name="dailyDays">
                                <input type="hidden" value="" id="dailyEndType" name="dailyEndType">
                                <input type="hidden" value="" id="dailyAfter" name="dailyAfter">
                                <input type="hidden" value="" id="dailyEnd" name="dailyEnd">

                                <input type="hidden" value="" id="weeklyInterval" name="weeklyInterval">
                                <input type="hidden" value="" id="weeklyDays" name="weeklyDays">
                                <input type="hidden" value="" id="weeklyStart" name="weeklyStart">
                                <input type="hidden" value="" id="weeklyEndType" name="weeklyEndType">
                                <input type="hidden" value="" id="weeklyAfter" name="weeklyAfter">
                                <input type="hidden" value="" id="weeklyEnd" name="weeklyEnd">

                                <input type="hidden" value="" id="monthlyDay" name="monthlyDay">
                                <input type="hidden" value="" id="monthlyInterval" name="monthlyInterval">
                                <input type="hidden" value="" id="monthlyStartDate" name="monthlyStartDate">
                                <input type="hidden" value="" id="monthlyEndType" name="monthlyEndType">
                                <input type="hidden" value="" id="monthlyAfter" name="monthlyAfter">
                                <input type="hidden" value="" id="monthlyEnd" name="monthlyEnd">

                                <div class="form-group row">
                                    <label for="" class="col-sm-3 col-form-label "></label>
                                    <div class="col-sm-9">
                                        <button type="submit" name="button" value="submit_general" id="save_edit_job"
                                            class="btn btn-lg btn-primary">Save</button>
                                        <button action="action" onclick="window.history.go(-1); return false;"
                                            class="btn btn-lg btn-secondary">Cancel</button>
                                    </div>
                                </div>
                            </form>


                        </div>

                        <div class="tab-pane" id="v-pills-jobs" role="tabpanel" aria-labelledby="v-pills-jobs-tab">
                            <div class="border-bottom py-2 row">
                                <div class="col-sm-8">
                                    <h4>Jobs</h4>
                                </div>
                                <div class="col-sm-4 ">
                                    <a class="btn btn-sm btn-primary"
                                        href="{$host_url}/index.php/job/add/{if isset($job.Id)}{$job.Id}{/if}"><i
                                            class="icofont-plus-circle"></i>&nbsp; Add Job</a>
                                </div>


                            </div>
                            <h6 class="mt-2">Project: {if isset($job.Name)}
                                {$job.Name}{$job.Address1}{$job.Suburb}{$job.City}-{/if}</h6>
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
                                                <td><a href="{$host_url}/index.php/project-id/{$value.ProjectId}/view-job-detail/{$value.Id}"
                                                        class="btn btn-sm" data-toggle="tooltip" data-placement="bottom"
                                                        title="" data-original-title="View"><i
                                                            class="active icofont-eye-alt"></i></a>
                                                    <a href="#" class="btn btn-sm" data-toggle="modal" data-placement="bottom"
                                                        title="Edit" data-id="{$value.Id}" data-target="#jobModal"><i
                                                            class="active icofont-ui-edit"></i></a>
                                                    <a href="#" class="delete_job btn btn-sm" data-id="{$value.Id}"><i
                                                            class="active icofont-ui-delete"></i></a>
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

<script>
    $(document).ready(function() {
        // Add new element
        // Add new element
        var is_recurring = $('#isRecurring').val();
        if (is_recurring == 'Yes'){
            dates();
        }
        
        $(".addDiv").click(function() {

            // Finding total number of elements added
            var total_element = $(".element").length;

            // last <div> with element class id
            var lastid = $(".element:last").attr("id");
            var split_id = lastid.split("_");
            var curr_id = Number(split_id[1]);
            var nextindex = Number(split_id[1]) + 1;
            var max = 500000000;
            // Check total number elements
            if (total_element < max) {
                // Adding new div container after last occurance of element class
                $(".element:last").after("<div class='element' id='div_" + nextindex + "'></div>");

                var responseoptions = '';

                responseoptions = $("#selResouces_" + curr_id).html();


                // Adding element to <div>
                $("#div_" + nextindex).append(
                    '<div class="form-group row"><div class="col-sm-4"><select class="form-control selResource" id="selResouces_' + nextindex + '" name="selResouces_' +
                    nextindex + '">' + responseoptions +
                    '  </select></div><div class="col-sm-4"><div class="btn-group btn-group-toggle" data-toggle="buttons"><label class="btn btn-sm btn-tertiary active">' +
                    '<input type="radio" name="options_' + nextindex + '" id="option_row' + nextindex + 'a" checked="" value="Employee"> Employee </label> <label class="btn btn-sm btn-tertiary">' +
                    '<input type="radio" name="options_' + nextindex + '" id="option_row' + nextindex + 'b" value="Supervisor"> Supervisor</label></div>' +
                    '</div><div class="col-sm-4"><a href="javascript:void(0);" class="remove btn btn-sm" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Delete" id="remove_' +
                    nextindex +
                    '" ><i class="active icofont-ui-delete"></i> Delete</a><input type="hidden" value="' +
                    nextindex + '" id="hidResourceCount" name="hidResourceCount[]"></div></div>');
            }

        });

        $('#customer_id').on('change', function() {
                var contact_id = $(this).val();
                var url = "{$host_url}/index.php/contact/contact/getContact?id=" + contact_id;
                console.log(url);
                $.ajax({
                            type: "POST",
                            url: url,
                            success: function(result) {
                                var json = JSON.parse(result);
                                $("#address").val(json.Address1);
                                $("#suburb").val(json.Suburb);
                                $("#city").val(json.City);
                            },
                            error: function() {
                                console.log('error');
                            }
                        });
            });


        // Remove element
        $('.containerDiv').on('click', '.remove', function() {

            var id = this.id;
            var split_id = id.split("_");
            var deleteindex = split_id[1];

            // Remove <div> with id
            $("#div_" + deleteindex).remove();

        });

        $('#save_edit_job').on('click', function(e){
            if (!confirm('Please note that all open job dispatches will be recreated. Are you sure you want to save the changes?')) {
                e.preventDefault();
            }
        });
    });
    {if isset($contactDetail["Address1"]) && $contactDetail["Address1"]!=''}
        function setProjectAddress() {
            $("#address").val('{$contactDetail["Address1"]}');
            $("#suburb").val('{$contactDetail["Suburb"]}');
            $("#city").val('{$contactDetail["City"]}');
            $("#sameAsContact").html('<a href="javascript:void(0);" onclick="javascript:setAddressFunction();">(Clear)</a>')

        }

        function setAddressFunction() {
            $("#address").val('');
            $("#suburb").val('');
            $("#city").val('');
            $("#sameAsContact").html(
                '<a href="javascript:void(0);" onclick="javascript:setProjectAddress();">(Same As Contact)</a>');

        }
    {/if}
    
</script>


<!-- Modal -->
<div class="modal fade" id="jobModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Repeat</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">

                <div class="form-group row">
                    <label for="inputPassword" class="pt-0 col-sm-3 col-form-label ">
                        <h5 class="pt-2">Repeat</h5>
                    </label>
                    <div class="col-sm-9">
                        <!-- <input type="radio" class="btn-check" name="options" id="option1" data-toggle="tab" role="tab" aria-controls="home" aria-selected="true" checked>
                                <label class="mr-2" for="option1">No Repeat</label>

                                <input type="radio" class="btn-check" name="options" id="option2">
                                <label class="mr-2" for="option2">Daily</label>

                                <input type="radio" class="btn-check" name="options" id="option3">
                                <label class="mr-2" for="option3">Weekly</label>

                                <input type="radio" class="btn-check" name="options" id="option4">
                                <label class="mr-2" for="option4">Monthly</label> -->

                        <ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
                            <li class="nav-item" role="presentation">
                                <a class="nav-link" id="pills-no-repeat-tab" data-toggle="pill" href="#pills-no-repeat"
                                    role="tab" aria-controls="pills-no-repeat" aria-selected="true"
                                    onclick="javascript:setHiddenTab('norepeat');">No Repeat</a>
                            </li>
                            <li class="nav-item" role="presentation">
                                <a class="nav-link {if isset($configurations->occurence) && $configurations->occurence=="daily"}active{/if}"
                                    id="pills-daily-tab" data-toggle="pill" href="#pills-daily" role="tab"
                                    aria-controls="pills-daily" aria-selected="false"
                                    onclick="javascript:setHiddenTab('daily');">Daily</a>
                            </li>
                            <li class="nav-item" role="presentation">
                                <a class="nav-link {if isset($configurations->occurence) && $configurations->occurence=="weekly"}active{/if}"
                                    id="pills-weekly-tab" data-toggle="pill" href="#pills-weekly" role="tab"
                                    aria-controls="pills-weekly" aria-selected="false"
                                    onclick="javascript:setHiddenTab('weekly');">Weekly</a>
                            </li>
                            <li class="nav-item" role="presentation">
                                <a class="nav-link {if isset($configurations->occurence) && $configurations->occurence=="monthly"}active{/if}"
                                    id="pills-monthly-tab" data-toggle="pill" href="#pills-monthly" role="tab"
                                    aria-controls="pills-monthly" aria-selected="false"
                                    onclick="javascript:setHiddenTab('monthly');">Monthly</a>
                            </li>
                        </ul>
                        <div class="tab-content" id="pills-tabContent">
                            <div class="tab-pane fade" id="pills-no-repeat" role="tabpanel"
                                aria-labelledby="pills-no-repeat-tab">



                                <hr>
                                No repeat
                                <hr>
                            </div>

                            <div class="tab-pane fade  {if isset($configurations->occurence) && $configurations->occurence=="daily"}active show{/if}"
                                id="pills-daily" role="tabpanel" aria-labelledby="pills-daily-tab">
                                <div class="form-group row">
                                    <div class="col-sm-9">

                                        <div class="form-inline mb-2">
                                            <input type="radio" class="btn-check" name="everydays" value="everyInterval"
                                                id="option2"
                                                {if isset($configurations->interval) && $configurations->interval=="everyInterval"}checked='checked'
                                                {/if} onclick="javascript:dates()">
                                            <label class="mr-2" for="option2">&nbsp;Every</label>
                                            <input class="form-control" type="number" id="startDaysNumber"
                                                name="startDaysNumber"
                                                value="{if isset($configurations->dailyDays) && $configurations->dailyDays!=""}{$configurations->dailyDays}{/if}"
                                                onchange="javascript:dates()">
                                            <label class="ml-2">day(s)</label>
                                        </div>

                                        <div class="form-inline mb-1">
                                            <input type="radio" class="btn-check" name="everydays" value="everyWeekday"
                                                id="option3" onclick="javascript:dates()"
                                                {if isset($configurations->interval) && $configurations->interval=="everyWeekday"}checked='checked'
                                                {/if}>
                                            <label class="mr-2" for="option3">&nbsp;Every weekday</label>
                                        </div>
                                    </div>
                                </div>



                                <hr>
                                <div class="form-group row">
                                    <label for="inputPassword" class="pt-0 col-sm-3 col-form-label ">
                                        <h5 class="pt-2">Starts on</h5>
                                    </label>
                                    <div class="col-sm-9">
                                        <input type="date" name="dailyStartDate" id="dailyStartDate"
                                            class="form-control sm-3"
                                            value="{if isset($configurations->start) && $configurations->start!=""}{$configurations->start}{/if}"
                                            class="form-control" onchange="javascript:dates()""  >
                                            </div>
                                        </div>

                                        <hr>
                                        <div class=" form-group row">
                                        <label for="inputPassword" class="pt-0 col-sm-3 col-form-label ">
                                            <h5 class="">Ends</h5>
                                        </label>
                                        <div class="col-sm-9">
                                            <input type="radio" class="btn-check" name="dailyEnds" id="dailyEnds1"
                                                {if isset($configurations->endType) && $configurations->endType=="never"}checked='checked'
                                                {/if} value="never" onclick="javascript:dates()"">
                                            <label class=" mr-2" for="dailyEnds1">Never</label>
                                            <br>

                                            <div class="form-inline mb-1">
                                                <input type="radio" class="btn-check" name="dailyEnds" id="dailyEnds2"
                                                    value="after" onclick="javascript:dates()"
                                                    {if isset($configurations->endType) && $configurations->endType=="after"}checked='checked'
                                                    {/if}>
                                                <label class="mr-2" for="dailyEnds2">&nbsp;After</label>
                                                <input class="form-control" type="number" name="dailyEndAfter"
                                                    id="dailyEndAfter"
                                                    value="{if isset($configurations->after) && $configurations->after!=""}{$configurations->after}{/if}"
                                                    onchange="javascript:dates()">
                                                <label class="ml-2">Occurance</label>
                                            </div>

                                            <div class="form-inline mb-1">
                                                <input type="radio" class="btn-check" name="dailyEnds" id="dailyEnds3"
                                                    value="on" onclick="javascript:dates()"
                                                    {if isset($configurations->endType) && $configurations->endType=="on"}checked='checked'
                                                    {/if}>
                                                <label class="mr-2" for="dailyEnds3">&nbsp;On</label>
                                                <input type="date" id="dailyEndDate" name="dailyEndDate"
                                                    value="{if isset($configurations->end) && $configurations->end!=""}{$configurations->end}{/if}"
                                                    onchange="javascript:dates()"" class=" form-control sm-3">
                                            </div>
                                        </div>
                                    </div>

                                    <hr>
                                    <div class="form-group row">
                                        <label for="inputPassword" class="pt-0 col-sm-3 col-form-label ">
                                            <h5>Summary</h5>
                                        </label>
                                        <div class="col-sm-9" id="dailySummary">
                                        </div>
                                    </div>


                                </div>
                                <div class="tab-pane fade  {if isset($configurations->occurence) && $configurations->occurence=="weekly"}active show{/if}"
                                    id="pills-weekly" role="tabpanel" aria-labelledby="pills-weekly-tab">
                                    <div class="form-inline">
                                        <div class="form-group">
                                            <label for="inputDays">Every</label>
                                            <input type="number" id="inputDays" class="form-control mx-sm-3"
                                                aria-describedby="inputDays" name="inputDays" value="1">
                                            <label for="inputDays">Weeks</label>
                                        </div>
                                    </div>
                                    <div class="form-inline pt-3">
                                        <div class="custom-control custom-checkbox mr-4">
                                            <input type="checkbox" class="custom-control-input" id="customCheck1"
                                                value="Monday" name="chkDays[]" onclick="dates();"
                                                {if "Monday"|in_array:$selectedDays}checked="checked" {/if}>
                                            <label class="custom-control-label pt-1" for="customCheck1">M</label>
                                        </div>
                                        <div class="custom-control custom-checkbox mr-4">
                                            <input type="checkbox" class="custom-control-input" id="customCheck2"
                                                value="Tuesday" name="chkDays[]" onclick="dates();"
                                                {if "Tuesday"|in_array:$selectedDays}checked="checked" {/if}>
                                            <label class="custom-control-label pt-1" for="customCheck2">T</label>
                                        </div>
                                        <div class="custom-control custom-checkbox mr-4">
                                            <input type="checkbox" class="custom-control-input" id="customCheck3"
                                                value="Wednesday" name="chkDays[]" onclick="dates();"
                                                {if "Wednesday"|in_array:$selectedDays}checked="checked" {/if}>
                                            <label class="custom-control-label pt-1" for="customCheck3">W</label>
                                        </div>
                                        <div class="custom-control custom-checkbox mr-4">
                                            <input type="checkbox" class="custom-control-input" id="customCheck4"
                                                value="Thursday" name="chkDays[]" onclick="dates();"
                                                {if "Thursday"|in_array:$selectedDays}checked="checked" {/if}>
                                            <label class="custom-control-label pt-1" for="customCheck4">T</label>
                                        </div>
                                        <div class="custom-control custom-checkbox mr-4">
                                            <input type="checkbox" class="custom-control-input" id="customCheck5"
                                                value="Friday" name="chkDays[]" onclick="dates();"
                                                {if "Friday"|in_array:$selectedDays}checked="checked" {/if}>
                                            <label class="custom-control-label pt-1" for="customCheck5">F</label>
                                        </div>
                                        <div class="custom-control custom-checkbox mr-4">
                                            <input type="checkbox" class="custom-control-input" id="customCheck6"
                                                value="Saturday" name="chkDays[]" onclick="dates();"
                                                {if "Saturday"|in_array:$selectedDays}checked="checked" {/if}>
                                            <label class="custom-control-label pt-1" for="customCheck6">S</label>
                                        </div>
                                        <div class="custom-control custom-checkbox mr-4">
                                            <input type="checkbox" class="custom-control-input" id="customCheck7"
                                                value="Sunday" name="chkDays[]" onclick="dates();"
                                                {if "Sunday"|in_array:$selectedDays}checked="checked" {/if}>
                                            <label class="custom-control-label pt-1" for="customCheck7">S</label>
                                        </div>
                                    </div>



                                    <hr>
                                    <div class="form-group row">
                                        <label for="inputPassword" class="pt-0 col-sm-3 col-form-label ">
                                            <h5 class="pt-2">Starts on</h5>
                                        </label>
                                        <div class="col-sm-9">
                                            <input type="date" id="weeklyStartDate" name="weeklyStartDate"
                                                class="form-control sm-3"
                                                value="{if isset($configurations->start)}{$configurations->start}{/if}"
                                                class="form-control" onblur="dates();">
                                        </div>
                                    </div>

                                    <hr>
                                    <div class="form-group row">
                                        <label for="inputPassword" class="pt-0 col-sm-3 col-form-label ">
                                            <h5 class="">Ends</h5>
                                        </label>
                                        <div class="col-sm-9">
                                            <input type="radio" class="btn-check" name="weekly" id="optionWeekly1"
                                                {if isset($configurations->endType) && $configurations->endType=="never"}checked="checked"
                                                {/if} value="never" onclick="dates();">
                                            <label class="mr-2" for="optionWeekly1">Never</label>
                                            <br>

                                            <div class="form-inline mb-1">
                                                <input type="radio" class="btn-check" name="weekly" id="optionWeekly2"
                                                    value="after" onclick="dates();"
                                                    {if isset($configurations->endType) && $configurations->endType=="after"}checked="checked"
                                                    {/if}>
                                                <label class="mr-2" for="optionWeekly2">&nbsp;After</label>
                                                <input class="form-control" type="number" {if isset($configurations->after)}
                                                value="{$configurations->after}" {/if} onchange="dates();"
                                                    name="weeklyAfter" id="weeklyEndAfter">
                                                <label class="ml-2">Occurance</label>
                                            </div>

                                            <div class="form-inline mb-1">
                                                <input type="radio" class="btn-check" name="weekly" id="optionWeekly3"
                                                    value="on" onclick="dates();"
                                                    {if isset($configurations->endType) && $configurations->endType=="on"}checked="checked"
                                                    {/if}>
                                                <label class="mr-2" for="optionWeekly3">&nbsp;On</label>
                                                <input type="date" {if isset($configurations->end)}
                                                    value="{$configurations->end}" {/if} id="weeklyEndDate"
                                                    name="weeklyEndDate" class="form-control sm-3" onblur="dates();">
                                            </div>
                                        </div>
                                    </div>

                                    <hr>
                                    <div class="form-group row">
                                        <label for="inputPassword" class="pt-0 col-sm-3 col-form-label ">
                                            <h5>Summary</h5>
                                        </label>
                                        <div class="col-sm-9" id="weeklySummary">
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane fade  {if isset($configurations->occurence) && $configurations->occurence=="monthly"}active show{/if}"
                                    id="pills-monthly" role="tabpanel" aria-labelledby="pills-monthly-tab">

                                    <div class="form-inline">
                                        <div class="form-group">
                                            <label for="onDay">On Day</label>
                                            <input type="number" id="monthlyOnDay" class="form-control mx-sm-3"
                                                style="width:80px;" aria-describedby="onDay"
                                                onchange="javascript:dates();" {if isset($configurations->monthlyDay)}
                                                value="{$configurations->monthlyDay}" {/if}>
                                            <label for="ofevery">of every</label>
                                            <input type="number" id="monthlyMonth" class="form-control mx-sm-3"
                                                style="width:80px;" aria-describedby="ofevery"
                                                onchange="javascript:dates();"
                                                {if isset($configurations->monthlyInterval)}
                                                value="{$configurations->monthlyInterval}" {/if}>
                                            <label for="inputMonth">months(s)</label>
                                        </div>
                                    </div>



                                    <hr>
                                    <div class="form-group row">
                                        <label for="inputPassword" class="pt-0 col-sm-3 col-form-label ">
                                            <h5 class="pt-2">Starts on</h5>
                                        </label>
                                        <div class="col-sm-9">
                                            <input type="date" id="monthlyStart" name="monthlyStart"
                                                class="form-control sm-3" {if isset($configurations->startDate)}
                                                value="{$configurations->startDate}" {/if} class="form-control"
                                                onchange="javascript:dates();">
                                        </div>
                                    </div>

                                    <hr>
                                    <div class="form-group row">
                                        <label for="inputPassword" class="pt-0 col-sm-3 col-form-label ">
                                            <h5 class="">Ends</h5>
                                        </label>
                                        <div class="col-sm-9">
                                            <input type="radio" class="btn-check" name="monthlyWeekly"
                                                id="optionWeekly1"
                                                {if isset($configurations->endType) && $configurations->endType=="never"}checked="checked"
                                                {/if} value="monthlyNever" onclick="javascript:dates();">
                                            <label class="mr-2" for="optionWeekly1">Never</label>
                                            <br>

                                            <div class="form-inline mb-1">
                                                <input type="radio" class="btn-check" name="monthlyWeekly"
                                                    id="optionWeekly2" onclick="javascript:dates();" value="after"
                                                    {if isset($configurations->endType) && $configurations->endType=="after"}checked="checked"
                                                    {/if}>
                                                <label class="mr-2" for="optionWeekly2">&nbsp;After</label>
                                                <input class="form-control" type="number" value="1"
                                                    name="monthlyAfterDay" id="monthlyAfterDay"
                                                    onchange="javascript:dates();">
                                                <label class="ml-2">Occurance</label>
                                            </div>

                                            <div class="form-inline mb-1">
                                                <input type="radio" class="btn-check" name="monthlyWeekly"
                                                    id="optionWeekly3" value="on" onclick="javascript:dates();"
                                                    {if isset($configurations->endType) && $configurations->endType=="on"}checked="checked"
                                                    {/if}>
                                                <label class="mr-2" for="optionWeekly3">&nbsp;On</label>
                                                <input type="date" id="monthlyOn" {if isset($today_date)}
                                                    value="{$today_date}" {/if} class="form-control sm-3"
                                                    onchange="javascript:dates();">
                                            </div>
                                        </div>
                                    </div>

                                    <hr>
                                    <div class="form-group row">
                                        <label for="inputPassword" class="pt-0 col-sm-3 col-form-label ">
                                            <h5>Summary</h5>
                                        </label>
                                        <div class="col-sm-9" id="monthlySummary">
                                        </div>
                                    </div>


                                </div>
                            </div>
                        </div>
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" onclick="javascript:validateReoccuringForm();">Save
                        changes</button>
                    <input type="hidden"
                        value="{if isset($configurations->occurence) && $configurations->occurence!=""}{$configurations->occurence}{/if}"
                        id="hidTab" name="hidTab">
                    <!--<button type="button" class="btn btn-primary" onclick="javascript:dates()">Get Dates</button> -->

                </div>
            </div>
        </div>
    </div>

    <!-- Modal -->
    <script>


        function validateReoccuringForm() {
            var selectedDaysInterval = $("#hidTab").val();
            var msg = '';
            console.log(selectedDaysInterval, "selectedDaysInterval");
            if (selectedDaysInterval == "daily") {
                var selectedDays = $("#inputDays").val();

                var selectedDays = $("input[type='radio'][name='everydays']:checked");
                if (selectedDays.length > 0) {
                    selectedDaysVal = selectedDays.val();
                }
                console.log(selectedDaysInterval);

                if (selectedDaysVal == "everyInterval") {
                    var startDaysNumber = $("#startDaysNumber").val();
                    if (startDaysNumber <= 0) {
                        msg = "Please enter number of Days greater than 0";
                    }
                }
                if ($("#dailyStartDate").val() == "")
                    msg = msg + "\nPlease enter Start Date";

                var selectedEndDays = $("input[type='radio'][name='dailyEnds']:checked");
                if (selectedEndDays.length > 0) {
                    selectedEndDaysVal = selectedEndDays.val();
                }
                console.log(selectedEndDaysVal);
                if (selectedEndDaysVal == "after") {
                    var dailyEndAfter = $("#dailyEndAfter").val();
                    if (dailyEndAfter <= 0 || dailyEndAfter == '') {
                        msg = "Please enter number of occurence";
                    }
                }


                if (msg != '') {
                    alert(msg);
                }

            } else if (selectedDaysInterval == "weekly") {

                if ($("#inputDays").val() == "" || $("#inputDays").val() < 0)
                    msg = msg + "\nPlease enter days";
                var selectedDays = $("input[type='checkbox'][name='chkDays[]']:checked");
                if (selectedDays.length <= 0) {
                    msg = msg + "\nPlease select days";
                }

                if (msg != '') {
                    alert(msg);
                }

            } else if (selectedDaysInterval == "monthly") {
                if ($("#monthlyMonth").val() == "" || $("#monthlyMonth").val() <= 0)
                    msg = msg + "\nPlease enter month";
                if ($("#monthlyOnDay").val() == "" || $("#monthlyOnDay").val() <= 0)
                    msg = msg + "\nPlease enter days";
                if (msg != '') {
                    alert(msg);
                }
            }
            if (msg == '') {
                dates();
                window.setTimeout(() => {
                    console.log('2');
                }, 1000);
                $("#hidView").html(
                    '<a href="javascript:void(0);" onclick="$(\'#jobModal\').modal(\'show\');">View Repeat Settings</a>'
                    );
                $('#jobModal').modal('hide');
            }
        }

        function setHiddenTab(selectedTab) {
            {
                $("#hidTab").val(selectedTab);
            }
        }

        function showProjectBlock(selected = "") {
            if (selected == "Yes") {
                $('#jobModal').modal('show');
                // $("#endDateBlock").hide();
                // $("#startDateBlock").hide();
            } else {

                // $("#endDateBlock").show();
                //$("#startDateBlock").show();
            }

        }

        function showHideContract(val) {
            //alert(val);
            if (val == "Contract") {
                $("#agreed_frequency").show();
                $(".agreed_frequency").show();
                if ($('[name = "agreed_frequency"]').val() != '') {
                    $(".time_selection").show();
                }

            } else {
                $("#agreed_frequency").hide();
                $(".agreed_frequency").hide();
                $(".time_selection").hide();
            }
        }

        function showHideHour(val) {
            console.log(val);
            console.log($('#project_type').val());
            if (val == "") {
                $(".time_selection").hide();
            } else {
                if ($('#project_type').val() == 'Contract') {
                    $(".time_selection").show();
                }
            }
        }


        function dates() {
            console.log("dates");
            var selectedTab = $("#hidTab").val();

            var summary = "";
            if (selectedTab == "daily") {
                $("#hidOccurenceType").val("daily");

                $("#dailyDays").val($("#startDaysNumber").val());

                var selectedDaysVal = selectedEndDayVal = "";
                var selectedDays = $("input[type='radio'][name='everydays']:checked");
                if (selectedDays.length > 0) {
                    selectedDaysVal = selectedDays.val();
                }
                var selectedEndDay = $("input[type='radio'][name='dailyEnds']:checked");

                if (selectedEndDay.length > 0) {
                    selectedEndDayVal = selectedEndDay.val();
                }
                //alert(selectedEndDayVal);
                var list = [];
                if (selectedDaysVal == "everyInterval") {
                    $("#dailyInterval").val("everyInterval");
                    $("#dailyStart").val($("#dailyStartDate").val());

                    var start = moment($("#dailyStartDate").val());
                    summary += "Starting Date " + $("#dailyStartDate").val();
                    if (selectedEndDayVal == "on") {

                        $("#dailyEndType").val("on");
                        $("#dailyEnd").val($("#dailyEndDate").val());
                        var end = moment($("#dailyEndDate").val());

                        summary += "<br> Ends On- " + end + " day";
                        var interv = $("#startDaysNumber").val();
                        var list = [];

                        for (var current = start; current < end; current.add(interv, 'd')) {
                            console.log(current, end);
                            list.push(current.format("YYYY-MM-DD"))
                        }
                    } else if (selectedEndDayVal == "never") {
                        $("#dailyEndType").val("never");
                        summary += "<br> Ends On- Never End";
                        var end = moment(start).add(3, 'M'); //moment($("#dailyEndDate").val());
                        var interv = $("#startDaysNumber").val();
                        var list = [];
                        for (var current = start; current < end; current.add(interv, 'd')) {
                            // console.log(current , end);
                            list.push(current.format("YYYY-MM-DD"))
                        }
                    } else {
                        $("#dailyEndType").val("after");
                        $("#dailyAfter").val($("#dailyEndAfter").val());
                        var list = [];
                        var end = $("#dailyEndAfter").val();
                        summary += "<br> After- " + end + " Occurrence";
                        var interv = $("#startDaysNumber").val();
                        for (var i = 0; i < end; i++) {

                            list.push(start.format("YYYY-MM-DD"));
                            start = moment(start).add(interv, 'd'); //moment(start).add(interv, 'days');
                            //console.log(start);
                        }
                    }
                } else {


                    $("#dailyInterval").val("everyWeekday");

                    $("#dailyStart").val($("#dailyStartDate").val());
                    var start = moment($("#dailyStartDate").val());

                    summary += "Starting Date " + $("#dailyStartDate").val();

                    summary += "<br>Every WeekDay";
                    // alert(selectedEndDayVal);
                    if (selectedEndDayVal == "on") {
                        $("#dailyEndType").val("on");
                        $("#dailyEnd").val($("#dailyEndDate").val());

                        var end = moment($("#dailyEndDate").val());

                        summary += " Ends On- " + $("#dailyEndDate").val();
                        var weekdayCounter = 0;

                        while (start <= end) {
                            if (start.format('ddd') !== 'Sat' && start.format('ddd') !== 'Sun') {
                                list.push(start.format("YYYY-MM-DD"))
                                weekdayCounter++; //add 1 to your counter if its not a weekend day
                            }
                            start = moment(start, 'YYYY-MM-DD').add(1, 'days'); //increment by one day
                        }
                    } else if (selectedEndDayVal == "never") {
                        $("#dailyEndType").val("never");
                        summary += "<br> Ends On- Never End";
                        var end = moment(start).add(3, 'M'); //moment($("#dailyEndDate").val());
                        var interv = $("#startDaysNumber").val();
                        var list = [];
                        while (start <= end) {
                            if (start.format('ddd') !== 'Sat' && start.format('ddd') !== 'Sun') {
                                list.push(start.format("YYYY-MM-DD"))
                                weekdayCounter++; //add 1 to your counter if its not a weekend day
                            }
                            start = moment(start, 'YYYY-MM-DD').add(1, 'days'); //increment by one day
                        }
                    } else {
                        $("#dailyEndType").val("after");
                        var list = [];
                        var end = $("#dailyEndAfter").val();

                        $("#dailyAfter").val($("#dailyEndAfter").val());
                        summary += "<br> Ends On- " + end + "Occurence";
                        for (var i = 0; i < end; i++) {


                            if (start.format('ddd') !== 'Sat' && start.format('ddd') !== 'Sun') {
                                list.push(start.format("YYYY-MM-DD"))
                                weekdayCounter++; //add 1 to your counter if its not a weekend day

                            } else {
                                i = i - 1;
                            }
                            start = moment(start, 'YYYY-MM-DD').add(1, 'days');
                        }
                    }
                }
                summary += "<br> The Dates are-<br>" + list
                $("#dailySummary").html(summary);

                $("#hidDates").val(list);
                console.log(list);
            } else if (selectedTab == "weekly") {

                $("#hidOccurenceType").val("weekly");
                var list = [];
                var selectedDaysVal = selectedEndDayVal = "";
                var weekCount = $("#inputDays").val();
                days = $('input[type="checkbox"][name="chkDays\\[\\]"]:checked').map(function() { return this.value; })
                    .get();

                $("#weeklyDays").val(days);
                var start = moment($("#weeklyStartDate").val());

                $("#weeklyStart").val($("#weeklyStartDate").val());
                summary += "Starting Date " + $("#weeklyStartDate").val();
                var selectedEndDay = $("input[type='radio'][name='weekly']:checked");
                if (selectedEndDay.length > 0) {
                    selectedEndDayVal = selectedEndDay.val();
                }

                var end = moment(start).add(3, 'M');
                var i = 1;
                for (startweek = 1; startweek <= weekCount; startweek++) {
                    if (selectedEndDayVal == "never") {

                        $("#weeklyEndType").val("never");

                        if (startweek == 1) {
                            summary += "<br>Ends on- Never Ends";
                        }
                        var endDate = moment(start).add(3, 'M').format("YYYY-MM-DD");
                        while (start <= end) {
                            if (weekCount > 1 && i % (7 * weekCount) == 0)
                                start = moment(start, 'YYYY-MM-DD').add(7 * weekCount, 'Days');
                            i++;
                            if (jQuery.inArray(start.format('dddd'), days) >= 0) {
                                list.push(start.format("YYYY-MM-DD"));
                            }
                            start = moment(start, 'YYYY-MM-DD').add(1, 'days');
                        }
                    } else if (selectedEndDayVal == "on") {
                        $("#weeklyEndType").val("on");

                        var end = moment($("#weeklyEndDate").val());
                        if (startweek == 1) {
                            summary += "<br>Ends on- " + $("#weeklyEndDate").val();
                        }
                        $("#weeklyEnd").val($("#weeklyEndDate").val());
                        console.log(start, end, weekCount);
                        while (start <= end) {
                            if (weekCount > 1 && i % (7 * weekCount) == 0)
                                start = moment(start, 'YYYY-MM-DD').add(7 * weekCount, 'Days');
                            i++;
                            if (jQuery.inArray(start.format('dddd'), days) >= 0) {
                                list.push(start.format("YYYY-MM-DD"));
                            }
                            start = moment(start, 'YYYY-MM-DD').add(1, 'days');
                        }

                    } else if (selectedEndDayVal == "after") {
                        $("#weeklyEndType").val("after");

                        $("#weeklyAfter").val($("#weeklyEndAfter").val());
                        if (days.length > 0) {
                            var list = [];
                            var end = $("#weeklyEndAfter").val();
                            if (startweek == 1) {
                                summary += "<br>Ends on- After" + $("#weeklyAfter").val() + " Occurrence";
                            }
                            console.log(list, "list");
                            console.log(end, "end");
                            for (var i = 0; i < end; i++) {
                                console.log(i, "i");
                                console.log(start.format('dddd'), "start.format");
                                if (jQuery.inArray(start.format('dddd'), days) >= 0) {
                                    list.push(start.format("YYYY-MM-DD"));
                                } else {
                                    i = i - 1;
                                }
                                start = moment(start, 'YYYY-MM-DD').add(1, 'days');
                            }
                        }
                    }
                }
                //console.log(days,start,weekCount,selectedEndDayVal,end);
                console.log(list);
                summary += "<br> The Dates are-<br>" + list

                $("#hidDates").val(list);
                $("#weeklySummary").html(summary);


            } else {
                console.log("monthly");

                $("#hidOccurenceType").val("monthly");
                $("#monthlyDay").val($("#monthlyOnDay").val());
                $("#monthlyInterval").val($("#monthlyMonth").val());
                $("#monthlyStartDate").val($("#monthlyStart").val());

                var selectedDaysVal = selectedEndDayVal = msg = "";
                var selectedDays = $("#monthlyOnDay").val();
                var selectedMonths = $("#monthlyMonth").val();
                var start = moment($("#monthlyStart").val());


                console.log("monthly", selectedDays, selectedMonths);
                if (selectedMonths > 0 && selectedMonths > 0) {

                    var selectedEndDay = $("input[type='radio'][name='monthlyWeekly']:checked");

                    if (selectedEndDay.length > 0) {
                        selectedEndDayVal = selectedEndDay.val();
                    }

                    console.log("selectedEndDayVal", selectedEndDayVal);
                    //alert(selectedEndDayVal);
                    var list = [];
                    console.log("start", start);

                    summary += "Starting Date " + $("#weeklyStartDate").val();
                    if (selectedEndDayVal == "monthlyNever") {
                        $("#monthlyEndType").val("never");

                        var end = moment(start).add(3, 'M');

                        summary += "<br>Ends On- Never Ends";
                        console.log("end", end);
                        var list = [];
                        while (start <= end) {

                            console.log(start.format('D'));
                            if (start.format('D') == selectedDays) {
                                list.push(start.format("YYYY-MM-DD"))
                            }
                            start = moment(start, 'YYYY-MM-DD').add(1, 'days'); //increment by one day
                        }
                        //alert(start.format('D'));


                    } else if (selectedEndDayVal == "on") {
                        $("#monthlyEndType").val("on");

                        var end = moment($("#monthlyOn").val());

                        $("#monthlyAfter").val($("#monthlyOn").val());
                        summary += "<br>Ends On-  " + $("#monthlyOn").val();
                        console.log("end", end);
                        var list = [];
                        while (start <= end) {

                            console.log(start.format('D'));
                            if (start.format('D') == selectedDays) {
                                list.push(start.format("YYYY-MM-DD"))
                            }
                            start = moment(start, 'YYYY-MM-DD').add(1, 'days'); //increment by one day
                        }
                        //alert(start.format('D'));


                    } else { //alert("asf");
                        $("#monthlyEndType").val("after");
                        var end = $("#monthlyAfterDay").val();

                        $("#monthlyAfter").val($("#monthlyAfterDay").val());

                        summary += "Ends After-  " + $("#monthlyAfterDay").val() + " Occurrence";
                        console.log(list, "list");
                        console.log(end, "end");
                        for (var i = 0; i < end; i++) {
                            console.log(i, "i");
                            console.log(start.format('dddd'), "start.format");
                            if (start.format('D') == selectedDays) {
                                list.push(start.format("YYYY-MM-DD"));
                            } else {
                                i = i - 1;
                            }
                            start = moment(start, 'YYYY-MM-DD').add(1, 'days');
                        }
                    }



                    $("#hidDates").val(list);
                    summary += "<br> The Dates are-<br>" + list
                    $("#monthlySummary").html(summary);

                } else {
                    msg = "Select Day and Month";
                }
                if (msg != "")
                    alert(msg);
            }
        }
    </script>
    {include file="../common/footer.tpl"}