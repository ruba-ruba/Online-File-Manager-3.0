FileManager.Views.Folders ||= {}

class FileManager.Views.Folders.FolderTreeView extends Backbone.View
  template: JST["backbone/templates/folders/tree_menu"]

  initialize: ->
    @collection = new FileManager.Collections.Navigation()
    @collection.fetch()
    @collection.on('reset', @render, this)

  render: ->
    $(".tree_menu").html(@template())
    @collection.each (folder) ->
      view = new FileManager.Views.Folders.TreeView(model: folder)
      $(folder.parentUlSelector()).append(view.render().el)
    this
