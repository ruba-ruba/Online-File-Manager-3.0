class FileManager.Routers.FilelistsRouter extends Backbone.Router

  routes:
    'folders': 'index'
    'comments': 'comments'
    'folders/:id': 'folderId'

  initialize: ->
    new FileManager.Views.Folders.FolderTreeView().render()

  comments: ->
    @comments = new FileManager.Collections.CommentsCollection()
    @comments.fetch()
    view = new FileManager.Views.Comments.CommentsView(collection: @comments)
    $(".main_content.col-xs-10").html(view.render().el)
    
  index: ->
    view = new FileManager.Views.Filelists.IndexView(folder_id: null)
    $(".main_content.col-xs-10").html(view.render().el)

  folderId: (folder_id) ->
    view = new FileManager.Views.Filelists.IndexView(folder_id: folder_id)
    $(".main_content.col-xs-10").html(view.render().el)