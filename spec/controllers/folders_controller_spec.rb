require 'spec_helper'

describe FoldersController do

  login_user

  let(:folder) {FactoryGirl.create(:folder_with_user)}
  let(:valid_attributes) { { "title" => "MyString" } }

  before do
    request.env["HTTP_REFERER"] = 'where_i_came_from'
  end

  describe "GET index" do
    it "assigns all folders as @folders" do
      get :index, {}
      assigns(:folders).should eq([folder])
    end
  end

  describe "download_folder" do
    it "should respond to dowload fplder" do
      get :download_folder, {:id => folder.to_param}
      expect(response).to be_success
    end
  end

  describe "GET show" do
    it "assigns the requested folder as @folder" do
      get :show, {:id => folder.to_param}
      assigns(:folder).should eq(folder)
    end
  end

  describe "GET new" do
    it "assigns a new folder as @folder" do
      get :new, {}
      assigns(:folder).should be_a_new(Folder)
    end
  end

  describe "GET edit" do
    it "assigns the requested folder as @folder" do
      get :edit, {:id => folder.to_param}
      assigns(:folder).should eq(folder)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Folder" do
        expect {
          post :create, {:folder => valid_attributes}
        }.to change(Folder, :count).by(1)
      end

      it "assigns a newly created folder as @folder" do
        post :create, {:folder => valid_attributes}
        assigns(:folder).should be_a(Folder)
        assigns(:folder).should be_persisted
      end

      it "redirects to the created folder" do
        post :create, {:folder => valid_attributes}
        response.should redirect_to(Folder.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved folder as @folder" do
        # Trigger the behavior that occurs when invalid params are submitted
        Folder.any_instance.stubs(:save).returns(false)
        post :create, {:folder => { "title" => "invalid value" }}
        assigns(:folder).should be_a_new(Folder)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Folder.any_instance.stubs(:save).returns(false)
        post :create, {:folder => { "title" => "invalid value" }}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested folder" do
        folder = FactoryGirl.create(:folder_with_user)
        sign_in :user, folder.user
        Folder.any_instance.expects(:update_attributes).with({ "title" => "MyString" })
        put :update, {:id => folder.to_param, :folder => { "title" => "MyString" }}
      end

      it "assigns the requested folder as @folder" do
        put :update, {:id => folder.to_param, :folder => valid_attributes}
        assigns(:folder).should eq(folder)
      end

      it "redirects to the folder" do
        folder = FactoryGirl.create(:folder_with_user)
        sign_in :user, folder.user
        put :update, {:id => folder.to_param, :folder => valid_attributes}
        response.should redirect_to(folder)
      end
    end

    describe "with invalid params" do
      it "assigns the folder as @folder" do
        Folder.any_instance.stubs(:save).returns(false)
        put :update, {:id => folder.to_param, :folder => { "title" => "invalid value" }}
        assigns(:folder).should eq(folder)
      end

      it "re-renders the 'edit' template" do
        folder = FactoryGirl.create(:folder_with_user, :title => 'sometitle')
        folder2 = FactoryGirl.create(:folder, :title => 'anothertitle')
        sign_in :user, folder.user
        put :update, {:id => folder.to_param, :folder => { "title" => 'anothertitle'}}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested folder" do
      folder = FactoryGirl.create(:folder_with_user)
      sign_in :user, folder.user
      request.env["HTTP_REFERER"] = 'where_i_came_from'
      expect {
        delete :destroy, {:id => folder.to_param}
      }.to change(Folder, :count).by(-1)
      expect(flash).not_to be_nil
      expect(response).to redirect_to 'where_i_came_from'
    end

    it "redirects to the folders list" do
      delete :destroy, {:id => folder.to_param}
      response.should redirect_to("where_i_came_from")
    end
  end

end
