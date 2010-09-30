require 'rubygems'
require 'sinatra'
require 'dropio'
require 'rack-flash'
require 'digest/sha1'

configure do
  CONFIG = YAML.load_file(File.expand_path(File.dirname(__FILE__) + '/config.yml'))

  Dropio::Config.api_key = CONFIG['api_key']

  # Uncomment to enable Dropio logging
  Dropio::Config.debug = true

  API_KEY = Dropio::Config.api_key

  enable :sessions
  use Rack::Flash, :sweep => true
end

get '/' do
  @drops = Dropio::Drop.find_all
  erb :'drops/index'
end

helpers do
  def show_large_thumbnail(asset)
    if asset.type == "image"
      large_thumbnail = lambda do
        asset.roles.select{ |role| role["name"] == "large_thumbnail" }
      end.call.first['locations']
      begin
        if large_thumbnail.first["status"] == "complete"
          "<img src='#{large_thumbnail.first['file_url']}' />"
        end
      rescue Exception => e
        puts "Caught exception: #{e}"
      end
    end
  end
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

