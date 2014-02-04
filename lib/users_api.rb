module UsersApi
  class API < Grape::API
    prefix "api"
    format :json
    default_format :json

    helpers FileManager::ApiHelpers 

    get "/v1/:token" do
      current_user.as_api
    end
  end
end
