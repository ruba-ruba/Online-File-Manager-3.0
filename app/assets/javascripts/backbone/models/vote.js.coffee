class FileManager.Models.Vote extends Backbone.Model
  paramRoot: 'vote'

class FileManager.Collections.VotesCollection extends Backbone.Collection
  model: FileManager.Models.Vote

  url: ->
    @base_url() + @token_param()

  base_url: ->
    '/api/v3/' + @commentable_type + "/" + @commentable_id + "/comments/" + comment.get("id") + "/vote"

  token_param: ->
    "?token=" + FileManager.token
