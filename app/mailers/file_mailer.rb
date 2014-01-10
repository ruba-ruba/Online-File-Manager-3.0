class FileMailer < ActionMailer::Base
   default :from => "file_uploader@site.com"

   def send_file(recipient, subject, file_path, file_name)
      attachments[file_name] = HTTParty.get(file_path).body
      mail(:to => recipient, :subject => subject,  body: "")
   end
end