class AddGenreToAlbum < ActiveRecord::Migration
  def self.up
    add_column :albums, :genre, :string
  end

  def self.down
    remove_column :albums, :genre
  end
end
