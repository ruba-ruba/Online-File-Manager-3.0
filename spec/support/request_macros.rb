module RequestMacros

  def login_admin
    before(:each) do
      @current_user = FactoryGirl.create(:admin)
      login_as @current_user, :scope => :user
    end
  end

  def login_user
    before(:each) do
      @current_user = FactoryGirl.create(:user)
      login_as @current_user, :scope => :user
    end
  end
end