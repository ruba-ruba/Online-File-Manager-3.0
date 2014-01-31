require 'grape'

module FileManager
  class API < Grape::API
    prefix "api"
    format :json
    default_format :json
    version "v3"

    resource :folders do
      get do
        present Folder.roots, with: FolderEntity
      end

      resource ":folder_id" do
        get  do
          present Folder.find(params[:folder_id]).children, with: FolderEntity
        end

        resource :items do
          get  do  
            present Folder.find(params[:folder_id]).items, with: ItemEntity
          end

          resource ":item_id" do
            get  do 
              present Item.find(params[:item_id]), with: ItemEntity
            end

            resource :comments do
              get do
                present Item.find(params[:item_id]).comments, with: CommentEntity
              end

              resource ":comment_id" do
                get do
                  present Comment.find(params[:comment_id]), with: CommentEntity
                end
              end
            end
          end
        end

        resource :comments do
          get do
            present Folder.find(params[:folder_id]).comments, with: CommentEntity
          end

          resource ":comment_id" do
            get do
              present Comment.find(params[:comment_id]), with: CommentEntity
            end
          end
        end
      end
    end

      resource :items do
        get  do  
          present Item.root, with: ItemEntity
        end
      end
  end
end