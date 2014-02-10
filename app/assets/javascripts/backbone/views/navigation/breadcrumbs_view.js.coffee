FileManager.Views.Navigation ||= {}

class FileManager.Views.Navigation.BreadcrumbsView extends Backbone.View
  template: JST["backbone/templates/navigation/breadcrumbs_container"]
  el: '.nav-path'

  initialize: ->
    @collection.on('reset', @render, this)
  
  render: ->
    @$el.html(@template())
    @collection.each (breadcrumb) =>
      view = new FileManager.Views.Navigation.BreadcrumbView(model: breadcrumb)
      @$el.append(view.render().el)
    this