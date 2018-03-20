// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//

//= require jquery3
//= require jquery_ujs
//= require popper
//= require bootstrap
//= require js/chartkick
//= require turbolinks
//= require nested_form_fields
//= require_tree.



$(document).on('turbolinks:load', function() {
  $('.reply-form').hide();
  $('.btn-reply').on('click', function(e){
    e.preventDefault();
    $(this).next('.reply-form').toggle(); // Show form on button click
  });
});



$(document).on('turbolinks:load', function() {
  $('.reply-form-challenge').hide();
  $('.btn-reply-challenge').on('click', function(e){
    e.preventDefault();
    $(this).prev('.reply-form-challenge').toggle(); // Show form on button click
  });
});
