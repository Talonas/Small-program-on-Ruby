class Album < ActiveRecord::Base
  
  attr_accessor :id, :artist_id, :name, :year
  
  def initialize (id, artist_id, name, year)
    @id = id
    @artist_id = artist_id
    @name = name
    @year = year
  end

  def metodas_1 id
    ActiveRecord.find("Klase", id)
  end

  public
  
  
  private
  
  def metodas_2
    return @id
  end
   
end
