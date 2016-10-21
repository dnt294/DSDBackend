// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).on('turbolinks:load', function() {

    $('.new.folder').on('click', function() {
        $('.ui.modal.new.folder').modal('show');
    });

    $('.new.up_file').on('click', function() {
        $('.ui.modal.new.up_file').modal('show');
    })

    $('#new_up_file').fileupload({
        dataType: 'json',
        progress: function(e, data) {
            var complete_percent = parseInt(data.loaded / data.total * 100, 10);
            $('#process-bar').attr('value', complete_percent);
        },
        add: function(e, data) {
            types = /(\.|\?)(jpg|JPG|gif|GIF|mp4|MP4|mp3|MP3|pdf|PDF)$/i
            file = data.files[0];
            if (types.test(file.type) || types.test(file.name)) {
                data.context = $(tmpl("template-upload", data.files[0]));
                $('#new_up_file').append(data.context);
                console.log('add!');
                data.submit();
            } else {
                alert(file.type + " không được hỗ trợ.");
            }
        },

        done: function(e, data) {

            //location.reload();
        }

    });

    $('.popupable').popup({
        on: 'hover',
        hoverable: true,
        inline: true,
        observeChanges: true,
        position: 'bottom left'
    });


});

function dummyBindingPopupListener() {
    $('body').on('popup', '.popupable', {
        hoverable: true,
        inline: true,
        observeChanges: true,
        position: 'bottom center'
    }, function(e) {});
}