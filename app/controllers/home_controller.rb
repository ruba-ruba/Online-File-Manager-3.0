class HomeController < ApplicationController
  respond_to :json

  def index    
  end

  def home_new
    respond_with Item.all
  end
end
