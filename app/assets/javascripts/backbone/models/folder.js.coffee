class FileManager.Models.Folder extends Backbone.Model
  paramRoot: 'folder'

class FileManager.Collections.FoldersCollection extends Backbone.Collection
  model: FileManager.Models.Folder

  initialize: (opts) ->
    @folder_id = opts.folder_id

  url: ->
    if @folder_id == null
      '/api/v3/folders?token=' + FileManager.token
    else
      '/api/v3/folders/' + @folder_id + "?token=" + FileManager.token