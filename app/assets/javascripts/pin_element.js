$(document).ready(function() {
  const button = $('#changing_display_order_button');
  const naviParent = $('#naviParent');
  const navbar = $('.navbar');
  const sidebar = $('.sidebar');
  
  const offset = button.offset();
  
  $(window).scroll(function () {
    if($(window).scrollTop() >= (offset.top - navbar.outerHeight() - 20.0)) {
      button.addClass('fixed_button');
      naviParent.addClass('fixed_naviParent');
      sidebar.addClass('fixed_sidebar')
    } else {
      button.removeClass('fixed_button');
      naviParent.removeClass('fixed_naviParent');
      sidebar.removeClass('fixed_sidebar')
    }
  });
});