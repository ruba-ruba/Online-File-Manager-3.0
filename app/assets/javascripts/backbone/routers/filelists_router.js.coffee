class FileManager.Routers.FilelistsRouter extends Backbone.Router

  routes:
    'home-new': 'index'
    'comments': 'comments'

  comments: ->
    @comments = new FileManager.Collections.CommentsCollection()
    @comments.fetch()
    view = new FileManager.Views.Comments.IndexView(collection: @comments)
    $(".main_content.col-xs-10").html(view.render().el)
    
  index: ->
    view = new FileManager.Views.Filelists.IndexView()
    $(".main_content.col-xs-10").html(view.render().el)
