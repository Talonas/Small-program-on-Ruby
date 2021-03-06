require 'rubygems'
require 'spec'
require 'classes/artist'
require 'classes/album'

describe Artist do
  
  it "should create a new empty artist" do
    Artist.new.should be_instance_of(Artist)
  end
  
  it "should create a new artist with id and name" do
    Artist.new(1, "artist").should be_instance_of(Artist)
  end
  
  it "should have id and name" do
    artist = Artist.new(1, "artist")
    artist.id.should == 1
    artist.name.should == "artist"
  end
  
  it "should allow rewrite id and name" do
    artist = Artist.new
    artist.id = 10
    artist.name = "test"
  end
  
  it "should get all artist's albums" do
    artist = ActiveRecord.find("Artist", 1)
    artist.get_albums.each do |album|
      album.should be_instance_of(Album)
    end
  end
  
end