require 'spec_helper'

describe UsersApi::API do
  describe "GET /api/v1/:token" do
    it "returns an user info" do
      user = FactoryGirl.create(:user)
      get "/api/v1/#{user.token}"
      response.status.should == 200
      JSON.parse(response.body).should == user.as_api.stringify_keys
    end

    it 'returns message' do
      
    end
  end
end