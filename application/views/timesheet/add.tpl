{include file="../common/head.tpl"}
<script src="http://cdn.jsdelivr.net/timepicker.js/latest/timepicker.min.js"></script>
<link href="{$baseurl}/css/timepicker.css"" rel=" stylesheet" />
<style>
    ._jw-tpk-container ._jw-tpk-dark {
        height: 200px;
         !important;
    }
</style>
<section>
    <div class="container">


        <h1 class="mb-1 pb-3">Create Timesheet</h1>
        <div class="boxStyle p-4">
            <div class="row">

                <div class="col-12 rightContent">
                    <div class="tab-content" id="v-pills-tabContent">
                        <div class="tab-pane fade show active" id="v-pills-home" role="tabpanel"
                            aria-Timesheet="v-pills-home-tab">
                            <h4 class="pb-4">Timesheet Information</h4>
                            <form action="/index.php/timesheet/createTimesheet" class="addTimeSheet" method="post" name="frmAddTimesheet">
                                <div class="form-group row">
                                    <label for="" class="col-sm-3 col-form-label">Employee Name</label>
                                    <div class="col-sm-9">
                                        {if isset($logged_in_user.UserRole) && $logged_in_user.UserRole === 'admin' || $logged_in_user.UserRole === 'superadmin'}

                                            <select name="Userlist" id="Userlist" class="form-control" onchange="javascript:chgJobs();">
                                                <option selected="selected" value="">All employees</option>
                                                {foreach $users_list as $value}
                                                    <option value="{$value["UserId"]}"
                                                        {if isset($curremp) && $curremp == $value["UserId"]} selected="selected"
                                                        {/if}>{$value["FirstName"]} {$value["LastName"]}
                                                    </option>

                                                {/foreach}
                                            </select>
                                        {else}

                                            <select name="Userlist" id="Userlist" class="form-control"
                                                onchange="javascript:chgJobs();">
                                                <option value="">Choose employees</option>
                                                {foreach $users_list as $value}
                                                    {if $value["UserId"]==$logged_in_user.UserId}
                                                        <option value="{$value["UserId"]}" {if $curremp == $value["UserId"]}
                                                            selected="selected" {/if}>{$value["FirstName"]} {$value["LastName"]}
                                                        </option>
                                                    {/if}
                                                {/foreach}



                                        </select> {/if}


                                    </div>
                                </div>



                                <div class="form-group row">
                                    <label for="" class="col-sm-3 col-form-label">Jobs</label>
                                    <div class="col-sm-9">
                                        <select name="Jobslist" id="Jobslist" class="form-control"
                                            onchange="javascript:chgJobs();">
                                            <option selected="selected" value="">Select Jobs</option>
                                            {foreach $jobs_list  as $project}

                                                <option value="{$project["Id"]}">{$project["Name"]}</option>
                                            {/foreach}

                                        </select>
                                    </div>
                                </div>




                                <div class="form-group row">
                                    <label for="" class="col-sm-3 col-form-label">Job Dispatch</label>
                                    <div class="col-sm-9">
                                        <select name="JobsDispatchlist" id="JobsDispatchlist" class="form-control">
                                            <option selected="selected" value="">All Job Dispatch</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="" class="col-sm-3 col-form-label"></label>
                                    <div class="col-sm-9">

                                        <div class="">
                                            <div class="form-group row">
                                                <div class="col-12 col-md-2 pb-2 pb-md-0">
                                                    <label for="" class="form-label">Start Time</label>
                                                    <input type="text" id="startdate" value="08:00" placeholder="Time"
                                                        class="form-control" name="txtStartTime">
                                                </div>

                                                <div class="col-12 col-md-2 pb-2 pb-md-0">
                                                    <label for="" class="form-label">Finish Time</label>
                                                    <input type="text" placeholder="Time" class="form-control"
                                                        id="enddate" placeholder="Time" name="txtEndTime"
                                                        onchange="calcDuration('end');">
                                                </div>

                                                <div class="col-12 col-sm-12 col-md-3 col-sm-6 pb-1 pb-md-0">
                                                    <label for="" class="form-label">Break</label>
                                                    
                                                            <div class="form-group"
                                                                onchange="calcDuration('breakmin');">
                                                                <select name="txtBreak" id="txtBreak"
                                                                    class="form-control">
                                                                    <option value="0.0">0.0</option>
                                                                    <option value="15">15</option>
                                                                    <option value="30">30</option>
                                                                    <option value="45">45</option>

                                                                </select>


                                                            </div>
                                                </div>

                                                <div class="col-12 col-sm-12 col-md-2">
                                                    <label for="" class="form-label"> Duration</label>
                                                    <input type="text" class="form-control" id="duration"
                                                        name="txtDuration" placeholder="Duration"
                                                        onchange="calcDuration('duration');">
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <div class="col-sm-12">
                                                    <label for="inputPassword"
                                                        class="form-label">Notes</label>
                                                    <textarea class="form-control" id="job_desc" rows="3"
                                                        placeholder="Description" name="txtNotes"></textarea>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </div>


                                <div class="form-group row">
                                    <label for="" class="col-sm-3 col-form-label"></label>
                                    <div class="col-sm-9">
                                        <button type="submit" class="btn btn-lg btn-primary">Save</button>
                                        <button type="button" class="btn btn-lg btn-secondary" onclick="history.back();">Cancel</button>
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

    timepicker.on('change', function(evt) {
        var value = (evt.hour || '00') + ':' + (evt.minute || '00');
        evt.element.value = value;

        //Added the below to store in the object and consoling:
        var id = evt.element.id;
        times[id] = value;
        //console.clear();
        //console.log(times,id,value);
        calcDuration(id); // Display the object
    });

    function calcDuration(requestFrom = '') {
        // alert(requestFrom);
        var now = $("#startdate").val();
        var then = $("#enddate").val();
        var breakhr = parseFloat($("#txtBreakHr").val());
        var breakmins = parseFloat($("#txtBreak").val());
        var duration = parseFloat($("#duration").val());
        //console.log(now);
        var startTime = moment(now, "HH:mm A");
        //  console.log(startTime);
        if (requestFrom == 'start') {
            if (then < 0 && duration < 0 && endTime == '' && endTime < 0) {
                return false;
            }
        }
        if (requestFrom == 'startdate' || requestFrom == 'duration' || requestFrom == 'breakhr' || requestFrom ==
            'breakmin') {
            var endTime = '';
            var breakhr = '';
            if (duration != '') {
                duration = duration;
            }
            if (breakhr != '')
                duration = duration + breakhr;

            if (breakmins != '')
                duration = duration + breakmins / 60;

console.log(duration);
            endTime = moment(startTime, 'HH:mm A').add(duration, 'hours').format('HH:mm');

            //console.log(endTime);
            $("#enddate").val(endTime);

        } else if (requestFrom == 'enddate') {
            var endTime = 0;
            var endTime = moment($("#enddate").val(), "HH:mm A");
            //console.log(endTime,breakhr,breakmins,startTime,"endTime");

            if (breakhr != '')
                endTime = moment(endTime).subtract(breakhr, 'hours');


            //console.log(endTime,"breakhr");
            if (breakmins != '')
                endTime = moment(endTime).subtract(breakmins / 60, "hours");
            //console.log(endTime,"breakmins");
            endTimeDuration = endTime - startTime;
            formatted = moment.utc(endTimeDuration).format('HH:mm');
            duration = moment(endTimeDuration, 'HH:mm A').format('HH:mm');
            // console.log(endTimeDuration,duration,"duration",formatted);

            $("#duration").val(formatted);
        }

    }

    function chgJobs() {
        if ($("#Userlist").val() != "" && $("#Jobslist").val() != "")
            $.ajax({
                url: "/index.php/timesheet/getJobs/" + $("#Userlist").val() + "/" + $("#Jobslist").val(),
                method: 'post',
                success: function(data) {
                    $("#JobsDispatchlist").html(data);
                },
                error: function(data) {
                    console.log('error');
                    console.log(data);
                }
            });
    }
</script>
{include file="../common/footer.tpl"}