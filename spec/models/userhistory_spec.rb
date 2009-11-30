require File.join( File.dirname(__FILE__), "..", "spec_helper" )

Spec::Matchers.define :belong do |expected|
  match do |actual|
    actual.should be_instance_of(expected)
  end
end
 
describe UserHistory do

  it "should create empty user history" do
    UserHistory.new.should be_kind_of(ActiveRecord::Base)
  end

  it "should have user_id, album_id and price" do
    history = UserHistory.create(
      :user_id => 1,
      :album_id => 1,
      :price => 45
    )
    history.user_id.should == 1
    history.album_id.should == 1
    history.price.should == 45
  end

  it "should create UserHistory object with user_id, album_id and price" do
    UserHistory.create(
      :user_id => 1,
      :album_id => 1,
      :price => 45
    ).should be_kind_of(ActiveRecord::Base)
  end

  it "should add new record to user's history" do
    UserHistory.create(
      :user_id => 1,
      :album_id => 1,
      :price => 45
    ).save
  end
 
end
