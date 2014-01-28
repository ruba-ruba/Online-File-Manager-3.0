require 'grape-entity'

module FileManager
  class ItemEntity < Grape::Entity
    extend ActionView::Helpers
    expose :size do |item, options|
      number_to_human_size(item.file_file_size)
    end
    expose :id
    expose :file_file_name
    expose :description
    expose :file_updated_at do |item, options|
      item.file_updated_at.strftime('%d/%m/%y %I:%M%p')
    end
    expose :extension do |item, options|
      item.extension
    end
    expose :file_path do |item, options|
      item.file.url
    end
    expose :mp3? do |item, options|
      item.is_mp3?
    end
  end
end