require 'classes/mainmethod'
require 'modules/validation'
require 'modules/activerecord'

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
  
  def how_mutch_money_spended
    money_spend = 0
    histories = ActiveRecord.find_all("UserHistory", {"WHERE" => {"user_id" => @id}})
    if histories
      histories.each { |history| money_spend += Integer(history.price) }
    end
    return money_spend
  end
  
  def before_save
    if !Validation.not_empty(@name) || !Validation.not_empty(@surname) || !Validation.is_numeric(@age) || 
       !Validation.not_empty(@gender) || !Validation.not_empty(@adress) || !Validation.not_empty(@email)
      return false
    end
    true
  end
  
  def update(name, surname, age, gender, adress, email)
    if !name.empty?
      @name = name
    end
    if !surname.empty?
      @surname = surname
    end
    if !age.empty?
      @age = age
    end
    if !gender.empty?
      @gender = gender
    end
    if !adress.empty?
      @adress = adress
    end
    if !email.empty?
      @email = email
    end
    if !save
      return false
    end
    true
  end
  
end