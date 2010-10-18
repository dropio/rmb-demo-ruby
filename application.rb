require 'rubygems'
require 'sinatra'
require 'rmb'
require 'rack-flash'
require 'digest/sha1'
require 'initializer'
include Initializer

get '/' do
  @drops = Rmb::Drop.find_all
  erb :'drops/index'
end

get '/drops/:name/?' do
  @redirect_url = request.url

  begin
    @drop = Rmb::Drop.find(params[:name])
    @assets = @drop.assets
    erb :'drops/show'
  rescue Rmb::MissingResourceError => e
    flash[:notice] = "#{e}"
    redirect '/'
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

