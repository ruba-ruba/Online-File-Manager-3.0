class ItemsController < ApplicationController
  require 'fileutils'
  require 'uri'

  before_filter :authenticate_user!
  before_filter  :find_item_and_check_manageability, :only => [:edit, :update, :destroy]


  def index
  end
  
  def show
    @item = Item.find(params[:id])    
  end
  
  def new
    @item = Item.new(:folder_id =>  params[:folder_id])
  end

  def create
    @item =  Item.new({:user_id => current_user.id}.merge(params[:item]))
    respond_to do |format|
      if @item.save
        format.html {redirect_to @item.folder || :root, notice: 'Item was successfully created.'}
      else
        flash[:error] = @item.errors.full_messages.join(", ")
        format.html {render 'new'}
        format.json { render json: @item.errors, status: :unprocessable_entity}
      end
    end
  end


  def edit  
  end

  def update
    if @item.update_attributes(params[:item])
      redirect_to @item.folder || :root, notice: 'Item was successfully updated.'
    else
      render action: "edit"
    end
  end

  def add_recipient
    @item = Item.find params[:id]
  end

  def send_mail
    mail = params[:mail]
    recipient = mail[:recipient]
    subject = mail[:subject]
    item = Item.find params[:id]
    file_path = item.file.path
    file_name = item.file_file_name
    FileMailer.send_file(recipient, subject, file_path, file_name).deliver
    redirect_to root_path, notice: 'email sent successfully'
  end

  def import_pages 
  end

  def import_page
    folder = params[:import][:folder_id]
    link = params[:import][:url]
    host = URI.parse(link).host
    name = Item.file_name(link, host)
    response = HTTParty.get(link)
    create_file(current_user.id, folder, name, host, response.body)
    rescue Exception => exc
      redirect_to import_pages_items_path, alert: "url not correct #{exc}"
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

  def crop_image
    @image = Item.find params[:id]
  end

  def crop_process
    @image = Item.find params[:id]
    @image.reprocess_file
    respond_to do |format|
    end
  end


 def destroy
    @item.destroy
    flash[:success] = "Items destroyed."
    redirect_to @item.folder || root_path
  end

  private

    def find_item_and_check_manageability
      @item = Item.find(params[:id])
      unless current_user.can_manage?(@item)  
        flash[:error] = "you can not do that"
        redirect_to :back and return  
      end
    end
end
