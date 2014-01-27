class FileManager.Models.Comment extends Backbone.Model
  paramRoot: 'comment'

class FileManager.Collections.CommentsCollection extends Backbone.Collection
  model: FileManager.Models.Comment
  url: '/api/v3/comments'
