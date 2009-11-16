require 'classes/mainmethod'
require 'modules/validation'

class Store < MainMethod
  
  attr_accessor :album_id, :amount, :price, :self_price
  
  def initialize(album_id=nil, amount=nil, price=nil, self_price=nil)
    @album_id   = album_id
    @amount     = amount
    @price      = price
    @self_price = self_price
  end
  
  def sell
    if Integer(@amount) > 0
      @amount = Integer(@amount) -1
      ActiveRecord.update(self.class.to_s, ["album_id", @album_id], prepare_for_save)
        return true
    end
    false
  end
  
  def add_amount amount
    if Validation.is_numeric amount
      if Integer(amount) > 0
        @amount = Integer(@amount) + Integer(amount)
        ActiveRecord.update(self.class.to_s, ["album_id", @album_id], prepare_for_save)
        return true
      else
        return false
      end
    end
    false
  end
  
  def set_new_price new_price
    if Validation.is_numeric(new_price)
      if Integer(new_price) > 0
        @price = new_price
        ActiveRecord.update(self.class.to_s, ["album_id", @album_id], prepare_for_save)
        return true
      else
        return false
      end
    end
    false
  end
  
  def before_save
    if !Validation.is_numeric(@amount) || !Validation.is_numeric(@price) || !Validation.is_numeric(@self_price)
      return false
    end
    true
  end
  
end
