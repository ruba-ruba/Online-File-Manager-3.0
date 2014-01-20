require 'spec_helper'

describe UsersApi::API do

  describe "GET /api/v1/:token" do
    let(:user){FactoryGirl.create(:user)}
    it "returns an user info" do
      get "/api/v1/#{user.token}"
      response.status.should == 200
      JSON.parse(response.body).should == user.as_api.stringify_keys
    end
  end

  describe "def current user" do
    let(:user){FactoryGirl.create(:user_wiht_token)}
    it "returns current_user" do
      get "/api/v1/#{user.token}"
      expect(user.token).to eq('baM80EgOTSifODeo8TxgyA')
    end
  end  

  describe "def current user" do 
    let(:user){FactoryGirl.create(:user)}
    it "returns errors" do
      get "/api/v1/#{user.token}"
      expect(user.token).not_to eq("baM80EgOTSifODeo8TxgyA")
    end
  end

  describe "def current user" do 
    let(:user){FactoryGirl.create(:user_wiht_expires)}
    it "returns errors" do
      get "/api/v1/#{user.token}"
      response.status.should == 401
    end
  end
end