require 'classes/mainmethod'

class UserHistory < MainMethod
  
  attr_accessor :user_id, :album_id, :price
  
  def initialize(user_id=nil, album_id=nil, price=nil)
    @user_id = user_id
    @album_id = album_id
    @price = price
  end
  
end