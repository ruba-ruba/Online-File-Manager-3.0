class FileManager.Routers.FilelistsRouter extends Backbone.Router
  # initialize: (options) ->
  #   @filelists = new FileManager.Collections.FilelistsCollection()
  #   @filelists.reset options.filelists

  # routes:
  #   "new"      : "newFilelist"
  #   "index"    : "index"
  #   ":id/edit" : "edit"
  #   ":id"      : "show"
  #   ".*"        : "index"

  routes:
    'home-new': 'index'
 
  index: ->
    view = new FileManager.Views.Filelists.IndexView()
    $(".main_content.col-xs-10").html(view.render().el)
