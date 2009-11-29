require File.join( File.dirname(__FILE__), "..", "spec_helper" )

describe User do
 
  it "should create empty user" do
    User.new.should be_kind_of(User)
  end
  
  it "should have name, surname, age, gender, adress and email" do
    user = User.new(
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
  
  it "should let rewrite id, name, surname, age, gender, adress and email" do
    user = User.new
    user.id = 12
    user.name ="test"
    user.surname = "teste"
    user.age = 33
    user.gender = "mot"
    user.adress = "Kaunas"
    user.email = "emailas"
  end
=begin 
  it "should update user's information" do
    user = ActiveRecord.find("User", 1)
    user.update("Paulius", "Pilkauskas", "22", "vyr", "Vilnius", "test").should be_true
  end
 
  it "should count how much money did user spend" do
    user = ActiveRecord.find("User", 1)
    user.how_mutch_money_spended.should be_kind_of(Fixnum)
  end
  
  it "should show zero in user history how much money spend if user did not buy anything yet" do
    user = User.new(100, "userName", "LastName", 34, "vyr", "adress", "email")
    user.how_mutch_money_spended.should equal(0)
  end
 
  it "should not allow register new user if he didn't filled fields" do
    user = User.new
    user.before_save.should be_false
  end
 
  it "should not allow register new user if age is noti numeric" do
    user = User.new("Username", "Userlastname", "AGE", "gender", "adress", "email")
    user.save.should be_false
  end
 
  it "should not allow update user's information if age is not a number" do
    user = ActiveRecord.find("User", 1)
    user.update("", "", "age", "", "", "").should be_false
  end
=end  
end
