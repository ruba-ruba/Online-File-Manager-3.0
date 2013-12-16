class FileMailer < ActionMailer::Base
   default :from => "file_uploader@site.com"

   def send_file(recipient, subject, message, sent_at = Time.now)
      @subject = subject
      @recipients = recipient
      @sent_on = sent_at
      @body["title"] = 'This is title'
      @body["email"] = 'sender@yourdomain.com'
      @body["message"] = message
      @headers = {}
   end
end