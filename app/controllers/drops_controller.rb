class DropsController < ApplicationController
  
  require 'dropio' 
  ######################
  #Production
  Dropio::Config.api_key = "YOUR_API_KEY"
  Dropio::Config.manager_api_token = "YOUR_MANAGER_TOKEN"
  Dropio::Config.user_output_locations = []
  Dropio::Config.enabled_cdns = ["akamai", "voxel", "limelight"]
  Dropio::Config.version = "3.0"
  
  
  def index
    service = Dropio::Api.new
    @manager_info = service.manager_drops(Dropio::Config.manager_api_token)
    
  end
  
  def new
    if params['id'] 
      service = Dropio::Api.new
      service.create_drop({"name"=>params['id']})
      redirect_to :drops
    end
  end
  
  def show
     @dropname = params['id'] 
     @output_locations = Dropio::Config.output_locations
      drop = Dropio::Drop.find(@dropname)
      @assets = []
      @howmany = drop.asset_count
      @drop = drop
      pages = (drop.asset_count / 30) + 1
      if !drop.blank?
        (pages).times { |i|
          drop.assets(i+1).each do |a|
              @assets << a
          end
        }
      end
  end
  
  def upload
  end
  
end
