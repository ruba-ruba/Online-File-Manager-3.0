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

  init: (opts) -> 
    @token = opts.token
    @app = new FileManager.Routers.FilelistsRouter
    Backbone.history.start
      root: '/manager/',
      pushState: true,
      silent: false
