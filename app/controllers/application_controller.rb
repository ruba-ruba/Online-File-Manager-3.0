class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :current_user_quota
  helper_method :back_url

  def current_user_quota    
    if current_user
      quota = current_user.quota
      size = current_user.items.sum(:file_file_size)
      @taken = size*100.to_f/quota if size
      @taken = @taken.to_s.truncate(4, :omission => "")
      @total = quota
    end
  end

  def back_url
    request.env["HTTP_REFERER"].present? && request.env["HTTP_REFERER"] != request.env["REQUEST_URI"] ? :back : folders_path
  end

end
