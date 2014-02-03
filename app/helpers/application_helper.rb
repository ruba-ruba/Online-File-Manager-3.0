module ApplicationHelper
  def pdf(item)
    if item.file_file_name.split('.')[1] == 'pdf'
        "#{link_to icon(:page_go), show_pdf_item_path(item), :target => '_blank', :alt => 'Open PDF', :title => 'Open PDF', :rel => 'tooltip'}".html_safe 
    end
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    css_class = if column == sort_column
      "glyphicon glyphicon-chevron-" + (sort_direction == 'asc' ? 'up' : 'down')
    else
      "glyphicon glyphicon-resize-vertical"
    end
    title += content_tag(:span, nil, :class => css_class)
    link_to title.html_safe, {:sort => column, :direction => direction}
  end
end
