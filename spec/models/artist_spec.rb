require File.join( File.dirname(__FILE__), "..", "spec_helper" )

describe Artist do
  
  it "should create a new empty artist" do
    Artist.new.should be_kind_of(ActiveRecord::Base)
  end
  
  it "should create a new artist with name" do
    Artist.new(:name => "Led Zeppelin").should be_kind_of(ActiveRecord::Base)
  end
  
  it "should have name" do
    artist = Artist.new(:name => "Led Zeppelin")
    artist.name.should == "Led Zeppelin"
  end

  it "should have many albums" do
    artist = Artist.find(:first, :conditions => {:name => "Led Zeppelin"})
    artist.albums.each { |album| album.should be_kind_of(ActiveRecord::Base) }
  end

end
