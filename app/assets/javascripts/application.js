//= require jquery
//= require jquery_ujs
//= require jquery.remotipart
//= require bootstrap-sprockets
//= require semantic-ui
//= require turbolinks
//= require cocoon
//= require jquery-fileupload/basic
//= require jquery-fileupload/vendor/tmpl
//= require_tree ./channels
//= require_tree .

$(document).ready(function() {
    $(document).on("click", ".full-row-clickable", function() {
        var link = $(this).data("href");
        window.location = link;
    });

    $(document).on("ajax:error", ".detect-ajax-error", function(e, xhr, status, error) {
        alert('Lỗi kết nối, vui lòng thử lại sau!');
    });

});