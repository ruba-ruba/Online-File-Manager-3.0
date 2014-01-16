# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ -> 
  $('.comments').delegate ".link_hidden_form_reply", "click", ->
    $(this).parent().parent().parent().siblings(".hidden_form_reply").show()
    return false

  $(".link_cancel_hidden_form_reply").on "click", ->
    $(".hidden_form_reply").hide()
    return false

  Pusher.channel_auth_endpoint = '/pusher/auth?user_id=' + user_id + '&authenticity_token=' + encodeURIComponent($( 'meta[name="csrf-token"]' ).attr( 'content' ));
  socket = new Pusher("8ba0acceea1e6f267635")
  presenceChannel = socket.subscribe('presence-' + channel)

  presenceChannel.bind "send_comment", (data) ->
    $(data.identifier).append(data.content)
    $("textarea").each ->
      $(this).val ""
    $(".hidden_form_reply").hide()


