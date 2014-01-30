FileManager.Views.Comments ||= {}

class FileManager.Views.Comments.CommentView extends Backbone.View
  template: JST["backbone/templates/comments/comment"]
  tagName: 'li'

  events:
    'click .link_hidden_form_reply': 'renderReplyForm'
    'click .actions_reply': 'renderClickedFormReply'


  render: ->
    $(@el).html(@template(comment: @model))
    this

  addVote: (vote) ->
    view = new FileManager.Views.Comments.VoteView(model: vote)
    $('.voiting').append(view.render().el)

  renderReplyForm: (event) ->
    console.log(event.target is @$('.link_hidden_form_reply')[0])
    $(".hidden_form_reply").show() if event.target is @$('.link_hidden_form_reply')[0]

  renderClickedFormReply: (event) ->
    alert $('#new_comment_reply #comment_content').val() if event.target is @$('#new_comment_reply #comment_content')[0]
