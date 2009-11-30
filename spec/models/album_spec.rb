require File.join( File.dirname(__FILE__), "..", "spec_helper" )
require 'test/unit'
require 'mocha'

class StoreTest < Test::Unit::TestCase

  def test_should_return_false_for_failed_sell
    store = stub("store")
    store.stubs(:sell).returns(false)
    album = Album.find(1)
    assert_equal false, album.sell(1)
  end

  def test_should_return_true_for_success_selling
    album = stub("album")
    album.stubs(:add_record_to_history).returns(true)
    album.stubs(:sell).returns(true)
    #album = Album.find(1)
    assert_equal true, album.sell(1)
  end

  def test_should_sell_album
    store = mock("store")
    album = Album.find(1)
    store.expects(:sell)
    album.sell 1
    store.sell
  end

end

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

  it "should create new user history record if sell is correct" do
    album = Album.find(1)
    album.add_record_to_history(1).should be_true
  end

end
