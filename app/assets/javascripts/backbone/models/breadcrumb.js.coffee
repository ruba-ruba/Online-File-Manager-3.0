class FileManager.Models.Breadcrumb extends Backbone.Model
  paramRoot: 'folderParent'

class FileManager.Collections.Breadcrumbs extends Backbone.Collection
  model: FileManager.Models.Breadcrumb
