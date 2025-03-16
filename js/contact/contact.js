$(document).ready(function () {
    if ($('#option2').is(":checked")) {
        $('.user').hide();
        $('.company').show();
    } else {
        $('.company').hide();
        $('.user').show();
    }

    if ($('#id').val() == 'new') {
        $('.extra_tabs').addClass('disabled');
    } else {
        $('.extra_tabs').removeClass('disabled');
    }

    $('.contact_type').click(function(e) {
        var filter = $(this).text();
        $.ajax({
            url: 'ajax/contact_ajax/add_filter',
            method: 'post',
            dataType: 'json',
            data: {type: 'ContactType', value: filter},
            success: function(response) {
                console.log(response);
                console.log('uploaded');
            },
            error: function(response) {
                console.log(response);
            }
        });
    }),

    $.validator.addMethod("valueNotEquals", function(value, element, arg){
        return arg !== $(element).find('option:selected').val();
    }, "Value must not equal arg.");

    $('.add_contact').validate({
        rules: {
            email: {
                required: true,
                email: true
            },
            address: {
                required: true
            },
            suburb: {
                required: true
            },
            city: {
                required: true
            },
            contact_type: {
                valueNotEquals: "default"
            }
        },
        messages: {
            email: {
                required: 'Email cannot be empty',
                email: 'Please provide a valid email address'

            },
            address: {
                required: 'Address cannot be empty'
            },
            suburb: {
                required: 'Suburb cannot be empty'

            },
            city: {
                required: 'City cannot be empty'
            },
            contact_type: {
                valueNotEquals: "Please select an item!"
            }
        }
    }),

        $('[name ="contact_type"]').click(function () {
            var selected = $(this).val();
            if (selected == 'Organisation') {
                $('.user').hide();
                $('.company').show();
            } else {
                $('.company').hide();
                $('.user').show();
            }
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
                success: function (response) {
                    console.log(response);
                    var html = '<tr>';
                    html += '<td>' + response.data.AddedOn + '<input type="hidden" class="document_id" value="' + response.inserted_id + '"></td>';
                    html += '<td>' + response.data.Name + '</td><td>';
                    html += '<a href="' + $('#host_url').val() + response.data.Path + '" class="btn btn-sm" target="_blank" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="View"><i class="active icofont-eye-alt"></i></a>';
                    html += '</tr>';
                    $('#documentlist').append(html);
                    $('.no_dcoument_message').hide();
                },
                error: function (response) {
                    console.log('error');
                    console.log(response);
                }
            });
        });

    $('.document_delete').on('click', function (c) {
        c.preventDefault();
        var element = $(this).parent().parent('tr');
        var id = element.find('.document_id').val();
        var url = $('#host_url').val() + '/index.php/ajax/contact_ajax/file_delete';
        $.ajax({
            url: url,
            method: 'post',
            dataType: 'json',
            data: { id: id },
            success: function (response) {
                element.remove();
            },
            error: function (response) {
                console.log('error');
                console.log(response);
            }
        });
    });

    $('#user_name').keyup(function () {
        var username = $(this).val();
        $.ajax({
            url: '../ajax/user_ajax/get_user',
            method: 'post',
            dataType: 'json',
            data: { type: 'Username', value: username },
            success: function (response) {
                if (response.result > 0) {
                    $('#user_name').after("<label class='username-error-message' for='user_name'>Username already exist, please try different username.</label>");
                } else {
                    if ($('.username-error-message').length > 0) {
                        $('.username-error-message').remove();
                    }
                }
            },
            error: function (response) {
                console.log(response);
            }
        })
    }),

        $('#email').keyup(function () {
            var email = $(this).val();
            $.ajax({
                url: '../ajax/user_ajax/get_user',
                method: 'post',
                dataType: 'json',
                data: { type: 'Email', value: email },
                success: function (response) {
                    if (response.result > 0) {
                        $('#email').after("<label class='email-error-message' for='user_name'>Email already exist, please try different email.</label>");
                    } else {
                        if ($('.email-error-message').length > 0) {
                            $('.email-error-message').remove();
                        }
                    }
                },
                error: function (response) {
                    console.log(response);
                }
            })
        })
})