# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ -> 
  console.log "123 123 123 123"
  $(".link_hidden_form_reply").on "click", ->
    $(this).parent().parent().parent().siblings(".hidden_form_reply").show()

  $(".link_cancel_hidden_form_reply").on "click", ->
    $(".hidden_form_reply").hide()