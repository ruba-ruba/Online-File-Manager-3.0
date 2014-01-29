FileManager.Views.Folders ||= {}

class FileManager.Views.Folders.TreeView extends Backbone.View
  template: JST["backbone/templates/folders/tree"]
  tagName: 'ul'

  render: ->
    $(@el).html(@template(folder: @model))
    this
