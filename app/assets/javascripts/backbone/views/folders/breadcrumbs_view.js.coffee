FileManager.Views.Folders ||= {}

class FileManager.Views.Folders.BreadcrumbsView extends Backbone.View
  template: JST["backbone/templates/folders/breadcrumbs"]

  initialize: ->
    @collection = new FileManager.Collections.Navigation()
    @collection.fetch()
    @collection.on('reset', @render, this)

  render: ->    
    $(".nav-path").html(@template())
    @collection.each(@addBr)
    this

    addBr: (folder) ->
    content = JST["backbone/templates/folders/breadcrumb"](folder: folder)
    $(".nav-path").append(content)