$(document).ready(function() {
    
    $('.add_user_for_job').click(function(e) {
        console.log('here');
        $('.containerDiv').children('div.element:last').clone().insertAfter("div.element:last");
        e.preventDefault();
    }),
    $('a.delete_user').click(function(e) {
        var element_to_remove = $(this).parent().parent('.element');
        var parent =  element_to_remove.parent().children('.element');
        $(this).parent().parent('.user').remove();
        e.preventDefault();
    }),
    
    $('.form_add-job').submit(function(e) {
        e.preventDefault();
        var form = $(this);
        $.ajax({
            type: "POST",
            url: "https://jms.syncretiq.com/index.php/ajax/project_ajax/add_jobs",
            data: form.serialize(),
            dataType: "html",
            success: function(result){
                var response = $.parseJSON(result);
                $('#tmpl_add_job').tmpl(response).appendTo('#contactList tbody');
                $('.modal input').val('');
                $('.modal').modal('hide');
            },
            error: function(data){
                console.log('error');
            }
        });
    }),

    $('#project_type').on('change', function(){
        if ($(this).val() == 'contract') {
            $('.contract_hours').show();
        } else {
            $('.contract_hours').hide();
        }
    }),

    $('#jobModal').on('show.bs.modal', function (event) {
        $(this).removeData();
    }),
    $('#jobModal').on('show.bs.modal', function (event) {
        //$(this).find('.loader').show();
        var button = $(event.relatedTarget) // Button that triggered the modal
        var job_id = button.data('id') // Extract info from data-* attributes
        // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
        // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
        var modal = $(this)

        $.ajax({
            url: "https://jms.syncretiq.com/index.php/ajax/project_ajax/get_jobs",
            data: {job_id: job_id},
            method: 'post',
            dataType: 'json',
            success: function(data) {
                modal.find('#date').val(data.JobDateTime);
                modal.find('#job_name').val(data.Name);
                modal.find('#job_desc').val(data.Description);
                
                
                
                
                $.each(data.resources, function( key, value ) {
                    if (key === 0) {
                        modal.find('.resource>option[value="' + value.UserId + '"]').last().prop('selected', true);
                    } else {
                        modal.find('.assign_user').clone().insertAfter('.assign_user').last();
                        modal.find('.resource>option[value="' + value.UserId + '"]').last().prop('selected', true);
                    }
                })
            },
            error: function(data) {
                console.log('error');
                console.log(data);
            }
        });
        //$('.loader').hide();
    }),

    $('a.delete_job').on('click', function(e) {
        e.preventDefault();
        var job_id = $(this).data('id');
        var element  = $(this).parent().parent('tr');
        $.ajax({
            url: "https://jms.syncretiq.com/index.php/ajax/project_ajax/delete_jobs",
            data: {id: job_id},
            method: 'post',
            dataType: 'json',
            success: function(data) {
                console.log('success');
                element.remove();
            },
            error: function(data) {
                console.log('error');
                console.log(data);
            }
        });
    }),

    $('#customer_id_ac').autocomplete({
                    minLength: 2,
                    source: function (request, response) {
                        $.ajax({
                            url: "https://jms.syncretiq.com/index.php/ajax/project_ajax/get_customer",
                            type: 'post',
                            dataType: 'json',
                            data: {
                                searchTerm: request.term,
                            },
                            success: function (data) {
                                $.each(data, function (index, item){
                                    data.index = index;
                                    data.value = item;
                                })
                                response(data);
                            }
                        });
                    },
                    select: function (event, ui) {
                        event.preventDefault();
                        console.log(ui);
                        var fieldValue = ui.item.value.trim();
                        $('#customer_id_ac').val(fieldValue);
                    },
                })
})