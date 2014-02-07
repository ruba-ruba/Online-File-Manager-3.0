FileManager.Views.Folders ||= {}

class FileManager.Views.Folders.BreadcrumbsView extends Backbone.View
  template: JST["backbone/templates/folders/breadcrumbs"]
  el: '.nav-path'

  events:
    'click .root_link': 'renderRootManagerFolder'

  initialize: ->
    @collection.on('reset', @render, this)
  
  render: ->
    @$el.html(@template())
    @collection.each (breadcrumb) =>
      view = new FileManager.Views.Folders.BreadcrumbView(model: breadcrumb)
      @$el.append(view.render().el)
    this

  renderRootManagerFolder: (event) ->
    event.preventDefault()
    FileManager.app.navigate("folders", {trigger: true})
