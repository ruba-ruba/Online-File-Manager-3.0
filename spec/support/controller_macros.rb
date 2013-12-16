module ControllerMacros
  
  def login_user
    before(:each) do
      user = FactoryGirl.create(:user)
      session[:user_id] = user.id
    end
  end

end