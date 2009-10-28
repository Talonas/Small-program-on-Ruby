require 'rubygems'
require 'spec'
require 'classes/album'

describe Album do
  
  it "should create new empty album" do
    Album.new.should be_instance_of(Album)
  end
  
  it "should create new not empty album" do
    Album.new(1, 2, "name", 2009, "jazz").should be_instance_of(Album)
  end
  
  it "should have id, artist_id, name, year and genre" do
    album = Album.new(1, 2, "name", 2009, "genre")
    album.id.should == 1
    album.artist_id.should == 2
    album.name.should == "name"
    album.genre.should == "genre"
  end
  
  it "should rewrite attributes" do
    album = Album.new(1, 2, "name", 2009, "genre")
    album.id = 10
    album.artist_id = 21
    album.name = "test"
    album.year = 990
    album.genre = "rewrite" 
  end
  
end