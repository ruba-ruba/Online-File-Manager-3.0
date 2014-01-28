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
    end

    resource :folders do
      get do
        present Folder.all, with: FolderEntity
      end
      get ":id" do
        present Folder.find(params[:id]), with: FolderEntity
      end 
    end
  end
end