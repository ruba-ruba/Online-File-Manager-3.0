class FileManager.Models.Comment extends Backbone.Model
  paramRoot: 'comment'

class FileManager.Collections.CommentsCollection extends Backbone.Collection
  model: FileManager.Models.Comment

  url: ->
      if @folder_id
        '/api/v3/folders/' + @folder_id + "/comments"
      else
        '/api/v3/items/' + @item_id + "/comments"