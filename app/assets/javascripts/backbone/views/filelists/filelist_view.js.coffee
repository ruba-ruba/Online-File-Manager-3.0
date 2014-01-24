FileManager.Views.Filelists ||= {}

class FileManager.Views.Filelists.FilelistView extends Backbone.View
  template: JST["backbone/templates/filelists/filelist"]

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    @$el.html(@template(@model.toJSON() ))
    return this
