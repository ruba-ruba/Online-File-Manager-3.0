FileManager.Views.Folders ||= {}

class FileManager.Views.Folders.BreadcrumbsView extends Backbone.View
  template: JST["backbone/templates/folders/breadcrumbs"]
  el: '.nav-path'

  initialize: ->
    @collection.on('reset', @render, this)

  render: ->
    @$el.html(@template())
    @$el.parents(".container-fluid").on("folderChanged", {el: @$el, self: @}, @drawPath)

  drawPath: (ev) ->
    collection = ev.data.self.collection  
    current_folder = collection.get(FileManager.app.current_folder_id)
    collection.each (folder) =>
      if folder.isParent(current_folder)
        view = new FileManager.Views.Folders.BreadcrumbView(model: folder)
        ev.data.el.append(view.render().el)
    ev.data.el.find('.breadcr').show()
