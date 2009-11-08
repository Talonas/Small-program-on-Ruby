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
  
  it "should fail if database record with one parameter (ID) does not exist" do
    ActiveRecord.find("Album", 1343).should be_false
  end
  
  it "should find database record with 'WHERE' query" do
    ActiveRecord.find("Album", { "WHERE"=> {"name"=>"Led Zeppelin"} }).should be_instance_of(Album)
  end
  
  it "should fail if database record with 'WHERE' query does not exist" do
    ActiveRecord.find("Album", { "WHERE"=> {"name"=>"Zentai"} }).should be_false
  end
  
  it "should find all table records" do
    object_list = ActiveRecord.find_all("Album")
    object_list.each { |object| object.should be_instance_of(Album) }
  end
  
  it "should find all table records with query" do
    object_list = ActiveRecord.find_all("Album", { "WHERE" => {"genre"=>"hard rock"} })
    object_list.each { |object| object.should be_instance_of(Album) }
  end
  
  it "should fail to find all table record if query is incorrect" do
    object_list = ActiveRecord.find_all("Album", { "WHERE" => {"genre"=>"llalalala"} })
    object_list.should be_false
  end
  
  it "should update record with ID 1" do
    hash = {"name"=>"The Piper at the Gates of Dawn", "year"=>1967, "genre"=>"psychedelic rock"}
    ActiveRecord.update("Album", 1, hash)
  end
  
end