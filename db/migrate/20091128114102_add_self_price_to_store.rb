class AddSelfPriceToStore < ActiveRecord::Migration
  def self.up
    add_column :stores, :self_price, :integer
  end

  def self.down
    remove_column :stores, :self_price
  end
end
