<footer class="footer fixed-bottom">
      <div class="container py-3">
          &copy; Copyright 2020 Eagle Eye Limited. All rights reserved. &nbsp;&nbsp;|&nbsp;&nbsp;<a href=""
            >Terms &amp; Condition</a
          >
      </div>
    </footer>

    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    
    <script
      src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
      integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
      crossorigin="anonymous"
    ></script>
    <script src="{$host_url}/js/bootstrap/bootstrap.min.js"></script>
    <script src="{$host_url}/js/jquery.validate.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validation-unobtrusive/3.2.11/jquery.validate.unobtrusive.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
    <script type="text/javascript" src="https://ajax.aspnetcdn.com/ajax/jquery.templates/beta1/jquery.tmpl.min.js"></script>
    {if (($active_controller == 'user_login') || ($active_controller == 'user') || ($active_controller == 'user_detail'))}
      <script src="{$host_url}/js/user/user.js"></script>
    {elseif (($active_controller == 'contact_edit') || ($active_controller == 'contact'))}
      <script src="{$host_url}/js/contact/contact.js"></script>
    {elseif ($active_controller == 'timesheet')}
      <script src="{$host_url}/js/timesheet/timesheet.js"></script>
    {elseif ($active_controller == 'dashboard')}
      <script src="{$host_url}/js/dashboard.js"></script>
    {elseif (($active_controller == 'project_detail') || ($active_controller == 'project') || ($active_controller == 'job'))}
    {assign var=unique_id value=10|mt_rand:20}
    
      <script src="{$host_url}/js/project/project.js?id={$unique_id}"></script>
    {/if}

    
    

    <script>
    
            $(document).ready(function() {
              $('body').on("click", ".dropdownFilter", function (e) {
                $(this).parent().is(".show") && e.stopPropagation();
                  });
                $('table#contactList tbody tr').click(function() {
                    var link = $(this).find('.link').val();
                    window.location = link;
                });
                $('table#jobsList tbody tr td:not(:last-child)').on("click", function() {
                    var link = $(this).parent().find('.link').val();
                    window.location = link;
                });
                $(function() {
                    $('[data-toggle="tooltip"]').tooltip()
                });

                $('.record_delete').on('click', function(e){
                  var href = $(this).attr('href');
                  var message = $(this).data('message');
                  var link = window.location.href;
                  if (confirm(message)) {
                      $.ajax({
                          method: 'post',
                          dataType: 'json',
                          url: href,
                          success: function(result) {
                              console.log(link);
                          }
                      });
                      window.location = link;
                  } else {
                      return false;
                  }
                  e.preventDefault();
              });
                
            });
    </script>
  </body>
</html>
