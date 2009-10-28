require 'rubygems'
require 'spec'
require 'modules/validation'

describe Validation do
  
  describe Validation, "not_empty" do
    it "should success if not empty value" do
      Validation.not_empty("value").should be_true
    end
    it "should fail if empty value" do
      Validation.not_empty("").should be_false
    end
  end
  
  describe Validation, "is_numeric" do
    it "should success if value is numeric" do
      Validation.is_numeric(12).should be_true
      Validation.is_numeric("12").should be_true
    end
    it "should fail if value is not numeric" do
      Validation.is_numeric("labas").should be_false
    end
  end
  
end