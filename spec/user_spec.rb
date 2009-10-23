require 'rubygems'
require 'spec'
require 'user'

describe User do
  
  it "should create new empty User object" do
    User.new.should be_instance_of(User)
  end
  
  it "should create new not empty User object" do
    User.new(1, "Vardenis", "Pavardenis", "vyr", 99, "Klaipeda", "neturiu@as.pasto").should be_instance_of(User)
  end
  
  it "should have id, name, surname, gender, age, adress and email" do
    new_user = User.new(1, "Vardenis", "Pavardenis", "vyr", 99, "Klaipeda", "neturiu@pasto.as")
    new_user.should be_instance_of(User)
    new_user.id.should == 1
    new_user.name.should == "Vardenis"
    new_user.surname.should == "Pavardenis"
    new_user.age.should == 99
    new_user.gender.should == "vyr"
    new_user.adress.should == "Klaipeda"
    new_user.email.should == "neturiu@pasto.as"
  end
  
end