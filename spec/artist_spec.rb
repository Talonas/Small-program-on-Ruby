require 'rubygems'
require 'spec'
require 'classes/artist'

describe Artist do
  
  it "should create new empty artist" do
    Artist.new.should be_instance_of(Artist)
  end
  
  it "should create new artist with params" do
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
  
end