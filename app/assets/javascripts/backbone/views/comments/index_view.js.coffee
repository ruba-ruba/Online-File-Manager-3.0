FileManager.Views.Comments ||= {}

class FileManager.Views.Comments.IndexView extends Backbone.View
  template: JST["backbone/templates/comments/index"]

  # initialize: ->
  #   @collection.on('reset', @render, this)

  render: ->
    $(@el).html(@template())
    this

  # appendItem: (filelist) ->
  #   view = new FileManager.Views.Filelists.ItemView(model: filelist)
  #   $('#filelist-t').append(view.render().el)
