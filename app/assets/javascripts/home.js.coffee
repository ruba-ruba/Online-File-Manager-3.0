# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


# second
# $(window).bind "beforeunload", ->
#   j = 0
#   $("form :input").not(":input[type=button], :input[type=submit], :input[type=reset], :input[type=hidden], :input[type=checkbox]").each (index, elem) ->
#     j++  if elem.value.length >= 1

#   return "You have unsaved data in form, really want to quit ?" if j > 0


# case 3 IF FF
# $(window).bind 'beforeunload', ->
#   if /Firefox[\/\s](\d+)/.test(navigator.userAgent)
#     if(confirm("Are you Sure do you want to leave?"))
#       history.go()
#     else
#       window.setTimeout( ->
#         window.stop()
#       , 1)
#       return
#   else
#     return "Are you Sure do you want to leave?"



$(window).bind "beforeunload", ->
  j = 0
  $(".data_form :input").not(":input[type=button], :input[type=submit], :input[type=reset], :input[type=hidden], :input[type=checkbox]").each (index, elem) ->
    if elem.value.length >= 1
      j++
      false

  if j > 0
    if /Firefox[\/\s](\d+)/.test(navigator.userAgent)
      if(confirm("Are you Sure do you want to leave?"))
        history.go()
      else
        window.setTimeout( ->
          window.stop()
        , 1)
        return
    else
      return "Are you Sure do you want to leave?"

$ ->
  $('form').submit ->
    $(window).unbind 'beforeunload'
