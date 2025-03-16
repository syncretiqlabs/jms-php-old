<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="generator" content="Jekyll v4.0.1" />
    <title>Eagle Eye Limited</title>

    <!-- Bootstrap core CSS -->
    <link href="{$host_url}/css/bootstrap/bootstrap.min.css" rel="stylesheet" />
    <link href="{$host_url}/css/style.css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="{$host_url}/css/evo-calendar.css"/>
    <link rel="stylesheet" type="text/css" href="{$host_url}/css/evo-calendar.midnight-blue.css"/>

    <script src="{$host_url}/js/jquery-3.5.1.min.js"></script>


    <link rel="icon" href="{$host_url}/img/favicon.png" />
    <meta name="msapplication-config" content="/docs/4.5/assets/img/favicons/browserconfig.xml" />
    <meta name="theme-color" content="#563d7c" />
    <link href="https://fonts.googleapis.com/css2?family=Raleway:wght@300;400;500;700;800;900&display=swap"
        rel="stylesheet" />
    <link
        href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@300;400;600;700;800&family=Raleway:wght@300;400;500;700;800;900&display=swap"
        rel="stylesheet" />
    <link rel="stylesheet" href="{$host_url}/css/icofont.css" />
    <script src="{$host_url}/js/evo-calendar.js"></script>
    <!--<script src="{$host_url}/js/evo-calendar.min.js"></script>-->
</head>

<body>
    {if $active_controller != 'user_login' && $active_controller != 'reset_password'}
        <header>
            <nav class="navbar navbar-expand-lg  bg-none">
                <h5 class="navbar-brand pl-1">
                    <a href="{$host_url}/"><img src="{$host_url}/img/logo-jms-white.png" class="logo" /></a>
                </h5>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
                    aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <i class="icofont-navigation-menu"></i>
                </button>
                <input type="hidden" id="host_url" value="{$host_url}">
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <div class="mr-auto">
                        <ul class="navbar-nav main-nav">
                            <li class="nav-item mx-1">
                                <a class="p-3{if ($active_controller == 'dashboard')} active {/if}" href="{$host_url}/">Dashboard</a>
                            </li>
                            {if isset($logged_in_user.UserRole) && ($logged_in_user.UserRole === 'admin' || $logged_in_user.UserRole === 'superadmin')}
                                <li class="nav-item mx-1">
                                    <a class="p-3 {if (($active_controller == 'contact_edit') || ($active_controller == 'contact'))}active{/if}"
                                        href="{$host_url}/index.php/contact/contact">Contacts</a>
                                </li>
                                <li class="nav-item mx-1">
                                    <a class="p-3 {if (($active_controller == 'jobs') || ($active_controller == 'jobs'))}active{/if}"
                                        href="{$host_url}/index.php/jobs">Jobs</a>
                                </li>
                            {else}
                                <li class="nav-item mx-1">
                                    <a class="p-3 {if (($active_controller == 'jobs') || ($active_controller == 'jobs'))}active{/if}"
                                        href="{$host_url}/index.php/jobs/myjobs">MyJobs</a>
                                </li>
                            {/if}
                            <li class="nav-item mx-1">
                                <a class="p-3 {if (($active_controller == 'timesheet') || ($active_controller == 'timesheet'))}active{/if}"
                                    href="{$host_url}/index.php/timesheet/index/1/emp/0/project/0/start/0/end/0/date/desc">Timesheet</a>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="navbar-nav ml-md-auto userMenu">
                    <span>Welcome&nbsp;</span><a href="" class="dropdown-toggle userDropDown" id="userMenu"
                        data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"">{$username}</a>

              <div class=" dropdown-menu dropdown-menu-right" aria-labelledby="userMenu">
                    <a class="dropdown-item" href="{$host_url}/index.php/user/user_detail/details/{$userid}">Profile</a>
                    {if isset($logged_in_user.UserType) && $logged_in_user.UserRole === 'admin' || $logged_in_user.UserRole === 'superadmin'}
                        <a class="dropdown-item" href="{$host_url}/index.php/user/user">Users</a>
                    {/if}
                    <a class="dropdown-item" id="logout" href="{$login_url}">Logout</a>
                </div>
                </div>
            </nav>
        </header>
    {/if}
