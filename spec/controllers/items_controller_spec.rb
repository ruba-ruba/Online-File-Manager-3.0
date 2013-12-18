require 'spec_helper'

describe ItemsController do

  login_user

  describe 'GET new' do
    it 'should render new' do
      get :new
      response.should be_success
      response.should render_template :new
    end

    it 'should render new with folder id' do
      folder = FactoryGirl.create(:folder)
      get :new, :folder_id => folder.id
      response.should be_success
      response.should render_template :new
    end
  end


end
