class FileManager.Models.Item extends Backbone.Model
  paramRoot: 'items'

class FileManager.Collections.ItemsCollection extends Backbone.Collection
  model: FileManager.Models.Item

  initialize: (opts) ->
    @folder_id = opts.folder_id

  url: ->
    if @folder_id == null
      '/api/v3/items'
    else
      '/api/v3/folders/' + @folder_id + "/items"