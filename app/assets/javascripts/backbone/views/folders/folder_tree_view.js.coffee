FileManager.Views.Folders ||= {}

class FileManager.Views.Folders.FolderTreeView extends Backbone.View
  template: JST["backbone/templates/folders/tree_menu"]

  render: ->
    $(".tree_menu").html(@template())
    this
