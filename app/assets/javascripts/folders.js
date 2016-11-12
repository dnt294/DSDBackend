// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).on('turbolinks:load', function() {

    $('.new.folder').on('click', function() {
        $('.ui.modal.new.folder').modal('show');
    });

    $('.new.up_file').on('click', function() {
        $('.ui.modal.new.up_file').modal('show');
    });

    dummyBindingPopup();

    $(document).bind('dragover', function(e) {
        var dropZone = $('#dropzone'),
            timeout = window.dropZoneTimeout;
        if (!timeout) {
            dropZone.addClass('in');
        } else {
            clearTimeout(timeout);
        }
        var found = false,
            node = e.target;
        do {
            if (node === dropZone[0]) {
                found = true;
                break;
            }
            node = node.parentNode;
        } while (node != null);
        if (found) {
            dropZone.addClass('hover');
        } else {
            dropZone.removeClass('hover');
        }
        window.dropZoneTimeout = setTimeout(function() {
            window.dropZoneTimeout = null;
            dropZone.removeClass('in hover');
        }, 100);
    });


    $('#new_up_file').fileupload({
        dataType: 'script',
        maxChunkSize: 5000000,
        maxFileSize: 5000000 * 30,
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
                data.submit();
            } else {
                alert(file.type + " không được hỗ trợ.");
            }
        },
        done: function(e, data) {
            console.log("DONE!!!!");

            location.reload();
        }
    });
});

function dummyBindingPopup() {
    $('.popupable').popup({
        on: 'hover',
        hoverable: true,
        inline: true,
        position: 'top left',
        observeChanges: true,
    });
};