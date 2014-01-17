module ControllerMacros
  def login_admin
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @current_user = FactoryGirl.create(:admin)
      sign_in :user, @current_user
    end
  end

  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @current_user = FactoryGirl.create(:user)
      sign_in :user, @current_user
    end
  end
end
