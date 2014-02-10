FileManager.Views.Navigation ||= {}

class FileManager.Views.Navigation.BreadcrumbView extends Backbone.View
  template: JST["backbone/templates/navigation/breadcrumb"]
  tagName: 'span'

  events:
    'click .breadcr_link': 'renderClickedFolder'
  
  render: ->
    @$el.html(@template(title: @model.get("title"), id: @model.get("id")))
    this

  renderClickedFolder: (event) ->
    event.preventDefault()
    FileManager.app.navigation.render_folder_breadcrumbs(@model.get("id"))
    FileManager.app.navigate("folders/" + @model.get("id"), {trigger: true})
