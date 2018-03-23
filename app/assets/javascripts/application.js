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
//= require bootstrap
//= require popper
//= require js/chartkick
//= require turbolinks
//= require nested_form_fields
//= require_tree.

$(document).on('turbolinks:load', function() {
  $('#graph').hide();
  // Clic sur Général - Cache les div et affiche le graph
    $('#btn-graph-global').on("click", function(e){
      $('li').removeClass('active');
      $(this).parent('li').addClass("active");

      $('.dashboard_div').hide();
      $('#graph').show();
      e.preventDefault();
    });
  // Clic sur Bilan - Cache les div et affiche le bilan
    $('#btn-bilan').on("click", function(e){
      $('li').removeClass('active');
      $(this).parent('li').addClass("active");
      $('.dashboard_div').hide();
      $('#summary').show();
      e.preventDefault();
    });

  // Clic sur Form - Cache les div et affiche le bilan
    $('#btn-form-result').on("click", function(e){
      $('li').removeClass('active');
      $(this).parent('li').addClass("active");
      $('.dashboard_div').hide();
      $('#resultform').show();
      e.preventDefault();
    });

  // Clic sur Objectifs - Cache les div et affiche le graph
  $(document).on('turbolinks:load', function() {
    $('#subgoallist div').on('click', function(e){
      $('.dashboard_div').hide();
      $('#graph').show();
      e.preventDefault();
    });
});
});


//Sur challenge#show, formulaire de commentaire
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
