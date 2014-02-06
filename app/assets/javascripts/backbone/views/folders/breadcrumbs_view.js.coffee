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
    @$el.parents(".container-fluid").on("folderChanged", {el: @$el, self: @}, @drawPath)

  drawPath: (ev, folder_id) ->
    collection = ev.data.self.collection  
    current_folder = collection.get(folder_id)
    ev.data.self.$el.html(ev.data.self.template())
    collection.each (folder) =>
      if folder.isParentOf(current_folder)
        view = new FileManager.Views.Folders.BreadcrumbView(model: folder)
        ev.data.el.append(view.render().el)
    current_folder_tmpl = JST["backbone/templates/folders/breadcrumb_current"](folder: current_folder)
    ev.data.el.append(current_folder_tmpl)
    ev.data.el.find('.breadcr').show()

  renderRootManagerFolder: (event) ->
    event.preventDefault()
    FileManager.app.navigate("folders", {trigger: true})
