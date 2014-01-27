FileManager::Application.routes.draw do
  
  get 'search', to: 'search_files#index', as: 'search'
  
  resources :locations

  root :to => 'folders#index'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :folders do
    resources :comments
    member do
     get 'download_folder', to: 'folders#download_folder' 
    end
  end

  resources :users
  get 'api/v2/:token', to: 'users#show_user_info', as: 'info', :defaults => { :format => 'json' }

  resources :items do
    resources :comments
    collection do
      get 'import_pages', to: 'items#import_pages', as: 'import_pages'
      post 'import_page', to: 'items#import_page', as: 'import_page'
      get 'duplicates', to: 'items#duplicates', as: 'duplicates'
    end
    member do
      get 'crop_image', to: 'items#crop_image'
      post 'crop_process', to: 'items#crop_process'
      get 'pdf' => 'items#pdf', :as => :pdf
      get 'show_pdf' => 'items#show_pdf'
      match 'add_recipient', to: 'items#add_recipient'
      post 'send_mail', to: 'items#send_mail'
    end
  end

  match 'pusher/auth'

  post "vote", to: 'votes#vote'

  #grape
  mount UsersApi::API => "/"
  mount FileManager::API  => "/"

  match 'send_daily_report', to: 'folders#send_daily_report'

  namespace :admin do
    resources :statistics
  end

  scope "api" do
    get 'filelists', to: 'home#home_new'    
  end
  match '*path', to: 'folders#index'
end
