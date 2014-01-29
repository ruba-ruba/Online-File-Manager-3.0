FileManager.Views.Votes ||= {}

class FileManager.Views.Comments.VoteView extends Backbone.View
  template: JST["backbone/templates/comments/vote"]
  tagName: 'li'

  render: ->
    $(@el).html(@template(vote: @model))
    this

  className: ->
    'comment_' + comment.get("id")