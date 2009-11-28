class AddAlbumIdToStore < ActiveRecord::Migration
  def self.up
    add_column :stores, :album_id, :integer
  end

  def self.down
    remove_column :stores, :album_id
  end
end
