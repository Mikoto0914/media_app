$(window).on('load', function() {
  $('.dropdown-trigger').dropdown();
  $('.tabs').tabs();
  $('.tooltipped').tooltip();
  $('.modal').modal();
  $('.slider').slider({ height: 250 });
  $('.carousel.carousel-slider').carousel({
    fullWidth: true
  });
});