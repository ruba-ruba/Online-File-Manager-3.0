FileManager.Views.Folders ||= {}

class FileManager.Views.Folders.FoldersView extends Backbone.View
  template: JST["backbone/templates/folders/folders"]

  initialize: ->
    @collection = new FileManager.Collections.FoldersCollection()
    @collection.fetch()
    @collection.on('reset', @render, this)
    @collection.on('reset', @renderTree, this)

  render: ->
    @collection.each (folder) ->
      view = new FileManager.Views.Folders.FolderView(model: folder)
      $('#filelist-t').append(view.render().el)

  renderTree: ->
    new FileManager.Views.Folders.FolderTreeView().render()
    @collection.each (folder) ->
      view = new FileManager.Views.Folders.TreeView(model: folder)
      $('#folders_tree').append(view.render().el)
