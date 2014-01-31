class FileManager.Models.Navigation extends Backbone.Model
  paramRoot: 'folder'

  parentUlSelector: ->
    parent_id = @get("parent_id")
    if parent_id == null
      ".folders_tree"
    else
      ".folder-" + parent_id

  childrenUlClass: ->
    "folder-" + @get("id")

class FileManager.Collections.Navigation extends Backbone.Collection
  model: FileManager.Models.Navigation

  url: '/api/v3/folders?include_subfolders=true'
