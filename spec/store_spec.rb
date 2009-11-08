require 'rubygems'
require 'spec'
require 'classes/store'
require 'modules/activerecord'

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
    store.sell.should be_false
  end
  
  it "should add add more albums to store" do
    store = Store.new(1, 0, 20, 10)
    lambda {
      store.add_amount 10
    }.should change(store, :amount).by(10)
  end
  
  it "should not allow to add more albums to the store if value of amount is not numeric" do
    store = Store.new(1, 0, 20, 10)
    store.add_amount("amount").should be_false
  end
  
  it "should change price of album" do
    store = Store.new(1, 1, 0, 10)
    lambda {
      store.set_new_price 20
    }.should change(store, :price).from(0).to(20)
  end
  
  it "should not change price of album if value is not numeric" do
    store = Store.new(1, 1, 1, 10)
    store.set_new_price("price").should be_false
  end
  
  describe Store, "before_save" do
    it "should fail if amount is not numeric" do
      store = Store.new(1, "string", 3, 4)
      store.before_save.should be_false
    end
    it "should fail if price is not numeric" do
      store = Store.new(1, 2, "string", 4)
      store.before_save.should be_false
    end
    it "should fail is self price is not numeric" do
      store = Store.new(1, 2, 3, "string")
      store.before_save.should be_false
    end
    it "should success if amount, price and self price are correct" do
      store = Store.new(1, 10, 20, 20)
      store.before_save.should be_true
    end
  end
  
end