require 'rubygems'
require 'spec'
require 'modules/validation'

describe Validation do
  
  describe Validation, "not_empty" do
    it "should success if not empty value" do
      Validation.not_empty("value").should be_instance_of(TrueClass)
    end
    it "should fail if empty value" do
      Validation.not_empty("").should be_instance_of(FalseClass)
    end
  end
  
  describe Validation, "is_numeric" do
    it "should success if value is numeric" do
      Validation.is_numeric(12).should be_instance_of(TrueClass)
      Validation.is_numeric("12").should be_instance_of(TrueClass)
    end
    it "should fail if value is not numeric" do
      Validation.is_numeric("labas").should be_instance_of(FalseClass)
    end
  end
  
end