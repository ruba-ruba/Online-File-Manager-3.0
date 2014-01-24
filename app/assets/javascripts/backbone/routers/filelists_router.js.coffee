class FileManager.Routers.FilelistsRouter extends Backbone.Router

  routes:
    'home-new': 'index'

  initialize: ->
    @collection = new FileManager.Collections.FilelistsCollection()
    @collection.fetch()
    
  index: ->
    view = new FileManager.Views.Filelists.IndexView(collection: @collection)
    $(".main_content.col-xs-10").html(view.render().el)
