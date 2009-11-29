class UserHistory < ActiveRecord::Base

  has_one :user
  has_many :albums

=begin
 attr_accessor :user_id, :album_id, :price
  
  def initialize(user_id=nil, album_id=nil, price=nil)
    @user_id  = user_id
    @album_id = album_id
    @price    = price
  end
  
  def info
    album = ActiveRecord.find("Album", @album_id)
    artist = ActiveRecord.find("Artist", album.artist_id)
    return {"album" => album, "artist" => artist}
  end
=end
end
