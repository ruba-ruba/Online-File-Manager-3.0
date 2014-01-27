FileManager.Views.Filelists ||= {}

class FileManager.Views.Filelists.ItemView extends Backbone.View
  template: JST["backbone/templates/filelists/item"]
  tagName: 'tr'
  events:
    'click': 'drawFooter'
  
  drawFooter: (event) ->
    event.preventDefault()
    content = JST["backbone/templates/filelists/item_footer"](model: @model)
    $("footer").html(content)

  render: ->
    $(@el).html(@template(filelist: @model))
    this
