FileManager.Views.Filelists ||= {}

class FileManager.Views.Filelists.IndexView extends Backbone.View
  template: JST["backbone/templates/filelists/index"]

  initialize: ->
    @collection.on('reset', @render, this)

  render: ->
    $(@el).html(@template(filelists: @collection))
    this
