class Album < ActiveRecord::Base

  has_one :store

  def sell user_id
    if self.store && self.store.amount > 0
      if self.store.sell
        UserHistory.create(
          :user_id => user_id,
          :album_id => @id,
          :price => self.store.price
        ).save
        return true;
      end
    end
    false
  end

end
