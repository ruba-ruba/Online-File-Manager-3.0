FileManager.Views.Navigation ||= {}

class FileManager.Views.Navigation.NavigationView extends Backbone.View

  el: '.nav-path'

  initialize: ->
    @collection = new FileManager.Collections.Navigation()
    @breadcrumbs = new FileManager.Collections.Breadcrumbs()
    new FileManager.Views.Navigation.BreadcrumbsView(collection: @breadcrumbs)
    new FileManager.Views.Navigation.TreeMenuView(collection: @collection)
    @collection.fetch()
    @collection.on('reset', @render_current_folder_breadcrumbs, this)

  set_current_folder_id: (folder_id) ->
    @current_folder_id = folder_id

  render_folder_breadcrumbs: (folder_id) ->
    if folder_id isnt null
      current_folder = @collection.get(folder_id)
      parents = current_folder.get("parents_info")
      title = current_folder.get("title")
      @breadcrumbs.reset_bradcr_path(parents)
      @draw_current_folder_breadcrumb(title)
    else
      @breadcrumbs.reset_bradcr_path([])

  render_current_folder_breadcrumbs: ->
    if @current_folder_id isnt undefined
      current_folder = @collection.get(@current_folder_id)
      parents = current_folder.get("parents_info")
      title = current_folder.get("title")
      @breadcrumbs.reset_bradcr_path(parents)
      @draw_current_folder_breadcrumb(title)
    else
      @breadcrumbs.reset_bradcr_path([])

  draw_current_folder_breadcrumb: (title) ->
    content = JST["backbone/templates/navigation/breadcrumb_current"]
    @$el.append(content(title: title))