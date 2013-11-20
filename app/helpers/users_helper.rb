module UsersHelper
  def role
    current_user.role
  end

  def admin?
    current_user.role == 'admin'
  end
end
