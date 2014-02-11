FileManager.Views.Filelists ||= {}

class FileManager.Views.Filelists.IndexView extends Backbone.View
  template: JST["backbone/templates/filelists/index"]

  initialize: (opts) ->
    @folders_collection = new FileManager.Collections.FoldersCollection(opts)
    @folders_collection.on('reset', @renderFolder, this)

    @items_collection = new FileManager.Collections.ItemsCollection(opts)
    @items_collection.on('reset', @renderItem, this)

  render: ->
    @$el.html(@template())
    @$table_el = @$('.filelist-t')
    @folders_collection.fetch()
    @items_collection.fetch()
    @

  renderFolder: ->
    @folders_collection.each (folder) =>
      view = new FileManager.Views.Folders.FolderView(model: folder)
      @$table_el.prepend(view.render().el)
    FileManager.app.navigation.render_folder_up()

  renderItem: ->
    @items_collection.each (item) =>
      view = new FileManager.Views.Items.ItemView(model: item)
      @$table_el.append(view.render().el)
