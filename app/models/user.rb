class User < ActiveRecord::Base

  has_many :user_histories

  validates_length_of :name, :minimum => 1, :allow_nil => false
  validates_length_of :surname, :minimum => 1, :allow_nil => false
  validates_length_of :adress, :minimum => 1, :allow_nil => false
  validates_numericality_of :age, :on => :update, :on => :save
  validates_inclusion_of :gender, :in => %w( vyr mot )
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :update, :on => :save

  def how_much_money_spent
    money_spent = 0
    self.user_histories.each { |history| money_spent += history.price }
    return money_spent
  end

  def update_information (name, surname, age, gender, adress, email)
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
    
    self.update_attributes(:age => self.age, :gender=> self.gender, :email => self.email)
  end

end
