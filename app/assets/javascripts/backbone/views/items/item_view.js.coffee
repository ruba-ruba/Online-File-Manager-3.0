FileManager.Views.Items ||= {}

class FileManager.Views.Items.ItemView extends Backbone.View
  template: JST["backbone/templates/items/item"]
  tagName: 'tr'
  events:
    'click': 'drawFooter'
  
  drawFooter: (event) ->
    event.preventDefault()
    content = JST["backbone/templates/items/item_footer"](model: @model)
    $("footer").html(content)
    $('audio').mediaelementplayer()

  render: ->
    $(@el).html(@template(item: @model))
    this
