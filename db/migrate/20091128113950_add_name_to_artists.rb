class AddNameToArtists < ActiveRecord::Migration
  def self.up
    add_column :artists, :name, :string
  end

  def self.down
    remove_column :artists, :name
  end
end
