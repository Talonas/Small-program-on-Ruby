require 'classes/mainmethod'
require 'modules/validation'

class User < MainMethod
  
  attr_accessor :id, :name, :surname, :age, :gender, :adress, :email
  
  def initialize(id=nil, name=nil, surname=nil, age=nil, gender=nil, adress=nil, email=nil)
    @id = id
    @name = name
    @surname = surname
    @age = age
    @gender = gender
    @adress = adress
    @email = email
  end
  
  def before_save
    if !Validation.not_empty @name
      return false
    end
    if !Validation.not_empty @surname
      return false
    end
    if !Validation.is_numeric @age
      return false
    end
    if !Validation.not_empty @gender
      return false
    end
    if !Validation.not_empty @adress
      return false
    end
    if !Validation.not_empty @email
      return false
    end
    return true
  end
  
end