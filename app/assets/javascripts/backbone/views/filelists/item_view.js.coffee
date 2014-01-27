FileManager.Views.Filelists ||= {}

class FileManager.Views.Filelists.ItemView extends Backbone.View
  template: JST["backbone/templates/filelists/item"]
  tagName: 'tr'
  
  render: ->
    $(@el).html(@template(filelist: @model))
    this
