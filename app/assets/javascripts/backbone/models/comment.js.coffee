class FileManager.Models.Comment extends Backbone.Model
  paramRoot: 'comment'
  url: ->
    model_id = @get("id")
    if typeof(model_id) == "undefined"
      @collection.url()
    else
      @collection.base_url() + "/" + model_id + @collection.token_param()

class FileManager.Models.VotedComment extends Backbone.Model
  paramRoot: 'vote'

  initialize: ->
    @on("change", @updateCollection, this)

  url: ->
    url_split = @comment.url().split("?")
    url = url_split[0] + "/vote?" + url_split[1]

  set_comment: (comment) ->
    @comment = comment
    this

  updateCollection: (changes) ->
    @comment.collection.add(changes, {merge: true})


class FileManager.Collections.CommentsCollection extends Backbone.Collection
  model: FileManager.Models.Comment

  initialize: (opts) ->
    @commentable_type = opts.commentable_type
    @commentable_id = opts.commentable_id

  url: ->
    @base_url() + @token_param()

  base_url: ->
    '/api/v3/' + @commentable_type + "/" + @commentable_id + "/comments"

  token_param: ->
    "?token=" + FileManager.token
