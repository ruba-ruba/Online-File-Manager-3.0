FileManager.Views.Comments ||= {}

class FileManager.Views.Comments.IndexView extends Backbone.View
  template: JST["backbone/templates/comments/new_comment"]


  render: ->
    $(@el).html(@template())
    this

