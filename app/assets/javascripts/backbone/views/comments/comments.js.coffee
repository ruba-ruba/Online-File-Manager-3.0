FileManager.Views.Comments ||= {}

class FileManager.Views.Comments.CommentsView extends Backbone.View
  template: JST["backbone/templates/comments/comments"]
  className: "comments_page row"

  events:
    'click .actions_global': 'renderClickedForm'

  initialize: ->
    @collection.on('reset', @renderComments, this)

  render: ->
    $(@el).html(@template())
    this

  renderComments: ->
    @collection.each(@addComment)

  addComment: (comment) ->
    view = new FileManager.Views.Comments.CommentView(model: comment)
    $(comment.get("parent_identifier")).append(view.render().el)

  renderClickedForm: (event)->
    formFields = @$el.find('#new_comment_global').serializeArray()
    value = formFields[1].value
    id = @collection.commentable_id
    type = @collection.commentable_type
    comment = new FileManager.Models.Comment(commentable_type: type, commentable_id: id, content: value).save()
