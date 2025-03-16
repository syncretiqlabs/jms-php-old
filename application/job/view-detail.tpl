{include file="../common/head.tpl"} 

<section>
        <div class="container">

               <h1 class="mb-1 pb-1">Project: {$currproject_list.Name}</h1>
        <div class="mb-2">
        <a href="{$host_url}/index.php/project/joblist/{$projectID}"><i class="icofont-rounded-left"></i>&nbsp; Back to listing</a>
        </div>
          <div class="boxStyle p-4">
                <div class="row">
                        <div class="col-3 leftMenu">
                          {include file="./leftmenu.tpl"} 
                        </div>
                        <div class="col-9 rightContent">
                          <div class="tab-content" id="v-pills-tabContent">

                            <div class="tab-pane fade show active" id="v-pills-jobs" role="tabpanel" aria-labelledby="v-pills-jobs-tab">
                                    <div class="py-2 row">
                                        <div class="col-sm-8">
                                            <h4>{$currjobs_list.Name}</h4>
                                        </div>
                                        <div class="col-sm-4 text-right">
                                            <a class="" href="#"><i class="icofont-ui-edit"></i>&nbsp; Edit Job</a>
                                        </div>
        
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
                        <hr>
                        <div class="">
                            <h4>Timesheet</h4>
                        </div>
                        {if count($currtimesheets)>0}
                        {foreach $currtimesheets as $currtimesheet}

                        <div class="form-group row">
                                
                                <div class="col-sm-3">
                                <label for="" class="form-label text-right">Start Time</label>
                                <div class="pt-2"><h5>{$currtimesheet.StartTime}</h5></div>
                                </div>
                                <div class="col-sm-3">
                                <label for="" class="form-label text-right">End Time</label>
                                <div class="pt-2"><h5>{$currtimesheet.FinishTime}</h5></div>
                                </div>
                                <div class="col-sm-3">
                                <label for="" class="form-label text-right">Break</label>
                                <div class="pt-2"><h5>{$currtimesheet.Break}</h5></div>
                                </div>
                                <div class="col-sm-3">
                                <label for="" class="form-label text-right">Total Hours</label>
                                <div class="pt-2"><h5>{$currtimesheet.TotalTime}</h5></div>
                                </div>
                            </div>
                            {if $currtimesheet.Notes!=''}
                            <div class="form-group row">
                                <div class="col-sm-12">
                                    <label for="inputPassword" class="form-label text-right">Notes</label>
                                    <div class="pt-2"><h5>{$currtimesheet.Notes}</h5></div>
                                </div>
                            </div>
                           
                            

                             {/if}
                        
                        <hr>
                        {/foreach}
                        {else}
                            <div class="form-group row">
                                <h5>No Timesheet logged</h5>
                            </div>
                        {/if}
                        <div class="">
                            <h4>Resources:</h4>
                        </div>
                        {foreach $currjobresouces as $currjobresouce}
                        <div class="form-group row">
                            <div class="col-sm-4">
                                <div class="pt-2"><h5>John Smith</h5></div>
                            </div>
                            <div class="col-sm-3">
                                <div class="pt-2"><h5>Employee</h5></div>
                            </div>
                            <div class="col-sm-5">
                                <a href="#" class="btn btn-sm" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Delete"><i class="active icofont-ui-delete"></i> Delete</a>
                                <a class="btn btn-sm collapsed" data-toggle="collapse" href="#collapseExample" role="button" aria-expanded="false" aria-controls="collapseExample"><i class="active icofont-clock-time"></i> Add</a>
                                <a class="btn btn-sm collapsed" data-toggle="collapse" href="#collapseExample" role="button" aria-expanded="false" aria-controls="collapseExample"><i class="active icofont-clock-time"></i> Edit</a>
                            </div>
                        </div>

                        <div class="bg-light p-2 mb-1 collapse" id="collapseExample" style="">
                        <div class="row">
                                <div class="col">
                                    <div class="form-group row">
                                        <div class="col-sm-3">
                                        <label for="" class="form-label text-right">Start Time</label>
                                        <input type="time" class="form-control" id="startdate" placeholder="Time">
                                        </div>
                                        <div class="col-sm-3">
                                        <label for="" class="form-label text-right">End Time</label>
                                        <input type="time" class="form-control" id="enddate" placeholder="Time">
                                        </div>
                                        <div class="col-sm-3">
                                        <label for="" class="form-label text-right">Break</label>
                                        <select class="form-control" id="exampleFormControlSelect1">
                                        <option>0.25</option>
                                        <option>0.50</option>
                                        <option>0.75</option>
                                        </select>
                                        </div>
                                        <div class="col-sm-3">
                                        <label for="" class="form-label text-right">Hours</label>
                                        <select class="form-control" id="exampleFormControlSelect1">
                                        <option>0.25</option>
                                        <option>0.50</option>
                                        <option>0.75</option>
                                        </select>
                                        </div>
                                        </div>
                                        <div class="form-group row">
                                            <div class="col-sm-12">
                                                <label for="inputPassword" class="form-label text-right">Notes</label>
                                                <textarea class="form-control" id="job_desc" rows="3" placeholder="Description"></textarea>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <div class="col-sm-12">
                                            <button type="button" class="btn btn-secondary mr-2">Cancel</button>
                                            <button type="button" class="btn btn-primary">Save</button>
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
                                                <div class="mr-auto">
                                                <div class="form-group">
                                                <h6>Upload Docuents</h6>
                                                <input type="file" class="form-control-file" id="exampleFormControlFile1">
                                                </div>
                                                </div>
                
                                    </div>
                                </div>
                            </div>
                        <div>
    
                    <table class="table table-hover table-responsive-sm" id="contactList">
                            <thead class="thead-dark">
                                <tr>
                                <th scope="col">Date Uploaded</th>
                                <th scope="col">Document Name <a href="#" class="caret"><i class="icofont-caret-down"></i></a></th>
                                <th scope="col">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>30/09/2021</td>
                                    <td>documentOne.pdf</td>
                                    <td>
                                        <a href="#" class="btn btn-sm" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="View"><i class="active icofont-eye-alt"></i></a>
                                        <a href="#" class="btn btn-sm" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Delete"><i class="active icofont-ui-delete"></i></a>
                                </td>
                            </tr>
                            <tr>
                                    <td>30/09/2021</td>
                                    <td>documentOne.pdf</td>
                                    <td>
                                        <a href="#" class="btn btn-sm" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="View"><i class="active icofont-eye-alt"></i></a>
                                        <a href="#" class="btn btn-sm" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Delete"><i class="active icofont-ui-delete"></i></a>
                                    </td>
                                </tr>
                                <tr>
                                    <td>30/09/2021</td>
                                    <td>documentOne.pdf</td>
                                    <td>
                                        <a href="#" class="btn btn-sm" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="View"><i class="active icofont-eye-alt"></i></a>
                                        <a href="#" class="btn btn-sm" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Delete"><i class="active icofont-ui-delete"></i></a>
                                    </td>
                                </tr>
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
{include file="../common/footer.tpl"}