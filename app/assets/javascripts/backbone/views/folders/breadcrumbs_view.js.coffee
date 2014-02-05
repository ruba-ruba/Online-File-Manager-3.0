FileManager.Views.Folders ||= {}

class FileManager.Views.Folders.BreadcrumbsView extends Backbone.View
  template: JST["backbone/templates/folders/breadcrumbs"]
  el: '.nav-path'

  initialize: ->    
    @collection = new FileManager.Collections.Navigation()
    @collection.fetch()
    @collection.on('reset', @render, this)

  render: ->
    @$el.html(@template())
    @collection.each (folder) ->
      view = new FileManager.Views.Folders.BreadcrumbView(model: folder)
      $('.nav-path').append(view.render().el)
    this
    @$el.parents(".container-fluid").on("click", '.tree_link', @drawPath)

  drawPath: ->
    $('.breadcr').show()
