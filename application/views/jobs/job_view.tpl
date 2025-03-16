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
          $(".alert-primary").slideUp(5000);
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
	        <h1 class="mb-1 pb-1">
			{if isset($logged_in_user.UserRole) && $logged_in_user.UserRole != 'member'}
				<a href="{$host_url}/index.php/jobs">Jobs</a> | {$job.Name}
			{else}
				Jobs | {$job.Name}	
			{/if}
		</h1>
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
                                    <h4>{$job.Name}</h4>
                                </div>
                                {if isset($logged_in_user.UserRole) && $logged_in_user.UserRole != 'member'}
                                <div class="col-sm-4 ">
                                    <a href="{$host_url}/index.php/jobs/edit/{$job.Id}"><i class="icofont-ui-edit"></i>&nbsp; Edit Job</a>&nbsp;&nbsp;
                                </div>
                                {/if}
                            </div>


                                <input type="hidden" name="id" value="{if isset($job.Id)}{$job.Id}{else}new{/if}">
                                <br>
                                <div class="form-group row">
                                    <label for="" class="col-sm-3  ">Status</label>
                                    <div class="col-sm-9">
                                    {if isset($job.Status) && $job.Status=="new"}
                                    <h5>New
                                    {elseif isset($job.Status) && $job.Status=="inprogress"}
                                    Inprogress
                                    {elseif isset($job.Status) && $job.Status=="completed"}
                                    Completed
                                    {elseif isset($job.Status) && $job.Status=="approved"}
                                    Approved
                                    </h5>
                                    {/if} 
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="" class="col-sm-3  ">Job Name</label>
                                    <div class="col-sm-9">
                                        <h5>{if isset($job.Name)}{$job.Name}{/if}</h5>
                                    </div>
                                </div>

                                <div class="form-row">
                                    <div class="col-12">
                                        <div class="form-group row">
                                            <label for="" class="col-3  ">Job Type</label>
                                            <div class="col-sm-3">
                                            <h5>{if isset($job.JobType)}{$job.JobType}{/if}</h5>
                                                
                                            </div>
                                            {if isset($job.JobType) && $job.JobType == 'contract' && isset($job.ContractHours)}
                                            <label for="contract_hours"
                                                class="contract_hours col-sm-3  "  >Time In
                                                Hours:</label>
                                            <div class="col-sm-3">
                                                {$job.ContractHours}
                                            </div>
                                            {/if}
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="" class="col-sm-3  ">Customer Name</label>
                                    <div class="col-sm-9">
                                     <h5>
                                        {if isset($job.ContactId)} 
                                            {if $job.ContactType == 'Organisation'}   
                                                {$job.CompanyName}
                                            {else}
                                                {$job.FirstName} {$job.LastName}
                                            {/if}
                                        {/if}
                                    </h5>
                                    </div>
                                </div> 

                                <div class="form-row">
                                    <div class="col-12">
                                        <div class="form-group row">
                                            <label for="" class="col-3  ">Address</label>
                                            <div class="col-sm-9">
                                                <h5>{if isset($job.Address1)} {$job.Address1} {/if}, {if isset($job.Suburb)}{$job.Suburb} {/if}, {if isset($job.City)}{$job.City} {/if}<h5>
                                                <a href='https://www.google.com/maps/place/{$full_address}' target="_blank"><i class="icofont-google-map"></i> Open In Map</a>
                                            </div> 
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="" class="col-sm-3  ">Description</label>
                                    <div class="col-sm-9">
                                       <h5> {if isset($job.Description)} {$job.Description} </h5>{/if}
                                    </div>
                                </div>



                                <div class="form-row">
                                    <div class="col-12">
                                        <div class="form-group row">
                                            <label for="" class="col-3  ">Order No</label>
                                            <div class="col-sm-3">
                                               <h5> {if isset($job.OrderId)} {$job.OrderId} {/if}</h5>
                                            </div>
                                            <label for="" class="col-sm-3  ">Code /Job
                                                no:</label>
                                            <div class="col-sm-3"> 
                                               <h5> {if isset($job.JobCode)}{$job.JobCode}{/if}</h5>
                                            </div>
                                        </div>
                                    </div>
                                </div>
 



                                <div class="form-group row">
                                    <label class="col-sm-3  ">Start Date</label>
                                    <div class="col-sm-9">
                                       <h5> {if isset($job.StartDate)}{$job.StartDate}{/if}</h5>
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

                                <div class="form-group row">
                                    <label class="col-sm-3  ">Billing Type</label>
                                    <div class="col-sm-9">
                                    <h5>{if isset($job.BillingType)}{$job.BillingType}{/if}</h5>
                                    </div>
                                </div>


                                <div class="form-group row">
                                    <label class="col-sm-3  ">Job Status</label>
                                    <div class="col-sm-9">
                                    <h5>{if isset($job.JobStatus)}{$job.JobStatus}{/if}</h5>
                                    </div>
                                </div>

                              
                        <hr>
                        
                                <div class="">
                            <h4>Resources:</h4>
                        </div>
                        {if count($currjobresouces)>0}
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
                                <a href="{$host_url}/index.php/jobs/deleteJobResource/{$currjobresouce.ResourceId}/{$job.Id}" class="btn btn-sm" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Delete"><i class="active icofont-ui-delete"></i> Delete</a>
                            {/if}
                              
                            </div>
                        </div>

                        <div class="bg-light p-2 mb-1 collapse" id="collapse{$currjobresouce.ResourceId}" style="">
                        <div class="row">
                                <div class="col">
                                    <div class="form-group row">
                                    <div class="col-2">
                                        <label for="" class="form-label ">Start Date</label>
                                    <input type="date" class="form-control" id="date{$currjobresouce["ResourceId"]}" name="txtDate" placeholder="Date">
                                     </div>
                                    <div class="col-2">
                                        <label for="" class="form-label ">Start Time</label>
  <input type="text" id="resstartdate{$currjobresouce["ResourceId"]}" placeholder="Time" class="form-control"   name="txtStartTime"    >
                                       
                                        </div>

                                        <div class="col-sm-2">
                                        <label for="" class="form-label "> Duration</label>
                                        <input type="text" step="0.01"  class="form-control" id="resduration{$currjobresouce["ResourceId"]}" name="txtDuration" placeholder="Duration"   onchange="calcDurationRes('duration',{$currjobresouce["ResourceId"]});" >
                                        </div>

                                        <div class="col-sm-4">
                                        <label for="" class="form-label ">Break</label>
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


                                        <div class="col-sm-1 p-0 mt-1">
                                        <span>Hr</span></div>

                                        <div class="col-sm-2">
                                        <label for="" class="form-label ">End Time</label>
                                        <input type="text"  placeholder="Time" class="form-control" id="resenddate{$currjobresouce["ResourceId"]}" placeholder="Time" name="txtEndTime"    onchange="calcDurationRes('end',{$currjobresouce["ResourceId"]});"  >
                                         
                                        </div>

                                        </div>
                                        <div class="form-group row">
                                            <div class="col-sm-12">
                                                <label for="inputPassword" class="form-label ">Notes</label>
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
                
                       {/foreach}{else}
                            <div class="form-group row">
                                <div class="col-sm-6"><h5>No Resources Allocated</h5></div>
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
                                <form name="frmDocs" method="post" action="{$host_url}/index.php/jobs/addDocuments" enctype="multipart/form-data">
                                    <div class="col-5">
                                                
                                        <div class="form-group">
                                        <h6>Upload Docuents</h6>
                                        <input type="file" class="form-control-file" id="flJob" name="flJob">

                                       
                                        </div>
                
                                    </div>
                                    <div class="col-3"> 
                                        <input type="hidden" name="hidJid" value="{$job.Id}">
                                        <input type="hidden" name="hidPid" value="{$job.Id}">
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
                                        <a href="{$host_url}/index.php/jobs/deleteFiles/{$files.Id}" class="btn btn-sm" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Delete"><i class="active icofont-ui-delete"></i></a>
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
/*
var times = {}; // Added to initialize an object
var varTimes=varComma='';
 

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
});*/



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
            url: "{$host_url}/index.php/editTimesheetAjax/"+now+"/"+then+"/"+breakhr+"/"+breakmins+"/"+duration+"/"+job_desc+"/"+{$job.Id}+"/"+id,
            success: function(result){
                location.href ='{$host_url}/index.php/view-job-detail/'+{$job.Id};
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
            url: "{$host_url}/index.php/saveTimesheetAjax/"+now+"/"+then+"/"+breakhr+"/"+breakmins+"/"+duration+"/"+job_desc+"/"+{$job.Id}+"/"+id+"/"+date,
            success: function(result){
                if(result=="Sorry cannot log old dates.")
                    alert(result);
                else
                    location.href ='{$host_url}/index.php/view-job-detail/'+{$job.Id};
            },
            error: function(data){
                console.log('error');
            }
        });
}
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
