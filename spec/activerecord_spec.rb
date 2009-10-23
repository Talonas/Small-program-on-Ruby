require 'rubygems'
require 'spec'

require 'activerecord'
require 'mainmethod'
require 'artist'

describe ActiveRecord do
 
  it "should build new object" do
    new_artist = ActiveRecord.build_object("Artists", { "id" => "1", "name" => "Pink Floyd" })
    new_artist.should be_instance_of(Artist)
    new_artist.id.should == "1"
    new_artist.name.should == "Pink Floyd"
  end
  
  it "should find record by id" do
    lambda {
      new_artist = ActiveRecord.find("Artist", "1")
      new_artist.should be_instance_of(Artist)
      new_artist.id.should == "1"
      new_artist.name.should == "Pink Floyd"
    }.should_not raise_error(SQLite3::SQLException)
  end
  
  it "should find record with one or more params" do
    lambda {
      new_artist = ActiveRecord.find("Artist", { "name" => "Pink Floyd" })
      new_artist.should be_instance_of(Artist)
      new_artist.id.should == "1"
      new_artist.name.should == "Pink Floyd"
    }.should_not raise_error(SQLite3::SQLException)
  end

  it "should get all records from table" do
    lambda {
      artists = ActiveRecord.find_all("Artist")
      artists.each { |artist| artist.should be_instance_of(Artist) }
    }.should_not raise_error(SQLite3::SQLException)
  end
  
  it "should get all records from table with specify parameters" do
    lambda {
      artists = ActiveRecord.find_all("Artist", { "name" => "Pink Floyd" })
      artists.each { |artist| artist.should be_instance_of(Artist) }
    }.should_not raise_error(SQLite3::SQLException)
  end
=begin 
  it "should save a new record into table" do
    lambda {
      new_artist = Artist.new
      new_artist.name = "Queen"
      new_artist.save().should be_instance_of(TrueClass)
    }.should_not raise_error(SQLite3::SQLException)    
  end
=end 
end