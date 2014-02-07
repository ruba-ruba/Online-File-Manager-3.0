FileManager.Views.Folders ||= {}

class FileManager.Views.Folders.BreadcrumbView extends Backbone.View
  template: JST["backbone/templates/folders/breadcrumb"]
  tagName: 'span'

  events:
    'click .breadcr_link': 'renderClickedFolder'
  
  render: ->
    $(@el).html(@template(title: @model.get("title"), id: @model.get("id")))
    this

  renderClickedFolder: (event) ->
    event.preventDefault()
    FileManager.app.navigate("folders/" + @model.get("id"), {trigger: true})
