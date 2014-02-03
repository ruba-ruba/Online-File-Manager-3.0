FileManager.Views.Folders ||= {}

class FileManager.Views.Folders.FolderView extends Backbone.View
  template: JST["backbone/templates/folders/folder"]
  tagName: 'tr'

  events:
    'click .folder_link': 'openFolder'

  render: ->
    $(@el).html(@template(folder: @model))
    this

  openFolder: (event) ->
    event.preventDefault()
    FileManager.app.navigate("folders/" + @model.get("id"), {trigger: true})
