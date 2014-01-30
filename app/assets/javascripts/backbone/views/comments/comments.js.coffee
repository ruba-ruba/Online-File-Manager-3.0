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

  renderClickedForm: ->
    alert $('#new_comment_global #comment_content').val()
