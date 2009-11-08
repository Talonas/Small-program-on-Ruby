require 'rubygems'
require 'spec'
require 'classes/userhistory'
require 'classes/album'
require 'classes/artist'
require 'modules/activerecord'

describe UserHistory do
  
  it "should create empty userHistory class" do
    UserHistory.new.should be_instance_of(UserHistory)
  end
  
  it "should create UserHistory object with user_id, album_id and price" do
    UserHistory.new(1, 1, 200).should be_instance_of(UserHistory)
  end
  
  it "should have user_id, album_id and price" do
    history = UserHistory.new(1, 2, 3)
    history.user_id.should == 1
    history.album_id.should == 2
    history.price.should == 3
  end
  
  it "should add new record (album_id and price) to user's history" do
    history = UserHistory.new
    history.user_id = 1
    history.album_id = 2
    history.price = 3
  end
  
  it "should get artist and album information" do
    history = ActiveRecord.find("UserHistory", {"WHERE" => {"user_id" => 1}})
    history.info["album"].should be_instance_of(Album)
    history.info["artist"].should be_instance_of(Artist)
  end
  
end