$(window).on('load', function() {
  $('.dropdown-trigger').dropdown();
  $('.tabs').tabs();
  $('.tooltipped').tooltip();
  $('.modal').modal();
  $('.slider').slider({ height: 250 });
  $('.sidenav').sidenav();
  $('.fixed-action-btn').floatingActionButton({
    toolbarEnabled: true
  });
  $(document).ready(function(){
    $('.parallax').parallax();
  });
});