require 'pry'
require 'grape'

module MyApp
  class API < Grape::API
    prefix "api"
    format :json
    default_format :json

    get "/v1/:token" do
      user = User.find_by_token params[:token]
      if user
        info = {}
        total_quota = user.quota
        left_quota = user.items.sum(:file_file_size)
        info[:email] = user.email
        info[:total_quota] = total_quota
        info[:used] = left_quota
        info[:left_quota] = total_quota - left_quota
        info
      else
        'you have wrong api key'
      end
    end

  end
end
