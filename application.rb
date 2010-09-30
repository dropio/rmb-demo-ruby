require 'rubygems'
require 'sinatra'
require 'dropio'
require 'rack-flash'
require 'digest/sha1'

configure do
  CONFIG = YAML.load_file(File.expand_path(File.dirname(__FILE__) + '/config.yml'))

  Dropio::Config.api_key = CONFIG['api_key']

  # Only needed for secure keys
  # Dropio::Config.api_secret = CONFIG['api_secret']

  # Uncomment to enable Dropio logging
  Dropio::Config.debug = true

  API_KEY = Dropio::Config.api_key
  API_SECRET = Dropio::Config.api_secret
  API_TOKEN = CONFIG['api_token']

  enable :sessions
  use Rack::Flash, :sweep => true
end

get '/' do
  @drops = Dropio::Drop.find_all
  erb :'drops/index'
end

get '/drops/:name/?' do
  @redirect_url = request.url
  begin
    @drop = Dropio::Drop.find(params[:name])
    @assets = @drop.assets
    erb :'drops/show'
  rescue Dropio::MissingResourceError => e
    "#{e}"
  end
end

get '/drops/:name/delete/?' do
  @drop = Dropio::Drop.find(params[:name])
  @drop.destroy!
  flash[:notice] = "Drop was successfully deleted."
  redirect '/'
end

post '/drops/create' do
  @dropname = params[:dropname]
  @drop = Dropio::Drop.create({:name => @dropname})
  flash[:notice] = "Drop was successfully created."
  redirect '/'
end

get '/drops/:drop/assets/:asset/delete/?' do
  @drop = Dropio::Drop.find(params[:drop])
  @asset = Dropio::Asset.find(@drop, params[:asset])
  @asset.destroy!
  flash[:notice] = "Asset was sucessfully deleted."
  redirect "/drops/#{params[:drop]}"
end

