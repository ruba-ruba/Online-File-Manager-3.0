FileManager.Views.Filelists ||= {}

class FileManager.Views.Filelists.ShowView extends Backbone.View
  template: JST["backbone/templates/filelists/show"]

  render: ->
    @$el.html(@template(@model.toJSON() ))
    return this
