class AddYearToAlbum < ActiveRecord::Migration
  def self.up
    add_column :albums, :year, :integer
  end

  def self.down
    remove_column :albums, :year
  end
end
