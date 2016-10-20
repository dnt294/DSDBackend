// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).on('turbolinks:load', function() {
    $('.new.folder').on('click', function() {
        $('.ui.modal.new.folder').modal('show');
    });

    $('.new.up_file').on('click', function() {
        $('.ui.modal.new.up_file').modal('show');
    })



    $('.popupable').popup({
        on: 'click',
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