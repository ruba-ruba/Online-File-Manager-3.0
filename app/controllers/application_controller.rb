class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :current_user_quota

  def current_user_quota
    if current_user
      quota = current_user.quota
      size = Item.where(user_id: current_user.id).pluck(:file_file_size).inject{|sum,x| sum + x }
      @taken = size*100.to_f/quota if size
      @taken = @taken.to_s.truncate(4, :omission => "")
      @total = quota
    end
  end

end

