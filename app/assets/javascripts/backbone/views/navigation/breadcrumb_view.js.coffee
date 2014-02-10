FileManager.Views.Navigation ||= {}

class FileManager.Views.Navigation.BreadcrumbView extends Backbone.View
  template: JST["backbone/templates/navigation/breadcrumb"]
  tagName: 'span'

  events:
    'click a': 'renderClickedFolder'
  
  render: ->
    @$el.html(@template(model: @model))
    this

  renderClickedFolder: (event) ->
    event.preventDefault()
    FileManager.app.navigation.render_folder_breadcrumbs(@model.get("id"))    
    FileManager.app.navigate(@model.generate_route(), {trigger: true})
