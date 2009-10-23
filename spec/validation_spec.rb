require 'rubygems'
require 'spec'
require 'validation'

describe Validation do
  
  it "returns false if value is empty" do
    Validation.is_empty("").should be_instance_of(FalseClass)
  end
  
  it "returns true if value is not empty" do
    Validation.is_empty("test").should be_instance_of(TrueClass)
  end
  
  it "returns false if value is not numeric" do
    Validation.is_numeric("aaaa").should be_instance_of(FalseClass)
  end
  
  it "retursn true if value is numeric" do
    Validation.is_numeric("1212").should be_instance_of(TrueClass)
    Validation.is_numeric(121212).should be_instance_of(TrueClass)
  end
  
end