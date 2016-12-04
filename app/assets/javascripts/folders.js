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

    var temp_up_id = $('#up_file_temp_up_id').val();
    var resume_path = '/up_files/' + temp_up_id + '/resume_upload';

    $('#new_up_file').fileupload({
            dataType: 'script',
            maxChunkSize: 5000000, // upload 5MB 1 lần
            maxFileSize: 50000000, // to nhất là 50MB
            maxRetries: 100,
            retryTimeout: 500,
            progress: function(e, data) {
                var complete_percent = parseInt(data.loaded / data.total * 100, 10);
                $('#process-bar').attr('value', complete_percent);
            },
            add: function(e, data) {
                var that = this;
                types = /(\.|\?)(jpg|JPG|gif|GIF|mp4|MP4|mp3|MP3|pdf|PDF)$/i
                file = data.files[0];
                if (types.test(file.type) || types.test(file.name)) {

                    if (file.size > 50000000) {
                        alert('Quá kích thước cho phép 50MB.');
                    } else {
                        data.context = $(tmpl("template-upload", data.files[0]));
                        $('#new_up_file').append(data.context);
                        data.submit();
                    }
                } else {
                    alert(file.type + " không được hỗ trợ.");
                }
            },
            fail: function(e, data) {
                console.log('fail upload');
                setToast('error', 'Tải lên bị lỗi, sẽ thử lại sau 30 giây.');
                setTimeout(function() {
                    console.log(resume_path);
                    $.getJSON(resume_path, function(result) {
                        setToast('info', 'Tiếp tục tải.');
                        console.log('downloaded: ' + result.file.size);
                        data.uploadedBytes = result.file.size;
                        data.submit();
                    });
                }, 30000);
            },
            done: function(e, data) {
                console.log("DONE!!!!");

                location.reload();
            }
        })
        .on('fileuploadchunksend', function(e, data) {
            console.log('upload chunk send');
        })
        .on('fileuploadchunkdone', function(e, data) {
            console.log('upload chunk done');
        })
        .on('fileuploadchunkfail', function(e, data) {
            console.log('upload chunk fail');
        })
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