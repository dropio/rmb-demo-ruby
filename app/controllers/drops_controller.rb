class DropsController < ApplicationController
  
  require 'dropio' 
  Dropio::Config.api_key = "348df82fc24bd1eff27084a7b5f876afe61d9d7b"
  Dropio::Config.manager_api_token = "dq7yf4m3qx"
  Dropio::Config.user_output_locations = ["sl_0bb68ad0233c012db8e7fffb204ba9a3"]
  Dropio::Config.enabled_cdns = ["akamai", "voxel", "limelight"]
  
  
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
     @dropname = params['id'] || "splayfist"
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
end
