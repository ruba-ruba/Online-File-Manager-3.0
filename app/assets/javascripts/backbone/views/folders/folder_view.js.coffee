FileManager.Views.Folders ||= {}

class FileManager.Views.Folders.FolderView extends Backbone.View
  template: JST["backbone/templates/folders/folder"]
  tagName: 'tr'

  render: ->
    $(@el).html(@template(folder: @model))
    this
