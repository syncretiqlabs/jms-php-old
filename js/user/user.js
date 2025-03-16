$(document).ready(function() {
    if ($('#type').val() == 'user') {
        $('.contact').hide();
        $('.user').show();
    } else {
        $('.user').hide();
        $('.contact').show();
    }

    if ($('#id').val() == 'new') {
        $('.extra_tabs').addClass('disabled');
    } else {
        $('.extra_tabs').removeClass('disabled');
    }

    $('.add_user').validate({
        rules :{
            user_name : {
                required : true
            },
            password: {
                required : true,
                minlength : 8
            },
            email: {
                required: true,
                email: true
            },
            mobile: {
                required: true,
                minlength: 10
            },
            employee_role: {
                required: true,
            }
        },
        messages :{
            user_name : {
                required : 'Enter username'
            },
            password : {
                required : 'Enter password',
                minlength : 'Password must contain atleast 8 characters'
            },
            email : {
                required : 'Email cannot be empty',
                email: 'Please provide a valid email address'
            },
            mobile : {
                required : 'Mobile number cannot be empty',
                minlength: 'Please provide a valid Mobile number'
            },
            employee_role : {
                required : 'Employee role must be selected',
            }
        }
    }),

    $('#password_confirm').on('keyup', function() {
        var value = $(this).val();
        var password = $('#password').val();
        if (value !== password) {
            $('.password_error').show();
        } else {
            $('.password_error').hide();
        }
    }),


    $('[name ="options"]').click(function(){
        var selected = $(this).val();
        if (selected == 'user') {
            $('.contact').hide();
            $('.user').show();
        } else {
            $('.user').hide();
            $('.contact').show();
        }
    }),

    $('#user_name').keyup(function(){
        var username = $(this).val();
        $.ajax({
            url: '../ajax/user_ajax/get_user',
            method: 'post',
            dataType: 'json',
            data: {type: 'Username', value: username},
            success: function(response) {
                if (response.result > 0) {
                    $('#user_name').after("<label class='username-error-message' for='user_name'>Username already exist, please try different username.</label>");
                } else {
                    if ($('.username-error-message').length > 0) {
                        $('.username-error-message').remove();
                    }
                }
            },
            error: function(response) {
                console.log(response);
            }
        })
    }),

    $('#email').keyup(function(){
        var email = $(this).val();
        $.ajax({
            url: '../ajax/user_ajax/get_user',
            method: 'post',
            dataType: 'json',
            data: {type: 'Email', value: email},
            success: function(response) {
                if (response.result > 0) {
                    $('#email').after("<label class='email-error-message' for='user_name'>Email already exist, please try different email.</label>");
                } else {
                    if ($('.email-error-message').length > 0) {
                        $('.email-error-message').remove();
                    }
                }
            },
            error: function(response) {
                console.log(response);
            }
        })
    }),

    $('form.file_upload_form').on('submit', function (c) {
        c.preventDefault();
        var url = $('#ajax_url').val();
        $.ajax({
            url: url,
            method: 'post',
            dataType: 'json',
            data: new FormData(this),
            processData: false,
            contentType: false,
            cache: false,
            success: function(response) {
                console.log(response);
                var html = '<tr>';
                html += '<td>' + response.data.AddedOn + '</td>';
                html += '<td>' + response.data.Name + '</td><td>';
                html += '<a href="' + $('#host_url').val() + response.data.Path + '" class="btn btn-sm" target="_blank" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="View"><i class="active icofont-eye-alt"></i></a>';
                html += '</td></tr>';
                $('#documentlist').append(html);
                $('.no_dcoument_message').hide();
            },
            error: function(response) {
                console.log('error');
                console.log(response);
            }
        });
    });

    $('.document_delete').on('click', function (c) {
        c.preventDefault();
        var element = $(this).parent().parent('tr');
        var id = element.find('.document_id').val();
        var url = $('#host_url').val() + '/index.php/ajax/user_ajax/file_delete';
        $.ajax({
            url: url,
            method: 'post',
            dataType: 'json',
            data: {id: id},
            success: function(response) {
                console.log(element);
                element.remove();
            },
            erro: function(response) {
                console.log('error');
                console.log(response);
            }
        });
    });
})