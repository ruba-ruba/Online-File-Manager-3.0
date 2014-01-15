FileManager::Application.routes.draw do
  
  resources :duplicates


  resources :locations


  root :to => 'folders#index'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :folders do
    resources :comments
  end

  resources :users
  get 'api/v2/:token', to: 'users#show_user_info', as: 'info', :defaults => { :format => 'json' }


  resources :items do
    resources :comments 
    collection do
      get 'import_pages', to: 'items#import_pages', as: 'import_pages'
      post 'import_page', to: 'items#import_page', as: 'import_page'
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


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
