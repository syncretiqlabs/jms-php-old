{include file="../common/head.tpl"}
<section>
        <div class="container">

      {$fN_sess}

        <div class="searchBar">
        <div class="input-group mb-3 input-group-lg">
                <div class="">
            <div class="row">
                
                    <div class="col-md-2 pb5 pl5 pr5">

    <select name="Userlist" id="Userlist" class="form-control">
    <option selected="selected" value="">All employees</option>
    {foreach $users_list as $value}
    <option value="{$value["UserId"]}" {if $curremp == $value["UserId"]} selected="selected" {/if} >{$value["FirstName"]} {$value["LastName"]}
</option> 
{/foreach} 

</select>

                    </div>
                

                <div class="col-md-2 pb5 pl5 pr5">
                        <select name="Projectlist" id="Projectlist" class="form-control">
    <option value="">All projects</option>
     {foreach $projects_list  as $project}

    <option value="{$project["Id"]}" {if $currproject == $project["Id"]} selected="selected" {/if} >{$project["Name"]}</option> 
                {/foreach}

</select>
                </div>

                <div class="col-md-2 pb5 pl5 pr5">
                        <input type="date" class="form-control" id="StartDate" placeholder="Date" value="{$currstart}">

                </div>
                <div class="col-md-2 pb5 pl5 pr5">
                        <input type="date" class="form-control" id="EndDate" placeholder="Date" value="{$currend}">
                </div>

                <div class="col-md-4 pb5 pl5 pr5">
                    <input type="submit" name="btnSearch" value="Search" id="btnSearch" class="bbtn btn-md btn-primary mr-1 p-3" style="margin-right: 4px"  onclick="applyFilter('filter');">
                    <input type="submit" name="btnExport" value="Export" id="btnExport" class="btn btn-md btn-primary mr-1 p-3" style="margin-right: 4px"  onclick="applyFilter('export');">

                    <input type="submit" name="createNew" value="Create new" id="btnCreate" class="btn btn-md btn-primary mr-1 p-3" style="margin-right: 4px" onclick="javascript:document.location='{$host_url}/index.php/timesheet/add'">

                </div>
            </div>
        </div>
                </div>
        </div>
          <div class="mainTable p-3">
                <div class="row">
                <div class="col-7">
                <h1 class="mb-1 mt-2">Timesheets Listing</h1>
                    </div>
                         
              <table class="table table-hover table-responsive-sm" id="contactList">
                  <thead class="thead-dark">
                    <tr>
                      <th scope="col">Date</th>
                      <th scope="col">Employee</th>
                      <th scope="col">Project</th>
                      <th scope="col">Job</th>
                      <th scope="col">Comment</th>
                      <th scope="col">Duration</th>
                      <th scope="col">Action</th>
                    </tr>
                  </thead>
                  <tbody>
                  {foreach $timesheets as $timesheet}
                    {if ($preDate!=$timesheet["Date"])}
                    <tr><td colspan="6">{$timesheet["Date"]}</td></tr>
                    {assign var="preDate" value=$timesheet['Date']}

                    {/if}
                    <tr>
                        <td>{$timesheet["Date"]}</td>
                        <td>{$timesheet["FirstName"]} {$timesheet["LastName"]}</td>
                        <td>{$timesheet["ProjectName"]}</td>
                        <td>{$timesheet["JobName"]}</td>
                        <td>{$timesheet["Notes"]}</td>
                        <td>{$timesheet["TotalTime"]}</td>
                        <td><a href="{$host_url}/index.php/timesheet/edit/{$timesheet["Id"]}"><i class="active icofont-ui-edit"></i></a> | <a href="{$host_url}/index.php/timesheet/delete/{$timesheet["Id"]}"><i class="active icofont-ui-delete"></i></a></td>
                        </tr>

                {/foreach}
                     
                  </tbody>
                </table>
                <hr>
                <hr>

            {if $total_records > $limit}
                <nav aria-label="...">
                    <ul class="pagination">
                        <li class="page-item {if $current_page == 1} disabled {/if}">
                            {if $current_page == 0}
                                <span class="page-link">Previous</span>
                            {else}
                                <a class="page-link" href="{$url}/{$current_page-1}">Previous</a>
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
                                <li class="page-item"><a class="page-link" href="{$url}/{$foo}">{$foo}</a></li>
                            {/if}
                        {/for}
                        <li class="page-item {if $current_page == $number_of_pages} disabled {/if}">
                            {if $current_page == $number_of_pages}
                                <span class="page-link">Next</span>
                            {else}
                                <a class="page-link" href="{$url}/{$current_page+1}">Next</a>
                            {/if}
                        </li>
                    </ul>
                </nav>
            {/if}
          </div>
        </div>
      </section>

<script>

function applyFilter(actions){
    valEmployee=$("#Userlist").val();
    valProject=$("#Projectlist").val();
    valStartDate=$("#StartDate").val();
    valEndDate=$("#EndDate").val();
    if(valEmployee=='')
        valEmployee=0;
    if(valProject=='')
        valProject=0;
    if(valStartDate=='')
        valStartDate=0;
    else        
        valStartDate=valStartDate.replace(/-/gi, "");
    
    if(valEndDate=='')
        valEndDate=0;
    else        
        valEndDate=valEndDate.replace(/-/gi, "");
    console.log(valEmployee,valProject,valStartDate,valEndDate);
    if(actions=='filter')
        javascript:document.location='{$host_url}/index.php/timesheet/index/1/emp/'+valEmployee+'/project/'+valProject+'/start/'+valStartDate+'/end/'+valEndDate
    else
        javascript:document.location='{$host_url}/index.php/timesheet/export/1/emp/'+valEmployee+'/project/'+valProject+'/start/'+valStartDate+'/end/'+valEndDate
}</script>


{include file="../common/footer.tpl"}