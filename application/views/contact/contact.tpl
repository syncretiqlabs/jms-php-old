{include file="../common/head.tpl"}

<section>
    <div class="container">

        <div class="searchBar">
            <form class="form" method="GET" action="{$host_url}/index.php/contact/contact/encrypt">
                <div class="input-group mb-3 input-group-lg">
                    <input type="text" class="form-control" name="search_term" value="{$search_term}"
                        placeholder="Search Contact Name / Email" aria-label="Recipient's username"
                        aria-describedby="button-addon2">
                    <div class="input-group-append mr-3">
                        <button class="btn btn-secondary" type="submit" id="button-addon2"><i
                                class="icofont-search-2"></i></button>
                    </div>
                    {* <a href="#" class="clear_search btn btn-md btn-primary mr-1 p-3"><i class="icofont-plus-circle"></i></a> *}
                    <a href="{$host_url}/index.php/contact/contact_edit" class="btn btn-md btn-primary mr-1 p-3"><i
                            class="icofont-plus-circle"></i> Add Contacts</a>
                </div>
            </form>
        </div>
        <div class="mainTable p-3">
            <div class="row">
                <div class="col-7">
                    <h1 class="mb-1 mt-2">Contact Listing</h1>
                    <h6 class="pb-2">{$total_records} records found</h6>
                    {if (isset($search_term) && $search_term != '')}
                        <h6 class="pb-2">search result for: {$search_term}<h6>
                            {/if}

                </div>
                <div class="col-5">
                    <div class="row">
                        <div class="col">
                            <div class="float-right mt-1">
                                {if isset($category) && ($category|@count > 0)}
                                    <h6 class="mb-1">Category:
                                        {foreach from=$category key=key item=value}
                                            <span class="badge badge-secondary">{$value}</span>
                                        {/foreach}
                                    </h6>
                                {/if}
                                {if isset($contact_type) && ($contact_type|@count > 0)}
                                    <h6 class="mb-1">ContactType:
                                        {foreach from=$contact_type key=key item=value}
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
                                    <button class="btn mb-1 btn-secondary btn-md dropdown-toggle" type="button"
                                        data-toggle="dropdown" id="dropdownFilter" aria-haspopup="true"
                                        aria-expanded="false">
                                        Filter
                                    </button>
                                    <form name="filter" method="GET"
                                        action="{$host_url}/index.php/contact/contact/encrypt">
                                        <input type="hidden" name="search_term" value="{$search_term}">
                                        <div class="dropdown-menu dropdownFilter dropdown-menu-right px-2">
                                            <div class="p-2">
                                                <h5>Category:</h5>
                                                <input type="checkbox" id="checkCustomer" value="Customer" name="category[]"
                                                    {if isset($category) && 'Customer'|in_array:$category} checked
                                                    {/if}>
                                                <label class="form-check-label mr-2" for="checkCustomer">   
                                                Customer
                                                </label>
                                                <input type="checkbox" id="checkSupplier" name="category[]"
                                                    {if isset($category) && 'Supplier'|in_array:$category} checked
                                                    {/if}>
                                                <label class="form-check-label mr-2" for="checkSupplier">  
                                                Supplier
                                                </label>
                                                <input type="checkbox" id="checkEmployee" value="Employee" name="category[]"
                                                    {if isset($category) && 'Employee'|in_array:$category} checked
                                                    {/if}>
                                                <label class="form-check-label mr-2" for="checkEmployee">
                                                Employee
                                                </label>
                                            </div>
                                            <div class="p-2">
                                                <h5>Type:</h5>
                                                <input type="checkbox" id="checkPeople" value="People" name="contact_type[]"
                                                    {if isset($contact_type) && 'People'|in_array:$contact_type} checked
                                                    {/if}>
                                                <label class="form-check-label mr-2" for="checkPeople">
                                                People
                                                </label>
                                                <input type="checkbox" id="checkOrganisation" value="Organisation" name="contact_type[]"
                                                    {if isset($contact_type) && 'Organisation'|in_array:$contact_type}
                                                    checked {/if}>
                                                <label class="form-check-label mr-2" for="checkOrganisation">
                                                Organisation
                                                </label>
                                            </div>
                                            <div class="p-2">
                                                <h5>Status:</h5>
                                                <input type="checkbox" id="checkActive" value="1" name="is_active[]"
                                                    {if isset($is_active) && '1'|in_array:$is_active} checked {/if}>
                                                <label class="form-check-label mr-2" for="checkActive">
                                                Active
                                                </label>
                                                <input type="checkbox" id="checkInactive" value="0" name="is_active[]"
                                                    {if isset($is_active) && '0'|in_array:$is_active} checked {/if}>
                                                <label class="form-check-label mr-2" for="checkInactive">
                                                Inactive
                                                </label>
                                            </div>
                                            <div class="p-2">
                                                <input type="submit" value="Apply" class="btn btn-secondary">
                                                <a class="btn btn-light"
                                                    href="{$host_url}/index.php/contact/contact">Reset</a>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </span>
                        </div>
                    </div>
                </div>
            </div>
            <table class="table table-hover table-responsive-sm tableList" id="contactList">
                <thead class="thead-dark">
                    <tr>
                        <th scope="col">&nbsp;</th>
                        <th scope="col">Name <a href="#" class="caret"><i class="icofont-caret-down"></i></a></th>
                        <th scope="col">Email</th>
                        <th scope="col">Status</th>
                    </tr>
                </thead>
                <tbody>
                    {foreach from=$contacts key=key item=value}
                        <tr>
                            <td>
                                {if $value.ContactType == 'Organisation'}
                                    <i class="icofont-building-alt"></i>
                                {else}
                                    <i class="icofont-user-alt-7"></i>
                                {/if}
                                <input type="hidden" class="link"
                                    value="{$host_url}/index.php/contact/contact_edit/details/{$value.Id}">
                            </td>
                            <td>
                                {if $value.ContactType == 'Organisation'}
                                    {$value.CompanyName}
                                {else}
                                    {$value.FirstName} {$value.LastName}
                                {/if}
                            </td>
                            <td>{$value.Email}</td>
                            <td>
                                {if $value.IsActive}
                                    <i class="active icofont-check-circled" data-toggle="tooltip" data-placement="bottom"
                                        title="Active"></i>
                                {else}
                                    <i class="inactive icofont-check-circled" data-toggle="tooltip" data-placement="bottom"
                                        title="" data-original-title="Inactive"></i>
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
                                <a class="page-link" href="{$url}/{$current_page-1}?{$query_term}">Previous</a>
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
                                <li class="page-item"><a class="page-link" href="{$url}/{$foo}?{$query_term}">{$foo}</a></li>
                            {/if}
                        {/for}
                        <li class="page-item {if $current_page == $number_of_pages} disabled {/if}">
                            {if $current_page == $number_of_pages}
                                <span class="page-link">Next</span>
                            {else}
                                <a class="page-link" href="{$url}/{$current_page+1}/?{$query_term}">Next</a>
                            {/if}
                        </li>

                        <li class="page-item">
                            <a class="page-link" href="{$url}/{$number_of_pages}/?{$query_term}">Last</a>
                        </li>
                    </ul>
                </nav>
            {/if}
        </div>
    </div>
</section>

{include file="../common/footer.tpl"}