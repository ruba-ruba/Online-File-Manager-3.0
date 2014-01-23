class ChangeUsersColomnCreateAt < ActiveRecord::Migration
  def up
    User.where(:expires_at => nil).each do |e|
      e.send :set_expiration
      e.active = true
      e.save
    end
  end

  def down
  end
end
