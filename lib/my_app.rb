require 'grape'

module MyApp
  class API < Grape::API
    prefix "api"
    format :json
    default_format :json

    get "/v1" do
      "text"
    end



  end
end
