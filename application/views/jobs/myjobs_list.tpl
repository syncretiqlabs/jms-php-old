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
            </div>
            <table class="table table-hover table-responsive-sm" id="jobsList">
                <thead class="thead-dark">
                    <tr>
                        <th scope="col">
                        {if $sortby=="dispatchname" && $direction=="desc"}<a href="{$host_url}/index.php/jobs/myjobs/{$current_page}/dispatchname/asc?{$query_term}" class="caret">Name <i
                                                    class="icofont-caret-down"></i></a>
                                        {else if $sortby=="name" && $direction=="asc"}
                                            <a href="{$host_url}/index.php/jobs/myjobs/{$current_page}/dispatchname/desc?{$query_term}" class="caret">Name <i
                                                    class="icofont-caret-up"></i></a>
                                        {else}
                                        <a href="{$host_url}/index.php/jobs/myjobs/{$current_page}/dispatchname/desc?{$query_term}" class="caret">Name </a>
                                        {/if}
                        </th>
                        <th scope="col">
                        {if $sortby=="name" && $direction=="desc"}<a href="{$host_url}/index.php/jobs/myjobs/{$current_page}/name/asc?{$query_term}" class="caret">Job <i
                                                    class="icofont-caret-down"></i></a>
                                        {else if $sortby=="name" && $direction=="asc"}
                                            <a href="{$host_url}/index.php/jobs/myjobs/{$current_page}/name/desc?{$query_term}" class="caret">Job <i
                                                    class="icofont-caret-up"></i></a>
                                        {else}
                                        <a href="{$host_url}/index.php/jobs/myjobs/{$current_page}/name/desc?{$query_term}" class="caret">Job </a>
                                        {/if}
                        </th>
                        <th scope="col">{if $sortby=="customer" && $direction=="desc"}<a href="{$host_url}/index.php/jobs/myjobs/{$current_page}/customer/asc?{$query_term}" class="caret">Customer <i
                                                    class="icofont-caret-down"></i></a>
                                        {else if $sortby=="customer" && $direction=="asc"}
                                            <a href="{$host_url}/index.php/jobs/myjobs/{$current_page}/customer/desc?{$query_term}" class="caret">Customer <i
                                                    class="icofont-caret-up"></i></a>
                                        {else}
                                        <a href="{$host_url}/index.php/jobs/myjobs/{$current_page}/customer/desc?{$query_term}" class="caret">Customer </a>
                                        {/if} </th>
                        <th scope="col">{if $sortby=="dispatchdate" && $direction=="desc"}<a href="{$host_url}/index.php/jobs/myjobs/{$current_page}/dispatchdate/asc?{$query_term}" class="caret">Dispatch Date <i
                                                    class="icofont-caret-down"></i></a>
                                        {else if $sortby=="dispatchdate" && $direction=="asc"}
                                            <a href="{$host_url}/index.php/jobs/myjobs/{$current_page}/dispatchdate/desc?{$query_term}" class="caret">Dispatch Date <i
                                                    class="icofont-caret-up"></i></a>
                                        {else}
                                        <a href="{$host_url}/index.php/jobs/myjobs/{$current_page}/dispatchdate/desc?{$query_term}" class="caret">Dispatch Date </a>
                                        {/if}</th>
                        <th scope="col">{if $sortby=="startdate" && $direction=="desc"}<a href="{$host_url}/index.php/jobs/myjobs/{$current_page}/startdate/asc?{$query_term}" class="caret">Logged Time <i
                                                    class="icofont-caret-down"></i></a>
                                        {else if $sortby=="startdate" && $direction=="asc"}
                                        <a href="{$host_url}/index.php/jobs/myjobs/{$current_page}/startdate/desc?{$query_term}" class="caret">Logged Time <i
                                                    class="icofont-caret-up"></i></a>
                                        {else}
                                        <a href="{$host_url}/index.php/jobs/myjobs/{$current_page}/startdate/desc?{$query_term}" class="caret">Logged Time </a>
                                        {/if}</th>
                    </tr>
                </thead>
                <tbody>
                    {if count($jobs)>0}
                    {foreach $jobs as $value}
                        <tr>
                            <td>
                                {$value.DispatchName}
                                <input type="hidden" class="link"
                                    value="/index.php/jobs/jobDetail/{$value.Id}">
                            </td>
                            <td>
                                {$value.Name}
                            </td>
                            <td>{if isset($value.FirstName)}
                                    {$value.FirstName} {$value.LastName}
                                {else}
                                    {$value.CompanyName}
                                {/if}
                            </td>
                            <td>{$value.DispatchedDate}</td>
                            <td>{if isset($value.TotalTime)}{$value.TotalTime}{else}null{/if}</td>
                        </tr>
                    {/foreach}
                    {else}
                         <tr>
                            <td colspan="7">No Open Jobs Found</td></tr>
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
                                <a class="page-link" href="{$url}/{$current_page-1}/{$sortby}/{$direction}?{$query_term}">Previous</a>
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
                                <li class="page-item"><a class="page-link" href="{$url}/{$foo}/{$sortby}/{$direction}?{$query_term}">{$foo}</a></li>
                            {/if}
                        {/for}
                        <li class="page-item {if $current_page == $number_of_pages+1} disabled {/if}">
                            {if $current_page == $number_of_pages+1}
                                <span class="page-link">Next</span>
                            {else}
                                <a class="page-link" href="{$url}/{$current_page}/{$sortby}/{$direction}?{$query_term}">Next</a>
                            {/if}
                        </li>

                        <li class="page-item">
                           
                                <a class="page-link" href="{$url}/{$number_of_pages}/{$sortby}/{$direction}?{$query_term}">Last</a>
                        </li>
                    </ul>
                </nav>
            {/if}
        </div>
    </div>
</section>

{include file="../common/footer.tpl"}
