{include file="../common/head.tpl"}
<section>
        <div class="container">

      {if (isset($fN_sess) && $fN_sess!="")}
         <div class="alert alert-primary alert-dismissible fade show" role="alert">
  <strong>{$fN_sess}</strong></div>
  <script>
  $(document).ready(function() {
          $(".alert-primary").slideUp(1000);
  });
</script>
{/if}

        <div class="searchBar">
        <div class="input-group mb-3 input-group-lg">
                <div class="">
            <div class="row">
                
                    <div class="col-md-2 pb5 pl5 pr5">
    {if isset($logged_in_user.UserRole) && $logged_in_user.UserRole === 'admin' || $logged_in_user.UserRole === 'superadmin'}

    <select name="Userlist" id="Userlist" class="form-control" >
    <option selected="selected" value="">All employees</option>
    {foreach $users_list as $value}
    <option value="{$value["UserId"]}" {if $curremp == $value["UserId"]} selected="selected" {/if} >{$value["FirstName"]} {$value["LastName"]}
</option> 

{/foreach} 
</select>
    {else}

    <select name="Userlist" id="Userlist" class="form-control" >
    <option  value="">Choose employees</option>
    {foreach $users_list as $value}
    {if $value["UserId"]==$logged_in_user.UserId}
    <option value="{$value["UserId"]}" {if $curremp == $value["UserId"]} selected="selected" {/if} >{$value["FirstName"]} {$value["LastName"]}
    </option> 
    {/if}
{/foreach} 
   


</select> {/if}

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
                         
              <table class="table table-hover table-responsive-sm" id="timesheetList">
                  <thead class="thead-dark">
                    <tr>
                      <th scope="col">{if $sortby=="date" && $direction=="desc"}<a href="{$host_url}/index.php/timesheet/index/{$current_page}/emp/{$curremp}/project/{$currproject}/start/{$currstartpar}/end/{$currendpar}/date/asc" class="caret">Date <i
                                                    class="icofont-caret-down"></i></a>
                                        {else if $sortby=="date" && $direction=="asc"}
                                            <a href="{$host_url}/index.php/timesheet/index/{$current_page}/emp/{$curremp}/project/{$currproject}/start/{$currstartpar}/end/{$currendpar}/date/desc" class="caret">Date <i
                                                    class="icofont-caret-up"></i></a>
                                        {else}
                                        <a href="{$host_url}/index.php/timesheet/index/{$current_page}/emp/{$curremp}/project/{$currproject}/start/{$currstartpar}/end/{$currendpar}/date/desc" class="caret">Date </a>
                                        {/if}</th>

                      <th scope="col">{if $sortby=="employee" && $direction=="desc"}<a href="{$host_url}/index.php/timesheet/index/{$current_page}/emp/{$curremp}/project/{$currproject}/start/{$currstartpar}/end/{$currendpar}/employee/asc" class="caret">Employee <i
                                                    class="icofont-caret-down"></i></a>
                                        {else if $sortby=="employee" && $direction=="asc"}
                                            <a href="{$host_url}/index.php/timesheet/index/{$current_page}/emp/{$curremp}/project/{$currproject}/start/{$currstartpar}/end/{$currendpar}/employee/desc" class="caret">Employee <i
                                                    class="icofont-caret-up"></i></a>
                                        {else}
                                        <a href="{$host_url}/index.php/timesheet/index/{$current_page}/emp/{$curremp}/project/{$currproject}/start/{$currstartpar}/end/{$currendpar}/employee/desc" class="caret">Employee </a>
                                        {/if}</th>

                      <th scope="col">{if $sortby=="project" && $direction=="desc"}<a href="{$host_url}/index.php/timesheet/index/{$current_page}/emp/{$curremp}/project/{$currproject}/start/{$currstartpar}/end/{$currendpar}/project/asc" class="caret">Project <i
                                                    class="icofont-caret-down"></i></a>
                                        {else if $sortby=="project" && $direction=="asc"}
                                            <a href="{$host_url}/index.php/timesheet/index/{$current_page}/emp/{$curremp}/project/{$currproject}/start/{$currstartpar}/end/{$currendpar}/project/desc" class="caret">Project <i
                                                    class="icofont-caret-up"></i></a>
                                        {else}
                                        <a href="{$host_url}/index.php/timesheet/index/{$current_page}/emp/{$curremp}/project/{$currproject}/start/{$currstartpar}/end/{$currendpar}/project/desc" class="caret">Project </a>
                                        {/if}</th>

                      <th scope="col">{if $sortby=="job" && $direction=="desc"}<a href="{$host_url}/index.php/timesheet/index/{$current_page}/emp/{$curremp}/project/{$currproject}/start/{$currstartpar}/end/{$currendpar}/job/asc" class="caret">Job <i
                                                    class="icofont-caret-down"></i></a>
                                        {else if $sortby=="job" && $direction=="asc"}
                                            <a href="{$host_url}/index.php/timesheet/index/{$current_page}/emp/{$curremp}/project/{$currproject}/start/{$currstartpar}/end/{$currendpar}/job/desc" class="caret">Job <i
                                                    class="icofont-caret-up"></i></a>
                                        {else}
                                        <a href="{$host_url}/index.php/timesheet/index/{$current_page}/emp/{$curremp}/project/{$currproject}/start/{$currstartpar}/end/{$currendpar}/job/desc" class="caret">Job </a>
                                        {/if}</th>

                      <th scope="col">{if $sortby=="comment" && $direction=="desc"}<a href="{$host_url}/index.php/timesheet/index/{$current_page}/emp/{$curremp}/project/{$currproject}/start/{$currstartpar}/end/{$currendpar}/comment/asc" class="caret">Comment <i
                                                    class="icofont-caret-down"></i></a>
                                        {else if $sortby=="comment" && $direction=="asc"}
                                            <a href="{$host_url}/index.php/timesheet/index/{$current_page}/emp/{$curremp}/project/{$currproject}/start/{$currstartpar}/end/{$currendpar}/comment/desc" class="caret">Comment <i
                                                    class="icofont-caret-up"></i></a>
                                        {else}
                                        <a href="{$host_url}/index.php/timesheet/index/{$current_page}/emp/{$curremp}/project/{$currproject}/start/{$currstartpar}/end/{$currendpar}/comment/desc" class="caret">Comment </a>
                                        {/if}</th>

                      <th scope="col">{if $sortby=="duration" && $direction=="desc"}<a href="{$host_url}/index.php/timesheet/index/{$current_page}/emp/{$curremp}/project/{$currproject}/start/{$currstartpar}/end/{$currendpar}/duration/asc" class="caret">Duration <i
                                                    class="icofont-caret-down"></i></a>
                                        {else if $sortby=="duration" && $direction=="asc"}
                                            <a href="{$host_url}/index.php/timesheet/index/{$current_page}/emp/{$curremp}/project/{$currproject}/start/{$currstartpar}/end/{$currendpar}/duration/desc" class="caret">Duration <i
                                                    class="icofont-caret-up"></i></a>
                                        {else}
                                        <a href="{$host_url}/index.php/timesheet/index/{$current_page}/emp/{$curremp}/project/{$currproject}/start/{$currstartpar}/end/{$currendpar}/duration/desc" class="caret">Duration </a>
                                        {/if}</th>
                      <th scope="col">Action</th>
                    </tr>
                  </thead>
                  <tbody>
                  {if $timesheet_records>0}
                  {foreach $timesheets as $timesheet}
                    {if ($preDate!=$timesheet["Date"])}
                    <!--
                    <tr><td colspan="7">{$timesheet["Date"]}</td></tr>
                    -->
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
                {else}
                <td colspan="7">No Records</td>
                {/if}
                     
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
                                <a class="page-link" href="{$url}/index/{$current_page-1}/emp/{$curremp}/project/{$currproject}/start/{$currstartpar}/end/{$currendpar}/{$sortby}/{$direction}">Previous</a>
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
                                <li class="page-item"><a class="page-link" href="{$url}/index/{$foo}/emp/{$curremp}/project/{$currproject}/start/{$currstartpar}/end/{$currendpar}/{$sortby}/{$direction}">{$foo}</a></li>
                            {/if}
                        {/for}
                        <li class="page-item {if $current_page == $number_of_pages} disabled {/if}">
                            {if $current_page == $number_of_pages}
                                <span class="page-link">Next</span>
                            {else}
                                <a class="page-link" href="{$url}/index/{$current_page+1}/emp/{$curremp}/project/{$currproject}/start/{$currstart}/end/{$currend}/{$sortby}/{$direction}">Next</a>
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