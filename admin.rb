require 'rubygems'
require 'sqlite3'

require 'modules/activerecord'

require 'classes/album'
require 'classes/artist'
require 'classes/user'
require 'classes/store'
require 'classes/userhistory'

class AdminInterface
  
  #
  # Funds
  #
  
  def count_funds
    @funds = 0
    histories = ActiveRecord.find_all("UserHistory")
    if histories
      histories.each do |history|
        @funds += Integer(history.price)
      end
    end
  end
  
  def count_wastes
    @wastes = 0
    stores = ActiveRecord.find_all("Store")
    stores.each do |store|
      @wastes += Integer(store.self_price)
    end
  end
  
  def funds_menu
    system "clear"
    count_funds
    count_wastes
    print "BIUDZETAS\n"
    print "  pajamos: #{@funds}Lt\n"
    print "  islaidos: #{@wastes}Lt\n"
    profit = @funds - @wastes
    print "  pelnas: #{profit}Lt\n"
    readline
  end
  
  #
  # Store
  #
  
  def print_all_albums
    albums = ActiveRecord.find_all("Album")
    albums.each do |album|
      store = ActiveRecord.find("Store", {"WHERE"=>{"album_id"=>album.id}})
      artist = ActiveRecord.find("Artist", album.artist_id)
      if store
        print "  #{album.id}. #{album.name}, #{album.year} - #{artist.name} | kaina #{store.price}Lt | savikaina #{store.self_price} | kiekis #{store.amount}vnt.\n"
      else
        print "  #{album.id}. #{album.name}, #{album.year}\n"
      end
    end
  end
  
  def soldout_albums
    system "clear"
    print "ISPARDUOTI ALBUMAI\n"
    stores = ActiveRecord.find_all("Store", {"WHERE"=>{"amount" => 0}})
    if stores
      stores.each do |store|
        album = ActiveRecord.find("Album", store.album_id)
        artist = ActiveRecord.find("Artist", album.artist_id)
        print "  #{album.id}. #{album.name} - #{artist.name} | savikaina: #{store.self_price}Lt\n"
      end
    else
      "  isparduotu nera\n"
    end
    readline
    store_menu
  end
  
  def buy_more_albums
  end
  
  def add_album
    system "clear"
    print "PAPILDYMAS\n"
    print_all_albums
    print "\n  Irasykite albumo ID ir kieki, kiek pirksite\n"
    print "  ID: "
    album_id = readline.chop
    print "  Kiekis: "
    amount = readline.chop
    store = ActiveRecord.find("Store", {"WHERE"=>{"album_id"=>album_id}})
    if store
      store.add_amount amount
      print "  albumu kiekis sekmingai papildytas"
      readline
    else
      print "  klaidingi duomenys"
      readline
    end
    store_menu
  end
  
  def change_album_price
    system "clear"
    print "KEISTI KAINA\n"
    print_all_albums
    print "\n  Iveskite ID albumo: "
    album_id = readline.chop
    store = ActiveRecord.find("Store", {"WHERE"=>{"album_id"=>album_id}})
    if store
      print "  iveskite nauja kaina: "
      new_price = readline.chop
      store.set_new_price new_price
    else
      print "bad\n"
    end
    readline
    store_menu
  end
  
  def most_sold_albums
    system "clear"
    print "LABIAUSIAI PERKAMI ALBUMAI\n"
    albums_hash = {}
      
    albums = ActiveRecord.find_all("Album")
    
    albums.each do |album|
      albums_hash[album.name] = ActiveRecord.count("UserHistory", {"WHERE" => {"album_id" => album.id}})
    end
    
    albums_hash.sort {|a,b| a[1]<=>b[1]}.reverse.each do |album|
      if album[1] > 0
        print "  #{album[0]}: #{album[1]}\n"
      end
    end
    readline
  end
  
  def store_menu
    system "clear"
    print "SANDELIS\n"
    print "  1 - Perziureti albumus\n"
    print "  2 - Papildyti albumu kiekius\n"
    print "  3 - Pirkti naujus albumus (feature)\n"
    print "  4 - Keisti albumo kaina\n"
    print "  5 - Isparduoti albumai\n"
    print "  6 - Labiausiai perkami albumai\n"
    print "\n  key: "
    key = readline.chop
    if key == "1"
      system "clear"
      print_all_albums
      readline
      store_menu
    end
    if key == "2"
      add_album
    end
    if key == "3"
    end
    if key == "4"
      change_album_price
    end
    if key == "5"
      soldout_albums
    end
    if key == "6"
      most_sold_albums
    end
  end
  
  
  #
  # Users
  #
  
  def print_users
    users = ActiveRecord.find_all("User")
    users.each do |user|
      print "  #{user.id}. #{user.name} #{user.surname}\n"
    end    
  end
  
  def client_list
    system "clear"
    print "KLIENTU SARASAS\n"
    print_users
    print "\n  Iveskite kliento ID detalesnei informacijai: "
    user_id = readline.chop
    user = ActiveRecord.find("User", user_id)
    if user
      user_information user
    end
    users_menu
  end
  
  def edit_users
    system "clear"
    print "KLIENTU SARASAS\n"
    print_users
    print "\n  Iveskite kliento ID kuri redaguosite: "
    user_id = readline.chop
    user = ActiveRecord.find("User", user_id)
    if user
      update_user user
    end
    users_menu
  end
  
  def best_users
    system "clear"
    users_hash = {}
    print "PELNINGIAUSI KLIENTAI\n"
    users = ActiveRecord.find_all("User")
    users.each do |user|
      users_hash[user] = user.how_mutch_money_spended
    end
    
    users_hash.sort {|a,b| a[1]<=>b[1]}
    
    users_hash.each do |user_hash|
      print "#{user_hash[0].name} : #{user_hash[1]}\n"
    end
    
    readline
  end
  
  def users_menu
    system "clear"
    print "KIENTAI\n"
    print "  1 - Klientu sarasas\n"
    print "  2 - Redaguoti klientu informacija\n"
    print "  3 - Pelningniausi klientai (feature)\n"

    print "\n  key: "
    key = readline.chop
    if key == "1"
      client_list
    end
    if key == "2"
      edit_users
    end
    if key == "3"
      best_users
    end
  end
  
  def user_information user
    system "clear"
    print "DETALI KLIENTO INFORMACIJA\n"
    print "  Vardas: #{user.name}\n"
    print "  Pavarde: #{user.surname}\n"
    print "  Amzius: #{user.age}\n"
    print "  Lytis: #{user.gender}\n"
    print "  Adresas: #{user.adress}\n"
    print "  El.pastas: #{user.email}\n"   
    print "\n  1 - Redaguoti informacija\n"   
    print "  key: "
    key = readline.chop
    if key == "1"
      update_user user
    end
  end
  
  def update_user user   
    system "clear"
    print "(neivesti laukai islaikys sena reiksme)\n"
    print "  Vardas: "
    name = readline.chop
    print "  Pavarde: "
    surname = readline.chop
    print "  Amzius: "
    age = readline.chop
    print "  Lytis (vyr, mot): "
    gender = readline.chop
    print "  Adresas: "
    adress = readline.chop
    print "  El.pastas: "
    email = readline.chop
    
    if !user.update(name, surname, age, gender, adress, email)
      print "  Klaidingai suvesi duomenys!\n\n"
    end
  end
  
  
  #
  # Main menu
  #
  
  def main_menu
    system "clear"
    print "MENIU\n"
    print "  1 - Biudzetas\n"
    print "  2 - Sandelis\n"
    print "  3 - Klientai\n"
    print "  0 - Iseiti\n"
    
    print "key: "
    key = readline.chop
    if key == "0"
      return false
    else
      if key == "1"
        funds_menu
      end
      if key == "2"
        store_menu
      end
      if key == "3"
        users_menu
      end
    end
    true
  end
  
end

main = AdminInterface.new

while main.main_menu == true
end