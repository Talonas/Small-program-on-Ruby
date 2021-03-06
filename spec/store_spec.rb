require 'rubygems'
require 'spec'
require 'classes/store'
require 'modules/activerecord'

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
    Store.new.should be_instance_of(Store)
  end
  
  it "should create not empty object" do
    Store.new(1, 20, 40, 30).should be_instance_of(Store)
  end
  
  it "should have album_id, amount, price and self_price" do
    store = Store.new(1, 2, 3, 4)
    store.album_id.should == 1
    store.amount.should == 2
    store.price.should == 3
    store.self_price.should == 4
  end
  
  it "should rewrite attributes" do
    store = Store.new(1, 2, 3, 4)
    store.album_id = 10
    store.amount = 34
    store.price = 0
    store.self_price = 9
  end
  
  it "should sell album" do
    store = Store.new(1, 12, 20, 10)
    lambda {
      store.sell
    }.should change(store, :amount).by(-1)
  end
  
  it "should not allow to sell album if its amount is less than 1" do
    store = Store.new(1, 0, 20, 10)
    store.sell.should success('no')
  end
  
  it "should add add more albums to store" do
    store = Store.new(1, 0, 20, 10)
    lambda {
      store.add_amount 10
    }.should change(store, :amount).by(10)
  end

  it "should should not allow to add 0 album" do
    store = Store.new(1, 0, 20, 20)
    store.add_amount(0).should success('no')
  end

  it "should not allow to add negative number of albums" do
    store = Store.new(1, 0, 20, 20)
    store.add_amount(-1).should success('no')
  end
  
  it "should not allow to add more albums to the store if value of amount is not numeric" do
    store = Store.new(1, 0, 20, 10)
    store.add_amount("amount").should success('no')
  end
  
  it "should change price of album" do
    store = Store.new(1, 1, 0, 10)
    lambda {
      store.set_new_price 20
    }.should change(store, :price).from(0).to(20)
  end

  it "should not change price if new price is 0" do
    store = Store.new(1, 1, 1, 10)
    store.set_new_price(0).should success('no')
  end

  it "should not change price if new price is negative" do
    store = Store.new(1, 1, 1, 10)
    store.set_new_price(-1).should success('no')
  end
  
  it "should not change price of album if value is not numeric" do
    store = Store.new(1, 1, 1, 10)
    store.set_new_price("price").should success('no')
  end
  

  it "should not add record to store if amount is not numeric" do
    store = Store.new(1, "string", 3, 4)
    store.before_save.should success('no')
  end

  it "should not add record to store if price is not numeric" do
    store = Store.new(1, 2, "string", 4)
    store.before_save.should success('no')
  end

  it "should not add record to store is self price is not numeric" do
    store = Store.new(1, 2, 3, "string")
    store.before_save.should success('no')
  end
  
  it "should add new record to store if amount, price and self price are correct" do
    store = Store.new(1, 10, 20, 20)
    store.before_save.should success('yes')
  end
  
end
