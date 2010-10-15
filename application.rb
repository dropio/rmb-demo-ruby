require 'rubygems'
require 'sinatra'
require 'rmb'
require 'rack-flash'
require 'digest/sha1'

configure do
  CONFIG = YAML.load_file(File.expand_path(File.dirname(__FILE__) + '/config.yml'))

  Rmb::Config.api_key = CONFIG['api_key']

  # Uncomment to enable Rmb logging
  Rmb::Config.debug = true

  API_KEY = Rmb::Config.api_key

  enable :sessions
  use Rack::Flash, :sweep => true
end

get '/' do
  @drops = Rmb::Drop.find_all
  erb :'drops/index'
end

helpers do
  def show_large_thumbnail(asset)
    begin
      if asset.type == "image"
        large_thumbnail = lambda do
          asset.roles.select{ |role| role["name"] == "large_thumbnail" }
        end.call.first['locations']
        if large_thumbnail.first["status"] == "complete"
          "<img src='#{large_thumbnail.first['file_url']}' />"
        end
      end
    rescue Exception => e
      puts "Caught exception: #{e}"
    end
  end
end

get '/drops/:name/?' do
  @redirect_url = request.url

  begin
    @drop = Rmb::Drop.find(params[:name])
    @assets = @drop.assets
    erb :'drops/show'
  rescue Rmb::MissingResourceError => e
    "#{e}"
  end
end

get '/drops/:name/delete/?' do
  @drop = Rmb::Drop.find(params[:name])
  @drop.destroy!
  flash[:notice] = "Drop was successfully deleted."
  redirect '/'
end

post '/drops/create' do
  @dropname = params[:dropname]
  @drop = Rmb::Drop.create({:name => @dropname})
  flash[:notice] = "Drop was successfully created."
  redirect '/'
end

get '/drops/:drop/assets/:asset/delete/?' do
  @drop = Rmb::Drop.find(params[:drop])
  @asset = Rmb::Asset.find(@drop, params[:asset])
  @asset.destroy!
  flash[:notice] = "Asset was sucessfully deleted."
  redirect "/drops/#{params[:drop]}"
end

