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

  ancestryArray: ->
    ancestry = @get("ancestry")
    if ancestry != null
      ancestry.split "/"
    else 
      []

  isParent: (current_folder) ->
    c_id = current_folder.get("id")
    anc_index = @ancestryArray().indexOf(c_id+'')


class FileManager.Collections.Navigation extends Backbone.Collection
  model: FileManager.Models.Navigation

  url: ->
    '/api/v3/folders?include_subfolders=true&token=' + FileManager.token
