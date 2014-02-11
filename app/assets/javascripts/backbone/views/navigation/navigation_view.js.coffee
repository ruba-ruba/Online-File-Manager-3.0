FileManager.Views.Navigation ||= {}

class FileManager.Views.Navigation.NavigationView extends Backbone.View
  el: '.container-fluid'
  events: 
    'click .up': 'navigate_folder_up'

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
      @breadcrumbs.reset_bradcr_path(parents, current_folder)
    else
      @breadcrumbs.reset_bradcr_path([])

  render_current_folder_breadcrumbs: ->
    if @current_folder_id isnt null
      current_folder = @collection.get(@current_folder_id)
      parents = current_folder.get("parents_info")
      title = current_folder.get("title")
      @breadcrumbs.reset_bradcr_path(parents, current_folder)
    else
      @breadcrumbs.reset_bradcr_path([])

  render_folder_up: ->
    if @current_folder_id isnt null
      content = JST["backbone/templates/folders/folder_up"]
      @$(".filelist-t").prepend(content())

  navigate_folder_up: (ev) ->
    current_folder = @collection.get(@current_folder_id)
    parent_id = current_folder.get("parent").id
    FileManager.app.navigation.render_folder_breadcrumbs(parent_id)
    FileManager.app.navigate("folders/" + parent_id, {trigger: true})
