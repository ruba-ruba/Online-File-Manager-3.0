FileManager.Views.Folders ||= {}

class FileManager.Views.Items.ItemsView extends Backbone.View

  initialize: (opts) ->
    @collection = new FileManager.Collections.ItemsCollection(opts)
    @collection.fetch()
    @collection.on('reset', @render, this)

  render: ->
    @collection.each (item) ->
      view = new FileManager.Views.Items.ItemView(model: item)
      $('#filelist-t').append(view.render().el)