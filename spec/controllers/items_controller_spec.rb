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

  describe "DELETE destroy" do
    let!(:item) {FactoryGirl.create(:item)}
    it "delete item" do
      sign_in :user, item.user
      request.env["HTTP_REFERER"]="/" 
      expect{delete :destroy, id: item.id}.to change(Item,:count).by(-1) 
    end
  end

  describe 'POST create' do
    let(:folder) { FactoryGirl.create(:folder) }
    it 'create new item without folder' do
      file =  fixture_file_upload('/test.csv', 'text/csv')
      item = {folder_id: nil, :file => file } 
      expect{ post :create, item: item }.to change(Item,:count).by(1)
    end

    it 'create new item with folder' do
      file =  fixture_file_upload('/test.csv', 'text/csv')
      item = {folder_id: folder.id, :file => file } 
      expect{ post :create, item: item }.to change(Item,:count).by(1)
      folder.items.should have(1).item
    end

    it 'create new item with folder' do 
      expect{ post :create, item: FactoryGirl.attributes_for(:item, file_file_name: nil) }.to change(Item,:count).by(0)
    end

    xit "should not create item when quota is overflowed" do
      file =  fixture_file_upload('/test.csv', 'text/csv')
      item = {folder_id: folder.id, :file => file}
      Item.any_instance.stubs(:check_quota).returns(false)
      expect{ post :create, item: item }.to change(Item,:count).by(0)
      response.should redirect_to(new_item_path)
    end
  end

  describe "PUT update" do
    let!(:old_item) {FactoryGirl.create(:item, :file_file_name =>"123123")}
    let!(:folder) {FactoryGirl.create(:folder, parent_id: Folder.first.id)}
    describe "valid attributes" do
      it "update item" do
        file =  fixture_file_upload('/test.csv', 'text/csv')
        item = {folder_id: folder.id, :file => file } 
        sign_in :user, old_item.user
        put :update, {id: old_item.id, item: item}
        old_item.reload
        old_item.file_file_name.should eq("test.csv")
        flash.should_not be_nil
        response.should redirect_to(old_item.folder)
      end
    end

    describe "invalid attributes" do
      it "should not update item" do
        item = {folder_id: folder.id, :file => nil} 
        sign_in :user, old_item.user
        put :update, {id: old_item.id, item: item}
        old_item.reload
        old_item.file_file_name.should eq("123123")
      end
    end
  end

  describe 'GET edit' do
    let(:item){FactoryGirl.create(:item)} 
    xit 'should render edit' do
      get :edit, id: item.id
      response.should be_success
      response.should render_template :edit
    end
  end

  describe 'GET show' do
    let(:item){FactoryGirl.create(:item)} 
    it 'should render show' do
      get :show, id: item.id
      response.should be_success
      response.should render_template :show
    end
  end
  
end
