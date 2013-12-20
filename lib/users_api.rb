module UsersApi
  class API < Grape::API
    prefix "api"
    format :json
    default_format :json

    helpers do
      def current_user
        @current_user ||= User.find_by_token params[:token]
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
