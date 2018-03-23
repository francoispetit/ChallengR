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

//= require popper
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
  // Clic sur Général - Cache le bilan et affiche le graph
    $('#btn-graph-global').on("click", function(e){
      $('#summary').hide();
      $('#graph').show();
      e.preventDefault();
    });
  // Clic sur Bilan - Cache le graph et affiche le bilan
    $('#btn-bilan').on("click", function(e){
      $('#graph').hide();
      $('#summary').show();
      e.preventDefault();
    });
    // Clic sur Objectifs - Cache le bilan et affiche le graph
    $(document).on('turbolinks:load', function() {
      $('#subgoallist div').on('click', function(e){
        $('#summary').hide();
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


$(document).on('turbolinks:load', function() {
  $('btn #choose_unit').on('click', function(e){
    var unit = $('#chosen_unit').val();
  $('[class*="subgoal"]').append(defineform());
  });
});



function remove_fields(link) {
  $(link).previous("input[type=hidden]").value = "1";
  $(link).up(".fields").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).up().insert({
    before: content.replace(regexp, new_id)
  });
}
