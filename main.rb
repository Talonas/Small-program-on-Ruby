require 'rubygems'
require 'sqlite3'

require 'modules/activerecord'

require 'classes/album'
require 'classes/artist'
require 'classes/user'
require 'classes/store'
require 'classes/userhistory'

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
    
    print "  1 - Koreguoti duomenis\n"
    print "  key: "
    key = readline.chop
    
    if key == "1"
      update_user_information
    end
    
  end
  
  def update_user_information
    system "clear"
    print "INFORMACIJOS REDAGAVIMAS\n"
    print "(neivesti laukai islaikys sena reiksme)\n"
    print "  Vardas: "
    name = readline.chop
    if !name.empty?
      @user.name = name
    end
    print "  Pavarde: "
    surname = readline.chop
    if !surname.empty?
      @user.surname = surname
    end
    print "  Amzius: "
    age = readline.chop
    if !age.empty?
      @user.age = age
    end
    print "  Lytis (vyr, mot): "
    gender = readline.chop
    if !gender.empty?
      @user.gender = gender
    end
    print "  Adresas: "
    adress = readline.chop
    if !adress.empty?
      @user.adress = adress
    end
    print "  El.pastas: "
    email = readline.chop
    if !email.empty?
      @user.email = email
    end
    
    if !@user.save
      print "  Yra klaidingai suvestu duomenu!\n"
      readline
    else
      print "  Jusu duomenys sekmingai issaugoti!\n"
      readline
    end
  end
  
  def show_user_history
    system "clear"
    print "PIRKINIU ISTORIJA\n"
    histories = ActiveRecord.find_all("UserHistory", {"WHERE" => {"user_id"=>@user.id}})
    if histories
      histories.each do |history|
        album = ActiveRecord.find("Album", history.album_id)
        artist = ActiveRecord.find("Artist", album.artist_id)
        print "  #{artist.name} - '#{album.name}' #{album.year}\n"
      end
      readline
    else
      print "  Jus dar nieko nepirkote\n"
      readline
    end
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
    artists.each { |artist| artist.print_info }
    print "\n  Iveskite atlikejo ID\n"
    print "  key: "
    key = readline.chop
    artist = ActiveRecord.find("Artist", key)
    if artist
      print_artist_albums artist
    else
      print "  Tokio atlikejo nera!\n"
      readline
    end
  end
  
  def print_artist_albums artist
    system "clear"
    print "#{artist.name}\n"
    albums = ActiveRecord.find_all("Album", {"WHERE" => {"artist_id"=>artist.id} })
    albums.each do |album|
      store = ActiveRecord.find("Store", {"WHERE" => {"album_id"=>album.id}})
      if store
        album.print_info store.price, store.amount
      end
    end
    print "\n  Iveskite albumo ID, kuri pirksite: "
    album_id = readline.chop
    album = ActiveRecord.find("Album", album_id)
    if album
      album.sell @user.id
    end
  end
  
  def print_all_albums
    system("clear")
    print "ALBUMAI:\n"
    albums = ActiveRecord.find_all("Album", { "ORDER BY" => "artist_id DESC" })
    albums.each do |album|
      store = ActiveRecord.find("Store", {"WHERE" => {"album_id"=>album.id}})
      if store
        artist = ActiveRecord.find("Artist", album.artist_id)
        album.print_info store.price, store.amount
      end
    end
    print "\n  Iveskite albumo ID, kuri pirksite: "
    album_id = readline.chop
    album = ActiveRecord.find("Album", album_id)
    if album
      album.sell @user.id
    end
  end
  
  def main_menu
    system("clear")
    print "MENIU:\n"
    print " 1 - Jusu duomenys\n"
    print " 2 - Pirkiniu istorija\n\n"
    print " 3 - Parduotuve\n\n"
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
        show_user_history
      end
      if key == "3"
        shop
      end
    end
    true
  end
  
  def login
    system("clear")
    print "PRISIJUNGIMAS\n"
    print "  El.pastas: "
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
    print "REGISTRACIJA\n"
    print "  Vardas: "
    user.name = readline.chop
    print "  Pavarde: "
    user.surname = readline.chop
    print "  Amzius: "
    user.age = readline.chop
    print "  Lytis (vyr, mot): "
    user.gender =  readline.chop
    print "  Adresas: "
    user.adress = readline.chop
    print "  El.pastas: "
    user.email = readline.chop
    
    if user.save
      @user = user
      return true
    else
      return false
    end
  end
  
end


system("clear")
print "PRADINIS PUSLAPIS\n"
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

=begin 
db = SQLite3::Database.new("data.db")

db.execute("DELETE FROM Artists")
db.execute("DELETE FROM Albums")
#db.execute("DELETE FROM Songs")
#db.execute("DELETE FROM Users")
db.execute("DELETE FROM UserHistorys")
db.execute("DELETE FROM Stores")

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
#db.execute("CREATE TABLE UserHistorys (
#   id INTEGER PRIMARY KEY,
#   user_id INTEGER,
#   album_id INTEGER,
#   price INTEGER)")
#db.execute("CREATE TABLE Stores (
#  album_id INTEGER,
#  amount INTEGER,
#  price INTEGER,
#  self_price INTEGER)")

db.execute("INSERT INTO Artists (name) VALUES ('Pink Floyd')")
db.execute("INSERT INTO Artists (name) VALUES ('Led Zeppelin')")

db.execute("INSERT INTO Albums (artist_id, name, year, genre) VALUES (1, 'The Piper at the Gates of Dawn', 1967, 'psychedelic rock')")
db.execute("INSERT INTO Albums (artist_id, name, year, genre) VALUES (1, 'A Saucerful of Secrets', 1968, 'psychedelic rock')")
db.execute("INSERT INTO Albums (artist_id, name, year, genre) VALUES (1, 'Soundtrack from the Film More', 1969, 'psychedelic rock')")
db.execute("INSERT INTO Albums (artist_id, name, year, genre) VALUES (1, 'Ummagumma', 1969, 'psychedelic rock')")
db.execute("INSERT INTO Albums (artist_id, name, year, genre) VALUES (1, 'Atom Heart Mother', 1970, 'psychedelic rock')")
db.execute("INSERT INTO Albums (artist_id, name, year, genre) VALUES (1, 'Meddle', 1971, 'psychedelic rock')")
db.execute("INSERT INTO Albums (artist_id, name, year, genre) VALUES (1, 'Obscured by Clouds', 1972, 'psychedelic rock')")
db.execute("INSERT INTO Albums (artist_id, name, year, genre) VALUES (1, 'The Dark Side of the Moon', 1973, 'progressive rock')")
db.execute("INSERT INTO Albums (artist_id, name, year, genre) VALUES (1, 'Wish You Were Here', 1975, 'progressive rock')")
db.execute("INSERT INTO Albums (artist_id, name, year, genre) VALUES (1, 'Animals', 1977, 'progressive rock')")
db.execute("INSERT INTO Albums (artist_id, name, year, genre) VALUES (1, 'The Wall', 1979, 'progressive rock')")
db.execute("INSERT INTO Albums (artist_id, name, year, genre) VALUES (1, 'The Final Cut', 1983, 'progressive rock')")
db.execute("INSERT INTO Albums (artist_id, name, year, genre) VALUES (1, 'A Momentary Lapse of Reason', 1987, 'progressive rock')")
db.execute("INSERT INTO Albums (artist_id, name, year, genre) VALUES (1, 'Delicate Sound of Thunder', 1988, 'progressive rock')")
db.execute("INSERT INTO Albums (artist_id, name, year, genre) VALUES (1, 'The Division Bell', 1994, 'progressive rock')")
db.execute("INSERT INTO Albums (artist_id, name, year, genre) VALUES (1, 'Pulse', 1995, 'progressive rock')")
db.execute("INSERT INTO Albums (artist_id, name, year, genre) VALUES (1, 'Is There Anybody Out There? The Wall Live 1980–81', 2000, 'progressive rock')")
db.execute("INSERT INTO Albums (artist_id, name, year, genre) VALUES (2, 'Led Zeppelin', 1969, 'hard rock')")
db.execute("INSERT INTO Albums (artist_id, name, year, genre) VALUES (2, 'Led Zeppelin II', 1969, 'hard rock')")
db.execute("INSERT INTO Albums (artist_id, name, year, genre) VALUES (2, 'Led Zeppelin III', 1970, 'hard rock')")
db.execute("INSERT INTO Albums (artist_id, name, year, genre) VALUES (2, 'Led Zeppelin IV', 1971, 'hard rock')")
db.execute("INSERT INTO Albums (artist_id, name, year, genre) VALUES (2, 'Houses of the Holy', 1973, 'hard rock')")
db.execute("INSERT INTO Albums (artist_id, name, year, genre) VALUES (2, 'Physical Graffiti', 1975, 'hard rock')")
db.execute("INSERT INTO Albums (artist_id, name, year, genre) VALUES (2, 'Presence', 1976, 'hard rock')")
db.execute("INSERT INTO Albums (artist_id, name, year, genre) VALUES (2, 'In Through the Out Door', 1979, 'hard rock')")
db.execute("INSERT INTO Albums (artist_id, name, year, genre) VALUES (2, 'Coda', 1982, 'hard rock')")

db.execute("INSERT INTO Stores (album_id, amount, price, self_price) VALUES (1, 2, 20, 10)")
db.execute("INSERT INTO Stores (album_id, amount, price, self_price) VALUES (2, 2, 20, 10)")
db.execute("INSERT INTO Stores (album_id, amount, price, self_price) VALUES (3, 2, 20, 10)")
db.execute("INSERT INTO Stores (album_id, amount, price, self_price) VALUES (4, 2, 20, 10)")
db.execute("INSERT INTO Stores (album_id, amount, price, self_price) VALUES (5, 2, 20, 10)")
db.execute("INSERT INTO Stores (album_id, amount, price, self_price) VALUES (6, 0, 20, 10)")
db.execute("INSERT INTO Stores (album_id, amount, price, self_price) VALUES (7, 0, 20, 10)")
db.execute("INSERT INTO Stores (album_id, amount, price, self_price) VALUES (8, 0, 20, 10)")
db.execute("INSERT INTO Stores (album_id, amount, price, self_price) VALUES (9, 0, 20, 10)")
db.execute("INSERT INTO Stores (album_id, amount, price, self_price) VALUES (10, 0, 20, 10)")
db.execute("INSERT INTO Stores (album_id, amount, price, self_price) VALUES (11, 0, 20, 10)")
db.execute("INSERT INTO Stores (album_id, amount, price, self_price) VALUES (12, 0, 20, 10)")
db.execute("INSERT INTO Stores (album_id, amount, price, self_price) VALUES (13, 0, 20, 10)")
db.execute("INSERT INTO Stores (album_id, amount, price, self_price) VALUES (14, 0, 20, 10)")
db.execute("INSERT INTO Stores (album_id, amount, price, self_price) VALUES (15, 2, 20, 10)")
db.execute("INSERT INTO Stores (album_id, amount, price, self_price) VALUES (16, 2, 20, 10)")
db.execute("INSERT INTO Stores (album_id, amount, price, self_price) VALUES (17, 0, 20, 10)")
db.execute("INSERT INTO Stores (album_id, amount, price, self_price) VALUES (18, 2, 20, 10)")
db.execute("INSERT INTO Stores (album_id, amount, price, self_price) VALUES (19, 2, 20, 10)")
db.execute("INSERT INTO Stores (album_id, amount, price, self_price) VALUES (20, 0, 20, 10)")
db.execute("INSERT INTO Stores (album_id, amount, price, self_price) VALUES (21, 2, 20, 10)")
db.execute("INSERT INTO Stores (album_id, amount, price, self_price) VALUES (22, 2, 20, 10)")
db.execute("INSERT INTO Stores (album_id, amount, price, self_price) VALUES (23, 2, 20, 10)")
db.execute("INSERT INTO Stores (album_id, amount, price, self_price) VALUES (24, 2, 20, 10)")
db.execute("INSERT INTO Stores (album_id, amount, price, self_price) VALUES (25, 2, 20, 10)")
db.execute("INSERT INTO Stores (album_id, amount, price, self_price) VALUES (26, 2, 20, 10)")
=end
