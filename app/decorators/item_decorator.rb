class ItemDecorator < Draper::Decorator
  include Famfamfam

  include ActionView::Helpers 
  include ActionView::Helpers::AssetTagHelper

  def content_icon_name
    case model.file_content_type
    when /jpeg|png/
      "picture"
    when /mp3|wav|octet-stream/
      "music"
    when "application/pdf"
      "page_white_acrobat"
    when "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      "page_excel"
    when "application/vnd.ms-excel"
      "map"
    else
      "page"
    end
  end

  def content_icon
    "<img align='bottom' border='0'class='icon' src='/assets/icons/fam-fam/16/#{content_icon_name}.png' />".html_safe
  end
end
