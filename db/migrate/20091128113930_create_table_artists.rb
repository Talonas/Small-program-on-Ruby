class CreateTableArtists < ActiveRecord::Migration
  def self.up
    create_table :artists do |t|
    end
  end

  def self.down
    drop_table :artists
  end
end
