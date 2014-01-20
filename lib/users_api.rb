module UsersApi
  class API < Grape::API
    prefix "api"
    format :json
    default_format :json

    get :test do
      { :message => "pong" }
    end

    helpers do
      def authenticate!
       error!('Unauthorized. Invalid or expired token.', 401) unless current_user
      end
 
      def current_user
        user = User.find_by_token(params[:token])
        if user && !user.token_expired?

          @current_user = user
        else
          false
        end
      end
    end


    resource :auth do
   
      desc "Creates and returns access_token if valid email"
      params do
        requires :email, :type => String, :desc => "Email address"
        requires :password, :type => String, :desc => "Password"
      end

      post :email do
        user = User.find_by_email(params[:email].downcase)
        if user && user.valid_password?(params[:password])
          user.update_token
          {:token => user.token}
        else
          error!('Unauthorized.', 401)
        end
      end
   
      desc "Returns pong if logged in correctly"
      params do
        requires :token, :type => String, :desc => "Access token."
      end
      get :test do
        { :message => "pong" }
      end

      get :ping do
        authenticate!
        { :message => "pong" }
      end
    end

    rescue_from NoMethodError do |e|
      error_response({ message: "token is invalid" })
    end

    get "/v1/:token" do
      current_user.as_api
    end

  end
end
