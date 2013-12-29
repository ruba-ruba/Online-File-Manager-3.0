class AddVotesToComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :votes_up, :integer
    add_column :comments, :votes_down, :integer
  end

  def self.down
    remove_column :comments, :votes_up
    remove_column :comments, :votes_down
  end
end
