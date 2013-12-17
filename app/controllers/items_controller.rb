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
          if @item.folder_id.nil?
          @items = Item.without_folder
          else
          @items = Item.where(:folder_id => @item.folder_id)
          end
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
        format.html { render action: "new" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end


  def edit
    @item = Item.find params[:id]
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
     @item = Item.find params[:id]

    new_file_name = "original_" + params[:item][:file_file_name]
    path = @item.item.path.split("/")
    path.pop
    path_for_file = path.join("/")
    File.rename(@item.item.path ,  path_for_file + "/" + new_file_name)

    respond_to do |format|
      if @item.update_attributes(params[:item])
        if @item.folder_id.nil?
          @items = Item.without_folder
        else
          @items = Item.where(:folder_id => @item.folder_id)
        end


        format.html { redirect_to :back, notice: 'Item was successfully updated.' }
        format.json { head :no_content }
        format.js
      else
        format.html { render action: "edit" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  def add_recipient
  end

  def send_mail
    mail = params[:mail]
    recipient = mail[:recipient]
    subject = mail[:subject]
    file_path = mail[:file_path]
    file_name = mail[:file_name]
    FileMailer.send_file(recipient, subject, file_path, file_name).deliver
    redirect_to root_path, notice: 'emeil sent successfully'
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

  class PDF < Prawn::Document
    def to_pdf(path)
      data = File.read(path)
      text data
      render
    end
  end

  def pdf
    file = Item.find params[:id]
    path = file.file.path
    name = file.file_file_name.split('.')[0]
    file_name = "#{name}.pdf"
    output = PDF.new.to_pdf(path)
    respond_to do |format|
      format.pdf { 
        send_data output, filename: file_name, type: "application/pdf"
      }
    end
  end

  def show_pdf
    item = Item.find params[:id]
    path = item.file.path
    send_file(path,
              :disposition => 'inline',
              :type => 'application/pdf',
              :x_sendfile => true )

 def destroy
    @item = Item.find params[:id]
    @item.destroy

    respond_to do |format|
      if @item.folder_id.nil?
        @items = Item.without_folder
      else
        @items = Item.where(:folder_id => @item.folder_id)
      end
      format.js
    end
  end

  def destroy_by_type
    Item.destroy(params[:items])
    if params[:folder_id]
      @items = Item.where(:folder_id => params[:folder_id])      
    else
      @items = Item.without_folder
    end
    respond_to do |format|
      format.js
    end
  end

end
