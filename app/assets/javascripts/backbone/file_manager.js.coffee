#= require_self
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers

window.FileManager =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}

  init: -> 
    new FileManager.Routers.FilelistsRouter
    Backbone.history.start()

$(document).ready ->
  FileManager.init()
