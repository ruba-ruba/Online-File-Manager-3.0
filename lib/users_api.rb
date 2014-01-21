module UsersApi
  class API < Grape::API
    prefix "api"
    format :json
    default_format :json

    helpers do
      def current_user
        @current_user ||= User.find_by_token(params[:token])
        error! "token is invalid" if @current_user.nil?
        error!("token is expired", 401) if @current_user.expired?
        @current_user
      end
    end

    get "/v1/:token" do
      current_user.as_api
    end
  end
end
