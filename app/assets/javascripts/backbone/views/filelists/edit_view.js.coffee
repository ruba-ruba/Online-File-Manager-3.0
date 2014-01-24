FileManager.Views.Filelists ||= {}

class FileManager.Views.Filelists.EditView extends Backbone.View
  template: JST["backbone/templates/filelists/edit"]

  events:
    "submit #edit-filelist": "update"

  update: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success: (filelist) =>
        @model = filelist
        window.location.hash = "/#{@model.id}"
    )

  render: ->
    @$el.html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
