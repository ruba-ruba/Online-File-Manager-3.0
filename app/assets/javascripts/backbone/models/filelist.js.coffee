class FileManager.Models.Filelist extends Backbone.Model
  paramRoot: 'filelist'

class FileManager.Collections.FilelistsCollection extends Backbone.Collection
  model: FileManager.Models.Filelist
  url: '/api/v3/items'
