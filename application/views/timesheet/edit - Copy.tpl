{include file="../common/head.tpl"} 
<script src="http://cdn.jsdelivr.net/timepicker.js/latest/timepicker.min.js"></script>
<link href="{$baseurl}/css/timepicker.css"" rel="stylesheet"/>
<style>
._jw-tpk-container ._jw-tpk-dark{
    height:200px; !important;
}</style>
<section>
        <div class="container">

        
        <h1 class="mb-1 pb-3">Edit Timesheet</h1>
          <div class="boxStyle p-4">
                <div class="row">
                        
                        <div class="col-12 rightContent">
                          <div class="tab-content" id="v-pills-tabContent">
                            <div class="tab-pane fade show active" id="v-pills-home" role="tabpanel" aria-Timesheet="v-pills-home-tab">
                                <h4 class="pb-4">Timesheet Information</h4>
                                <form action="/index.php/timesheet/update/{$currtimesheet_list[0]["Id"]}" method="post" name="frmAddTimesheet">
                                <div class="form-group row">
                                        <label for="" class="col-sm-3 col-form-label text-right">Employee Name</label>
                                        <div class="col-sm-9"> 
                                        {if isset($logged_in_user.UserRole) && $logged_in_user.UserRole === 'admin' || $logged_in_user.UserRole === 'superadmin'}

    <select name="Userlist" id="Userlist" class="form-control" >
    <option selected="selected" value="">All employees</option>
    {foreach $users_list as $value}
    <option value="{$value["UserId"]}" {if isset($currtimesheet_list[0]["UserId"]) && $currtimesheet_list[0]["UserId"] == $value["UserId"]} selected="selected" {/if} >{$value["FirstName"]} {$value["LastName"]}
</option> 

{/foreach} 
</select>
    {else}

    <select name="Userlist" id="Userlist" class="form-control" >
    <option  value="">Choose employees</option>
    {foreach $users_list as $value}
    {if $value["UserId"]==$logged_in_user.UserId}
    <option value="{$value["UserId"]}" {if $curremp == $value["UserId"]} selected="selected" {/if} >{$value["FirstName"]} {$value["LastName"]}
    </option> 
    {/if}
{/foreach} 
   


</select> {/if}
                                    </div>
                                </div> 



                                <div class="form-group row">
                                        <label for="" class="col-sm-3 col-form-label text-right">Projects</label>
                                        <div class="col-sm-9">
                                        <select name="Projectlist" id="Projectlist" class="form-control" onchange="javascript:chgJobs();">
    <option selected="selected" value="">Select Project</option>
                      {foreach $projects_list  as $project}

    <option value="{$project["Id"]}"{if $currtimesheet_list[0]["ProjectID"] == $project["Id"]} selected="selected" {/if} >{$project["Name"]}</option> 
                {/foreach}

</select>
                                    </div>
                                </div> 




                                <div class="form-group row">
                                        <label for="" class="col-sm-3 col-form-label text-right">Jobs</label>
                                        <div class="col-sm-9">
                                        <select name="Jobslist" id="Jobslist" class="form-control">
    <option  value="">Select Jobs</option>
     {foreach $currjobs_list  as $currjobs}

    <option value="{$currjobs["Id"]}"{if $currtimesheet_list[0]["JobId"] == $currjobs["Id"]} selected="selected" {/if} >{$currjobs["Name"]}</option> 
                {/foreach}
</select>
                                    </div>
                                </div> 




                                <div class="form-group row">
                                        <label for="" class="col-sm-3 col-form-label text-right">Date</label>
                                        <div class="col-sm-9">

                                        <input type="date" class="form-control" id="date" name="txtDate" placeholder="Date" value="{$currtimesheet_list[0]["Date"]}">

                                    </div>
                                </div> 
<div class="form-group row">
                                        <label for="" class="col-sm-3 col-form-label text-right"></label>
 <div class="col-sm-9">

                                <div class="">
                                    <div class="form-group row">
                                    <div class="col-sm-2">
                                        <label for="" class="form-label text-right">Start Time</label>
                                    <input type="text" id="startdate" placeholder="Time" class="form-control"   name="txtStartTime"  value="{$currtimesheet_list[0]["StartTime"]}" >
                                        <!--<input type="time" class="form-control" id="startdate"  name="txtStartTime" placeholder="Time"    onchange="calcDuration('start');">
                                        -->
                                        </div>

                                        <div class="col-sm-2">
                                        <label for="" class="form-label text-right"> Duration</label>
                                        <input type="text" step="0.01"  class="form-control" id="duration" name="txtDuration" placeholder="Duration"   onchange="calcDuration('duration');"value='{$currtimesheet_list[0]["TotalTime"]}'>
                                        </div>

                                        <div class="col-sm-6">
                                        <label for="" class="form-label text-right">Break</label>
                                        <div class="row">
                                         <div class="col-sm-5 pr-1 form-horizontal">
                                            <div class="form-group">
                                                
                                        <select name="txtBreakHr" id="txtBreakHr" class="form-control "  onchange="calcDuration('breakhr');">
                                        <option {if $currtimesheet_list[0]["Break"] == "0" } selected='selected' {/if} value="0">0.0</option>
                                        <option {if $currtimesheet_list[0]["Break"] == "1" } selected='selected' {/if} value="1">1</option>
                                        <option {if $currtimesheet_list[0]["Break"] == "2" } selected='selected' {/if} value="2">2</option>
                                        <option {if $currtimesheet_list[0]["Break"] == "3" } selected='selected' {/if} value="3">3</option>
                                        <option {if $currtimesheet_list[0]["Break"] == "4" } selected='selected' {/if} value="4">4</option>
                                        <option {if $currtimesheet_list[0]["Break"] == "5" } selected='selected' {/if} value="5">5</option>
                                        <option {if $currtimesheet_list[0]["Break"] == "6" } selected='selected' {/if} value="6">6</option>
                                        <option {if $currtimesheet_list[0]["Break"] == "7" } selected='selected' {/if} value="7">7</option>
                                        <option {if $currtimesheet_list[0]["Break"] == "8" } selected='selected' {/if} value="8">8</option>
                                        <option {if $currtimesheet_list[0]["Break"] == "9" } selected='selected' {/if} value="9">9</option>
                                        <option {if $currtimesheet_list[0]["Break"] == "10" } selected='selected' {/if} value="10">10</option> 
                                        <option {if $currtimesheet_list[0]["Break"] == "11" } selected='selected' {/if} value="11">11</option>
                                        <option {if $currtimesheet_list[0]["Break"] == "12" } selected='selected' {/if} value="12">12</option>
                                        <option {if $currtimesheet_list[0]["Break"] == "13" } selected='selected' {/if} value="13">13</option>
                                        <option {if $currtimesheet_list[0]["Break"] == "14" } selected='selected' {/if} value="14">14</option>
                                        <option {if $currtimesheet_list[0]["Break"] == "15" } selected='selected' {/if} value="15">15</option>
                                        <option {if $currtimesheet_list[0]["Break"] == "16" } selected='selected' {/if} value="16">16</option>
                                        <option {if $currtimesheet_list[0]["Break"] == "17" } selected='selected' {/if} value="17">17</option>
                                        <option {if $currtimesheet_list[0]["Break"] == "18" } selected='selected' {/if} value="18">18</option>
                                        <option {if $currtimesheet_list[0]["Break"] == "19" } selected='selected' {/if} value="19">19</option>
                                        <option {if $currtimesheet_list[0]["Break"] == "20" } selected='selected' {/if} value="20">20</option> 
                                        <option {if $currtimesheet_list[0]["Break"] == "21" } selected='selected' {/if} value="21">21</option>
                                        <option {if $currtimesheet_list[0]["Break"] == "22" } selected='selected' {/if} value="22">22</option>
                                        <option {if $currtimesheet_list[0]["Break"] == "23" } selected='selected' {/if} value="23">23</option>
                                        </select>
                                        </div>
                                        </div> 

                                        <div class="col-sm-1 p-0 mt-1">
                                        <span>Hr</span></div>

                                        <div class="col-sm-5 pr-1 form-horizontal">
                                            <div class="form-group"  onchange="calcDuration('breakmin');">
                                        <select name="txtBreak" id="txtBreak" class="form-control">
                                        <option value="0" {if $currtimesheet_list[0]["BreakMin"] == "0" } selected="selected" {/if} >0.0</option>
                                        <option value="15" {if $currtimesheet_list[0]["BreakMin"] == "15"} selected="selected" {/if} >15</option>
                                        <option value="30" {if $currtimesheet_list[0]["BreakMin"] == "30"} selected="selected" {/if} >30</option>
                                        <option value="45" {if $currtimesheet_list[0]["BreakMin"] == "45"} selected="selected" {/if} >45</option>

                                    </select>
                                         

                                        </div>
                                        </div> 
                                        <div class="col-sm-1 p-0 mt-1">
                                        <span>Min</span></div>
                                        </div>
                                        </div>


                                        <div class="col-sm-2">
                                        <label for="" class="form-label text-right">End Time</label>
                                        <input type="text"  placeholder="Time" class="form-control" id="enddate" placeholder="Time" name="txtEndTime"    onchange="calcDuration('end');" value="{$currtimesheet_list[0]["FinishTime"]}">
                                        <!--
                                        <input type="time" class="form-control" id="enddate" placeholder="Time" name="txtEndTime"    onchange="calcDuration('end');">
                                        -->
                                        </div>

                                        </div>
                                        <div class="form-group row">
                                            <div class="col-sm-12">
                                                <label for="inputPassword" class="form-label text-right">Notes</label>
                                                <textarea class="form-control" id="job_desc" rows="3" placeholder="Description" name="txtNotes">{$currtimesheet_list[0]["Notes"]}</textarea>
                                            </div>
                                        </div>
                                </div>

        </div>
                                </div>
                                         

                                         

                                         

                                         

                                        </div>
                                         
                                </div>

        </div>
                                </div>
                                           

                                            <div class="form-group row">
                                            <label for="" class="col-sm-3 col-form-label text-right"></label>
                                            <div class="col-sm-9">
                                                <button type="submit" class="btn btn-lg btn-primary">Update</button>
                                                <button type="submit" class="btn btn-lg btn-secondary">Cancel</button>
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


var times = {}; // Added to initialize an object

var timepicker = new TimePicker(['startdate', 'enddate'], {
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
  calcDuration(id); // Display the object
});

function calcDuration(requestFrom=''){
   // alert(requestFrom);
var now  = $("#startdate").val();
var then = $("#enddate").val();
var breakhr = parseFloat($("#txtBreakHr").val());
var breakmins = parseFloat($("#txtBreak").val());
var duration = parseFloat($("#duration").val());
//console.log(now);
var startTime = moment(now,"HH:mm A");
 //  console.log(startTime);
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

//console.log(endTime);
$("#enddate").val(endTime);

}else if(requestFrom=='enddate'){
    var endTime =0;
var endTime = moment($("#enddate").val(),"HH:mm A");
        //console.log(endTime,breakhr,breakmins,startTime,"endTime");

    if(breakhr!='')
        endTime=moment(endTime).subtract(breakhr, 'hours');


//console.log(endTime,"breakhr");
    if(breakmins!='')
        endTime=moment(endTime).subtract(breakmins/60,"hours");
//console.log(endTime,"breakmins");
        endTimeDuration=endTime-startTime;
    formatted = moment.utc(endTimeDuration).format('HH:mm');
    duration=moment(endTimeDuration, 'HH:mm A').format('HH:mm');
       // console.log(endTimeDuration,duration,"duration",formatted);

$("#duration").val(formatted);
}

 }

function chgJobs(){
   $.ajax({
            url: "/index.php/timesheet/get_jobs/"+$("#Projectlist").val(),
            method: 'post',
            success: function(data) {
              $("#Jobslist").html(data);
            },
            error: function(data) {
                console.log('error');
                console.log(data);
            }
        });
}
</script>
{include file="../common/footer.tpl"}
