FileManager.Views.Comments ||= {}

class FileManager.Views.Comments.CommentsView extends Backbone.View
  template: JST["backbone/templates/comments/comments"]
  className: "comments_page row"

  events:
    'click .actions_global': 'createComment'

  initialize: ->
    @collection.on('reset', @renderComments, this)
    @collection.on('add', @addComment, this)

  render: ->
    $(@el).html(@template())
    this

  renderComments: ->
    @collection.each(@addComment)

  addComment: (comment) ->
    view = new FileManager.Views.Comments.CommentView(model: comment)
    $(comment.get("parent_identifier")).append(view.render().el)

  createComment: (event)->
    formFields = @$el.find('#new_comment_global').serializeArray()
    value = formFields[1].value
    @collection.create(content: value, {wait: true})
    @$el.find('#new_comment_global textarea').val("")

