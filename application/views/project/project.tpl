{include file="../common/head.tpl"}

<section>
    <div class="container">

        <div class="searchBar">
            <form class="form" method="GET" action="{$host_url}/index.php/project/project/encrypt">
                <div class="input-group mb-3 input-group-lg">
                    <input type="text" class="form-control" name="search_term" value="{$search_term}"
                        placeholder="Search Contact Name / Email" aria-label="Recipient's username"
                        aria-describedby="button-addon2">
                    <div class="input-group-append mr-3">
                        <button class="btn btn-secondary" type="submit" id="button-addon2"><i
                                class="icofont-search-2"></i></button>
                    </div>
                     
                    <a href="{$host_url}/index.php/project/project_detail/editProject" class="btn btn-md btn-primary mr-1 p-3"><i
                            class="icofont-plus-circle"></i> Add Projects</a>
                </div>
            </form>
        </div>
        <div class="mainTable p-3">
            <div class="row">
                <div class="col-7">
                    <h1 class="mb-1 mt-2">Project Listing</h1>
                    <h6 class="pb-2">{$total_records} records found</h6>
                    {if (isset($search_term) && $search_term != '')}
                        <h6 class="pb-2">search result for: {$search_term}<h6>
                    {/if}
                </div>
                <div class="col-5">
                    <div class="row">
                        <div class="col">

                            <span class="float-right mt-2">
                                <div class="dropdown">
                                    <button class="btn btn-secondary btn-md dropdown-toggle" type="button"
                                        id="dropdownFilter" data-toggle="dropdown" aria-haspopup="true"
                                        aria-expanded="false">
                                        Filter
                                    </button>
                                    <form name="filter" method="GET" action="{$host_url}/index.php/project/project/encrypt">
                                        <input type="hidden" name="search_term" value="{$search_term}">
                                        <div class="dropdown-menu dropdownFilter dropdown-menu-right px-2">
                                            <div class="p-2">
                                                Type:<br>
                                                <input type="checkbox" value="onetime" name="project_type[]" {if isset($project_type) && 'onetime'|in_array:$project_type} checked {/if}>Onetime
                                                <input type="checkbox" value="contract" name="project_type[]" {if isset($project_type) && 'contract'|in_array:$project_type} checked {/if}>Contract
                                            </div>
                                            <div class="p-2">
                                                Status:<br>
                                                <input type="checkbox" value="new" name="project_status[]" {if isset($contact_type) && 'new'|in_array:$contact_type} checked {/if}>New
                                                <input type="checkbox" value="inprogress" name="project_status[]" {if isset($contact_type) && 'inprogress'|in_array:$contact_type} checked {/if}>InProgress
                                                <input type="checkbox" value="completed" name="project_status[]" {if isset($contact_type) && 'completed'|in_array:$contact_type} checked {/if}>Completed
                                                <input type="checkbox" value="approved" name="project_status[]" {if isset($contact_type) && 'approved'|in_array:$contact_type} checked {/if}>Approved
                                            </div>
                                            <div class="p-2">
                                                <input type="submit" value="Apply" class="btn btn-secondary">
                                                <a class="btn btn-light" href="http://jms.syncretiq.com/index.php/project/project">Reset</a>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                        </div>
                    </div>
                    </span>
                </div>
            </div>
            <table class="table table-hover table-responsive-sm" id="contactList">
                <thead class="thead-dark">
                    <tr>
                        <th scope="col">Name</th>
                        <th scope="col">Customer </th>
                        <th scope="col">Start Date</th>
                        <th scope="col">End Date</th>
                        <th scope="col">Status</th>
                    </tr>
                </thead>
                <tbody>
                    {foreach from=$projects key=key item=value}
                        <tr>
                            <td>
                                {$value.Name}
                                <input type="hidden" class="link"
                                    value="/index.php/project/project_detail/index/{$value.Id}">
                            </td>
                            <td>{if isset($value.CompanyName)}{$value.CompanyName}
                            {elseif isset($value.FirstName)}{$value.FirstName}
                                {$value.LastName}{/if}</td>
                            <td>{$value.StartDate}</td>
                            <td>{$value.EndDate}</td>
                            <td>
                                {if isset($value.Status) && ($value.Status == 'New')}
                                    <i class="active icofont-star" data-toggle="tooltip" data-placement="bottom" title=""
                                        data-original-title="New"></i>
                                {else if isset($value.Status) && ($value.Status == 'InProgress')}
                                    <i class="active icofont-refresh" data-toggle="tooltip" data-placement="bottom" title=""
                                        data-original-title="In progress"></i>
                                {else if isset($value.Status) && ($value.Status == 'Completed')}
                                    <i class="active icofont-check-circled " data-toggle="tooltip" data-placement="bottom"
                                        title="" data-original-title="Completed"></i>
                                {else if isset($value.Status) && ($value.Status == 'Archive')}
                                    <i class="active icofont-archive" data-toggle="tooltip" data-placement="bottom" title=""
                                        data-original-title="Archived"></i>
                                {else}
                                    <i class="active icofont-star" data-toggle="tooltip" data-placement="bottom" title=""
                                        data-original-title="New"></i>
                                {/if}
                            </td>
                        </tr>
                    {/foreach}
                </tbody>
            </table>
            <hr>
            {if $total_records > $limit}
                <nav aria-label="...">
                    <ul class="pagination">
                        <li class="page-item">
                                <a class="page-link" href="{$url}/1/?{$query_term}">First</a>
                        </li>
                        <li class="page-item {if $current_page == 1} disabled {/if}">
                            {if $current_page == 0}
                                <span class="page-link">Previous</span>
                            {else}
                                <a class="page-link" href="{$url}/{$current_page-1}/?{$query_term}">Previous</a>
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
                                <li class="page-item"><a class="page-link" href="{$url}/{$foo}/?{$query_term}">{$foo}</a></li>
                            {/if}
                        {/for}
                        <li class="page-item {if $current_page == $number_of_pages+1} disabled {/if}">
                            {if $current_page == $number_of_pages+1}
                                <span class="page-link">Next</span>
                            {else}
                                <a class="page-link" href="{$url}/{$current_page+1}/?{$query_term}">Next</a>
                            {/if}
                        </li>

                        <li class="page-item">
                           
                                <a class="page-link" href="{$url}/{$number_of_pages+1}/?{$query_term}">Last</a>
                        </li>
                    </ul>
                </nav>
            {/if}
        </div>
    </div>
</section>

{include file="../common/footer.tpl"}