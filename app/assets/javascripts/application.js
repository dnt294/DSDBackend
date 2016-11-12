//= require jquery
//= require jquery_ujs
//= require jquery.remotipart
//= require bootstrap-sprockets
//= require semantic-ui
//= require turbolinks
//= require cocoon
//= require jquery-fileupload/basic
//= require jquery-fileupload/vendor/tmpl
//= require_tree .
//= require_tree ./channels

$(document).ready(function() {
    $(document).on("click", ".full-row-clickable", function() {
        var link = $(this).data("href");
        window.location = link;
    });

    $(document).on("ajax:error", ".detect-ajax-error", function(e, xhr, status, error) {
        alert('Lỗi kết nối, vui lòng thử lại sau!');
    });

});

function setToast(type, message) {

    toastr[type](message);

    toastr.options = {
        "closeButton": false,
        "debug": false,
        "newestOnTop": false,
        "progressBar": false,
        "positionClass": "toast-top-right",
        "preventDuplicates": false,
        "onclick": null,
        "showDuration": "300",
        "hideDuration": "1000",
        "timeOut": "5000",
        "extendedTimeOut": "1000",
        "showEasing": "swing",
        "hideEasing": "linear",
        "showMethod": "fadeIn",
        "hideMethod": "fadeOut"
    };
}