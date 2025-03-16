{include file="../common/head.tpl"} 
<script src="http://cdn.jsdelivr.net/timepicker.js/latest/timepicker.min.js"></script>
<link href="{$host_url}/css/timepicker.css"" rel="stylesheet"/>
<style>
._jw-tpk-container ._jw-tpk-dark{
    height:200px; !important;
}</style>
<section>
        <div class="container">

        {if (isset($fN_sess) && $fN_sess!="")}
         <div class="alert alert-primary alert-dismissible fade show" role="alert">
  <strong>{$fN_sess}</strong></div>
  <script>
  $(document).ready(function() {
          $(".alert-primary").slideUp(1000);
  });
</script>
{/if}

               <h1 class="mb-1 pb-1">Project: {$currproject_list["Name"]}</h1>
        <div class="mb-2">
        <a href="/index.php/project/joblist/{$projecId}/1/date/asc"><i class="icofont-rounded-left"></i>&nbsp; Back to Job Listing</a>
        </div>
          <div class="boxStyle p-4">
                <div class="row">
                        <div class="col-3 leftMenu">
                    {include file="../common/projectleftmenu.tpl"}
                        </div>
                        <div class="col-9 rightContent">
                          <div class="tab-content" id="v-pills-tabContent">

                            <div class="tab-pane fade show active" id="v-pills-jobs" role="tabpanel" aria-labelledby="v-pills-jobs-tab">
                                    <div class="py-2 row">
                                        <div class="col-sm-8">
                                            <h4>{$currjobs_list["Name"]}</h4>
                                        </div>
                                        {if isset($logged_in_user.UserRole) && $logged_in_user.UserRole === 'admin' || $logged_in_user.UserRole === 'superadmin'}
                                        <div class="col-sm-4 text-right">
                                            <a class="" href="{$host_url}/index.php/project-id/{$projecId}/edit/{$currjobs_list.Id}"><i class="icofont-ui-edit"></i>&nbsp; Edit Job</a>
                                        </div>
                                        {/if}
        
                                </div>
                                <hr>

                        <div class="form-group row">
                            <label for="" class="col-sm-3 col-form-label text-right">Start Date</label>
                            <div class="col-sm-3">
                                <div class="pt-2"><h5>{$currjobs_list.JobStartDate}</h5></div>
                            </div>
                            <label for="" class="col-sm-3 col-form-label text-right">End Date</label>
                            <div class="col-sm-3">
                                <div class="pt-2"><h5>{$currjobs_list.JobEndDate}</h5></div>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label for="" class="col-sm-3 col-form-label text-right">Job Name</label>
                            <div class="col-sm-9">
                                <div class="pt-2"><h5>{$currjobs_list.Name}</h5></div>
                            </div>
                            </div>
                        <div class="form-group row">
                            <label for="" class="col-sm-3 col-form-label text-right">Description</label>
                            <div class="col-sm-9">
                                <div class="pt-2"><h5>{$currjobs_list.Description}</h5></div>
                            </div>
                        </div>

                        <div class="form-group row">
                            <label for="" class="col-sm-3 col-form-label text-right">Address</label>
                            <div class="col-sm-9">
                                <div class="pt-2"><h5>{$currjobs_list.Address},{$currjobs_list.Suburb},{$currjobs_list.City}  <a href='https://www.google.com/maps/place/{$currjobs_list.Address}+{$currjobs_list.Suburb}+{$currjobs_list.City}' target="_blank"><i class="icofont-google-map"></i> Open In Map</a></h5></div>
                            </div>
                        </div>


                        <div class="form-group row">
                            <label for="" class="col-sm-3 col-form-label text-right">Status</label>
                            <div class="col-sm-9">
                                <div class="pt-2"><h5>{if $currjobs_list.Status=="1"}Open {else}Close{/if}</h5></div>
                            </div>
                        </div>
                        <hr>
                        <div class="">
                            <h4>Timesheet</h4>
                        </div>

                        {$totalDuration=0}
                        {if count($currtimesheets)>0}
                        {foreach $currtimesheets as $currtimesheet}
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
                                <tr>
                                <td><h5>{$currtimesheet.FirstName} {$currtimesheet.LastName}</h5></td>
                                <td>{$currtimesheet.StartTime}</td>
                                <td>{$currtimesheet.TotalTime}</td>
                                <td>{$currtimesheet.Break}:{$currtimesheet.BreakMin}</td>
                                <td>{$currtimesheet.FinishTime}</td>
                                <td>{if isset($logged_in_user.UserRole) && ( $logged_in_user.UserRole === 'admin' || $logged_in_user.UserRole === 'superadmin' || $currtimesheet.UserId===$logged_in_user.UserId)}

                                <a href="{$host_url}/index.php/deleteJobTimesheet/{$currtimesheet.Id}/{$projecId}/{$currjobs_list.Id}" class="btn btn-sm p-0" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Delete"><i class="active icofont-ui-delete" ></i> Delete</a>
                                {/if}
                                
                                {if isset($logged_in_user.UserRole) && ( $logged_in_user.UserRole === 'admin' || $logged_in_user.UserRole === 'superadmin' || $currtimesheet.UserId===$logged_in_user.UserId)}
                                <a class="btn btn-sm collapsed" data-toggle="collapse" href="#collapseExample{$currtimesheet.Id}" role="button" aria-expanded="false" aria-controls="collapseExample{$currtimesheet.Id}"><i class="active icofont-clock-time"></i> Edit</a>
                                {/if}
                                <a href="#" class="btn btn-sm" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="{$currtimesheet.Notes}"><i class="active icofont-info-circle"></i> Notes</a>
                                </td>
                                </tr>
                                </tbody>
                                </table>
                        {* {$totalDuration=0}
                        {if count($currtimesheets)>0}
                        {foreach $currtimesheets as $currtimesheet} *}

                        <div class="form-group row">
                               <!-- 
                                <div class="col-sm-3">
                                <label for="" class="form-label text-right">User</label>
                                <div class="pt-2"><h5>{$currtimesheet.FirstName} {$currtimesheet.LastName}</h5></div>
                                </div>
                                <div class="col-sm-3">
                                <label for="" class="form-label text-right">Start Time</label>
                                <div class="pt-2"><h5>{$currtimesheet.StartTime}</h5></div>
                                </div>


                                <div class="col-sm-2">
                                <label for="" class="form-label text-right">Duration</label>
                                <div class="pt-2"><h5>{$currtimesheet.TotalTime}</h5></div>
                                </div> 

                                <div class="col-sm-2">
                                <label for="" class="form-label text-right">Break</label>
                                <div class="pt-2"><h5>{$currtimesheet.Break}:{$currtimesheet.BreakMin}</h5></div>
                                </div>

                                <div class="col-sm-2">
                                <label for="" class="form-label text-right">End Time</label>
                                <div class="pt-2"><h5>{$currtimesheet.FinishTime}</h5></div>
                                </div>
                            </div>
                             -->
                            <!--<div class="form-group row">
                                <div class="col-sm-7">
                                    <label for="inputPassword" class="form-label text-right">Notes</label>
                                    <div class="pt-2"><h5>{$currtimesheet.Notes}</h5></div>
                                </div>
                                <div class="col-sm-5">
                                {if isset($logged_in_user.UserRole) && ( $logged_in_user.UserRole === 'admin' || $logged_in_user.UserRole === 'superadmin' || $currtimesheet.UserId===$logged_in_user.UserId)}

                                <a href="{$host_url}/index.php/deleteJobTimesheet/{$currtimesheet.Id}/{$projecId}/{$currjobs_list.Id}" class="btn btn-sm" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Delete"><i class="active icofont-ui-delete" ></i> Delete</a>
                                {/if}
                                
                                {if isset($logged_in_user.UserRole) && ( $logged_in_user.UserRole === 'admin' || $logged_in_user.UserRole === 'superadmin' || $currtimesheet.UserId===$logged_in_user.UserId)}
                                <a class="btn btn-sm collapsed" data-toggle="collapse" href="#collapseExample{$currtimesheet.Id}" role="button" aria-expanded="false" aria-controls="collapseExample{$currtimesheet.Id}"><i class="active icofont-clock-time"></i> Edit</a>
                                {/if}
                            </div>-->
                            </div>
                            <div class="bg-light p-2 mb-1 collapse" id="collapseExample{$currtimesheet.Id}" style="">
                       
                        
                        
                        <div class="row">
                                <div class="col">
                                    <div class="form-group row">
                                    <div class="col-sm-2">
                                        <label for="" class="form-label text-right">Start Time</label>
  <input type="text" id="startdate{$currtimesheet["Id"]}" placeholder="Time" class="form-control"   name="txtStartTime"  value="{$currtimesheet["StartTime"]}" >
                                       
                                        </div>

                                        <div class="col-sm-2">
                                        <label for="" class="form-label text-right"> Duration</label>
                                        <input type="text" step="0.01"  class="form-control" id="duration{$currtimesheet["Id"]}" name="txtDuration" placeholder="Duration"   onchange="calcDuration('duration',{$currtimesheet["Id"]});"value='{$currtimesheet["TotalTime"]}'>
                                        </div>

                                        <div class="col-sm-6">
                                        <label for="" class="form-label text-right">Break</label>
                                        <div class="row">
                                         <div class="col-sm-5 pr-1 form-horizontal">
                                            <div class="form-group">
                                                
                                        <select name="txtBreakHr" id="txtBreakHr{$currtimesheet["Id"]}" class="form-control "  onchange="calcDuration('breakhr',{$currtimesheet["Id"]});">
                                        <option {if $currtimesheet["Break"] == "0" } selected='selected' {/if} value="0">0.0</option>
                                        <option {if $currtimesheet["Break"] == "1" } selected='selected' {/if} value="1">1</option>
                                        <option {if $currtimesheet["Break"] == "2" } selected='selected' {/if} value="2">2</option>
                                        <option {if $currtimesheet["Break"] == "3" } selected='selected' {/if} value="3">3</option>
                                        <option {if $currtimesheet["Break"] == "4" } selected='selected' {/if} value="4">4</option>
                                        <option {if $currtimesheet["Break"] == "5" } selected='selected' {/if} value="5">5</option>
                                        <option {if $currtimesheet["Break"] == "6" } selected='selected' {/if} value="6">6</option>
                                        <option {if $currtimesheet["Break"] == "7" } selected='selected' {/if} value="7">7</option>
                                        <option {if $currtimesheet["Break"] == "8" } selected='selected' {/if} value="8">8</option>
                                        <option {if $currtimesheet["Break"] == "9" } selected='selected' {/if} value="9">9</option>
                                        <option {if $currtimesheet["Break"] == "10" } selected='selected' {/if} value="10">10</option> 
                                        <option {if $currtimesheet["Break"] == "11" } selected='selected' {/if} value="11">11</option>
                                        <option {if $currtimesheet["Break"] == "12" } selected='selected' {/if} value="12">12</option>
                                        <option {if $currtimesheet["Break"] == "13" } selected='selected' {/if} value="13">13</option>
                                        <option {if $currtimesheet["Break"] == "14" } selected='selected' {/if} value="14">14</option>
                                        <option {if $currtimesheet["Break"] == "15" } selected='selected' {/if} value="15">15</option>
                                        <option {if $currtimesheet["Break"] == "16" } selected='selected' {/if} value="16">16</option>
                                        <option {if $currtimesheet["Break"] == "17" } selected='selected' {/if} value="17">17</option>
                                        <option {if $currtimesheet["Break"] == "18" } selected='selected' {/if} value="18">18</option>
                                        <option {if $currtimesheet["Break"] == "19" } selected='selected' {/if} value="19">19</option>
                                        <option {if $currtimesheet["Break"] == "20" } selected='selected' {/if} value="20">20</option> 
                                        <option {if $currtimesheet["Break"] == "21" } selected='selected' {/if} value="21">21</option>
                                        <option {if $currtimesheet["Break"] == "22" } selected='selected' {/if} value="22">22</option>
                                        <option {if $currtimesheet["Break"] == "23" } selected='selected' {/if} value="23">23</option>
                                        </select>
                                        </div>
                                        </div> 
                                        <div class="col-sm-1 p-0 mt-1">
                                        <span>Hr</span></div>

                                        <div class="col-sm-5 pr-1 form-horizontal">
                                            <div class="form-group"  onchange="calcDuration('breakmin',{$currtimesheet["Id"]});">
                                        <select name="txtBreak" id="txtBreak{$currtimesheet["Id"]}" class="form-control">
                                        <option value="0" {if $currtimesheet["BreakMin"] == "0" } selected="selected" {/if} >0.0</option>
                                        <option value="15" {if $currtimesheet["BreakMin"] == "15"} selected="selected" {/if} >15</option>
                                        <option value="30" {if $currtimesheet["BreakMin"] == "30"} selected="selected" {/if} >30</option>
                                        <option value="45" {if $currtimesheet["BreakMin"] == "45"} selected="selected" {/if} >45</option>

                                    </select>
                                         

                                        </div>
                                        </div>

                                        <div class="col-sm-1 p-0 mt-1">
                                        <span>Min</span></div>
                                        </div>
                                        </div>

                                        <div class="col-sm-2">
                                        <label for="" class="form-label text-right">End Time</label>
                                        <input type="text"  placeholder="Time" class="form-control" id="enddate{$currtimesheet["Id"]}" placeholder="Time" name="txtEndTime"    onchange="calcDuration('end',{$currtimesheet["Id"]});" value="{$currtimesheet["FinishTime"]}">
                                         
                                        </div>

                                        </div>
                                        <div class="form-group row">
                                            <div class="col-sm-12">
                                                <label for="inputPassword" class="form-label text-right">Notes</label>
                                                <textarea class="form-control" id="job_desc{$currtimesheet["Id"]}" rows="3" placeholder="Description" name="txtNotes">{$currtimesheet["Notes"]}</textarea>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <div class="col-sm-12">
                                            <button type="button" class="btn btn-secondary mr-2" onclick='javascript:$("#collapseExample{$currtimesheet.Id}").removeClass("show");'>Cancel</button>
                                            <button type="button" class="btn btn-primary" onclick="javascript:saveTimesheet({$currtimesheet.Id});">Save</button>
                                            </div>
                                        </div>
              
                                </div>
                        </div> 
                         </div>
                           
                            

                             
                        
                        <hr>
                        {/foreach}
                        {else}
                            <div class="form-group row">
                                <div class="col-sm-3"><h5>No Timesheet logged</h5></div>
                            </div>
                        {/if}
                        <div class="">
                            <h4>Resources:</h4>
                        </div>
                        {foreach $currjobresouces as $currjobresouce}
                        <div class="form-group row">
                            <div class="col-sm-4">
                                <div class="pt-2"><h5>{$currjobresouce.FirstName} {$currjobresouce.LastName}</h5><input type="hidden" name="hidId" value="resourceId{$currjobresouce.ResourceId}"></div>
                            </div>
                            <div class="col-sm-3">
                                <div class="pt-2"><h5>{$currjobresouce.RoleId}</h5></div>
                            </div>
                            <div class="col-sm-5">
                            {if isset($logged_in_user.UserRole) && ( $logged_in_user.UserRole === 'admin' || $logged_in_user.UserRole === 'superadmin')}
                                <a href="{$host_url}/index.php/deleteJobResource/{$currjobresouce.ResourceId}/{$projecId}/{$currjobs_list.Id}" class="btn btn-sm" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Delete"><i class="active icofont-ui-delete"></i> Delete</a>
                            {/if}
                            {if isset($logged_in_user.UserRole) && ( $logged_in_user.UserRole === 'admin' || $logged_in_user.UserRole === 'superadmin' || ($currjobresouce.ResourceId===$logged_in_user.UserId && $currjobs_list.Status==1))}
                                <a class="btn btn-sm collapsed" data-toggle="collapse" href="#collapse{$currjobresouce.ResourceId}" role="button" aria-expanded="false" aria-controls="collapse"><i class="active icofont-clock-time"></i> Add</a> 
                            {/if}
                            </div>
                        </div>

                        <div class="bg-light p-2 mb-1 collapse" id="collapse{$currjobresouce.ResourceId}" style="">
                        <div class="row">
                                <div class="col">
                                    <div class="form-group row">
                                    <div class="col-2">
                                        <label for="" class="form-label text-right">Start Date</label>
                                    <input type="date" class="form-control" id="date{$currjobresouce["ResourceId"]}" name="txtDate" placeholder="Date">
                                     </div>
                                    <div class="col-2">
                                        <label for="" class="form-label text-right">Start Time</label>
  <input type="text" id="resstartdate{$currjobresouce["ResourceId"]}" placeholder="Time" class="form-control"   name="txtStartTime"    >
                                       
                                        </div>

                                        <div class="col-sm-2">
                                        <label for="" class="form-label text-right"> Duration</label>
                                        <input type="text" step="0.01"  class="form-control" id="resduration{$currjobresouce["ResourceId"]}" name="txtDuration" placeholder="Duration"   onchange="calcDurationRes('duration',{$currjobresouce["ResourceId"]});" >
                                        </div>

                                        <div class="col-sm-4">
                                        <label for="" class="form-label text-right">Break</label>
                                        <div class="row">
                                         <div class="col-sm-6 form-horizontal">
                                            <div class="form-group">
                                                
                                        <select name="txtBreakHr" id="restxtBreakHr{$currjobresouce["ResourceId"]}" class="form-control "  onchange="calcDurationRes('breakhr',{$currjobresouce["ResourceId"]});">
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
                                        <div class="col-sm-1 p-0 mt-1">
                                        <span>Hr</span></div>
                                        </div> 

                                        <div class="col-sm-6 form-horizontal">
                                            <div class="form-group"  >
                                        <select name="txtBreak" id="restxtBreak{$currjobresouce["ResourceId"]}" class="form-control" onchange="calcDurationRes('breakmin',{$currjobresouce["ResourceId"]});">
                                        <option value="0.0">0.0</option>
                                        <option value="15">15</option>
                                        <option value="30">30</option>
                                        <option value="45">45</option>

                                    </select>
                                         

                                        </div>
                                        </div> 
                                        </div>
                                        </div>


                                        

                                        <div class="col-sm-2">
                                        <label for="" class="form-label text-right">End Time</label>
                                        <input type="text"  placeholder="Time" class="form-control" id="resenddate{$currjobresouce["ResourceId"]}" placeholder="Time" name="txtEndTime"    onchange="calcDurationRes('end',{$currjobresouce["ResourceId"]});"  >
                                         
                                        </div>

                                        </div>
                                        <div class="form-group row">
                                            <div class="col-sm-12">
                                                <label for="inputPassword" class="form-label text-right">Notes</label>
                                                <textarea class="form-control" id="resjob_desc{$currjobresouce["ResourceId"]}" rows="3" placeholder="Description" name="txtNotes"></textarea>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <div class="col-sm-12">
                                            <button type="button" class="btn btn-secondary mr-2" onclick='javascript:$("#collapse{$currjobresouce.ResourceId}").removeClass("show");'>Cancel</button>
                                            <button type="button" class="btn btn-primary" onclick="javascript:saveResourceTimesheet({$currjobresouce.ResourceId});">Save</button>
                                            </div>
                                        </div>
                                </div>
                                </div>
                        </div>
                
                        <hr>{/foreach}
                            
 
    
                             
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
                                <form name="frmDocs" method="post" action="{$host_url}/index.php/job/addDocuments" enctype="multipart/form-data">
                                    <div class="col-5">
                                                
                                        <div class="form-group">
                                        <h6>Upload Docuents</h6>
                                        <input type="file" class="form-control-file" id="flJob" name="flJob">

                                       
                                        </div>
                
                                    </div>
                                    <div class="col-3"> 
                                        <input type="hidden" name="hidJid" value="{$currjobs_list.Id}">
                                        <input type="hidden" name="hidPid" value="{$projecId}">
                                        <button type="submit" class="btn btn-primary" id="btnUpload" name="btnUpload">Upload</button>
                                    </div>
                                </form>
                                </div>
                            </div>
                        <div>
    
                    <table class="table table-hover table-responsive-sm" id="FilesList">
                            <thead class="thead-dark">
                                <tr>
                                <th scope="col">Date Uploaded</th>
                                <th scope="col">Document Name <a href="#" class="caret"><i class="icofont-caret-down"></i></a></th>
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
                                        <a href="{$host_url}/uploads/jobs/{$files.Name}" class="btn btn-sm" target="_blank"><i class="active icofont-eye-alt"></i></a>
                                        {if isset($logged_in_user.UserRole) && ($logged_in_user.UserRole=="admin" || $logged_in_user.UserRole=="superadmin") || ($logged_in_user.UserId==$files.ResourceId)}
                                        <a href="{$host_url}/index.php/project-id/{$files.ProjectId}/delete/{$files.JobId}/{$files.Id}" class="btn btn-sm" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Delete"><i class="active icofont-ui-delete"></i></a>
                                        {/if}
                                </td>
                            </tr>
                             {/foreach}
                             {else}
                             <tr>
                                    <td colspan="3"> No Files
                                </td>
                            </tr>
                             {/if}
                                
                            </tbody>
                            </table>
                        </div>


                                </div>


                        </div>
                          </div>
                        </div>
                      </div>
          </div>
        
      </section>
<script>
var times = {}; // Added to initialize an object
var varTimes=varComma='';

var timepicker = new TimePicker([{if count($currtimesheets)>0}
    {foreach $currtimesheets as $currtimesheetId}'startdate{$currtimesheetId.Id}','enddate{$currtimesheetId.Id}',{/foreach}
{/if}{if count($currjobresouces)>0}
    {foreach $currjobresouces as $currjobresouceId}'resstartdate{$currjobresouceId.ResourceId}','resenddate{$currjobresouceId.ResourceId}',{/foreach}
{/if}], {
  theme: 'dark',
  lang: 'en'
});

timepicker.on('change', function(evt){
  var value = (evt.hour || '00') + ':' + (evt.minute || '00');
  evt.element.value = value;
  
  //Added the below to store in the object and consoling:
  var id = evt.element.id;
  times[id] = value;
  //console.clear();
  //console.log(times,id,value);
  alphanum=alphastr=id;
  var thenum = alphanum.replace(/^.*?(\d+).*/,'$1');
  var alphastr = alphastr.replace(/[^a-z]/gi, '');
console.log(thenum,alphastr);
//alert(thenum);
//alert(alphastr);
if(alphastr=="startdate" || alphastr=="enddate")
  calcDuration(alphastr,thenum); // Display the object
if(alphastr=="resenddate" || alphastr=="resstartdate")
  calcDurationRes(alphastr,thenum); // Display the object
});



function calcDurationRes(requestFrom='',id=''){
  //alert(requestFrom);
var now  = $("#resstartdate"+id).val();
var then = $("#resenddate"+id).val();
var breakhr = parseFloat($("#restxtBreakHr"+id).val());
var breakmins = parseFloat($("#restxtBreak"+id).val());
var duration = parseFloat($("#resduration"+id).val());
console.log(now,then);
var startTime = moment(now,"HH:mm A");


if(requestFrom=='resstartdate'){
    if(then<0 && duration<0 && endTime=='' && endTime<0){
    return false;
    }
}
if(requestFrom=='resstartdate' || requestFrom=='duration' || requestFrom=='breakhr' || requestFrom=='breakmin'){
var endTime ='';
if(duration!=''){
    duration=duration;
}
//alert(duration);
if(breakhr!='')
    duration=duration+breakhr;
//alert(duration);
if(breakmins!='')
    duration=duration+breakmins/60;
//alert(duration);
endTime =moment(startTime, 'HH:mm A').add(duration, 'hours').format('HH:mm');

$("#resenddate"+id).val(endTime);

}else if(requestFrom=='enddate' || requestFrom=='end' || requestFrom=='resenddate' ){
 var endTime =0;
var endTime = moment($("#"+requestFrom+id).val(),"HH:mm A");

    if(breakhr!='')
        endTime=moment(endTime).subtract(breakhr, 'hours');


    if(breakmins!='')
        endTime=moment(endTime).subtract(breakmins/60,"hours");
        endTimeDuration=endTime-startTime;
    formatted = moment.utc(endTimeDuration).format('HH:mm');
    duration=moment(endTimeDuration, 'HH:mm A').format('HH:mm');
if( requestFrom=='resenddate' )
    $("#resduration"+id).val(formatted);
else
    $("#duration"+id).val(formatted);

 
}

 }



function calcDuration(requestFrom='',id=''){
var now  = $("#startdate"+id).val();
var then = $("#enddate"+id).val();
var breakhr = parseFloat($("#txtBreakHr"+id).val());
var breakmins = parseFloat($("#txtBreak"+id).val());
var duration = parseFloat($("#duration"+id).val());
var startTime = moment(now,"HH:mm A");


if(requestFrom=='start'){
    if(then<0 && duration<0 && endTime=='' && endTime<0){
    return false;
    }
}
if(requestFrom=='startdate' || requestFrom=='duration' || requestFrom=='breakhr' || requestFrom=='breakmin'){
var endTime ='';
if(duration!=''){
    duration=duration;
}
if(breakhr!='')
    duration=duration+breakhr;

if(breakmins!='')
    duration=duration+breakmins/60;

endTime =moment(startTime, 'HH:mm A').add(duration, 'hours').format('HH:mm');

$("#enddate"+id).val(endTime);

}else if(requestFrom=='enddate' || requestFrom=='end' ){
 var endTime =0;
var endTime = moment($("#"+requestFrom+id).val(),"HH:mm A");

    if(breakhr!='')
        endTime=moment(endTime).subtract(breakhr, 'hours');
    if(breakmins!='')
        endTime=moment(endTime).subtract(breakmins/60,"hours");
        endTimeDuration=endTime-startTime;
    formatted = moment.utc(endTimeDuration).format('HH:mm');
    $("#duration"+id).val(formatted);
}

}

function saveTimesheet(id){
var now  = $("#startdate"+id).val();
var then = $("#enddate"+id).val();
var breakhr = parseFloat($("#txtBreakHr"+id).val());
var breakmins = parseFloat($("#txtBreak"+id).val());
var duration = ($("#duration"+id).val());
var job_desc = ($("#job_desc"+id).val());
console.log(now,then,breakhr,breakmins,duration,job_desc);
$.ajax({
            type: "POST",
            url: "{$host_url}/index.php/editTimesheetAjax/"+now+"/"+then+"/"+breakhr+"/"+breakmins+"/"+duration+"/"+job_desc+"/"+{$projecId}+"/"+{$currjobs_list.Id}+"/"+id,
            success: function(result){
                location.href ='{$host_url}/index.php/project-id/'+{$projecId}+'/view-job-detail/'+{$currjobs_list.Id};
            },
            error: function(data){
                console.log('error');
            }
        });
}



function saveResourceTimesheet(id){
var job_desc=' ';
var now  = $("#resstartdate"+id).val();
var then = $("#resenddate"+id).val();
var breakhr = parseFloat($("#restxtBreakHr"+id).val());
var breakmins = parseFloat($("#restxtBreak"+id).val());
var date = ($("#date"+id).val());
date = date.replace( /-/g, "" );

var duration = ($("#resduration"+id).val());
job_desc = ($("#resjob_desc"+id).val());
console.log(now,then,breakhr,breakmins,duration,job_desc);
$.ajax({
            type: "POST",
            url: "{$host_url}/index.php/saveTimesheetAjax/"+now+"/"+then+"/"+breakhr+"/"+breakmins+"/"+duration+"/"+job_desc+"/"+{$projecId}+"/"+{$currjobs_list.Id}+"/"+id+"/"+date,
            success: function(result){
                if(result=="Sorry cannot log old dates.")
                    alert(result);
                else
                    location.href ='{$host_url}/index.php/project-id/'+{$projecId}+'/view-job-detail/'+{$currjobs_list.Id};
            },
            error: function(data){
                console.log('error');
            }
        });
}
</script>
{include file="../common/footer.tpl"}
