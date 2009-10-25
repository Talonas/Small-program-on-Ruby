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
  
end