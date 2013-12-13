class ApplicationController < ActionController::Base
  protect_from_forgery
  # layout 'cosmo'
  helper_method :ancestor_ids_for_tree

  def ancestor_ids_for_tree
  	session[:ancestor_ids] || [] 	
  end
end

