class AddAlbumIdToUserHistory < ActiveRecord::Migration
  def self.up
    add_column :user_history, :album_id, :integer
  end

  def self.down
    remove_column :user_history, :album_id
  end
end
