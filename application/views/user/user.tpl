{include file="../common/head.tpl"}

<section>
    <div class="container">

        <div class="searchBar">
            <form class="form" method="GET" action="{$host_url}/index.php/user/user/encrypt">
                <div class="input-group mb-3 input-group-lg">
                    <input type="text" class="form-control" name="search_term" value="{$search_term}" placeholder="Search Contact Name / Email" aria-label="Recipient's username" aria-describedby="button-addon2">
                    <div class="input-group-append mr-3">
                        <button class="btn btn-secondary" type="submit" id="button-addon2"><i class="icofont-search-2"></i></button>
                    </div>
                    <a href="{$host_url}/index.php/user/user_detail" class="btn btn-md btn-primary mr-1 p-3"><i
                            class="icofont-plus-circle"></i> Add User</a>
                </div>
            </form>
        </div>
        <div class="mainTable p-3">
            <div class="row">
                <div class="col-7">
                    <h1 class="mb-1 mt-2">User Listing</h1>
                    <h6 class="pb-2">{$total_records} records found</h6>
                </div>
                <div class="col-5">
                    <div class="row">
                        <div class="col">
                            <div class="float-right mt-1">
                            {if isset($user_type) && ($user_type|@count > 0)}
                                <h6 class="mb-1">UserType:
                                {foreach from=$user_type key=key item=value}
                                    <span class="badge badge-secondary">{$value}</span>
                                {/foreach}
                                </h6>
                            {/if}
                            {if isset($user_role) && ($user_role|@count > 0)}
                                <h6 class="mb-1">UserRole:
                                {foreach from=$user_role key=key item=value}
                                    <span class="badge badge-secondary">{$value}</span>
                                {/foreach}
                                </h6>
                            {/if}
                            {if isset($is_active) && ($is_active|@count > 0)}
                                <h6 class="mb-1">Status:
                                {foreach from=$is_active key=key item=value}
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
                                    <form name="filter" method="GET"
                                        action="{$host_url}/index.php/user/user/encrypt">
                                        <input type="hidden" name="search_term" value="{$search_term}">
                                        <div class="dropdown-menu dropdownFilter dropdown-menu-right px-2">
                                            <div class="p-2">
                                                <h5>User Type:</h5>
                                                <input type="checkbox" value="Customer" name="user_type[]"
                                                    {if isset($user_type) && 'Customer'|in_array:$user_type} checked
                                                    {/if}> Customer
                                                <input type="checkbox" value="Supplier" name="user_type[]"
                                                    {if isset($user_type) && 'Supplier'|in_array:$user_type} checked
                                                    {/if}> Supplier
                                                <input type="checkbox" value="Contractor" name="user_type[]"
                                                    {if isset($user_type) && 'Contractor'|in_array:$user_type} checked
                                                    {/if}> Contractor
                                                <input type="checkbox" value="Employee" name="user_type[]"
                                                    {if isset($user_type) && 'Employee'|in_array:$user_type} checked
                                                    {/if}> Employee
                                            </div>
                                            <div class="p-2">
                                                <h5>User Role:</h5>
                                                <input type="checkbox" value="admin" name="user_role[]"
                                                    {if isset($user_role) && 'admin'|in_array:$user_role} checked
                                                    {/if}> Admin
                                                <input type="checkbox" value="supervisor" name="user_role[]"
                                                    {if isset($user_role) && 'supervisor'|in_array:$user_role}
                                                    checked {/if}> Supervisor
                                                <input type="checkbox" value="member" name="user_role[]"
                                                    {if isset($user_role) && 'member'|in_array:$user_role}
                                                    checked {/if}> Member
                                            </div>
                                            <div class="p-2">
                                                <h5>Status:</h5>
                                                <input type="checkbox" value="1" name="is_active[]"
                                                    {if isset($is_active) && '1'|in_array:$is_active} checked
                                                    {/if}> Active
                                                <input type="checkbox" value="0" name="is_active[]"
                                                    {if isset($is_active) && '0'|in_array:$is_active} checked
                                                    {/if}> Inactive
                                            </div>
                                            <div class="p-2">
                                                <input type="submit" value="Apply" class="btn btn-secondary">
                                                <a class="btn btn-light"
                                                    href="{$host_url}/index.php/user/user">Reset</a>
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
                        <th scope="col">UserName</th>
                        <th scope="col">Name</th>
                        <th scope="col">Email</th>
                        <th scope="col">Active</th>
                    </tr>
                </thead>
                <tbody>
                    {foreach from=$users key=key item=value}
                        <tr>
                            <td>
                                {$value.UserName}
                                <input type="hidden" class="link"
                                    value="{$host_url}/index.php/user/user_detail/details/{$value.UserId}">
                            </td>
                            <td>{if isset($value.FirstName)}{$value.FirstName}{/if} {if isset($value.LastName)}{$value.LastName}{/if}</td>
                            <td>{if isset($value.Email)}{$value.Email}{/if}</td>
                            <td>{if $value.Status == 1}Yes{else}No{/if}</td>
                        </tr>
                    {/foreach}
                </tbody>
            </table>
            <hr>
            {if $total_records > $limit}
                <nav aria-label="...">
                    <ul class="pagination">
                        <li class="page-item {if $current_page == 1} disabled {/if}">
                            {if $current_page == 0}
                                <span class="page-link">Previous</span>
                            {else}
                                <a class="page-link" href="{$url}/{$current_page-1}/?{$query_term}">Previous</a>
                            {/if}
                        </li>
                        {for $foo=1 to $number_of_pages}
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
                        <li class="page-item {if $current_page == $number_of_pages} disabled {/if}">
                            {if $current_page == $number_of_pages}
                                <span class="page-link">Next</span>
                            {else}
                                <a class="page-link" href="{$url}/{$current_page+1}/?{$query_term}">Next</a>
                            {/if}
                        </li>
                    </ul>
                </nav>
            {/if}
        </div>
    </div>
</section>

{include file="../common/footer.tpl"}