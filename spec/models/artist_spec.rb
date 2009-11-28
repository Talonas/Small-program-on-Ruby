require File.join( File.dirname(__FILE__), "..", "spec_helper" )
 
describe Artist do
  
  it "should create a new empty artist" do
    Artist.new.should be_instance_of(ActiveRecord::Base)
  end
  
  it "should create a new artist with name" do
    Artist.new(:name => "Led Zeppelin").should be_instance_of(ActiveRecord::Base)
  end
  
  it "should have name" do
    artist = Artist.new(:name => "Led Zeppelin")
    artist.name.should == "Led Zeppelin"
  end
=begin  
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
=end
end
