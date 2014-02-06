FileManager.Views.Folders ||= {}

class FileManager.Views.Folders.BreadcrumbView extends Backbone.View
  template: JST["backbone/templates/folders/breadcrumb"]
  tagName: 'span'
  className: 'breadcr'
  
  render: ->
    $(@el).html(@template(folder: @model))
    this
# add event on click breadcrumb