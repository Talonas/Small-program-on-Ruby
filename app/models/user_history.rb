class UserHistory < ActiveRecord::Base

  has_one  :user
  has_many :albums

end
