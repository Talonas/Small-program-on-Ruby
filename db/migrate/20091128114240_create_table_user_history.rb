class CreateTableUserHistory < ActiveRecord::Migration
  def self.up
    create_table :user_history do |t|
    end
  end

  def self.down
    drop_table :user_history
  end
end
