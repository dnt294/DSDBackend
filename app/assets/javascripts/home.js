$(document).ready(function() {

    // fix menu when passed
    $('.welcome-menu').visibility({
        once: false,
        onBottomPassed: function() {
            $('.following-header').transition('fade in');
        },
        onBottomPassedReverse: function() {
            $('.following-header').transition('fade out');
        }
    });

});