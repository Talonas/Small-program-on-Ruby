class CreateTableStore < ActiveRecord::Migration
  def self.up
    create_table :stores do |t|
    end
  end

  def self.down
    drop_table :stores
  end
end
