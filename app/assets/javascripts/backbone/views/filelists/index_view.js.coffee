FileManager.Views.Filelists ||= {}

class FileManager.Views.Filelists.IndexView extends Backbone.View
  template: JST["backbone/templates/filelists/index"]

  initialize: ->
    new FileManager.Views.Folders.FoldersView()
    new FileManager.Views.Items.ItemsView()

  render: ->
    $(@el).html(@template())
    this
