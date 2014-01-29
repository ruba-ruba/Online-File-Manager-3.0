FileManager.Views.Comments ||= {}

class FileManager.Views.Comments.CommentsView extends Backbone.View
  template: JST["backbone/templates/comments/comments"]

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
    $('.comments ul').append(view.render().el)
