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
        format.html { render :nothing => true }
        format.js { render :layout => false }
      else
        format.html { render action: "new" }
        format.js
      end
    end
  end


  def edit
  end

  def update
  end
end




