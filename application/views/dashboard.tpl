{include file="common/head.tpl"}
<section>
    {if isset($logged_in_user.UserType) && $logged_in_user.UserRole === 'admin' || $logged_in_user.UserRole === 'superadmin'}
        <div class="container main-action">
            <a href="{$host_url}/index.php/contact/contact_edit" class="btn btn-md btn-primary mr-1 p-3 mb-2 mb-md-0"><i
                    class="icofont-plus-circle"></i> Add Contact</a>
            <a href="{$host_url}/index.php/jobs/add" class="btn btn-md btn-primary mr-1 p-3 mb-2 mb-md-0"><i
                    class="icofont-plus-circle"></i> Add Job</a>
        </div>
    {/if}
    <br>
    <div class="container">
        <!--<div class="row">
            <div class="col-md-12 col-lg-12">
                <div id="calendar"></div>
            </div>
        </div>-->
        <div class="row">
            {if isset($logged_in_user.UserType) && $logged_in_user.UserRole === 'admin' || $logged_in_user.UserRole === 'superadmin'}
                <div class="col-md-8 col-lg-8">
                    
                    <div class="mainTable mt-4 p-3">
                        <div class="row">
                            <div class="col-7">
                                <h1 class="mb-3 mt-2">Today's Jobs</h1>
                            </div>
                        <div class="col-5">
                        </div>
                    </div>
                    <table class="table table-hover table-responsive-sm" id="todaysJobsList">
                        <thead class="thead-dark">
                            <tr>
                                <th scope="col">Name</th>
                                <th scope="col">StartDate</th>
                                <th scope="col">Customer</th>
                            </tr>
                        </thead>
                        <tbody>
                        {if isset($todays_job_dispatch)}
                            {foreach from=$todays_job_dispatch key=key item=value}
                                <tr>
                                    <td>
                                        {$value.DispatchName}
                                        <input type="hidden" class="link"
                                            value="/index.php/jobs/jobDispatchDetail/{$value.Id}">
                                    </td>
                                    <td>{$value.DispatchedDate}</td>
                                    <td>{if $value.ContactType == 'Organisation'}{$value.CompanyName}
                                        {else}{$value.FirstName}
                                        {$value.LastName}{/if}</td>

                                </tr>
                            {/foreach}
                        {else}
                                <tr>
                                    <td colspan="5">No jobs scheduled for today</td>
                                </tr>
                        {/if}
                        </tbody>
                    </table>
                    </div>
                    <div class="mainTable mt-4 p-3">
                        <div class="row">
                            <div class="col-7">
                                <h1 class="mb-3 mt-2">Upcoming Jobs</h1>
                            </div>
                            <div class="col-5">
                            </div>
                        </div>
                        <table class="table table-hover table-responsive-sm" id="contactList">
                            <thead class="thead-dark">
                                <tr>
                                    <th scope="col">Name</th>
                                    <th scope="col">StartDate</th>
                                    <th scope="col">Customer</th>
                                </tr>
                            </thead>
                            <tbody>
                                {if isset($upcoming_job_dispatch)}
                                    {foreach from=$upcoming_job_dispatch key=key item=value}
                                        <tr>
                                            <td>
                                                {$value.DispatchName}
                                                <input type="hidden" class="link"
                                                    value="/index.php/jobs/jobDispatchDetail/{$value.Id}">
                                            </td>
                                            <td>{$value.DispatchedDate}</td>
                                            <td>{if $value.ContactType == 'Organisation'}{$value.CompanyName}
                                                {else}{$value.FirstName}
                                                {$value.LastName}{/if}</td>

                                        </tr>
                                    {/foreach}
                                {else}
                                    <tr>
                                        <td>You do not have any active job</td>
                                    </tr>
                                {/if}
                            </tbody>
                        </table>
                    </div>
                    <div class="mainTable mt-4 p-3">
                        <div class="row">
                            <div class="col-7">
                                <h1 class="mb-3 mt-2">Recent Jobs</h1>
                            </div>
                            <div class="col-5">
                            </div>
                        </div>
                        <table class="table table-hover table-responsive-sm" id="contactList">
                            <thead class="thead-dark">
                                <tr>
                                    <th scope="col">Name</th>
                                    <th scope="col">DispatchedDate</th>
                                    <th scope="col">Total Hours</th>
                                    <th scope="col">TimeSheetStatus</th>
                                </tr>
                            </thead>
                            <tbody>
                                {if isset($recent_job_dispatch)}
                                    {foreach from=$recent_job_dispatch key=key item=value}
                                        <tr>
                                            <td>
                                                {$value.Name}
                                                <input type="hidden" class="link"
                                                    value="/index.php/jobs/jobDispatchDetail/{$value.Id}">
                                            </td>
                                            <td>{$value.DispatchedDate}</td>
                                            <td>{$value.TotalTIme}</td>
                                            <td>{$value.Result}</td>
                                        </tr>
                                    {/foreach}
                                {else}
                                    <tr>
                                        <td>No contract project added</td>
                                    </tr>
                                {/if}
                            </tbody>
                        </table>
                    </div>
                    <div class="mainTable mt-4 p-3">
                        <div class="row">
                            <div class="col-7">
                                <h1 class="mb-3 mt-2">Recent Contracts</h1>
                            </div>
                            <div class="col-5">
                                <span class="float-right mt-2"><a href="" class="">Show All</a></span>
                            </div>
                        </div>
                        <table class="table table-hover table-responsive-sm" id="contactList">
                            <thead class="thead-dark">
                                <tr>
                                    <th scope="col">Name</th>
                                    <th scope="col">Contact</th>
                                    <th scope="col">StartDate</th>
                                    <th scope="col">AgreedTime</th>
                                    <th scope="col">RemainingTime</th>
                                </tr>
                            </thead>
                            <tbody>
                                {if isset($recent_contract_jobs)}
                                    {foreach from=$recent_contract_jobs key=key item=value}
                                        <tr>
                                            <td>
                                                {$value.Name}
                                                <input type="hidden" class="link" value="/index.php/jobs/jobDetail/{$value.Id}">
                                            </td>
                                            <td>
                                                {if $value.ContactType == 'Organisation'}
                                                    {$value.CompanyName}
                                                {else}
                                                    {$value.FirstName} {$value.LastName}
                                                {/if}
                                            </td>
                                            <td>{$value.StartDate}</td>
                                            <td>{$value.ContractHours}</td>
                                            <td>{$value.TimeRemaining}</td>
                                        </tr>
                                    {/foreach}
                                {else}
                                    <tr>
                                        <td>You do not have any active job</td>
                                    </tr>
                                {/if}
                            </tbody>
                        </table>
                    </div>
                </div>
            {else}
                <div class="col-md-12 col-lg-12">
                    <div class="mainTable mt-4 p-3">
                        <div class="row">
                            <div class="col-7">
                                <h1 class="mb-3 mt-2">Upcoming jobs</h1>
                            </div>
                        </div>
                        <table class="table table-hover table-responsive-sm" id="contactList">
                            <thead class="thead-dark">
                                <tr>
                                    <th scope="col">Name</th>
                                    <th scope="col">StartDate</th>
                                    <th scope="col">Customer</th>
                                </tr>
                            </thead>
                            <tbody>
                                {if isset($upcoming_user_job_dispatch)}
                                    {foreach from=$upcoming_user_job_dispatch key=key item=value}
                                        <tr>
                                            <td>
                                                {$value.DispatchName}
                                                <input type="hidden" class="link"
                                                    value="/index.php/jobs/jobDispatchDetail/{$value.Id}">
                                            </td>
                                            <td>{$value.DispatchedDate}</td>
                                            <td>{$value.CompanyName}</td>
                                        </tr>
                                    {/foreach}
                                {else}
                                    <tr>
                                        <td>You do not have any active job</td>
                                    </tr>
                                {/if}
                            </tbody>
                        </table>
                    </div>
                </div>
            {/if}
            {if isset($logged_in_user.UserType) && $logged_in_user.UserRole === 'admin' || $logged_in_user.UserRole === 'superadmin'}
                <div class="col-md-4 col-lg-4">
                    <!--<div class="mainTable mt-4  p-3">
                        <div class="row">
                            <div class="col-7">
                                <h1 class="mb-3 mt-2">Quick View Report</h1>
                            </div>
                        </div>
                        <div class="row">
                            <p>Total Jobs:</p>
                            <p>Total Hours:</p>
                            <p>Total Contract Hours:</p>
                        </div>
                    </div>-->
                    <div class="mainTable mt-4  p-3">
                        <div class="row">
                            <div class="col-12">
                                <h1 class="mb-3 mt-2">Quick View Report</h1>
                            </div>
                            <div class="col-12 pb-2">
                                <select class="form-control form-select report_select" aria-label="Default select example">
                                    <option value="7_days" selected='selected'>Last 7 days</option>
                                    <option value="30_days">Last 30 days</option>
                                    <option value="last_month">Last Month</option>
                                    <option value="this_month">This Month</option>
                                    <option value="upcoming_week">Upcoming Week</option>
                                    <option value="upcoming_month">Upcoming Month</option>
                                </select>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col">
                                <div>
                                    <h4><span class="badge bg-light">Total Jobs:</span> <span id="report_total_jobs"></span></h4>
                                </div>
                                <div>
                                    <h4><span class="badge bg-light">Total Hours:</span> <span id="report_total_hours"></span></h4>
                                </div>
                                <div>
                                    <h4><span class="badge bg-light">Total Contract Hours:</span> <span id="report_total_contract_hours"></span></h4>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="mainTable mt-4  p-3">
                        <div class="row">
                            <div class="col-7">
                                <h1 class="mb-3 mt-2">Recent Contacts</h1>
                            </div>
                            <div class="col-5">
                                <span class="float-right mt-2"><a href="{$host_url}/index.php/contact/contact" class="">Show
                                        All</a></span>
                            </div>
                        </div>
                        <table class="table table-hover" id="contactList">
                            <tbody>
                                {foreach from=$contacts key=key item=value}
                                    <tr>
                                        <td>
                                            <h5>
                                                {if $value.ContactType == 'Organisation'}
                                                    {$value.CompanyName}
                                                {else}
                                                    {$value.FirstName} {$value.LastName}
                                                {/if}
                                                <input type="hidden" class="link"
                                                    value="/index.php/contact/contact_edit/details/{$value.Id}">
                                            </h5>
                                            <h6>
                                                {$value.Address1}, {$value.Suburb}, {$value.City}
                                            </h6>
                                            {if isset($value.Mobile) || isset($value.Phone) }
                                                <h6>
                                                    {if isset($value.Mobile)}
                                                        {$value.Mobile}
                                                    {/if}
                                                    {if isset($value.Mobile) && isset($value.Phone) }
                                                        /
                                                    {/if}
                                                    {if isset($value.Phone)}
                                                        {$value.Phone}
                                                    {/if}
                                                </h6>
                                            {/if}
                                            {if isset($value.Email)}
                                                <p class="mt-0">{$value.Email}</p>
                                            {/if}
                                        </td>
                                    </tr>
                                {{/foreach}}
                            </tbody>
                        </table>
                    </div>
                </div>
            {/if}
        </div>
    </div>
</section>
{include file="common/footer.tpl"}