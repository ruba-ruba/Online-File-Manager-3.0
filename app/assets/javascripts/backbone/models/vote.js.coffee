class FileManager.Models.Vote extends Backbone.Model
  paramRoot: 'vote'

class FileManager.Collections.VotesCollection extends Backbone.Collection
  model: FileManager.Models.Vote
  url: '/api/v3/votes'