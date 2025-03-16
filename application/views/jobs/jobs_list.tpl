{include file="../common/head.tpl"}

<section>
    <div class="container">
{if (isset($fN_sess) && $fN_sess!="")}
         <div class="alert alert-primary alert-dismissible fade show" role="alert">
  <strong>{$fN_sess}</strong></div>
  <script>
  $(document).ready(function() {
          $(".alert-primary").slideUp(3000);
  });
</script>
{/if}
        <div class="searchBar">
            <form class="form" method="GET" action="{$host_url}/index.php/jobs/encrypt">
                <div class="input-group mb-3 input-group-lg">
                    <input type="text" class="form-control" name="search_term" value="{$search_term}"
                        placeholder="Search Contact Name / Email" aria-label="Recipient's username"
                        aria-describedby="button-addon2">
                    <div class="input-group-append mr-3">
                        <button class="btn btn-secondary" type="submit" id="button-addon2"><i
                                class="icofont-search-2"></i></button>
                    </div>
                    {if isset($logged_in_user.UserRole) && $logged_in_user.UserRole === 'admin' || $logged_in_user.UserRole === 'superadmin'}
                    <a href="{$host_url}/index.php/jobs/add" class="btn btn-md btn-primary mr-1 p-3"><i
                            class="icofont-plus-circle"></i> Add Jobs</a>
                    {/if}
                </div>
            </form>
        </div>
        <div class="mainTable p-3">
            <div class="row">
                <div class="col-7">
                    <h1 class="mb-1 mt-2">Jobs Listing</h1>
                    <h6 class="pb-2">{$total_records} records found</h6>
                    {if (isset($search_term) && $search_term != '')}
                        <h6 class="pb-2">search result for: {$search_term}<h6>
                    {/if}
                </div>
                <div class="col-5">
                    <div class="row">
                    <div class="col">
                        <div class="float-right mt-1">
                            {if isset($project_type) && ($project_type|@count > 0)}
                                <h6 class="mb-1">Type:
                                    {foreach from=$project_type key=key item=value}
                                        <span class="badge badge-secondary">{$value}</span>
                                    {/foreach}
                                </h6>
                            {/if}
                            {if isset($job_occurence) && ($job_occurence|@count > 0)}
                                <h6 class="mb-1">Occurence:
                                    {foreach from=$job_occurence key=key item=value}
                                        <span class="badge badge-secondary">{$value}</span>
                                    {/foreach}
                                </h6>
                            {/if}
                            {if isset($project_status) && ($project_status|@count > 0)}
                                <h6 class="mb-1">Status:
                                    {foreach from=$project_status key=key item=value}
                                        <span class="badge badge-secondary">{$value}</span>
                                    {/foreach}
                                </h6>
                            {/if}
                        </div>
                    </div>
                        <div class="col">
                            <span class="float-right mt-2">
                                <div class="dropdown">
                                    <button class="btn btn-secondary btn-md dropdown-toggle" type="button"
                                        id="dropdownFilter" data-toggle="dropdown" aria-haspopup="true"
                                        aria-expanded="false">
                                        Filter
                                    </button>
                                    <form name="filter" method="GET" action="{$host_url}/index.php/jobs/encrypt">
                                        <input type="hidden" name="search_term" value="{$search_term}">
                                        <div class="dropdown-menu dropdownFilter dropdown-menu-right px-2">
                                            <div class="p-2">
                                                <h5>Type:</h5>
                                                <input type="checkbox" id="non-contract" value="Non-Contract" name="project_type[]" {if isset($project_type) && 'Non-Contract'|in_array:$project_type} checked {/if}> 
                                                <label class="form-check-label mr-2" for="non-contract">
                                                Non-Contract
                                                </label>
                                                <input type="checkbox" id="contract" value="Contract" name="project_type[]" {if isset($project_type) && 'Contract'|in_array:$project_type} checked {/if}> 
                                                <label class="form-check-label mr-2" for="contract">
                                                Contract
                                                </label>
                                            </div>
					    <div class="p-2">
                                                <h5>Occurence:</h5>
                                                <input type="checkbox" id="onetime" value="No" name="job_occurence[]" {if isset($job_occurence) && 'No'|in_array:$job_occurence} checked {/if}> 
                                                <label class="form-check-label mr-2" for="onetime">
                                                Onetime
                                                </label>
                                                <input type="checkbox" id="recurring" value="Yes" name="job_occurence[]" {if isset($job_occurence) && 'Yes'|in_array:$job_occurence} checked {/if}> 
                                                <label class="form-check-label mr-2" for="recurring">
                                                Recurring
                                                </label>
                                            </div>
                                            <div class="p-2">
                                                <h5>Status:</h5>
                                                <input type="checkbox" id="new" value="new" name="project_status[]" {if isset($project_status) && 'new'|in_array:$project_status} checked {/if}>
                                                <label class="form-check-label mr-2" for="new">
                                                New
                                                </label>
                                                <input type="checkbox" id="inprogress" value="inprogress" name="project_status[]" {if isset($project_status) && 'inprogress'|in_array:$project_status} checked {/if}> 
                                                <label class="form-check-label mr-2" for="inprogress">
                                                InProgress
                                                </label>
                                                <input type="checkbox" id="completed" value="completed" name="project_status[]" {if isset($project_status) && 'completed'|in_array:$project_status} checked {/if}>
                                                <label class="form-check-label mr-2" for="completed">
                                                Completed
                                                </label>
                                                <input type="checkbox" id="cancelled" value="cancelled" name="project_status[]" {if isset($project_status) && 'cancelled'|in_array:$project_status} checked {/if}>
                                                <label class="form-check-label mr-2" for="cancelled">
                                                Cancelled
                                                </label>
                                            </div>
                                            <div class="p-2">
                                                <input type="submit" value="Apply" class="btn btn-secondary">
                                                <a class="btn btn-light" href="{$host_url}/index.php/jobs">Reset</a>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                        </div>
                    </div>
                    </span>
                </div>
            </div>
            <table class="table table-hover table-responsive-sm" id="jobsList">
                <thead class="thead-dark">
                    <tr>
                        <th scope="col">
                        {if $sortby=="name" && $direction=="desc"}<a href="{$host_url}/index.php/jobs/{$current_page}/name/asc?{$query_term}" class="caret">Name <i
                                                    class="icofont-caret-down"></i></a>
                                        {else if $sortby=="name" && $direction=="asc"}
                                            <a href="{$host_url}/index.php/jobs/{$current_page}/name/desc?{$query_term}" class="caret">Name <i
                                                    class="icofont-caret-up"></i></a>
                                        {else}
                                        <a href="{$host_url}/index.php/jobs/{$current_page}/name/desc?{$query_term}" class="caret">Name </a>
                                        {/if}
                        </th>
                        <th scope="col">{if $sortby=="customer" && $direction=="desc"}<a href="{$host_url}/index.php/jobs/{$current_page}/customer/asc?{$query_term}" class="caret">Customer <i
                                                    class="icofont-caret-down"></i></a>
                                        {else if $sortby=="customer" && $direction=="asc"}
                                            <a href="{$host_url}/index.php/jobs/{$current_page}/customer/desc?{$query_term}" class="caret">Customer <i
                                                    class="icofont-caret-up"></i></a>
                                        {else}
                                        <a href="{$host_url}/index.php/jobs/{$current_page}/customer/desc?{$query_term}" class="caret">Customer </a>
                                        {/if} </th>
                        <th scope="col">{if $sortby=="startdate" && $direction=="desc"}<a href="{$host_url}/index.php/jobs/{$current_page}/startdate/asc?{$query_term}" class="caret">Start Date <i
                                                    class="icofont-caret-down"></i></a>
                                        {else if $sortby=="startdate" && $direction=="asc"}
                                            <a href="{$host_url}/index.php/jobs/{$current_page}/startdate/desc?{$query_term}" class="caret">Start Date <i
                                                    class="icofont-caret-up"></i></a>
                                        {else}
                                        <a href="{$host_url}/index.php/jobs/{$current_page}/startdate/desc?{$query_term}" class="caret">Start Date </a>
                                        {/if}</th>
                        <th scope="col">{if $sortby=="enddate" && $direction=="desc"}<a href="{$host_url}/index.php/jobs/{$current_page}/enddate/asc?{$query_term}" class="caret">End Date <i
                                                    class="icofont-caret-down"></i></a>
                                        {else if $sortby=="enddate" && $direction=="asc"}
                                            <a href="{$host_url}/index.php/jobs/{$current_page}/enddate/desc?{$query_term}" class="caret">End Date <i
                                                    class="icofont-caret-up"></i></a>
                                        {else}
                                        <a href="{$host_url}/index.php/jobs/{$current_page}/enddate/desc?{$query_term}" class="caret">End Date </a>
                                        {/if}</th>
                        <th scope="col">Job Type</th>
                        <th scope="col">Status</th>
                        <th scope="col" style="width:155px">Action</th>
                    </tr>
                </thead>
                <tbody>
                    {if count($jobs)>0}
                    {foreach $jobs as $value}
                        <tr>
                            <td>
                                {$value.Name}
                                <input type="hidden" class="link"
                                    value="/index.php/jobs/jobDetail/{$value.Id}">
                            </td>
                            <td>
                                {if $value.ContactType == "People"}
                                    {$value.FirstName}{$value.LastName} <i class="icofont-user-alt-7"></i>
                                {else if $value.ContactType == "Organisation"}
                                    {$value.CompanyName} <i class="icofont-building-alt"></i>
                                {/if}
                            </td>
                            <td>{$value.StartDate}</td>
                            <td>{$value.EndDate}</td>
                            <td>
                            {if isset($value.JobType) }{$value.JobType}{/if}</td>
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
                                    {if isset($logged_in_user.UserRole) && $logged_in_user.UserRole === 'admin' || $logged_in_user.UserRole === 'superadmin'}
                                                <a href="{$host_url}/index.php/jobs/dispatched/{$value.Id}/1/date/desc" class="btn btn-sm" 
                                                    title="" data-toggle="tooltip" data-placement="bottom" data-original-title="View Job Dispatch" data-id="{$value.Id}" ><i class="active icofont-listine-dots"></i></a>

                                                <a href="{$host_url}/index.php/jobs/edit/{$value.Id}" class="btn btn-sm" 
                                                    title="" data-toggle="tooltip" data-placement="bottom" data-original-title="Edit Job"  data-id="{$value.Id}" ><i class="active icofont-ui-edit"></i></a>

                                                <a class="record_delete" data-message="Are you sure you want to delete this job? This might delete job dispatch with in this job." href="{$host_url}/index.php/jobs/delete/{$value.Id}" class="btn btn-sm" data-toggle="tooltip" data-placement="bottom" data-original-title="Delete Job"  ><i class="active icofont-ui-delete"></i></a>
                                                 
                                            {/if}
                                            </td>
                        </tr>
                    {/foreach}
                    {else}
                         <tr>
                            <td colspan="7">No Jobs Found</td></tr>
                    {/if}
                </tbody>
            </table>
            <hr>
            {if $total_records > $limit}
                <nav aria-label="...">
                    <ul class="pagination">
                        <li class="page-item">
                                <a class="page-link" href="{$url}/1/{$sortby}/{$direction}?{$query_term}">First</a>
                        </li>
                        <li class="page-item {if $current_page == 1} disabled {/if}">
                            {if $current_page == 0}
                                <span class="page-link">Previous</span>
                            {else}
                                <a class="page-link" href="{$url}/index/{$current_page-1}/{$sortby}/{$direction}?{$query_term}">Previous</a>
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
                                <li class="page-item"><a class="page-link" href="{$url}/index/{$foo}/{$sortby}/{$direction}?{$query_term}">{$foo}</a></li>
                            {/if}
                        {/for}
                        <li class="page-item {if $current_page == $number_of_pages+1} disabled {/if}">
                            {if $current_page == $number_of_pages+1}
                                <span class="page-link">Next</span>
                            {else}
                                <a class="page-link" href="{$url}/index/{$current_page}/{$sortby}/{$direction}?{$query_term}">Next</a>
                            {/if}
                        </li>

                        <li class="page-item">
                           
                                <a class="page-link" href="{$url}/index/{$number_of_pages}/{$sortby}/{$direction}?{$query_term}">Last</a>
                        </li>
                    </ul>
                </nav>
            {/if}
        </div>
    </div>
</section>

{include file="../common/footer.tpl"}
