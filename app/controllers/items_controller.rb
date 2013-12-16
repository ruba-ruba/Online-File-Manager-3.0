class ItemsController < ApplicationController
  require 'fileutils'
  require 'uri'

  before_filter :authenticate_user!

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
    if @item.valid?
      if @item.check_quota 
        if @item.save
          respond_to do |format|
            format.html { redirect_to @item, notice: 'Item was successfully created.' }
          end
        end
      else
        respond_to do |format|
          format.html { redirect_to new_item_path, alert: " limit of space" }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to new_item_path}
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end


  def edit
  end

  def update
  end

  def import_pages 
  end

  def import_page
    user = params[:import][:user_id]
    folder = params[:import][:folder_id]
    link = params[:import][:url]
    host = URI.parse(link).host
    name = Item.file_name(link, host)
    begin
      response = HTTParty.get(link)
      create_file(user, folder, name, host, response.body)
    rescue Exception => exc
       redirect_to import_pages_items_path, alert: "url not correct #{exc}"
    end
  end

  def create_file(user, folder, name, host, data)
    Item.create_file(user, folder, name, host, data)
    respond_to do |format|
      @folder = Folder.find(params[:folder_id]) if params[:folder_id]
      message = "#{host}/#{name} was successfully created"
      if @folder.present?
        format.html {redirect_to @folder, notice: message }
      else
        format.html {redirect_to root_path, notice: message }
      end
    end
  end
end
