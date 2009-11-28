class AddPriceToStore < ActiveRecord::Migration
  def self.up
    add_column :stores, :price, :integer
  end

  def self.down
    remove_column :stores, :price
  end
end
