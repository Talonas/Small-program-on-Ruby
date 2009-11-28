class AddAmountToStore < ActiveRecord::Migration
  def self.up
    add_column :stores, :amount, :integer
  end

  def self.down
    remove_column :stores, :amount
  end
end
