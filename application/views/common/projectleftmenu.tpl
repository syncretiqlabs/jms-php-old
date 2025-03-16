{if isset($logged_in_user.UserRole) && $logged_in_user.UserRole === 'admin' || $logged_in_user.UserRole === 'superadmin'}
{if isset($job.Id)}

<div class="nav flex-column nav-pills" id="v-pills-tab" role="tablist" aria-orientation="vertical">
                        <a class="nav-link {if isset($currentmenu) && $currentmenu=="basic"} active {/if}" id="v-pills-home-tab" href="{$host_url}/index.php/jobs/jobDetail/{if isset($job.Id)}{$job.Id}{/if}"
                            role="tab" aria-controls="v-pills-home" aria-selected="true">Basic Information</a>
                        <a class="nav-link {if isset($currentmenu) && $currentmenu=="jobs"} active {/if}" id="v-pills-jobs-tab"  href="{$host_url}/index.php/jobs/dispatched/{if isset($job.Id)}{$job.Id}{/if}/1/date/desc" role="tab"
                            aria-controls="v-pills-jobs" aria-selected="false">Dispatched Jobs</a>
                      
                    </div>
{else}
<div class="nav flex-column nav-pills" id="v-pills-tab" role="tablist" aria-orientation="vertical">
                        <a class="nav-link active" id="v-pills-home-tab" href="#"
                            role="tab" aria-controls="v-pills-home" aria-selected="true">Basic Information</a>
                        <a class="nav-link extra_tabs nav-link disabled" id="v-pills-jobs-tab"  href="#" role="tab"
                            aria-controls="v-pills-jobs" aria-selected="false">Jobs</a>
                      
</div>
{/if}
{else}



{if isset($job.Id)}

<div class="nav flex-column nav-pills" id="v-pills-tab" role="tablist" aria-orientation="vertical">
                        <a class="nav-link {if isset($currentmenu) && $currentmenu=="basic"} active {/if}" id="v-pills-home-tab" href="{$host_url}/index.php/jobs/jobDetail/{if isset($job.Id)}{$job.Id}{/if}"
                            role="tab" aria-controls="v-pills-home" aria-selected="true">Basic Information</a>
                        <a class="nav-link {if isset($currentmenu) && $currentmenu=="jobs"} active {/if}" id="v-pills-jobs-tab"  href="{$host_url}/index.php/jobs/dispatched/{if isset($job.Id)}{$job.Id}{/if}/1/date/desc" role="tab"
                            aria-controls="v-pills-jobs" aria-selected="false">Dispatched Jobs</a>
                        
                    </div>
{else}
<div class="nav flex-column nav-pills" id="v-pills-tab" role="tablist" aria-orientation="vertical">
                        <a class="nav-link active" id="v-pills-home-tab" href="#"
                            role="tab" aria-controls="v-pills-home" aria-selected="true">Basic Information</a>
                        <a class="nav-link extra_tabs nav-link disabled" id="v-pills-jobs-tab"  href="#" role="tab"
                            aria-controls="v-pills-jobs" aria-selected="false">Jobs</a>
                         
</div>
{/if}
{/if}
