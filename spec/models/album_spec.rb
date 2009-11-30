require File.join( File.dirname(__FILE__), "..", "spec_helper" )

describe Album do

  it "should create new empty album" do
    Album.new.should be_kind_of(ActiveRecord::Base)
  end

  it "should have artist_id, name, year and genre" do
    album = Album.new(
      :artist_id => 1,
      :name => "House of the Holy",
      :year => 1973,
      :genre => "rock"
    )
    album.name.should == "House of the Holy"
    album.year.should == 1973
    album.genre.should == "rock"
  end

  it "should sell album for user" do
    album = Album.new(
      :artist_id => 1,
      :name => "House of the Holy",
      :year => 1973,
      :genre => "rock"
    )
    album.sell 1
  end

  it "should not allow to sell album if it's amount is 0" do
    album = Album.find(2)
    album.sell(1).should be_false
  end

end
