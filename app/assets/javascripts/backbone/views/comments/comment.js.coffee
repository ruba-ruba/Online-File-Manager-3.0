FileManager.Views.Comments ||= {}

class FileManager.Views.Comments.CommentView extends Backbone.View
  template: JST["backbone/templates/comments/comment"]
  tagName: 'li'

  events:
    'click .link_hidden_form_reply': 'renderReplyForm'
    'click .submit': 'renderClickedFormReply'

  render: ->
    $(@el).html(@template(comment: @model))
    this

  addVote: (vote) ->
    view = new FileManager.Views.Comments.VoteView(model: vote)
    $('.voiting').append(view.render().el)

  renderReplyForm: (event) ->
    event.preventDefault()
    $('textarea').val ""
    if event.target is @$('.link_hidden_form_reply')[0]
      target = @$(".hidden_form_reply").first()
      $(".hidden_form_reply").not(target).hide()
      target.toggle()

  renderClickedFormReply: (event) ->
    event.preventDefault()
    if  event.target is @$('.submit')[0]
      alert $(event.target).parent().siblings('.form-inputs').children('.comment_content').children('.controls').children('textarea').val()