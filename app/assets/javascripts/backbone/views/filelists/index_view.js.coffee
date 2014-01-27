FileManager.Views.Filelists ||= {}

class FileManager.Views.Filelists.IndexView extends Backbone.View
  template: JST["backbone/templates/filelists/index"]

  initialize: ->
    @collection.on('reset', @render, this)

  render: ->
    $(@el).html(@template())
    @collection.each(@appendItem)
    this

  appendItem: (filelist) ->
    view = new FileManager.Views.Filelists.ItemView(model: filelist)
    $('#filelist').append(view.render().el)
