FileManager.Views.Filelists ||= {}

class FileManager.Views.Filelists.NewView extends Backbone.View
  template: JST["backbone/templates/filelists/new"]

  events:
    "submit #new-filelist": "save"

  constructor: (options) ->
    super(options)
    @model = new @collection.model()

    @model.bind("change:errors", () =>
      this.render()
    )

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")

    @collection.create(@model.toJSON(),
      success: (filelist) =>
        @model = filelist
        window.location.hash = "/#{@model.id}"

      error: (filelist, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    @$el.html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
