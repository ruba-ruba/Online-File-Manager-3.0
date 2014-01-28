class FileManager.Models.Folder extends Backbone.Model
  paramRoot: 'folder'

class FileManager.Collections.FoldersCollection extends Backbone.Collection
  model: FileManager.Models.Folder
  url: '/api/v3/folders'