module ApplicationHelper
  def pdf(item)
    if item.file_file_name.split('.')[1] == 'pdf'
      "#{link_to 'show', show_pdf_item_path(item), :target => '_blank'}".html_safe
    end
  end
end
