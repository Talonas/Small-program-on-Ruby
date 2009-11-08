require 'classes/userhistory'

class Album
  
  attr_accessor :id, :artist_id, :name, :year, :genre
    
  def initialize(id=nil, artist_id=nil, name=nil, year=nil, genre=nil)
    @id = id
    @artist_id = artist_id
    @name = name
    @year = year
    @genre = genre
  end
  
  def sell user_id
    store = ActiveRecord.find("Store", {"WHERE" => {"album_id" => @id}})
    if store && store.amount > "0"
      store.sell
      UserHistory.new(user_id, @id, store.price).save
      return true
    end
    false
  end
  
  def print_info price, amount
    print "  #{@id}. #{@name}, #{@year} : Kaina #{price}Lt, liko #{amount}vnt.\n"
  end
  
end