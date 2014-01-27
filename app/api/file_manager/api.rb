require 'grape'

module FileManager
  class API < Grape::API
    prefix "api"
    format :json
    default_format :json
    version "v3"

    resource :items do
      get do
        Item.all
      end
      get ":id" do
        Item.find(params[:id])
      end 
    end

    
  end
end