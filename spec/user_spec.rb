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
  
end