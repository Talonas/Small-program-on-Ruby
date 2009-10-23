require 'rubygems'
require 'spec'
require 'album'

describe Album do
  
  it "should create empty album" do
    Album.new.should be_instance_of(Album)
  end
  
  it "should create not empty album" do
    Album.new(1, 1, "album", 2009, "pop").should be_instance_of(Album)
  end
  
  it "should have id, artist_id, name, year and genre" do
    new_album = Album.new(1, 1, "album", 2009, "pop")
    new_album.id.should == 1
    new_album.artist_id.should == 1
    new_album.name.should == "album"
    new_album.year.should == 2009
    new_album.genre.should == "pop"
  end
  
end