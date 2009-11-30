class Album < ActiveRecord::Base

  has_one :store

  def sell user_id
    if self.store && self.store.amount > 0
      if self.store.sell && add_record_to_history(user_id)        
        return true
      end
    end
    false
  end

  def add_record_to_history user_id
    user_history = UserHistory.create(
      :user_id => user_id,
      :album_id => @id,
      :price => self.store.price
    )
    user_history.save
  end

end
