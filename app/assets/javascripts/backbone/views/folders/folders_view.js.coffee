FileManager.Views.Folders ||= {}

class FileManager.Views.Folders.FoldersView extends Backbone.View
  template: JST["backbone/templates/folders/folders"]

  initialize: (opts) ->
    @collection = new FileManager.Collections.FoldersCollection(opts)
    @collection.fetch()
    @collection.on('reset', @render, this)

  render: ->
    @collection.each (folder) ->
      view = new FileManager.Views.Folders.FolderView(model: folder)
      $('#filelist-t').prepend(view.render().el)
