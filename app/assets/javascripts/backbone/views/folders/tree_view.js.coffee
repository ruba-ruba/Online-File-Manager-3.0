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
    event.preventDefault()
    if event.target is @$('.near_icon')[0]
      FileManager.app.navigation.render_folder(@model.get("id"))
      FileManager.app.navigate("folders/" + @model.get("id"), {trigger: true}) 
