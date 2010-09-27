RAILS_GEM_VERSION = '2.3.9' unless defined? RAILS_GEM_VERSION

require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.gem 'dropio', :version => '3.0.0.pre7'
  config.time_zone = 'UTC'
end