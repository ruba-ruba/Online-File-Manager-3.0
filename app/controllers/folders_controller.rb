require 'zip'

class FoldersController < ApplicationController
  
  helper_method  :sort_column, :item_sort_column, :sort_direction
  before_filter  :authenticate_user!, :except => [:index, :show]
  before_filter  :find_folder_and_check_manageability, :only => [:edit, :update, :destroy]

  def index
    @folders = Folder.roots.order(sort_column + ' ' + sort_direction)
    @items = Item.root.order(item_sort_column + ' ' + sort_direction)
  end

  def show
    @folder = Folder.find(params[:id])
    @folders = @folder.children.order(sort_column + ' ' + sort_direction)
    @items = @folder.items.order(item_sort_column + ' ' + sort_direction)    
  end

  def new
    @folder = Folder.new
  end

  def edit
  end

  def create
    @folder = current_user.folders.build(params[:folder])
    if @folder.save
      flash[:notice] = "Folder was successfully created."
      redirect_to @folder
    else
      flash[:error] = @folder.errors.full_messages.join(", ")
      render action: "new"
    end
  end

  def update
    if @folder.update_attributes(params[:folder])
      redirect_to @folder, notice: 'Folder was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @folder.destroy
    flash[:notice] = "Folder was successfully deleted."
    redirect_to :back
  end

  def send_daily_report
    DailyMailer.daily_uploads.deliver
    flash[:notice] = "Email was successfully send."
    redirect_to :root
  end

  def download_folder
    headers['Cache-Control'] = 'no-cache'  
    tmp_filename = "#{Rails.root}/tmp/tmp_zip_" <<
                    Time.now.strftime('%Y-%m-%d-%H%M%S-%N').to_s <<   
                    ".zip"
    zip = Zip::File.open(tmp_filename, Zip::File::CREATE) 
    zip.close
    send_data(File.open(tmp_filename, "rb+").read, :type => 'application/zip', :disposition => 'attachment', :filename => tmp_filename.to_s)
    File.delete tmp_filename
  end

  private

    def find_folder_and_check_manageability
      @folder = Folder.find(params[:id])
      unless current_user.can_manage?(@folder)  
        flash[:error] = "you can not do that"
        redirect_to :back and return  
      end
    end

    def sort_direction
      if %w[asc desc].include?(params[:direction])
        cookies[:cookie_sorting] = params[:direction]
      else
        cookies[:cookie_sorting] || "asc"
      end
    end

    def sort_column
      if Folder.column_names.include?(params[:sort])
        cookies[:cookie_column] = params[:sort]
      else
        cookies[:cookie_column] || "title"
      end
    end

    def item_sort_column
      Item.column_names.include?(params[:items_sort]) ? params[:items_sort] : "file_file_name"
    end

end
