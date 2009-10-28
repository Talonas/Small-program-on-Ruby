require 'rubygems'
require 'spec'
require 'classes/user'

describe User do
  
  it "should create empty user" do
    User.new.should be_instance_of(User)
  end
  
  it "should create user with parameters" do
    User.new(1, "vardas", "pavarde", 99, "vyr", "adresas", "pastas").should be_instance_of(User)
  end
  
  it "should have id, name, surname, age, gender, adress and email" do
    user = User.new(1, "vardas", "pavarde", 99, "vyr", "adresas", "pastas")
    user.id.should == 1
    user.name.should == "vardas"
    user.surname.should == "pavarde"
    user.age.should == 99
    user.gender.should == "vyr"
    user.adress.should == "adresas"
    user.email.should == "pastas"
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
  
  describe User, "before_save" do
    it "should fail if all or one user's attributes are incorrect" do
      user = User.new
      user.before_save.should be_false
    end
    it "should success if all user's attributes are correct" do
      user = User.new(1, "name", "surname", 11, "gender", "adress", "email") do
        user.before_save.should be_true
      end
    end
  end
  
end