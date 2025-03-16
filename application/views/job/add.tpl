{include file="../common/head.tpl"} 

<section>
        <div class="container">

         

        <h1 class="mb-1 pb-1">Project: {$currproject_list.Name}</h1>
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
                                     
                        <form action="/index.php/job/insertJob/{$projecId}" method="post" name="frmAddJob" id="frmAddJob">
                                <div class="form-group row">
                                    <label for="inputPassword" class="col-sm-3 col-form-label text-right">Start Date</label>
                                    <div class="col-sm-3">
                                    <input type="date" class="form-control" id="startdate" placeholder="Date" name="startDate" onchange="javascript:setEndDate();">
                                    </div>
                                    <label for="inputPassword" class="col-sm-3 col-form-label text-right">End Date</label>
                                    <div class="col-sm-3">
                                    <input type="date" class="form-control" id="enddate" placeholder="Date" name="endDate">
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="inputPassword" class="col-sm-3 col-form-label text-right">Job Name</label>
                                    <div class="col-sm-9">
                                    <input type="text" class="form-control" id="job_name" placeholder="Job Name"  name="jobName">
                                    </div>
                                    </div>
                                <div class="form-group row">
                                    <label for="inputPassword" class="col-sm-3 col-form-label text-right">Description</label>
                                    <div class="col-sm-9">
                                        <textarea class="form-control" id="job_desc" rows="3" placeholder="Description" name="txtDescription"></textarea>
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="col-12">
                                        <div class="form-group row">
                                            <label for="" class="col-3 col-form-label text-right">Address<a href="javascript:void(0)" onclick="javascript:loadPrjAddress({$projecId});">(Same As Project)</a></label>
                                            <div class="col-sm-9">
                                        <input type="text" class="form-control" id="address" name="address" value="  " placeholder="Line 1">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="col-12">
                                        <div class="form-group row">
                                            <label for="" class="col-3 col-form-label text-right">Suburb</label>
                                            <div class="col-sm-5">
                                                <input type="text" class="form-control" id="suburb" name="suburb" value="  " placeholder="Suburb">
                                            </div>
                                            <div class="col-sm-2">
                                                <input type="text" class="form-control" id="city" name="city" value="" placeholder="City">
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="inputPassword" class="col-sm-3 col-form-label text-right">Status</label>
                                    <div class="col-sm-9">
                                        <div class="btn-group btn-group-toggle" data-toggle="buttons">
                                    <label class="btn btn-sm btn-tertiary active">
                                        <input type="radio" name="status" id="option_status" checked="" value="1"> Open
                                    </label>
                                    <label class="btn btn-sm btn-tertiary">
                                        <input type="radio" name="status" id="option_status_no" value="0"> Close
                                    </label>
                                    </div>
                                    </div>
                                </div>

                                                                 <hr>

                                  <!--resources--> 
                                <div class="">
                                    <h5>Resources:</h5>
                                </div>

                        <div class="containerDiv" >
                            <div class='element' id='div_1'>
                                <div class="form-group row">
                                    <div class="col-sm-4">
                                    <select class="form-control selResource" name="selResouces_1" id="selResouces_1">
                                        <option selected="selected" value="">Select Resources</option>

                                        {foreach $users_list as $value}
    <option value="{$value["UserId"]}"  >{$value["FirstName"]} {$value["LastName"]}
</option> 
{/foreach} 
                                    </select>
                                    </div>
            
                                    <div class="col-sm-4">
                                    <div class="btn-group btn-group-toggle" data-toggle="buttons">
                                    <label class="btn btn-sm btn-tertiary active">
                                        <input type="radio" name="options_1" id="option_row1a" checked="" value="employee"> Employee
                                    </label>
                                    <label class="btn btn-sm btn-tertiary">
                                        <input type="radio" name="options_1" id="option_row1b" value="supervisor"> Supervisor
                                    </label>
                                    </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <a href="javascript:void(0);" class="remove btn btn-sm" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Delete" id="remove_1"><i class="active icofont-ui-delete"></i> Delete</a><input type="hidden" value="1" id="hidResourceCount" name="hidResourceCount[]">
                                         
                                    </div>
                                </div>
                            </div>
                        </div>
                                 
                                </div>
            
                                <!--resources--> 
    
                                    
                                 
            
                                    <div>
                                            <button type="button" class="btn btn-outline-secondary addDiv"><i class="icofont-plus-circle"></i>Add Name</button>
                                        </div>
                                        <hr>
                                     
                                
                                <div class="form-group row">
                                            <label for="" class="col-sm-3 col-form-label text-right"></label>
                                            <div class="col-sm-9">
                                                <button type="button" class="btn btn-lg btn-primary" onclick="javasctipt:chkForm();">Save</button>
                                                <button type="button" class="btn btn-lg btn-secondary">Cancel</button>
                                            </div>
                                            </div>
                                </form>
                        <div>
                        </div>


                                </div>


                        </div>
                          </div>
                        </div>
                      </div>
          </div>
        
      </section>
<script>
$(document).ready(function(){

 // Add new element
 $(".addDiv").click(function(){

  // Finding total number of elements added
  var total_element = $(".element").length;
 
  // last <div> with element class id
  var lastid = $(".element:last").attr("id");
  var split_id = lastid.split("_");
  var nextindex = Number(split_id[1]) + 1;
  var max = 500000000;
  // Check total number elements
  if(total_element < max ){
   // Adding new div container after last occurance of element class
   $(".element:last").after("<div class='element' id='div_"+ nextindex +"'></div>");

     var responseoptions='';

  responseoptions=$("#selResouces_1").html();
    
 
   // Adding element to <div>
   $("#div_" + nextindex).append('<div class="form-group row"><div class="col-sm-4"><select class="form-control selResource" name="selResouces_' + nextindex + '">'+responseoptions+'  </select></div><div class="col-sm-4"><div class="btn-group btn-group-toggle" data-toggle="buttons"><label class="btn btn-sm btn-tertiary active"><input type="radio" name="options_' + nextindex + '" id="option_row1a" checked="" value="employee"> Employee</label><label class="btn btn-sm btn-tertiary"><input type="radio" name="options_' + nextindex + '" id="option_row1b" value="supervisor"> Supervisor</label></div></div><div class="col-sm-4"><a href="javascript:void(0);" class="remove btn btn-sm" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Delete" id="remove_' + nextindex + '" ><i class="active icofont-ui-delete"></i> Delete</a><input type="hidden" value="' + nextindex + '" id="hidResourceCount" name="hidResourceCount[]"></div></div>');
  }
 
 });

 // Remove element
 $('.containerDiv').on('click','.remove',function(){
 
  var id = this.id;
  var split_id = id.split("_");
  var deleteindex = split_id[1];

  // Remove <div> with id
  $("#div_" + deleteindex).remove();

 }); 
});
function setEndDate(){
$("#enddate").val($("#startdate").val());
}
function loadPrjAddress(pid=''){
  $.ajax({
            type: "POST",
            url: "{$host_url}/index.php/projectInfoAjax/"+pid,
            success: function(result){
            var json = JSON.parse(result);
              $("#address").val(json.Address);
              $("#suburb").val(json.Suburb);
              $("#city").val(json.City);
              
            },
            error: function(data){
                console.log('error');
            }
        });
}
function chkForm(){
var error='false';
$.each($('select', '#frmAddJob'),function(k){
    console.log($(this).val());
    if($(this).val()==""){
    error= true;
    }
}); 
if( error==true){
  alert("Please select Resources");
  return false;
}else
 $('#frmAddJob').submit();
}

</script>
{include file="../common/footer.tpl"}
