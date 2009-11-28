class CreateTableUserHistory < ActiveRecord::Migration
  def self.up
    create_table :user_histories do |t|
    end
  end

  def self.down
    drop_table :user_histories
  end
end
