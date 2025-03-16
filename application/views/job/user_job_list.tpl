{include file="../common/head.tpl"}

<section>
    <div class="container">

         {if (isset($fN_sess) && $fN_sess!="")}
         <div class="alert alert-primary alert-dismissible fade show" role="alert">
  <strong>{$fN_sess}</strong></div>
  <script>
  $(document).ready(function() {
          $(".alert-primary").slideUp(5000);
  });
</script>
{/if}

        <h1 class="mb-1 pb-1">Jobs</h1>
         
        <div class="boxStyle p-4">
            <div class="row">
               
                <div class="col-12 rightContent">
                    <div class="tab-content" id="v-pills-tabContent">
                        <div class="tab-pane fade show " id="v-pills-home" role="tabpanel"
                            aria-labelledby="v-pills-home-tab">
                            <div class="border-bottom py-2 row">
                                <div class="col-sm-8">
                                    <h4>Basic Information</h4>
                                </div>
                                <div class="col-sm-4 text-right">

                                </div>
                            </div>


                             


                        </div>

                        <div class=" " id="v-pills-jobs active" role="tabpanel" aria-labelledby="v-pills-jobs-tab">
                            <div class="border-bottom py-2 row">
                                 
                                {if isset($logged_in_user.UserRole) && $logged_in_user.UserRole === 'admin' || $logged_in_user.UserRole === 'superadmin'}
                                <div class="col-sm-4 text-right">
                                    <a class="btn btn-sm btn-primary" href="{$host_url}/index.php/job/add/{$project.Id}" ><i class="icofont-plus-circle"></i>&nbsp; Add Job</a>
                                </div>

                                {/if}
                                

                            </div>
                            <h6 class="mt-2"> </h6>
                            <table class="table table-hover table-responsive-sm" id="jobList">
                                <thead class="thead-dark">
                                    <tr>
                                        <th scope="col">Date</a></th>

                                        <th scope="col">Job Name</th>
                                        <th scope="col">Description</th>
                                        <th scope="col">Actions</th>
                                    </tr>
                                </thead>
                                <tbody>

                                    {if isset($jobs) && count($jobs)>0}
                                        {foreach $jobs as $value}
                                        <tr>
                                            <td>{$value.JobStartDate}                            <input type="hidden" class="link" value="{$host_url}/index.php/user-view-job-detail/{$value.Id}" >
</td>
                                            <td>{$value.Name}</td>
                                            <td>{$value.Description}</td>
                                            <td><a href="{$host_url}/index.php/user-view-job-detail/{$value.Id}" class="btn btn-sm" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="View"><i class="active icofont-eye-alt"></i></a>

                                            {if isset($logged_in_user.UserRole) && $logged_in_user.UserRole === 'admin' || $logged_in_user.UserRole === 'superadmin'}
                                                <a href="{$host_url}/index.php/project-id/{$value.ProjectId}/edit/{$value.Id}" class="btn btn-sm" 
                                                    title="Edit" data-id="{$value.Id}" ><i class="active icofont-ui-edit"></i></a>
                                            {/if}       
                                            {if isset($logged_in_user.UserRole) && $logged_in_user.UserRole === 'admin' || $logged_in_user.UserRole === 'superadmin'}
                                                <a href="{$host_url}/index.php/project-id/{$value.ProjectId}/delete/{$value.Id}"><i class="active icofont-ui-delete"></i></a>
                                                 
                                            {/if}
                                            </td>
                                        </tr>
                                        {/foreach}
                                    {else}
                                        <tr>
                                            <td>No job created yet</td>
                                        </tr>
                                    {/if}
                                </tbody>
                            </table>
                        </div> 
                         
                         
                    </div>
                    {if $total_records > $limit}
                <nav aria-label="...">
                    <ul class="pagination">
                        <li class="page-item {if $current_page == 1} disabled {/if}">
                            {if $current_page == 0}
                                <span class="page-link">Previous</span>
                            {else}
                                <a class="page-link" href="{$url}/{$current_page-1}/{$sortby}/{$direction}">Previous</a>
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
                                <li class="page-item"><a class="page-link" href="{$url}/{$foo}/{$sortby}/{$direction}">{$foo}</a></li>
                            {/if}
                        {/for}
                        <li class="page-item {if $current_page == $number_of_pages} disabled {/if}">
                            {if $current_page == $number_of_pages}
                                <span class="page-link">Next</span>
                            {else}
                                <a class="page-link" href="{$url}/{$current_page+1}/{$sortby}/{$direction}">Next</a>
                            {/if}
                        </li>
                    </ul>
                </nav>
            {/if}
                </div>

            </div>
            
        </div>
    </div>
</section>
 
<script>
            $(document).ready(function() {
              $('body').on("click", ".dropdownFilter", function (e) {
                $(this).parent().is(".show") && e.stopPropagation();
                  });
                $('table#jobList tr').click(function() {
                    var link = $(this).find('.link').val();
                    window.location = link;
                }),

                $(function() {
                    $('[data-toggle="tooltip"]').tooltip()
                });
            });
    </script>


{include file="../common/footer.tpl"}
