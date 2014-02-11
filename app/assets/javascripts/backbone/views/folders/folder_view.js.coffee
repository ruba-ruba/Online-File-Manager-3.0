FileManager.Views.Folders ||= {}

class FileManager.Views.Folders.FolderView extends Backbone.View
  template: JST["backbone/templates/folders/folder"]
  tagName: 'tr'

  events:
    'click .folder_link': 'openFolder'

  render: ->    
    @$el.append(@template(folder: @model))
    this

  openFolder: (event) ->
    event.preventDefault()
    FileManager.app.navigation.render_folder_breadcrumbs(@model.get("id"))
    FileManager.app.navigate("folders/" + @model.get("id"), {trigger: true})
