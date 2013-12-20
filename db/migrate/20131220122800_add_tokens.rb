class AddTokens < ActiveRecord::Migration
  def up
    users = User.where(:token => nil)
    users.each do |user|
      user.token = user.send(:generate_token)
      user.save(:validate => false)
    end
  end

  def down
  end
end
