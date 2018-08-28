// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
window.addEventListener('turbolinks:load', function() {
  $('.datepicker').pickadate();
  $('select').material_select();
})