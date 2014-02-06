FileManager.Views.Folders ||= {}

class FileManager.Views.Folders.BreadcrumbsView extends Backbone.View
  template: JST["backbone/templates/folders/breadcrumbs"]
  el: '.nav-path'

  initialize: ->
    @collection.on('reset', @render, this)

  render: ->
    @$el.html(@template())
    @$el.parents(".container-fluid").on("folderChanged", {el: @$el, self: @}, @drawPath)

  drawPath: (ev, folder_id) ->
    collection = ev.data.self.collection  
    current_folder = collection.get(folder_id)
    ev.data.self.$el.html(ev.data.self.template())
    collection.each (folder) =>
      if folder.isParentOf(current_folder)
        view = new FileManager.Views.Folders.BreadcrumbView(model: folder)
        ev.data.el.append(view.render().el)
    # to add template of current folder title
    ev.data.el.find('.breadcr').show()
