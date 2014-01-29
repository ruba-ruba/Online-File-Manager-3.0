# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $('.tree_menu').delegate ".toggleable_folder", "click", ->
    target = $(this)
    if target.hasClass('glyphicon-plus')
      target.removeClass('glyphicon-plus').addClass('glyphicon-minus')
    else if target.hasClass('glyphicon-minus')
      target.addClass('glyphicon-plus').removeClass('glyphicon-minus')
