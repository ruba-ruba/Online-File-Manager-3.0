require 'action_view'

class DailyMailer < ActionMailer::Base
  default :from =>  Settings.admin_mail

  def daily_uploads
    yesterday = Time.now - 1.day
    @folders = Folder.where(:created_at => 
                yesterday.beginning_of_day..yesterday.end_of_day)
    @items = Item.where(:created_at => 
                yesterday.beginning_of_day..yesterday.end_of_day)
    @size = @items.sum(:file_file_size)
    mail(:to => Settings.admin_mail, 
                :subject => "Daily Report for #{yesterday.to_formatted_s(:long)}")
  end
end