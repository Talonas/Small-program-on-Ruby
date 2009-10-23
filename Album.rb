class Album
  
  attr_accessor :id, :artist_id, :name, :year, :genre
  
  def initialize(id=nil, artist_id=nil, name=nil, year=nil, genre=nil)
    @id = id
    @artist_id = artist_id
    @name = name
    @year = year
    @genre = genre
  end
  
end