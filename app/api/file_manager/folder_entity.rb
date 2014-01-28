require 'grape-entity'

module FileManager
  class FolderEntity < Grape::Entity
    extend ActionView::Helpers
    expose :id
    expose :title
    expose :parent_id
    expose :parent
    expose :ancestry
    expose :description
    expose :folder_size do |folder, options|
      folder.size
    end
  end
end
