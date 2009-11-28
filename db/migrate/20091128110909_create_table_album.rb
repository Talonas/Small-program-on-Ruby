class CreateTableAlbum < ActiveRecord::Migration
  def self.up
    create_table :albums do |t|
    end
  end

  def self.down
    drop_table :albums
  end
end
