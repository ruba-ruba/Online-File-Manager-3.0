module ApplicationHelper
  def pdf(item)
    if item.file_file_name.split('.')[1] == 'pdf'
      "#{link_to 'show', show_pdf_item_path(item), :target => '_blank'}".html_safe
    end
  end

  def content_icon(target)
    if target.class == Folder
      "#{icon(:folder)} #{ target.title}".html_safe
    else
      case target.file_content_type
      when "image/jpeg" 
        "#{icon(:picture)} #{content_tag(:span, target.file_file_name, class: "text")}".html_safe
      when "audio/mp3"
        "#{icon(:music)} #{content_tag(:span, target.file_file_name, class: "text")}".html_safe
      else
        "#{icon(:folder)} #{content_tag(:span, target.file_file_name, class: "text")}".html_safe
      end
    end    
  end
end
