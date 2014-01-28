class FileManager.Models.Item extends Backbone.Model
  paramRoot: 'items'

class FileManager.Collections.ItemsCollection extends Backbone.Collection
  model: FileManager.Models.Item
  url: '/api/v3/items'