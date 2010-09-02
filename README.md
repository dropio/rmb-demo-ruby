Drop.io Rich Media Backbone simple demo application:
=====================================================

This is a small demo application written in Ruby using the Sinatra web framework that shows how to do basic things with the Rich Media Backbone API.


To get up and running:
======================
First you'll need to add your API credentials to the `config.yml` configuration file. `api_key` is mandatory, but you can leave both `api_secret` and `api_token` blank if you're not using a secure key. If you're using a secure key, be sure to uncomment line 12 in `application.rb`.

   If you have bundler installed, you should be able to run `bundle install` from within this project's directory.
This will install all external dependencies for you.

Then simply run `rackup` to start the application with your default web server.