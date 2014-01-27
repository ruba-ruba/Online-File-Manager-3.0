class FileManager.Routers.FilelistsRouter extends Backbone.Router

  routes:
    'home-new': 'index'
    'comments': 'comments'

  initialize: ->
    @collection = new FileManager.Collections.FilelistsCollection()
    @collection.fetch()

  comments: ->
    @comments = new FileManager.Collections.CommentsCollection()
    @comments.fetch()
    view = new FileManager.Views.Comments.IndexView(collection: @comments)
    $(".main_content.col-xs-10").html(view.render().el)
    
  index: ->
    view = new FileManager.Views.Filelists.IndexView(collection: @collection)
    $(".main_content.col-xs-10").html(view.render().el)


