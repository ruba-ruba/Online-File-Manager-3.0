FileManager.Views.Comments ||= {}

class FileManager.Views.Comments.CommentView extends Backbone.View
  template: JST["backbone/templates/comments/comment"]
  tagName: 'li'

  render: ->
    $(@el).html(@template(comment: @model))
    this

  className: ->
    'comment-' + @model.get("id")

  addVote: (vote) ->
    view = new FileManager.Views.Comments.VoteView(model: vote)
    $('.voiting').append(view.render().el)
