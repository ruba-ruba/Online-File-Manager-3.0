class FileManager.Models.Item extends Backbone.Model
  paramRoot: 'items'

class FileManager.Collections.ItemsCollection extends Backbone.Collection
  model: FileManager.Models.Item

  initialize: (opts) ->
    @urlRoot = opts.id

  url: ->
    '/api/v3/folders/' + @urlRoot + "/items"