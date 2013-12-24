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
    @item = Item.new(:folder_id =>  params[:folder_id])
  end

  def create
    @item =  current_user.items.build(params[:item])
    respond_to do |format|
      if @item.save
        format.html {redirect_to @item.folder || :root, notice: 'Item was successfully created.'}
      else
        format.html {render 'new'}
        format.json { render json: @item.errors, status: :unprocessable_entity}
      end
    end
  end


  def edit  
     @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update_attributes(params[:item])
      redirect_to @item.folder || :root, notice: 'Item was successfully updated.'
    else
      render action: "edit"
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
  end

 def destroy
    @item = Item.find(params[:id])
    @item.destroy
    flash[:success] = "Items destroyed."
    redirect_to @item.folder || root_path
  end

  def download_file    
    item = Item.find(params[:id])
    path = item.file.path
    send_file(path,
              :type => item.file_content_type)
  end
end
