module RequestMacros

  def login_admin
    before(:each) do
      login_as FactoryGirl.create(:admin), :scope => :user
    end
  end

  def login_user
    before(:each) do
      login_as FactoryGirl.create(:user), :scope => :user
    end
  end
end