require File.join( File.dirname(__FILE__), "..", "spec_helper" )

require 'test/unit'
require 'mocha'

class StoreTest < Test::Unit::TestCase
end

Spec::Matchers.define :success do |expected|
  match do |actual|
    if expected == 'yes'
      actual.should be_true
    else expected == 'no'
      actual.should be_false
    end
  end
end
 
describe Store do
  
  it "should create empty object" do
    Store.new.should be_kind_of(ActiveRecord::Base)
  end
  
  it "should create not empty object" do
    Store.new(
      :album_id => 1,
      :amount => 10,
      :price => 23,
      :self_price => 17
    ).should be_kind_of(ActiveRecord::Base)
  end
  
  it "should have album_id, amount, price and self_price" do
    store = Store.create(
      :album_id => 1,
      :amount => 10,
      :price => 23,
      :self_price => 17
    )
    store.album_id.should == 1
    store.amount.should == 10
    store.price.should == 23
    store.self_price.should == 17
  end

  it "should sell album" do
    store = Store.find(:first, :conditions => {:album_id => 1})
    lambda {
      store.sell
    }.should change(store, :amount).by(-1)
  end

  it "should not allow to sell album if its amount is less than 1" do
    store = Store.find(:first, :conditions => {:amount => 0})
    store.sell.should success('no')
  end
  
  it "should add more albums to store" do
    store = Store.find(:first, :conditions => {:album_id => 3})
    lambda {
      store.add_amount 10
    }.should change(store, :amount).by(10)
  end
 
  it "should should not allow to add 0 album" do
    store = Store.find(:first, :conditions => {:album_id => 3})
    store.add_amount(0).should success('no')
  end
 
  it "should not allow to add negative number of albums" do
    store = Store.find(:first, :conditions => {:album_id => 3})
    store.add_amount(-1).should success('no')
  end
  
  it "should not allow to add more albums to the store if value of amount is not numeric" do
    store = Store.find(:first, :conditions => {:album_id => 3})
    store.add_amount("amount").should success('no')
  end
  
  it "should change price of album" do
    store = Store.find(:first, :conditions => {:album_id => 3})
    lambda {
      store.set_new_price 20
    }.should change(store, :price).from(30).to(20)
  end
 
  it "should not change price if new price is 0" do
    store = Store.find(:first, :conditions => {:album_id => 3})
    store.set_new_price(0).should success('no')
  end
 
  it "should not change price if new price is negative" do
    store = Store.find(:first, :conditions => {:album_id => 3})
    store.set_new_price(-1).should success('no')
  end
  
  it "should not change price of album if value is not numeric" do
    store = Store.find(:first, :conditions => {:album_id => 3})
    store.set_new_price("price").should success('no')
  end
  

  it "should not add record to store if amount is not numeric" do
    store = Store.create(
      :album_id => 1, 
      :amount => "string", 
      :price => 3, 
      :self_price => 4
    )
    store.save.should success('no')
  end
 
  it "should not add record to store if price is not numeric" do
    store = Store.create(
      :album_id => 1, 
      :amount => 10, 
      :price => "price", 
      :self_price => 4
    )    
    store.save.should success('no')
  end
 
  it "should not add record to store is self price is not numeric" do
    store = Store.create(
      :album_id => 1, 
      :amount => 10, 
      :price => 3, 
      :self_price => "self price"
    )    
    store.save.should success('no')
  end
  
  it "should add new record to store if amount, price and self price are correct" do
    store = Store.create(
      :album_id => 1, 
      :amount => 10, 
      :price => 3, 
      :self_price => 1
    )    
    store.save.should success('yes')
  end

  it "should not add new record to store if values are empty" do
    store = Store.create
    store.save.should success('no')
  end

end
