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

  reset_bradcr_path: (path, current_folder) ->
    new_path = [{title: "My Documents", id: null}].concat path
    if current_folder isnt undefined
      current_title = current_folder.get("title")
      current_id = current_folder.get("id")
      new_path = new_path.concat [{title: current_title, id: current_id, current: true}]
    @reset(new_path)
