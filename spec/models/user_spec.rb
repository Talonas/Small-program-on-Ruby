require File.join( File.dirname(__FILE__), "..", "spec_helper" )

describe User do
 
  it "should create empty user" do
    User.new.should be_kind_of(ActiveRecord::Base)
  end
  
  it "should have name, surname, age, gender, adress and email" do
    user = User.create(
      :name => "Jonas",
      :surname => "Jonaitis",
      :age => 45,
      :gender => "vyr",
      :adress => "Zalgirio g. 34, Kaunas",
      :email => "jonas@gmail.com"
    )
    user.name.should == "Jonas"
    user.surname.should == "Jonaitis"
    user.age.should == 45
    user.gender.should == "vyr"
    user.adress.should == "Zalgirio g. 34, Kaunas"
    user.email.should == "jonas@gmail.com"
  end

  it "should update user's information" do
    user = User.find(1)
    user.update_information("Paulius", "Pilkauskas", "22", "vyr", "Vilnius", "talonas@gmail.com").should be_true
  end
 
  it "should count how much money did user spend" do
    user = User.find(1)
    user.how_much_money_spent.should be_kind_of(Fixnum)
  end

  it "should show zero in user history how much money spend if user did not buy anything yet" do
    user = User.create(
      :name => "Jonas",
      :surname => "Jonaitis",
      :age => 45,
      :gender => "vyr",
      :adress => "Zalgirio g. 34, Kaunas",
      :email => "jonas@gmail.com"
    )
    user.how_much_money_spent.should equal(0)
  end
  
  it "should not allow register new user if he didn't filled all fields" do
    user = User.create
    user.save.should be_false
  end
 
  it "should not allow register new user if age is noti numeric" do
    user = User.create(
      :name => "Jonas",
      :surname => "Jonaitis",
      :age => "age",
      :gender => "vyr",
      :adress => "Zalgirio g. 34, Kaunas",
      :email => "jonas@gmail.com"
    )    
    user.save.should be_false
  end  

end
