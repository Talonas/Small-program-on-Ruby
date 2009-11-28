class AddAlbumIdToUserHistory < ActiveRecord::Migration
  def self.up
    add_column :user_histories, :album_id, :integer
  end

  def self.down
    remove_column :user_histories, :album_id
  end
end
