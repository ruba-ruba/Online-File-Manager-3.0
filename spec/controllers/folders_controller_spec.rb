require 'spec_helper'

describe FoldersController do

  login_user

  let(:valid_attributes) { { "title" => "MyString" } }

  describe "GET index" do
    it "assigns all folders as @folders" do
      folder = Folder.create! valid_attributes
      get :index, {}
      assigns(:folders).should eq([folder])
    end
  end

  describe "GET show" do
    it "assigns the requested folder as @folder" do
      folder = Folder.create! valid_attributes
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
      folder = Folder.create! valid_attributes
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
        folder = Folder.create! valid_attributes
        # Assuming there are no other folders in the database, this
        # specifies that the Folder created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Folder.any_instance.expects(:update_attributes).with({ "title" => "MyString" })
        put :update, {:id => folder.to_param, :folder => { "title" => "MyString" }}
      end

      it "assigns the requested folder as @folder" do
        folder = Folder.create! valid_attributes
        put :update, {:id => folder.to_param, :folder => valid_attributes}
        assigns(:folder).should eq(folder)
      end

      it "redirects to the folder" do
        folder = Folder.create! valid_attributes
        put :update, {:id => folder.to_param, :folder => valid_attributes}
        response.should redirect_to(folder)
      end
    end

    describe "with invalid params" do
      it "assigns the folder as @folder" do
        folder = Folder.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Folder.any_instance.stubs(:save).returns(false)
        put :update, {:id => folder.to_param, :folder => { "title" => "invalid value" }}
        assigns(:folder).should eq(folder)
      end

      it "re-renders the 'edit' template" do
        folder = Folder.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Folder.any_instance.stubs(:save).returns(false)
        put :update, {:id => folder.to_param, :folder => { "title" => "invalid value" }}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested folder" do
      folder = Folder.create! valid_attributes
      expect {
        delete :destroy, {:id => folder.to_param}
      }.to change(Folder, :count).by(-1)
    end

    it "redirects to the folders list" do
      folder = Folder.create! valid_attributes
      delete :destroy, {:id => folder.to_param}
      response.should redirect_to(folders_url)
    end
  end

end
