require 'modules/activerecord'

class Artist
  
  attr_accessor :id, :name
   
  def initialize(id=nil, name=nil)
    @id = id
    @name = name
  end
  
  def get_albums
    ActiveRecord.find_all("Album", {"WHERE" => {"artist_id" => @id}})
  end
  
end
