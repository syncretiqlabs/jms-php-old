{include file='../common/head.tpl'}

<div class="container">
    <div class="row">
        <div class="col-12 col-md-12 col-lg-6 offset-lg-3 offset-0 ">
            <div class="logo-login text-center my-4">
                <img src="{$host_url}/img/logo-eagle-eye.png" />
            </div>
            <div class="form-signin p-5 rounded-3">
            {if isset($template) && ($template == new_password_form)}
                {if isset($template_error)}
                        <h1 class="h3 mb-3 font-weight-normal">Error</h1>
                        <span>{$template_error}</span>
                        
                {else}
                    <form method="post" class="" action="{$host_url}/index.php/user/reset_password/set_new_password">
                        <h1 class="h3 mb-3 font-weight-normal">Reset Password</h1>
                        <input type="hidden" name="redirect_url" value="{if isset($redirect_url)}{$redirect_url}{/if}">
                        <input type="hidden" name="user_id" value="{$user_id}">
                        <label for="inputEmail" class="sr-only">New Password</label>
                        <input type="password" id="password" class="form-control" placeholder="New Password" name="password" required="true" autofocus="" />
                        <label for="inputEmail" class="sr-only">Confirm Password</label>
                        
                        
                        <br>
                        
                        <input type="password" id="confirmpassword" class="form-control" placeholder="Confirm Password" name="confirm_password" required="true" autofocus="" />
                        {if isset($error)}
                            <span class="error">{$error}</span>
                        {/if}
                        <br>
                        <button class="btn btn-lg btn-primary btn-block" name='submit' value='generate_link' type="submit">
                            Save Password
                        </button>
                    </form>
                {/if}
            {else}
                {if isset($email_sent)}
                    <form method="post" class="">
                    <h1 class="h3 mb-3 font-weight-normal">{$email_sent}</h1>
                    <span>{$message}</span>
                    <a href="{$host_url}/index.php/user/reset_password">Try Again</a>&nbsp;<a href="{$host_url}/index.php">Back to Login</a>
                </form>
                {else}
                    <form method="post" class="">
                        <h1 class="h3 mb-3 font-weight-normal">Reset Password</h1>
                        <input type="hidden" name="redirect_url" value="{if isset($redirect_url)}{$redirect_url}{/if}">
                        <label for="inputEmail" class="sr-only">Email address</label>
                        <input type="email" id="inputEmail" class="form-control" placeholder="Email address"
                            name="email_address" required="" autofocus="" />
                        {if isset($error)}
                            <span class="error">{$error}</span>
                        {/if}
                        <br>
                        <button class="btn btn-lg btn-primary btn-block" name='submit' value='generate_link' type="submit">
                            Send
                        </button></br>
                        <a href="{$host_url}/index.php">Back to Login</a>
                    </form>
                {/if}
            {/if}
            </div>
            <div class="row mt-3">
                <div class="col-6">
                    <div class="">
                        <img src="{$host_url}/img/logo-jms-gray.png" />
                    </div>
                </div>

                <div class="col-6">
                    <div class="text-right">
                        <img src="{$host_url}/img/logo-powered-by-syncretiq.png" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
{include file='../common/footer.tpl'}