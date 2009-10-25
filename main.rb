require 'rubygems'
require 'sqlite3'

require 'modules/activerecord'

require 'classes/album'
require 'classes/artist'
require 'classes/user'

class UserInterface
  
  attr_writer :user
  
  def initialize(user=nil)
    @user = user
  end
  
  def user_information
    system("clear")
    print "INFORMACIJA:\n"
    print "  Varddas: #{@user.name}\n"
    print "  Pavarde: #{@user.surname}\n"
    print "  Amzius: #{@user.age}\n"
    print "  Lytis: #{@user.gender}\n"
    print "  Adresas: #{@user.adress}\n"
    print "  El.pastas: #{@user.email}\n\n"
  end
  
  def shop
    system("clear")
    print "PARDUOTUVE:\n"
    print "  1 - Ieskoti pagal atlikejus\n"
    print "  2 - Ziureti albumus\n\n"
    
    print "key: "
    key = readline.chop
    if key == "1"
      print_artists
    end
    if key == "2"
      print_all_albums
    end
  end
  
  def print_artists
    system "clear"
    print "ATLIKEJAI:\n"
    artists = ActiveRecord.find_all("Artist")
    artists.each do |artist|
      print "  #{artist.id}. #{artist.name}\n"
    end
    print "\n  Iveskite atlikejo ID\n"
    print "  key: "
    key = readline.chop
    artist = ActiveRecord.find("Artist", key)
    if artist
      print_artist_albums artist
    else
      print "  Tokio atlikejo nera!\n"
    end
  end
  
  def print_artist_albums artist
    system "clear"
    print "#{artist.name}\n"
    albums = ActiveRecord.find_all("Album", {"WHERE" => {"artist_id"=>artist.id}})
    albums.each do |album|
      print "  #{album.id}. #{album.name}, #{album.year}\n"
    end
  end
  
  def print_all_albums
    system("clear")
    print "ALBUMAI:\n"
    albums = ActiveRecord.find_all("Album", { "ORDER BY" => "artist_id DESC" })
    albums.each do |album|
      artist = ActiveRecord.find("Artist", album.artist_id)
      print "#{album.id}. #{album.name}, #{album.year} - #{artist.name}\n"
    end
  end
  
  def main_menu
    #system("clear")
    print "MENIU:\n"
    print " 1 - Jusu duomenys\n\n"
    print " 2 - Parduotuve\n\n"
    print " 0 - Iseiti\n\n"
    
    print "key: "
    key = readline.chop
    if key == "0"
      return false
    else
      if key == "1"
        user_information
      end
      if key == "2"
        shop
      end
    end
    true
  end
  
  def login
    system("clear")
    print "Iveskite savo el.pasta: "
    email = readline.chop
    user = ActiveRecord.find("User", { "WHERE" => { "email" => email } })
    if user
      @user = user
      return true
    else
      return false
    end
  end
  
  def register
    system("clear")
    user = User.new
    print "REGISTRACIJA\n\n"
    print "Vardas: "
    user.name = readline.chop
    print "Pavarde: "
    user.surname = readline.chop
    print "Amzius: "
    user.age = readline.chop
    print "Lytis (vyr, mot): "
    user.gender =  readline.chop
    print "Adresas: "
    user.adress = readline.chop
    print "El.pastas: "
    user.email = readline.chop
    
    if user.save
      @user = user
      return true
    else
      return false
    end
  end
  
end


system("cler")
print " 1 - prisijungti\n"
print " 2 - registruotis\n\n"

print "key: "
key = readline.chop
if key == "1"
  main = UserInterface.new
  if main.login
    while main.main_menu == true
    end
  else
    print "Toks vartotojas neegzistuoja!\n"
  end
end
if key == "2"
  main = UserInterface.new
  if main.register
    while main.main_menu == true
    end
  else
    print "Klaidingai ivesti duomenys!\n"
  end
end





db = SQLite3::Database.new( "data.db" )

#db.execute("DELETE FROM Artists")
#db.execute("DELETE FROM Albums")
#db.execute("DELETE FROM Songs")
#db.execute("DELETE FROM Users")


#db.execute("CREATE TABLE Albums (
#  id INTEGER PRIMARY KEY,
#  artist_id INTEGER,
#  name TEXT,
#  year INTEGER,
#  genre TEXT)")
#db.execute("CREATE TABLE Artists (
#   id INTEGER PRIMARY KEY,
#   name TEXT)")
#db.execute("CREATE TABLE Users (
#   id INTEGER PRIMARY KEY,
#   name TEXT,
#   surname TEXT,
#   age INTEGER,
#   gender TEXT,
#   adress TEXT,
#   email TEXT)")
  
#db.execute("INSERT INTO Artists (name) VALUES ('Pink Floyd')")
#db.execute("INSERT INTO Artists (name) VALUES ('Led Zeppelin')")

#db.execute("INSERT INTO Albums (artist_id, name, year, genre) VALUES (1, 'The Piper at the Gates of Dawn', 1967, 'rock')")
#db.execute("INSERT INTO Albums (artist_id, name, year, genre) VALUES (1, 'A Saucerful of Secrets', 1968, 'rock')")
#db.execute("INSERT INTO Albums (artist_id, name, year, genre) VALUES (1, 'Soundtrack from the Film More', 1969, 'rock')")
#db.execute("INSERT INTO Albums (artist_id, name, year, genre) VALUES (1, 'Ummagumma', 1969, 'rock')")
#db.execute("INSERT INTO Albums (artist_id, name, year, genre) VALUES (1, 'Atom Heart Mother', 1970, 'rock')")
#db.execute("INSERT INTO Albums (artist_id, name, year, genre) VALUES (1, 'Meddle', 1971, 'rock')")
#db.execute("INSERT INTO Albums (artist_id, name, year, genre) VALUES (1, 'Obscured by Clouds', 1972, 'rock')")
#db.execute("INSERT INTO Albums (artist_id, name, year, genre) VALUES (1, 'The Dark Side of the Moon', 1973, 'rock')")
#db.execute("INSERT INTO Albums (artist_id, name, year, genre) VALUES (1, 'Wish You Were Here', 1975, 'rock')")
#db.execute("INSERT INTO Albums (artist_id, name, year, genre) VALUES (1, 'Animals', 1977, 'rock')")
#db.execute("INSERT INTO Albums (artist_id, name, year, genre) VALUES (1, 'The Wall', 1979, 'rock')")
#db.execute("INSERT INTO Albums (artist_id, name, year, genre) VALUES (1, 'The Final Cut', 1983, 'rock')")
#db.execute("INSERT INTO Albums (artist_id, name, year, genre) VALUES (1, 'A Momentary Lapse of Reason', 1987, 'rock')")
#db.execute("INSERT INTO Albums (artist_id, name, year, genre) VALUES (1, 'Delicate Sound of Thunder', 1988, 'rock')")
#db.execute("INSERT INTO Albums (artist_id, name, year, genre) VALUES (1, 'The Division Bell', 1994, 'rock')")
#db.execute("INSERT INTO Albums (artist_id, name, year, genre) VALUES (1, 'Pulse', 1995, 'rock')")
#db.execute("INSERT INTO Albums (artist_id, name, year, genre) VALUES (1, 'Is There Anybody Out There? The Wall Live 1980–81', 2000, 'rock')")
#db.execute("INSERT INTO Albums (artist_id, name, year, genre) VALUES (2, 'Led Zeppelin', 1969, 'rock')")
#db.execute("INSERT INTO Albums (artist_id, name, year, genre) VALUES (2, 'Led Zeppelin II', 1969, 'rock')")
#db.execute("INSERT INTO Albums (artist_id, name, year, genre) VALUES (2, 'Led Zeppelin III', 1970, 'rock')")
#db.execute("INSERT INTO Albums (artist_id, name, year, genre) VALUES (2, 'Led Zeppelin IV', 1971, 'rock')")
#db.execute("INSERT INTO Albums (artist_id, name, year, genre) VALUES (2, 'Houses of the Holy', 1973, 'rock')")
#db.execute("INSERT INTO Albums (artist_id, name, year, genre) VALUES (2, 'Physical Graffiti', 1975, 'rock')")
#db.execute("INSERT INTO Albums (artist_id, name, year, genre) VALUES (2, 'Presence', 1976, 'rock')")
#db.execute("INSERT INTO Albums (artist_id, name, year, genre) VALUES (2, 'In Through the Out Door', 1979, 'rock')")
#db.execute("INSERT INTO Albums (artist_id, name, year, genre) VALUES (2, 'Coda', 1982, 'rock')")


#db.execute("INSERT INTO Albums (artist_id, name, year, genre) VALUES (1, 'test', 2009, 'jazz')")
