$(function () {
    $('.click-nav ul').hide();
    $(document).on('click','.click-nav', function(e) {
        $('.click-nav ul').slideToggle(200);
        e.stopPropagation();
    });
    $(document).click(function() {
        if ($('.click-nav ul').is(':visible')) {
            $('.click-nav ul', this).slideUp();
        }
    });
});

