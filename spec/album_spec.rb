require 'rubygems'
require 'spec'
require 'classes/album'
require 'classes/store'
require 'modules/activerecord'

describe Album do
  
  it "should create new empty album" do
    Album.new.should be_instance_of(Album)
  end
  
  it "should have id, artist_id, name, year and genre" do
    album = Album.new(1, 2, "name", 2009, "genre")
    album.id.should == 1
    album.artist_id.should == 2
    album.name.should == "name"
    album.genre.should == "genre"
  end
  
  it "should sell album for user" do
    album = ActiveRecord.find("Album", 1)
    album.sell 1
  end
  
  it "should not allow to sell album if it's amount is 0" do
    album = Album.new(999, 1, "album_name", 2009, "jazz")
    album.sell(1).should be_false
  end

end
