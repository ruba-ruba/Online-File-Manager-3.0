class ItemsController < ApplicationController

  def create
    @item = current_user.items.build( params[:item] )
    @item.save
  end

  def new
    @item = Item.new
    respond_to do |format|
      format.html
    end
  end

  def show
    @item = Item.find(params[:id])    
  end

  def index
  end

  def edit
  end

  def update
  end
end




