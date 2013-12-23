# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$(window).bind "beforeunload", ->
  confirmation = ->
    if confirm("you have unsaved data in form, really want to quit ?")
      false
    else
      false
      
  j = 0
  $("form :input").not(":input[type=button], :input[type=submit], :input[type=reset], :input[type=hidden], :input[type=checkbox]").each (index, elem) ->
    j++  if elem.value.length >= 1

  return confirmation()  if j > 0