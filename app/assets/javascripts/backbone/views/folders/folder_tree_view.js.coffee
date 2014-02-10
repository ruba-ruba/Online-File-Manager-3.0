FileManager.Views.Folders ||= {}

class FileManager.Views.Folders.FolderTreeView extends Backbone.View
  template: JST["backbone/templates/folders/tree_menu"]

  el: '.nav-path'  

  initialize: ->
    @collection = new FileManager.Collections.Navigation()
    @breadcrumbs = new FileManager.Collections.Breadcrumbs()
    new FileManager.Views.Folders.BreadcrumbsView(collection: @breadcrumbs)
    @collection.fetch()
    @collection.on('reset', @render, this)

  render: ->
    $(".tree_menu").html(@template())
    @render_current_folder_breadcrumbs()    
    @collection.each (folder) ->
      view = new FileManager.Views.Folders.TreeView(model: folder)
      $(folder.parentUlSelector()).append(view.render().el)
    this

  set_current_folder_id: (folder_id) ->
    @current_folder_id = folder_id

  render_folder_breadcrumbs: (folder_id) ->
    current_folder = @collection.get(folder_id)
    parents = current_folder.get("parents_info")
    title = current_folder.get("title")
    @breadcrumbs.reset(parents)
    @draw_current_folder_breadcrumb(title)

  render_current_folder_breadcrumbs: ->
    if @current_folder_id isnt undefined
      current_folder = @collection.get(@current_folder_id)
      parents = current_folder.get("parents_info")
      title = current_folder.get("title")
      @breadcrumbs.reset(parents)
      @draw_current_folder_breadcrumb(title)

  draw_current_folder_breadcrumb: (title) ->
    content = JST["backbone/templates/folders/breadcrumb_current"]
    @$el.append(content(title: title))
