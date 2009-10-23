require 'rubygems'
require 'sqlite3'

require 'artist'
require 'album'
require 'activerecord'

# artist functions #

def print_all_artists
  system("clear")
  artists = ActiveRecord.find_all("Artist")
  artists.each do |artist|
    print "#{artist.id}. #{artist.name}\n"
  end
  
  print "Iveskite atlikejo ID (0 - pagr.meniu) "
  key = readline
  key.chop!
  if key != "0"
    albums = ActiveRecord.find_all("Album", { "artist_id" => key })
    if albums != false
      print_artist_album(albums)
    else
      print "Tokio atlikejo nera!\n"
    end
  end
  
end


# albums functions #

def print_all_albums
  system("clear")
  albums = ActiveRecord.find_all("Album")
  albums.each do |album|
    artist = ActiveRecord.find("Artist", album.artist_id)
    print "#{album.id}. #{album.artist_id}, #{album.name}, #{album.year}, #{artist.name}, #{album.genre}\n"
  end
end

def print_artist_album(albums)
  albums.each do |album|
    print "#{album.id}. #{album.name} #{album.year}\n"
  end
end


# songs functions #

# code block


# main menu #

def print_menu
  print "\n Pagrindinis meniu\n"
  print "  1 - Jusu domenys\n\n"
  print "  2 - Atlikejai\n"
  print "  3 - Albumai\n\n"
  print "  0 - Iseiti\n\n"
  
  print "key: "
  key = readline
  key.chop!
  
  if key == "0"
    return true
  else
    if key == "1"
    end
    if key == "2"
      print_all_artists
    end
    if key == "3"
      print_all_albums
    end
    false
  end
end

while true
  if print_menu
    system("clear")
    break
  end
end

=begin  
db = SQLite3::Database.new( "data.db" )

db.execute("DELETE FROM Artists")
db.execute("DELETE FROM Albums")

#db.execute("CREATE TABLE Artists (
#  id INTEGER PRIMARY KEY,
#  name TEXT)")

db.execute("INSERT into Artists (name) VALUES ('Pink Floyd')")  

#db.execute("CREATE TABLE Albums (
#  id INTEGER PRIMARY KEY,
#  artist_id INTEGER,
#  name TEXT,
#  year INTEGER,
#  genre TEXT)")
  
db.execute("INSERT into Albums (artist_id, name, year, genre) VALUES (1, 'The Piper At The Gates Of Dawn', 1967, 'rock')")
db.execute("INSERT into Albums (artist_id, name, year, genre) VALUES (1, 'A Saucerful Of Secrets', 1968, 'rock')")
db.execute("INSERT into Albums (artist_id, name, year, genre) VALUES (1, 'More', 1969, 'rock')")
db.execute("INSERT into Albums (artist_id, name, year, genre) VALUES (1, 'Ummagumma', 1969, 'rock')")

db.execute("INSERT into Albums (artist_id, name, year, genre) VALUES (1, 'Atom Heart Mother', 1970, 'rock')")
db.execute("INSERT into Albums (artist_id, name, year, genre) VALUES (1, 'Meddle', 1971, 'rock')")
db.execute("INSERT into Albums (artist_id, name, year, genre) VALUES (1, 'Relics', 1971, 'rock')")
db.execute("INSERT into Albums (artist_id, name, year, genre) VALUES (1, 'Obscured By Clouds', 1972, 'rock')")

db.execute("INSERT into Albums (artist_id, name, year, genre) VALUES (1, 'Dark Side Of The Moon', 1973, 'rock')")
db.execute("INSERT into Albums (artist_id, name, year, genre) VALUES (1, 'Animals', 1975, 'rock')")
db.execute("INSERT into Albums (artist_id, name, year, genre) VALUES (1, 'Wish You Were Here', 1975, 'rock')")
db.execute("INSERT into Albums (artist_id, name, year, genre) VALUES (1, 'The Wall', 1979, 'rock')")
=end