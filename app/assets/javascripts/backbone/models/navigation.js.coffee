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

  isParentOf: (current_folder) ->
    folder_id = @get("id")
    ancestry_of_current_folder = current_folder.ancestryArray()
    anc_index = ancestry_of_current_folder.indexOf(folder_id+'')
    if anc_index is -1
      isParentOfCurrentFolder = false
    else
      isParentOfCurrentFolder = true
    isParentOfCurrentFolder

class FileManager.Collections.Navigation extends Backbone.Collection
  model: FileManager.Models.Navigation

  url: ->
    '/api/v3/folders?include_subfolders=true&token=' + FileManager.token
