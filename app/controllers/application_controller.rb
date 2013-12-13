class ApplicationController < ActionController::Base
  protect_from_forgery
  # layout 'cosmo'
  helper_method :ancestor_ids_for_tree

  before_filter :current_user_quota

  def ancestor_ids_for_tree
  	session[:ancestor_ids] || [] 	
  end


  def current_user_quota
    quota = current_user.quota
    size = Item.where(user_id: current_user.id).pluck(:file_file_size).inject{|sum,x| sum + x }
    @taken = size*100/quota if size
    @total = quota
  end
end

