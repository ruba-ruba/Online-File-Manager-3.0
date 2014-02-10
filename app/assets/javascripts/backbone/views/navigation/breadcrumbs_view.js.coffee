FileManager.Views.Navigation ||= {}

class FileManager.Views.Navigation.BreadcrumbsView extends Backbone.View
  template: JST["backbone/templates/navigation/breadcrumbs"]
  el: '.nav-path'

  events:
    'click .root_link': 'renderRootManagerFolder'

  initialize: ->
    @collection.on('reset', @render, this)
  
  render: ->
    @$el.html(@template())
    @collection.each (breadcrumb) =>
      view = new FileManager.Views.Navigation.BreadcrumbView(model: breadcrumb)
      @$el.append(view.render().el)
    this

  renderRootManagerFolder: (event) ->
    event.preventDefault()
    @collection.reset([])
    FileManager.app.navigate("folders", {trigger: true})