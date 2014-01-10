class FileManagerMailer < ActionMailer::Base
   default :from => "file_uploader@site.com"

  def send_file(recipient, subject, file_path, file_name)
    attachments[file_name] = HTTParty.get(file_path).body
    mail(:to => recipient, :subject => subject,  body: "")
  end

  def send_comment(comment)
    @comment = comment
    @link = url_for([@comment.commentable, Comment])
    mail(:to => Settings.admin_mail,
         :subject => "New comment added by #{@comment.author}")
  end
end
