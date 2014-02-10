class FileManager.Models.Breadcrumb extends Backbone.Model
  paramRoot: 'folderParent'

  generate_route: ->
    id = @get("id")
    if id isnt null
      '/folders/' + id
    else
      '/folders'

class FileManager.Collections.Breadcrumbs extends Backbone.Collection
  model: FileManager.Models.Breadcrumb

  reset_bradcr_path: (path) -> 
    new_path = [{title: "My Documents", id: null}].concat path
    @reset(new_path)
