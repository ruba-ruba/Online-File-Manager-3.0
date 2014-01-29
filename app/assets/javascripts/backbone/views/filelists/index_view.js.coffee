FileManager.Views.Filelists ||= {}

class FileManager.Views.Filelists.IndexView extends Backbone.View
  template: JST["backbone/templates/filelists/index"]

  initialize: (opts) ->
    new FileManager.Views.Folders.FoldersView(opts)
    new FileManager.Views.Items.ItemsView(opts)

  render: ->
    $(@el).html(@template())
    this
