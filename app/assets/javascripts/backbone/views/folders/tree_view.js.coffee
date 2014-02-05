FileManager.Views.Folders ||= {}

class FileManager.Views.Folders.TreeView extends Backbone.View
  template: JST["backbone/templates/folders/tree"]
  tagName: 'li'

  events:
    'click .tree_link': 'renderClickedFolder'

  render: ->
    @$el.html(@template(folder: @model))
    this

  renderClickedFolder: (event) ->
    @$el.parents(".container-fluid").trigger("treeClicked", [@])
    event.preventDefault()
    FileManager.app.navigate("folders/" + @model.get("id"), {trigger: true}) if event.target is @$('.near_icon')[0]
