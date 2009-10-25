require 'rubygems'
require 'spec'

require 'classes/userhistory'

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
  
  it "should write new attr values" do
    history = UserHistory.new
    history.user_id = 1
    history.album_id = 2
    history.price = 3
  end
  
end