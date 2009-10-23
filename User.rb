class User
  
  attr_accessor :id, :name, :surname, :gender, :age, :adress, :email
  
  def initialize(id=nil, name=nil, surname=nil, gender=nil, age=nil, adress=nil, email=nil)
    @id = id
    @name = name
    @surname = surname
    @gender = gender
    @age = age
    @adress = adress
    @email = email
  end
  
end