FileManager.Views.Navigation ||= {}

class FileManager.Views.Navigation.TreeMenuView extends Backbone.View
  template: JST["backbone/templates/navigation/tree_menu"]
  el: '.tree_menu'

  initialize: ->
    @collection.on('reset', @render, this)

  render: ->
    @$el.html(@template())
    @collection.each (folder) ->
      view = new FileManager.Views.Navigation.TreeView(model: folder)
      @$(folder.parentUlSelector()).append(view.render().el)
    this