FileManager.Views.Folders ||= {}

class FileManager.Views.Folders.FolderTreeView extends Backbone.View
  template: JST["backbone/templates/folders/tree_menu"]

  initialize: ->
    @collection = new FileManager.Collections.Navigation()
    @breadcrumbs = new FileManager.Collections.Breadcrumbs()
    new FileManager.Views.Folders.BreadcrumbsView(collection: @breadcrumbs)
    @collection.fetch()
    @collection.on('reset', @render, this)

  render: ->
    $(".tree_menu").html(@template())
    @render_current_folder()
    @collection.each (folder) ->
      view = new FileManager.Views.Folders.TreeView(model: folder)
      $(folder.parentUlSelector()).append(view.render().el)
    this

  set_current_folder_id: (folder_id) ->
    @current_folder_id = folder_id

  render_folder: (folder_id) ->
    parents = @collection.get(folder_id).get("parents_info")
    @breadcrumbs.reset(parents)

  render_current_folder: ->
    parents = @collection.get(@current_folder_id).get("parents_info")
    @breadcrumbs.reset(parents)