require 'grape'

module FileManager
  class API < Grape::API
    prefix "api"
    format :json
    default_format :json
    version "v3"

    resource :items do
      get do
        present Item.all, with: ItemEntity
      end
      get ":id" do
        present Item.find(params[:id]), with: ItemEntity
      end
    end

    resource :comments do
      get do
        present Comment.all, with: CommentEntity
      end
      get ":id" do
        present Comment.find(params[:id]), with: CommentEntity
      end
      post do
        binding.pry
      end
    end

    resource :folders do
      get do
        present Folder.all, with: FolderEntity
      end
      get ":id" do
        present Folder.find(params[:id]), with: FolderEntity
      end
      get ":id/folders" do        
        folders = if params[:id] == "root"
          Folder.roots
        else
          Folder.find(params[:id]).children
        end
        present folders, with: FolderEntity
      end
      get ":id/items" do
        items = if params[:id] == "root"
          Item.root
        else
          Folder.find(params[:id]).items
        end
        present items, with: ItemEntity
      end
    end

    resource :votes do
      get do
        present Vote.all, with: VoteEntity
      end
      get ":id" do
        present Vote.find(params[:id]), with: VoteEntity
      end 
    end
  end
end