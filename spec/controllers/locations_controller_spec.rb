require 'spec_helper'#

describe LocationsController do

  login_user

  let(:valid_attributes) { { "latitude" => 90.0,  "longitude" => 90.0} }

  describe "GET index" do
    let!(:item) {FactoryGirl.create(:item)}
    let!(:location1) {FactoryGirl.create(:location, :item_id => item.id)}
    let!(:location2) {FactoryGirl.create(:location, :item_id => item.id)}
    let!(:location3) {FactoryGirl.create(:location, :item_id => item.id)}
    it "assigns all locations as @locations" do
      get :index, :item_id => item.id
      assigns(:locations).should eq([location1, location2, location3])
      response.should be_success
      response.should render_template :index
    end
  end

  describe "GET show" do
    let!(:location) {FactoryGirl.create(:location)}
    it "render show" do
      get :show, {:id => location.id}
      assigns(:location).should eq(location)
      response.should be_success
      response.should render_template :show
    end
  end

  describe "GET new" do
    it "render new" do
      get :new
      assigns(:location).should be_a_new(Location)
      response.should be_success
      response.should render_template :new
    end
  end

  describe "GET edit" do
    let!(:location) {FactoryGirl.create(:location)}
    it "render edit" do
      get :edit, {:id => location.id}
      assigns(:location).should eq(location)
      response.should be_success
      response.should render_template :edit
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Location" do
        expect {post :create, {:location => valid_attributes}}.to change(Location, :count).by(1)
      end

      it "assigns a newly created location as @location" do
        post :create, {:location => valid_attributes}
        assigns(:location).should be_a(Location)
        assigns(:location).should be_persisted
      end

      it "redirects to the created location" do
        post :create, {:location => valid_attributes}
        response.should redirect_to(Location.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved location as @location" do
        expect {post :create}.to change(Location, :count).by(0)
        assigns(:location).should be_a_new(Location)
        response.should render_template :new
      end
    end
  end

  describe "PUT update" do
    let!(:location) {FactoryGirl.create(:location)}
    describe "with valid params" do
      it "updates the requested location" do
        put :update, {:id => location.to_param, :location => { "latitude" => 91.0,  "longitude" => 91.0}}
      end

      it "assigns the requested location as @location" do
        put :update, {:id => location.id, :location => valid_attributes}
        assigns(:location).should eq(location)
      end

      it "redirects to the location" do
        put :update, {:id => location.id, :location => valid_attributes}
        response.should redirect_to(location)
      end
    end

    describe "with invalid params" do
      let!(:location) {FactoryGirl.create(:location)}
      it "assigns the location as @location" do
        put :update, {:id => location.id}
        assigns(:location).should eq(location)
      end

      it "re-renders the 'edit' template" do
        put :update, {:id => location.id, :location => { :latitude => nil,  :longitude => nil}}
        response.should render_template :edit
      end
    end
  end

  describe "DELETE destroy" do
    let!(:location) {FactoryGirl.create(:location)}
    it "delete location" do
      expect {delete :destroy, id: location.to_param}.to change(Location, :count).by(-1)
      response.should redirect_to(locations_url)
    end
  end

end
