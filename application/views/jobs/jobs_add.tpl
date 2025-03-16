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

        {if isset($project.Name)}
            <h1 class="mb-1 pb-1">Job- {$project.Name}</h1>
        {/if}
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
                                    <h4>Add New Job</h4>
                                </div>
                                <div class="col-sm-4 text-right">

                                </div>
                            </div>


                            <form class="mt-2" method="POST" action="{$host_url}/index.php/jobs/insertJob">
                                <input type="hidden" name="id"
                                    value="{if isset($project.Id)}{$project.Id}{else}new{/if}">
                                <div class="form-group row">
                                    <label for="" class="col-sm-3 col-form-label text-right">Status</label>
                                    <div class="col-sm-9">
                                        <select id="status" class="form-control" name="status">
                                            <option selected>Select...</option>
                                            <option value="new" {if isset($project.Status) && $project.Status=="new"}
                                                selected="selected" {/if}
                                                {if isset($contactDetail.Id) && $contactDetail.Id!=''}
                                                selected="selected" {/if} selected>New</option>
                                            <option value="inprogress"
                                                {if isset($project.Status) && $project.Status=="inprogress"}
                                                selected="selected" {/if}>Inprogress</option>
                                            <option value="completed"
                                                {if isset($project.Status) && $project.Status=="completed"}
                                                selected="selected" {/if}>Completed</option>
                                            <option value="cancelled"
                                                {if isset($project.Status) && $project.Status=="cancelled"}
                                                selected="selected" {/if}>Cancelled</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="" class="col-sm-3 col-form-label text-right">Jobs Name</label>
                                    <div class="col-sm-9">
                                        <input type="text" class="form-control" id="project_name" name="project_name"
                                            value="{if isset($project.Name)}{$project.Name}{/if}"
                                            placeholder="Jobs name">
                                    </div>
                                </div>

                                <div class="form-row">
                                    <div class="col-12">
                                        <div class="form-group row">
                                            <label for="" class="col-3 col-form-label text-right">Jobs Type</label>
                                            <div class="col-sm-3">
                                                <select name='project_type' class="form-control" id="project_type"
                                                    onchange="showHideContract(this.value);">
                                                    <option value="Non-Contract"
                                                        {if isset($project.Type) && $project.Type == 'Non-Contract'}selected{/if}>
                                                        Non-Contract</option>
                                                    <option value="Contract"
                                                        {if isset($project.Type) && $project.Type == 'Contract'}selected{/if}>
                                                        Contract</option>

                                                </select>
                                            </div>
                                                <label for="agreed_frequency" class="agreed_frequency col-sm-3 col-form-label text-right"
                                                    style={if !isset($project.Type) || (isset($project.Type) && $project.Type == 'Non-Contract')}'display: none;' {else} '' {/if}>Agreed Hours</label>
                                                <div class="col-sm-3" id="agreed_frequency"
                                                    style={if !isset($project.Type) || (isset($project.Type) && $project.Type == 'Non-Contract')}'display: none;' {else} '' {/if}>
                                                    <select class="form-control" name="agreed_frequency" onchange="showHideHour(this.value);">
                                                        <option value="" {if !isset($project.AgreedFrequency) || (isset($project.AgreedFrequency) && $project.AgreedFrequency == '')}selected{/if}>not applicable</option>
                                                        <option value="weekly" {if isset($project.AgreedFrequency) && $project.AgreedFrequency == 'weekly'}selected{/if}>weekly</option>
                                                        <option value="fortnightly" {if isset($project.AgreedFrequency) && $project.AgreedFrequency == 'fortnightly'}selected{/if}>fortnightly</option>
                                                        <option value="monthly" {if isset($project.AgreedFrequency) && $project.AgreedFrequency == 'monthly'}selected{/if}>monthly</option>
                                                    </select>
                                                </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="time_selection form-row" {if isset($project.Type) && $project.Type == 'contract' && $project.AgreedFrequency != ''}style="" {else}style="display: none;"{/if}>
                                    <div class="col-12">
                                        <div class="form-group row">
                                            <label for="frequency_hours" class="frequency_hours col-sm-3 col-form-label text-right">Frequency Hours:</label>
                                            <div class="col-sm-3" id="contractHoursDiv">
                                                <input type="number" class="form-control frequency_hours" id="frequency_hours" name="frequency_hours" placeholder="48"
                                                    value="{if isset($project.FrequencyHours)}{$project.FrequencyHours}{/if}">
                                            </div>

                                            <label for="contract_hours" class="contract_hours col-sm-3 col-form-label text-right" >Time In Hours:</label>
                                            <div class="col-sm-3" id="contractHoursDiv">
                                                <input type="number" class="form-control contract_hours" id="contract_hours" name="contract_hours" placeholder="48"
                                                    value="{if isset($project.ContractHours)}{$project.ContractHours}{/if}">
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-row">
                                    <div class="col-12">
                                        <div class="form-group row">
                                            <label for="" class="col-3 col-form-label text-right">Is Recurring</label>
                                            <div class="col-sm-3">
                                                <select name='isRecurring' class="form-control" id="isRecurring"
                                                    onchange="javascript:showProjectBlock(this.value)">
                                                    <option value="Yes">Yes</option>
                                                    <option value="No" selected>No</option>

                                                </select>
                                            </div>
                                            <div class="col-sm-3" id="hidView"></div>

                                        </div>
                                    </div>
                                </div>

                                <div class="form-group row" id="startDateBlock">
                                    <label class="col-sm-3 col-form-label text-right">Start Date</label>
                                    <div class="col-sm-9">
                                        <input type="date" name="startdate" id="startdate" {if isset($today_date)}
                                            value="{$today_date}" {/if} class="form-control" onfocus="this.showPicker()"
                                            onchange="javascript:setEndDate();" />
                                    </div>
                                </div>

                                <div class="form-group row" id="endDateBlock">
                                    <label class="col-sm-3 col-form-label text-right">End Date</label>
                                    <div class="col-sm-9">
                                        <input type="date" name="enddate" id="enddate" {if isset($today_date)}
                                            value="{$today_date}" {/if} class="form-control" onfocus="this.showPicker()" />
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="" class="col-sm-3 col-form-label text-right">Customer Name</label>
                                    <div class="col-sm-9">
                                        <select id="customer_id" class="form-control"
                                            name="customer_id">
                                            <option selected>Select...</option>
                                            {foreach $contact_list as $value}
                                                <option value="{$value.Id}"
                                                    {if isset($project.ContactId) && $project.ContactId==$value.Id}
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
                                        <br>
                                        <a href="javascript:void(0);"
                                            onclick="javascript:$('#contactModal').modal('show');">
                                            Add Contact</a>
                                    </div>
                                </div>

                                <div class="form-row">
                                    <div class="col-12">
                                        <div class="form-group row">
                                            <label for=""
                                                class="col-3 col-form-label text-right">Address{if isset($contactDetail["Address1"]) && $contactDetail["Address1"]!=''}<span
                                                        id="sameAsContact"><a href="javascript:void(0);"
                                                            onclick="javascript:setProjectAddress();">(Same As
                                                        Contact)</a>{/if}</label>
                                            <div class="col-sm-9">
                                                <input type="text" class="form-control" id="address" name="address"
                                                    value="{if isset($project.Address1)} {$project.Address1} {/if}"
                                                    placeholder="Line 1">
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-row">
                                    <div class="col-12">
                                        <div class="form-group row">
                                            <label for="" class="col-3 col-form-label text-right"></label>
                                            <div class="col-sm-5">
                                                <input type="text" class="form-control" id="suburb" name="suburb"
                                                    value="{if isset($project.Suburb)} {$project.Suburb} {/if}"
                                                    placeholder="Suburb">
                                            </div>
                                            <div class="col-sm-2">
                                                <input type="text" class="form-control" id="city" name="city"
                                                    value="{if isset($project.City)} {$project.City} {/if}"
                                                    placeholder="City">
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="" class="col-sm-3 col-form-label text-right">Description</label>
                                    <div class="col-sm-9">
                                        <textarea type="textarea" class="form-control" name="description"
                                            placeholder="Description">{if isset($project.Description)} {$project.Description} {/if}</textarea>
                                    </div>
                                </div>



                                <div class="form-row">
                                    <div class="col-12">
                                        <div class="form-group row">
                                            <label for="" class="col-3 col-form-label text-right">Order No</label>
                                            <div class="col-sm-3">
                                                <input type="text" class="form-control" id="order_no" name="order_no"
                                                    {if isset($project.OrderId)} value="{$project.OrderId}" {/if}
                                                    placeholder="Order no">
                                            </div>
                                            <label for="" class="col-sm-3 col-form-label text-right">Code /Job
                                                no:</label>
                                            <div class="col-sm-3">
                                                <input type="text" class="form-control" id="job_no" name="job_no"
                                                    {if isset($project.JobId)} value="{$project.JobId}" {/if}
                                                    placeholder="Job no">
                                            </div>
                                        </div>
                                    </div>
                                </div>








                                <div class="form-group row">
                                    <label class="col-sm-3 col-form-label text-right">Notes</label>
                                    <div class="col-sm-9">
                                        <input type="text" class="form-control" placeholder="Notes if required"
                                            name="notes" {if isset($project.Notes)} value="{$project.Notes}" {/if}>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-sm-3 col-form-label text-right">Billing Type</label>
                                    <div class="col-sm-9">
                                        <select name="selBilling" id="selBilling" class="form-control">
                                            <option value="Weekly">Weekly</option>
                                            <option value="BiWeekly">BiWeekly</option>
                                            <option value="Monthly">Monthly</option>
                                        </select>
                                    </div>
                                </div>



                                <div class="form-group row" style="display: none;">
                                    <label for="inputPassword" class="col-sm-3 col-form-label text-right">Job
                                        Status</label>
                                    <div class="col-sm-9">
                                        <div class="btn-group btn-group-toggle" data-toggle="buttons">
                                            <label class="btn btn-sm btn-tertiary active">
                                                <input type="radio" name="job_status" id="option_status" checked=""
                                                    value="Open"> Open
                                            </label>
                                            <label class="btn btn-sm btn-tertiary">
                                                <input type="radio" name="job_status" id="option_status_no"
                                                    value="Close"> Close
                                            </label>
                                        </div>
                                    </div>
                                </div>

                                <hr>

                                <!--resources-->
                                <div class="">
                                    <h5>Resources:</h5>
                                </div>

                                <div class="containerDiv">
                                    <div class='element' id='div_1'>
                                        <div class="form-group row">
                                            <div class="col-sm-4">
                                                <select class="form-control selResource" name="selResouces_1"
                                                    id="selResouces_1">
                                                    <option selected="selected" value="">Select Resources</option>

                                                    {foreach $users_list as $value}
                                                        <option value="{$value["UserId"]}">{$value["FirstName"]}
                                                            {$value["LastName"]}
                                                        </option>
                                                    {/foreach}
                                                </select>
                                            </div>

                                            <div class="col-sm-4">
                                                <div class="btn-group btn-group-toggle" data-toggle="buttons">
                                                    <label class="btn btn-sm btn-tertiary active">
                                                        <input type="radio" name="options_1" id="option_row1a"
                                                            checked="" value="Employee"> Employee
                                                    </label>
                                                    <label class="btn btn-sm btn-tertiary">
                                                        <input type="radio" name="options_1" id="option_row1b"
                                                            value="Supervisor"> Supervisor
                                                    </label>
                                                </div>
                                            </div>
                                            <div class="col-sm-4">
                                                <a href="javascript:void(0);" class="remove btn btn-sm"
                                                    data-toggle="tooltip" data-placement="bottom" title=""
                                                    data-original-title="Delete" id="remove_1"><i
                                                        class="active icofont-ui-delete"></i> Delete</a><input
                                                    type="hidden" value="1" id="hidResourceCount"
                                                    name="hidResourceCount[]">

                                            </div>
                                        </div>
                                    </div>
                                </div>

                        </div>
                        <div>
                            <button type="button" class="btn btn-outline-secondary addDiv"><i
                                    class="icofont-plus-circle"></i>Add Name</button>
                        </div>
                        <hr>

                        <!--resources-->


                        <div class="form-group row">
                            <label for="" class="col-sm-3 col-form-label text-right"></label>
                            <div class="col-sm-9">
                                <button type="submit" name="button" value="submit_general"
                                    class="btn btn-lg btn-primary">Save</button>

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



                                <button type="button" class="btn btn-lg btn-secondary"
                                    onclick="javascript:document.location='{$host_url}/index.php/jobs'">Cancel</button>
                            </div>
                        </div>
                        </form>


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
        $(".addDiv").click(function() {

            // Finding total number of elements added
            var total_element = $(".element").length;

            // last <div> with element class id
            var lastid = $(".element:last").attr("id");
            var split_id = lastid.split("_");
            var nextindex = Number(split_id[1]) + 1;
            var max = 500000000;
            // Check total number elements
            if (total_element < max) {
                // Adding new div container after last occurance of element class
                $(".element:last").after("<div class='element' id='div_" + nextindex + "'></div>");

                var responseoptions = '';

                responseoptions = $("#selResouces_1").html();


                // Adding element to <div>
                $("#div_" + nextindex).append(
                    '<div class="form-group row"><div class="col-sm-4"><select class="form-control selResource" name="selResouces_' +
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

        // Remove element
        $('.containerDiv').on('click', '.remove', function() {

            var id = this.id;
            var split_id = id.split("_");
            var deleteindex = split_id[1];

            // Remove <div> with id
            $("#div_" + deleteindex).remove();

        });
    });

    function setEndDate() {
        $("#enddate").val($("#startdate").val());
    }

    function loadPrjAddress(pid = '') {
        $.ajax({
            type: "POST",
            url: "{$host_url}/index.php/projectInfoAjax/"+pid,
            success: function(result) {
                var json = JSON.parse(result);
                $("#address").val(json.Address);
                $("#suburb").val(json.Suburb);
                $("#city").val(json.City);

            },
            error: function(data) {
                console.log('error');
            }
        });
    }

    function chkForm() {
        var error = 'false';
        $.each($('select', '#frmAddJob'), function(k) {
            console.log($(this).val());
            if ($(this).val() == "") {
                error = true;
            }
        });
        if (error == true) {
            alert("Please select Resources");
            return false;
        } else
            $('#frmAddJob').submit();
    }
</script>
<script>
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

<script>
    function showProjectBlock(selected = "") {
        if (selected == "Yes") {
            $('#jobModal').modal('show');
            $("#endDateBlock").hide();
            $("#startdate").prop('disabled', true);
            $("#startDateBlock").hide();
            $("#enddate").prop('disabled', true);
        } else {
            $("#endDateBlock").show();
            $("#startdate").prop('disabled', false);
            $("#startDateBlock").show();
            $("#enddate").prop('disabled', false);
        }

    }
</script>
<!-- Contact Modal -->

<div class="modal fade" id="contactModal" tabindex="-1" aria-labelledby="exampleModalLabelq" aria-hidden="true">

    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Job Details</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="tab-pane fade show active" id="v-pills-home" role="tabpanel"
                    aria-labelledby="v-pills-home-tab">
                    <h4 class="pb-4">{if isset($contact) && $contact.ContactType == 'People'}Person
                        {elseif !isset($contact) || $contact.ContactType == 'Organisation'} Organisation
                        {/if}Information</h4>
                    <form method="post">
                        <input type="hidden" name="id" id="id"
                            value="{if isset($contact.Id)}{$contact.Id}{else}new{/if}">
                        <input type="hidden" name="type" id="type" value="{if isset($type)}{$type}{/if}">
                        <div class="form-row">

                            <div class="form-group col-3 text-right"">
                                    </div>
                                    <div class=" form-group col-9">
                                <div class="btn-group btn-group-toggle" data-toggle="buttons">
                                    <label class="btn btn-tertiary active">
                                        <input type="radio" name="contact_type" id="option1" value="People"
                                            {if isset($contact) && $contact.ContactType=='People'}checked{/if}> <i
                                            class="icofont-user-alt-7"></i> People
                                    </label>
                                    <label class="btn btn-tertiary">
                                        <input type="radio" name="contact_type" id="option2" value="Organisation"
                                            {if !isset($contact) || (isset($contact) && $contact.ContactType=='Organisation')}checked{/if}>
                                        <i class="icofont-building-alt"></i> Organisation
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label for="" class="col-sm-3 col-form-label text-right">Category</label>
                            <div class="col-sm-9">
                                <select id="inputState" name="contact_category" id="contact_category"
                                    class="required form-control">
                                    <option {if !isset($contact.ContactCategory)} selected {/if} disabled
                                        value="default">Select...</option>
                                    <option value="Customer"
                                        {if !isset($contact.ContactCategory) || (isset($contact.ContactCategory) && $contact.ContactCategory == 'Customer')}
                                        selected {/if}>Customer</option>
                                    <option value="Supplier"
                                        {if isset($contact.ContactCategory) && $contact.ContactCategory == 'Supplier'}
                                        selected {/if}>Supplier</option>
                                    <option value="Sub-contractor"
                                        {if isset($contact.ContactCategory) && $contact.ContactCategory == 'Sub-contractor'}
                                        selected {/if}>Sub-contractor</option>
                                </select>
                            </div>
                        </div>

                        <div class="company form-group row">
                            <label for="" class="col-sm-3 col-form-label text-right">Company Name</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control company_name" id="company_name"
                                    name="company_name"
                                    value="{if isset($contact.CompanyName)}{$contact.CompanyName}{/if}">
                            </div>
                        </div>

                        <div class="form-group row">
                            <label for="" class="col-sm-3 col-form-label text-right">Email</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control company_name" id="email" name="email"
                                    value="{if isset($contact.Email)}{$contact.Email}{/if}">
                            </div>
                        </div>
                        <div class="user form-group row">
                            <label for="" class="col-sm-3 col-form-label text-right">First Name</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" id="first_name" name="first_name"
                                    value="{if isset($contact.FirstName)}{$contact.FirstName}{/if}">
                            </div>
                        </div>

                        <div class=" user form-group row">
                            <label for="" class="col-sm-3 col-form-label text-right">Last Name</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" id="last_name" name="last_name"
                                    value="{if isset($contact.LastName)}{$contact.LastName}{/if}">
                            </div>
                        </div>

                        <div class="form-group row">
                            <label for="" class="col-sm-3 col-form-label text-right">Address1</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" id="addresscontact" name="addresscontact"
                                    value="{if isset($contact.Address1)}{$contact.Address1}{/if}">
                            </div>
                        </div>
                        <div class="form-group row">
                            <label for="" class="col-sm-3 col-form-label text-right">Suburb</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" id="contactsuburb" name="contactsuburb"
                                    value="{if isset($contact.Suburb)}{$contact.Suburb}{/if}">
                            </div>
                        </div>
                        <div class="form-group row">
                            <label for="" class="col-sm-3 col-form-label text-right">City</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" id="contactcity" name="contactcity"
                                    value="{if isset($contact.City)}{$contact.City}{/if}">
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="col-6">
                                <div class="form-group row">
                                    <label for="" class="col-sm-6 col-form-label text-right">Phone</label>
                                    <div class="col-sm-6 pl-2">
                                        <input type="text" class="form-control" id="phone" name="phone"
                                            value="{if isset($contact.Phone)}{$contact.Phone}{/if}">
                                    </div>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="form-group row">
                                    <label for="" class="col-sm-6 col-form-label text-right">Mobile</label>
                                    <div class="col-sm-6 ">
                                        <input type="text" class="form-control" id="mobile" name="mobile"
                                            value="{if isset($contact.Mobile)}{$contact.Mobile}{/if}">
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="form-group row">
                            <label for="" class="col-sm-3 col-form-label text-right"></label>
                            <div class="col-sm-9">
                                <button type="button" onclick="javascript:saveContact();" name="button"
                                    value="submit_general" class="btn btn-lg btn-primary">Save</button>
                                <button type="button" class="btn btn-lg btn-secondary"
                                    onclick="javascript:$('#contactModal').modal('hide');">Cancel</button>
                            </div>
                        </div>
                    </form>


                </div>
            </div>
        </div>
    </div>
</div>

<!-- Contact Modal -->
<!-- job Modal -->
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
                    <label for="inputPassword" class="pt-0 col-sm-3 col-form-label text-right">
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
                                <a class="nav-link active" id="pills-no-repeat-tab" data-toggle="pill"
                                    href="#pills-no-repeat" role="tab" aria-controls="pills-no-repeat"
                                    aria-selected="true" onclick="javascript:setHiddenTab('norepeat');">No Repeat</a>
                            </li>
                            <li class="nav-item" role="presentation">
                                <a class="nav-link" id="pills-daily-tab" data-toggle="pill" href="#pills-daily"
                                    role="tab" aria-controls="pills-daily" aria-selected="false"
                                    onclick="javascript:setHiddenTab('daily');">Daily</a>
                            </li>
                            <li class="nav-item" role="presentation">
                                <a class="nav-link" id="pills-weekly-tab" data-toggle="pill" href="#pills-weekly"
                                    role="tab" aria-controls="pills-weekly" aria-selected="false"
                                    onclick="javascript:setHiddenTab('weekly');">Weekly</a>
                            </li>
                            <li class="nav-item" role="presentation">
                                <a class="nav-link" id="pills-monthly-tab" data-toggle="pill" href="#pills-monthly"
                                    role="tab" aria-controls="pills-monthly" aria-selected="false"
                                    onclick="javascript:setHiddenTab('monthly');">Monthly</a>
                            </li>
                        </ul>
                        <div class="tab-content" id="pills-tabContent">
                            <div class="tab-pane fade show active" id="pills-no-repeat" role="tabpanel"
                                aria-labelledby="pills-no-repeat-tab">



                                <hr>
                                No repeat
                                <hr>
                            </div>

                            <div class="tab-pane fade" id="pills-daily" role="tabpanel"
                                aria-labelledby="pills-daily-tab">
                                <div class="form-group row">
                                    <div class="col-sm-9">

                                        <div class="form-inline mb-2">
                                            <input type="radio" class="btn-check" name="everydays" value="everyInterval"
                                                id="option2" checked onclick="javascript:dates()">
                                            <label class="mr-2" for="option2">&nbsp;Every</label>
                                            <input class="form-control" type="number" id="startDaysNumber"
                                                name="startDaysNumber" value="1" onchange="javascript:dates()">
                                            <label class="ml-2">day(s)</label>
                                        </div>

                                        <div class="form-inline mb-1">
                                            <input type="radio" class="btn-check" name="everydays" value="everyWeekday"
                                                id="option3" onclick="javascript:dates()">
                                            <label class="mr-2" for="option3">&nbsp;Every weekday</label>
                                        </div>
                                    </div>
                                </div>



                                <hr>
                                <div class="form-group row">
                                    <label for="inputPassword" class="pt-0 col-sm-3 col-form-label text-right">
                                        <h5 class="pt-2">Starts on</h5>
                                    </label>
                                    <div class="col-sm-9">
                                        <input type="date" name="dailyStartDate" id="dailyStartDate"
                                            class="form-control sm-3" {if isset($today_date)} value="{$today_date}"
                                            {/if} class="form-control" onchange="javascript:dates()""  >
                                            </div>
                                        </div>

                                        <hr>
                                        <div class=" form-group row">
                                        <label for="inputPassword" class="pt-0 col-sm-3 col-form-label text-right">
                                            <h5 class="">Ends</h5>
                                        </label>
                                        <div class="col-sm-9">
                                            <input type="radio" class="btn-check" name="dailyEnds" id="dailyEnds1"
                                                checked value="never" onclick="javascript:dates()"">
                                            <label class=" mr-2" for="dailyEnds1">Never</label>
                                            <br>

                                            <div class="form-inline mb-1">
                                                <input type="radio" class="btn-check" name="dailyEnds" id="dailyEnds2"
                                                    value="after" onclick="javascript:dates()"">
                                                <label class=" mr-2" for="dailyEnds2">&nbsp;After</label>
                                                <input class="form-control" type="number" name="dailyEndAfter"
                                                    id="dailyEndAfter" value="1" onchange="javascript:dates()"">
                                                <label class=" ml-2">Occurance</label>
                                            </div>

                                            <div class="form-inline mb-1">
                                                <input type="radio" class="btn-check" name="dailyEnds" id="dailyEnds3"
                                                    value="on" onclick="javascript:dates()"">
                                                <label class=" mr-2" for="dailyEnds3">&nbsp;On</label>
                                                <input type="date" id="dailyEndDate" name="dailyEndDate"
                                                    {if isset($today_date)} value="{$today_date}" {/if}
                                                    onchange="javascript:dates()"" class=" form-control sm-3">
                                            </div>
                                        </div>
                                    </div>

                                    <hr>
                                    <div class="form-group row">
                                        <label for="inputPassword" class="pt-0 col-sm-3 col-form-label text-right">
                                            <h5>Summary</h5>
                                        </label>
                                        <div class="col-sm-9" id="dailySummary">
                                        </div>
                                    </div>


                                </div>
                                <div class="tab-pane fade" id="pills-weekly" role="tabpanel"
                                    aria-labelledby="pills-weekly-tab">
                                    <div class="form-inline">
                                        <div class="form-group">
                                            <label for="inputDays">Every</label>
                                            <input type="number" id="inputDays" class="form-control mx-sm-3"
                                                aria-describedby="inputDays" name="inputDays" value="1"
                                                onchange="javascript:dates()">
                                            <label for="inputDays">Weeks</label>
                                        </div>
                                    </div>
                                    <div class="form-inline pt-3">
                                        <div class="custom-control custom-checkbox mr-4">
                                            <input type="checkbox" class="custom-control-input" id="customCheck1"
                                                value="Monday" name="chkDays[]" onclick="dates();">
                                            <label class="custom-control-label pt-1" for="customCheck1">M</label>
                                        </div>
                                        <div class="custom-control custom-checkbox mr-4">
                                            <input type="checkbox" class="custom-control-input" id="customCheck2"
                                                value="Tuesday" name="chkDays[]" onclick="dates();">
                                            <label class="custom-control-label pt-1" for="customCheck2">T</label>
                                        </div>
                                        <div class="custom-control custom-checkbox mr-4">
                                            <input type="checkbox" class="custom-control-input" id="customCheck3"
                                                value="Wednesday" name="chkDays[]" onclick="dates();">
                                            <label class="custom-control-label pt-1" for="customCheck3">W</label>
                                        </div>
                                        <div class="custom-control custom-checkbox mr-4">
                                            <input type="checkbox" class="custom-control-input" id="customCheck4"
                                                value="Thursday" name="chkDays[]" onclick="dates();">
                                            <label class="custom-control-label pt-1" for="customCheck4">T</label>
                                        </div>
                                        <div class="custom-control custom-checkbox mr-4">
                                            <input type="checkbox" class="custom-control-input" id="customCheck5"
                                                value="Friday" name="chkDays[]" onclick="dates();">
                                            <label class="custom-control-label pt-1" for="customCheck5">F</label>
                                        </div>
                                        <div class="custom-control custom-checkbox mr-4">
                                            <input type="checkbox" class="custom-control-input" id="customCheck6"
                                                value="Saturday" name="chkDays[]" onclick="dates();">
                                            <label class="custom-control-label pt-1" for="customCheck6">S</label>
                                        </div>
                                        <div class="custom-control custom-checkbox mr-4">
                                            <input type="checkbox" class="custom-control-input" id="customCheck7"
                                                value="Sunday" name="chkDays[]" onclick="dates();">
                                            <label class="custom-control-label pt-1" for="customCheck7">S</label>
                                        </div>
                                    </div>



                                    <hr>
                                    <div class="form-group row">
                                        <label for="inputPassword" class="pt-0 col-sm-3 col-form-label text-right">
                                            <h5 class="pt-2">Starts on</h5>
                                        </label>
                                        <div class="col-sm-9">
                                            <input type="date" id="weeklyStartDate" name="weeklyStartDate"
                                                class="form-control sm-3" {if isset($today_date)} value="{$today_date}"
                                                {/if} class="form-control" onblur="dates();">
                                        </div>
                                    </div>

                                    <hr>
                                    <div class="form-group row">
                                        <label for="inputPassword" class="pt-0 col-sm-3 col-form-label text-right">
                                            <h5 class="">Ends</h5>
                                        </label>
                                        <div class="col-sm-9">
                                            <input type="radio" class="btn-check" name="weekly" id="optionWeekly1"
                                                checked value="never" onclick="dates();">
                                            <label class="mr-2" for="optionWeekly1">Never</label>
                                            <br>

                                            <div class="form-inline mb-1">
                                                <input type="radio" class="btn-check" name="weekly" id="optionWeekly2"
                                                    value="after" onclick="dates();">
                                                <label class="mr-2" for="optionWeekly2">&nbsp;After</label>
                                                <input class="form-control" type="number" value="1" onchange="dates();"
                                                    name="weeklyAfter" id="weeklyEndAfter">
                                                <label class="ml-2">Occurance</label>
                                            </div>

                                            <div class="form-inline mb-1">
                                                <input type="radio" class="btn-check" name="weekly" id="optionWeekly3"
                                                    value="on" onclick="dates();">
                                                <label class="mr-2" for="optionWeekly3">&nbsp;On</label>
                                                <input type="date" {if isset($today_date)} value="{$today_date}" {/if}
                                                    id="weeklyEndDate" name="weeklyEndDate" class="form-control sm-3"
                                                    onblur="dates();">
                                            </div>
                                        </div>
                                    </div>

                                    <hr>
                                    <div class="form-group row">
                                        <label for="inputPassword" class="pt-0 col-sm-3 col-form-label text-right">
                                            <h5>Summary</h5>
                                        </label>
                                        <div class="col-sm-9" id="weeklySummary">
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane fade" id="pills-monthly" role="tabpanel"
                                    aria-labelledby="pills-monthly-tab">

                                    <div class="form-inline">
                                        <div class="form-group">
                                            <label for="onDay">On Day</label>
                                            <input type="number" id="monthlyOnDay" class="form-control mx-sm-3"
                                                style="width:80px;" aria-describedby="onDay"
                                                onchange="javascript:dates();" value="1">
                                            <label for="ofevery">of every</label>
                                            <input type="number" id="monthlyMonth" class="form-control mx-sm-3"
                                                style="width:80px;" aria-describedby="ofevery"
                                                onchange="javascript:dates();" value="1">
                                            <label for="inputMonth">months(s)</label>
                                        </div>
                                    </div>



                                    <hr>
                                    <div class="form-group row">
                                        <label for="inputPassword" class="pt-0 col-sm-3 col-form-label text-right">
                                            <h5 class="pt-2">Starts on</h5>
                                        </label>
                                        <div class="col-sm-9">
                                            <input type="date" id="monthlyStart" name="monthlyStart"
                                                class="form-control sm-3" {if isset($today_date)} value="{$today_date}"
                                                {/if} class="form-control" onchange="javascript:dates();">
                                        </div>
                                    </div>

                                    <hr>
                                    <div class="form-group row">
                                        <label for="inputPassword" class="pt-0 col-sm-3 col-form-label text-right">
                                            <h5 class="">Ends</h5>
                                        </label>
                                        <div class="col-sm-9">
                                            <input type="radio" class="btn-check" name="monthlyWeekly"
                                                id="optionWeekly1" checked value="monthlyNever"
                                                onclick="javascript:dates();">
                                            <label class="mr-2" for="optionWeekly1">Never</label>
                                            <br>

                                            <div class="form-inline mb-1">
                                                <input type="radio" class="btn-check" name="monthlyWeekly"
                                                    id="optionWeekly2" onclick="javascript:dates();" value="after">
                                                <label class="mr-2" for="optionWeekly2">&nbsp;After</label>
                                                <input class="form-control" type="number" value="1"
                                                    name="monthlyAfterDay" id="monthlyAfterDay"
                                                    onchange="javascript:dates();">
                                                <label class="ml-2">Occurance</label>
                                            </div>

                                            <div class="form-inline mb-1">
                                                <input type="radio" class="btn-check" name="monthlyWeekly"
                                                    id="optionWeekly3" value="on" onclick="javascript:dates();">
                                                <label class="mr-2" for="optionWeekly3">&nbsp;On</label>
                                                <input type="date" id="monthlyOn" {if isset($today_date)}
                                                    value="{$today_date}" {/if} class="form-control sm-3"
                                                    onchange="javascript:dates();">
                                            </div>
                                        </div>
                                    </div>

                                    <hr>
                                    <div class="form-group row">
                                        <label for="inputPassword" class="pt-0 col-sm-3 col-form-label text-right">
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
                    <input type="hidden" value="norepeat" id="hidTab" name="hidTab">
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
                sleep(1000);
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
                            /* if (weekCount > 1 && i % (7 * weekCount) == 0)
                                 start = moment(start, 'YYYY-MM-DD').add(7 * weekCount, 'Days');*/
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
                        while (start <= end) {
                            /*if (weekCount > 1 && i % (7 * weekCount) == 0)
                                start = moment(start, 'YYYY-MM-DD').add(7 * weekCount, 'Days');*/
                            i++;
                            if (jQuery.inArray(start.format('dddd'), days) >= 0) {
                                list.push(start.format("YYYY-MM-DD"));
                            }
                            start = moment(start, 'YYYY-MM-DD').add(1, 'days');
                        }

                    } else if (selectedEndDayVal == "after") {
                        $("#weeklyEndType").val("after");
                        if (days.length > 0) {
                            var list = [];
                            var end = $("#weeklyEndAfter").val();
                            $("#weeklyAfter").val($("#weeklyEndAfter").val());
                            if (startweek == 1) {
                                summary += "<br>Ends on- After" + $("#weeklyAfter").val() + " Occurrence";
                            }
                            for (var i = 0; i < end; i++) {



                                console.log(i, "i");
                                console.log(start.format('dddd'), "start.format", start.format("YYYY-MM-DD"));
                                if (jQuery.inArray(start.format('dddd'), days) >= 0) {
                                    list.push(start.format("YYYY-MM-DD"));
                                } else {
                                    i = i - 1;
                                }
                                start = moment(start, 'YYYY-MM-DD').add(1, 'days');
                            }
                        }
                    }
                    start = moment(start, 'YYYY-MM-DD').add(13, 'days');
                    console.log("dddddddddddddddddddddddddd");
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

        function sleep(time) {
            return new Promise((resolve) => setTimeout(resolve, time));
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

        function showHideDates() {
            console.log($(this).val());
        }

        $(document).ready(function() {

            if ($('#option2').is(":checked")) {
                $('.user').hide();
                $('.company').show();
            } else {
                $('.company').hide();
                $('.user').show();
            }

            $('[name ="contact_type"]').click(function() {
                var selected = $(this).val();
                if (selected == 'Organisation') {
                    $('.user').hide();
                    $('.company').show();
                } else {
                    $('.company').hide();
                    $('.user').show();
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

        });

        function saveContact() {
            var passstr = '';
            passstr += 'contacttype=' + $('[name ="contact_type"]:checked').val() + '&';
            passstr += 'contactcategory=' + $('[name ="contact_category"]').val() + '&';
            passstr += 'contactcompanyName=' + $("#company_name").val() + '&';
            passstr += 'contactemail=' + $("#email").val() + '&';
            passstr += 'contactfirstName=' + $("#first_name").val() + '&';
            passstr += 'contactlastName=' + $("#last_name").val() + '&';
            passstr += 'contactaddress1=' + $("#addresscontact").val() + '&';
            passstr += 'contactsuburb=' + $("#contactsuburb").val() + '&';
            passstr += 'contactcity=' + $("#contactcity").val() + '&';
            passstr += 'contactphone=' + $("#phone").val();
            console.log(passstr);

            $.ajax({
                type: "POST",
                url: "{$host_url}/index.php/contact/contact/addAjaxContact?"+passstr,
                success: function(result) {
                    var json = JSON.parse(result);
                    $("#customer_id").html(json.html);
                    $("#address").val(json.current_contact.Address1);
                    $("#suburb").val(json.current_contact.Suburb);
                    $("#city").val(json.current_contact.City);
                    $('#contactModal').modal('hide');
                },
                error: function(data) {
                    console.log('error');
                }
            });
        }
    </script>

    {include file="../common/footer.tpl"}