# Drop.io Rich Media Backbone Ruby demo application

## Overview

### API Keys

To run this demo application you'll need an RMB API key (and optionally an API secret key). 

Get yours from <http://backbone.drop.io>

### Simple Demo

This is a small application written in Ruby using the Sinatra web framework demonstrating the basic functionality of the Rich Media Backbone API. With it you can create and manage drops as well as upload and manage assets.

**Installation:**

* Edit `config.yml` to include your API key (and optionally your API secret if using a secure key).
* If using a secure key, uncomment line 12 in `application.rb`.
* Run `bundle install` from within this project's directory to install the dependencies.
* Run `rackup` to start the application with your default web server.

### Live Demo

A live version of this demo application might be available for viewing here: <http://rmb-simple-demo.heroku.com/>

