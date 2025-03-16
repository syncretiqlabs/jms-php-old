{include file="../common/head.tpl"}
<script src="http://cdn.jsdelivr.net/timepicker.js/latest/timepicker.min.js"></script>
<link href="{$host_url}/css/timepicker.css"" rel=" stylesheet" />
<style>
    ._jw-tpk-container ._jw-tpk-dark {
        height: 200px;
         !important;
    }
</style>
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

        {if isset($job.Name)}
            <h1 class="mb-1 pb-1">{$job.Name}</h1>
        {/if}
        <div class="mb-2">
            {if isset($logged_in_user.UserRole) && $logged_in_user.UserRole != 'member'}
                <a href="{$host_url}/index.php/jobs/jobDetail/{$job.JobId}/1/date/desc">Job Detail</a>&nbsp;<i
                        class="icofont-rounded-right"></i>&nbsp;<a href="{$host_url}/index.php/jobs/dispatched/{$job.JobId}/1/date/desc">Job Dispatch Listing</a>
            {/if}
        </div>
        <div class="boxStyle p-4">
            <div class="row">

                <div class="col-12 rightContent">
                    <div class="tab-content" id="v-pills-tabContent">
                        <div class="tab-pane fade show active" id="v-pills-home" role="tabpanel"
                            aria-labelledby="v-pills-home-tab">
                            <div class="border-bottom py-2 row">
                                <div class="col-sm-12">
                                    <h4>{$job.DispatchName}</h4>
                                </div>
                                {if isset($logged_in_user.UserRole) && $logged_in_user.UserRole != 'member'}
                                    <div class="col-sm-4 ">
                                        <!--<a href="{$host_url}/index.php/jobs/jobDispatchedDateEdit/{$currentjob}"><i class="icofont-ui-edit"></i>&nbsp; Edit Dispatched Job</a>&nbsp;&nbsp;-->
                                    </div>
                                {/if}
                            </div>

                            <input type="hidden" name="id" value="{if isset($job.Id)}{$job.Id}{else}new{/if}">
                                <input type="hidden" name="job_id" 
                                {if isset($logged_in_user.UserRole) && $logged_in_user.UserRole != 'member'}
                                    value="{$job.JId}"
                                {else}
                                    value="{$job.JdId}" 
                                {/if}
                                >
                            <br>
                            <div class="form-group row">
                                <label for="" class="col-sm-3  ">Job Dispatch Name</label>
                                <div class="col-sm-9">
                                    <h5>{if isset($job.DispatchName)}{$job.DispatchName}{/if}</h5>
                                </div>
                            </div>

                            <div class="form-row">
                                <div class="col-12">
                                    <div class="form-group row">
                                        <label for="" class="col-6 col-md-3">Job Type</label>
                                        <div class="col-sm-3">
                                            <h5>{if isset($job.JobType)}{$job.JobType}{/if}</h5>
                                        </div>
                                        <h5>{if isset($job.JobType) && $job.JobType == 'Contract' && isset($job.ContractHours)}</h5>
                                            <label for="contract_hours" class="contract_hours col-sm-3  ">Time In Hours:</label>
                                            <div class="col-sm-3">
                                                <h5>{$job.ContractHours}</h5>
                                            </div>
                                        {/if}
                                    </div>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="" class="col-sm-3  ">Customer Name</label>
                                <div class="col-sm-9">
                                   <h5>{if isset($job.ContactId)} {$job.FirstName} {$job.LastName} {/if}</h5>
                                </div>
                            </div>

                            <div class="form-row">
                                <div class="col-12">
                                    <div class="form-group row">
                                        <label for="" class="col-3  ">Address</label>
                                        <div class="col-sm-5">
                                            <h5>{if isset($job.Address1)} {$job.Address1} {/if}, {if isset($job.Suburb)}{$job.Suburb} {/if}</h5>
                                            <h5>{if isset($job.City)}{$job.City} {/if}</h5>
                                            <a href='https://www.google.com/maps/place/{$job.Address1}+{$job.Suburb}+{$job.City}'
                                                target="_blank"><i class="icofont-google-map"></i> Open In Map</a>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            {* <div class="form-row">
                                <div class="col-12">
                                    <div class="form-group row">
                                        <label for="" class="col-3  "></label>
                                        <div class="col-sm-5">
                                            <h5>{if isset($job.Suburb)}SubUrb- {$job.Suburb} {/if}</h5>
                                        </div>
                                        <div class="col-sm-2">
                                            <h5>{if isset($job.City)}City- {$job.City} {/if}</h5>
                                        </div>
                                    </div>
                                </div>
                            </div> *}

                            <div class="form-group row">
                                <label for="" class="col-sm-3  ">Description</label>
                                <div class="col-sm-9">
                                    <h5>{if isset($job.Description)} {$job.Description} {/if}</h5>
                                </div>
                            </div>



                            <div class="form-row">
                                <div class="col-12">
                                    <div class="form-group row">
                                        <label for="" class="col-6 col-md-3">Order No</label>
                                        <div class="col-sm-3">
                                            <h5>{if isset($job.OrderId)} {$job.OrderId} {/if}</h5>
                                        </div>
                                        <label for="" class="col-6 col-md-3">Code /Job
                                            no:</label>
                                        <div class="col-sm-3">
                                            <h5>{if isset($job.JobCode)}{$job.JobCode}{/if}</h5>
                                        </div>
                                    </div>
                                </div>
                            </div>




                            <div class="form-group row">
                                <label class="col-sm-3  ">Start Date</label>
                                <div class="col-sm-9">
                                    <h5>{if isset($job.StartDate)}{$job.StartDate}{/if}</h5>
                                </div>
                            </div>

                            <div class="form-group row">
                                <label class="col-sm-3  ">End Date</label>
                                <div class="col-sm-9">
                                    <h5>{if isset($job.EndDate)}{$job.EndDate}{/if}</h5>
                                </div>
                            </div>



                            <div class="form-group row">
                                <label class="col-sm-3  ">Notes</label>
                                <div class="col-sm-9">
                                    <h5>{if isset($job.Notes)}{$job.Notes}{/if}</h5>
                                </div>
                            </div>


                            <!--<div class="form-group row">
                                <label class="col-sm-3  ">Job Status</label>
                                <div class="col-sm-9">
                                    <h5>{if isset($job.JobStatus)}{$job.JobStatus}{/if}</h5>
                                </div>
                            </div>-->


                            <hr>
                            <div class="">
                                <h4>Timesheet</h4>
                            </div>

                            {$totalDuration=0}
                            {if count($currtimesheets)>0}

                                <table class="table table-hover table-responsive-sm" id="jobList">
                                    <thead class="thead-dark">
                                        <th>User</th>
                                        <th>Start Time</th>
                                        <th>Duration</th>
                                        <th>Break</th>
                                        <th>End Time</th>
                                        <th>Actions</th>
                                    </thead>
                                    <tbody>
                                        {foreach $currtimesheets as $currtimesheet}
                                            <tr>
                                                <td>
                                                    <h5>{$currtimesheet.FirstName} {$currtimesheet.LastName}</h5>
                                                </td>
                                                <td>{$currtimesheet.StartTime}</td>
                                                <td>{$currtimesheet.TotalTime}</td>
                                                <td>{$currtimesheet.Break}:{$currtimesheet.BreakMin}</td>
                                                <td>{$currtimesheet.FinishTime}</td>
                                                <td>{if isset($logged_in_user.UserRole) && ( $logged_in_user.UserRole === 'admin' || $logged_in_user.UserRole === 'superadmin' || $currtimesheet.UserId===$logged_in_user.UserId)}

                                                        <a href="{$host_url}/index.php/deleteJobDispatchTimesheet/{$currtimesheet.Id}/{$job.Id}"
                                                            class="btn btn-sm p-0" data-toggle="tooltip" data-placement="bottom"
                                                            title="" data-original-title="Delete"><i
                                                                class="active icofont-ui-delete"></i> Delete</a>
                                                    {/if}

                                                    {if isset($logged_in_user.UserRole) && ( $logged_in_user.UserRole === 'admin' || $logged_in_user.UserRole === 'superadmin' || $currtimesheet.UserId===$logged_in_user.UserId)}
                                                        <a class="btn btn-sm collapsed" data-toggle="collapse"
                                                            href="#collapseExample{$currtimesheet.Id}" role="button"
                                                            aria-expanded="false"
                                                            aria-controls="collapseExample{$currtimesheet.Id}"><i
                                                                class="active icofont-clock-time"></i> Edit</a>

                                                    {/if}
                                                    <a href="#" class="btn btn-sm" data-toggle="tooltip" data-placement="bottom"
                                                        title="" data-original-title="{$currtimesheet.Notes}"><i
                                                            class="active icofont-info-circle"></i> Notes</a>

                                                </td>

                                            </tr>
                                            <tr>
                                                <td colspan="7" style="border:none;padding:none !important;">
                                                    <div class="form-group row">


                                                    </div>
                                                    <div class="bg-light p-2 mb-1 collapse"
                                                        id="collapseExample{$currtimesheet.Id}" style="">



                                                        <div class="row">
                                                            <div class="col">
                                                                <div class="form-group row">
                                                                    <div class="col-sm-2">
                                                                        <label for="" class="form-label ">Start
                                                                            Time</label>
                                                                        <input type="text" id="startdate{$currtimesheet["Id"]}"
                                                                            placeholder="Time" class="form-control"
                                                                            name="txtStartTime"
                                                                            value="{$currtimesheet["StartTime"]}">

                                                                    </div>

                                                                    <div class="col-sm-2">
                                                                        <label for="" class="form-label ">
                                                                            Duration</label>
                                                                        <input type="text" step="0.01" class="form-control"
                                                                            id="duration{$currtimesheet["Id"]}"
                                                                            name="txtDuration" placeholder="Duration"
                                                                            onchange="calcDuration('duration',{$currtimesheet["Id"]});"
                                                                            value='{$currtimesheet["TotalTime"]}'>
                                                                    </div>

                                                                    <div class="col-sm-6">
                                                                        <label for=""
                                                                            class="form-label ">Break</label>
                                                                        <div class="row">
                                                                            <div class="col-sm-5 pr-1 form-horizontal">
                                                                                <div class="form-group">

                                                                                    <select name="txtBreakHr"
                                                                                        id="txtBreakHr{$currtimesheet["Id"]}"
                                                                                        class="form-control "
                                                                                        onchange="calcDuration('breakhr',{$currtimesheet["Id"]});">
                                                                                        <option
                                                                                            {if $currtimesheet["Break"] == "0" }
                                                                                            selected='selected' {/if} value="0">
                                                                                            0.0</option>
                                                                                        <option
                                                                                            {if $currtimesheet["Break"] == "1" }
                                                                                            selected='selected' {/if} value="1">
                                                                                            1</option>
                                                                                        <option
                                                                                            {if $currtimesheet["Break"] == "2" }
                                                                                            selected='selected' {/if} value="2">
                                                                                            2</option>
                                                                                        <option
                                                                                            {if $currtimesheet["Break"] == "3" }
                                                                                            selected='selected' {/if} value="3">
                                                                                            3</option>
                                                                                        <option
                                                                                            {if $currtimesheet["Break"] == "4" }
                                                                                            selected='selected' {/if} value="4">
                                                                                            4</option>
                                                                                        <option
                                                                                            {if $currtimesheet["Break"] == "5" }
                                                                                            selected='selected' {/if} value="5">
                                                                                            5</option>
                                                                                        <option
                                                                                            {if $currtimesheet["Break"] == "6" }
                                                                                            selected='selected' {/if} value="6">
                                                                                            6</option>
                                                                                        <option
                                                                                            {if $currtimesheet["Break"] == "7" }
                                                                                            selected='selected' {/if} value="7">
                                                                                            7</option>
                                                                                        <option
                                                                                            {if $currtimesheet["Break"] == "8" }
                                                                                            selected='selected' {/if} value="8">
                                                                                            8</option>
                                                                                        <option
                                                                                            {if $currtimesheet["Break"] == "9" }
                                                                                            selected='selected' {/if} value="9">
                                                                                            9</option>
                                                                                        <option
                                                                                            {if $currtimesheet["Break"] == "10" }
                                                                                            selected='selected' {/if}
                                                                                            value="10">10</option>
                                                                                        <option
                                                                                            {if $currtimesheet["Break"] == "11" }
                                                                                            selected='selected' {/if}
                                                                                            value="11">11</option>
                                                                                        <option
                                                                                            {if $currtimesheet["Break"] == "12" }
                                                                                            selected='selected' {/if}
                                                                                            value="12">12</option>
                                                                                        <option
                                                                                            {if $currtimesheet["Break"] == "13" }
                                                                                            selected='selected' {/if}
                                                                                            value="13">13</option>
                                                                                        <option
                                                                                            {if $currtimesheet["Break"] == "14" }
                                                                                            selected='selected' {/if}
                                                                                            value="14">14</option>
                                                                                        <option
                                                                                            {if $currtimesheet["Break"] == "15" }
                                                                                            selected='selected' {/if}
                                                                                            value="15">15</option>
                                                                                        <option
                                                                                            {if $currtimesheet["Break"] == "16" }
                                                                                            selected='selected' {/if}
                                                                                            value="16">16</option>
                                                                                        <option
                                                                                            {if $currtimesheet["Break"] == "17" }
                                                                                            selected='selected' {/if}
                                                                                            value="17">17</option>
                                                                                        <option
                                                                                            {if $currtimesheet["Break"] == "18" }
                                                                                            selected='selected' {/if}
                                                                                            value="18">18</option>
                                                                                        <option
                                                                                            {if $currtimesheet["Break"] == "19" }
                                                                                            selected='selected' {/if}
                                                                                            value="19">19</option>
                                                                                        <option
                                                                                            {if $currtimesheet["Break"] == "20" }
                                                                                            selected='selected' {/if}
                                                                                            value="20">20</option>
                                                                                        <option
                                                                                            {if $currtimesheet["Break"] == "21" }
                                                                                            selected='selected' {/if}
                                                                                            value="21">21</option>
                                                                                        <option
                                                                                            {if $currtimesheet["Break"] == "22" }
                                                                                            selected='selected' {/if}
                                                                                            value="22">22</option>
                                                                                        <option
                                                                                            {if $currtimesheet["Break"] == "23" }
                                                                                            selected='selected' {/if}
                                                                                            value="23">23</option>
                                                                                    </select>
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-sm-1 p-0 mt-1">
                                                                                <span>Hr</span>
                                                                            </div>

                                                                            <div class="col-sm-5 pr-1 form-horizontal">
                                                                                <div class="form-group"
                                                                                    onchange="calcDuration('breakmin',{$currtimesheet["Id"]});">
                                                                                    <select name="txtBreak"
                                                                                        id="txtBreak{$currtimesheet["Id"]}"
                                                                                        class="form-control">
                                                                                        <option value="0"
                                                                                            {if $currtimesheet["BreakMin"] == "0" }
                                                                                            selected="selected" {/if}>0.0
                                                                                        </option>
                                                                                        <option value="15"
                                                                                            {if $currtimesheet["BreakMin"] == "15"}
                                                                                            selected="selected" {/if}>15
                                                                                        </option>
                                                                                        <option value="30"
                                                                                            {if $currtimesheet["BreakMin"] == "30"}
                                                                                            selected="selected" {/if}>30
                                                                                        </option>
                                                                                        <option value="45"
                                                                                            {if $currtimesheet["BreakMin"] == "45"}
                                                                                            selected="selected" {/if}>45
                                                                                        </option>

                                                                                    </select>


                                                                                </div>
                                                                            </div>

                                                                            <div class="col-sm-1 p-0 mt-1">
                                                                                <span>Min</span>
                                                                            </div>
                                                                        </div>
                                                                    </div>

                                                                    <div class="col-sm-2">
                                                                        <label for="" class="form-label ">End
                                                                            Time</label>
                                                                        <input type="text" placeholder="Time"
                                                                            class="form-control"
                                                                            id="enddate{$currtimesheet["Id"]}"
                                                                            placeholder="Time" name="txtEndTime"
                                                                            onchange="calcDuration('end',{$currtimesheet["Id"]});"
                                                                            value="{$currtimesheet["FinishTime"]}">

                                                                    </div>

                                                                </div>
                                                                <div class="form-group row">
                                                                    <div class="col-sm-12">
                                                                        <label for="inputPassword"
                                                                            class="form-label ">Notes</label>
                                                                        <textarea class="form-control"
                                                                            id="job_desc{$currtimesheet["Id"]}" rows="3"
                                                                            placeholder="Description"
                                                                            name="txtNotes">{$currtimesheet["Notes"]}</textarea>
                                                                    </div>
                                                                </div>
                                                                <div class="form-group row">
                                                                    <div class="col-sm-12">
                                                                        <button type="button" class="btn btn-secondary mr-2"
                                                                            onclick='javascript:$("#collapseExample{$currtimesheet.Id}").removeClass("show");'>Cancel</button>
                                                                        <button type="button" class="btn btn-primary"
                                                                            onclick="javascript:saveTimesheet({$currtimesheet.Id});">Save</button>
                                                                    </div>
                                                                </div>

                                                            </div>
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>

                                        {/foreach}
                                    {else}
                                        <div class="form-group row">
                                            <div class="col-sm-6">
                                                <h5>No Timesheet logged</h5>
                                            </div>
                                        </div>
                                    {/if}

                                </tbody>
                            </table>










                            <hr>
                            <div class="">
                                <h4>Resources:</h4>
                            </div>
                            {if count($currjobresouces)>0}
                                {foreach $currjobresouces as $currjobresouce}
                                    <div class="form-group row border-top mb-1 pt-1">
                                        <div class="col-sm-4">
                                            <div class="pt-2">
                                                <h5> {$currjobresouce.FirstName} {$currjobresouce.LastName}</h5><input
                                                    type="hidden" name="hidId" value="resourceId{$currjobresouce.ResourceId}">
                                            </div>
                                        </div>
                                        {* <div class="col-sm-3">
                                            <div class="pt-2">
                                                <h5>{$currjobresouce.RoleId}</h5>
                                            </div>
                                        </div> *}
                                        <div class="col-sm-5">
                                            {if isset($logged_in_user.UserRole) && ( $logged_in_user.UserRole === 'admin' || $logged_in_user.UserRole === 'superadmin'|| $logged_in_user.UserRole === 'supervisor')}
                                                <a href="javascript:void(0);" class="btn btn-sm" data-toggle="tooltip"
                                                    data-placement="bottom" title="" data-original-title="Swap Resources"
                                                    onclick="javascript:showContainerDiv({$currjobresouce.ResourceId});"><i
                                                        class="active active icofont-refresh"></i> Swap Resources</a>


                                            {/if}
                                            {if isset($logged_in_user.UserRole) && ( $logged_in_user.UserRole === 'admin' || $logged_in_user.UserRole === 'superadmin' || ($currjobresouce.ResourceId==$logged_in_user.UserId && $job.DispatchOpen=="open"))}
                                                <a class="btn btn-sm collapsed" data-toggle="collapse"
                                                    href="#collapse{$currjobresouce.ResourceId}" role="button" aria-expanded="false"
                                                    aria-controls="collapse"><i class="active icofont-clock-time"></i> Add</a>
                                            {/if}
                                        </div>

                                    </div>


                                    <!---swap start--->


                                    <div class="containerDiv_{$currjobresouce.ResourceId}" style="display:none;"
                                        id="containerDiv_{$currjobresouce.ResourceId}">
                                        <div class="element" id="div_1">
                                            <div class="form-group row">
                                                <div class="col-sm-4">
                                                    <select class="form-control selResource"
                                                        name="selResouces_{$currjobresouce.UDJId}"
                                                        id="selResouces_{$currjobresouce.UDJId}">
                                                        <option selected="selected" value="">Select Resources</option>

                                                        {foreach $users as $user}
                                                            <option value="{$user.UserId}">{$user.FirstName} {$user.LastName}
                                                            </option>
                                                        {/foreach}

                                                    </select>
                                                </div>

                                                <div class="col-sm-4">
                                                <br>
                                                    <div class="btn-group btn-group-toggle" data-toggle="buttons">
                                                        <label class="btn btn-sm btn-tertiary active">
                                                            <input type="radio" name="options_{$currjobresouce.UDJId}"
                                                                id="option_row1a" checked="" value="employee"> Employee
                                                        </label>
                                                        <label class="btn btn-sm btn-tertiary">
                                                            <input type="radio" name="options_{$currjobresouce.UDJId}"
                                                                id="option_row1b" value="supervisor"> Supervisor
                                                        </label>
                                                    </div>
                                                </div>
                                                <div class="col-sm-4">
                                                    <input type="button" value="Update" class="btn btn-primary"
                                                        onclick="javascript:swapResource({$currjobresouce.UDJId});">
                                                    <a href="javascript:void(0);" class="remove btn btn-sm" title=""
                                                        data-original-title="Cancel" id="remove_1"
                                                        onclick="javascript:showContainerDiv({$currjobresouce.ResourceId});"><i
                                                            class="active icofont-ui-delete"></i> Cancel</a><input type="hidden"
                                                        value="1" id="hidResourceCount" name="hidResourceCount[]">

                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!---swap end---->


                                    <div class="bg-light p-2 mb-1 collapse" id="collapse{$currjobresouce.ResourceId}" style="">
                                        <div class="row">
                                            <div class="col">
                                                <div class="form-group row">
                                                    <div class="col-12 col-md-2 pb-1 pb-md-0">
                                                        <label for="" class="form-label ">Date</label>
                                                        <!--<input type="date" class="form-control" id="date{$currjobresouce["ResourceId"]}" name="txtDate" placeholder="Date">-->
                                                        <select name="txtDate" id="date{$currjobresouce["ResourceId"]}"
                                                            class="form-control">

                                                            {foreach $currjobresoucesDate[$currjobresouce["ResourceId"]] as $keys=>$currjobresouceDate}
                                                                <option
                                                                    value="{$currjobresoucesIds[$currjobresouce["ResourceId"]][$keys]}">
                                                                    {$currjobresouceDate}</option>
                                                            {/foreach}
                                                        </select>
                                                    </div>
                                                    <div class="col-12 col-md-2 pb-1 pb-md-0">
                                                        <label for="" class="form-label ">Start Time</label>
                                                        <input type="text" id="resstartdate{$currjobresouce["ResourceId"]}"
                                                            placeholder="Time" class="form-control" name="txtStartTime">

                                                    </div>
                                                    <div class="col-12 col-md-2 py-2 py-md-0">
                                                        <label for="" class="form-label ">Finish Time</label>
                                                        <input type="text" placeholder="Time" class="form-control"
                                                            id="resenddate{$currjobresouce["ResourceId"]}" placeholder="Time"
                                                            name="txtEndTime"
                                                            onchange="calcDurationRes('end',{$currjobresouce["ResourceId"]});">

                                                    </div>

                                                    

                                                    <div class="col-12 col-sm-12 col-md-4 col-sm-4 pb-1 pb-md-0">
                                                        <label for="" class="form-label ">Break</label>
                                                        <div class="row">
                                                            <div class="col-5 col-md-6 form-horizontal">
                                                                <div class="form-group">

                                                                    <select name="txtBreakHr"
                                                                        id="restxtBreakHr{$currjobresouce["ResourceId"]}"
                                                                        class="form-control "
                                                                        onchange="calcDurationRes('breakhr',{$currjobresouce["ResourceId"]});">
                                                                        <option value="0.0">0.0</option>
                                                                        <option value="1">1</option>
                                                                        <option value="2">2</option>
                                                                        <option value="3">3</option>
                                                                        <option value="4">4</option>
                                                                        <option value="5">5</option>
                                                                        <option value="6">6</option>
                                                                        <option value="7">7</option>
                                                                        <option value="8">8</option>
                                                                        <option value="9">9</option>
                                                                        <option value="10">10</option>
                                                                        <option value="11">11</option>
                                                                        <option value="12">12</option>
                                                                        <option value="13">13</option>
                                                                        <option value="14">14</option>
                                                                        <option value="15">15</option>
                                                                        <option value="16">16</option>
                                                                        <option value="17">17</option>
                                                                        <option value="18">18</option>
                                                                        <option value="19">19</option>
                                                                        <option value="20">20</option>
                                                                        <option value="21">21</option>
                                                                        <option value="22">22</option>
                                                                        <option value="23">23</option>
                                                                    </select>
                                                                </div>
                                                            </div>

                                                            <div class="col-5 col-md-6 form-horizontal">
                                                                <div class="form-group">
                                                                    <select name="txtBreak"
                                                                        id="restxtBreak{$currjobresouce["ResourceId"]}"
                                                                        class="form-control"
                                                                        onchange="calcDurationRes('breakmin',{$currjobresouce["ResourceId"]});">
                                                                        <option value="0.0">0.0</option>
                                                                        <option value="15">15</option>
                                                                        <option value="30">30</option>
                                                                        <option value="45">45</option>

                                                                    </select>


                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
{* 

                                                    <div class="col-sm-1 p-0 mt-1">
                                                        <span>Hr</span>
                                                    </div> *}

                                                    <div class="col-12 col-sm-12 col-md-2">
                                                        <label for="" class="form-label "> Duration</label>
                                                        <input type="text" step="0.01" class="form-control"
                                                            id="resduration{$currjobresouce["ResourceId"]}" name="txtDuration"
                                                            placeholder="Duration"
                                                            onchange="calcDurationRes('duration',{$currjobresouce["ResourceId"]});">
                                                    </div>

                                                </div>
                                                <div class="form-group row">
                                                    <div class="col-sm-12">
                                                        <label for="inputPassword" class="form-label ">Notes</label>
                                                        <textarea class="form-control"
                                                            id="resjob_desc{$currjobresouce["ResourceId"]}" rows="3"
                                                            placeholder="Description" name="txtNotes"></textarea>
                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <div class="col-sm-12">
                                                        <button type="button" class="btn btn-secondary mr-2"
                                                            onclick='javascript:$("#collapse{$currjobresouce.ResourceId}").removeClass("show");'>Cancel</button>
                                                        <button type="button" class="btn btn-primary"
                                                            onclick="javascript:saveResourceTimesheet({$currjobresouce.ResourceId});">Save</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                {/foreach}
                                {else}
                                    <div class="form-group row">
                                        <div class="col-sm-6">
                                            <h5>No Resources Allocated</h5>
                                        </div>
                                    </div>
                                {/if}

                                <hr>


                                <div class="form-group row">
                                    <div class="col-sm-12">
                                        <div class="row">
                                            <div class="col">
                                                <h4>Documents</h4>
                                            </div>


                                        </div>
                                    </div>
                                </div>
                                <div class="form-group row">

                                    <div class="col-sm-12">
                                        <form name="frmDocs" method="post"
                                            action="{$host_url}/index.php/jobs/addDispatchDocuments"
                                            enctype="multipart/form-data">
                                            <div class="col-5">

                                                <div class="form-group">
                                                    <h6>Upload Docuents</h6>
                                                    <input type="file" class="form-control-file" id="flJob" name="flJob">


                                                </div>

                                            </div>
                                            <div class="col-3">
                                                <input type="hidden" name="hidJid" value="{$job.Id}">
                                                <input type="hidden" name="hidPid" value="{$job.Id}">
                                                <input type="hidden" name="hidJrid" value="{$currentjob}">
                                                <button type="submit" class="btn btn-primary" id="btnUpload"
                                                    name="btnUpload">Upload</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                                <div>
                                    <table class="table table-hover table-responsive-sm" id="FilesList">
                                        <thead class="thead-dark">
                                            <tr>
                                                <th scope="col">Date Uploaded</th>
                                                <th scope="col">Document Name <a href="#" class="caret"><i
                                                            class="icofont-caret-down"></i></a></th>
                                                <th scope="col">Actions</th>
                                            </tr>
                                        </thead>
                                        {if $files_records>0}
                                            {foreach $files_list as $files}
                                                <tbody>

                                                    <tr>
                                                        <td>{$files.AddedOn}</td>
                                                        <td>{$files.Name}</td>
                                                        <td>
                                                            <a href="{$host_url}/uploads/jobs/{$files.Name}" class="btn btn-sm"
                                                                target="_blank"><i class="active icofont-eye-alt"></i></a>
                                                            {if isset($logged_in_user.UserRole) && ($logged_in_user.UserRole=="admin" || $logged_in_user.UserRole=="superadmin") || ($logged_in_user.UserId==$files.ResourceId)}
                                                                <a href="{$host_url}/index.php/jobs/jobDispatchDelete/{$files.Id}"
                                                                    class="btn btn-sm" data-toggle="tooltip" data-placement="bottom"
                                                                    title="" data-original-title="Delete"><i
                                                                        class="active icofont-ui-delete"></i></a>
                                                            {/if}
                                                        </td>
                                                    </tr>
                                                {/foreach}
                                            {else}
                                                <tr>
                                                    <td colspan="6"> No Files
                                                    </td>
                                                </tr>
                                            {/if}

                                        </tbody>
                                    </table>
                                    <hr>


                                    </form>


                                </div>





                            </div>
                        </div>
                    </div>
                </div>
            </div>
    </section>



    <script>
        var times = {}; // Added to initialize an object
        var varTimes = varComma = '';

        var timepicker = new TimePicker([{if count($currtimesheets)>0}
            {foreach $currtimesheets as $currtimesheetId}'startdate{$currtimesheetId.Id}','enddate{$currtimesheetId.Id}',{/foreach}
            {/if}{if count($currjobresouces)>0}
            {foreach $currjobresouces as $currjobresouceId}'resstartdate{$currjobresouceId.ResourceId}','resenddate{$currjobresouceId.ResourceId}',{/foreach}
        {/if}], {
        theme: 'dark',
            lang: 'en'
        });

        timepicker.on('change', function(evt) {
            var value = (evt.hour || '00') + ':' + (evt.minute || '00');
            evt.element.value = value;

            //Added the below to store in the object and consoling:
            var id = evt.element.id;
            times[id] = value;
            //console.clear();
            //console.log(times,id,value);
            alphanum = alphastr = id;
            var thenum = alphanum.replace(/^.*?(\d+).*/, '$1');
            var alphastr = alphastr.replace(/[^a-z]/gi, '');
            console.log(thenum, alphastr);
            //alert(thenum);
            //alert(alphastr);
            if (alphastr == "startdate" || alphastr == "enddate")
                calcDuration(alphastr, thenum); // Display the object
            if (alphastr == "resenddate" || alphastr == "resstartdate")
                calcDurationRes(alphastr, thenum); // Display the object
        });



        function calcDurationRes(requestFrom = '', id = '') {
            //alert(requestFrom);
            var now = $("#resstartdate" + id).val();
            var then = $("#resenddate" + id).val();
            var breakhr = parseFloat($("#restxtBreakHr" + id).val());
            var breakmins = parseFloat($("#restxtBreak" + id).val());
            var duration = parseFloat($("#resduration" + id).val());
            console.log(now, then);
            var startTime = moment(now, "HH:mm A");


            if (requestFrom == 'resstartdate') {
                if (then < 0 && duration < 0 && endTime == '' && endTime < 0) {
                    return false;
                }
            }
            if (requestFrom == 'resstartdate' || requestFrom == 'duration' || requestFrom == 'breakhr' || requestFrom ==
                'breakmin') {
                var endTime = '';
                if (duration != '') {
                    duration = duration;
                }
                //alert(duration);
                if (breakhr != '')
                    duration = duration + breakhr;
                //alert(duration);
                if (breakmins != '')
                    duration = duration + breakmins / 60;
                //alert(duration);
                endTime = moment(startTime, 'HH:mm A').add(duration, 'hours').format('HH:mm');

                $("#resenddate" + id).val(endTime);

            } else if (requestFrom == 'enddate' || requestFrom == 'end' || requestFrom == 'resenddate') {
                var endTime = 0;
                var endTime = moment($("#" + requestFrom + id).val(), "HH:mm A");

                if (breakhr != '')
                    endTime = moment(endTime).subtract(breakhr, 'hours');


                if (breakmins != '')
                    endTime = moment(endTime).subtract(breakmins / 60, "hours");
                endTimeDuration = endTime - startTime;
                formatted = moment.utc(endTimeDuration).format('HH:mm');
                duration = moment(endTimeDuration, 'HH:mm A').format('HH:mm');
                if (requestFrom == 'resenddate')
                    $("#resduration" + id).val(formatted);
                else
                    $("#duration" + id).val(formatted);


            }

        }



        function calcDuration(requestFrom = '', id = '') {
            var now = $("#startdate" + id).val();
            var then = $("#enddate" + id).val();
            var breakhr = parseFloat($("#txtBreakHr" + id).val());
            var breakmins = parseFloat($("#txtBreak" + id).val());
            var duration = parseFloat($("#duration" + id).val());
            var startTime = moment(now, "HH:mm A");


            if (requestFrom == 'start') {
                if (then < 0 && duration < 0 && endTime == '' && endTime < 0) {
                    return false;
                }
            }
            if (requestFrom == 'startdate' || requestFrom == 'duration' || requestFrom == 'breakhr' || requestFrom ==
                'breakmin') {
                var endTime = '';
                if (duration != '') {
                    duration = duration;
                }
                if (breakhr != '')
                    duration = duration + breakhr;

                if (breakmins != '')
                    duration = duration + breakmins / 60;

                endTime = moment(startTime, 'HH:mm A').add(duration, 'hours').format('HH:mm');

                $("#enddate" + id).val(endTime);

            } else if (requestFrom == 'enddate' || requestFrom == 'end') {
                var endTime = 0;
                var endTime = moment($("#" + requestFrom + id).val(), "HH:mm A");

                if (breakhr != '')
                    endTime = moment(endTime).subtract(breakhr, 'hours');
                if (breakmins != '')
                    endTime = moment(endTime).subtract(breakmins / 60, "hours");
                endTimeDuration = endTime - startTime;
                formatted = moment.utc(endTimeDuration).format('HH:mm');
                $("#duration" + id).val(formatted);
            }

        }

        function saveTimesheet(id) {
            var now = $("#startdate" + id).val();
            var then = $("#enddate" + id).val();
            var breakhr = parseFloat($("#txtBreakHr" + id).val());
            var breakmins = parseFloat($("#txtBreak" + id).val());
            var duration = ($("#duration" + id).val());

            var job_desc = null;
            job_desc = ($("#job_desc" + id).val());
            
            if (job_desc == "") {
                job_desc = null;
            }

            console.log(id);
            console.log(now, then, breakhr, breakmins, duration, job_desc, id);
            $.ajax({
                type: "POST",
                url: "{$host_url}/index.php/jobs/editDispatchTimesheetAjax/"+now+"/"+then+"/"+breakhr+"/"+breakmins+"/"+duration+"/"+job_desc+"/"+{$job.Id}+"/"+id,
                success: function(result) {
                    //location.href ='{$host_url}/index.php/view-job-detail/'+{$job.Id};
                    location.href ='{$host_url}/index.php/jobs/jobDispatchDetail/'+{$currentjob};

                },
                error: function(data) {
                    console.log('error');
                }
            });
        }



        function saveResourceTimesheet(id) {
            var job_desc = ' ';
            var now = $("#resstartdate" + id).val();
            var then = $("#resenddate" + id).val();
            var breakhr = parseFloat($("#restxtBreakHr" + id).val());
            var breakmins = parseFloat($("#restxtBreak" + id).val());
            var date = ($("#date" + id).val());
            date = date.replace(/-/g, "");

            var duration = ($("#resduration" + id).val());
            var job_desc = null;
            job_desc = ($("#resjob_desc" + id).val());
            job_id = $("input[name=job_id]").val();
            if (job_desc == "") job_desc = null;
            console.log(now, then, breakhr, breakmins, duration, job_desc);
            $.ajax({
                type: "POST",
                url: "{$host_url}/index.php/jobs/saveDispatchTimesheetAjax/"+now+"/"+then+"/"+breakhr+"/"+breakmins+"/"+duration+"/"+job_desc+"/"+{$job.Id}+"/"+id+"/"+date+"/"+job_id,
                success: function(result) {
                    if (result == "Sorry cannot log old dates.") {
                        alert(result);
                    } else {
                        location.href ='{$host_url}/index.php/jobs/jobDispatchDetail/' + {$currentjob};
                    }
                },
                error: function(data) {
                    console.log('error');
                }
            });
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
        function showContainerDiv(val) {
            $(".containerDiv_" + val).toggle();
        }


        function swapResource(val) {
            var newResource = $("#selResouces_" + val).val();
            var oldResource = val;
            var newRole = '';
            var selected = $("input[type='radio'][name='options_" + val + "']:checked");
            if (selected.length > 0) {
                newRole = selected.val();
            }
            console.log(newResource, oldResource, newRole);
            if (newResource != "" && oldResource != "" && newRole != "") {

                console.log(newResource, oldResource, newRole);
                $.ajax({
                    type: "POST",
                    url: "{$host_url}/index.php/jobs/swapDispatchResourceAjax/"+newResource+"/"+oldResource+"/"+newRole,
                    success: function(result) {
                        //location.href ='{$host_url}/index.php/view-job-detail/'+{$job.Id};
                        location.href ='{$host_url}/index.php/jobs/jobDispatchDetail/'+{$job.Id};

                    },
                    error: function(data) {
                        console.log('error');
                    }
                });
            } else {
                alert("Please select User and Role Properly.");
            }
        }
    </script>
    {include file="../common/footer.tpl"}