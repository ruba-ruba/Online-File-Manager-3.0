class FileManager.Models.Folder extends Backbone.Model
  paramRoot: 'folder'

  parentUlSelector: ->
    parent_id = @get("parent_id")
    if parent_id == null
      ".folders_tree"
    else
      ".folder-" + parent_id

  childrenUlClass: ->
    "folder-" + @get("id")

class FileManager.Collections.FoldersCollection extends Backbone.Collection
  model: FileManager.Models.Folder

  initialize: (opts) ->
    if opts.tree
      @treeView = true
    else
      @treeView = false
    @urlRoot = opts.id

  url: ->
    if @treeView
      '/api/v3/folders'
    else
      '/api/v3/folders/' + @urlRoot + "/folders"
