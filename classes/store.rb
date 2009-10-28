require 'classes/mainmethod'
require 'modules/validation'

class Store < MainMethod
  
  attr_accessor :album_id, :amount, :price, :self_price
  
  def initialize(album_id=nil, amount=nil, price=nil, self_price=nil)
    @album_id = album_id
    @amount = amount
    @price = price
    @self_price = self_price
  end
  
  def sell
    @amount = Integer(@amount) -1
    #@amount -= 1
    ActiveRecord.update(self.class.to_s, ["album_id", @album_id], prepare_for_save)
  end
  
  def add_amount amount
    @amount = Integer(@amount) + Integer(amount)
    ActiveRecord.update(self.class.to_s, ["album_id", @album_id], prepare_for_save)
  end
  
  def set_new_price new_price
    @price = new_price
    ActiveRecord.update(self.class.to_s, ["album_id", @album_id], prepare_for_save)
  end
  
  def before_save
    if !Validation.is_numeric @amount
      return false
    end
    if !Validation.is_numeric @price
      return false
    end
    if !Validation.is_numeric @self_price
      return false
    end
    true
  end
  
end