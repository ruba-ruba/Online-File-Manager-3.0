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
      number_to_human_size(folder.size)
    end
    expose :updated_at do |folder, options|
      folder.updated_at.strftime('%d/%m/%y %I:%M%p')
    end
    expose :has_children? do |folder, options|
      folder.has_children?
    end    
  end
end
