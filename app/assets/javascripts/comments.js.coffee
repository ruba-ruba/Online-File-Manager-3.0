# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ -> 
  $(".link_hidden_form_reply").on "click", ->
    $(this).parent().parent().parent().siblings(".hidden_form_reply").show()

  $(".link_cancel_hidden_form_reply").on "click", ->
    $(".hidden_form_reply").hide()

  Pusher.log = (message) ->
    window.console.log message  if window.console and window.console.log

  Pusher.channel_auth_endpoint = '/pusher/auth?user_id=' + user_id;
  socket = new Pusher("8ba0acceea1e6f267635")
  presenceChannel = socket.subscribe('presence-' + channel)

  presenceChannel.bind "send_comment", (data) ->
    $('.comments ul').append(data)

