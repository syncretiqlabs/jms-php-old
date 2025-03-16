{include file='../common/head.tpl'}

<div class="container">
      <div class="row">
        <div class="col-12 col-md-12 col-lg-6 offset-lg-3 offset-0 ">
          <div class="logo-login text-center my-4">
            <img src="{$host_url}/img/logo-eagle-eye.png" />
          </div>
          <div class="form-signin p-5 rounded-3">
            <form method="post" class="">
                <h1 class="h3 mb-3 font-weight-normal">Login</h1>
                <input type="hidden" name="redirect_url" value="{if isset($redirect_url)}{$redirect_url}{/if}">
                <label for="inputEmail" class="sr-only">Email address</label>
                <input type="email" id="inputEmail" class="form-control" placeholder="Email address" name="email_address" required="" autofocus="" />
                <label for="inputPassword" class="sr-only">Password</label>
                <input type="password" id="inputPassword" class="form-control mt-3" placeholder="Password" name="password" required="" />
                    {if isset($error)}
                        <span class="error">{$error}</span>
                    {/if}
                <div class="row">
                    {*<div class="col-6">
                     <div class="checkbox my-3">
                        <label>
                        <input type="checkbox" value="remember-me" /><span>Remember me</span>
                        </label>
                    </div> 
                    </div>*}

                    <div class="col-12">
                    <div class="py-3">
                        <a href="{$host_url}/index.php/user/reset_password" class=""> Forgot Password</a>
                    </div>
                    </div>
                </div>
                <button class="btn btn-lg btn-primary btn-block" name='submit' value='submit' type="submit">
                    Login
                </button>
            </form>
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