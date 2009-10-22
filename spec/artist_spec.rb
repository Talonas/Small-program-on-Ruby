require 'rubygems'
require 'spec'
require 'artist'

describe Artist do
  
  it "should create new artist with no parameters" do
    Artist.new.should be_instance_of(Artist)
  end
  
  it "should create new artist" do
    Artist.new(1, "Unknown Artist").should be_instance_of(Artist)
  end
  
  it "should have id and name" do
    new_artist = Artist.new(1, "Unknown Artist")
    new_artist.id.should == 1
    new_artist.name.should == "Unknown Artist"
  end
  
end