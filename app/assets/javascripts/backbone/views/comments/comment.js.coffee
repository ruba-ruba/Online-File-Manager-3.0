FileManager.Views.Comments ||= {}

class FileManager.Views.Comments.CommentView extends Backbone.View
  template: JST["backbone/templates/comments/comment"]
  tagName: 'li'

  initialize: ->
    @model.on("change", @reRender, this)

  events:
    'click .link_hidden_form_reply': 'renderReplyForm'
    'click .submit': 'createCommentReply'
    'click .link_form_delete': 'deleteComment'
    'click .up-vote': 'upVote'
    'click .down-vote': 'downVote'

  render: ->
    $(@el).html(@template(comment: @model))
    this

  reRender: ->
    oldContent = $(@el).find(".positive")[0]
    newContent = $(@template(comment: @model))[0]
    $(oldContent).replaceWith(newContent)

  renderReplyForm: (event) ->
    event.preventDefault()
    @$('textarea').val ""
    if event.target is @$('.link_hidden_form_reply')[0]
      target = @$(".hidden_form_reply").first()
      $(".hidden_form_reply").not(target).hide()
      target.toggle()

  createCommentReply: (event) ->
    event.preventDefault()
    if  event.target is @$('.submit')[0]
      formFields = @$el.find('#new_comment_global').serializeArray()
      value = @$('textarea').val()
      parent_id = @model.get("id")
      @model.collection.create(content: value, parent_id: parent_id, {wait: true})
      @$('textarea').val ""
      @$(".hidden_form_reply").hide()

  deleteComment: (event) ->
    event.preventDefault()
    if  event.target is @$('.link_form_delete')[0]
      @model.destroy()
      @$(".hidden_form_reply").hide()
      $(@el).html("comment was deleted")

  upVote: (event) ->
    event.preventDefault()
    if event.target is @$('.glyphicon-thumbs-up')[0]
      new FileManager.Models.VotedComment(vote_type: true).set_comment(@model).save()

  downVote: (event) ->
    event.preventDefault()
    if event.target is @$('.glyphicon-thumbs-down')[0]
      new FileManager.Models.VotedComment(vote_type: false).set_comment(@model).save()
