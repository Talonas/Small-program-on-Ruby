class AddUserIdToUserHistory < ActiveRecord::Migration
  def self.up
    add_column :user_histories, :user_id, :integer
  end

  def self.down
    remove_column :user_histories, :user_id
  end
end
