class FileManager.Routers.FilelistsRouter extends Backbone.Router

  routes:
    'home-new': 'index'
    'comments': 'comments'
    'folders-new/:id': 'foldersNew'

  initialize: ->
    new FileManager.Views.Folders.FolderTreeView().render()

  comments: ->
    @comments = new FileManager.Collections.CommentsCollection()
    @comments.fetch()
    view = new FileManager.Views.Comments.CommentsView(collection: @comments)
    $(".main_content.col-xs-10").html(view.render().el)
    
  index: ->
    view = new FileManager.Views.Filelists.IndexView(id: "root")
    $(".main_content.col-xs-10").html(view.render().el)

  foldersNew: (folder_id) ->
    view = new FileManager.Views.Filelists.IndexView(id: folder_id)
    $(".main_content.col-xs-10").html(view.render().el)