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
    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render json: @item, status: :created, location: @item }
      else
        format.html { render action: "new" }
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
    name = "#{link.gsub('/','').gsub(':','')}.html"
    host = URI.parse(link).host
    begin
      response = HTTParty.get(link)
      create_file(user, folder, name, host, response.body)
    rescue Errno::ECONNREFUSED
       redirect_to import_pages_items_path, alert: 'url not correct'
    end
  end

  def create_file(user, folder, name, host, data)
    path = "public/stystem/web_pages/#{host}"
    dirname = ("#{Rails.root}/#{path}")
    unless File.directory?(dirname)
      FileUtils.mkdir_p(dirname)
    end
    data = data.encode "UTF-8"
    file = File.new("#{Rails.root}/#{path}/#{name}", 'wb+')
    File.open("#{Rails.root}/#{path}/#{name}", 'w+')  { |f| f.write(data)  }
    file_params = {user_id: user, folder_id: folder, file_name: name}
    Item.create_record(file_params, file)
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
