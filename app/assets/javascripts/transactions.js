$(document).ready(function(){
$('[data-toggle=offcanvas]').click(function() {
  console.log('massive error');
    $(this).toggleClass('visible-xs text-center');
    $(this).find('i').toggleClass('glyphicon-chevron-right glyphicon-chevron-left');
    $('.row-offcanvas').toggleClass('active');
    $('#lg-menu').toggleClass('hidden-xs').toggleClass('visible-xs');
    $('#xs-menu').toggleClass('visible-xs').toggleClass('hidden-xs');
    $('#btnShow').toggle();
});
$(document).on('click','.navbar-collapse.in',function(e) {
debugger;
    if( $(e.target).is('a') ) {
        $(this).collapse('hide');
    }
});
});
