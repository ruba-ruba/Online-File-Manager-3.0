module UsersHelper
  def role
    current_user.role
  end

  def admin?
    current_user.role == 'admin'
  end

  def user_info(user)
    if user
      info = {}
      total_quota = user.quota
      left_quota = user.items.sum(:file_file_size)
      info[:email] = user.email
      info[:total_quota] = total_quota
      info[:used] = left_quota
      info[:left_quota] = total_quota - left_quota
      info
    else
      'you have wrong api key'
    end
  end
  
end
