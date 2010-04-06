# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_clienttest_session',
  :secret      => '3d8079e9ad5bbfafb3c2a3ff44b32f84b0eaf1edebc41b0fe04e7671863aed4e7c5c5ea356573210c3d3960556bbe7a35f9ab847a6737c8964e3d9deaf1ae6ea'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
