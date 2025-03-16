$(document).ready(function() {
    $('#Projectlist').on('change',function(e) {
        var job_id = $(this).val();
        var host_url = $('#host_url').val();
        $.ajax({
            url: host_url + '/index.php/ajax/timesheet_ajax/get_jobs_dispatch',
            method: 'post',
            dataType: 'json',
            data: {'job_id': job_id},
            success: function(response) {
                var element = '<option value="">All JobDispatch</option>';
                $.each(response, function( index, value ) {
                    element += '<option value=' + value.Id + '>' + value.DispatchName + '</option>'
                });
                $('#job_dispatch_list').empty().append(element);
            },
            error: function(response) {
                console.log(response);
                console.log('failure');
            }
        });
    }),
    $('.addTimeSheet').validate({
        rules :{
            Userlist : {
                required : true
            },
            Jobslist: {
                required : true
            },
            JobsDispatchlist: {
                required : true
            },
            txtDuration: {
                required : true
            }
        },
        messages :{
            Userlist : {
                required : 'Please select a user'
            },
            Jobslist : {
                required : 'Please select a job',
            },
            JobsDispatchlist : {
                required : 'Please select a job dispatch',
            },
            txtDuration: {
                required : 'Duration Field cannot be empty'
            }
        }
    })
});