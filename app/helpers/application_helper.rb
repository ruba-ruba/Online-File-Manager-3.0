module ApplicationHelper
  def pdf(item)
    if item.file_file_name.split('.')[1] == 'pdf'
        "#{link_to icon(:page_go), show_pdf_item_path(item), :target => '_blank', :alt => 'Open PDF', :title => 'Open PDF', :rel => 'tooltip'}".html_safe 
    end
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction}, {:class => css_class}
  end

  def content_icon(target)
    if target.class == Folder
      "#{icon(:folder)} #{content_tag(:span, target.title, class: "text")}".html_safe
    else
      case target.file_content_type
      when "image/jpeg" 
        "#{icon(:picture)} #{content_tag(:span, target.file_file_name, class: "text")}".html_safe
      when "audio/mp3"
        "#{icon(:music)} #{content_tag(:span, target.file_file_name, class: "text")}".html_safe
      when "application/pdf"
        "#{icon(:page_white_acrobat)} #{content_tag(:span, target.file_file_name, class: "text")}".html_safe
      when "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
        "#{icon(:page_excel)} #{content_tag(:span, target.file_file_name, class: "text")}".html_safe
      when "application/vnd.ms-excel"
        "#{icon(:map)} #{content_tag(:span, target.file_file_name, class: "text")}".html_safe
      else
        "#{icon(:page)} #{content_tag(:span, target.file_file_name, class: "text")}".html_safe
      end
    end    
  end
end
