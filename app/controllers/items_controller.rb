class ItemsController < ApplicationController

  def index
  end
  
  def show
    @item = Item.find(params[:id])    
  end
  
  def new
    @item = Item.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @item =  current_user.items.build(params[:item])
    respond_to do |format|
      if @item.save
        format.html { redirect_to @item }
      else
        format.html { render action: "new" }
      end
    end
  end


  def edit
  end

  def update
  end
end




