class Store < ActiveRecord::Base

  has_many :albums

  validates_numericality_of :amount, :allow_nil => false
  validates_numericality_of :price, :allow_nil => false
  validates_numericality_of :self_price, :allow_nil => false

  def sell
    if self.amount > 0
      self.amount -= 1
      self.update_attribute(:amount, self.amount)
      self.save
    end
    false
  end

  def add_amount amount
    if amount.is_a?(Fixnum) && amount > 0
      self.amount += amount
      self.update_attributes(:amount => self.amount)
      self.save
    end
    false
  end

  def set_new_price new_price
    if new_price.is_a?(Fixnum) && new_price > 0
      self.price = new_price
      self.update_attributes(:price => self.price)
      self.save
    end
    false
  end

end
