# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_Small-program-on-Ruby_session',
  :secret      => 'f6c4b4e4690fb996d4f9a64adce7f93732df545dc4deb8b572d42b83b502d61e4fd679b2284f454da5c28b89ed3254df2ee733cb133e15bd786860d162c8312e'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
