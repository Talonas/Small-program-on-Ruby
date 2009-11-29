class User < ActiveRecord::Base

  has_many :user_histories

  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  def how_much_money_spent
    money_spent = 0
    self.user_histories.each { |history| money_spent += history.price }
    return money_spent
  end

  def update (name, surname, age, gender, adress, email)
    if !name.empty?
      self.name = name
    end
    if !surname.empty?
      self.surname = surname
    end
    if !age.empty?
      self.age = age
    end
    if !gender.empty?
      self.gender = gender
    end
    if !adress.empty?
      self.adress = adress
    end
    if !email.empty?
      self.email = email
    end
    
    self.save
  end

=begin
  attr_accessor :id, :name, :surname, :age, :gender, :adress, :email
  
  def initialize(id=nil, name=nil, surname=nil, age=nil, gender=nil, adress=nil, email=nil)
    @id      = id
    @name    = name
    @surname = surname
    @age     = age
    @gender  = gender
    @adress  = adress
    @email   = email
  end
  
  def how_mutch_money_spended
    moneyend_spend = 0
    histories = ActiveRecord.find_all("UserHistory", {"WHERE" => {"user_id" => @id}})
    if histories
      histories.each { |history| money_spend += Integer(history.price) }
    end
    return money_spend
  end
 
  def before_save
    if !Validation.not_empty(@name) || !Validation.not_empty(@surname) || !Validation.not_empty(@age) || !Validation.is_numeric(@age) || 
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
=end
end
