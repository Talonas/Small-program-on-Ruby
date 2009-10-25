require 'rubygems'
require 'spec'

require 'modules/activerecord'
require 'classes/album'

describe ActiveRecord do
  
  it "should build a new object" do
    new_object = ActiveRecord.build_object("Albums", {"id"=>"1", "artist_id"=>"2", "name"=>"test", "year"=>"2009", "genre"=>"jazz"})
    new_object.should be_instance_of(Album)
    new_object.id.should == "1"
    new_object.artist_id.should == "2"
    new_object.name.should == "test"
    new_object.year.should == "2009"
    new_object.genre.should == "jazz"
  end
  
  it "should find database record with one parameter (ID)" do
    ActiveRecord.find("Album", 1).should be_instance_of(Album)
  end
  
  it "should find database record with 'WHERE' query" do
    ActiveRecord.find("Album", { "WHERE"=> {"name"=>"test"} }).should be_instance_of(Album)
  end
  
end