FileManager.Views.Folders ||= {}

class FileManager.Views.Folders.FolderTreeView extends Backbone.View
  template: JST["backbone/templates/folders/tree_menu"]

  render: ->
    $(".menu.col-xs-2").html(@template())
    this
