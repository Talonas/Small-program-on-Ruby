class AddPriceToUserHistory < ActiveRecord::Migration
  def self.up
    add_column :user_histories, :price, :integer
  end

  def self.down
    remove_column :user_histories, :price
  end
end
