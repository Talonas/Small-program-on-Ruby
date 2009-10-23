require 'validation'
require 'activerecord'
require 'mainmethod'

class Artist < MainMethod
  
  attr_accessor :id, :name
  
  def initialize(id=nil, name=nil)
    @id = id;
    @name = name;
  end
  
  def before_save
    if !Validation.is_empty @name
      return false
    end
    true
  end
  
end