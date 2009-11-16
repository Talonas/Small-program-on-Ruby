require 'rubygems'
require 'spec'
require 'modules/validation'

describe Validation do
  
  describe Validation, "method not_empty" do
    it "should success if user filled value" do
      Validation.not_empty("value").should be_true
    end
    it "should fail if user did not fill any value" do
      Validation.not_empty("").should be_false
    end
  end
  
  describe Validation, "method is_numeric" do
    it "should fail if value is Nill" do
      Validation.is_numeric(nil).should be_false
    end
    it "should success if given value is numeric" do
      Validation.is_numeric(12).should be_true
      Validation.is_numeric("12").should be_true
    end
    it "should fail if given value is not numeric" do
      Validation.is_numeric("labas").should be_false
    end
  end
  
end
