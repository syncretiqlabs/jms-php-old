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
        {if isset($job_details.Name)}
            <h1 class="mb-1 pb-1">{$job_details.Name}</h1>
        {/if}
        <div class="mb-2">
            <a href="{$host_url}/index.php/jobs/jobDetail/{$currentjob}"><i class="icofont-rounded-left"></i>&nbsp; Back
                to Jobs Details</a>

            <div class="mainTable p-3">
                <div class="row">
                    <div class="col-7">
                        <h1 class="mb-1 mt-2">Job Dispatch Listing</h1>
                        <h6 class="pb-2">{$total_records} records found</h6>
                        {if (isset($search_term) && $search_term != '')}
                            <h6 class="pb-2">search result for: {$search_term}<h6>
                                {/if}
                    </div>
                    <div class="col-5">
                        <a href="javascript:void(0);" onclick="javascript:$('#adhoc_job_despatch').modal('show');"
                            class="btn btn-md btn-primary mr-1 p-3" style="float: right;">
                            <i class="icofont-plus-circle"></i> Adhoc JobDispatch</a>
                    </div>
                </div>
                <table class="table table-hover table-responsive-sm" id="jobsList">
                    <thead class="thead-dark">
                        <tr>
                            <th scope="col">
                                {if $sortby=="name" && $direction=="desc"}<a
                                        href="{$host_url}/index.php/jobs/dispatched/{$currentjob}/{$current_page}/name/asc"
                                        class="caret">Name <i class="icofont-caret-down"></i></a>
                                {else if $sortby=="name" && $direction=="asc"}
                                    <a href="{$host_url}/index.php/jobs/dispatched/{$currentjob}/{$current_page}/name/desc"
                                        class="caret">Name <i class="icofont-caret-up"></i></a>
                                {else}
                                    <a href="{$host_url}/index.php/jobs/dispatched/{$currentjob}/{$current_page}/name/desc"
                                        class="caret">Name </a>
                                {/if}
                            </th>

                            <!--<th scope="col">Resource</th>-->

                            <th scope="col">{if $sortby=="date" && $direction=="desc"}<a
                                        href="{$host_url}/index.php/jobs/dispatched/{$currentjob}/{$current_page}/date/asc"
                                        class="caret">Job Dispatched Date <i class="icofont-caret-down"></i></a>
                                {else if $sortby=="date" && $direction=="asc"}
                                    <a href="{$host_url}/index.php/jobs/dispatched/{$currentjob}/{$current_page}/date/desc"
                                        class="caret">Job Dispatched Date <i class="icofont-caret-up"></i></a>
                                {else}
                                    <a href="{$host_url}/index.php/jobs/dispatched/{$currentjob}/{$current_page}/date/desc"
                                        class="caret">Job Dispatched Date </a>
                                {/if}
                            </th>

                            <th scope="col">Status</th>
                            <th scope="col" width="100">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        {if count($jobs)>0}
                            {foreach $jobs as $value}
                                <tr>
                                    <td>
                                        {$value.DispatchName}
                                        <input type="hidden" class="link" value="/index.php/jobs/jobDispatchDetail/{$value.Id}">
                                    </td>

                                    <!--<td> </td>-->
                                    <td>{$value.DispatchedDate}</td>
                                    <td>
                                        {if isset($value.Status) && ($value.Status == 'new')}
                                            <i class="active icofont-star" data-toggle="tooltip" data-placement="bottom" title=""
                                                data-original-title="New"></i>
                                        {else if isset($value.Status) && ($value.Status == 'inprogress')}
                                            <i class="active icofont-refresh" data-toggle="tooltip" data-placement="bottom" title=""
                                                data-original-title="In progress"></i>
                                        {else if isset($value.Status) && ($value.Status == 'completed')}
                                            <i class="active icofont-check-circled " data-toggle="tooltip" data-placement="bottom"
                                                title="" data-original-title="Completed"></i>
                                        {else if isset($value.Status) && ($value.Status == 'approved')}
                                            <i class="active icofont-archive" data-toggle="tooltip" data-placement="bottom" title=""
                                                data-original-title="Approved"></i>
                                        {else}
                                            <i class="active icofont-star" data-toggle="tooltip" data-placement="bottom" title=""
                                                data-original-title="New"></i>
                                        {/if}
                                    </td>

                                    <td>
                                    <!-- <a href="{$host_url}/index.php/jobs/jobDispatchDetail/{$value.Id}" class="btn btn-sm"
                                            data-toggle="tooltip" data-placement="bottom" title="" data-original-title="View"><i
                                                class="active icofont-eye-alt"></i></a> -->

                                        {if isset($logged_in_user.UserRole) && $logged_in_user.UserRole === 'admin' || $logged_in_user.UserRole === 'superadmin'}
                                            <!--<a href="{$host_url}/index.php/jobs/jobDispatchedDateEdit/{$value.Id}" class="btn btn-sm" 
                                                    title="Edit" data-id="{$value.Id}" ><i class="active icofont-ui-edit"></i></a>-->
                                        {/if}
                                        {if isset($logged_in_user.UserRole) && $logged_in_user.UserRole === 'admin' || $logged_in_user.UserRole === 'superadmin'}
                                            <a class="record_delete" data-message="Are you sure you want to delete {$value.DispatchName}? 
Please note that if this job dispatch is deleted all the associated TimeSheet entries will also be deleted." href="{$host_url}/index.php/jobs/jobDispatchDateDelete/{$value.Id}/{$currentjob}/{$current_page}"><i class="active icofont-ui-delete"></i></a>
                                        {/if}
                                    </td>
                                </tr>
                            {/foreach}
                        {else}
                            <tr>
                                <td colspan="7">No Jobs Found</td>
                            </tr>
                        {/if}
                    </tbody>
                </table>

            </div>
            {if $total_records > $limit}
                <nav aria-label="...">
                    <ul class="pagination">
                        <li class="page-item">
                            <a class="page-link"
                                href="{$url}/{$currentjob}/1/{$sortby}/{$direction}?{$query_term}">First</a>
                        </li>
                        <li class="page-item {if $current_page == 1} disabled {/if}">
                            {if $current_page == 0}
                                <span class="page-link">Previous</span>
                            {else}
                                <a class="page-link"
                                    href="{$url}/{$currentjob}/{$current_page-1}/{$sortby}/{$direction}?{$query_term}">Previous</a>
                            {/if}
                        </li>
                        {for $foo=1 to $number_of_pages+1}
                            {if $current_page == $foo}
                                <li class="page-item active" aria-current="page">
                                    <span class="page-link">
                                        {$foo}
                                        <span class="sr-only">(current)</span>
                                    </span>
                                </li>
                            {else}
                                <li class="page-item"><a class="page-link"
                                        href="{$url}/{$currentjob}/{$foo}/{$sortby}/{$direction}?{$query_term}">{$foo}</a></li>
                            {/if}
                        {/for}
                        <li class="page-item {if $current_page == $number_of_pages+1} disabled {/if}">
                            {if $current_page == $number_of_pages+1}
                                <span class="page-link">Next</span>
                            {else}
                                <a class="page-link"
                                    href="{$url}/{$currentjob}/{$current_page}/{$sortby}/{$direction}?{$query_term}">Next</a>
                            {/if}
                        </li>

                        <li class="page-item">

                            <a class="page-link"
                                href="{$url}/{$currentjob}/{$number_of_pages}/{$sortby}/{$direction}?{$query_term}">Last</a>
                        </li>
                    </ul>
                </nav>
            {/if}
        </div>
    </div>
</section>


<div class="modal fade" id="adhoc_job_despatch" tabindex="-1" aria-labelledby="exampleModalLabelq" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Add Job Dispatch</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="tab-pane fade show active" id="v-pills-home" role="tabpanel"
                    aria-labelledby="v-pills-home-tab">
                    <h4 class="pb-4"></h4>
                    <form method="post" class="adhoc_job_dispatch" action="{$host_url}/index.php/jobs/addAdhocJobDispatch">
                        <input type="hidden" name="JobId" class="jobid" value="{$currentjob}">
                        <input type="hidden" name="JobName" class="JobName" value="{$job_details.Name}">
                        <input type="hidden" name="selBilling" class="selBilling" value="{$job_details.BillingType}">
                        <input type="hidden" name="resource_count" class="resource_count" value="">
                        <div class="form-group row">
                            <label for="" class="col-sm-3 col-form-label text-right">Date</label>
                            <div class="col-sm-9">
                                <input type="date" class="form-control date" id="date" name="date">
                            </div>
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

                                    <div class="col-sm-4" style="display: none;">
                                        <div class="btn-group btn-group-toggle" data-toggle="buttons">
                                            <label class="btn btn-sm btn-tertiary active">
                                                <input type="radio" name="options_1" id="option_row1a" checked=""
                                                    value="Employee"> Employee
                                            </label>
                                            <label class="btn btn-sm btn-tertiary">
                                                <input type="radio" name="options_1" id="option_row1b"
                                                    value="Supervisor"> Supervisor
                                            </label>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <a href="javascript:void(0);" class="remove btn btn-sm" data-toggle="tooltip"
                                            data-placement="bottom" title="" data-original-title="Delete"
                                            id="remove_1"><i class="active icofont-ui-delete"></i> Delete</a><input
                                            type="hidden" value="1" id="hidResourceCount" name="hidResourceCount[]">

                                    </div>
                                </div>
                            </div>
                        </div>
                        <div>
                            <button type="button" class="btn btn-outline-secondary addDiv"><i
                                    class="icofont-plus-circle"></i>Add Name</button>
                        </div>

                        <div class="form-group row">
                            <label for="" class="col-sm-3 col-form-label text-right"></label>
                            <div class="col-sm-9">
                                <button type="submit" name="button"
                                    value="submit_general" class="btn btn-lg btn-primary">Save</button>
                                <button type="button" class="btn btn-lg btn-secondary"
                                    onclick="javascript:$('#adhoc_job_despatch').modal('hide');">Cancel</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {
        $('.delete_dispatch').on('click', function(e){
            var href = $(this).attr('href');
            var link = window.location.href;
            if (confirm('Are you sure you want to delete this job dispatch?')) {
                $.ajax({
                    method: 'post',
                    dataType: 'json',
                    url: href,
                    success: function(result) {
                        console.log(link);
                    }
                });
                window.location = link;
            } else {
                return false;
            }
            e.preventDefault();
        });

        $('.resource_count').val($('.element').length);



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
                $("#div_" + nextindex).append('<div class="form-group row"><div class="col-sm-4"><select class="form-control selResource" name="selResouces_' + nextindex + '">'+responseoptions+'  </select></div><div class="col-sm-4"><a href="javascript:void(0);" class="remove btn btn-sm" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Delete" id="remove_' + nextindex + '" ><i class="active icofont-ui-delete"></i> Delete</a><input type="hidden" value="' + nextindex + '" id="hidResourceCount" name="hidResourceCount[]"></div></div>');
            }

            $('.resource_count').val($('.element').length);
        });

        $('.submit_general').click(function() {
            var job_id = $('.adhoc_job_dispatch').find('.jobid').val();
            var date = $('.adhoc_job_dispatch').find('.date').val();
            var total_resources = $('.element').length;
            console.log(total_resources);
            var resource = [];
            var role = [];
            var combination = [];
            for ( var i = 0; i < total_resources; i++ ) {
                var j = i+1;
                var resources = $("select[name=selResouces_" + j + "] option:selected").val();
                var roles = $("input[name='options_" + j + "']:checked").val();
                combination[resources] = roles;
            }
            /*var get_val = '';
            get_val += 'jobid=' + job_id + '&';
            get_val += 'date=' + date;
            get_val += 'resource=' + JSON.stringify(combination);

            console.log(get_val);
*/
            $.ajax({
                type: "POST",
                data: {
                    job_id: job_id,
                    date: date,
                    resource: JSON.stringify(combination)
                },
                method: 'post',
                dataType: 'json',
                url: "{$host_url}/index.php/jobs/addAdhocJobDispatch",
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
        });
    })

</script>

{include file="../common/footer.tpl"}