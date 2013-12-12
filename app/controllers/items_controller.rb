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



  def import_page
    if params['/items/import_page']
      link = params['/items/import_page'][:url]
      name = "#{link.gsub('/','').gsub(':','')}.html"
      host = URI.parse(link).host
      response = HTTParty.get(link)
      create_file(name, host, response.body)
    end
  end

  def create_file(name, host, data)
    dirname = ("#{Rails.root}/public/stystem/web_pages/#{host}")
    unless File.directory?(dirname)
      FileUtils.mkdir_p(dirname)
    end
    data = data.encode "UTF-8"
    file = File.new("#{Rails.root}/public/stystem/web_pages/#{host}/#{name}", 'wb+')
    binding.pry
    File.open("#{Rails.root}/public/stystem/web_pages/#{host}/#{name}", 'w+')  { |f| f.write(data)  }
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
